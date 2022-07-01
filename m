Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434EA563384
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 14:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbiGAMgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 08:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiGAMgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 08:36:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6BD369D5
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 05:36:20 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 39ACB1FEF7;
        Fri,  1 Jul 2022 12:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656678979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hik5kQpAU7ySnk73AYd3MtOF4Oi3e+hPwcdOndB21e0=;
        b=ReWvEEV7AD5hdFc7vdb8yWAQVbtn19wNrYakeGKb3TQrkzQLrj1Ayb9BRIxoypyYBZ9pxc
        xdIj5qY5D0mYhVFkmrhVuZgejY18APEC9TTOSqfYcI2AVs7xq/+SYcuSyP/tLxCxunl2oZ
        8Z/Ruf0aOi7mXBrqhXfkIkHFikio0Fc=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BF8602C142;
        Fri,  1 Jul 2022 12:36:18 +0000 (UTC)
Date:   Fri, 1 Jul 2022 14:36:18 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     cgel.zte@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, vbabka@suse.cz, minchan@kernel.org,
        oleksandr@redhat.com, xu xin <xu.xin16@zte.com.cn>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH linux-next] mm/madvise: allow KSM hints for
 process_madvise
Message-ID: <Yr7qQsWQGb0dhkxr@dhcp22.suse.cz>
References: <20220701084323.1261361-1-xu.xin16@zte.com.cn>
 <Yr66Uhcv+XAPYPwj@dhcp22.suse.cz>
 <93e1e19a-deff-2dad-0b3c-ef411309ec58@redhat.com>
 <c9de1c34-2a39-e4a2-c9b0-9790c5ffab13@redhat.com>
 <Yr7h/E/6A+tsjU9r@dhcp22.suse.cz>
 <203548a6-cf70-30ce-6756-f6c909e7ef21@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <203548a6-cf70-30ce-6756-f6c909e7ef21@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 01-07-22 14:09:24, David Hildenbrand wrote:
> On 01.07.22 14:02, Michal Hocko wrote:
> > On Fri 01-07-22 12:50:59, David Hildenbrand wrote:
> >> On 01.07.22 12:32, David Hildenbrand wrote:
> >>> On 01.07.22 11:11, Michal Hocko wrote:
> >>>> [Cc Jann]
> >>>>
> >>>> On Fri 01-07-22 08:43:23, cgel.zte@gmail.com wrote:
> >>>>> From: xu xin <xu.xin16@zte.com.cn>
> >>>>>
> >>>>> The benefits of doing this are obvious because using madvise in user code
> >>>>> is the only current way to enable KSM, which is inconvenient for those
> >>>>> compiled app without marking MERGEABLE wanting to enable KSM.
> >>>>
> >>>> I would rephrase:
> >>>> "
> >>>> KSM functionality is currently available only to processes which are
> >>>> using MADV_MERGEABLE directly. This is limiting because there are
> >>>> usecases which will benefit from enabling KSM on a remote process. One
> >>>> example would be an application which cannot be modified (e.g. because
> >>>> it is only distributed as a binary). MORE EXAMPLES WOULD BE REALLY
> >>>> BENEFICIAL.
> >>>> "
> >>>>
> >>>>> Since we already have the syscall of process_madvise(), then reusing the
> >>>>> interface to allow external KSM hints is more acceptable [1].
> >>>>>
> >>>>> Although this patch was released by Oleksandr Natalenko, but it was
> >>>>> unfortunately terminated without any conclusions because there was debate
> >>>>> on whether it should use signal_pending() to check the target task besides
> >>>>> the task of current() when calling unmerge_ksm_pages of other task [2].
> >>>>
> >>>> I am not sure this is particularly interesting. I do not remember
> >>>> details of that discussion but checking signal_pending on a different
> >>>> task is rarely the right thing to do. In this case the check is meant to
> >>>> allow bailing out from the operation so that the caller could be
> >>>> terminated for example.
> >>>>
> >>>>> I think it's unneeded to check the target task. For example, when we set
> >>>>> the klob /sys/kernel/mm/ksm/run from 1 to 2,
> >>>>> unmerge_and_remove_all_rmap_items() doesn't use signal_pending() to check
> >>>>> all other target tasks either.
> >>>>>
> >>>>> I hope this patch can get attention again.
> >>>>
> >>>> One thing that the changelog is missing and it is quite important IMHO
> >>>> is the permission model. As we have discussed in previous incarnations
> >>>> of the remote KSM functionality that KSM has some security implications.
> >>>> It would be really great to refer to that in the changelog for the
> >>>> future reference (http://lkml.kernel.org/r/CAG48ez0riS60zcA9CC9rUDV=kLS0326Rr23OKv1_RHaTkOOj7A@mail.gmail.com)
> >>>>
> >>>> So this implementation requires PTRACE_MODE_READ_FSCREDS and
> >>>> CAP_SYS_NICE so the remote process would need to be allowed to
> >>>> introspect the address space. This is the same constrain applied to the
> >>>> remote momory reclaim. Is this sufficient?
> >>>>
> >>>> I would say yes because to some degree KSM mergning can have very
> >>>> similar effect to memory reclaim from the side channel POV. But it
> >>>> should be really documented in the changelog so that it is clear that
> >>>> this has been a deliberate decision and thought through.
> >>>>
> >>>> Other than that this looks like the most reasonable approach to me.
> >>>>
> >>>>> [1] https://lore.kernel.org/lkml/YoOrdh85+AqJH8w1@dhcp22.suse.cz/
> >>>>> [2] https://lore.kernel.org/lkml/2a66abd8-4103-f11b-06d1-07762667eee6@suse.cz/
> >>>>>
> >>>
> >>> I have various concerns, but the biggest concern is that this modifies
> >>> VMA flags and can possibly break applications.
> >>>
> >>> process_madvise must not modify remote process state.
> >>>
> >>> That's why we only allow a very limited selection that are merely hints.
> >>>
> >>> So nack from my side.
> >>>
> >>
> >> [I'm quit ebusy, but I think some more explanation might be of value]
> >>
> >> One COW example where I think force-enabling KSM for processes is
> >> *currently* not a good idea (besides the side channel discussions, which
> >> is also why Windows stopped to enable KSM system wide a while ago):
> >>
> >> App:
> >>
> >> a) memset(page, 0);
> >> b) trigger R/O long-term pin on page (e.g., vfio)
> >>
> >> If between a) and b) KSM replaces the page by the shared zeropage you'll
> >> get an unreliable pin because we don't break yet COW when taking a R/O
> >> pin on the shared zeropage. And in the traditional sense, the app did
> >> everything right to guarantee that the pin will stay reliable.
> > 
> > Isn't this a bug in the existing implementation of the CoW?
> 
> One the one hand yes (pinning the shared zeropage is questionable), on
> the other hand no (user space did modify that memory ahead of time and
> filled it with something reasonable, that's how why always worked
> correctly in the absence of KSM).

I am not sure about exact details of the KSM implementation but if that
is not a desirable behavior then it should be handled on the KSM level.
The very sam thing can easily happen in a multithreaded (or in general
multi-process with shared mm) environment as well.
 
> >> Further, if an app explicitly decides to disable KSM one some region, we
> >> should not overwrite that.
> > 
> > Well, the interface is rather spartan. You cannot really tell "disable
> > KSM on some reqion". You can only tell "KSM can be applied to this
> > region" and later change your mind. Maybe this is what you had in
> > mind though.
> 
> That's what I meant. The hugepage interface has different semantics and
> you get three possible states:
> 
> 1: yes please: MADV_HUGEPAGE
> 2: don't care -- don't set anything
> 3. please no: MADV_NOHUGEPAGE
> 
> Currently for KSM we only have 1 and 2 internally I think (single
> flag), because it didn't matter in the past ebcause there was no
> force-enablement. One could convert it into all 3 states, changing the
> semantics of MADV_UNMERGEABLE slightly from
> 
> 
> 1: yes please: MADV_MERGEABLE
> 2: don't care: MADV_UNMERGEABLE
> 
> to
> 
> 1: yes please: MADV_MERGEABLE
> 2: don't care -- don't set anything
> 3. please no: MADV_UNMERGEABLE

Are you saying that any remote handling of the KSM has to deal with a
pre-existing semantic as well? Are we aware of any existing application
that really uses MADV_UNMERGEABLE in a hope to disable KSM for any of
its sensitive memory ranges? My understanding is that this is simply a
on/off knob and a remote way to do the same is in line with the existing
API.

To be completely honest I do not really buy an argument that this might
break something much more than the original application can do already.
Unless I am missing the ptrace check puts the bar rather high. Adversary
with this level of access to the target application has already broken
it. Or am I missing something?
-- 
Michal Hocko
SUSE Labs
