Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCCC542AB9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbiFHJHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbiFHJE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:04:29 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B54026271A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 01:24:21 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id m25so18575485lji.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 01:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qn1e9UAfXz5aNABeJOAzysJEyHPbsjfCU7HdITnS84k=;
        b=Zf/rY8UPfUil7LCo0AmPL0ktcOejRjNbVkLs6BfbQEG0tklgICY+14UzNT7D2l+FDP
         kd/C58CeMvLCk8v3OokScSeoWleedGL2pCuZ4fpDA/Jq1KQDZNs4yJvNeRq2uK5ohQfv
         x4JYv71VyLAWcCv/E2Q2Aj30ajf43xjO6xVU0l7ZmWZuCFV8Mab02uK+G5KxWVWLxWab
         pz3zN5y+pykDMGv075WbOy8vrLxMM7b81TO1CCsC2Cjxlj6PBZkA0QWRSCsNtnZJpAjf
         OGONEqGxWA91wAD7DPtau1HbAdjZEXl/4fttRzwneXCGvy6jRrNp4vyt+nqKNTR9wue/
         xJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qn1e9UAfXz5aNABeJOAzysJEyHPbsjfCU7HdITnS84k=;
        b=EGf9uiZoAyvU+THNsv5ImFQgxFAtTv7l8GDzVFWjL5lOMQmIb/grBDihPDTKjVuoru
         tT0HR83aEsSmDuLeUu0YREttw9zchXB6sQrjkheM9FClkQcWMpFsV8A8ZwtrTtSpTNp6
         /fu0JZ4rU6L28Zm6hQE+BnChQqgOfunyxKMofpxvUKjHoeJW/J+1x9YvHDeZyEC1KoIW
         oLcbTmart/lz0JFApVb8f4JZC6nGKpOBxDAVLWgg2wLUAGYtLGC4OYrnO4kHgNvz3Wxe
         kYXYuCxY8O3qLPeI/rN1c25NO1hzX1u3ihvauvpC+ChJYo8u0oLdMgqhlwAFbX5VbuUg
         WXWA==
X-Gm-Message-State: AOAM530+F8Iyoqr8812+tE+elqHBfMBTlT8nu7qG8SbTfQYDC1yt7alV
        I1cN6ICHQOOih2fPjp8WXJnaaL/TsJ2UqCwvynO2QA==
X-Google-Smtp-Source: ABdhPJwud0+3E/Q29u9oy+kzSCNdY14guBqBmA0Hqpt4c+PmhIEHReOxdmFrIBDqbHdvMdQZbHcRxllXIDLHtj3hagQ=
X-Received: by 2002:a2e:bf14:0:b0:255:b789:576b with SMTP id
 c20-20020a2ebf14000000b00255b789576bmr3093006ljr.47.1654676659002; Wed, 08
 Jun 2022 01:24:19 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000bb7f1c05da29b601@google.com> <00000000000010b7d305e08837c8@google.com>
 <YpnqpMYcokTwCB6u@smile.fi.intel.com> <Ypor265BTdnmgwpM@rowland.harvard.edu>
 <YpouRmanvCQeKA3S@kroah.com> <Ypow1LRZ3Hau36ci@rowland.harvard.edu>
 <Ypoyy/stICFdHauR@kroah.com> <CACT4Y+bBWrLRwiowaWk8o4+XAtCHxxJiEQfiSkgM3BDut9atAw@mail.gmail.com>
 <20220606123839.GW2146@kadam> <CACT4Y+Y_kg1J00iBL=sMr5AP7U4RXuBizusvQG52few2NcJ6dg@mail.gmail.com>
 <YqAWpMdi4o1IQslu@casper.infradead.org> <CACT4Y+anOkc=-A5=3EBrvmu+AJ+f7CcrOfWp85hEu+CHkS3BGw@mail.gmail.com>
In-Reply-To: <CACT4Y+anOkc=-A5=3EBrvmu+AJ+f7CcrOfWp85hEu+CHkS3BGw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 8 Jun 2022 10:24:07 +0200
Message-ID: <CACT4Y+YM8__WOVAQcpNBNxneHCp5dv2tF7ySDpivRJ-efGNCUQ@mail.gmail.com>
Subject: Re: [syzbot] general protection fault in __device_attach
To:     Matthew Wilcox <willy@infradead.org>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jun 2022 at 10:20, Dmitry Vyukov <dvyukov@google.com> wrote:
> > On Tue, Jun 07, 2022 at 09:15:09AM +0200, Dmitry Vyukov wrote:
> > > On Mon, 6 Jun 2022 at 14:39, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > > >
> > > > On Sat, Jun 04, 2022 at 10:32:46AM +0200, 'Dmitry Vyukov' via syzkaller-bugs wrote:
> > > > > On Fri, 3 Jun 2022 at 18:12, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > > > > But again, is this a "real and able to be triggered from userspace"
> > > > > > problem, or just fault-injection-induced?
> > > > >
> > > > > Then this is something to fix in the fault injection subsystem.
> > > > > Testing systems shouldn't be reporting false positives.
> > > > > What allocations cannot fail in real life? Is it <=page_size?
> > > > >
> > > >
> > > > Apparently in 2014, anything less than *EIGHT?!!* pages succeeded!
> > > >
> > > > https://lwn.net/Articles/627419/
> > > >
> > > > I have been on the look out since that article and never seen anyone
> > > > mention it changing.  I think we should ignore that and say that
> > > > anything over PAGE_SIZE can fail.  Possibly we could go smaller than
> > > > PAGE_SIZE...
> > >
> > > +linux-mm for GFP expertise re what allocations cannot possibly fail
> > > and should be excluded from fault injection.
> > >
> > > Interesting, thanks for the link.
> > >
> > > PAGE_SIZE looks like a good start. Once we have the predicate in
> > > place, we can refine it later when/if we have more inputs.
> > >
> > > But I wonder about GFP flags. They definitely have some impact on allocations.
> > > If GFP_ACCOUNT is set, all allocations can fail, right?
> > > If GFP_DMA/DMA32 is set, allocations can fail, right? What about other zones?
> > > If GFP_NORETRY is set, allocations can fail?
> > > What about GFP_NOMEMALLOC and GFP_ATOMIC?
> > > What about GFP_IO/GFP_FS/GFP_DIRECT_RECLAIM/GFP_KSWAPD_RECLAIM? At
> > > least some of these need to be set for allocations to not fail? Which
> > > ones?
> > > Any other flags are required to be set/unset for allocations to not fail?
> >
> > I'm not the expert on page allocation, but ...
> >
> > I don't think GFP_ACCOUNT makes allocations fail.  It might make reclaim
> > happen from within that cgroup, and it might cause an OOM kill for
> > something in that cgroup.  But I don't think it makes a (low order)
> > allocation more likely to fail.
>
> Interesting.
> I was thinking of some malicious specifically crafted configurations
> with very low limit and particular pattern of allocations. Also what
> if there is just 1 process (current)? Is it possible to kill and
> reclaim the current process when a thread is stuck in the middle of
> the kernel on a kmalloc?
> Also I see e.g.:
>         Tasks with the OOM protection (oom_score_adj set to -1000)
>         are treated as an exception and are never killed.
>
> I am not an expert on this either, but I think it may be hard to fight
> with a specifically crafted attack.
>
>
> > There's usually less memory avilable in DMA/DMA32 zones, but we have
> > so few allocations from those zones, I question the utility of focusing
> > testing on those allocations.
> >
> > GFP_ATOMIC allows access to emergency pools, so I would say _less_ likely
> > to fail.  KSWAPD_RECLAIM has no effect on whether _this_ allocation
> > succeeds or fails; it kicks kswapd to do reclaim, rather than doing
> > reclaim directly.  DIRECT_RECLAIM definitely makes allocations more likely
> > to succeed.  GFP_FS allows (direct) reclaim to happen from filesystems.
> > GFP_IO allows IO to start (ie writeback can start) in order to clean
> > dirty memory.
> >
> > Anyway, I hope somebody who knows the page allocator better than I do
> > can say smarter things than this.  Even better if they can put it into
> > Documentation/ somewhere ;-)
>
> Even better to put this into code as a predicate function that fault
> injection will use. It will also serve as precise up-to-date
> documentation.

Also at the end of kmalloc as:
WARN_ON(!ret && !cant_fail(size, gfp));
!

> > https://www.kernel.org/doc/html/latest/core-api/memory-allocation.html
> > exists but isn't quite enough to answer this question.
