Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3877517D01
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 08:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiECGKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 02:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiECGKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 02:10:09 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70773336F
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 23:06:37 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id h144so7115979vkh.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 23:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=7N4xc/wMzuulecI04es1Ttu3ntRturBloFa549S0Y3Q=;
        b=NEVrVzg9Pe7LgLukiVkco8UDTV6L59oHrngUV4vIQi1UdW9T5lIL78M4V4Q8qQKIFJ
         DLHLChcTxDhzAcdGXIh5iSm1rZ7eJRQXd9My+REEAGmqWRKjHa2lyUXfN3+2N4UVX8Fq
         GeujgEZzSMb6mfbE2Wf/objpyHuRUunvrk/NmpQq9qySmCUdy7VVudW3tWxLPdB4zlwo
         S8V+p2TevVjqVcURU/nIg9m8fDH7xx7B/vg+nv5XR7UFULjcv7aWGiBl8oGFuVc1ZkqL
         voxnEbtK36gSGYTkwYM92/5J0q9xcferwd12sIh4tg08NKsnaQ2SoD7+ougi/LEF3T59
         56yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=7N4xc/wMzuulecI04es1Ttu3ntRturBloFa549S0Y3Q=;
        b=7PeyhJm2FyfB75edlLnpbMEu49zudWv+GWWuAczH0GG75R/PHl8d2DtOsUB9vPAHbt
         0SeX5K4Ca61ec7nIbtDiV+bdFPX3r1hxfeDSKg9HaSknn1jtdpNtnajW/oXG8P6M2S1j
         TUIrD+Wk20F+NVRwFGQcKvHpwPtWGNCTNHyWVis24toos4zodDmr4ZFkBJAhWdISeNT0
         z2BjJIufDYWVgbnikHSkBcMJ02qYbB9YuNqrD6x4JHyPTk+plQukx3MMBKVLg23lecdX
         rfDYcBziRC0VF7LKy8Z1o93p7twSNKnzsISUhnSAw4iUvd8/TcrQb5HLpzS+wB9A6fkp
         DXGQ==
X-Gm-Message-State: AOAM531eHHOvEfh5YN069ns8/GPW/vcjx1hyS6ZmnZjrdXruLmLZM39V
        fyyWlRlVJ3H1400J6pPMt2AJ76Bh7YyNBFU3O8rRGg==
X-Google-Smtp-Source: ABdhPJybo+d0kbBuduaYftUo3seNL4tZkqegmoofOoOd+SP9ml8MIN+ga2yGL+UEog18KotV0y6a+Lszzi+VSenrjx0=
X-Received: by 2002:a1f:9b85:0:b0:32d:4d56:cf64 with SMTP id
 d127-20020a1f9b85000000b0032d4d56cf64mr4410925vke.31.1651557996716; Mon, 02
 May 2022 23:06:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
 <20220501175813.tvytoosygtqlh3nn@offworld>
In-Reply-To: <20220501175813.tvytoosygtqlh3nn@offworld>
From:   Wei Xu <weixugc@google.com>
Date:   Mon, 2 May 2022 23:06:25 -0700
Message-ID: <CAAPL-u8i_wc15iJzU9s9V1YuuS+FQL2zdw3o7MqNnSFao3u4KA@mail.gmail.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces
To:     Wei Xu <weixugc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Yang Shi <shy828301@gmail.com>, Linux MM <linux-mm@kvack.org>,
        Greg Thelen <gthelen@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        Michal Hocko <mhocko@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Feng Tang <feng.tang@intel.com>, Jonathan.Cameron@huawei.com
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

On Sun, May 1, 2022 at 11:09 AM Davidlohr Bueso <dave@stgolabs.net> wrote:
>
> Nice summary, thanks. I don't know who of the interested parties will be
> at lsfmm, but fyi we have a couple of sessions on memory tiering Tuesday
> at 14:00 and 15:00.
>
> On Fri, 29 Apr 2022, Wei Xu wrote:
>
> >The current kernel has the basic memory tiering support: Inactive
> >pages on a higher tier NUMA node can be migrated (demoted) to a lower
> >tier NUMA node to make room for new allocations on the higher tier
> >NUMA node.  Frequently accessed pages on a lower tier NUMA node can be
> >migrated (promoted) to a higher tier NUMA node to improve the
> >performance.
>
> Regardless of the promotion algorithm, at some point I see the NUMA hinting
> fault mechanism being in the way of performance. It would be nice if hardware
> began giving us page "heatmaps" instead of having to rely on faulting or
> sampling based ways to identify hot memory.

I agree with your comments on both NUMA hinting faults and
hardware-assisted "heatmaps".


> >A tiering relationship between NUMA nodes in the form of demotion path
> >is created during the kernel initialization and updated when a NUMA
> >node is hot-added or hot-removed.  The current implementation puts all
> >nodes with CPU into the top tier, and then builds the tiering hierarchy
> >tier-by-tier by establishing the per-node demotion targets based on
> >the distances between nodes.
> >
> >The current memory tiering interface needs to be improved to address
> >several important use cases:
> >
> >* The current tiering initialization code always initializes
> >  each memory-only NUMA node into a lower tier.  But a memory-only
> >  NUMA node may have a high performance memory device (e.g. a DRAM
> >  device attached via CXL.mem or a DRAM-backed memory-only node on
> >  a virtual machine) and should be put into the top tier.
>
> At least the CXL memory (volatile or not) will still be slower than
> regular DRAM, so I think that we'd not want this to be top-tier. But
> in general, yes I agree that defining top tier as whether or not the
> node has a CPU a bit limiting, as you've detailed here.
>
> >Tiering Hierarchy Initialization
> >================================
> >
> >By default, all memory nodes are in the top tier (N_TOPTIER_MEMORY).
> >
> >A device driver can remove its memory nodes from the top tier, e.g.
> >a dax driver can remove PMEM nodes from the top tier.
> >
> >The kernel builds the memory tiering hierarchy and per-node demotion
> >order tier-by-tier starting from N_TOPTIER_MEMORY.  For a node N, the
> >best distance nodes in the next lower tier are assigned to
> >node_demotion[N].preferred and all the nodes in the next lower tier
> >are assigned to node_demotion[N].allowed.
> >
> >node_demotion[N].preferred can be empty if no preferred demotion node
> >is available for node N.
>
> Upon cases where there more than one possible demotion node (with equal
> cost), I'm wondering if we want to do something better than choosing
> randomly, like we do now - perhaps round robin? Of course anything
> like this will require actual performance data, something I have seen
> very little of.

I'd prefer that the demotion node selection follows the way how the
kernel selects the node/zone for normal allocations.  If we want to
group several demotion nodes with equal cost together (e.g. to better
utilize the bandwidth from these nodes), we'd better to improve such
an optimization in __alloc_pages_nodemask() to benefit normal
allocations as well.

> >Memory tiering hierarchy is rebuilt upon hot-add or hot-remove of a
> >memory node, but is NOT rebuilt upon hot-add or hot-remove of a CPU
> >node.
>
> I think this makes sense.
>
> Thanks,
> Davidlohr
