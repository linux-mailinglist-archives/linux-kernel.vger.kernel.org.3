Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FF651F9A4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbiEIKUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 06:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbiEIKTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 06:19:54 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164C8142808;
        Mon,  9 May 2022 03:15:59 -0700 (PDT)
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KxcQD3J50z67mYl;
        Mon,  9 May 2022 18:11:16 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 9 May 2022 12:15:56 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 11:15:54 +0100
Date:   Mon, 9 May 2022 11:15:53 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
CC:     Barry Song <21cnbao@gmail.com>, <bp@alien8.de>,
        <catalin.marinas@arm.com>, <dietmar.eggemann@arm.com>,
        <gregkh@linuxfoundation.org>, <hpa@zytor.com>,
        <juri.lelli@redhat.com>, <bristot@redhat.com>, <lenb@kernel.org>,
        <mgorman@suse.de>, <mingo@redhat.com>, <peterz@infradead.org>,
        <rjw@rjwysocki.net>, <sudeep.holla@arm.com>, <tglx@linutronix.de>,
        <aubrey.li@linux.intel.com>, <bsegall@google.com>,
        <guodong.xu@linaro.org>, <liguozhu@hisilicon.com>,
        <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>,
        <msys.mizuma@gmail.com>, <prime.zeng@hisilicon.com>,
        <rostedt@goodmis.org>, <tim.c.chen@linux.intel.com>,
        <valentin.schneider@arm.com>, <vincent.guittot@linaro.org>,
        <will@kernel.org>, <x86@kernel.org>, <xuwei5@huawei.com>,
        <yangyicong@huawei.com>, <linuxarm@huawei.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        "Darren Hart" <darren@os.amperecomputing.com>
Subject: Re: [BUG] Re: [PATCH 1/3] topology: Represent clusters of CPUs
 within a die
Message-ID: <20220509111553.0000266d@Huawei.com>
In-Reply-To: <65da3fc4-46b4-c6ee-c84f-3fb5a7f917ab@arm.com>
References: <20210820013008.12881-1-21cnbao@gmail.com>
        <20210820013008.12881-2-21cnbao@gmail.com>
        <65da3fc4-46b4-c6ee-c84f-3fb5a7f917ab@arm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml747-chm.china.huawei.com (10.201.108.197) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 May 2022 15:24:27 -0500
Jeremy Linton <jeremy.linton@arm.com> wrote:

> Hi,
> 
> It seems this set is:
> 
> "BUG: arch topology borken"
>                     ^code
> 
> on machines that don't actually have clusters, or provide a 
> representation which might be taken for a cluster. The Ampere Altra for 
> one. So, I guess its my job to relay what I was informed of when I 
> intially proposed something similar a few years back.
> 
> Neither the ACPI/PPTT spec nor the Arm architectural spec mandate the 
> concept of a "cluster" particularly in the form of a system with cores 
> sharing the L2, which IIRC is the case for the Kunpeng.

It is not. Kunpeng 920 shares l3 tag cache, but not l2 cache (which is
private for each core).
As such the existence of a cluster is not distinguished by sharing
of any cache resources that are in PPTT.  There is an argument for potentially
adding more types of resource to PPTT to give a richer description.

Whilst ACPI doesn't mandate a cluster (there is an example, though that happens
to have L3 shared across the cluster), it does allow for addition
hierarchy description. Cluster is just a name for such an extra level.

> And it tends to 
> be a shared L2 which gives the most bang for the buck (or was when I was 
> testing/benchmarking all this, on aarch64) from scheduler changes which 
> create cluster level scheduling domains.
> But OTOH, things like specJBB 
> didn't really like those smaller MC levels (which I suspect is hurt by 
> this change, without running a full benchmark suite, especially on 
> something like the above ampere, given what is happening to its 
> scheduling domains).
> 
> So, the one takeway I can give is this, the code below which is 
> attempting to create a cluster level should be a bit more intellegent 
> about whether there is an actual cluster.

I agree that more intelligence is needed, though I think that belongs
in the interpretation of the cluster level.  This particular patch
should present that information in a consistent fashion.  My understanding
is it is consistent with how other levels have been presented in that
it's perfectly acceptable to have multiple levels that can be collapsed
by the users of the description. (perhaps I'm wrong on that?)

> A first order approximation 
> might be adding a check to see if the node immediatly above the CPU 
> contains an L2 and that its shared. 

That rules out our clusters, so not a great starting point :)

Darren Hart's recent set for Ampere Altra is fixing a different combination
but is in some sense similar in that it corrects an assumption that turned
out to be false in the user of the topology description whilst leaving the
description alone.

> A better fix, of course is the 
> reason this wasn't previously done, and that is to convince the ACPI 
> commitee to standardize a CLUSTER level flag which could be utilized by 
> a firmware/machine manufactuer to decide whether cluster level 
> scheduling provides an advantage and simply not do it on machines which 
> don't flag CLUSTER levels because its not avantagious.

While I obviously can't predict discussions in ASWG, my gut feeling
is that would be a non starter with questions along the lines of:

1) Why is this level special? The spec already defines a hierarchical
   description with caches described at each level, so you can infer
   what is intended.  If we define cluster, we'll also need to define
   super cluster (we have designs with super clusters and it's only going
   to get worse as systems continue to get bigger.)
2) If an architecture does not share resources at a given level that will
   have significant impact on scheduling decisions, don't present the
   level.  So if no advantage has seen, what is it doing there?

Thanks

Jonathan

> 
> 
> Thanks,
> 
> 
> 
> On 8/19/21 20:30, Barry Song wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Both ACPI and DT provide the ability to describe additional layers of
> > topology between that of individual cores and higher level constructs
> > such as the level at which the last level cache is shared.
> > In ACPI this can be represented in PPTT as a Processor Hierarchy
> > Node Structure [1] that is the parent of the CPU cores and in turn
> > has a parent Processor Hierarchy Nodes Structure representing
> > a higher level of topology.
> > 
> > For example Kunpeng 920 has 6 or 8 clusters in each NUMA node, and each
> > cluster has 4 cpus. All clusters share L3 cache data, but each cluster
> > has local L3 tag. On the other hand, each clusters will share some
> > internal system bus.
> > 
> > +-----------------------------------+                          +---------+
> > |  +------+    +------+            +---------------------------+         |
> > |  | CPU0 |    | cpu1 |             |    +-----------+         |         |
> > |  +------+    +------+             |    |           |         |         |
> > |                                   +----+    L3     |         |         |
> > |  +------+    +------+   cluster   |    |    tag    |         |         |
> > |  | CPU2 |    | CPU3 |             |    |           |         |         |
> > |  +------+    +------+             |    +-----------+         |         |
> > |                                   |                          |         |
> > +-----------------------------------+                          |         |
> > +-----------------------------------+                          |         |
> > |  +------+    +------+             +--------------------------+         |
> > |  |      |    |      |             |    +-----------+         |         |
> > |  +------+    +------+             |    |           |         |         |
> > |                                   |    |    L3     |         |         |
> > |  +------+    +------+             +----+    tag    |         |         |
> > |  |      |    |      |             |    |           |         |         |
> > |  +------+    +------+             |    +-----------+         |         |
> > |                                   |                          |         |
> > +-----------------------------------+                          |   L3    |
> >                                                                 |   data  |
> > +-----------------------------------+                          |         |
> > |  +------+    +------+             |    +-----------+         |         |
> > |  |      |    |      |             |    |           |         |         |
> > |  +------+    +------+             +----+    L3     |         |         |
> > |                                   |    |    tag    |         |         |
> > |  +------+    +------+             |    |           |         |         |
> > |  |      |    |      |            ++    +-----------+         |         |
> > |  +------+    +------+            |---------------------------+         |
> > +-----------------------------------|                          |         |
> > +-----------------------------------|                          |         |
> > |  +------+    +------+            +---------------------------+         |
> > |  |      |    |      |             |    +-----------+         |         |
> > |  +------+    +------+             |    |           |         |         |
> > |                                   +----+    L3     |         |         |
> > |  +------+    +------+             |    |    tag    |         |         |
> > |  |      |    |      |             |    |           |         |         |
> > |  +------+    +------+             |    +-----------+         |         |
> > |                                   |                          |         |
> > +-----------------------------------+                          |         |
> > +-----------------------------------+                          |         |
> > |  +------+    +------+             +--------------------------+         |
> > |  |      |    |      |             |   +-----------+          |         |
> > |  +------+    +------+             |   |           |          |         |
> > |                                   |   |    L3     |          |         |
> > |  +------+    +------+             +---+    tag    |          |         |
> > |  |      |    |      |             |   |           |          |         |
> > |  +------+    +------+             |   +-----------+          |         |
> > |                                   |                          |         |
> > +-----------------------------------+                          |         |
> > +-----------------------------------+                         ++         |
> > |  +------+    +------+             +--------------------------+         |
> > |  |      |    |      |             |  +-----------+           |         |
> > |  +------+    +------+             |  |           |           |         |
> > |                                   |  |    L3     |           |         |
> > |  +------+    +------+             +--+    tag    |           |         |
> > |  |      |    |      |             |  |           |           |         |
> > |  +------+    +------+             |  +-----------+           |         |
> > |                                   |                          +---------+
> > +-----------------------------------+
> > 
> > That means spreading tasks among clusters will bring more bandwidth
> > while packing tasks within one cluster will lead to smaller cache
> > synchronization latency. So both kernel and userspace will have
> > a chance to leverage this topology to deploy tasks accordingly to
> > achieve either smaller cache latency within one cluster or an even
> > distribution of load among clusters for higher throughput.
> > 
> > This patch exposes cluster topology to both kernel and userspace.
> > Libraried like hwloc will know cluster by cluster_cpus and related
> > sysfs attributes. PoC of HWLOC support at [2].
> > 
> > Note this patch only handle the ACPI case.
> > 
> > Special consideration is needed for SMT processors, where it is
> > necessary to move 2 levels up the hierarchy from the leaf nodes
> > (thus skipping the processor core level).
> > 
> > Note that arm64 / ACPI does not provide any means of identifying
> > a die level in the topology but that may be unrelate to the cluster
> > level.
> > 
> > [1] ACPI Specification 6.3 - section 5.2.29.1 processor hierarchy node
> >      structure (Type 0)
> > [2] https://github.com/hisilicon/hwloc/tree/linux-cluster
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> > Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> > ---
> >   .../ABI/stable/sysfs-devices-system-cpu       | 15 +++++
> >   Documentation/admin-guide/cputopology.rst     | 12 ++--
> >   arch/arm64/kernel/topology.c                  |  2 +
> >   drivers/acpi/pptt.c                           | 67 +++++++++++++++++++
> >   drivers/base/arch_topology.c                  | 14 ++++
> >   drivers/base/topology.c                       | 10 +++
> >   include/linux/acpi.h                          |  5 ++
> >   include/linux/arch_topology.h                 |  5 ++
> >   include/linux/topology.h                      |  6 ++
> >   9 files changed, 132 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/ABI/stable/sysfs-devices-system-cpu b/Documentation/ABI/stable/sysfs-devices-system-cpu
> > index 516dafea03eb..3965ce504484 100644
> > --- a/Documentation/ABI/stable/sysfs-devices-system-cpu
> > +++ b/Documentation/ABI/stable/sysfs-devices-system-cpu
> > @@ -42,6 +42,12 @@ Description:    the CPU core ID of cpuX. Typically it is the hardware platform's
> >                   architecture and platform dependent.
> >   Values:         integer
> >   
> > +What:           /sys/devices/system/cpu/cpuX/topology/cluster_id
> > +Description:    the cluster ID of cpuX.  Typically it is the hardware platform's
> > +                identifier (rather than the kernel's). The actual value is
> > +                architecture and platform dependent.
> > +Values:         integer
> > +
> >   What:           /sys/devices/system/cpu/cpuX/topology/book_id
> >   Description:    the book ID of cpuX. Typically it is the hardware platform's
> >                   identifier (rather than the kernel's). The actual value is
> > @@ -85,6 +91,15 @@ Description:    human-readable list of CPUs within the same die.
> >                   The format is like 0-3, 8-11, 14,17.
> >   Values:         decimal list.
> >   
> > +What:           /sys/devices/system/cpu/cpuX/topology/cluster_cpus
> > +Description:    internal kernel map of CPUs within the same cluster.
> > +Values:         hexadecimal bitmask.
> > +
> > +What:           /sys/devices/system/cpu/cpuX/topology/cluster_cpus_list
> > +Description:    human-readable list of CPUs within the same cluster.
> > +                The format is like 0-3, 8-11, 14,17.
> > +Values:         decimal list.
> > +
> >   What:           /sys/devices/system/cpu/cpuX/topology/book_siblings
> >   Description:    internal kernel map of cpuX's hardware threads within the same
> >                   book_id. it's only used on s390.
> > diff --git a/Documentation/admin-guide/cputopology.rst b/Documentation/admin-guide/cputopology.rst
> > index 8632a1db36e4..a5491949880d 100644
> > --- a/Documentation/admin-guide/cputopology.rst
> > +++ b/Documentation/admin-guide/cputopology.rst
> > @@ -19,11 +19,13 @@ these macros in include/asm-XXX/topology.h::
> >   
> >   	#define topology_physical_package_id(cpu)
> >   	#define topology_die_id(cpu)
> > +	#define topology_cluster_id(cpu)
> >   	#define topology_core_id(cpu)
> >   	#define topology_book_id(cpu)
> >   	#define topology_drawer_id(cpu)
> >   	#define topology_sibling_cpumask(cpu)
> >   	#define topology_core_cpumask(cpu)
> > +	#define topology_cluster_cpumask(cpu)
> >   	#define topology_die_cpumask(cpu)
> >   	#define topology_book_cpumask(cpu)
> >   	#define topology_drawer_cpumask(cpu)
> > @@ -39,10 +41,12 @@ not defined by include/asm-XXX/topology.h:
> >   
> >   1) topology_physical_package_id: -1
> >   2) topology_die_id: -1
> > -3) topology_core_id: 0
> > -4) topology_sibling_cpumask: just the given CPU
> > -5) topology_core_cpumask: just the given CPU
> > -6) topology_die_cpumask: just the given CPU
> > +3) topology_cluster_id: -1
> > +4) topology_core_id: 0
> > +5) topology_sibling_cpumask: just the given CPU
> > +6) topology_core_cpumask: just the given CPU
> > +7) topology_cluster_cpumask: just the given CPU
> > +8) topology_die_cpumask: just the given CPU
> >   
> >   For architectures that don't support books (CONFIG_SCHED_BOOK) there are no
> >   default definitions for topology_book_id() and topology_book_cpumask().
> > diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> > index 4dd14a6620c1..9ab78ad826e2 100644
> > --- a/arch/arm64/kernel/topology.c
> > +++ b/arch/arm64/kernel/topology.c
> > @@ -103,6 +103,8 @@ int __init parse_acpi_topology(void)
> >   			cpu_topology[cpu].thread_id  = -1;
> >   			cpu_topology[cpu].core_id    = topology_id;
> >   		}
> > +		topology_id = find_acpi_cpu_topology_cluster(cpu);
> > +		cpu_topology[cpu].cluster_id = topology_id;
> >   		topology_id = find_acpi_cpu_topology_package(cpu);
> >   		cpu_topology[cpu].package_id = topology_id;
> >   
> > diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> > index fe69dc518f31..701f61c01359 100644
> > --- a/drivers/acpi/pptt.c
> > +++ b/drivers/acpi/pptt.c
> > @@ -746,6 +746,73 @@ int find_acpi_cpu_topology_package(unsigned int cpu)
> >   					  ACPI_PPTT_PHYSICAL_PACKAGE);
> >   }
> >   
> > +/**
> > + * find_acpi_cpu_topology_cluster() - Determine a unique CPU cluster value
> > + * @cpu: Kernel logical CPU number
> > + *
> > + * Determine a topology unique cluster ID for the given CPU/thread.
> > + * This ID can then be used to group peers, which will have matching ids.
> > + *
> > + * The cluster, if present is the level of topology above CPUs. In a
> > + * multi-thread CPU, it will be the level above the CPU, not the thread.
> > + * It may not exist in single CPU systems. In simple multi-CPU systems,
> > + * it may be equal to the package topology level.
> > + *
> > + * Return: -ENOENT if the PPTT doesn't exist, the CPU cannot be found
> > + * or there is no toplogy level above the CPU..
> > + * Otherwise returns a value which represents the package for this CPU.
> > + */
> > +
> > +int find_acpi_cpu_topology_cluster(unsigned int cpu)
> > +{
> > +	struct acpi_table_header *table;
> > +	acpi_status status;
> > +	struct acpi_pptt_processor *cpu_node, *cluster_node;
> > +	u32 acpi_cpu_id;
> > +	int retval;
> > +	int is_thread;
> > +
> > +	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
> > +	if (ACPI_FAILURE(status)) {
> > +		acpi_pptt_warn_missing();
> > +		return -ENOENT;
> > +	}
> > +
> > +	acpi_cpu_id = get_acpi_id_for_cpu(cpu);
> > +	cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
> > +	if (cpu_node == NULL || !cpu_node->parent) {
> > +		retval = -ENOENT;
> > +		goto put_table;
> > +	}
> > +
> > +	is_thread = cpu_node->flags & ACPI_PPTT_ACPI_PROCESSOR_IS_THREAD;
> > +	cluster_node = fetch_pptt_node(table, cpu_node->parent);
> > +	if (cluster_node == NULL) {
> > +		retval = -ENOENT;
> > +		goto put_table;
> > +	}
> > +	if (is_thread) {
> > +		if (!cluster_node->parent) {
> > +			retval = -ENOENT;
> > +			goto put_table;
> > +		}
> > +		cluster_node = fetch_pptt_node(table, cluster_node->parent);
> > +		if (cluster_node == NULL) {
> > +			retval = -ENOENT;
> > +			goto put_table;
> > +		}
> > +	}
> > +	if (cluster_node->flags & ACPI_PPTT_ACPI_PROCESSOR_ID_VALID)
> > +		retval = cluster_node->acpi_processor_id;
> > +	else
> > +		retval = ACPI_PTR_DIFF(cluster_node, table);
> > +
> > +put_table:
> > +	acpi_put_table(table);
> > +
> > +	return retval;
> > +}
> > +
> >   /**
> >    * find_acpi_cpu_topology_hetero_id() - Get a core architecture tag
> >    * @cpu: Kernel logical CPU number
> > diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> > index 921312a8d957..5b1589adacaf 100644
> > --- a/drivers/base/arch_topology.c
> > +++ b/drivers/base/arch_topology.c
> > @@ -598,6 +598,11 @@ const struct cpumask *cpu_coregroup_mask(int cpu)
> >   	return core_mask;
> >   }
> >   
> > +const struct cpumask *cpu_clustergroup_mask(int cpu)
> > +{
> > +	return &cpu_topology[cpu].cluster_sibling;
> > +}
> > +
> >   void update_siblings_masks(unsigned int cpuid)
> >   {
> >   	struct cpu_topology *cpu_topo, *cpuid_topo = &cpu_topology[cpuid];
> > @@ -615,6 +620,11 @@ void update_siblings_masks(unsigned int cpuid)
> >   		if (cpuid_topo->package_id != cpu_topo->package_id)
> >   			continue;
> >   
> > +		if (cpuid_topo->cluster_id == cpu_topo->cluster_id) {
> > +			cpumask_set_cpu(cpu, &cpuid_topo->cluster_sibling);
> > +			cpumask_set_cpu(cpuid, &cpu_topo->cluster_sibling);
> > +		}
> > +
> >   		cpumask_set_cpu(cpuid, &cpu_topo->core_sibling);
> >   		cpumask_set_cpu(cpu, &cpuid_topo->core_sibling);
> >   
> > @@ -633,6 +643,9 @@ static void clear_cpu_topology(int cpu)
> >   	cpumask_clear(&cpu_topo->llc_sibling);
> >   	cpumask_set_cpu(cpu, &cpu_topo->llc_sibling);
> >   
> > +	cpumask_clear(&cpu_topo->cluster_sibling);
> > +	cpumask_set_cpu(cpu, &cpu_topo->cluster_sibling);
> > +
> >   	cpumask_clear(&cpu_topo->core_sibling);
> >   	cpumask_set_cpu(cpu, &cpu_topo->core_sibling);
> >   	cpumask_clear(&cpu_topo->thread_sibling);
> > @@ -648,6 +661,7 @@ void __init reset_cpu_topology(void)
> >   
> >   		cpu_topo->thread_id = -1;
> >   		cpu_topo->core_id = -1;
> > +		cpu_topo->cluster_id = -1;
> >   		cpu_topo->package_id = -1;
> >   		cpu_topo->llc_id = -1;
> >   
> > diff --git a/drivers/base/topology.c b/drivers/base/topology.c
> > index 43c0940643f5..8f2b641d0b8c 100644
> > --- a/drivers/base/topology.c
> > +++ b/drivers/base/topology.c
> > @@ -48,6 +48,9 @@ static DEVICE_ATTR_RO(physical_package_id);
> >   define_id_show_func(die_id);
> >   static DEVICE_ATTR_RO(die_id);
> >   
> > +define_id_show_func(cluster_id);
> > +static DEVICE_ATTR_RO(cluster_id);
> > +
> >   define_id_show_func(core_id);
> >   static DEVICE_ATTR_RO(core_id);
> >   
> > @@ -63,6 +66,10 @@ define_siblings_read_func(core_siblings, core_cpumask);
> >   static BIN_ATTR_RO(core_siblings, 0);
> >   static BIN_ATTR_RO(core_siblings_list, 0);
> >   
> > +define_siblings_read_func(cluster_cpus, cluster_cpumask);
> > +static BIN_ATTR_RO(cluster_cpus, 0);
> > +static BIN_ATTR_RO(cluster_cpus_list, 0);
> > +
> >   define_siblings_read_func(die_cpus, die_cpumask);
> >   static BIN_ATTR_RO(die_cpus, 0);
> >   static BIN_ATTR_RO(die_cpus_list, 0);
> > @@ -94,6 +101,8 @@ static struct bin_attribute *bin_attrs[] = {
> >   	&bin_attr_thread_siblings_list,
> >   	&bin_attr_core_siblings,
> >   	&bin_attr_core_siblings_list,
> > +	&bin_attr_cluster_cpus,
> > +	&bin_attr_cluster_cpus_list,
> >   	&bin_attr_die_cpus,
> >   	&bin_attr_die_cpus_list,
> >   	&bin_attr_package_cpus,
> > @@ -112,6 +121,7 @@ static struct bin_attribute *bin_attrs[] = {
> >   static struct attribute *default_attrs[] = {
> >   	&dev_attr_physical_package_id.attr,
> >   	&dev_attr_die_id.attr,
> > +	&dev_attr_cluster_id.attr,
> >   	&dev_attr_core_id.attr,
> >   #ifdef CONFIG_SCHED_BOOK
> >   	&dev_attr_book_id.attr,
> > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> > index 72e4f7fd268c..6d65427e5f67 100644
> > --- a/include/linux/acpi.h
> > +++ b/include/linux/acpi.h
> > @@ -1353,6 +1353,7 @@ static inline int lpit_read_residency_count_address(u64 *address)
> >   #ifdef CONFIG_ACPI_PPTT
> >   int acpi_pptt_cpu_is_thread(unsigned int cpu);
> >   int find_acpi_cpu_topology(unsigned int cpu, int level);
> > +int find_acpi_cpu_topology_cluster(unsigned int cpu);
> >   int find_acpi_cpu_topology_package(unsigned int cpu);
> >   int find_acpi_cpu_topology_hetero_id(unsigned int cpu);
> >   int find_acpi_cpu_cache_topology(unsigned int cpu, int level);
> > @@ -1365,6 +1366,10 @@ static inline int find_acpi_cpu_topology(unsigned int cpu, int level)
> >   {
> >   	return -EINVAL;
> >   }
> > +static inline int find_acpi_cpu_topology_cluster(unsigned int cpu)
> > +{
> > +	return -EINVAL;
> > +}
> >   static inline int find_acpi_cpu_topology_package(unsigned int cpu)
> >   {
> >   	return -EINVAL;
> > diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
> > index f180240dc95f..b97cea83b25e 100644
> > --- a/include/linux/arch_topology.h
> > +++ b/include/linux/arch_topology.h
> > @@ -62,10 +62,12 @@ void topology_set_thermal_pressure(const struct cpumask *cpus,
> >   struct cpu_topology {
> >   	int thread_id;
> >   	int core_id;
> > +	int cluster_id;
> >   	int package_id;
> >   	int llc_id;
> >   	cpumask_t thread_sibling;
> >   	cpumask_t core_sibling;
> > +	cpumask_t cluster_sibling;
> >   	cpumask_t llc_sibling;
> >   };
> >   
> > @@ -73,13 +75,16 @@ struct cpu_topology {
> >   extern struct cpu_topology cpu_topology[NR_CPUS];
> >   
> >   #define topology_physical_package_id(cpu)	(cpu_topology[cpu].package_id)
> > +#define topology_cluster_id(cpu)	(cpu_topology[cpu].cluster_id)
> >   #define topology_core_id(cpu)		(cpu_topology[cpu].core_id)
> >   #define topology_core_cpumask(cpu)	(&cpu_topology[cpu].core_sibling)
> >   #define topology_sibling_cpumask(cpu)	(&cpu_topology[cpu].thread_sibling)
> > +#define topology_cluster_cpumask(cpu)	(&cpu_topology[cpu].cluster_sibling)
> >   #define topology_llc_cpumask(cpu)	(&cpu_topology[cpu].llc_sibling)
> >   void init_cpu_topology(void);
> >   void store_cpu_topology(unsigned int cpuid);
> >   const struct cpumask *cpu_coregroup_mask(int cpu);
> > +const struct cpumask *cpu_clustergroup_mask(int cpu);
> >   void update_siblings_masks(unsigned int cpu);
> >   void remove_cpu_topology(unsigned int cpuid);
> >   void reset_cpu_topology(void);
> > diff --git a/include/linux/topology.h b/include/linux/topology.h
> > index 7634cd737061..80d27d717631 100644
> > --- a/include/linux/topology.h
> > +++ b/include/linux/topology.h
> > @@ -186,6 +186,9 @@ static inline int cpu_to_mem(int cpu)
> >   #ifndef topology_die_id
> >   #define topology_die_id(cpu)			((void)(cpu), -1)
> >   #endif
> > +#ifndef topology_cluster_id
> > +#define topology_cluster_id(cpu)		((void)(cpu), -1)
> > +#endif
> >   #ifndef topology_core_id
> >   #define topology_core_id(cpu)			((void)(cpu), 0)
> >   #endif
> > @@ -195,6 +198,9 @@ static inline int cpu_to_mem(int cpu)
> >   #ifndef topology_core_cpumask
> >   #define topology_core_cpumask(cpu)		cpumask_of(cpu)
> >   #endif
> > +#ifndef topology_cluster_cpumask
> > +#define topology_cluster_cpumask(cpu)		cpumask_of(cpu)
> > +#endif
> >   #ifndef topology_die_cpumask
> >   #define topology_die_cpumask(cpu)		cpumask_of(cpu)
> >   #endif  
> 

