Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C565075BB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346769AbiDSQ4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350764AbiDSQuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:50:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D34140B2;
        Tue, 19 Apr 2022 09:47:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 972C4B81BDF;
        Tue, 19 Apr 2022 16:47:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0826C385A5;
        Tue, 19 Apr 2022 16:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650386856;
        bh=Xg8BVCfgdei07bwHKlZffWReysmux0uXI5sIlyTTzII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qKTE01baLdiKYbyHvlFqEFW09GVgmCYmAf+ogB2UsjdH0ZlxaYfydSuXPnfLEPmam
         cQQytZJ4iaZS+mEujTIdQcpZE+qfUYmH7L83DLS6cW7e6eoDmXqCx3TtFJzzwk5Foj
         OsgimDBSF/tlV38G6F95vD/9LDjly/eFV/GqYqxc=
Date:   Tue, 19 Apr 2022 18:47:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tony Luck <tony.luck@intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, corbet@lwn.net,
        andriy.shevchenko@linux.intel.com, jithu.joseph@intel.com,
        ashok.raj@intel.com, rostedt@goodmis.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com
Subject: Re: [PATCH v3 03/11] platform/x86/intel/ifs: Create device for Intel
 IFS (In Field Scan)
Message-ID: <Yl7npfrVTPFEIivC@kroah.com>
References: <20220407191347.9681-1-jithu.joseph@intel.com>
 <20220419163859.2228874-1-tony.luck@intel.com>
 <20220419163859.2228874-4-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419163859.2228874-4-tony.luck@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 09:38:51AM -0700, Tony Luck wrote:
> The initial implementation of IFS is model specific. Enumeration is
> via a combination of family-model-stepping and a check for a bit in the
> CORE_CAPABILITIES MSR.
> 
> Linux has handled this lack of enumeration before with a code stub to
> create a device.  See arch/x86/kernel/pmem.c. Use the same approach
> here.

Ick, why?  Why not just create a simple virtual device and use that?  Do
you really want to bind a driver to this?  Or do you already "know" the
only driver that you have will bind to this?

pmem.c should not be used as a good example of anything, sorry.

greg k-h


> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  MAINTAINERS                                   |  7 +++
>  drivers/platform/x86/intel/Kconfig            |  1 +
>  drivers/platform/x86/intel/Makefile           |  1 +
>  drivers/platform/x86/intel/ifs/Kconfig        |  2 +
>  drivers/platform/x86/intel/ifs/Makefile       |  1 +
>  .../platform/x86/intel/ifs/intel_ifs_device.c | 50 +++++++++++++++++++
>  6 files changed, 62 insertions(+)
>  create mode 100644 drivers/platform/x86/intel/ifs/Kconfig
>  create mode 100644 drivers/platform/x86/intel/ifs/Makefile
>  create mode 100644 drivers/platform/x86/intel/ifs/intel_ifs_device.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 40fa1955ca3f..9e372a960fa5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9861,6 +9861,13 @@ B:	https://bugzilla.kernel.org
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git
>  F:	drivers/idle/intel_idle.c
>  
> +INTEL IN FIELD SCAN (IFS) DRIVER
> +M:	Jithu Joseph <jithu.joseph@intel.com>
> +R:	Ashok Raj <ashok.raj@intel.com>
> +R:	Tony Luck <tony.luck@intel.com>
> +S:	Maintained
> +F:	drivers/platform/x86/intel/ifs
> +
>  INTEL INTEGRATED SENSOR HUB DRIVER
>  M:	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>  M:	Jiri Kosina <jikos@kernel.org>
> diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
> index 1f01a8a23c57..794968bda115 100644
> --- a/drivers/platform/x86/intel/Kconfig
> +++ b/drivers/platform/x86/intel/Kconfig
> @@ -4,6 +4,7 @@
>  #
>  
>  source "drivers/platform/x86/intel/atomisp2/Kconfig"
> +source "drivers/platform/x86/intel/ifs/Kconfig"
>  source "drivers/platform/x86/intel/int1092/Kconfig"
>  source "drivers/platform/x86/intel/int3472/Kconfig"
>  source "drivers/platform/x86/intel/pmc/Kconfig"
> diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
> index c61bc3e97121..10285d0fd16a 100644
> --- a/drivers/platform/x86/intel/Makefile
> +++ b/drivers/platform/x86/intel/Makefile
> @@ -5,6 +5,7 @@
>  #
>  
>  obj-$(CONFIG_INTEL_ATOMISP2_PDX86)	+= atomisp2/
> +obj-y					+= ifs/
>  obj-$(CONFIG_INTEL_SAR_INT1092)		+= int1092/
>  obj-$(CONFIG_INTEL_SKL_INT3472)		+= int3472/
>  obj-$(CONFIG_INTEL_PMC_CORE)		+= pmc/
> diff --git a/drivers/platform/x86/intel/ifs/Kconfig b/drivers/platform/x86/intel/ifs/Kconfig
> new file mode 100644
> index 000000000000..51325b699563
> --- /dev/null
> +++ b/drivers/platform/x86/intel/ifs/Kconfig
> @@ -0,0 +1,2 @@
> +config INTEL_IFS_DEVICE
> +	bool
> diff --git a/drivers/platform/x86/intel/ifs/Makefile b/drivers/platform/x86/intel/ifs/Makefile
> new file mode 100644
> index 000000000000..12c2f5ce9925
> --- /dev/null
> +++ b/drivers/platform/x86/intel/ifs/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_INTEL_IFS_DEVICE)	+= intel_ifs_device.o
> diff --git a/drivers/platform/x86/intel/ifs/intel_ifs_device.c b/drivers/platform/x86/intel/ifs/intel_ifs_device.c
> new file mode 100644
> index 000000000000..64a143871d72
> --- /dev/null
> +++ b/drivers/platform/x86/intel/ifs/intel_ifs_device.c
> @@ -0,0 +1,50 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright(c) 2022 Intel Corporation. */
> +
> +#include <linux/platform_device.h>
> +#include <linux/init.h>
> +#include <asm/cpu_device_id.h>
> +
> +#define MSR_IA32_CORE_CAPS_INTEGRITY_BIT	2
> +#define MSR_IA32_CORE_CAPS_INTEGRITY		BIT(MSR_IA32_CORE_CAPS_INTEGRITY_BIT)
> +
> +#define X86_MATCH(model)					\
> +	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6,		\
> +		INTEL_FAM6_##model, X86_FEATURE_CORE_CAPABILITIES, NULL)
> +
> +static const struct x86_cpu_id ifs_cpu_ids[] __initconst = {
> +	X86_MATCH(SAPPHIRERAPIDS_X),
> +	{}
> +};
> +
> +static __init int register_ifs_device(void)
> +{
> +	struct platform_device *pdev;
> +	const struct x86_cpu_id *m;
> +	u64 ia32_core_caps;
> +
> +	m = x86_match_cpu(ifs_cpu_ids);
> +	if (!m)
> +		return -ENODEV;
> +
> +	if (rdmsrl_safe(MSR_IA32_CORE_CAPS, &ia32_core_caps))
> +		return -ENODEV;
> +
> +	if (ia32_core_caps & MSR_IA32_CORE_CAPS_INTEGRITY) {
> +		pdev = platform_device_alloc("intel_ifs", 0);
> +		if (pdev) {
> +			if (platform_device_add(pdev))
> +				platform_device_put(pdev);
> +		}
> +	}
> +
> +	/*
> +	 * Failure here will be visible by a missing device
> +	 * in sysfs. Returning an error code would not make
> +	 * that any easier to diagnose. Would also complicate
> +	 * future implementations that may support a subset of
> +	 * the types of tests.
> +	 */
> +	return 0;

So even if everything fails, you succeed?  But you are failing above for
some cases, so why is creating the device somehow special here that you
should succeed no matter what?

thanks,

greg k-h
