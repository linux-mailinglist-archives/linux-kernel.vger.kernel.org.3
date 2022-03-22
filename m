Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96BA4E3B77
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 10:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbiCVJKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 05:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiCVJKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 05:10:45 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390856AA53
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 02:09:18 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id v13so13517215qkv.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 02:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=BNCKjFJ1kL67A8tt1gdjJR9rFpj3bMan9VjmS2TqIGk=;
        b=hnfGs25l9dtepJOn2XILegGfFiERAx3f0NbzYKATft2vxoQ9JY/rVvxD5cdAOgO8qv
         rQOpu6pI8uX8KpnDCv3D3Go7OlNT0WyuG6Snd2iil+ALxfmaqqQDZf/RzUOF+iyvOYLa
         HDsdTVFCpWcbrUp3qol83bfvemFGGeZ7SkregkOuHIIeuqi2A9bPMVyZXP59mGkDQjh/
         xCQj4lGTxVDL5xnKOJ5wGL03BNYNtGHCyQMapgWnojjFT1XRTmb40dIP4zPIRwz4wt8D
         oH/9GKKewBaL099QjLolc2AHRVo2pEYhTZEFPV6fC5r/BQgnLVA1qwkj81xLdF5GR7Qa
         Qgkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=BNCKjFJ1kL67A8tt1gdjJR9rFpj3bMan9VjmS2TqIGk=;
        b=8MFel0WzUcGIqIA8N5arMFgq1nFAynoG5fNINbszIXAWvxsk6H+k7eW71j+2bvfduQ
         r1bKS7uiHl2OIBnfmzXcOVkGy1Ih32nCVU2tjfLVvQaBqiN8N49BQ65bqw3+PsI07svh
         MoL1X1JlWL2ECx+8ZZetelFQ5IVGZwXv6+SPGuj36kDAfRcI0PuigvLziPAcndO4yhOm
         pUiUIpvtlSkCA3jd8FzzwXM14/7xq2VHapC1sJPBAooVbWen6NRlDsq9cjt94FOrbKpz
         KOCwtWnU+LTUhLrSKk7oEx28nI0IvoJvkUtbFMn5D40HFrANdQ/Wwapc5qRL5CqixuDA
         /0UQ==
X-Gm-Message-State: AOAM530Igqgp/Wxj1MsKj11DDsPULrpFEOSMn+Z5qUdFfrNGWKh5w/aX
        4+mg0DuqBCkLioGo6ZzOEKQIfE+qvio=
X-Google-Smtp-Source: ABdhPJzgyrNa6Isu4OPdeTl0k3948wG3arAGVSSuexuWYTfbr2n+wQsLulRebuF3EVyqoxuySyWgNQ==
X-Received: by 2002:a05:620a:2293:b0:600:2b7b:2a19 with SMTP id o19-20020a05620a229300b006002b7b2a19mr14450676qkh.408.1647940156601;
        Tue, 22 Mar 2022 02:09:16 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s21-20020a05620a16b500b0067b1205878esm8675016qkj.7.2022.03.22.02.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 02:09:15 -0700 (PDT)
Message-ID: <6239923b.1c69fb81.b16f9.d623@mx.google.com>
X-Google-Original-Message-ID: <20220322090912.GA2339033@cgel.zte@gmail.com>
Date:   Tue, 22 Mar 2022 09:09:12 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     bsingharora@gmail.com, akpm@linux-foundation.org,
        yang.yang29@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] delayacct: track delays from ksm cow
References: <6232970f.1c69fb81.4e365.c9f2@mx.google.com>
 <4e76476b-1da0-09c5-7dc4-0b2db796a549@redhat.com>
 <62330402.1c69fb81.d2ba6.0538@mx.google.com>
 <987bd014-c5ab-52cb-627e-2085560cb327@redhat.com>
 <6233e342.1c69fb81.692f.6286@mx.google.com>
 <2bb1c357-5335-9d96-d862-bd51c1014193@redhat.com>
 <6236c600.1c69fb81.7cd4.a900@mx.google.com>
 <0414c610-7f56-2dd2-0d83-ac3a5194eb60@redhat.com>
 <62393e86.1c69fb81.bb254.3d1a@mx.google.com>
 <e63e62fc-1f94-0750-1503-181c7a35e226@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e63e62fc-1f94-0750-1503-181c7a35e226@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 08:55:15AM +0100, David Hildenbrand wrote:
> On 22.03.22 04:12, CGEL wrote:
> > On Mon, Mar 21, 2022 at 04:45:40PM +0100, David Hildenbrand wrote:
> >> On 20.03.22 07:13, CGEL wrote:
> >>> On Fri, Mar 18, 2022 at 09:24:44AM +0100, David Hildenbrand wrote:
> >>>> On 18.03.22 02:41, CGEL wrote:
> >>>>> On Thu, Mar 17, 2022 at 11:05:22AM +0100, David Hildenbrand wrote:
> >>>>>> On 17.03.22 10:48, CGEL wrote:
> >>>>>>> On Thu, Mar 17, 2022 at 09:17:13AM +0100, David Hildenbrand wrote:
> >>>>>>>> On 17.03.22 03:03, CGEL wrote:
> >>>>>>>>> On Wed, Mar 16, 2022 at 03:56:23PM +0100, David Hildenbrand wrote:
> >>>>>>>>>> On 16.03.22 14:34, cgel.zte@gmail.com wrote:
> >>>>>>>>>>> From: Yang Yang <yang.yang29@zte.com.cn>
> >>>>>>>>>>>
> >>>>>>>>>>> Delay accounting does not track the delay of ksm cow.  When tasks
> >>>>>>>>>>> have many ksm pages, it may spend a amount of time waiting for ksm
> >>>>>>>>>>> cow.
> >>>>>>>>>>>
> >>>>>>>>>>> To get the impact of tasks in ksm cow, measure the delay when ksm
> >>>>>>>>>>> cow happens. This could help users to decide whether to user ksm
> >>>>>>>>>>> or not.
> >>>>>>>>>>>
> >>>>>>>>>>> Also update tools/accounting/getdelays.c:
> >>>>>>>>>>>
> >>>>>>>>>>>     / # ./getdelays -dl -p 231
> >>>>>>>>>>>     print delayacct stats ON
> >>>>>>>>>>>     listen forever
> >>>>>>>>>>>     PID     231
> >>>>>>>>>>>
> >>>>>>>>>>>     CPU             count     real total  virtual total    delay total  delay average
> >>>>>>>>>>>                      6247     1859000000     2154070021     1674255063          0.268ms
> >>>>>>>>>>>     IO              count    delay total  delay average
> >>>>>>>>>>>                         0              0              0ms
> >>>>>>>>>>>     SWAP            count    delay total  delay average
> >>>>>>>>>>>                         0              0              0ms
> >>>>>>>>>>>     RECLAIM         count    delay total  delay average
> >>>>>>>>>>>                         0              0              0ms
> >>>>>>>>>>>     THRASHING       count    delay total  delay average
> >>>>>>>>>>>                         0              0              0ms
> >>>>>>>>>>>     KSM             count    delay total  delay average
> >>>>>>>>>>>                      3635      271567604              0ms
> >>>>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> TBH I'm not sure how particularly helpful this is and if we want this.
> >>>>>>>>>>
> >>>>>>>>> Thanks for replying.
> >>>>>>>>>
> >>>>>>>>> Users may use ksm by calling madvise(, , MADV_MERGEABLE) when they want
> >>>>>>>>> save memory, it's a tradeoff by suffering delay on ksm cow. Users can
> >>>>>>>>> get to know how much memory ksm saved by reading
> >>>>>>>>> /sys/kernel/mm/ksm/pages_sharing, but they don't know what the costs of
> >>>>>>>>> ksm cow delay, and this is important of some delay sensitive tasks. If
> >>>>>>>>> users know both saved memory and ksm cow delay, they could better use
> >>>>>>>>> madvise(, , MADV_MERGEABLE).
> >>>>>>>>
> >>>>>>>> But that happens after the effects, no?
> >>>>>>>>
> >>>>>>>> IOW a user already called madvise(, , MADV_MERGEABLE) and then gets the
> >>>>>>>> results.
> >>>>>>>>
> >>>>>>> Image user are developing or porting their applications on experiment
> >>>>>>> machine, they could takes those benchmark as feedback to adjust whether
> >>>>>>> to use madvise(, , MADV_MERGEABLE) or it's range.
> >>>>>>
> >>>>>> And why can't they run it with and without and observe performance using
> >>>>>> existing metrics (or even application-specific metrics?)?
> >>>>>>
> >>>>>>
> >>>>> I think the reason why we need this patch, is just like why we need                                                                                                     
> >>>>> swap,reclaim,thrashing getdelay information. When system is complex,
> >>>>> it's hard to precise tell which kernel activity impact the observe
> >>>>> performance or application-specific metrics, preempt? cgroup throttle?
> >>>>> swap? reclaim? IO?
> >>>>>
> >>>>> So if we could get the factor's precise impact data, when we are tunning
> >>>>> the factor(for this patch it's ksm), it's more efficient.
> >>>>>
> >>>>
> >>>> I'm not convinced that we want to make or write-fault handler more
> >>>> complicated for such a corner case with an unclear, eventual use case.
> >>>
> >>> IIRC, KSM is designed for VM. But recently we found KSM works well for
> >>> system with many containers(save about 10%~20% of total memroy), and
> >>> container technology is more popular today, so KSM may be used more.
> >>>
> >>> To reduce the impact for write-fault handler, we may write a new function
> >>> with ifdef CONFIG_KSM inside to do this job?
> >>
> >> Maybe we just want to catch the impact of the write-fault handler when
> >> copying more generally?
> >>
> > We know kernel has different kind of COW, some are transparent for user.
> > For example child process may cause COW, and user should not care this
> > performance impact, because it's kernel inside mechanism, user is hard
> > to do something. But KSM is different, user can do the policy tuning in
> > userspace. If we metric all the COW, it may be noise, doesn't it?
> 
> Only to some degree I think. The other delays (e.g., SWAP, RECLAIM) are
> also not completely transparent to the user, no? I mean, user space
> might affect them to some degree with some tunables, but it's not
> completely transparent for the user either.
> 
> IIRC, we have these sources of COW that result in a r/w anon page (->
> MAP_PRIVATE):
> (1) R/O-mapped, (possibly) shared anonymous page (fork() or KSM)
> (2) R/O-mapped, shared zeropage (e.g., KSM, read-only access to
>     unpopulated page in MAP_ANON)
> (3) R/O-mapped, shared file/device/... page that requires a private copy
>     on modifications (e.g., MAP_PRIVATE !MAP_ANON)
> 
> Note that your current patch won't catch when KSM placed the shared
> zeropage (use_zero_page).
> 
> Tracking the overall overhead might be of value I think, and it would
> still allow for determining how much KSM is involved by measuring with
> and without KSM enabled.
> 
> >>>
> >>>> IIRC, whenever using KSM you're already agreeing to eventually pay a
> >>>> performance price, and the price heavily depends on other factors in the
> >>>> system. Simply looking at the number of write-faults might already give
> >>>> an indication what changed with KSM being enabled.
> >>>>
> >>> While saying "you're already agreeing to pay a performance price", I think
> >>> this is the shortcoming of KSM that putting off it being used more widely.
> >>> It's not easy for user/app to decide how to use madvise(, ,MADV_MERGEABLE).
> >>
> >> ... and my point is that the metric you're introducing might absolutely
> >> not be expressive for such users playing with MADV_MERGEABLE. IMHO
> >> people will look at actual application performance to figure out what
> >> "harm" will be done, no?
> >>
> >> But I do see value in capturing how many COW we have in general --
> >> either via a counter or via a delay as proposed by you.
> >>
> > Thanks for your affirmative. As describe above, or we add a vm counter:
> > KSM_COW? 
> 
> As I'm messing with the COW logic lately (e.g., [1]) I'd welcome vm
> counters for all different kind of COW-related events, especially
> 
> (1) COW of an anon, !KSM page
> (2) COW of a KSM page
> (3) COW of the shared zeropage
> (4) Reuse instead of COW
> 
> I used some VM counters myself to debug/test some of my latest changes.
> 
> >>>
> >>> Is there a more easy way to use KSM, enjoying memory saving while minimum
> >>> the performance price for container? We think it's possible, and are working
> >>> for a new patch: provide a knob for cgroup to enable/disable KSM for all tasks
> >>> in this cgroup, so if your container is delay sensitive just leave it, and if
> >>> not you can easy to enable KSM without modify app code.
> >>>
> >>> Before using the new knob, user might want to know the precise impact of KSM.
> >>> I think write-faults is indirection. If indirection is good enough, why we need
> >>> taskstats and PSI? By the way, getdelays support container statistics.
> >>
> >> Would anything speak against making this more generic and capturing the
> >> delay for any COW, not just for KSM?
> > I think we'd better to export data to userspace that is meaning for user.
> > User may no need kernel inside mechanism'data.
> 
> Reading Documentation/accounting/delay-accounting.rst I wonder what we
> best put in there.
> 
> "Tasks encounter delays in execution when they wait for some kernel
> resource to become available."
> 
> I mean, in any COW event we are waiting for the kernel to create a copy.
> 
> 
> This could be of value even if we add separate VM counters.
>
I think your statement is good enough. I will modify this patch to support
counting all COW events delay, and submit patch to add new VM counters for
different kinds of COW.

Great thanks!
> 
> 
> [1]
> https://lore.kernel.org/linux-mm/20220315104741.63071-2-david@redhat.com/T/
> 
> -- 
> Thanks,
> 
> David / dhildenb
