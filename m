Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F179050FB59
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346100AbiDZKtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345013AbiDZKsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:48:41 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661F0E09C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 03:43:04 -0700 (PDT)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KndfG6FKfz6F98k;
        Tue, 26 Apr 2022 18:39:02 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 12:43:02 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 11:43:01 +0100
Date:   Tue, 26 Apr 2022 11:43:00 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
CC:     Jagdish Gediya <jvgediya@linux.ibm.com>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <baolin.wang@linux.alibaba.com>,
        <dave.hansen@linux.intel.com>, <shy828301@gmail.com>,
        <weixugc@google.com>, <gthelen@google.com>,
        <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 0/7] mm: demotion: Introduce new node state
 N_DEMOTION_TARGETS
Message-ID: <20220426114300.00003ad8@Huawei.com>
In-Reply-To: <8a8d14ca-0976-41cc-02cb-dd1680fa37ef@linux.ibm.com>
References: <20220422195516.10769-1-jvgediya@linux.ibm.com>
        <4b986b46afb2fe888c127d8758221d0f0d3ec55f.camel@intel.com>
        <YmaC2jw6WaQ4X+8W@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
        <20220425145735.000007ca@Huawei.com>
        <8a8d14ca-0976-41cc-02cb-dd1680fa37ef@linux.ibm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml731-chm.china.huawei.com (10.201.108.82) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2022 20:14:58 +0530
Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> wrote:

> On 4/25/22 7:27 PM, Jonathan Cameron wrote:
> > On Mon, 25 Apr 2022 16:45:38 +0530
> > Jagdish Gediya <jvgediya@linux.ibm.com> wrote:
> >   
> >> On Sun, Apr 24, 2022 at 11:19:53AM +0800, ying.huang@intel.com wrote:  
> >>> On Sat, 2022-04-23 at 01:25 +0530, Jagdish Gediya wrote:  
> >>>> Some systems(e.g. PowerVM) can have both DRAM(fast memory) only
> >>>> NUMA node which are N_MEMORY and slow memory(persistent memory)
> >>>> only NUMA node which are also N_MEMORY. As the current demotion
> >>>> target finding algorithm works based on N_MEMORY and best distance,
> >>>> it will choose DRAM only NUMA node as demotion target instead of
> >>>> persistent memory node on such systems. If DRAM only NUMA node is
> >>>> filled with demoted pages then at some point new allocations can
> >>>> start falling to persistent memory, so basically cold pages are in
> >>>> fast memor (due to demotion) and new pages are in slow memory, this
> >>>> is why persistent memory nodes should be utilized for demotion and
> >>>> dram node should be avoided for demotion so that they can be used
> >>>> for new allocations.
> >>>>
> >>>> Current implementation can work fine on the system where the memory
> >>>> only numa nodes are possible only for persistent/slow memory but it
> >>>> is not suitable for the like of systems mentioned above.  
> >>>
> >>> Can you share the NUMA topology information of your machine?  And the
> >>> demotion order before and after your change?
> >>>
> >>> Whether it's good to use the PMEM nodes as the demotion targets of the
> >>> DRAM-only node too?  
> >>
> >> $ numactl -H
> >> available: 2 nodes (0-1)
> >> node 0 cpus: 0 1 2 3 4 5 6 7
> >> node 0 size: 14272 MB
> >> node 0 free: 13392 MB
> >> node 1 cpus:
> >> node 1 size: 2028 MB
> >> node 1 free: 1971 MB
> >> node distances:
> >> node   0   1
> >>    0:  10  40
> >>    1:  40  10
> >>
> >> 1) without N_DEMOTION_TARGETS patch series, 1 is demotion target
> >>     for 0 even when 1 is DRAM node and there is no demotion targets for 1.  
> > 
> > I'm not convinced the distinction between DRAM and persistent memory is
> > valid. There will definitely be systems with a large pool
> > of remote DRAM (and potentially no NV memory) where the right choice
> > is to demote to that DRAM pool.
> > 
> > Basing the decision on whether the memory is from kmem or
> > normal DRAM doesn't provide sufficient information to make the decision.
> >   
> 
> Hence the suggestion for the ability to override this from userspace. 
> Now, for example, we could build a system with memory from the remote 
> machine (memory inception in case of power which will mostly be plugged 
> in as regular hotpluggable memory ) and a slow CXL memory or OpenCAPI 
> memory.
> 
> In the former case, we won't consider that for demotion with this series 
> because that is not instantiated via dax kmem. So yes definitely we 
> would need the ability to override this from userspace so that we could 
> put these remote memory NUMA nodes as demotion targets if we want.


Agreed.  I would like to have a better 'guess' at the right default
though if possible.  With hindsight my instinct would have been to
have a default of no demotion path at all and hence ensure distros will carry
appropriate userspace setup scripts.  Ah well, too late :)

> 
> >>
> >> $ cat /sys/bus/nd/devices/dax0.0/target_node
> >> 2
> >> $
> >> # cd /sys/bus/dax/drivers/
> >> :/sys/bus/dax/drivers# ls
> >> device_dax  kmem
> >> :/sys/bus/dax/drivers# cd device_dax/
> >> :/sys/bus/dax/drivers/device_dax# echo dax0.0 > unbind
> >> :/sys/bus/dax/drivers/device_dax# echo dax0.0 >  ../kmem/new_id
> >> :/sys/bus/dax/drivers/device_dax# numactl -H
> >> available: 3 nodes (0-2)
> >> node 0 cpus: 0 1 2 3 4 5 6 7
> >> node 0 size: 14272 MB
> >> node 0 free: 13380 MB
> >> node 1 cpus:
> >> node 1 size: 2028 MB
> >> node 1 free: 1961 MB
> >> node 2 cpus:
> >> node 2 size: 0 MB
> >> node 2 free: 0 MB
> >> node distances:
> >> node   0   1   2
> >>    0:  10  40  80
> >>    1:  40  10  80
> >>    2:  80  80  10
> >>
> >> 2) Once this new node brought online,  without N_DEMOTION_TARGETS
> >> patch series, 1 is demotion target for 0 and 2 is demotion target
> >> for 1.
> >>
> >> With this patch series applied,
> >> 1) No demotion target for either 0 or 1 before dax device is online  
> > 
> > I'd argue that is wrong.  At this state you have a tiered memory system
> > be it one with just DRAM.  Using it as such is correct behavior that
> > we should not be preventing.  Sure some usecases wouldn't want that
> > arrangement but some do want it.
> > 
> > For your case we could add a heuristic along the lines of the demotion
> > target should be at least as big as the starting point but that would
> > be a bit hacky.
> >   
> 
> Hence the proposal to do a per node demotion target override with the 
> semantics that i explained here
> 
> 
> https://lore.kernel.org/linux-mm/8735i1zurt.fsf@linux.ibm.com/
> 
> Let me know if that interface would be good to handle all the possible 
> demotion target configs we would want to have.

At first glance it looks good to me.

Jonathan

> 
> -aneesh

