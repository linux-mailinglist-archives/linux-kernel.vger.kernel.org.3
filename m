Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF8A52B2E8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 09:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbiERHJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 03:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbiERHJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 03:09:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0175EBCE95
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 00:09:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7A4CB81E91
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 07:09:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBCF5C385AA;
        Wed, 18 May 2022 07:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652857755;
        bh=5VOCG6D7WIJ+aptpFBTKRAjSL5vE+/rVyHeXhlnHmuo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mCDVzWkIzB5296VRCBwWDjhnnI6AHpE8Oz3xvcwgGItJaDFFprY0SiAENX9e2eD8y
         fNHpHFVPH1/x2Trt/GPuW0OA4XamPZAa8d43KXAEXdk1R6Kz3lDk5aZH1Uhz9pu6lV
         QyH39GovNr+oznN7Ua8c5oP3rLN00DY3+Lve1cio=
Date:   Wed, 18 May 2022 09:09:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, rafael@kernel.org,
        mchehab+huawei@kernel.org, eugenis@google.com, tony.luck@intel.com,
        pcc@google.com, peterz@infradead.org, marcos@orca.pet,
        conor.dooley@microchip.com, nicolas.ferre@microchip.com,
        marcan@marcan.st, linus.walleij@linaro.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/8] drivers: base: Add hardware prefetch control core
 driver
Message-ID: <YoSbmA+5m1Le0XGe@kroah.com>
References: <20220518063032.2377351-1-tarumizu.kohei@fujitsu.com>
 <20220518063032.2377351-2-tarumizu.kohei@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518063032.2377351-2-tarumizu.kohei@fujitsu.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 03:30:25PM +0900, Kohei Tarumizu wrote:
> Adds a register/unregister function to provide sysfs interface to
> control CPU's hardware prefetch behavior. It creates the
> "prefetch_control" sysfs directory and some attributes.
> 
> Attributes are hardware dependent, so it must be implemented for each
> hardware. If CPU has a hardware prefetch behavior, call this function
> to create sysfs.
> 
> Following patches add support for A64FX and x86.
> 
> Signed-off-by: Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
> ---
>  drivers/base/pfctl.c  | 180 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pfctl.h |  14 ++++
>  2 files changed, 194 insertions(+)
>  create mode 100644 drivers/base/pfctl.c
>  create mode 100644 include/linux/pfctl.h
> 
> diff --git a/drivers/base/pfctl.c b/drivers/base/pfctl.c
> new file mode 100644
> index 000000000000..08ee8faaf277
> --- /dev/null
> +++ b/drivers/base/pfctl.c
> @@ -0,0 +1,180 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Hardware prefetch control support via sysfs.
> + *
> + * Copyright 2022 FUJITSU LIMITED
> + *
> + * See Documentation/ABI/testing/sysfs-devices-system-cpu for more information.
> + */
> +
> +#include <linux/cacheinfo.h>
> +#include <linux/cpu.h>
> +#include <linux/device.h>
> +#include <linux/pfctl.h>
> +#include <linux/slab.h>
> +
> +#ifdef pr_fmt
> +#undef pr_fmt
> +#endif
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +const struct pfctl_group *pgroups;
> +enum cpuhp_state hp_online;
> +
> +static struct device_attribute **
> +get_pfctl_attribute(unsigned int level, enum cache_type type)
> +{
> +	int i;
> +
> +	for (i = 0; pgroups[i].attrs; i++)
> +		if ((level == pgroups[i].level) && (type == pgroups[i].type))
> +			return pgroups[i].attrs;
> +
> +	return NULL;
> +}
> +
> +static int remove_pfctl_attr(struct device *index_dev, void *data)
> +{
> +	struct cacheinfo *leaf = dev_get_drvdata(index_dev);
> +	struct device_attribute **attrs;
> +	struct device *pfctl_dev;
> +	int i;
> +
> +	attrs = get_pfctl_attribute(leaf->level, leaf->type);
> +	if (!attrs)
> +		return 0;
> +
> +	pfctl_dev = device_find_child_by_name(index_dev, "prefetch_control");
> +	if (!pfctl_dev)
> +		return 0;
> +
> +	for (i = 0; attrs[i]; i++)
> +		device_remove_file(pfctl_dev, attrs[i]);

This feels wrong, attributes should be groups and be automatically added
and removed by the driver core that way.  Not as lists of attributes
like this, as that will race and be wrong.

Use a list of attribute groups please.

> +
> +	device_unregister(pfctl_dev);
> +	put_device(pfctl_dev);
> +
> +	pfctl_dev = NULL;
> +
> +	return 0;
> +}
> +
> +static int create_pfctl_attr(struct device *index_dev, void *data)
> +{
> +	struct cacheinfo *leaf = dev_get_drvdata(index_dev);
> +	struct device_attribute **attrs;
> +	struct device *pfctl_dev;
> +	int i, err;
> +
> +	attrs = get_pfctl_attribute(leaf->level, leaf->type);
> +	if (!attrs)
> +		return 0;
> +
> +	pfctl_dev = cpu_device_create(index_dev, NULL, NULL,
> +				      "prefetch_control");
> +	if (IS_ERR(pfctl_dev))
> +		return PTR_ERR(pfctl_dev);
> +
> +	for (i = 0; attrs[i]; i++) {
> +		err = device_create_file(pfctl_dev, attrs[i]);

You just raced with userspace and lost :(

Please use attribute groups instead of manually adding files after the
device is created and userspace is notified that it was present.

That also makes your clean up logic much simpler (i.e. none as the drive
core did it for you already.)

> +		if (err) {
> +			while (--i >= 0)
> +				device_remove_file(pfctl_dev, attrs[i]);
> +
> +			device_unregister(pfctl_dev);
> +			pfctl_dev = NULL;
> +
> +			return err;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int pfctl_online(unsigned int cpu)
> +{
> +	struct device *cpu_dev = get_cpu_device(cpu);
> +	struct device *cache_dev;
> +	int ret;
> +
> +	cache_dev = device_find_child_by_name(cpu_dev, "cache");
> +	if (!cache_dev)
> +		return -ENODEV;
> +
> +	ret = device_for_each_child(cache_dev, NULL, create_pfctl_attr);
> +	if (ret < 0)
> +		device_for_each_child(cache_dev, NULL, remove_pfctl_attr);
> +
> +	put_device(cache_dev);
> +
> +	return ret;
> +}
> +
> +static int pfctl_prepare_down(unsigned int cpu)
> +{
> +	struct device *cpu_dev = get_cpu_device(cpu);
> +	struct device *cache_dev;
> +
> +	cache_dev = device_find_child_by_name(cpu_dev, "cache");
> +	if (!cache_dev)
> +		return 0;
> +
> +	device_for_each_child(cache_dev, NULL, remove_pfctl_attr);
> +
> +	put_device(cache_dev);
> +
> +	return 0;
> +}
> +
> +/**
> + * pfctl_register_attrs - register a Hardware Prefetch Control attributes
> + * @pfctl_groups: pfctl_groups contains device attribute group to control the
> + *                hardware prefetch register.
> + *
> + * Note: Call this function after the cache device is initialized because it
> + * requires access to the cache device. (e.g. Call at the late_initcall)
> + *
> + * Context: Any context.
> + * Return: 0 on success, negative error code on failure.
> + */
> +int pfctl_register_attrs(const struct pfctl_group *pfctl_groups)
> +{
> +	int ret;
> +
> +	if (pgroups)
> +		return -EEXIST;
> +
> +	pgroups = pfctl_groups;
> +
> +	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "base/pfctl:online",
> +				pfctl_online, pfctl_prepare_down);
> +	if (ret < 0) {
> +		pr_err("failed to register hotplug callbacks\n");
> +		pgroups = NULL;
> +		return ret;
> +	}
> +
> +	hp_online = ret;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pfctl_register_attrs);
> +
> +/**
> + * pfctl_unregister_attrs - unregister the Hardware Prefetch Control driver
> + * @pfctl_groups: Used to verify that this function is called by the same driver
> + *                that called pfctl_register_attrs.
> + *
> + * Context: Any context.
> + * Return: nothing.
> + */
> +void pfctl_unregister_attrs(const struct pfctl_group *pfctl_groups)
> +{
> +	if (!pgroups || (pfctl_groups != pgroups))
> +		return;
> +
> +	cpuhp_remove_state(hp_online);
> +
> +	pgroups = NULL;
> +}
> +EXPORT_SYMBOL_GPL(pfctl_unregister_attrs);
> diff --git a/include/linux/pfctl.h b/include/linux/pfctl.h
> new file mode 100644
> index 000000000000..ecdab78be09f
> --- /dev/null
> +++ b/include/linux/pfctl.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_PFCTL_H
> +#define _LINUX_PFCTL_H
> +
> +struct pfctl_group {
> +	unsigned int		level;
> +	enum cache_type		type;
> +	struct device_attribute	**attrs;

Attribute groups please.

> +};
> +
> +int pfctl_register_attrs(const struct pfctl_group *pfctl_groups);
> +void pfctl_unregister_attrs(const struct pfctl_group *pfctl_groups);

Why do you think this needs to be in the driver core?  Why isn't this
just a normal cpu driver?

thanks,

greg k-h
