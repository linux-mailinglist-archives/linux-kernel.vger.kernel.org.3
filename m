Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D234A8395
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 13:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238024AbiBCMJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 07:09:59 -0500
Received: from foss.arm.com ([217.140.110.172]:42900 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229794AbiBCMJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 07:09:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0347D11D4;
        Thu,  3 Feb 2022 04:09:58 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E907A3F774;
        Thu,  3 Feb 2022 04:09:56 -0800 (PST)
Date:   Thu, 3 Feb 2022 12:09:50 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] soc: bcm: brcmstb: Added support for PSCI system
 suspend operations
Message-ID: <YfvD2KklLEZX7Pht@FVFF77S0Q05N>
References: <20220122035421.4086618-1-f.fainelli@gmail.com>
 <20220122035421.4086618-4-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220122035421.4086618-4-f.fainelli@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 21, 2022 at 07:54:20PM -0800, Florian Fainelli wrote:
> Add support for the Broadcom STB system suspend operations which
> leverage the standard PSCI functions and uses the
> psci_cpu_suspend_enter() operation to power off the system with or
> without retention ("echo standby > /sys/power/state").

What exactly does this enable that can't be achieved with the existing PSCI
driver as-is?

When you say "retention", what specifically do you mean? Retention of CPU
state? DRAM contents?

We already have SYSTEM_SUSPEND for states where DRAM content is retained but
CPU (and some system state) is lost, and IIUC we can do suspend-to-idle with
CPU_SUSPEND states.

interface necessary?

> The system reset path also supports a special "powercycle" mode which
> signals to the ARM Trusted Firmware that an external PMIC chip must
> force the SoC into a power cycle.

How does that compare to the regular SYSTEM_RESET call?

The PSCI spec says of SYSTEM_RESET:

| This function provides a method for performing a system cold reset. To the
| caller, the behavior is equivalent to a hardware power-cycle sequence.

... so I don't follow how this is different, unless this platform's
SYSTEM_RESET implementation is *not* actually performing a system cold reset?

If that *doesn't* perform a cold rest, it seems like a bug?

> As much as possible extensions were built using the SIP namespace rather
> than the standard PSCI namespace, however compatibility with the
> standard PSCI implementation is retained when CONFIG_BRCMSTB_PM is not
> selected.

I really don't like this, because it seems to be creating a parallel
infrastructure for doing things that can *already* be done with standard PSCI
driver. The actual PSCI bits just seem to be playing about with the power_state
value, which we should be able to do in the regular PSCI driver, and the
SIP-specific functions seem to have nothing to do with PSCI.

At the least there needs to be a much better explanation of why this is
necessary, but overall I'd very much like to have *any* vendor specific code
for suspend states, and if there are limitations in the standard PSCI driver we
go and address those. Otherwise we're going to gain a plethora of
vendor-specific suspend implementations, which is exactly what PSCI was
intended to avoid in the first place.

I have some specific comments below, but even with those addressed, I don't
think this is the right approach, and as things stand, NAK to this.

> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/soc/bcm/brcmstb/Kconfig           |   4 +-
>  drivers/soc/bcm/brcmstb/pm/Makefile       |   1 +
>  drivers/soc/bcm/brcmstb/pm/pm-psci.c      | 315 ++++++++++++++++++++++
>  include/linux/soc/brcmstb/brcmstb-smccc.h |  84 ++++++
>  4 files changed, 402 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/soc/bcm/brcmstb/pm/pm-psci.c
>  create mode 100644 include/linux/soc/brcmstb/brcmstb-smccc.h
> 
> diff --git a/drivers/soc/bcm/brcmstb/Kconfig b/drivers/soc/bcm/brcmstb/Kconfig
> index 38e476905d96..a2b31717096e 100644
> --- a/drivers/soc/bcm/brcmstb/Kconfig
> +++ b/drivers/soc/bcm/brcmstb/Kconfig
> @@ -2,8 +2,8 @@
>  if SOC_BRCMSTB
>  
>  config BRCMSTB_PM
> -	bool "Support suspend/resume for STB platforms"
> -	default y
> +	tristate "Support suspend/resume for STB platforms"
> +	default ARCH_BRCMSTB || BMIPS_GENERIC
>  	depends on PM
>  	depends on ARCH_BRCMSTB || BMIPS_GENERIC
>  	select ARM_CPU_SUSPEND if ARM
> diff --git a/drivers/soc/bcm/brcmstb/pm/Makefile b/drivers/soc/bcm/brcmstb/pm/Makefile
> index 86004458260c..4ece53db8937 100644
> --- a/drivers/soc/bcm/brcmstb/pm/Makefile
> +++ b/drivers/soc/bcm/brcmstb/pm/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_BRCMSTB_PM)	+= pm-psci.o
>  ifndef CONFIG_ARM_PSCI_FW
>  obj-$(CONFIG_ARM)		+= s2-arm.o pm-arm.o
>  AFLAGS_s2-arm.o			:= -march=armv7-a
> diff --git a/drivers/soc/bcm/brcmstb/pm/pm-psci.c b/drivers/soc/bcm/brcmstb/pm/pm-psci.c
> new file mode 100644
> index 000000000000..7ba34d01c2fc
> --- /dev/null
> +++ b/drivers/soc/bcm/brcmstb/pm/pm-psci.c
> @@ -0,0 +1,315 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Broadcom STB PSCI based system wide PM support
> + *
> + * Copyright © 2018-2022 Broadcom
> + */
> +
> +#define pr_fmt(fmt) "brcmstb-pm-psci: " fmt
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/arm-smccc.h>
> +#include <linux/panic_notifier.h>
> +#include <linux/psci.h>
> +#include <linux/suspend.h>
> +#include <linux/soc/brcmstb/brcmstb.h>
> +#include <linux/soc/brcmstb/brcmstb-smccc.h>
> +#include <linux/reboot.h>
> +#include <linux/kobject.h>
> +
> +#include <uapi/linux/psci.h>
> +
> +#include <asm/suspend.h>
> +#include <asm/system_misc.h>
> +
> +#include "aon_defs.h"
> +
> +static psci_fn *invoke_psci_fn;
> +static bool brcmstb_psci_system_reset2_supported;
> +static bool brcmstb_psci_system_suspend_supported;
> +static bool brcmstb_psci_cpu_retention = true;
> +
> +static int brcmstb_psci_integ_region(unsigned long function_id,
> +				     unsigned long base,
> +				     unsigned long size)
> +{
> +	unsigned long end;
> +
> +	if (!size)
> +		return -EINVAL;
> +
> +	end = DIV_ROUND_UP(base + size, SIP_MIN_REGION_SIZE);
> +	base /= SIP_MIN_REGION_SIZE;
> +	size = end - base;
> +
> +	return invoke_psci_fn(function_id, base, size, 0);
> +}
> +
> +static int __maybe_unused brcmstb_psci_integ_region_set(unsigned long base,
> +							unsigned long size)
> +{
> +	return brcmstb_psci_integ_region(SIP_FUNC_INTEG_REGION_SET, base, size);
> +}
> +
> +static int __maybe_unused brcmstb_psci_integ_region_del(unsigned long base,
> +							unsigned long size)
> +{
> +	return brcmstb_psci_integ_region(SIP_FUNC_INTEG_REGION_DEL, base, size);
> +}
> +
> +static int brcmstb_psci_integ_region_reset_all(void)
> +{
> +	return invoke_psci_fn(SIP_FUNC_INTEG_REGION_RESET_ALL, 0, 0, 0);
> +}

What's all this? Below I see the phrase "integrity checking regions", but only
the brcmstb_psci_integ_region_reset_all() function is used, and it's not clear
what this is supposed to be for.

> +static int brcmstb_psci_sys_reset(struct notifier_block *nb,
> +				  unsigned long action, void *data)
> +{
> +	const char *cmd = data;
> +	/*
> +	 * reset_type[31] = 0 (architectural)
> +	 * reset_type[30:0] = 0 (SYSTEM_WARM_RESET)
> +	 * cookie = 0 (ignored by the implementation)
> +	 */
> +	uint32_t reboot_type = 0;
> +
> +	if ((action == REBOOT_COLD || action == REBOOT_WARM ||
> +	    action == REBOOT_SOFT) &&
> +	    brcmstb_psci_system_reset2_supported) {
> +		if (cmd && !strcmp(cmd, "powercycle"))
> +			reboot_type = BIT(31) | 1;
> +		invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2), reboot_type, 0, 0);
> +	} else {
> +		invoke_psci_fn(PSCI_0_2_FN_SYSTEM_RESET, 0, 0, 0);
> +	}
> +
> +	return NOTIFY_DONE;
> +}

If there are a bunch of specific SYSTEM_RESET2 values we want to expose, I'd
rather we described those generically in the DT, and somehow handle that in the
generic driver.

> +
> +static struct notifier_block brcmstb_psci_sys_reset_nb = {
> +	.notifier_call	= brcmstb_psci_sys_reset,
> +	.priority	= 128,
> +};
> +
> +void brcmstb_psci_sys_poweroff(void)
> +{
> +	invoke_psci_fn(PSCI_0_2_FN_SYSTEM_OFF, 0, 0, 0);
> +}
> +
> +static int psci_features(u32 psci_func_id)
> +{
> +	u32 features_func_id;
> +
> +	switch (ARM_SMCCC_OWNER_NUM(psci_func_id)) {
> +	case ARM_SMCCC_OWNER_SIP:
> +		features_func_id = SIP_FUNC_PSCI_FEATURES;
> +		break;
> +	case ARM_SMCCC_OWNER_STANDARD:
> +		features_func_id = PSCI_1_0_FN_PSCI_FEATURES;
> +		break;
> +	default:
> +		return PSCI_RET_NOT_SUPPORTED;
> +	}
> +
> +	return invoke_psci_fn(features_func_id, psci_func_id, 0, 0);
> +}
> +
> +static int brcmstb_psci_enter(suspend_state_t state)
> +{
> +	/* Request a SYSTEM level power state with retention */
> +	u32 pstate = 2 << PSCI_0_2_POWER_STATE_AFFL_SHIFT |
> +		     !brcmstb_psci_cpu_retention << PSCI_0_2_POWER_STATE_TYPE_SHIFT;
> +	int ret = -EINVAL;
> +
> +	switch (state) {
> +	case PM_SUSPEND_STANDBY:
> +		ret = psci_cpu_suspend_enter(pstate);
> +		break;
> +	case PM_SUSPEND_MEM:
> +		ret = brcmstb_psci_system_suspend_supported ?
> +			 psci_system_suspend_enter(state) : -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int brcmstb_psci_valid(suspend_state_t state)
> +{
> +	switch (state) {
> +	case PM_SUSPEND_STANDBY:
> +		return true;
> +	case PM_SUSPEND_MEM:
> +		return brcmstb_psci_system_suspend_supported;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static const struct platform_suspend_ops brcmstb_psci_ops = {
> +	.enter	= brcmstb_psci_enter,
> +	.valid	= brcmstb_psci_valid,
> +};
> +
> +static int brcmstb_psci_panic_notify(struct notifier_block *nb,
> +				     unsigned long action, void *data)
> +{
> +	int ret;
> +
> +	ret = invoke_psci_fn(SIP_FUNC_PANIC_NOTIFY, BRCMSTB_PANIC_MAGIC, 0, 0);
> +	if (ret != PSCI_RET_SUCCESS)
> +		return NOTIFY_BAD;
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block brcmstb_psci_nb = {
> +	.notifier_call = brcmstb_psci_panic_notify,
> +};

This appears to have nothing to do with idle/suspend states (and so might be OK
on its own if you need it, but it should be in a separate patch with some
justification).

> +static ssize_t brcmstb_psci_version_show(struct kobject *kobj,
> +					 struct kobj_attribute *attr,
> +					 char *buf)
> +{
> +	struct arm_smccc_res res = { };
> +	u32 version;
> +
> +	if (invoke_psci_fn == __invoke_psci_fn_hvc)
> +		arm_smccc_hvc(SIP_FUNC_PSCI_BRCMSTB_VERSION,
> +			      0, 0, 0, 0, 0, 0, 0, &res);
> +	else
> +		arm_smccc_smc(SIP_FUNC_PSCI_BRCMSTB_VERSION,
> +			      0, 0, 0, 0, 0, 0, 0, &res);
> +
> +	if (res.a0 != PSCI_RET_SUCCESS)
> +		return -EOPNOTSUPP;
> +
> +	version = res.a1;
> +
> +	return sprintf(buf, "%d.%d.%d.%d\n",
> +		       (version >> 24) & 0xff, (version >> 16) & 0xff,
> +		       (version >> 8) & 0xff, version & 0xff);
> +}
> +
> +static struct kobj_attribute brcmstb_psci_version_attr =
> +	__ATTR(mon_version, 0400, brcmstb_psci_version_show, NULL);
> +
> +static ssize_t brcmstb_psci_cpu_retention_show(struct kobject *kobj,
> +					       struct kobj_attribute *attr,
> +					       char *buf)
> +{
> +	return sprintf(buf, "%d\n", brcmstb_psci_cpu_retention);
> +}
> +
> +static ssize_t brcmstb_psci_cpu_retention_store(struct kobject *kobj,
> +						struct kobj_attribute *attr,
> +						const char *buf, size_t count)
> +{
> +	int ret, val;
> +
> +	ret = kstrtoint(buf, 10, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (val != 0 && val != 1)
> +		return -EINVAL;
> +
> +	brcmstb_psci_cpu_retention = !!val;
> +
> +	return count;
> +}
> +
> +static struct kobj_attribute brcmstb_psci_cpu_retention_attr =
> +	__ATTR(cpu_retention, 0644, brcmstb_psci_cpu_retention_show,
> +	       brcmstb_psci_cpu_retention_store);
> +
> +static const struct attribute *brcmstb_psci_attributes[] = {
> +	&brcmstb_psci_version_attr.attr,
> +	&brcmstb_psci_cpu_retention_attr.attr,
> +	NULL,
> +};
> +
> +static int brcmstb_pm_psci_init(void)
> +{
> +	unsigned long funcs_id[] = {
> +		PSCI_0_2_FN_SYSTEM_OFF,
> +		SIP_FUNC_INTEG_REGION_SET,
> +		SIP_FUNC_INTEG_REGION_DEL,
> +		SIP_FUNC_INTEG_REGION_RESET_ALL,
> +	};
> +	struct arm_smccc_res res = { };
> +	struct kobject *brcmstb_kobj;
> +	unsigned int i;
> +	int ret;
> +
> +	switch (arm_smccc_1_1_get_conduit()) {
> +	case SMCCC_CONDUIT_HVC:
> +		invoke_psci_fn = __invoke_psci_fn_hvc;
> +		break;
> +	case SMCCC_CONDUIT_SMC:
> +		invoke_psci_fn = __invoke_psci_fn_smc;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

Immediately after this switch, we know we there is *a* SMCCCv1.1+
implementation, but we have no idea *which* implementation that is. It could be
Broadcom's brcmstb implementation, it could be KVM's implementation, or anyone
else's...

> +
> +	/* Check the revision of monitor */
> +	if (invoke_psci_fn == __invoke_psci_fn_hvc)
> +		arm_smccc_hvc(SIP_SVC_REVISION,
> +			      0, 0, 0, 0, 0, 0, 0, &res);
> +	else
> +		arm_smccc_smc(SIP_SVC_REVISION,
> +			      0, 0, 0, 0, 0, 0, 0, &res);

This tells us the SIP interface's revision (if implemented), but not that the
SIP is Broadcom, and we still don't know that this is the brcmstb
implementation specifically.

> +	/* Test for our supported features */
> +	for (i = 0; i < ARRAY_SIZE(funcs_id); i++) {
> +		ret = psci_features(funcs_id[i]);
> +		if (ret == PSCI_RET_NOT_SUPPORTED) {
> +			pr_err("Firmware does not support function 0x%lx\n",
> +			       funcs_id[i]);
> +			return -EOPNOTSUPP;
> +		}
> +	}

For the SIP FIDs, this will invoke SIP_FUNC_PSCI_FEATURES, and since we haven't
determined the specific FW implementation, that could be another SIP's function
that does arbitrary things (e.g. they might just return 0, and mislead you).

So this is unsafe.

> +
> +	ret = psci_features(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2));
> +	if (ret != PSCI_RET_NOT_SUPPORTED)
> +		brcmstb_psci_system_reset2_supported = true;
> +
> +	ret = psci_features(PSCI_FN_NATIVE(1_0, SYSTEM_SUSPEND));
> +	if (ret != PSCI_RET_NOT_SUPPORTED)
> +		brcmstb_psci_system_suspend_supported = true;

Even if we've managed to get here, we still don't know that this is a brcmstb
implementation...

> +
> +	ret = brcmstb_psci_integ_region_reset_all();

... and as with all SIP calls, this might do arbitrary things.

> +	if (ret != PSCI_RET_SUCCESS) {
> +		pr_err("Error resetting all integrity checking regions\n");
> +		return -EIO;
> +	}
> +
> +	if (res.a0 == SIP_REVISION_MAJOR && res.a1 < SIP_REVISION_MINOR) {
> +		pr_info("Firmware is too old! Please update\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	brcmstb_kobj = kobject_create_and_add("brcmstb", firmware_kobj);
> +	if (brcmstb_kobj) {
> +		ret = sysfs_create_files(brcmstb_kobj, brcmstb_psci_attributes);
> +		if (ret)
> +			return ret;
> +	}

... and we can register this on a non-brcmstb implementation...

> +
> +	pm_power_off = brcmstb_psci_sys_poweroff;
> +	register_restart_handler(&brcmstb_psci_sys_reset_nb);
> +	suspend_set_ops(&brcmstb_psci_ops);
> +	atomic_notifier_chain_register(&panic_notifier_list,
> +				       &brcmstb_psci_nb);

... and we break power off, restart, and suspend on other implementations ...

> +	pr_info("Using PSCI based system PM (full featured)\n");

This should be explicit with something like "Overriding stnadard PSCI
functionaliy with brcmstb-specific code".

As it stands this is at best meaningless, and at worst misleading and
disparaging of standard PSCI.

> +
> +	return 0;
> +}
> +module_init(brcmstb_pm_psci_init);
> +
> +MODULE_AUTHOR("Broadcom");
> +MODULE_DESCRIPTION("Broadcom STB PM PSCI operations");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/soc/brcmstb/brcmstb-smccc.h b/include/linux/soc/brcmstb/brcmstb-smccc.h
> new file mode 100644
> index 000000000000..2863e894e1c7
> --- /dev/null
> +++ b/include/linux/soc/brcmstb/brcmstb-smccc.h
> @@ -0,0 +1,84 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __BRCMSTB_SMCCC_H
> +#define __BRCMSTB_SMCCC_H
> +
> +#include <linux/arm-smccc.h>
> +#include <uapi/linux/psci.h>
> +
> +#ifdef CONFIG_64BIT
> +#define PSCI_FN_NATIVE(version, name)   PSCI_##version##_FN64_##name
> +#else
> +#define PSCI_FN_NATIVE(version, name)   PSCI_##version##_FN_##name
> +#endif
> +
> +/* Broadcom STB custom SIP function calls */
> +#define SIP_FUNC_INTEG_REGION_SET	\
> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, \
> +			   IS_ENABLED(CONFIG_64BIT), \
> +			   ARM_SMCCC_OWNER_SIP, \
> +			   0)
> +#define SIP_FUNC_INTEG_REGION_DEL	\
> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, \
> +			   IS_ENABLED(CONFIG_64BIT), \
> +			   ARM_SMCCC_OWNER_SIP, \
> +			   1)
> +#define SIP_FUNC_INTEG_REGION_RESET_ALL	\
> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, \
> +			   IS_ENABLED(CONFIG_64BIT), \
> +			   ARM_SMCCC_OWNER_SIP, \
> +			   2)
> +#define SIP_FUNC_PANIC_NOTIFY		\
> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, \
> +			   IS_ENABLED(CONFIG_64BIT), \
> +			   ARM_SMCCC_OWNER_SIP, \
> +			   3)
> +#define SIP_FUNC_PSCI_FEATURES		\
> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, \
> +			   IS_ENABLED(CONFIG_64BIT), \
> +			   ARM_SMCCC_OWNER_SIP, \
> +			   4)
> +#define SIP_FUNC_PSCI_BRCMSTB_VERSION		\
> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, \
> +			   IS_ENABLED(CONFIG_64BIT), \
> +			   ARM_SMCCC_OWNER_SIP, \
> +			   5)
> +
> +#define SIP_SVC_REVISION		\
> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, \
> +			   IS_ENABLED(CONFIG_64BIT), \
> +			   ARM_SMCCC_OWNER_SIP, \
> +			   0xFF02)

Looking at the SMCCC spec, isn't the "general service query" REVISION call
0xFF03? 0xFF02 is reserved.

Thanks,
Mark.

> +
> +#define SIP_MIN_REGION_SIZE	4096
> +#define SIP_REVISION_MAJOR	0
> +#define SIP_REVISION_MINOR	2
> +
> +typedef unsigned long (psci_fn)(unsigned long, unsigned long,
> +				unsigned long, unsigned long);
> +
> +static inline unsigned long __invoke_psci_fn_hvc(unsigned long function_id,
> +						 unsigned long arg0,
> +						 unsigned long arg1,
> +						 unsigned long arg2)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_hvc(function_id, arg0, arg1, arg2, 0, 0, 0, 0, &res);
> +
> +	return res.a0;
> +}
> +
> +static inline unsigned long __invoke_psci_fn_smc(unsigned long function_id,
> +						 unsigned long arg0,
> +						 unsigned long arg1,
> +						 unsigned long arg2)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_smc(function_id, arg0, arg1, arg2, 0, 0, 0, 0, &res);
> +
> +	return res.a0;
> +}
> +
> +
> +#endif /* __BRCMSTB_SMCCC_H */
> -- 
> 2.25.1
> 
