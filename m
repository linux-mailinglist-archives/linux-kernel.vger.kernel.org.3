Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9539351B862
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 09:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245425AbiEEHGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 03:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbiEEHGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 03:06:17 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4986B424B8
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 00:02:38 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id m203so1663694vke.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 00:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vnF2T47QwtV2MM5JsBKXJllk8Fkw/taDtMcsA+Pm0ss=;
        b=Tv7st99W/bJLrY0D6g5aI3ngx9ERblrYUN57KX7nh/Mo//mNuBpJ+alhR0fCHjnXDJ
         KRt2Lp8TQlGEl0THfxDLxhcJbNXqf21r40Z9wDJQpAJnJU4F/XA4LpoJr4D6DCljnehQ
         HM86I2tmPq2S5M1DEd5BwLMSN9fIYMH8uCqqr3+fhmChnpz+GvpP4Ynqh8MqKhe5cd98
         Q52Ay97TwTlV1WkwoHHjHC2FZftI9O5J5sz+XNPGTMDskd0PjgBWlCCkf5E4lH2Fr9vl
         4hVCB+XIZmY1pYWoxnX1L2YqeGg8eXyjPaED0n154CTS6n8U9E6yuqU6729gXD5iXWUc
         F7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vnF2T47QwtV2MM5JsBKXJllk8Fkw/taDtMcsA+Pm0ss=;
        b=5Sh10MLl3Os5GuiVo4pMerObFeDHfP3MsRs/+ll3byS89JVEwEZTeoe77C7/YJkRe2
         GvemfLIxnI4fPOJDzZsmPLTK2lG45Lj2g9lm9Z1EwYoNCc0g46a5utQmF/bu+FyMizZA
         ulNH22lykXEh+xuXJeQiDh8CRz3iyxZhA0oNBMSsCeGLiCveD5u7tsmYTTIrOazDn137
         udCGc2TSwoabdczLZyMpo8kEEsIF0Kk5uIUx82/tTChFMvGI2VaoFSWk3Hmm6zt8d9eO
         MgBfw4Z8q6JBTmf3wDNNhiJRT82eHu+0oz1W17uTe9sYsASWQE18jQ3n2Pw4ruQ233yo
         dwVw==
X-Gm-Message-State: AOAM531ZAar7k6v9JYYgpGhTR1HVsINZ6QuhUBb+FLCvqJMrOnynAraX
        m2hQbpM41fCZ02FW/79y/wZEqLYIEIvLga9YfLr28w==
X-Google-Smtp-Source: ABdhPJwSxqp9pbYamPWRRMk2ZIElO2hkcZR6prx7v2o9JG4eZmm0Trv/PdDyCHvpb9TreDTcX7jCzsyBv8T38PB8las=
X-Received: by 2002:a1f:28d8:0:b0:349:6247:e614 with SMTP id
 o207-20020a1f28d8000000b003496247e614mr8095209vko.38.1651734156856; Thu, 05
 May 2022 00:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
 <1b6ab66587cfef8574f38cafdd1796daf2a92346.camel@linux.intel.com>
In-Reply-To: <1b6ab66587cfef8574f38cafdd1796daf2a92346.camel@linux.intel.com>
From:   Wei Xu <weixugc@google.com>
Date:   Thu, 5 May 2022 00:02:25 -0700
Message-ID: <CAAPL-u93P1FmM6+TvKDAKuqbUaTBouswqw7uQhvommMEP1-oVg@mail.gmail.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Yang Shi <shy828301@gmail.com>, Linux MM <linux-mm@kvack.org>,
        Greg Thelen <gthelen@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michal Hocko <mhocko@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Feng Tang <feng.tang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
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

On Tue, May 3, 2022 at 12:12 PM Tim Chen <tim.c.chen@linux.intel.com> wrote:
>
> On Fri, 2022-04-29 at 19:10 -0700, Wei Xu wrote:
> > The current kernel has the basic memory tiering support: Inactive
> > pages on a higher tier NUMA node can be migrated (demoted) to a lower
> > tier NUMA node to make room for new allocations on the higher tier
> > NUMA node.  Frequently accessed pages on a lower tier NUMA node can be
> > migrated (promoted) to a higher tier NUMA node to improve the
> > performance.
> >
> > A tiering relationship between NUMA nodes in the form of demotion path
> > is created during the kernel initialization and updated when a NUMA
> > node is hot-added or hot-removed.  The current implementation puts all
> > nodes with CPU into the top tier, and then builds the tiering hierarchy
> > tier-by-tier by establishing the per-node demotion targets based on
> > the distances between nodes.
>
> Thanks for making this proposal.  It has many of the elements needed
> for the tiering support.
>
> >
> > The current memory tiering interface needs to be improved to address
> > several important use cases:
> >
> > * The current tiering initialization code always initializes
> >   each memory-only NUMA node into a lower tier.  But a memory-only
> >   NUMA node may have a high performance memory device (e.g. a DRAM
> >   device attached via CXL.mem or a DRAM-backed memory-only node on
> >   a virtual machine) and should be put into the top tier.
> >
> > * The current tiering hierarchy always puts CPU nodes into the top
> >   tier. But on a system with HBM (e.g. GPU memory) devices, these
> >   memory-only HBM NUMA nodes should be in the top tier, and DRAM nodes
> >   with CPUs are better to be placed into the next lower tier.
> >
> > * Also because the current tiering hierarchy always puts CPU nodes
> >   into the top tier, when a CPU is hot-added (or hot-removed) and
> >   triggers a memory node from CPU-less into a CPU node (or vice
> >   versa), the memory tiering hierarchy gets changed, even though no
> >   memory node is added or removed.  This can make the tiering
> >   hierarchy much less stable.
> >
> > * A higher tier node can only be demoted to selected nodes on the
> >   next lower tier, not any other node from the next lower tier.  This
> >   strict, hard-coded demotion order does not work in all use cases
> >   (e.g. some use cases may want to allow cross-socket demotion to
> >   another node in the same demotion tier as a fallback when the
> >   preferred demotion node is out of space), and has resulted in the
> >   feature request for an interface to override the system-wide,
> >   per-node demotion order from the userspace.
> >
> > * There are no interfaces for the userspace to learn about the memory
> >   tiering hierarchy in order to optimize its memory allocations.
> >
> > I'd like to propose revised memory tiering kernel interfaces based on
> > the discussions in the threads:
> >
> > - https://lore.kernel.org/lkml/20220425201728.5kzm4seu7rep7ndr@offworld/T/
> > - https://lore.kernel.org/linux-mm/20220426114300.00003ad8@Huawei.com/t/
> >
> >
> > Sysfs Interfaces
> > ================
> >
> > * /sys/devices/system/node/memory_tiers
> >
> >   Format: node list (one tier per line, in the tier order)
> >
> >   When read, list memory nodes by tiers.
> >
> >   When written (one tier per line), take the user-provided node-tier
> >   assignment as the new tiering hierarchy and rebuild the per-node
> >   demotion order.  It is allowed to only override the top tiers, in
> >   which cases, the kernel will establish the lower tiers automatically.
> >
> >
> > Kernel Representation
> > =====================
> >
> > * nodemask_t node_states[N_TOPTIER_MEMORY]
> >
> >   Store all top-tier memory nodes.
> >
> > * nodemask_t memory_tiers[MAX_TIERS]
> >
> >   Store memory nodes by tiers.
> >
> > * struct demotion_nodes node_demotion[]
> >
> >   where: struct demotion_nodes { nodemask_t preferred; nodemask_t allowed; }
> >
> >   For a node N:
> >
> >   node_demotion[N].preferred lists all preferred demotion targets;
> >
> >   node_demotion[N].allowed lists all allowed demotion targets
> >   (initialized to be all the nodes in the same demotion tier).
> >
>
> I assume that the preferred list is auto-configured/initialized based on
> NUMA distances.  Not sure why "allowed" list is only to the same demotion
> tier?  For example, I think the default should be tier 0 should
> is allowed to demote to tier 1 and tier 2, not just to tier 1.  So if we
> fail to demote to tier 1, we can demote to tier 2.

I agree that we can allow demotion to go to all the lower tiers, not
just the immediate next tier.  I have mentioned the same idea as well
when replying to Dan's comments.

> Do you also expose the demotion preferred node and allowed
> list via /sys/devices/system/node/memory_tiers, as you have done in the examples?

To keep the memory tier sysfs minimal for now, I didn't propose
exposing the demotion preferred/allowed list in
/sys/devices/system/node/memory_tiers.  But now I can see that in the
way that the examples were presented, N_TOPTIER_MEMORY and
node_demotion[] can be thought as part of the memory_tiers output,
which is not the intention.

> > Examples
> > ========
> >
> > * Example 2:
> >   Node 0 & 1 are DRAM nodes.
> >   Node 2 is a PMEM node and closer to node 0.
> >
> >   Node 0 has node 2 as the preferred and only demotion target.
> >
> >   Node 1 has no preferred demotion target, but can still demote
> >   to node 2.
> >
> >   Set mempolicy to prevent cross-socket demotion and memory access,
> >   e.g. cpuset.mems=0,2
>
> Do we expect to later allow configuration of the demotion list explicitly?
> Something like:
>
> echo "demotion 0 1 1-3" > /sys/devices/system/node/memory_tiers
>
> to set demotion list for node 0, where preferred demote node is 1,
> allowed demote node list is 1-3.

IMHO, we'd better follow the allocation fallback order for the
demotion node order in each tier and avoid userspace override of
per-node demotion list.

In general, I think we'd better keep the tier assignment of each node
stable.  If adding/changing one node can redefine the tiers of other
nodes, it can make tier-based memory accounting very difficult.
Overriding the per-node demotion list can have such undesirable side
effects (if the per-node demotion list is used to redefine tiers).

> Thanks.
>
> Tim
>
>
