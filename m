Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD62954394E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245669AbiFHQmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245618AbiFHQmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:42:54 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16EF42EED
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 09:42:52 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id s135so3779676pgs.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 09:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FfjvO7B5FqBNPEvHomyiko8bwkLv7xlFXftevPJWVhI=;
        b=Ewgy29dHgxalPcoa/UTJQKTeAWR9W8BGDEFTLyinxP/EalQDXxuaFCbFGavxlfY+35
         AKvG/UDGzebVpi7TqYWDfZgGEY044i3Qciol9wjugjQLZpZ9GSkLTH3s38C+aFimnPwh
         pDmEjskW0mbV0sFbhNl+qyVLl9zz0Iw89O2UPcyILWXlvztbIJWVw1iiR/GdR7vL6Uot
         7s9hrDQR6AKbA4VQIsKwzZXsqDn0/bj7taTdjgnAl00xF3LbA7+/dKryZl8gmfj/d7e2
         iuD4RqMa7wd0hl9Xp4L2HUxOzDKvAocq7QamySQUbPqi+y4HwMMfsBHtejYe7i4Gpl7x
         0Qmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FfjvO7B5FqBNPEvHomyiko8bwkLv7xlFXftevPJWVhI=;
        b=TFeXOA09iKDex2orVHxcw0XWvgeiQWP53EMILbAKeDODsG8OmKMQ4fEPBBCBjEY165
         6fUjnXNFxyG06gSXkVGwvaDHszOgW/y3lQHFsQpQIEiAq/t8tSUkDJm8vuB7oowuvTcS
         Fim9Z4yNPvnzhW/6dZB0JqUiboP98Jw0ySkAw8iCG2Umanx6EFvTwOGsq4SLPIs7Ckim
         +3CRSo9ctlhfiC65wquHnfg37endZATnyC9+2fTk9h+aDIAVBVLFJFhvgu0kL5wjCqus
         ZK46ts0Z8G0iGey2EdtFMtRiTXXuwX4ylrzx//lGNNpRRI3vfLG7nPdEKZ6bz3aePGON
         UflA==
X-Gm-Message-State: AOAM533g4S574L4SeGiBFiI1SKjqfYbxWCcu7yQ9S0tu8pyOFdOPCPNa
        tUOLih4+Xr4qx2hKILShMIq0SY3vJWAe+6LWN+I=
X-Google-Smtp-Source: ABdhPJwbbsC/uM/CMyClhNpsm0YJrAzx+GFfEPeMelWToBuXprjIt8AxZzkgijS9pHd5VoLMK1yry9MFWz1VRKpt0+Q=
X-Received: by 2002:a63:3183:0:b0:3fd:6797:70a8 with SMTP id
 x125-20020a633183000000b003fd679770a8mr19363974pgx.206.1654706572261; Wed, 08
 Jun 2022 09:42:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
 <20220603134237.131362-2-aneesh.kumar@linux.ibm.com> <CAHbLzkrWer5-HgujZ12b=qxtT2ByV0+Sy7fsYb2EBgHAGRuPpw@mail.gmail.com>
 <2b4f053b-de25-986c-f764-5cc6a28f4953@linux.ibm.com>
In-Reply-To: <2b4f053b-de25-986c-f764-5cc6a28f4953@linux.ibm.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 8 Jun 2022 09:42:39 -0700
Message-ID: <CAHbLzkqg++ENAEPdd+UY8Q5X0CuvbHC+JFAvYi2KLaS+2=q3_A@mail.gmail.com>
Subject: Re: [PATCH v5 1/9] mm/demotion: Add support for explicit memory tiers
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Xu <weixugc@google.com>, Huang Ying <ying.huang@intel.com>,
        Greg Thelen <gthelen@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 7, 2022 at 9:58 PM Aneesh Kumar K V
<aneesh.kumar@linux.ibm.com> wrote:
>
> On 6/8/22 3:02 AM, Yang Shi wrote:
> > On Fri, Jun 3, 2022 at 6:43 AM Aneesh Kumar K.V
> > <aneesh.kumar@linux.ibm.com> wrote:
> >>
> >> In the current kernel, memory tiers are defined implicitly via a
> >> demotion path relationship between NUMA nodes, which is created
> >> during the kernel initialization and updated when a NUMA node is
> >> hot-added or hot-removed.  The current implementation puts all
> >> nodes with CPU into the top tier, and builds the tier hierarchy
> >> tier-by-tier by establishing the per-node demotion targets based
> >> on the distances between nodes.
> >>
> >> This current memory tier kernel interface needs to be improved for
> >> several important use cases,
> >>
> >> The current tier initialization code always initializes
> >> each memory-only NUMA node into a lower tier.  But a memory-only
> >> NUMA node may have a high performance memory device (e.g. a DRAM
> >> device attached via CXL.mem or a DRAM-backed memory-only node on
> >> a virtual machine) and should be put into a higher tier.
> >>
> >> The current tier hierarchy always puts CPU nodes into the top
> >> tier. But on a system with HBM or GPU devices, the
> >> memory-only NUMA nodes mapping these devices should be in the
> >> top tier, and DRAM nodes with CPUs are better to be placed into the
> >> next lower tier.
> >>
> >> With current kernel higher tier node can only be demoted to selected nodes on the
> >> next lower tier as defined by the demotion path, not any other
> >> node from any lower tier.  This strict, hard-coded demotion order
> >> does not work in all use cases (e.g. some use cases may want to
> >> allow cross-socket demotion to another node in the same demotion
> >> tier as a fallback when the preferred demotion node is out of
> >> space), This demotion order is also inconsistent with the page
> >> allocation fallback order when all the nodes in a higher tier are
> >> out of space: The page allocation can fall back to any node from
> >> any lower tier, whereas the demotion order doesn't allow that.
> >>
> >> The current kernel also don't provide any interfaces for the
> >> userspace to learn about the memory tier hierarchy in order to
> >> optimize its memory allocations.
> >>
> >> This patch series address the above by defining memory tiers explicitly.
> >>
> >> This patch introduce explicity memory tiers with ranks. The rank
> >> value of a memory tier is used to derive the demotion order between
> >> NUMA nodes. The memory tiers present in a system can be found at
> >>
> >> /sys/devices/system/memtier/memtierN/
> >>
> >> The nodes which are part of a specific memory tier can be listed
> >> via
> >> /sys/devices/system/memtier/memtierN/nodelist
> >>
> >> "Rank" is an opaque value. Its absolute value doesn't have any
> >> special meaning. But the rank values of different memtiers can be
> >> compared with each other to determine the memory tier order.
> >>
> >> For example, if we have 3 memtiers: memtier0, memtier1, memiter2, and
> >> their rank values are 300, 200, 100, then the memory tier order is:
> >> memtier0 -> memtier2 -> memtier1, where memtier0 is the highest tier
> >> and memtier1 is the lowest tier.
> >>
> >> The rank value of each memtier should be unique.
> >>
> >> A higher rank memory tier will appear first in the demotion order
> >> than a lower rank memory tier. ie. while reclaim we choose a node
> >> in higher rank memory tier to demote pages to as compared to a node
> >> in a lower rank memory tier.
> >>
> >> For now we are not adding the dynamic number of memory tiers.
> >> But a future series supporting that is possible. Currently
> >> number of tiers supported is limitted to MAX_MEMORY_TIERS(3).
> >> When doing memory hotplug, if not added to a memory tier, the NUMA
> >> node gets added to DEFAULT_MEMORY_TIER(1).
> >>
> >> This patch is based on the proposal sent by Wei Xu <weixugc@google.com> at [1].
> >>
> >> [1] https://lore.kernel.org/linux-mm/CAAPL-u9Wv+nH1VOZTj=9p9S70Y3Qz3+63EkqncRDdHfubsrjfw@mail.gmail.com
> >>
> >> Suggested-by: Wei Xu <weixugc@google.com>
> >> Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
> >> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> >> ---
> >>   include/linux/memory-tiers.h |  20 ++++
> >>   mm/Kconfig                   |  11 ++
> >>   mm/Makefile                  |   1 +
> >>   mm/memory-tiers.c            | 188 +++++++++++++++++++++++++++++++++++
> >>   4 files changed, 220 insertions(+)
> >>   create mode 100644 include/linux/memory-tiers.h
> >>   create mode 100644 mm/memory-tiers.c
> >>
> >> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> >> new file mode 100644
> >> index 000000000000..e17f6b4ee177
> >> --- /dev/null
> >> +++ b/include/linux/memory-tiers.h
> >> @@ -0,0 +1,20 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +#ifndef _LINUX_MEMORY_TIERS_H
> >> +#define _LINUX_MEMORY_TIERS_H
> >> +
> >> +#ifdef CONFIG_TIERED_MEMORY
> >> +
> >> +#define MEMORY_TIER_HBM_GPU    0
> >> +#define MEMORY_TIER_DRAM       1
> >> +#define MEMORY_TIER_PMEM       2
> >> +
> >> +#define MEMORY_RANK_HBM_GPU    300
> >> +#define MEMORY_RANK_DRAM       200
> >> +#define MEMORY_RANK_PMEM       100
> >> +
> >> +#define DEFAULT_MEMORY_TIER    MEMORY_TIER_DRAM
> >> +#define MAX_MEMORY_TIERS  3
> >> +
> >> +#endif /* CONFIG_TIERED_MEMORY */
> >> +
> >> +#endif
> >> diff --git a/mm/Kconfig b/mm/Kconfig
> >> index 169e64192e48..08a3d330740b 100644
> >> --- a/mm/Kconfig
> >> +++ b/mm/Kconfig
> >> @@ -614,6 +614,17 @@ config ARCH_ENABLE_HUGEPAGE_MIGRATION
> >>   config ARCH_ENABLE_THP_MIGRATION
> >>          bool
> >>
> >> +config TIERED_MEMORY
> >> +       bool "Support for explicit memory tiers"
> >> +       def_bool n
> >> +       depends on MIGRATION && NUMA
> >> +       help
> >> +         Support to split nodes into memory tiers explicitly and
> >> +         to demote pages on reclaim to lower tiers. This option
> >> +         also exposes sysfs interface to read nodes available in
> >> +         specific tier and to move specific node among different
> >> +         possible tiers.
> >
> > IMHO we should not need a new kernel config. If tiering is not present
> > then there is just one tier on the system. And tiering is a kind of
> > hardware configuration, the information could be shown regardless of
> > whether demotion/promotion is supported/enabled or not.
> >
>
> This was added so that we could avoid doing multiple
>
> #if defined(CONFIG_MIGRATION) && defined(CONFIG_NUMA)
>
> Initially I had that as def_bool y and depends on MIGRATION && NUMA. But
> it was later suggested that def_bool is not recommended for newer config.
>
> How about
>
>   config TIERED_MEMORY
>         bool "Support for explicit memory tiers"
> -       def_bool n
> -       depends on MIGRATION && NUMA
> -       help
> -         Support to split nodes into memory tiers explicitly and
> -         to demote pages on reclaim to lower tiers. This option
> -         also exposes sysfs interface to read nodes available in
> -         specific tier and to move specific node among different
> -         possible tiers.
> +       def_bool MIGRATION && NUMA

CONFIG_NUMA should be good enough. Memory tiering doesn't have to mean
demotion/promotion has to be supported IMHO.

>
>   config HUGETLB_PAGE_SIZE_VARIABLE
>         def_bool n
>
> ie, we just make it a Kconfig variable without exposing it to the user?
>
> -aneesh
