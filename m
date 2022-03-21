Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0A54E3055
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 19:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352367AbiCUS7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 14:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240618AbiCUS7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 14:59:47 -0400
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DADCBC2F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 11:58:21 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id o10so12990513ejd.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 11:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6aLAHA+A+XxV/kMRfZhDtEhgsmAuTureOTlZFDIWkzs=;
        b=Qsq21hmRH+iqiYa4VSlncdY3qBfUF+dVsu8MilMIEA2eorfCCx7cGtihOezl2qXt3V
         bfgGzVJ4tD1Tgp0oQeenHZXex+a1238ZWyxhCPkJleMHuCdwx5fUEb6yNPxtka1n0PN3
         24RS+BAoqoBunTWviDoBs1sy8Pvg0xzmlb527mXILgu+kMb2ybUOE99afXMx79REuSjR
         TuW44AjxeE7cy0loC3b7BkLkOP42dh5erFvvvXjLTSBlY6IfqZUbeRL3JFqOSk7BJyB7
         R1cgRJozwVrIAIftjB/l9hvY7yhjHdZaoFBDuvzbq6UldlKUmqxX5C8oH5jee4r3L82V
         WwOg==
X-Gm-Message-State: AOAM532f7WtGjRTgfGMHfknrR5DbRauc8jzq/XTtIdywt6iF2OLWNtwd
        Dvvw4iK8gXC7SkK3+TrScnpRMkCwt+uThIErbgydLQ==
X-Google-Smtp-Source: ABdhPJw43iRiq+D1zfQ0J+MApKYivTG9ixyQabZWo7Hz7p1g9hAkNUhsYf004S6F+kC1U+OJfh6k71JDJTdo67TQ4cg=
X-Received: by 2002:a17:907:3e98:b0:6d7:7c21:529f with SMTP id
 hs24-20020a1709073e9800b006d77c21529fmr22525233ejc.104.1647889098743; Mon, 21
 Mar 2022 11:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220309021230.721028-1-yuzhao@google.com> <20220309021230.721028-6-yuzhao@google.com>
 <875yoh552i.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAOUHufYPSesiePfxaV=y9Vne5cb+Y_vQtJyQ1NiO1CFus=8WOA@mail.gmail.com>
In-Reply-To: <CAOUHufYPSesiePfxaV=y9Vne5cb+Y_vQtJyQ1NiO1CFus=8WOA@mail.gmail.com>
From:   Justin Forbes <jforbes@fedoraproject.org>
Date:   Mon, 21 Mar 2022 13:58:07 -0500
Message-ID: <CAFxkdAouXr5Qn9asFge0P-HqA4aAk56yqP4xEiaWYRioJ1ssyA@mail.gmail.com>
Subject: Re: [PATCH v9 05/14] mm: multi-gen LRU: groundwork
To:     Yu Zhao <yuzhao@google.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        kernel <kernel@lists.fedoraproject.org>,
        kernel-team@lists.ubuntu.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 4:30 AM Yu Zhao <yuzhao@google.com> wrote:
>
> On Mon, Mar 14, 2022 at 2:09 AM Huang, Ying <ying.huang@intel.com> wrote:
> >
> > Hi, Yu,
> >
> > Yu Zhao <yuzhao@google.com> writes:
> > > diff --git a/mm/Kconfig b/mm/Kconfig
> > > index 3326ee3903f3..747ab1690bcf 100644
> > > --- a/mm/Kconfig
> > > +++ b/mm/Kconfig
> > > @@ -892,6 +892,16 @@ config ANON_VMA_NAME
> > >         area from being merged with adjacent virtual memory areas due to the
> > >         difference in their name.
> > >
> > > +# the multi-gen LRU {
> > > +config LRU_GEN
> > > +     bool "Multi-Gen LRU"
> > > +     depends on MMU
> > > +     # the following options can use up the spare bits in page flags
> > > +     depends on !MAXSMP && (64BIT || !SPARSEMEM || SPARSEMEM_VMEMMAP)
> >
> > LRU_GEN depends on !MAXSMP.  So, What is the maximum NR_CPUS supported
> > by LRU_GEN?
>
> LRU_GEN doesn't really care about NR_CPUS. IOW, it doesn't impose a
> max number. The dependency is with NODES_SHIFT selected by MAXSMP:
>     default "10" if MAXSMP
> This combined with LAST_CPUPID_SHIFT can exhaust the spare bits in page flags.
>
> MAXSMP is meant for kernel developers to test their code, and it
> should not be used in production [1]. But some distros unfortunately
> ship kernels built with this option, e.g., Fedora and Ubuntu. And
> their users reported build errors to me after they applied MGLRU on
> those kernels ("Not enough bits in page flags"). Let me add Fedora and
> Ubuntu to this thread.
>
> Fedora and Ubuntu,
>
> Could you please clarify if there is a reason to ship kernels built
> with MAXSMP? Otherwise, please consider disabling this option. Thanks.
>
> As per above, MAXSMP enables ridiculously large numbers of CPUs and
> NUMA nodes for testing purposes. It is detrimental to performance,
> e.g., CPUMASK_OFFSTACK.

It was enabled for Fedora, and RHEL because we did need more than 512
CPUs, originally only in RHEL until SGI (years ago) complained that
they were testing very large machines with Fedora.  The testing done
on RHEL showed that the performance impact was minimal.   For a very
long time we had MAXSMP off and carried a patch which allowed us to
turn on CPUMASK_OFFSTACK without debugging because there was supposed
to be "something else" coming.  In 2019 we gave up, dropped that patch
and just turned on MAXSMP.

I do not have any metrics for how often someone runs Fedora on a
ridiculously large machine these days, but I would guess that number
is not 0.

Justin

> [1] https://lore.kernel.org/lkml/20131106055634.GA24044@gmail.com/
>
