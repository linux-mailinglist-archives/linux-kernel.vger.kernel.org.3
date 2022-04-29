Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B792A515434
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 21:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238011AbiD2TKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 15:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237246AbiD2TKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 15:10:37 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F5CB7C5D
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 12:07:18 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id x52so6112743pfu.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 12:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eugz4b299LAJGviRoH6n/zYxtlNfeDtZuX/41skGRSQ=;
        b=j+KKd8TayNnf0ZoOfvfN/kf4WPOc5GvDmZoLi2SB6fzA/VKCl1lw2NMM0yLP2prH+8
         1GGlmGYS3kRII/PnI8s4kpyOmBO8L1wnO242BDLhEPGl61fh/Z7SZUr2GYiVTsJ4a2oF
         uTyxkvG1m1xfhoeBTHk2xShivqAlv8G8EKWK2j5oSw80Nh2UqZgtjR6nz/IdDM2IkV9m
         emXkT5Wcy98CaCmLA5aggANfsmvoR3iWeFX73m06sqiXFumta2V7H+rOnqN8HJV8rJzg
         O5V05KdlxxzBFMdoqejRJWuRYcDUec4ruyOtP8drBT1CUsYAgLciZ7/QOp5oAsNkIhMf
         SSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eugz4b299LAJGviRoH6n/zYxtlNfeDtZuX/41skGRSQ=;
        b=WizvuUBBo2PosuWphfiRPNxd/3fKaEOu4MKggq2FUcZbGq7JXdZBDTY5Av8Pl/HbqY
         AFSE923POxkUU7RTbVBqfbarZG1lI2udtDp2zSkPwdEtVNrWUGEPSSjZVL/JnK6s1Yxi
         eykw34dX21t5d7XITB1lX+MBW7o37CqsdgP2stz9Hj7X9Ca8PLiOWlwaM28R7lBBdE35
         CWg687BpNELiX1hO4d43lQJlpQ1/o1vsnRiIs613qOhWe46m8cX0wt34i4htArsdUi/0
         Sh4KW+we7icM4AEzQEtjoEev4XEnWpWE6ih/dRDzxXF00uClgU1eIHPd7qLOyzqREsid
         zfEg==
X-Gm-Message-State: AOAM532F/gPgcYXRp5sUuyzI9IC2boyrdA2/ZqPIrcagsJRndTwO9Ij7
        Pk/cIrguVvaPmR5J1Ih2FvBiHWqzmyWRaNryfms=
X-Google-Smtp-Source: ABdhPJxKktCuHL2P0bMHC+35pvSzkKtvzuFOAm8jlnxebQnU+R/CMxBzVivQLRAqrM3pGd/YYiRpHRxJDtENBSoTfvM=
X-Received: by 2002:a05:6a00:228d:b0:50a:934f:e302 with SMTP id
 f13-20020a056a00228d00b0050a934fe302mr376830pfe.20.1651259238116; Fri, 29 Apr
 2022 12:07:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220407020953.475626-1-shy828301@gmail.com> <Yk6cutNf5sOuYbDl@ziqianlu-nuc9qn>
 <CAHbLzkq+eKcKCsxXDTiOcBxk8FjMdWBqOxwi4N_NG7PZWbAAkA@mail.gmail.com>
 <Yl/FS9enAD4V8jG3@ziqianlu-nuc9qn> <f27ec36beb3cf1dbbfc3b8835e586d5d6fe7f561.camel@intel.com>
 <YmETEHnK/FiNbLO7@ziqianlu-desk1> <6f7210be7353d1c01dc9f872b2692b83f87f5452.camel@intel.com>
 <YmJKBaq1yj6/iBJ3@ziqianlu-desk1> <CAHbLzkriO6xWzyMNpcVFmyxSn=cqbz2qx+2mJ5d0m-beqPRCUg@mail.gmail.com>
 <Ymu9acl18pTA5GU6@ziqianlu-desk1>
In-Reply-To: <Ymu9acl18pTA5GU6@ziqianlu-desk1>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 29 Apr 2022 12:07:05 -0700
Message-ID: <CAHbLzkoi_a8Tk-bG53cwzcsHhaci30qxi8a4iBXUjVdVc-+kKQ@mail.gmail.com>
Subject: Re: [PATCH] mm: swap: determine swap device by using page nid
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     "ying.huang@intel.com" <ying.huang@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 3:27 AM Aaron Lu <aaron.lu@intel.com> wrote:
>
> On Fri, Apr 22, 2022 at 10:00:59AM -0700, Yang Shi wrote:
> > On Thu, Apr 21, 2022 at 11:24 PM Aaron Lu <aaron.lu@intel.com> wrote:
> > >
> > > On Thu, Apr 21, 2022 at 04:34:09PM +0800, ying.huang@intel.com wrote:
> > > > On Thu, 2022-04-21 at 16:17 +0800, Aaron Lu wrote:
> > > > > On Thu, Apr 21, 2022 at 03:49:21PM +0800, ying.huang@intel.com wrote:
> > >
> > > ... ...
> > >
> > > > > > For swap-in latency, we can use pmbench, which can output latency
> > > > > > information.
> > > > > >
> > > > >
> > > > > OK, I'll give pmbench a run, thanks for the suggestion.
> > > >
> > > > Better to construct a senario with more swapin than swapout.  For
> > > > example, start a memory eater, then kill it later.
> > >
> > > What about vm-scalability/case-swapin?
> > > https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree/case-swapin
> > >
> > > I think you are pretty familiar with it but still:
> > > 1) it starts $nr_task processes and each mmaps $size/$nr_task area and
> > >    then consumes the memory, after this, it waits for a signal;
> > > 2) start another process to consume $size memory to push the memory in
> > >    step 1) to swap device;
> > > 3) kick processes in step 1) to start accessing their memory, thus
> > >    trigger swapins. The metric of this testcase is the swapin throughput.
> > >
> > > I plan to restrict the cgroup's limit to $size.
> > >
> > > Considering there is only one NVMe drive attached to node 0, I will run
> > > the test as described before:
> > > 1) bind processes to run on node 0, allocate on node 1 to test the
> > >    performance when reclaimer's node id is the same as swap device's.
> > > 2) bind processes to run on node 1, allocate on node 0 to test the
> > >    performance when page's node id is the same as swap device's.
> > >
>
> Thanks to Tim, he has found me a server that has a single Optane disk
> attached to node 0.
>
> Let's use task0_mem0 to denote tasks bound to node 0 and memory bound
> to node 0 through cgroup cpuset. And for the above swapin case:
> when nr_task=1:
> task0_mem0 throughput: [571652, 587158, 594316], avg=584375 -> baseline
> task0_mem1 throughput: [582944, 583752, 589026], avg=585240    +0.15%
> task1_mem0 throughput: [569349, 577459, 581107], avg=575971    -1.4%
> task1_mem1 throughput: [564482, 570664, 571466], avg=568870    -2.6%
>
> task0_mem1 is slightly better than task1_mem0.
>
> For nr_task=8 or nr_task=16, I also gave it a run and the result is
> almost the same for all 4 cases.
>
> > > Ying and Yang,
> > >
> > > Let me know what you think about the case used and the way the test is
> > > conducted.
> >
> > Looks fine to me. To measure the latency, you could also try the below
> > bpftrace script:
> >
>
> Trying to install bpftrace on an old distro(Ubuntu 16.04) is a real
> pain, I gave up... But I managed to get an old bcc installed. Using
> the provided funclatency script to profile 30 seconds swap_readpage(),
> there is no obvious difference from the histrogram.

Thank you so much for the testing.

>
> So for now, from the existing results, it did't show big difference.
> Theoretically, for IO device, when swapping a remote page, using the
> remote swap device that is at the same node as the page can reduce the
> traffic of the interlink and improve performance. I think this is the
> main motivation for this code change?

Yes.

Given the result it seems better to keep the code as-is.

> On swapin time, it's hard to say which node the task will run on anyway
> so it's hard to say where to swap is beneficial.
>
