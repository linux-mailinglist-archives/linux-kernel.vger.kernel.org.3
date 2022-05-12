Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C6F5242F6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 05:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244426AbiELDDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 23:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244326AbiELDCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 23:02:53 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BBC666B7
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 20:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652324572; x=1683860572;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SgptTZfZfGrbOw2WOs6Fg6V0ycj5dJurGQTzVvgHsWM=;
  b=CZVtz1Ne5O+Vv+d6c4wLm0Uadf0pKVviuA15GBbclcEFDGcHCAK0uh26
   SRelf94gBCddvEvRH1HMtA+q3QzmPTT1NJX3+Q3HOufvdVvZfrq6P0x9A
   sLlHZfAymwuIVlccwTitQ6bCpPmO38RPenDgzHKchwx8AgHqXiv6VEaHZ
   Bb0lcsTtt59Ac2rHxUNOsSP+pN/h5Kx3Ckuc9/xVKi29t/S5ZrLIJgS17
   Qx9lHHr3c5jw2IjZyxsHbmfUYc8whW18K3V546gaqi1Q8mXxFgSI33788
   Ma2U0284RV3OScNpoGY3BETbJzEUDf3ol6CpIpnUtjA9iIi4XIv4OfdEo
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="332911946"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="332911946"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 20:02:50 -0700
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="594449987"
Received: from ruonanwa-mobl.ccr.corp.intel.com ([10.254.212.157])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 20:02:46 -0700
Message-ID: <28e1f3861eb4d01ef914cd456f8de334b8beb719.camel@intel.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Hesham Almatary <hesham.almatary@huawei.com>,
        Alistair Popple <apopple@nvidia.com>
Cc:     Wei Xu <weixugc@google.com>,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Greg Thelen <gthelen@google.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michal Hocko <mhocko@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Feng Tang <feng.tang@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Date:   Thu, 12 May 2022 11:02:43 +0800
In-Reply-To: <20220511100527.00007bc2@huawei.com>
References: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
         <CAHbLzkq1YXXLMiREpGnzhJjPssu4WpSsnkTmrLJ=hAEhZVUr9w@mail.gmail.com>
         <CAAPL-u-r2Pc_MaHQmKKNH_icAa_fH1COWb5qSPpr8xffREQ_cQ@mail.gmail.com>
         <CAHbLzkrit3SDQUWPQ_RtTO_xFqxoqR9LpY=72afERapUgkjxZg@mail.gmail.com>
         <1642ab64-7957-e1e6-71c5-ceab9c23bf41@huawei.com>
         <CAHbLzkqBVdaT5wwPuCXUMb8DwLEzHPaQwCKXsjsPBRTgZAAgnw@mail.gmail.com>
         <c272e43d-47c5-d7d4-cb17-95dc6f28f5cd@huawei.com>
         <e1bf6346-fd93-13ee-0b38-c1d956df0e99@linux.ibm.com>
         <CAAPL-u-Q1_19TM-J-QD9QWXGcp6A9xJS126xO54H83u+c569Tg@mail.gmail.com>
         <87o804r08w.fsf@nvdebian.thelocal> <20220511100527.00007bc2@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-05-11 at 10:05 +0100, Hesham Almatary wrote:
> On Wed, 11 May 2022 17:12:34 +1000
> Alistair Popple <apopple@nvidia.com> wrote:
> 
> > 
> > Wei Xu <weixugc@google.com> writes:
> > 
> > > On Tue, May 10, 2022 at 5:10 AM Aneesh Kumar K V
> > > <aneesh.kumar@linux.ibm.com> wrote:
> > > > 
> > > > On 5/10/22 3:29 PM, Hesham Almatary wrote:
> > > > > Hello Yang,
> > > > > 
> > > > > On 5/10/2022 4:24 AM, Yang Shi wrote:
> > > > > > On Mon, May 9, 2022 at 7:32 AM Hesham Almatary
> > > > > > <hesham.almatary@huawei.com> wrote:
> > > > 
> > > > 
> > > > ...
> > > > 
> > > > > > > 
> > > > > > > node 0 has a CPU and DDR memory in tier 0, node 1 has GPU and
> > > > > > > DDR memory in tier 0,
> > > > > > > node 2 has NVMM memory in tier 1, node 3 has some sort of
> > > > > > > bigger memory (could be a bigger DDR or something) in tier 2.
> > > > > > > The distances are as follows:
> > > > > > > 
> > > > > > > --------------          --------------
> > > > > > > >   Node 0   |          |   Node 1   |
> > > > > > > >  -------   |          |  -------   |
> > > > > > > > >  DDR  |  |          | |  DDR  |  |
> > > > > > > >  -------   |          |  -------   |
> > > > > > > >            |          |            |
> > > > > > > --------------          --------------
> > > > > > >          | 20               | 120    |
> > > > > > >          v                  v        |
> > > > > > > ----------------------------       |
> > > > > > > > Node 2     PMEM          |       | 100
> > > > > > > ----------------------------       |
> > > > > > >          | 100                       |
> > > > > > >          v                           v
> > > > > > > --------------------------------------
> > > > > > > > Node 3    Large mem                |
> > > > > > > --------------------------------------
> > > > > > > 
> > > > > > > node distances:
> > > > > > > node   0    1    2    3
> > > > > > >      0  10   20   20  120
> > > > > > >      1  20   10  120  100
> > > > > > >      2  20  120   10  100
> > > > > > >      3  120 100  100   10
> > > > > > > 
> > > > > > > /sys/devices/system/node/memory_tiers
> > > > > > > 0-1
> > > > > > > 2
> > > > > > > 3
> > > > > > > 
> > > > > > > N_TOPTIER_MEMORY: 0-1
> > > > > > > 
> > > > > > > 
> > > > > > > In this case, we want to be able to "skip" the demotion path
> > > > > > > from Node 1 to Node 2,
> > > > > > > 
> > > > > > > and make demotion go directely to Node 3 as it is closer,
> > > > > > > distance wise. How can
> > > > > > > 
> > > > > > > we accommodate this scenario (or at least not rule it out as
> > > > > > > future work) with the
> > > > > > > 
> > > > > > > current RFC?
> > > > > > If I remember correctly NUMA distance is hardcoded in SLIT by
> > > > > > the firmware, it is supposed to reflect the latency. So I
> > > > > > suppose it is the firmware's responsibility to have correct
> > > > > > information. And the RFC assumes higher tier memory has better
> > > > > > performance than lower tier memory (latency, bandwidth,
> > > > > > throughput, etc), so it sounds like a buggy firmware to have
> > > > > > lower tier memory with shorter distance than higher tier memory
> > > > > > IMHO.
> > > > > 
> > > > > You are correct if you're assuming the topology is all
> > > > > hierarchically
> > > > > 
> > > > > symmetric, but unfortuantely, in real hardware (e.g., my example
> > > > > above)
> > > > > 
> > > > > it is not. The distance/latency between two nodes in the same
> > > > > tier
> > > > > 
> > > > > and a third node, is different. The firmware still provides the
> > > > > correct
> > > > > 
> > > > > latency, but putting a node in a tier is up to the kernel/user,
> > > > > and
> > > > > 
> > > > > is relative: e.g., Node 3 could belong to tier 1 from Node 1's
> > > > > 
> > > > > perspective, but to tier 2 from Node 0's.
> > > > > 
> > > > > 
> > > > > A more detailed example (building on my previous one) is when
> > > > > having
> > > > > 
> > > > > the GPU connected to a switch:
> > > > > 
> > > > > ----------------------------
> > > > > > Node 2     PMEM          |
> > > > > ----------------------------
> > > > >        ^
> > > > >        |
> > > > > --------------          --------------
> > > > > >   Node 0   |          |   Node 1   |
> > > > > >  -------   |          |  -------   |
> > > > > > >  DDR  |  |          | |  DDR  |  |
> > > > > >  -------   |          |  -------   |
> > > > > >    CPU     |          |    GPU     |
> > > > > --------------          --------------
> > > > >         |                  |
> > > > >         v                  v
> > > > > ----------------------------
> > > > > >         Switch           |
> > > > > ----------------------------
> > > > >         |
> > > > >         v
> > > > > --------------------------------------
> > > > > > Node 3    Large mem                |
> > > > > --------------------------------------
> > > > > 
> > > > > Here, demoting from Node 1 to Node 3 directly would be faster as
> > > > > 
> > > > > it only has to go through one hub, compared to demoting from
> > > > > Node 1
> > > > > 
> > > > > to Node 2, where it goes through two hubs. I hope that example
> > > > > 
> > > > > clarifies things a little bit.
> > > > > 
> > > > 
> > > > Alistair mentioned that we want to consider GPU memory to be
> > > > expensive and want to demote from GPU to regular DRAM. In that
> > > > case for the above case we should end up with
> > > > 
> > > > 
> > > > tier 0 - > Node3
> > > > tier 1 ->  Node0, Node1
> > > > tier 2 ->  Node2
> > 
> > I'm a little bit confused by the tiering here as I don't think it's
> > quite what we want. As pointed out GPU memory is expensive and
> > therefore we don't want anything demoting to it. That implies it
> > should be in the top tier:
> > 
> > tier 0 -> Node1
> > tier 1 -> Node0, Node3
> > tier 2 -> Node2
> > 
> > Hence:
> > 
> > node 0: allowed=2
> > node 1: allowed=0,3,2
> > node 2: allowed=empty
> > node 3: allowed=2
> > 
> > Alternatively Node3 could be put in tier 2 which would prevent
> > demotion to PMEM via the switch/CPU:
> > 
> > tier 0 -> Node1
> > tier 1 -> Node0
> > tier 2 -> Node2, Node3
> > 
> > node 0: allowed=2,3
> > node 1: allowed=0,3,2
> > node 2: allowed=empty
> > node 3: allowed=empty
> > 
> Indeed. The scenario I described here is where the GPU can't/don't
> demote to PMEM, but the CPU can. In this case it would work fine if we
> put the GPU (Node 1) in tier 0, and rely on the fallback order.
> 

We can also try to enforce this with NUMA policy and cpusets together
with memory tier.  We have not only one weapon.

Best Regards,
Huang, Ying

> > Both of these would be an improvement over the current situation
> > upstream, which demotes everything to GPU memory and doesn't support
> > demoting from the GPU (meaning reclaim on GPU memory pages everything
> > to disk).
> > 
> > > > 
> > > > Hence
> > > > 
> > > >   node 0: allowed=2
> > > >   node 1: allowed=2
> > > >   node 2: allowed = empty
> > > >   node 3: allowed = 0-1 , based on fallback order 1, 0
> > > 
> > > If we have 3 tiers as defined above, then we'd better to have:
> > > 
> > > node 0: allowed = 2
> > > node 1: allowed = 2
> > > node 2: allowed = empty
> > > node 3: allowed = 0-2, based on fallback order: 1,0,2
> > > 
> > > The firmware should provide the node distance values to reflect that
> > > PMEM is slowest and should have the largest distance away from node
> > > 3.
> > 
> > Right. In my above example firmware would have to provide reasonable
> > distance values to ensure optimal fallback order.
> > 
> > > > -aneesh
> > > > 
> > > > 
> 


