Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5B64E1A59
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 07:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244788AbiCTGOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 02:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244782AbiCTGOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 02:14:47 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33002DD4A
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 23:13:22 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id n15so10215384plh.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 23:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=ATwV3kKv7WjeaQbxwSKHzxc1JHIEcUZVk8IFPARJOcw=;
        b=fZEJMGkd+NV1NKWLGyW28bpPAFGP6pnIJ3E74/N2ZNjYtpTxD0oMcKuM8hqWTf0ReZ
         +xZ25SYY0HQ+NzV2IV6dqi5y9bHTu6qHM0aKvH6Rgty7uBmlSVV34XCMkXA8BEV4bXQZ
         Mg6zaAPkxBc61eNRADICSMq8VbbrPrudYBM9Db3UCyI712hl/LNDvEE26RR5xNQIIkby
         LxU4v6c/wDTaKajz9BGtpWGyLwjNPLvGx2LESzUahl3rkk3oVQzd0aYskX/pv+gbpm7W
         u644/jUDgqjuBgmMx6kDW3CrSL1MKd39R6eiiSxQvxweFYtoDF2GJbP5DzJFCGKQ2RZj
         llxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=ATwV3kKv7WjeaQbxwSKHzxc1JHIEcUZVk8IFPARJOcw=;
        b=F9+ilZ8NDfs9N2tSz+cknYJmIr6Zkl5T0Xm2JRaj0rfUIxWhOMy4+4/9CQ+aNfNlgr
         QYssacsCmNrED0X9WrfOolORZFUHtbv0+93b6xH4kJWLROkBCbMDLzFeNlVe4u7zk8UX
         qsvuNr4I4olWA7FBQsmyxX4qOFZ/ey7o4PUsMLAP7osnE/bSzDSffg5dMNMCwo0F6tqI
         pvHJTYSe7TO2vUe1fJY94K9UpFOMYLaNXZ2+RdKWl0+1u5wMufVhF4QjrbFDfYuvw6iZ
         ovc646UkVs/mxltjGl0l2ZXGntXK014TumaqZjAzNQi+PHVSO0ApcZohCDVHo5FX+yTy
         uq+g==
X-Gm-Message-State: AOAM530YyrumAxovBCSjTKsImquSzqOCsRwkoiHH7kxSb8FapLH7QP0b
        A9du3MwnmLbj24XZecCAOtQ=
X-Google-Smtp-Source: ABdhPJxR/AM8uHUbJiT7giuOK8er0MPtqxNzRTX8O0xC1v5KkNLSScOfzhQnwTL41N99DrWFHO4EQw==
X-Received: by 2002:a17:90b:3e8c:b0:1bf:4043:daa with SMTP id rj12-20020a17090b3e8c00b001bf40430daamr19767053pjb.233.1647756801445;
        Sat, 19 Mar 2022 23:13:21 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id k1-20020a056a00134100b004f78df32666sm15679359pfu.198.2022.03.19.23.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 23:13:20 -0700 (PDT)
Message-ID: <6236c600.1c69fb81.7cd4.a900@mx.google.com>
X-Google-Original-Message-ID: <20220320061319.GA2323336@cgel.zte@gmail.com>
Date:   Sun, 20 Mar 2022 06:13:19 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     bsingharora@gmail.com, akpm@linux-foundation.org,
        yang.yang29@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] delayacct: track delays from ksm cow
References: <20220316133420.2131707-1-yang.yang29@zte.com.cn>
 <412dc01c-8829-eac2-52c7-3f704dbb5a98@redhat.com>
 <6232970f.1c69fb81.4e365.c9f2@mx.google.com>
 <4e76476b-1da0-09c5-7dc4-0b2db796a549@redhat.com>
 <62330402.1c69fb81.d2ba6.0538@mx.google.com>
 <987bd014-c5ab-52cb-627e-2085560cb327@redhat.com>
 <6233e342.1c69fb81.692f.6286@mx.google.com>
 <2bb1c357-5335-9d96-d862-bd51c1014193@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bb1c357-5335-9d96-d862-bd51c1014193@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 09:24:44AM +0100, David Hildenbrand wrote:
> On 18.03.22 02:41, CGEL wrote:
> > On Thu, Mar 17, 2022 at 11:05:22AM +0100, David Hildenbrand wrote:
> >> On 17.03.22 10:48, CGEL wrote:
> >>> On Thu, Mar 17, 2022 at 09:17:13AM +0100, David Hildenbrand wrote:
> >>>> On 17.03.22 03:03, CGEL wrote:
> >>>>> On Wed, Mar 16, 2022 at 03:56:23PM +0100, David Hildenbrand wrote:
> >>>>>> On 16.03.22 14:34, cgel.zte@gmail.com wrote:
> >>>>>>> From: Yang Yang <yang.yang29@zte.com.cn>
> >>>>>>>
> >>>>>>> Delay accounting does not track the delay of ksm cow.  When tasks
> >>>>>>> have many ksm pages, it may spend a amount of time waiting for ksm
> >>>>>>> cow.
> >>>>>>>
> >>>>>>> To get the impact of tasks in ksm cow, measure the delay when ksm
> >>>>>>> cow happens. This could help users to decide whether to user ksm
> >>>>>>> or not.
> >>>>>>>
> >>>>>>> Also update tools/accounting/getdelays.c:
> >>>>>>>
> >>>>>>>     / # ./getdelays -dl -p 231
> >>>>>>>     print delayacct stats ON
> >>>>>>>     listen forever
> >>>>>>>     PID     231
> >>>>>>>
> >>>>>>>     CPU             count     real total  virtual total    delay total  delay average
> >>>>>>>                      6247     1859000000     2154070021     1674255063          0.268ms
> >>>>>>>     IO              count    delay total  delay average
> >>>>>>>                         0              0              0ms
> >>>>>>>     SWAP            count    delay total  delay average
> >>>>>>>                         0              0              0ms
> >>>>>>>     RECLAIM         count    delay total  delay average
> >>>>>>>                         0              0              0ms
> >>>>>>>     THRASHING       count    delay total  delay average
> >>>>>>>                         0              0              0ms
> >>>>>>>     KSM             count    delay total  delay average
> >>>>>>>                      3635      271567604              0ms
> >>>>>>>
> >>>>>>
> >>>>>> TBH I'm not sure how particularly helpful this is and if we want this.
> >>>>>>
> >>>>> Thanks for replying.
> >>>>>
> >>>>> Users may use ksm by calling madvise(, , MADV_MERGEABLE) when they want
> >>>>> save memory, it's a tradeoff by suffering delay on ksm cow. Users can
> >>>>> get to know how much memory ksm saved by reading
> >>>>> /sys/kernel/mm/ksm/pages_sharing, but they don't know what the costs of
> >>>>> ksm cow delay, and this is important of some delay sensitive tasks. If
> >>>>> users know both saved memory and ksm cow delay, they could better use
> >>>>> madvise(, , MADV_MERGEABLE).
> >>>>
> >>>> But that happens after the effects, no?
> >>>>
> >>>> IOW a user already called madvise(, , MADV_MERGEABLE) and then gets the
> >>>> results.
> >>>>
> >>> Image user are developing or porting their applications on experiment
> >>> machine, they could takes those benchmark as feedback to adjust whether
> >>> to use madvise(, , MADV_MERGEABLE) or it's range.
> >>
> >> And why can't they run it with and without and observe performance using
> >> existing metrics (or even application-specific metrics?)?
> >>
> >>
> > I think the reason why we need this patch, is just like why we need                                                                                                     
> > swap,reclaim,thrashing getdelay information. When system is complex,
> > it's hard to precise tell which kernel activity impact the observe
> > performance or application-specific metrics, preempt? cgroup throttle?
> > swap? reclaim? IO?
> > 
> > So if we could get the factor's precise impact data, when we are tunning
> > the factor(for this patch it's ksm), it's more efficient.
> > 
> 
> I'm not convinced that we want to make or write-fault handler more
> complicated for such a corner case with an unclear, eventual use case.

IIRC, KSM is designed for VM. But recently we found KSM works well for
system with many containers(save about 10%~20% of total memroy), and
container technology is more popular today, so KSM may be used more.

To reduce the impact for write-fault handler, we may write a new function
with ifdef CONFIG_KSM inside to do this job?

> IIRC, whenever using KSM you're already agreeing to eventually pay a
> performance price, and the price heavily depends on other factors in the
> system. Simply looking at the number of write-faults might already give
> an indication what changed with KSM being enabled.
> 
While saying "you're already agreeing to pay a performance price", I think
this is the shortcoming of KSM that putting off it being used more widely.
It's not easy for user/app to decide how to use madvise(, ,MADV_MERGEABLE).

Is there a more easy way to use KSM, enjoying memory saving while minimum
the performance price for container? We think it's possible, and are working
for a new patch: provide a knob for cgroup to enable/disable KSM for all tasks
in this cgroup, so if your container is delay sensitive just leave it, and if
not you can easy to enable KSM without modify app code.

Before using the new knob, user might want to know the precise impact of KSM.
I think write-faults is indirection. If indirection is good enough, why we need
taskstats and PSI? By the way, getdelays support container statistics.

Thanks.

> Having that said, I'd like to hear other opinions.
> 
> -- 
> Thanks,
> 
> David / dhildenb
