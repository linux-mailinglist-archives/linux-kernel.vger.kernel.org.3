Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309C95427C1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240664AbiFHHMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235703AbiFHFtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 01:49:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BDF1567C2;
        Tue,  7 Jun 2022 20:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rb8PtiqYu5cbp4L1/wbvkrZWp96775LgK31d20avxd0=; b=XDQVraJG6VNU51qlL2Cm9Ls3AW
        QwUxqU1rbHT7aux/Hf7mU8uBRW+nAvn/g434eK7KcdQvxHq1XqCkXN45g0Jy0uDMpBxtcUzRZ8JYb
        L9o9w1mjqa/kbQBQism8A7rfvU4zaxYSQVB0bLTNhZo2xNHD4NxtmLg/wNo766JpC75Lj2PXd/HJ1
        Yu1kWx7yGd6y/F7zAVvZ2sfYrAhImlz+3cG82JXuajyGx23L1xPDzBWasTjfmgUnEycNQIzdZBJ6L
        LRFZoUyM5iBpbcBtzAwxgjseaIER0sY7FETYccxpTBBLQskNFCTPh9rXB6RUZ+1y5o1C8fbDFcPcN
        qQbhKTUg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nymJw-00CH9N-Dj; Wed, 08 Jun 2022 03:25:24 +0000
Date:   Wed, 8 Jun 2022 04:25:24 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        syzbot <syzbot+dd3c97de244683533381@syzkaller.appspotmail.com>,
        hdanton@sina.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
        rafael@kernel.org, rjw@rjwysocki.net,
        syzkaller-bugs@googlegroups.com, linux-usb@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [syzbot] general protection fault in __device_attach
Message-ID: <YqAWpMdi4o1IQslu@casper.infradead.org>
References: <000000000000bb7f1c05da29b601@google.com>
 <00000000000010b7d305e08837c8@google.com>
 <YpnqpMYcokTwCB6u@smile.fi.intel.com>
 <Ypor265BTdnmgwpM@rowland.harvard.edu>
 <YpouRmanvCQeKA3S@kroah.com>
 <Ypow1LRZ3Hau36ci@rowland.harvard.edu>
 <Ypoyy/stICFdHauR@kroah.com>
 <CACT4Y+bBWrLRwiowaWk8o4+XAtCHxxJiEQfiSkgM3BDut9atAw@mail.gmail.com>
 <20220606123839.GW2146@kadam>
 <CACT4Y+Y_kg1J00iBL=sMr5AP7U4RXuBizusvQG52few2NcJ6dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Y_kg1J00iBL=sMr5AP7U4RXuBizusvQG52few2NcJ6dg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 09:15:09AM +0200, Dmitry Vyukov wrote:
> On Mon, 6 Jun 2022 at 14:39, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > On Sat, Jun 04, 2022 at 10:32:46AM +0200, 'Dmitry Vyukov' via syzkaller-bugs wrote:
> > > On Fri, 3 Jun 2022 at 18:12, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > But again, is this a "real and able to be triggered from userspace"
> > > > problem, or just fault-injection-induced?
> > >
> > > Then this is something to fix in the fault injection subsystem.
> > > Testing systems shouldn't be reporting false positives.
> > > What allocations cannot fail in real life? Is it <=page_size?
> > >
> >
> > Apparently in 2014, anything less than *EIGHT?!!* pages succeeded!
> >
> > https://lwn.net/Articles/627419/
> >
> > I have been on the look out since that article and never seen anyone
> > mention it changing.  I think we should ignore that and say that
> > anything over PAGE_SIZE can fail.  Possibly we could go smaller than
> > PAGE_SIZE...
> 
> +linux-mm for GFP expertise re what allocations cannot possibly fail
> and should be excluded from fault injection.
> 
> Interesting, thanks for the link.
> 
> PAGE_SIZE looks like a good start. Once we have the predicate in
> place, we can refine it later when/if we have more inputs.
> 
> But I wonder about GFP flags. They definitely have some impact on allocations.
> If GFP_ACCOUNT is set, all allocations can fail, right?
> If GFP_DMA/DMA32 is set, allocations can fail, right? What about other zones?
> If GFP_NORETRY is set, allocations can fail?
> What about GFP_NOMEMALLOC and GFP_ATOMIC?
> What about GFP_IO/GFP_FS/GFP_DIRECT_RECLAIM/GFP_KSWAPD_RECLAIM? At
> least some of these need to be set for allocations to not fail? Which
> ones?
> Any other flags are required to be set/unset for allocations to not fail?

I'm not the expert on page allocation, but ...

I don't think GFP_ACCOUNT makes allocations fail.  It might make reclaim
happen from within that cgroup, and it might cause an OOM kill for
something in that cgroup.  But I don't think it makes a (low order)
allocation more likely to fail.

There's usually less memory avilable in DMA/DMA32 zones, but we have
so few allocations from those zones, I question the utility of focusing
testing on those allocations.

GFP_ATOMIC allows access to emergency pools, so I would say _less_ likely
to fail.  KSWAPD_RECLAIM has no effect on whether _this_ allocation
succeeds or fails; it kicks kswapd to do reclaim, rather than doing
reclaim directly.  DIRECT_RECLAIM definitely makes allocations more likely
to succeed.  GFP_FS allows (direct) reclaim to happen from filesystems.
GFP_IO allows IO to start (ie writeback can start) in order to clean
dirty memory.

Anyway, I hope somebody who knows the page allocator better than I do
can say smarter things than this.  Even better if they can put it into
Documentation/ somewhere ;-)

https://www.kernel.org/doc/html/latest/core-api/memory-allocation.html
exists but isn't quite enough to answer this question.
