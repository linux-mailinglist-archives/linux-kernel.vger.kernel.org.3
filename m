Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6692F516917
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 03:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356288AbiEBBHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 21:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbiEBBHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 21:07:34 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC453AA49
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 18:04:06 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id w5-20020a17090aaf8500b001d74c754128so14972897pjq.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 18:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=FuWLGbnADKrl4A1syPhPXKuQOu6m8jQIYMoHCl1Ol1o=;
        b=Rb7AelR2nkOQeVv31XJPbDhPfFWtYn1uIfa+g1dbFP2YVGuObIDgW5JKE0WU2RQ26u
         /hxKFjcu5c+K2sdCeq0OkLG+0fngV3qtSCiwHx8b53HyIIyZOZQFvbAKKw08W5oMKCAl
         MdiQZvb2K6MyaE150H2qO7cWj5nsg61VYevhiD0QH1xeEMXKBtlUvUACurBLM4lcftQR
         4pIVP8hYEdzt5LXjzZjloRGH3dCMfMOLDdtgODgr9/XEwEFg2vSZj1HETGCTAmove6G+
         DfWNQrhqtcKJAHGZkgsCeGV0uULi7kgP6+r9MZSLS0Du6REDbCgtct6N8n93kdorQlmP
         +hRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=FuWLGbnADKrl4A1syPhPXKuQOu6m8jQIYMoHCl1Ol1o=;
        b=1uwxoYDvQ73Lkks0TRQqlet5IwFSf+57QE8tRG5nBdYNpe2yQ+KgxKulNDagiaaVmw
         6PV02SpGV5yx8/ahdCfmvYb5RZx6BozB3G8wYmBnAWEDunSbzUgkeCMI4QENz2IzZy6q
         8pMmDeYd77Yhavx73G3hhUFKjdvfMEeAojV09ggtFEZkHpXXSJudc8P5CdRRcy5Kr8ny
         2fJWNo4cPGQLHR0SJiEloZSnHfz0KePRLyhNcG9cGtuTfOLAIig3qhYQ2YHwBJmwOEcF
         P2QyNCuBobyq3QZccYscbbZrYeOMo4QAbl4Pr8dDlmLQMR61ZqXkSOQtf2PljP3d7344
         81lQ==
X-Gm-Message-State: AOAM530k5glEk75LyAHv6mTnW3uv7bPuLG395xOMxTHsmhqhHVSzkBCA
        hyBwEC4gO09R4d6e209QospH1A==
X-Google-Smtp-Source: ABdhPJyD2UoMHfENDkkp1YeWcSmn9t2AcMxPzhx0iLqv54pJl+i+LVY1hPfF8VZLXwmv4cmWJFBMrA==
X-Received: by 2002:a17:90a:1946:b0:1d2:d49b:1db with SMTP id 6-20020a17090a194600b001d2d49b01dbmr15705389pjh.30.1651453446106;
        Sun, 01 May 2022 18:04:06 -0700 (PDT)
Received: from [2620:15c:29:204:e310:ef81:d548:9992] ([2620:15c:29:204:e310:ef81:d548:9992])
        by smtp.gmail.com with ESMTPSA id y1-20020a1709027c8100b0015e8d4eb29bsm3423635pll.229.2022.05.01.18.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 18:04:05 -0700 (PDT)
Date:   Sun, 1 May 2022 18:04:05 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Yuanchu Xie <yuanchu@google.com>
cc:     Wei Xu <weixugc@google.com>,
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
Subject: Re: RFC: Memory Tiering Kernel Interfaces
In-Reply-To: <20220501175813.tvytoosygtqlh3nn@offworld>
Message-ID: <69d7a550-737-9324-b092-97d72487e7dc@google.com>
References: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com> <20220501175813.tvytoosygtqlh3nn@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Sun, 1 May 2022, Davidlohr Bueso wrote:

> Nice summary, thanks. I don't know who of the interested parties will be
> at lsfmm, but fyi we have a couple of sessions on memory tiering Tuesday
> at 14:00 and 15:00.
> 
> On Fri, 29 Apr 2022, Wei Xu wrote:
> 
> > The current kernel has the basic memory tiering support: Inactive
> > pages on a higher tier NUMA node can be migrated (demoted) to a lower
> > tier NUMA node to make room for new allocations on the higher tier
> > NUMA node.  Frequently accessed pages on a lower tier NUMA node can be
> > migrated (promoted) to a higher tier NUMA node to improve the
> > performance.
> 
> Regardless of the promotion algorithm, at some point I see the NUMA hinting
> fault mechanism being in the way of performance. It would be nice if hardware
> began giving us page "heatmaps" instead of having to rely on faulting or
> sampling based ways to identify hot memory.
> 

Hi Davidlohr,

I tend to agree with this and we've been discussing potential hardware 
assistance for page heatmaps as well, but not as an extension of sampling 
techniques that rely on the page table Accessed bit.

Have you thought about what hardware could give us here that would allow 
us to identify the set of hottest (or coldest) pages over a range so that 
we don't need to iterate through it?

Adding Yuanchu Xie <yuanchu@google.com> who has been looking into this 
recently.

> > A tiering relationship between NUMA nodes in the form of demotion path
> > is created during the kernel initialization and updated when a NUMA
> > node is hot-added or hot-removed.  The current implementation puts all
> > nodes with CPU into the top tier, and then builds the tiering hierarchy
> > tier-by-tier by establishing the per-node demotion targets based on
> > the distances between nodes.
> > 
> > The current memory tiering interface needs to be improved to address
> > several important use cases:
> > 
> > * The current tiering initialization code always initializes
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
> > Tiering Hierarchy Initialization
> > ================================
> > 
> > By default, all memory nodes are in the top tier (N_TOPTIER_MEMORY).
> > 
> > A device driver can remove its memory nodes from the top tier, e.g.
> > a dax driver can remove PMEM nodes from the top tier.
> > 
> > The kernel builds the memory tiering hierarchy and per-node demotion
> > order tier-by-tier starting from N_TOPTIER_MEMORY.  For a node N, the
> > best distance nodes in the next lower tier are assigned to
> > node_demotion[N].preferred and all the nodes in the next lower tier
> > are assigned to node_demotion[N].allowed.
> > 
> > node_demotion[N].preferred can be empty if no preferred demotion node
> > is available for node N.
> 
> Upon cases where there more than one possible demotion node (with equal
> cost), I'm wondering if we want to do something better than choosing
> randomly, like we do now - perhaps round robin? Of course anything
> like this will require actual performance data, something I have seen
> very little of.
> 
> > Memory tiering hierarchy is rebuilt upon hot-add or hot-remove of a
> > memory node, but is NOT rebuilt upon hot-add or hot-remove of a CPU
> > node.
> 
> I think this makes sense.
> 
> Thanks,
> Davidlohr
> 
> 
