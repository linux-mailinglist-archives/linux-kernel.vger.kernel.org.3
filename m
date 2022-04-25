Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F4E50E282
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242298AbiDYOAr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 25 Apr 2022 10:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242296AbiDYOAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:00:44 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635DD7DE25
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:57:40 -0700 (PDT)
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Kn62m6ZBYz67VyR;
        Mon, 25 Apr 2022 21:54:56 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 15:57:37 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 14:57:37 +0100
Date:   Mon, 25 Apr 2022 14:57:35 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jagdish Gediya <jvgediya@linux.ibm.com>
CC:     "ying.huang@intel.com" <ying.huang@intel.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <baolin.wang@linux.alibaba.com>,
        <dave.hansen@linux.intel.com>, <aneesh.kumar@linux.ibm.com>,
        <shy828301@gmail.com>, <weixugc@google.com>, <gthelen@google.com>,
        <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 0/7] mm: demotion: Introduce new node state
 N_DEMOTION_TARGETS
Message-ID: <20220425145735.000007ca@Huawei.com>
In-Reply-To: <YmaC2jw6WaQ4X+8W@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
References: <20220422195516.10769-1-jvgediya@linux.ibm.com>
        <4b986b46afb2fe888c127d8758221d0f0d3ec55f.camel@intel.com>
        <YmaC2jw6WaQ4X+8W@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2022 16:45:38 +0530
Jagdish Gediya <jvgediya@linux.ibm.com> wrote:

> On Sun, Apr 24, 2022 at 11:19:53AM +0800, ying.huang@intel.com wrote:
> > On Sat, 2022-04-23 at 01:25 +0530, Jagdish Gediya wrote:  
> > > Some systems(e.g. PowerVM) can have both DRAM(fast memory) only
> > > NUMA node which are N_MEMORY and slow memory(persistent memory)
> > > only NUMA node which are also N_MEMORY. As the current demotion
> > > target finding algorithm works based on N_MEMORY and best distance,
> > > it will choose DRAM only NUMA node as demotion target instead of
> > > persistent memory node on such systems. If DRAM only NUMA node is
> > > filled with demoted pages then at some point new allocations can
> > > start falling to persistent memory, so basically cold pages are in
> > > fast memor (due to demotion) and new pages are in slow memory, this
> > > is why persistent memory nodes should be utilized for demotion and
> > > dram node should be avoided for demotion so that they can be used
> > > for new allocations.
> > > 
> > > Current implementation can work fine on the system where the memory
> > > only numa nodes are possible only for persistent/slow memory but it
> > > is not suitable for the like of systems mentioned above.  
> > 
> > Can you share the NUMA topology information of your machine?  And the
> > demotion order before and after your change?
> > 
> > Whether it's good to use the PMEM nodes as the demotion targets of the
> > DRAM-only node too?  
> 
> $ numactl -H
> available: 2 nodes (0-1)
> node 0 cpus: 0 1 2 3 4 5 6 7
> node 0 size: 14272 MB
> node 0 free: 13392 MB
> node 1 cpus:
> node 1 size: 2028 MB
> node 1 free: 1971 MB
> node distances:
> node   0   1
>   0:  10  40
>   1:  40  10
> 
> 1) without N_DEMOTION_TARGETS patch series, 1 is demotion target
>    for 0 even when 1 is DRAM node and there is no demotion targets for 1.

I'm not convinced the distinction between DRAM and persistent memory is
valid. There will definitely be systems with a large pool
of remote DRAM (and potentially no NV memory) where the right choice
is to demote to that DRAM pool.

Basing the decision on whether the memory is from kmem or
normal DRAM doesn't provide sufficient information to make the decision.

> 
> $ cat /sys/bus/nd/devices/dax0.0/target_node
> 2
> $
> # cd /sys/bus/dax/drivers/
> :/sys/bus/dax/drivers# ls
> device_dax  kmem
> :/sys/bus/dax/drivers# cd device_dax/
> :/sys/bus/dax/drivers/device_dax# echo dax0.0 > unbind
> :/sys/bus/dax/drivers/device_dax# echo dax0.0 >  ../kmem/new_id
> :/sys/bus/dax/drivers/device_dax# numactl -H
> available: 3 nodes (0-2)
> node 0 cpus: 0 1 2 3 4 5 6 7
> node 0 size: 14272 MB
> node 0 free: 13380 MB
> node 1 cpus:
> node 1 size: 2028 MB
> node 1 free: 1961 MB
> node 2 cpus:
> node 2 size: 0 MB
> node 2 free: 0 MB
> node distances:
> node   0   1   2
>   0:  10  40  80
>   1:  40  10  80
>   2:  80  80  10
> 
> 2) Once this new node brought online,  without N_DEMOTION_TARGETS
> patch series, 1 is demotion target for 0 and 2 is demotion target
> for 1.
> 
> With this patch series applied,
> 1) No demotion target for either 0 or 1 before dax device is online

I'd argue that is wrong.  At this state you have a tiered memory system
be it one with just DRAM.  Using it as such is correct behavior that
we should not be preventing.  Sure some usecases wouldn't want that
arrangement but some do want it.

For your case we could add a heuristic along the lines of the demotion
target should be at least as big as the starting point but that would
be a bit hacky.

Jonathan

> 2) 2 is demotion target for both 0 and 1 after dax device is online.
> 
> > Best Regards,
> > Huang, Ying
> >   
> > > This patch series introduces the new node state N_DEMOTION_TARGETS,
> > > which is used to distinguish the nodes which can be used as demotion
> > > targets, node_states[N_DEMOTION_TARGETS] is used to hold the list of
> > > nodes which can be used as demotion targets.
> > > 
> > > node state N_DEMOTION_TARGETS is also set from the dax kmem driver,
> > > certain type of memory which registers through dax kmem (e.g. HBM)
> > > may not be the right choices for demotion so in future they should
> > > be distinguished based on certain attributes and dax kmem driver
> > > should avoid setting them as N_DEMOTION_TARGETS, however current
> > > implementation also doesn't distinguish any  such memory and it
> > > considers all N_MEMORY as demotion targets so this patch series
> > > doesn't modify the current behavior.
> > > 
> > > below command can be used to view the available demotion targets in
> > > the system,
> > > 
> > > $ cat /sys/devices/system/node/demotion_targets
> > > 
> > > This patch series sets N_DEMOTION_TARGET from dax device kmem driver,
> > > It may be possible that some memory node desired as demotion target
> > > is not detected in the system from dax-device kmem probe path. It is
> > > also possible that some of the dax-devices are not preferred as
> > > demotion target e.g. HBM, for such devices, node shouldn't be set to
> > > N_DEMOTION_TARGETS, so support is also added to set the demotion
> > > target list from user space so that default behavior can be overridden
> > > to avoid or add specific node to demotion targets manually.
> > > 
> > > Override the demotion targets in the system (which sets the
> > > node_states[N_DEMOTION_TARGETS] in kernel),
> > > $ echo <node list> > /sys/devices/system/node/demotion_targets
> > > 
> > > As by default node attributes under /sys/devices/system/node/ are read-
> > > only, support is added to write node_states[] via sysfs so that
> > > node_states[N_DEMOTION_TARGETS] can be modified from user space via
> > > sysfs.
> > > 
> > > It is also helpful to know per node demotion target path prepared by
> > > kernel to understand the demotion behaviour during reclaim, so this
> > > patch series also adds a /sys/devices/system/node/nodeX/demotion_targets
> > > interface to view per-node demotion targets via sysfs.
> > > 
> > > Current code which sets migration targets is modified in
> > > this patch series to avoid some of the limitations on the demotion
> > > target sharing and to use N_DEMOTION_TARGETS only nodes while
> > > finding demotion targets.
> > > 
> > > Changelog
> > > ----------
> > > 
> > > v2:
> > > In v1, only 1st patch of this patch series was sent, which was
> > > implemented to avoid some of the limitations on the demotion
> > > target sharing, however for certain numa topology, the demotion
> > > targets found by that patch was not most optimal, so 1st patch
> > > in this series is modified according to suggestions from Huang
> > > and Baolin. Different examples of demotion list comparasion
> > > between existing implementation and changed implementation can
> > > be found in the commit message of 1st patch.
> > > 
> > > v3:
> > > - Modify patch 1 subject to make it more specific
> > > - Remove /sys/kernel/mm/numa/demotion_targets interface, use
> > >   /sys/devices/system/node/demotion_targets instead and make
> > >   it writable to override node_states[N_DEMOTION_TARGETS].
> > > - Add support to view per node demotion targets via sysfs
> > > 
> > > Jagdish Gediya (8):
> > >   mm: demotion: Fix demotion targets sharing among sources
> > >   mm: demotion: Add new node state N_DEMOTION_TARGETS
> > >   drivers/base/node: Add support to write node_states[] via sysfs
> > >   device-dax/kmem: Set node state as N_DEMOTION_TARGETS
> > >   mm: demotion: Build demotion list based on N_DEMOTION_TARGETS
> > >   mm: demotion: expose per-node demotion targets via sysfs
> > >   docs: numa: Add documentation for demotion
> > > 
> > >  Documentation/admin-guide/mm/index.rst        |  1 +
> > >  .../admin-guide/mm/numa_demotion.rst          | 57 +++++++++++++++
> > >  drivers/base/node.c                           | 70 ++++++++++++++++---
> > >  drivers/dax/kmem.c                            |  2 +
> > >  include/linux/migrate.h                       |  1 +
> > >  include/linux/nodemask.h                      |  1 +
> > >  mm/migrate.c                                  | 54 ++++++++++----
> > >  7 files changed, 162 insertions(+), 24 deletions(-)
> > >  create mode 100644 Documentation/admin-guide/mm/numa_demotion.rst
> > >   
> > 
> > 
> >   
> 

