Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE9658E481
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 03:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbiHJBan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 21:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiHJBaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 21:30:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D52C1D1
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 18:30:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32AE2B81A03
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 01:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D54C433D6;
        Wed, 10 Aug 2022 01:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1660095013;
        bh=h1Xe4kLj1fZVvhCfG/JILBgStIWuw0hoaqbRBEzMgYg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SAXDGcalYV4NL1NfK1zPnZDJI1TJTB5rtxKYu8NosaTL2DGD3C+Qw+3pzUxHmtOrU
         tb7l4QpOMDGve/O/fsSj38HuX8YENl3kWAeaEvchuGx0TrmDQxgig82SdeRuDdT1J1
         ORVrgY/uJ10ezYCWeYjf1zc3HlPrpLhP5KAt8Lkk=
Date:   Tue, 9 Aug 2022 18:30:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Carlos Llamas <cmllamas@google.com>
Cc:     Liam Howlett <liam.howlett@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+a7b60a176ec13cafb793@syzkaller.appspotmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hridya Valsaraju <hridya@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Todd Kjos <tkjos@android.com>,
        Matthew Wilcox <willy@infradead.org>,
        Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH] binder_alloc: Add missing mmap_lock calls when using
 the VMA
Message-Id: <20220809183012.ac2d52eb91eba55a12d3214a@linux-foundation.org>
In-Reply-To: <YvLLQ/qasEJffdnn@google.com>
References: <20220809160618.1052539-1-Liam.Howlett@oracle.com>
        <YvKsI5pMbgQ5Irup@google.com>
        <20220809190211.ew4taam2lcomramw@revolver>
        <YvLLQ/qasEJffdnn@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Aug 2022 21:01:55 +0000 Carlos Llamas <cmllamas@google.com> wrote:

> On Tue, Aug 09, 2022 at 07:02:17PM +0000, Liam Howlett wrote:
> > > 
> > > do we need to hold on to the lock while we loop through the pages here?
> > 
> > I think we do?  Holding this lock will ensure the pages don't go away, I
> > believe (looking at mm/rmap.c comments on locking at the top)?
> > 
> > In any case, this function is called from print_binder_proc_stats()
> > which looks to be a debugfs/debugging call so I thought safer would be
> > better than faster and with a potential race.
> 
> The pages are protected by alloc->mutex, so you could immediately
> release the mmap lock after binder_alloc_get_vma() call. I agree this
> is a debugging call so it would be nice to reduce contention.

I'll queue this patch for testing, shall update it if there's a v2.
