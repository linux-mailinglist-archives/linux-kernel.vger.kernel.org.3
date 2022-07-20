Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5E757AF6B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 05:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238823AbiGTDRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 23:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234732AbiGTDRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 23:17:25 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D1023BD9;
        Tue, 19 Jul 2022 20:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pPIVLIwZGOIJjDt3jJyC3v27AiTio1D7WqhVh4qBdn8=; b=OKoYzCknWtA1aSXAPwUp2xMcK/
        BeosNKR3tov2F5zpWiYheo9s29aZ/fCG/5dYQzPpL+aIDgTXbk0BkIe/vW5oIVcFJI1zM7oYfHK6g
        kfCHxzlVy+Q5bmixLpiJxaSzVGOA7Xd9PUq5teTZh/R/ey9o74YCSoMeOftqn/KPm8N4Ojmc2nmYv
        a0ttCasHsepCDrb8IKxi0XoF3Rg8dFqCOocXVLV95mNAVYN6um8x0oXVu3cMF/vaEdvlNxKHI+yC/
        mPHAV1+JDsCRedF3XcEEa3YrRYVtGB1GytAKwf6RBisrImqLEpJfBc11eF4LHiBmS+nCPcy25U+Dx
        qQEGnXmw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oE0DA-00Dy6f-AN;
        Wed, 20 Jul 2022 03:17:20 +0000
Date:   Wed, 20 Jul 2022 04:17:20 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v4 0/4] s390/crash: support multi-segment iterators
Message-ID: <YtdzwLXFMuv02JEA@ZenIV>
References: <cover.1658206891.git.agordeev@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1658206891.git.agordeev@linux.ibm.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 07:16:32AM +0200, Alexander Gordeev wrote:
> Hi Matthew et al,
> 
> This series completes 5d8de293c224 ("vmcore: convert copy_oldmem_page()
> to take an iov_iter") for s390.
> 
> Changes since v3:
>   - concurrent access to HSA and oldmem swap buffers protected;
> 
> Changes since v2:
>   - Matthew Wilcox suggestion is adopted, with that...
>   - copy_to_iter() is used instead of custom implementation;
> 
> Changes since v1:
>   - number of bytes left to copy on fail fixed;

OK...  Do you prefer it to go through s390 tree?  The thing is, I've
stuff in iov_iter tree that conflicts with it; I'll gladly drop that
bit (vfs.git #fixes-s390) in favour of your series (and drop s390
bits from "new iov_iter flavour - ITER_UBUF" in #work.iov_iter - they
are not needed anymore).

I can put your series into replacement of #fixes-s390, or pull it
from whatever static branch you put it into - up to you.
Preferences?
