Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C434C50766A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348717AbiDSRXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241432AbiDSRXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:23:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C73736E26;
        Tue, 19 Apr 2022 10:21:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF9B2B8191F;
        Tue, 19 Apr 2022 17:20:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0EAC385A5;
        Tue, 19 Apr 2022 17:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650388857;
        bh=DiZaxboVhzLFzemPCR6xysQw7rQxfXOq4eSLN4tfiQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rUT6OfjAOs49csK6+pV4qfuM2w4nZlwfwaU1wAINCp9vYaOoJVp5l415gdVc4he/A
         NEjoWa3mIGtjofa3Jctsa2xCVPkTRdpD2lV+fOtV54Zfw0hAlxcshh1qVackwJVhGK
         LB/Qp9keBibVcjYQgK1HIKJBrF0bj/4Lz3oln5fU=
Date:   Tue, 19 Apr 2022 19:20:54 +0200
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
Subject: Re: [PATCH v3 09/11] platform/x86/intel/ifs: Add IFS sysfs interface
Message-ID: <Yl7vdpJgKYRL1jeW@kroah.com>
References: <20220407191347.9681-1-jithu.joseph@intel.com>
 <20220419163859.2228874-1-tony.luck@intel.com>
 <20220419163859.2228874-10-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419163859.2228874-10-tony.luck@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 09:38:57AM -0700, Tony Luck wrote:
> From: Jithu Joseph <jithu.joseph@intel.com>
> 
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
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> Co-developed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  drivers/platform/x86/intel/ifs/Makefile  |   2 +-
>  drivers/platform/x86/intel/ifs/core.c    |   9 ++
>  drivers/platform/x86/intel/ifs/ifs.h     |   3 +
>  drivers/platform/x86/intel/ifs/runtest.c |   7 ++
>  drivers/platform/x86/intel/ifs/sysfs.c   | 151 +++++++++++++++++++++++
>  5 files changed, 171 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/platform/x86/intel/ifs/sysfs.c
> 
> diff --git a/drivers/platform/x86/intel/ifs/Makefile b/drivers/platform/x86/intel/ifs/Makefile
> index 7de27361b479..dbbe0bf66987 100644
> --- a/drivers/platform/x86/intel/ifs/Makefile
> +++ b/drivers/platform/x86/intel/ifs/Makefile
> @@ -2,4 +2,4 @@ obj-$(CONFIG_INTEL_IFS_DEVICE)	+= intel_ifs_device.o
>  
>  obj-$(CONFIG_INTEL_IFS)		+= intel_ifs.o
>  
> -intel_ifs-objs			:= core.o load.o runtest.o
> +intel_ifs-objs			:= core.o load.o runtest.o sysfs.o
> diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
> index 0dc4cdda35ff..f56cde0cdfd6 100644
> --- a/drivers/platform/x86/intel/ifs/core.c
> +++ b/drivers/platform/x86/intel/ifs/core.c
> @@ -3,6 +3,7 @@
>  
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/semaphore.h>
>  
>  #include "ifs.h"
>  
> @@ -26,10 +27,18 @@ static int ifs_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +/*
> + * Note there is no need for a ->remove() call back. There isn't an
> + * "unload" operation to remove the scan binary from the BIOS reserved
> + * area. Also ".dev_groups" removal order will guarantee that any in
> + * flight tests have completed.
> + */

So you are ok with the warning the kernel gives you when you unload the
driver?  That feels wrong :(

> +
>  static struct platform_driver intel_ifs_driver = {
>  	.probe = ifs_probe,
>  	.driver = {
>  		.name = "intel_ifs",
> +		.dev_groups = plat_ifs_groups,
>  	},
>  };
>  
> diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
> index f5e3636d709f..4e6662f2d2f8 100644
> --- a/drivers/platform/x86/intel/ifs/ifs.h
> +++ b/drivers/platform/x86/intel/ifs/ifs.h
> @@ -97,4 +97,7 @@ int ifs_setup_wq(void);
>  void ifs_destroy_wq(void);
>  int do_core_test(int cpu, struct device *dev);
>  
> +extern const struct attribute_group *plat_ifs_groups[];
> +extern struct semaphore ifs_sem;
> +
>  #endif
> diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
> index 7793a01f7b94..246eff250563 100644
> --- a/drivers/platform/x86/intel/ifs/runtest.c
> +++ b/drivers/platform/x86/intel/ifs/runtest.c
> @@ -10,6 +10,13 @@
>  
>  #include "ifs.h"
>  
> +/*
> + * Note all code and data in this file is protected by
> + * ifs_sem. On HT systems all threads on a core will
> + * execute together, but only the first thread on the
> + * core will update results of the test and indicate
> + * completion.
> + */
>  static struct workqueue_struct *ifs_wq;
>  static struct completion test_thread_done;
>  static atomic_t siblings_in;
> diff --git a/drivers/platform/x86/intel/ifs/sysfs.c b/drivers/platform/x86/intel/ifs/sysfs.c
> new file mode 100644
> index 000000000000..41db2a12fbc8
> --- /dev/null
> +++ b/drivers/platform/x86/intel/ifs/sysfs.c
> @@ -0,0 +1,151 @@
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
> +/*
> + * Protects against simultaneous tests on multiple cores, or
> + * reloading can file while a test is in progress
> + */
> +DEFINE_SEMAPHORE(ifs_sem);
> +
> +/*
> + * The sysfs interface to check additional details of last test
> + * cat /sys/devices/system/platform/ifs/details
> + */
> +static ssize_t details_show(struct device *dev,
> +			    struct device_attribute *attr,
> +			    char *buf)
> +{
> +	struct ifs_data *ifsd = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%#llx\n", ifsd->scan_details);
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
> +	struct ifs_data *ifsd = dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%s\n", status_msg[ifsd->status]);
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
> +	struct ifs_data *ifsd = dev_get_drvdata(dev);
> +	unsigned int cpu;
> +	int rc;
> +
> +	rc = kstrtouint(buf, 0, &cpu);
> +	if (rc < 0 || cpu >= nr_cpu_ids)
> +		return -EINVAL;
> +
> +	if (down_interruptible(&ifs_sem))
> +		return -EINTR;
> +
> +	if (!ifsd->loaded)
> +		rc = -EPERM;
> +	else
> +		rc = do_core_test(cpu, dev);
> +
> +	up(&ifs_sem);
> +
> +	return rc ? rc : count;
> +}
> +
> +static DEVICE_ATTR_WO(run_test);
> +
> +/*
> + * Reload the IFS image. When user wants to install new IFS image
> + */
> +static ssize_t reload_store(struct device *dev,
> +			    struct device_attribute *attr,
> +			    const char *buf, size_t count)
> +{
> +	struct ifs_data *ifsd = dev_get_drvdata(dev);
> +	int rc;
> +
> +	if (!sysfs_streq(buf, "1"))

kstrtobool()?

> +		return -EINVAL;
> +
> +	if (down_interruptible(&ifs_sem))
> +		return -EINTR;
> +
> +	rc = load_ifs_binary(dev);
> +
> +	ifsd->loaded = (rc == 0);
> +
> +	up(&ifs_sem);
> +
> +	return rc ? rc : count;
> +}
> +
> +static DEVICE_ATTR_WO(reload);
> +
> +/*
> + * Display currently loaded IFS image version.
> + */
> +static ssize_t image_version_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	struct ifs_data *ifsd = dev_get_drvdata(dev);
> +
> +	if (!ifsd->loaded)
> +		return sysfs_emit(buf, "%s\n", "none");
> +	else
> +		return sysfs_emit(buf, "%#x\n", ifsd->loaded_version);
> +}
> +
> +static DEVICE_ATTR_RO(image_version);
> +
> +/* global scan sysfs attributes */
> +static struct attribute *plat_ifs_attrs[] = {
> +	&dev_attr_details.attr,
> +	&dev_attr_status.attr,
> +	&dev_attr_run_test.attr,
> +	&dev_attr_reload.attr,
> +	&dev_attr_image_version.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group plat_ifs_attr_group = {
> +	.attrs = plat_ifs_attrs,
> +};
> +
> +const struct attribute_group *plat_ifs_groups[] = {
> +	&plat_ifs_attr_group,
> +	NULL
> +};

ATTRIBUTE_GROUPS()?

thanks,

greg k-h
