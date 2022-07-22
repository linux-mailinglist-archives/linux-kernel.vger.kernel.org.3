Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7808157E1F8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 15:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235537AbiGVNFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 09:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235668AbiGVNFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 09:05:17 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92090AFB46
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 06:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658495098; x=1690031098;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3UexRuVY3AcaXMgMBgzKXg5g6ZSkA1O/DEQepC4BC6s=;
  b=Nz4Ote+0WujUnRpInQlRs1JSWBW8X9Ju4Bsp2Fpta2jHb7cDB6oR5JEi
   snPQuj8GMVbYLH+X7OSL9L7DM21AFscKtuIpve9A630qCHvROP7SVmaKq
   0+Q2v3RNzp55SmDwZFa5FDDSHD0PQyECc+eGjB8VZCOgovD2WfIXVGwW4
   RPg4PgiktV98FjNBHoeRIESYSDt3oU0wtlD4I0KBvr+H4lyahKJkRtT2s
   4uGGkLm3NdjdeH4Y1uNiyNNXQdSUPlfAPJKbCg4x0Czt8nMh/CW5Ph4SM
   nOL/vQygNJr5ZW+W/u2/wNQYoFFYvVIja24LMiGjld8jANX/Qfn5AWrGr
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="349010364"
X-IronPort-AV: E=Sophos;i="5.93,185,1654585200"; 
   d="scan'208";a="349010364"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 06:04:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,185,1654585200"; 
   d="scan'208";a="626553699"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 22 Jul 2022 06:04:46 -0700
Received: from [10.252.209.172] (kliang2-mobl1.ccr.corp.intel.com [10.252.209.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id B54A3580919;
        Fri, 22 Jul 2022 06:04:44 -0700 (PDT)
Message-ID: <8c122462-afa5-bdf2-8bfb-910ff59ada03@linux.intel.com>
Date:   Fri, 22 Jul 2022 09:04:43 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH V2 1/5] perf/x86/intel/uncore: Parse uncore discovery
 tables
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     peterz@infradead.org, mingo@kernel.org, acme@redhat.com,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, namhyung@kernel.org,
        ak@linux.intel.com, tilak.tangudu@intel.com
References: <1616003977-90612-1-git-send-email-kan.liang@linux.intel.com>
 <1616003977-90612-2-git-send-email-kan.liang@linux.intel.com>
 <20220722125552.fmljascpvmi2b6ec@ldmartin-desk2>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20220722125552.fmljascpvmi2b6ec@ldmartin-desk2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-07-22 8:55 a.m., Lucas De Marchi wrote:
> Hi Kan,
> 
> On Wed, Mar 17, 2021 at 10:59:33AM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> A self-describing mechanism for the uncore PerfMon hardware has been
>> introduced with the latest Intel platforms. By reading through an MMIO
>> page worth of information, perf can 'discover' all the standard uncore
>> PerfMon registers in a machine.
>>
>> The discovery mechanism relies on BIOS's support. With a proper BIOS,
>> a PCI device with the unique capability ID 0x23 can be found on each
>> die. Perf can retrieve the information of all available uncore PerfMons
>> from the device via MMIO. The information is composed of one global
>> discovery table and several unit discovery tables.
>> - The global discovery table includes global uncore information of the
>>  die, e.g., the address of the global control register, the offset of
>>  the global status register, the number of uncore units, the offset of
>>  unit discovery tables, etc.
>> - The unit discovery table includes generic uncore unit information,
>>  e.g., the access type, the counter width, the address of counters,
>>  the address of the counter control, the unit ID, the unit type, etc.
>>  The unit is also called "box" in the code.
>> Perf can provide basic uncore support based on this information
>> with the following patches.
>>
>> To locate the PCI device with the discovery tables, check the generic
>> PCI ID first. If it doesn't match, go through the entire PCI device tree
>> and locate the device with the unique capability ID.
>>
>> The uncore information is similar among dies. To save parsing time and
>> space, only completely parse and store the discovery tables on the first
>> die and the first box of each die. The parsed information is stored in
>> an
>> RB tree structure, intel_uncore_discovery_type. The size of the stored
>> discovery tables varies among platforms. It's around 4KB for a Sapphire
>> Rapids server.
>>
>> If a BIOS doesn't support the 'discovery' mechanism, the uncore driver
>> will exit with -ENODEV. There is nothing changed.
>>
>> Add a module parameter to disable the discovery feature. If a BIOS gets
>> the discovery tables wrong, users can have an option to disable the
>> feature. For the current patchset, the uncore driver will exit with
>> -ENODEV. In the future, it may fall back to the hardcode uncore driver
>> on a known platform.
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> 
> I observed one issue when upgrading a kernel from 5.10 to 5.15 and after
> bisecting it arrived to this commit. I also verified the same issue is
> present in 5.19-rc7 and that the issue is gone when booting with
> intel_uncore.uncore_no_discover.
> 
> Test system is a SPR host with a PVC gpu. Issue is that PVC is not
> reaching pkg c6 state, even if we put it in rc6 state. It seems the pcie
> link is not idling, preventing it to go to pkg c6.
> 
> PMON discovery in bios is set to "auto".
> 
> We do see the following on dmesg while going through this code path:
> 
>     intel_uncore: Invalid Global Discovery State: 0xffffffffffffffff
> 0xffffffffffffffff 0xffffffffffffffff

On SPR, the uncore driver relies on the discovery table provided by the
BIOS/firmware. It looks like your BIOS/firmware is out of date. Could
you please update to the latest BIOS/firmware and have a try?

Thanks,
Kan

>     intel_uncore: Invalid Global Discovery State: 0xffffffffffffffff
> 0xffffffffffffffff 0xffffffffffffffff
>     intel_uncore: Uncore type 6 box 0: Invalid box control address.
>     intel_uncore: Uncore type 6 box 1: Invalid box control address.
>     intel_uncore: Uncore type 6 box 2: Invalid box control address.
>     intel_uncore: Uncore type 6 box 3: Invalid box control address.
>     intel_uncore: Uncore type 6 box 4: Invalid box control address.
>     intel_uncore: Uncore type 6 box 5: Invalid box control address.
>     intel_uncore: Uncore type 6 box 6: Invalid box control address.
>     intel_uncore: Uncore type 6 box 7: Invalid box control address.
> 
> Any idea what could be going wrong here?
> 
> thanks
> Lucas De Marchi
> 
>> ---
>> arch/x86/events/intel/Makefile           |   2 +-
>> arch/x86/events/intel/uncore.c           |  31 ++-
>> arch/x86/events/intel/uncore_discovery.c | 318
>> +++++++++++++++++++++++++++++++
>> arch/x86/events/intel/uncore_discovery.h | 105 ++++++++++
>> 4 files changed, 448 insertions(+), 8 deletions(-)
>> create mode 100644 arch/x86/events/intel/uncore_discovery.c
>> create mode 100644 arch/x86/events/intel/uncore_discovery.h
>>
>> diff --git a/arch/x86/events/intel/Makefile
>> b/arch/x86/events/intel/Makefile
>> index e67a588..10bde6c 100644
>> --- a/arch/x86/events/intel/Makefile
>> +++ b/arch/x86/events/intel/Makefile
>> @@ -3,6 +3,6 @@ obj-$(CONFIG_CPU_SUP_INTEL)        += core.o bts.o
>> obj-$(CONFIG_CPU_SUP_INTEL)        += ds.o knc.o
>> obj-$(CONFIG_CPU_SUP_INTEL)        += lbr.o p4.o p6.o pt.o
>> obj-$(CONFIG_PERF_EVENTS_INTEL_UNCORE)    += intel-uncore.o
>> -intel-uncore-objs            := uncore.o uncore_nhmex.o uncore_snb.o
>> uncore_snbep.o
>> +intel-uncore-objs            := uncore.o uncore_nhmex.o uncore_snb.o
>> uncore_snbep.o uncore_discovery.o
>> obj-$(CONFIG_PERF_EVENTS_INTEL_CSTATE)    += intel-cstate.o
>> intel-cstate-objs            := cstate.o
>> diff --git a/arch/x86/events/intel/uncore.c
>> b/arch/x86/events/intel/uncore.c
>> index 33c8180..d111370 100644
>> --- a/arch/x86/events/intel/uncore.c
>> +++ b/arch/x86/events/intel/uncore.c
>> @@ -4,7 +4,12 @@
>> #include <asm/cpu_device_id.h>
>> #include <asm/intel-family.h>
>> #include "uncore.h"
>> +#include "uncore_discovery.h"
>>
>> +static bool uncore_no_discover;
>> +module_param(uncore_no_discover, bool, 0);
>> +MODULE_PARM_DESC(uncore_no_discover, "Don't enable the Intel uncore
>> PerfMon discovery mechanism "
>> +                     "(default: enable the discovery mechanism).");
>> static struct intel_uncore_type *empty_uncore[] = { NULL, };
>> struct intel_uncore_type **uncore_msr_uncores = empty_uncore;
>> struct intel_uncore_type **uncore_pci_uncores = empty_uncore;
>> @@ -1637,6 +1642,9 @@ static const struct intel_uncore_init_fun
>> snr_uncore_init __initconst = {
>>     .mmio_init = snr_uncore_mmio_init,
>> };
>>
>> +static const struct intel_uncore_init_fun generic_uncore_init
>> __initconst = {
>> +};
>> +
>> static const struct x86_cpu_id intel_uncore_match[] __initconst = {
>>     X86_MATCH_INTEL_FAM6_MODEL(NEHALEM_EP,        &nhm_uncore_init),
>>     X86_MATCH_INTEL_FAM6_MODEL(NEHALEM,        &nhm_uncore_init),
>> @@ -1684,17 +1692,21 @@ static int __init intel_uncore_init(void)
>>     struct intel_uncore_init_fun *uncore_init;
>>     int pret = 0, cret = 0, mret = 0, ret;
>>
>> -    id = x86_match_cpu(intel_uncore_match);
>> -    if (!id)
>> -        return -ENODEV;
>> -
>>     if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
>>         return -ENODEV;
>>
>>     __uncore_max_dies =
>>         topology_max_packages() * topology_max_die_per_package();
>>
>> -    uncore_init = (struct intel_uncore_init_fun *)id->driver_data;
>> +    id = x86_match_cpu(intel_uncore_match);
>> +    if (!id) {
>> +        if (!uncore_no_discover && intel_uncore_has_discovery_tables())
>> +            uncore_init = (struct intel_uncore_init_fun
>> *)&generic_uncore_init;
>> +        else
>> +            return -ENODEV;
>> +    } else
>> +        uncore_init = (struct intel_uncore_init_fun *)id->driver_data;
>> +
>>     if (uncore_init->pci_init) {
>>         pret = uncore_init->pci_init();
>>         if (!pret)
>> @@ -1711,8 +1723,10 @@ static int __init intel_uncore_init(void)
>>         mret = uncore_mmio_init();
>>     }
>>
>> -    if (cret && pret && mret)
>> -        return -ENODEV;
>> +    if (cret && pret && mret) {
>> +        ret = -ENODEV;
>> +        goto free_discovery;
>> +    }
>>
>>     /* Install hotplug callbacks to setup the targets for each package */
>>     ret = cpuhp_setup_state(CPUHP_AP_PERF_X86_UNCORE_ONLINE,
>> @@ -1727,6 +1741,8 @@ static int __init intel_uncore_init(void)
>>     uncore_types_exit(uncore_msr_uncores);
>>     uncore_types_exit(uncore_mmio_uncores);
>>     uncore_pci_exit();
>> +free_discovery:
>> +    intel_uncore_clear_discovery_tables();
>>     return ret;
>> }
>> module_init(intel_uncore_init);
>> @@ -1737,5 +1753,6 @@ static void __exit intel_uncore_exit(void)
>>     uncore_types_exit(uncore_msr_uncores);
>>     uncore_types_exit(uncore_mmio_uncores);
>>     uncore_pci_exit();
>> +    intel_uncore_clear_discovery_tables();
>> }
>> module_exit(intel_uncore_exit);
>> diff --git a/arch/x86/events/intel/uncore_discovery.c
>> b/arch/x86/events/intel/uncore_discovery.c
>> new file mode 100644
>> index 0000000..9d5c8b2
>> --- /dev/null
>> +++ b/arch/x86/events/intel/uncore_discovery.c
>> @@ -0,0 +1,318 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Support Intel uncore PerfMon discovery mechanism.
>> + * Copyright(c) 2021 Intel Corporation.
>> + */
>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>> +
>> +#include "uncore.h"
>> +#include "uncore_discovery.h"
>> +
>> +static struct rb_root discovery_tables = RB_ROOT;
>> +static int num_discovered_types[UNCORE_ACCESS_MAX];
>> +
>> +static bool has_generic_discovery_table(void)
>> +{
>> +    struct pci_dev *dev;
>> +    int dvsec;
>> +
>> +    dev = pci_get_device(PCI_VENDOR_ID_INTEL,
>> UNCORE_DISCOVERY_TABLE_DEVICE, NULL);
>> +    if (!dev)
>> +        return false;
>> +
>> +    /* A discovery table device has the unique capability ID. */
>> +    dvsec = pci_find_next_ext_capability(dev, 0,
>> UNCORE_EXT_CAP_ID_DISCOVERY);
>> +    pci_dev_put(dev);
>> +    if (dvsec)
>> +        return true;
>> +
>> +    return false;
>> +}
>> +
>> +static int logical_die_id;
>> +
>> +static int get_device_die_id(struct pci_dev *dev)
>> +{
>> +    int cpu, node = pcibus_to_node(dev->bus);
>> +
>> +    /*
>> +     * If the NUMA info is not available, assume that the logical die
>> id is
>> +     * continuous in the order in which the discovery table devices are
>> +     * detected.
>> +     */
>> +    if (node < 0)
>> +        return logical_die_id++;
>> +
>> +    for_each_cpu(cpu, cpumask_of_node(node)) {
>> +        struct cpuinfo_x86 *c = &cpu_data(cpu);
>> +
>> +        if (c->initialized && cpu_to_node(cpu) == node)
>> +            return c->logical_die_id;
>> +    }
>> +
>> +    /*
>> +     * All CPUs of a node may be offlined. For this case,
>> +     * the PCI and MMIO type of uncore blocks which are
>> +     * enumerated by the device will be unavailable.
>> +     */
>> +    return -1;
>> +}
>> +
>> +#define __node_2_type(cur)    \
>> +    rb_entry((cur), struct intel_uncore_discovery_type, node)
>> +
>> +static inline int __type_cmp(const void *key, const struct rb_node *b)
>> +{
>> +    struct intel_uncore_discovery_type *type_b = __node_2_type(b);
>> +    const u16 *type_id = key;
>> +
>> +    if (type_b->type > *type_id)
>> +        return -1;
>> +    else if (type_b->type < *type_id)
>> +        return 1;
>> +
>> +    return 0;
>> +}
>> +
>> +static inline struct intel_uncore_discovery_type *
>> +search_uncore_discovery_type(u16 type_id)
>> +{
>> +    struct rb_node *node = rb_find(&type_id, &discovery_tables,
>> __type_cmp);
>> +
>> +    return (node) ? __node_2_type(node) : NULL;
>> +}
>> +
>> +static inline bool __type_less(struct rb_node *a, const struct
>> rb_node *b)
>> +{
>> +    return (__node_2_type(a)->type < __node_2_type(b)->type) ? true :
>> false;
>> +}
>> +
>> +static struct intel_uncore_discovery_type *
>> +add_uncore_discovery_type(struct uncore_unit_discovery *unit)
>> +{
>> +    struct intel_uncore_discovery_type *type;
>> +
>> +    if (unit->access_type >= UNCORE_ACCESS_MAX) {
>> +        pr_warn("Unsupported access type %d\n", unit->access_type);
>> +        return NULL;
>> +    }
>> +
>> +    type = kzalloc(sizeof(struct intel_uncore_discovery_type),
>> GFP_KERNEL);
>> +    if (!type)
>> +        return NULL;
>> +
>> +    type->box_ctrl_die = kcalloc(__uncore_max_dies, sizeof(u64),
>> GFP_KERNEL);
>> +    if (!type->box_ctrl_die)
>> +        goto free_type;
>> +
>> +    type->access_type = unit->access_type;
>> +    num_discovered_types[type->access_type]++;
>> +    type->type = unit->box_type;
>> +
>> +    rb_add(&type->node, &discovery_tables, __type_less);
>> +
>> +    return type;
>> +
>> +free_type:
>> +    kfree(type);
>> +
>> +    return NULL;
>> +
>> +}
>> +
>> +static struct intel_uncore_discovery_type *
>> +get_uncore_discovery_type(struct uncore_unit_discovery *unit)
>> +{
>> +    struct intel_uncore_discovery_type *type;
>> +
>> +    type = search_uncore_discovery_type(unit->box_type);
>> +    if (type)
>> +        return type;
>> +
>> +    return add_uncore_discovery_type(unit);
>> +}
>> +
>> +static void
>> +uncore_insert_box_info(struct uncore_unit_discovery *unit,
>> +               int die, bool parsed)
>> +{
>> +    struct intel_uncore_discovery_type *type;
>> +    unsigned int *box_offset, *ids;
>> +    int i;
>> +
>> +    if (WARN_ON_ONCE(!unit->ctl || !unit->ctl_offset ||
>> !unit->ctr_offset))
>> +        return;
>> +
>> +    if (parsed) {
>> +        type = search_uncore_discovery_type(unit->box_type);
>> +        if (WARN_ON_ONCE(!type))
>> +            return;
>> +        /* Store the first box of each die */
>> +        if (!type->box_ctrl_die[die])
>> +            type->box_ctrl_die[die] = unit->ctl;
>> +        return;
>> +    }
>> +
>> +    type = get_uncore_discovery_type(unit);
>> +    if (!type)
>> +        return;
>> +
>> +    box_offset = kcalloc(type->num_boxes + 1, sizeof(unsigned int),
>> GFP_KERNEL);
>> +    if (!box_offset)
>> +        return;
>> +
>> +    ids = kcalloc(type->num_boxes + 1, sizeof(unsigned int),
>> GFP_KERNEL);
>> +    if (!ids)
>> +        goto free_box_offset;
>> +
>> +    /* Store generic information for the first box */
>> +    if (!type->num_boxes) {
>> +        type->box_ctrl = unit->ctl;
>> +        type->box_ctrl_die[die] = unit->ctl;
>> +        type->num_counters = unit->num_regs;
>> +        type->counter_width = unit->bit_width;
>> +        type->ctl_offset = unit->ctl_offset;
>> +        type->ctr_offset = unit->ctr_offset;
>> +        *ids = unit->box_id;
>> +        goto end;
>> +    }
>> +
>> +    for (i = 0; i < type->num_boxes; i++) {
>> +        ids[i] = type->ids[i];
>> +        box_offset[i] = type->box_offset[i];
>> +
>> +        if (WARN_ON_ONCE(unit->box_id == ids[i]))
>> +            goto free_ids;
>> +    }
>> +    ids[i] = unit->box_id;
>> +    box_offset[i] = unit->ctl - type->box_ctrl;
>> +    kfree(type->ids);
>> +    kfree(type->box_offset);
>> +end:
>> +    type->ids = ids;
>> +    type->box_offset = box_offset;
>> +    type->num_boxes++;
>> +    return;
>> +
>> +free_ids:
>> +    kfree(ids);
>> +
>> +free_box_offset:
>> +    kfree(box_offset);
>> +
>> +}
>> +
>> +static int parse_discovery_table(struct pci_dev *dev, int die,
>> +                 u32 bar_offset, bool *parsed)
>> +{
>> +    struct uncore_global_discovery global;
>> +    struct uncore_unit_discovery unit;
>> +    void __iomem *io_addr;
>> +    resource_size_t addr;
>> +    unsigned long size;
>> +    u32 val;
>> +    int i;
>> +
>> +    pci_read_config_dword(dev, bar_offset, &val);
>> +
>> +    if (val & UNCORE_DISCOVERY_MASK)
>> +        return -EINVAL;
>> +
>> +    addr = (resource_size_t)(val & ~UNCORE_DISCOVERY_MASK);
>> +    size = UNCORE_DISCOVERY_GLOBAL_MAP_SIZE;
>> +    io_addr = ioremap(addr, size);
>> +    if (!io_addr)
>> +        return -ENOMEM;
>> +
>> +    /* Read Global Discovery State */
>> +    memcpy_fromio(&global, io_addr, sizeof(struct
>> uncore_global_discovery));
>> +    if (uncore_discovery_invalid_unit(global)) {
>> +        pr_info("Invalid Global Discovery State: 0x%llx 0x%llx
>> 0x%llx\n",
>> +            global.table1, global.ctl, global.table3);
>> +        iounmap(io_addr);
>> +        return -EINVAL;
>> +    }
>> +    iounmap(io_addr);
>> +
>> +    size = (1 + global.max_units) * global.stride * 8;
>> +    io_addr = ioremap(addr, size);
>> +    if (!io_addr)
>> +        return -ENOMEM;
>> +
>> +    /* Parsing Unit Discovery State */
>> +    for (i = 0; i < global.max_units; i++) {
>> +        memcpy_fromio(&unit, io_addr + (i + 1) * (global.stride * 8),
>> +                  sizeof(struct uncore_unit_discovery));
>> +
>> +        if (uncore_discovery_invalid_unit(unit))
>> +            continue;
>> +
>> +        if (unit.access_type >= UNCORE_ACCESS_MAX)
>> +            continue;
>> +
>> +        uncore_insert_box_info(&unit, die, *parsed);
>> +    }
>> +
>> +    *parsed = true;
>> +    iounmap(io_addr);
>> +    return 0;
>> +}
>> +
>> +bool intel_uncore_has_discovery_tables(void)
>> +{
>> +    u32 device, val, entry_id, bar_offset;
>> +    int die, dvsec = 0, ret = true;
>> +    struct pci_dev *dev = NULL;
>> +    bool parsed = false;
>> +
>> +    if (has_generic_discovery_table())
>> +        device = UNCORE_DISCOVERY_TABLE_DEVICE;
>> +    else
>> +        device = PCI_ANY_ID;
>> +
>> +    /*
>> +     * Start a new search and iterates through the list of
>> +     * the discovery table devices.
>> +     */
>> +    while ((dev = pci_get_device(PCI_VENDOR_ID_INTEL, device, dev))
>> != NULL) {
>> +        while ((dvsec = pci_find_next_ext_capability(dev, dvsec,
>> UNCORE_EXT_CAP_ID_DISCOVERY))) {
>> +            pci_read_config_dword(dev, dvsec +
>> UNCORE_DISCOVERY_DVSEC_OFFSET, &val);
>> +            entry_id = val & UNCORE_DISCOVERY_DVSEC_ID_MASK;
>> +            if (entry_id != UNCORE_DISCOVERY_DVSEC_ID_PMON)
>> +                continue;
>> +
>> +            pci_read_config_dword(dev, dvsec +
>> UNCORE_DISCOVERY_DVSEC2_OFFSET, &val);
>> +
>> +            if (val & ~UNCORE_DISCOVERY_DVSEC2_BIR_MASK) {
>> +                ret = false;
>> +                goto err;
>> +            }
>> +            bar_offset = UNCORE_DISCOVERY_BIR_BASE +
>> +                     (val & UNCORE_DISCOVERY_DVSEC2_BIR_MASK) *
>> UNCORE_DISCOVERY_BIR_STEP;
>> +
>> +            die = get_device_die_id(dev);
>> +            if (die < 0)
>> +                continue;
>> +
>> +            parse_discovery_table(dev, die, bar_offset, &parsed);
>> +        }
>> +    }
>> +
>> +    /* None of the discovery tables are available */
>> +    if (!parsed)
>> +        ret = false;
>> +err:
>> +    pci_dev_put(dev);
>> +
>> +    return ret;
>> +}
>> +
>> +void intel_uncore_clear_discovery_tables(void)
>> +{
>> +    struct intel_uncore_discovery_type *type, *next;
>> +
>> +    rbtree_postorder_for_each_entry_safe(type, next,
>> &discovery_tables, node) {
>> +        kfree(type->box_ctrl_die);
>> +        kfree(type);
>> +    }
>> +}
>> diff --git a/arch/x86/events/intel/uncore_discovery.h
>> b/arch/x86/events/intel/uncore_discovery.h
>> new file mode 100644
>> index 0000000..95afa39
>> --- /dev/null
>> +++ b/arch/x86/events/intel/uncore_discovery.h
>> @@ -0,0 +1,105 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +
>> +/* Generic device ID of a discovery table device */
>> +#define UNCORE_DISCOVERY_TABLE_DEVICE        0x09a7
>> +/* Capability ID for a discovery table device */
>> +#define UNCORE_EXT_CAP_ID_DISCOVERY        0x23
>> +/* First DVSEC offset */
>> +#define UNCORE_DISCOVERY_DVSEC_OFFSET        0x8
>> +/* Mask of the supported discovery entry type */
>> +#define UNCORE_DISCOVERY_DVSEC_ID_MASK        0xffff
>> +/* PMON discovery entry type ID */
>> +#define UNCORE_DISCOVERY_DVSEC_ID_PMON        0x1
>> +/* Second DVSEC offset */
>> +#define UNCORE_DISCOVERY_DVSEC2_OFFSET        0xc
>> +/* Mask of the discovery table BAR offset */
>> +#define UNCORE_DISCOVERY_DVSEC2_BIR_MASK    0x7
>> +/* Discovery table BAR base offset */
>> +#define UNCORE_DISCOVERY_BIR_BASE        0x10
>> +/* Discovery table BAR step */
>> +#define UNCORE_DISCOVERY_BIR_STEP        0x4
>> +/* Mask of the discovery table offset */
>> +#define UNCORE_DISCOVERY_MASK            0xf
>> +/* Global discovery table size */
>> +#define UNCORE_DISCOVERY_GLOBAL_MAP_SIZE    0x20
>> +
>> +#define uncore_discovery_invalid_unit(unit)            \
>> +    (!unit.table1 || !unit.ctl || !unit.table3 ||    \
>> +     unit.table1 == -1ULL || unit.ctl == -1ULL ||    \
>> +     unit.table3 == -1ULL)
>> +
>> +enum uncore_access_type {
>> +    UNCORE_ACCESS_MSR    = 0,
>> +    UNCORE_ACCESS_MMIO,
>> +    UNCORE_ACCESS_PCI,
>> +
>> +    UNCORE_ACCESS_MAX,
>> +};
>> +
>> +struct uncore_global_discovery {
>> +    union {
>> +        u64    table1;
>> +        struct {
>> +            u64    type : 8,
>> +                stride : 8,
>> +                max_units : 10,
>> +                __reserved_1 : 36,
>> +                access_type : 2;
>> +        };
>> +    };
>> +
>> +    u64    ctl;        /* Global Control Address */
>> +
>> +    union {
>> +        u64    table3;
>> +        struct {
>> +            u64    status_offset : 8,
>> +                num_status : 16,
>> +                __reserved_2 : 40;
>> +        };
>> +    };
>> +};
>> +
>> +struct uncore_unit_discovery {
>> +    union {
>> +        u64    table1;
>> +        struct {
>> +            u64    num_regs : 8,
>> +                ctl_offset : 8,
>> +                bit_width : 8,
>> +                ctr_offset : 8,
>> +                status_offset : 8,
>> +                __reserved_1 : 22,
>> +                access_type : 2;
>> +            };
>> +        };
>> +
>> +    u64    ctl;        /* Unit Control Address */
>> +
>> +    union {
>> +        u64    table3;
>> +        struct {
>> +            u64    box_type : 16,
>> +                box_id : 16,
>> +                __reserved_2 : 32;
>> +        };
>> +    };
>> +};
>> +
>> +struct intel_uncore_discovery_type {
>> +    struct rb_node    node;
>> +    enum uncore_access_type    access_type;
>> +    u64        box_ctrl;    /* Unit ctrl addr of the first box */
>> +    u64        *box_ctrl_die;    /* Unit ctrl addr of the first box
>> of each die */
>> +    u16        type;        /* Type ID of the uncore block */
>> +    u8        num_counters;
>> +    u8        counter_width;
>> +    u8        ctl_offset;    /* Counter Control 0 offset */
>> +    u8        ctr_offset;    /* Counter 0 offset */
>> +    u16        num_boxes;    /* number of boxes for the uncore block */
>> +    unsigned int    *ids;        /* Box IDs */
>> +    unsigned int    *box_offset;    /* Box offset */
>> +};
>> +
>> +bool intel_uncore_has_discovery_tables(void);
>> +void intel_uncore_clear_discovery_tables(void);
>> -- 
>> 2.7.4
>>
