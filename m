Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1CE4F8DF3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234801AbiDHFCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 01:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbiDHFBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 01:01:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459DA19E39F;
        Thu,  7 Apr 2022 21:59:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E82FB829B6;
        Fri,  8 Apr 2022 04:59:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94920C385A9;
        Fri,  8 Apr 2022 04:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649393963;
        bh=L/WHVqu6oXXWB4ZDJIpAw8g8GHxO3sA9DNFDL/KsO0c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QSy6I2plQUP3T1DugJ/2xySuOtcqRrs9EzjDIvkjDVmIDbszWly0qr6Vy/7iRo+0u
         RSLcj+qzsPZIT2EF6NXKF84qnqovFcsQvtgujs4T1ZOw6EaG3I7VFU35Wc/ogPkopQ
         HPXSFRM1WDtEPhtVuNXbvRXvvHGy9wLAsr47noeE=
Date:   Fri, 8 Apr 2022 06:59:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jithu Joseph <jithu.joseph@intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, corbet@lwn.net,
        andriy.shevchenko@linux.intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, rostedt@goodmis.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com
Subject: Re: [PATCH v2 08/10] platform/x86/intel/ifs: Add IFS sysfs interface
Message-ID: <Yk/BKInZAsNPvyNa@kroah.com>
References: <20220407191347.9681-1-jithu.joseph@intel.com>
 <20220407191347.9681-9-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407191347.9681-9-jithu.joseph@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 12:13:45PM -0700, Jithu Joseph wrote:
> Implement sysfs interface to trigger ifs test for a specific cpu.
> Additional interfaces related to checking the status of the
> scan test and seeing the version of the loaded IFS binary
> are also added.
> 
> The basic usage is as below.
>    - To start test, for example on cpu5:
>        echo 5 > /sys/devices/platform/intel_ifs/run_test
>    - To see the status of the last test
>        cat /sys/devices/platform/intel_ifs/status
>    - To see the version of the loaded scan binary
>        cat /sys/devices/platform/intel_ifs/image_version
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> ---
>  drivers/platform/x86/intel/ifs/Makefile |   2 +-
>  drivers/platform/x86/intel/ifs/core.c   |   1 +
>  drivers/platform/x86/intel/ifs/ifs.h    |   2 +
>  drivers/platform/x86/intel/ifs/sysfs.c  | 139 ++++++++++++++++++++++++
>  4 files changed, 143 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/platform/x86/intel/ifs/sysfs.c
> 
> diff --git a/drivers/platform/x86/intel/ifs/Makefile b/drivers/platform/x86/intel/ifs/Makefile
> index d5905e5d2de8..93745fcdf652 100644
> --- a/drivers/platform/x86/intel/ifs/Makefile
> +++ b/drivers/platform/x86/intel/ifs/Makefile
> @@ -1,3 +1,3 @@
>  obj-$(CONFIG_INTEL_IFS)			+= intel_ifs.o
>  
> -intel_ifs-objs				:= core.o load.o runtest.o
> +intel_ifs-objs				:= core.o load.o runtest.o sysfs.o
> diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
> index 95847e00038b..85442953d0f5 100644
> --- a/drivers/platform/x86/intel/ifs/core.c
> +++ b/drivers/platform/x86/intel/ifs/core.c
> @@ -82,6 +82,7 @@ static int __init ifs_init(void)
>  		goto drv_unreg;
>  	}
>  
> +	ifs_sysfs_add();
>  	ret = platform_device_add(ifs_pdev);
>  	if (ret) {
>  		pr_err("intel_ifs: platform device add failed\n");
> diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
> index 93cc1af4aea0..3200d9de4436 100644
> --- a/drivers/platform/x86/intel/ifs/ifs.h
> +++ b/drivers/platform/x86/intel/ifs/ifs.h
> @@ -127,6 +127,8 @@ struct ifs_test {
>  
>  int load_ifs_binary(void);
>  int do_core_test(int cpu);
> +void ifs_sysfs_add(void);
> +
>  extern struct platform_device *ifs_pdev;
>  extern struct ifs_binary ifs_binary;
>  extern struct ifs_test ifs_test;
> diff --git a/drivers/platform/x86/intel/ifs/sysfs.c b/drivers/platform/x86/intel/ifs/sysfs.c
> new file mode 100644
> index 000000000000..f6decebbeae9
> --- /dev/null
> +++ b/drivers/platform/x86/intel/ifs/sysfs.c
> @@ -0,0 +1,139 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2022 Intel Corporation. */
> +
> +#include <linux/cpu.h>
> +#include <linux/delay.h>
> +#include <linux/fs.h>
> +#include <linux/platform_device.h>
> +#include <linux/semaphore.h>
> +#include <linux/slab.h>
> +
> +#include "ifs.h"
> +
> +static DEFINE_SEMAPHORE(ifs_sem);
> +
> +/*
> + * The sysfs interface to check additional details of last test
> + * cat /sys/devices/system/platform/ifs/details
> + */
> +static ssize_t details_show(struct device *dev,
> +			    struct device_attribute *attr,
> +			    char *buf)
> +{
> +	int ret;
> +
> +	if (down_trylock(&ifs_sem))
> +		return -EBUSY;

Why do you care about locking here at all?

> +
> +	ret = sysfs_emit(buf, "%#llx\n", ifs_test.scan_details);
> +	up(&ifs_sem);

What are you protecting?  The value can change right after the lock is
released, so who cares?

> +
> +	return ret;
> +}
> +
> +static DEVICE_ATTR_RO(details);
> +
> +static const char * const status_msg[] = {
> +	[SCAN_NOT_TESTED] = "untested",
> +	[SCAN_TEST_PASS] = "pass",
> +	[SCAN_TEST_FAIL] = "fail"
> +};
> +
> +/*
> + * The sysfs interface to check the test status:
> + * To check the status of last test
> + * cat /sys/devices/platform/ifs/status
> + */
> +static ssize_t status_show(struct device *dev,
> +			   struct device_attribute *attr,
> +			   char *buf)
> +{
> +	int ret;
> +
> +	if (down_trylock(&ifs_sem))
> +		return -EBUSY;
> +
> +	ret = sysfs_emit(buf, "%s\n", status_msg[ifs_test.status]);
> +
> +	up(&ifs_sem);
> +
> +	return ret;
> +}
> +
> +static DEVICE_ATTR_RO(status);
> +
> +/*
> + * The sysfs interface for single core testing
> + * To start test, for example, cpu5
> + * echo 5 > /sys/devices/platform/ifs/run_test
> + * To check the result:
> + * cat /sys/devices/platform/ifs/result
> + * The sibling core gets tested at the same time.
> + */
> +static ssize_t run_test_store(struct device *dev,
> +			      struct device_attribute *attr,
> +			      const char *buf, size_t count)
> +{
> +	unsigned int cpu;
> +	int ret = count;
> +	int rc;
> +
> +	if (!ifs_binary.loaded) {
> +		dev_info(&ifs_pdev->dev, "Load scan binary using driver bind interface\n");

Do not allow userspace to spam kernel logs for no reason :(

sysfs files are not "help files" in the kernel.

> +		return -EPERM;
> +	}
> +
> +	if (ifs_disabled)
> +		return -ENXIO;
> +
> +	rc = kstrtouint(buf, 0, &cpu);
> +	if (rc < 0 || cpu >= nr_cpu_ids)
> +		return -EINVAL;
> +
> +	if (down_trylock(&ifs_sem))
> +		return -EBUSY;
> +
> +	rc = do_core_test(cpu);
> +	if (rc)
> +		ret = rc;
> +
> +	up(&ifs_sem);
> +
> +	return ret;
> +}
> +
> +static DEVICE_ATTR_WO(run_test);
> +
> +/*
> + * Currently loaded IFS image version.
> + */
> +static ssize_t image_version_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%#x\n", ifs_binary.loaded_version);
> +}
> +
> +static DEVICE_ATTR_RO(image_version);
> +
> +/* global scan sysfs attributes */
> +static struct attribute *plat_ifs_attrs[] = {
> +	&dev_attr_image_version.attr,
> +	&dev_attr_run_test.attr,
> +	&dev_attr_status.attr,
> +	&dev_attr_details.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group plat_ifs_attr_group = {
> +	.attrs = plat_ifs_attrs,
> +};
> +
> +static const struct attribute_group *plat_ifs_groups[] = {
> +	&plat_ifs_attr_group,
> +	NULL
> +};
> +
> +void ifs_sysfs_add(void)
> +{
> +	ifs_pdev->dev.groups = plat_ifs_groups;

Why do you have a single global structure?

{sigh}


