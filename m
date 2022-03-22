Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4747E4E3823
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 05:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236598AbiCVEyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 00:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236567AbiCVEyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 00:54:22 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958CC98F73
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 21:52:54 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id d129so3545236vkh.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 21:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WZwFAXeypL3jPipKNgPJxQINJj6JMXunijbszepaSjU=;
        b=YFh0z8aRY3bgF45d2I8rgI3ST09NIq0Hofz3dyojfGq9mke2zfjLTsefMvQvUBTJgm
         1qnKwVGrEXKXSj0hr1XpDupQwV09DvcSlZv2oyo79KqZp8KW5tKNq+0f1ASQPMGtcfJj
         P5fQrQ8ujRVKAEfEuFzSHk0AfcCg6JSuVh6LG1bUk+O7UOrgYohfOEL9uBkgKuz4Wreu
         Q8KI8EdVa4vu6DTWcfdyaVSbtYeXcWRWcrhBF6Lx8WDBw43iNsBdBH0EcHw0kye8ODpH
         XYWP2nIJloYZp0SmdNuOj8C9hJ23ZC46NCbzbhzmgg4s3AxfY1MAHIflZ+Ntz3noPvvn
         it6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WZwFAXeypL3jPipKNgPJxQINJj6JMXunijbszepaSjU=;
        b=cAKU06FbLnOd1S3zOpwTcDmS7nQH1vjaeMwSGOEN0j6SXNnos1ZCcz15b98joR6Ccc
         GDg5OcuUeh8TuGALgEzzGjqojhNGD0d5kDX1hcwm2+CMM2qVkryJpiE1i+Xpx/j5EFiJ
         mEDVK8X8zwHoApzzjHSBg2nzw9QT7VTcZo9iK01knl/isHDGTsYwn1228Pl7D4LJ49ju
         13bRQVWJ6kCMJ6VSH1QcMIoxALVkyFH1wW+NLo2yOgcdT4rQDfmR1vxXR1BkF+ngo/mS
         FB7AxAUjSsC7TkniBcOvEaXoVJ/f0TZT8Ut3kaPs0O4/mHiRMoLeqAgotT54YSgQULr8
         8ZBA==
X-Gm-Message-State: AOAM530JheCTkJmtTTsfiUPoLVh6wpdEMyqD+eojzGTwd1HRQMS/9Hjs
        Obl44vtusquMMqzasPal2R3rXB5tDLLVqGaZTuNSjw==
X-Google-Smtp-Source: ABdhPJxFR1nglzJK4RoUAy7iy7C1My9l/amg903cMnO5caRvyJNwsaMuy9GXoP8bTaVJxjBoEyZx6dpVzJR7dnuPQ7o=
X-Received: by 2002:a05:6122:887:b0:332:699e:7e67 with SMTP id
 7-20020a056122088700b00332699e7e67mr9362524vkf.35.1647924773467; Mon, 21 Mar
 2022 21:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220309021230.721028-1-yuzhao@google.com> <20220309021230.721028-6-yuzhao@google.com>
 <875yoh552i.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAOUHufYPSesiePfxaV=y9Vne5cb+Y_vQtJyQ1NiO1CFus=8WOA@mail.gmail.com>
 <CAFxkdAouXr5Qn9asFge0P-HqA4aAk56yqP4xEiaWYRioJ1ssyA@mail.gmail.com> <cf736b49-57e3-51df-56af-5b71d0304e4a@redhat.com>
In-Reply-To: <cf736b49-57e3-51df-56af-5b71d0304e4a@redhat.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 21 Mar 2022 22:52:42 -0600
Message-ID: <CAOUHufbkSffDkUgv03kGdNs2-6V-fTHRKr7hjsZJubA_yWU7bQ@mail.gmail.com>
Subject: Re: [PATCH v9 05/14] mm: multi-gen LRU: groundwork
To:     Prarit Bhargava <prarit@redhat.com>,
        Justin Forbes <jforbes@fedoraproject.org>
Cc:     Andi Kleen <ak@linux.intel.com>, kernel-team@lists.ubuntu.com,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Brian Geffon <bgeffon@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Jesse Barnes <jsbarnes@google.com>,
        Sofia Trinh <sofia.trinh@edi.works>,
        "Huang, Ying" <ying.huang@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Steven Barrett <steven@liquorix.net>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Donald Carr <d@chaos-reins.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Will Deacon <will@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@kernel.org>,
        kernel <kernel@lists.fedoraproject.org>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Larabel <Michael@michaellarabel.com>,
        Linux-MM <linux-mm@kvack.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 1:18 PM Prarit Bhargava <prarit@redhat.com> wrote:
>
> On 3/21/22 14:58, Justin Forbes wrote:
> > On Mon, Mar 14, 2022 at 4:30 AM Yu Zhao <yuzhao@google.com> wrote:
> >>
> >> On Mon, Mar 14, 2022 at 2:09 AM Huang, Ying <ying.huang@intel.com> wrote:
> >>>
> >>> Hi, Yu,
> >>>
> >>> Yu Zhao <yuzhao@google.com> writes:
> >>>> diff --git a/mm/Kconfig b/mm/Kconfig
> >>>> index 3326ee3903f3..747ab1690bcf 100644
> >>>> --- a/mm/Kconfig
> >>>> +++ b/mm/Kconfig
> >>>> @@ -892,6 +892,16 @@ config ANON_VMA_NAME
> >>>>          area from being merged with adjacent virtual memory areas due to the
> >>>>          difference in their name.
> >>>>
> >>>> +# the multi-gen LRU {
> >>>> +config LRU_GEN
> >>>> +     bool "Multi-Gen LRU"
> >>>> +     depends on MMU
> >>>> +     # the following options can use up the spare bits in page flags
> >>>> +     depends on !MAXSMP && (64BIT || !SPARSEMEM || SPARSEMEM_VMEMMAP)
> >>>
> >>> LRU_GEN depends on !MAXSMP.  So, What is the maximum NR_CPUS supported
> >>> by LRU_GEN?
> >>
> >> LRU_GEN doesn't really care about NR_CPUS. IOW, it doesn't impose a
> >> max number. The dependency is with NODES_SHIFT selected by MAXSMP:
> >>      default "10" if MAXSMP
> >> This combined with LAST_CPUPID_SHIFT can exhaust the spare bits in page flags.
> >>
> >> MAXSMP is meant for kernel developers to test their code, and it
> >> should not be used in production [1]. But some distros unfortunately
> >> ship kernels built with this option, e.g., Fedora and Ubuntu. And
> >> their users reported build errors to me after they applied MGLRU on
> >> those kernels ("Not enough bits in page flags"). Let me add Fedora and
> >> Ubuntu to this thread.
> >>
> >> Fedora and Ubuntu,
> >>
> >> Could you please clarify if there is a reason to ship kernels built
> >> with MAXSMP? Otherwise, please consider disabling this option. Thanks.
> >>
> >> As per above, MAXSMP enables ridiculously large numbers of CPUs and
> >> NUMA nodes for testing purposes. It is detrimental to performance,
> >> e.g., CPUMASK_OFFSTACK.
> >
> > It was enabled for Fedora, and RHEL because we did need more than 512
> > CPUs, originally only in RHEL until SGI (years ago) complained that
> > they were testing very large machines with Fedora.  The testing done
> > on RHEL showed that the performance impact was minimal.   For a very
> > long time we had MAXSMP off and carried a patch which allowed us to
> > turn on CPUMASK_OFFSTACK without debugging because there was supposed
> > to be "something else" coming.  In 2019 we gave up, dropped that patch
> > and just turned on MAXSMP.
> >
> > I do not have any metrics for how often someone runs Fedora on a
> > ridiculously large machine these days, but I would guess that number
> > is not 0.
>
> It is not 0.  I've seen data from large systems (1000+ logical threads)
> that are running Fedora albeit with a modified Fedora kernel.
>
> Additionally the max limit for CPUS in RHEL is 1792, however, we have
> recently had a request to *double* that to 3584.  You should just assume
> that number will continue to increase.

Good to know. Thanks.

From the standpoint of overhead, I'd consider NR_CPUS=4096 and
NODES_SHIFT=7 as the next step, before going with MAXSMP.
