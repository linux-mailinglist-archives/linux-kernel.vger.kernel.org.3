Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5746A5AD58F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 16:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiIEOz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 10:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237781AbiIEOzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 10:55:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 698293FA3B;
        Mon,  5 Sep 2022 07:55:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0BBEED1;
        Mon,  5 Sep 2022 07:55:28 -0700 (PDT)
Received: from [10.57.16.151] (unknown [10.57.16.151])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F19F3F534;
        Mon,  5 Sep 2022 07:55:20 -0700 (PDT)
Message-ID: <b357cc19-8b3f-ef97-efb1-8e7a8f5b2b8b@arm.com>
Date:   Mon, 5 Sep 2022 15:55:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RFC v1 3/3] perf: arm_spe: Add support for SPEv1.2
 inverted event filtering
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20220825-arm-spe-v8-7-v1-0-c75b8d92e692@kernel.org>
 <20220825-arm-spe-v8-7-v1-3-c75b8d92e692@kernel.org>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20220825-arm-spe-v8-7-v1-3-c75b8d92e692@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/08/2022 19:08, Rob Herring wrote:
> Arm SPEv1.2 (Arm v8.7/v9.2) adds a new feature called Inverted Event
> Filter which excludes samples matching the event filter. The feature
> mirrors the existing event filter in PMSEVFR_EL1 adding a new register,
> PMSNEVFR_EL1, which has the same event bit assignments.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 57904c11aece..9744da888818 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -258,6 +258,7 @@
>  #define SYS_PMSIDR_EL1_ARCHINST_SHIFT	3
>  #define SYS_PMSIDR_EL1_LDS_SHIFT	4
>  #define SYS_PMSIDR_EL1_ERND_SHIFT	5
> +#define SYS_PMSIDR_EL1_FNE_SHIFT	6
>  #define SYS_PMSIDR_EL1_INTERVAL_SHIFT	8
>  #define SYS_PMSIDR_EL1_INTERVAL_MASK	0xfUL
>  #define SYS_PMSIDR_EL1_MAXSIZE_SHIFT	12
> @@ -302,6 +303,7 @@
>  #define SYS_PMSFCR_EL1_FE_SHIFT		0
>  #define SYS_PMSFCR_EL1_FT_SHIFT		1
>  #define SYS_PMSFCR_EL1_FL_SHIFT		2
> +#define SYS_PMSFCR_EL1_FNE_SHIFT	3
>  #define SYS_PMSFCR_EL1_B_SHIFT		16
>  #define SYS_PMSFCR_EL1_LD_SHIFT		17
>  #define SYS_PMSFCR_EL1_ST_SHIFT		18
> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index a75b03b5c8f9..724409a88423 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
> @@ -82,6 +82,7 @@ struct arm_spe_pmu {
>  #define SPE_PMU_FEAT_ARCH_INST			(1UL << 3)
>  #define SPE_PMU_FEAT_LDS			(1UL << 4)
>  #define SPE_PMU_FEAT_ERND			(1UL << 5)
> +#define SPE_PMU_FEAT_INV_FILT_EVT		(1UL << 6)
>  #define SPE_PMU_FEAT_DEV_PROBED			(1UL << 63)
>  	u64					features;
>  
> @@ -199,6 +200,10 @@ static const struct attribute_group arm_spe_pmu_cap_group = {
>  #define ATTR_CFG_FLD_min_latency_LO		0
>  #define ATTR_CFG_FLD_min_latency_HI		11
>  
> +#define ATTR_CFG_FLD_inv_event_filter_CFG	config3	/* PMSNEVFR_EL1 */
> +#define ATTR_CFG_FLD_inv_event_filter_LO	0
> +#define ATTR_CFG_FLD_inv_event_filter_HI	63
> +
>  /* Why does everything I do descend into this? */
>  #define __GEN_PMU_FORMAT_ATTR(cfg, lo, hi)				\
>  	(lo) == (hi) ? #cfg ":" #lo "\n" : #cfg ":" #lo "-" #hi
> @@ -229,6 +234,7 @@ GEN_PMU_FORMAT_ATTR(branch_filter);
>  GEN_PMU_FORMAT_ATTR(load_filter);
>  GEN_PMU_FORMAT_ATTR(store_filter);
>  GEN_PMU_FORMAT_ATTR(event_filter);
> +GEN_PMU_FORMAT_ATTR(inv_event_filter);
>  GEN_PMU_FORMAT_ATTR(min_latency);
>  
>  static struct attribute *arm_spe_pmu_formats_attr[] = {
> @@ -240,12 +246,27 @@ static struct attribute *arm_spe_pmu_formats_attr[] = {
>  	&format_attr_load_filter.attr,
>  	&format_attr_store_filter.attr,
>  	&format_attr_event_filter.attr,
> +	&format_attr_inv_event_filter.attr,
>  	&format_attr_min_latency.attr,
>  	NULL,
>  };
>  
> +static umode_t arm_spe_pmu_format_attr_is_visible(struct kobject *kobj,
> +						  struct attribute *attr,
> +						  int unused)
> +	{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct arm_spe_pmu *spe_pmu = dev_get_drvdata(dev);
> +
> +	if (attr == &format_attr_inv_event_filter.attr && !(spe_pmu->features & SPE_PMU_FEAT_INV_FILT_EVT))
> +		return 0;
> +
> +	return attr->mode;
> +}
> +
>  static const struct attribute_group arm_spe_pmu_format_group = {
>  	.name	= "format",
> +	.is_visible = arm_spe_pmu_format_attr_is_visible,
>  	.attrs	= arm_spe_pmu_formats_attr,
>  };
>  
> @@ -341,6 +362,9 @@ static u64 arm_spe_event_to_pmsfcr(struct perf_event *event)
>  	if (ATTR_CFG_GET_FLD(attr, event_filter))
>  		reg |= BIT(SYS_PMSFCR_EL1_FE_SHIFT);
>  
> +	if (ATTR_CFG_GET_FLD(attr, inv_event_filter))
> +		reg |= BIT(SYS_PMSFCR_EL1_FNE_SHIFT);
> +
>  	if (ATTR_CFG_GET_FLD(attr, min_latency))
>  		reg |= BIT(SYS_PMSFCR_EL1_FL_SHIFT);
>  
> @@ -353,6 +377,12 @@ static u64 arm_spe_event_to_pmsevfr(struct perf_event *event)
>  	return ATTR_CFG_GET_FLD(attr, event_filter);
>  }
>  
> +static u64 arm_spe_event_to_pmsnevfr(struct perf_event *event)
> +{
> +	struct perf_event_attr *attr = &event->attr;
> +	return ATTR_CFG_GET_FLD(attr, inv_event_filter);
> +}
> +
>  static u64 arm_spe_event_to_pmslatfr(struct perf_event *event)
>  {
>  	struct perf_event_attr *attr = &event->attr;
> @@ -703,6 +733,9 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
>  	if (arm_spe_event_to_pmsevfr(event) & arm_spe_pmsevfr_res0(spe_pmu->pmsver))
>  		return -EOPNOTSUPP;
>  
> +	if (arm_spe_event_to_pmsnevfr(event) & arm_spe_pmsevfr_res0(spe_pmu->pmsver))
> +		return -EOPNOTSUPP;
> +
>  	if (attr->exclude_idle)
>  		return -EOPNOTSUPP;
>  
> @@ -721,6 +754,10 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
>  	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_EVT))
>  		return -EOPNOTSUPP;
>  
> +	if ((reg & BIT(SYS_PMSFCR_EL1_FNE_SHIFT)) &&
> +	    !(spe_pmu->features & SPE_PMU_FEAT_INV_FILT_EVT))
> +		return -EOPNOTSUPP;
> +
>  	if ((reg & BIT(SYS_PMSFCR_EL1_FT_SHIFT)) &&
>  	    !(spe_pmu->features & SPE_PMU_FEAT_FILT_TYP))
>  		return -EOPNOTSUPP;
> @@ -757,6 +794,9 @@ static void arm_spe_pmu_start(struct perf_event *event, int flags)
>  	reg = arm_spe_event_to_pmsevfr(event);
>  	write_sysreg_s(reg, SYS_PMSEVFR_EL1);
>  
> +	reg = arm_spe_event_to_pmsnevfr(event);
> +	write_sysreg_s(reg, SYS_PMSNEVFR_EL1);
> +

I think this needs to check if the feature is present before writing
otherwise you get a crash, pasted below. Otherwise it looks ok to me.

  kernel BUG at arch/arm64/kernel/traps.c:497!
  Internal error: Oops - BUG: 0 [#1] SMP
  Modules linked in: coresight_tmc coresight_stm coresight_etm4x
coresight_replicator coresight_funnel coresight_tpiu coresight arm_spe_pmu
  CPU: 1 PID: 656 Comm: perf-exec Not tainted 6.0.0-rc3+ #43
  pstate: 004000c9 (nzcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : do_undefinstr+0x2fc/0x320
  lr : do_undefinstr+0x250/0x320
  sp : ffff80000b543730
  x29: ffff80000b543730 x28: ffff008002748e80 x27: ffff00800be55e60
  x26: ffff80000a4cfce0 x25: ffff00837df9c59c x24: ffff00837df9c598
  x23: 00000000404000c9 x22: 00000000d5189921 x21: ffff80000a8080e8
  x20: ffff008002748e80 x19: ffff80000b5437c0 x18: 0000000000000000
  x17: 0000000000000000 x16: ffff8000082d2720 x15: fffffc0200462a80
  x14: 0000000000000000 x13: 0000029000000290 x12: 003000000000000c
  x11: 00000000ffffffff x10: 00000000ffffffff x9 : ffff8000082ead7c
  x8 : 0000000000000000 x7 : 0000000000000007 x6 : 0000000000010000
  x5 : 0000000000000000 x4 : 0000000000000000 x3 : 00000000d5380000
  x2 : ffff80000a426640 x1 : ffff80000a8080f8 x0 : 00000000404000c9
  Call trace:
   do_undefinstr+0x2fc/0x320
   el1_undef+0x30/0x50
   el1h_64_sync_handler+0x80/0xd0
   el1h_64_sync+0x64/0x68
   arm_spe_pmu_start+0x64/0xe8 [arm_spe_pmu]
   arm_spe_pmu_add+0x78/0x98 [arm_spe_pmu]
   event_sched_in.isra.0+0xa8/0x1a8
   merge_sched_in+0x1f4/0x3e8
   visit_groups_merge.constprop.0+0x1ac/0x480
   ctx_sched_in+0x1b0/0x1c8
   perf_event_sched_in+0x60/0x90
   ctx_resched+0x68/0xb0
   perf_event_exec+0x130/0x460
   begin_new_exec+0x5e4/0x1100
   load_elf_binary+0x3bc/0x16d8
   bprm_execve+0x280/0x620
   do_execveat_common.isra.0+0x1a4/0x240
   __arm64_sys_execve+0x48/0x60
   invoke_syscall+0x4c/0x110
   el0_svc_common.constprop.0+0x4c/0xf8
   do_el0_svc+0x34/0xc0
   el0_svc+0x2c/0x88
   el0t_64_sync_handler+0xb8/0xc0
   el0t_64_sync+0x18c/0x190
  Code: 33103ec0 2a0003f6 17ffff7a f9001bf7 (d4210000)

>  	reg = arm_spe_event_to_pmslatfr(event);
>  	write_sysreg_s(reg, SYS_PMSLATFR_EL1);
>  
> @@ -991,6 +1031,9 @@ static void __arm_spe_pmu_dev_probe(void *info)
>  	if (reg & BIT(SYS_PMSIDR_EL1_FE_SHIFT))
>  		spe_pmu->features |= SPE_PMU_FEAT_FILT_EVT;
>  
> +	if (reg & BIT(SYS_PMSIDR_EL1_FNE_SHIFT))
> +		spe_pmu->features |= SPE_PMU_FEAT_INV_FILT_EVT;
> +
>  	if (reg & BIT(SYS_PMSIDR_EL1_FT_SHIFT))
>  		spe_pmu->features |= SPE_PMU_FEAT_FILT_TYP;
>  
> 
