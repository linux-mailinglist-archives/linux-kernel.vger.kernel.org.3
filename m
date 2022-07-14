Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C295752BA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239007AbiGNQ1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiGNQ1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:27:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AD561B3C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=88JOhkNUSoMMoClhidAsgxns/gETlUPh9cr1gTnulbI=; b=e+BbfDQ//3J55jajPromAgti6W
        BqlxJFKeEV+8i1sjNKbt1rfI8OSpFIvgkcAjaBD53rFXshCzwZSIvneSxfrgJo1FhFIl5EnHhsExc
        eAxXfcrbqXBFDz6PE/5X0zY9iNfMT8OtrH/RlgQji1uWIn0pM/LhzOj53WW4oURiWfxTWUHnUiQzn
        jPa5x0EWTxjTgpIX98+ga8xHPn+A6vTvybHjyGISeCXEADrnAxJtYlq2ecrLX9X9Y4d9jk0rSsHWy
        xZ1AyhX6nbOxQ3+jGHPAz92qnxBSe++LpyVqZ7R8UBcEG/tONUVP2YgBlBazUKGPWPL4UFP2p24OS
        9OUB0Mgw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oC1gW-009VsB-Si; Thu, 14 Jul 2022 16:27:28 +0000
Date:   Thu, 14 Jul 2022 17:27:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+a785d07959bc94837d51@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, Zach O'Keefe <zokeefe@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: Re: [syzbot] memory leak in xas_create
Message-ID: <YtBD8L4yIjKtIfw9@casper.infradead.org>
References: <000000000000eb2d6c05e35a0d73@google.com>
 <20220711133808.d86400ce9960febcb0fd537b@linux-foundation.org>
 <YsyMQ2jzOICVbCda@casper.infradead.org>
 <CACT4Y+bL3aM-cVeYSLU7az1x2Yj1vH7GaQSq=Z-BGc5Vk1Vi4w@mail.gmail.com>
 <Ys1r06szkVi3QEai@casper.infradead.org>
 <CACT4Y+Z44fS04StzMh+sfUWo-k5sjYf3VGhhK2ppkHP=9RZQEw@mail.gmail.com>
 <Ys1v1548IkSJ45F/@casper.infradead.org>
 <CACT4Y+a=N3Q6f4dDcmONZYBHMgkO3MpbqoYDupo_N1tKJ=14Rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+a=N3Q6f4dDcmONZYBHMgkO3MpbqoYDupo_N1tKJ=14Rg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 03:29:29PM +0200, Dmitry Vyukov wrote:
> Then I think it's still possible that this is a KMEMLEAK false
> positive. IIRC it may have some false positives since it does not do
> full stop-the-world before scanning memory/registers. syzkaller tries
> to circumvent this by doing multiple scans with some delays, but it
> does not give 100% guarantee.
> And I am assuming this code does not try to hide pointers by storing
> something in low/high bits, etc.

Oh, I meant to answer this.  The XArray does set bit 1 of the pointer
when it's stored in the tree.  However, this shouldn't affect kmemleak
(I would think) because it looks like a pointer to the third byte of the
allocation, so the allocation is still referenced, even if the first
byte of the allocation isn't referenced.

Also, I would expect kmemleak to report bugs all over if this were the
problem, because every node no matter how it's allocated gets its bit 1
set.
