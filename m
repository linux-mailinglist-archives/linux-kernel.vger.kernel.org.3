Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C07517BD7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 04:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiECCKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 22:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiECCKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 22:10:02 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6E93B2AF
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 19:06:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0VC4XbVj_1651543583;
Received: from 30.39.210.51(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VC4XbVj_1651543583)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 03 May 2022 10:06:24 +0800
Message-ID: <87f8d4d0-6d06-7254-b2a6-3ccf6a555733@linux.alibaba.com>
Date:   Tue, 3 May 2022 10:07:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
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
        Brice Goglin <brice.goglin@gmail.com>,
        Feng Tang <feng.tang@intel.com>, Jonathan.Cameron@huawei.com
References: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
 <20220501175813.tvytoosygtqlh3nn@offworld>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20220501175813.tvytoosygtqlh3nn@offworld>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.5 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/2/2022 1:58 AM, Davidlohr Bueso wrote:
> Nice summary, thanks. I don't know who of the interested parties will be
> at lsfmm, but fyi we have a couple of sessions on memory tiering Tuesday
> at 14:00 and 15:00.
> 
> On Fri, 29 Apr 2022, Wei Xu wrote:
> 
>> The current kernel has the basic memory tiering support: Inactive
>> pages on a higher tier NUMA node can be migrated (demoted) to a lower
>> tier NUMA node to make room for new allocations on the higher tier
>> NUMA node.  Frequently accessed pages on a lower tier NUMA node can be
>> migrated (promoted) to a higher tier NUMA node to improve the
>> performance.
> 
> Regardless of the promotion algorithm, at some point I see the NUMA hinting
> fault mechanism being in the way of performance. It would be nice if 
> hardware
> began giving us page "heatmaps" instead of having to rely on faulting or
> sampling based ways to identify hot memory.
> 
>> A tiering relationship between NUMA nodes in the form of demotion path
>> is created during the kernel initialization and updated when a NUMA
>> node is hot-added or hot-removed.  The current implementation puts all
>> nodes with CPU into the top tier, and then builds the tiering hierarchy
>> tier-by-tier by establishing the per-node demotion targets based on
>> the distances between nodes.
>>
>> The current memory tiering interface needs to be improved to address
>> several important use cases:
>>
>> * The current tiering initialization code always initializes
>>  each memory-only NUMA node into a lower tier.  But a memory-only
>>  NUMA node may have a high performance memory device (e.g. a DRAM
>>  device attached via CXL.mem or a DRAM-backed memory-only node on
>>  a virtual machine) and should be put into the top tier.
> 
> At least the CXL memory (volatile or not) will still be slower than
> regular DRAM, so I think that we'd not want this to be top-tier. But
> in general, yes I agree that defining top tier as whether or not the
> node has a CPU a bit limiting, as you've detailed here.
> 
>> Tiering Hierarchy Initialization
>> ================================
>>
>> By default, all memory nodes are in the top tier (N_TOPTIER_MEMORY).
>>
>> A device driver can remove its memory nodes from the top tier, e.g.
>> a dax driver can remove PMEM nodes from the top tier.
>>
>> The kernel builds the memory tiering hierarchy and per-node demotion
>> order tier-by-tier starting from N_TOPTIER_MEMORY.  For a node N, the
>> best distance nodes in the next lower tier are assigned to
>> node_demotion[N].preferred and all the nodes in the next lower tier
>> are assigned to node_demotion[N].allowed.
>>
>> node_demotion[N].preferred can be empty if no preferred demotion node
>> is available for node N.
> 
> Upon cases where there more than one possible demotion node (with equal
> cost), I'm wondering if we want to do something better than choosing
> randomly, like we do now - perhaps round robin? Of course anything
> like this will require actual performance data, something I have seen
> very little of.

I've tried to use round robin[1] to select a target demotion node if 
there are multiple demotion nodes, however I did not see any obvious 
performance gain with mysql testing. Maybe use other test suits?

https://lore.kernel.org/all/c02bcbc04faa7a2c852534e9cd58a91c44494657.1636016609.git.baolin.wang@linux.alibaba.com/
