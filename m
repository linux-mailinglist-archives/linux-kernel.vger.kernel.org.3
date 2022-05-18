Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECFF52B2B3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 08:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbiERGnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 02:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbiERGnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 02:43:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDCF1DA68
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 23:43:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45AB1617C4
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 06:43:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9204C385A9;
        Wed, 18 May 2022 06:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652856199;
        bh=296csENr6RY1hKFoBASlhcf97nf1BLor5PsmVeI8xsc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LC3iKAXJcsz/eChz3vlTOEWReW68KMrjC8Tlt1FcueQIls4LvhltiDa/XNCmRZGoo
         3YoUAdzgJl5Tx2DuqBIX59p8JRXaEvGgoZyVuHUzRZLS6FYaf3oy1ah0svqZI57yrE
         Akv2RPJHdaDEO95qppXO9ZPVatX7Vm5SQ2afw/JY=
Date:   Wed, 18 May 2022 08:43:14 +0200
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
Subject: Re: [PATCH v4 6/8] x86: Add hardware prefetch control support for x86
Message-ID: <YoSVglItX1PhveEP@kroah.com>
References: <20220518063032.2377351-1-tarumizu.kohei@fujitsu.com>
 <20220518063032.2377351-7-tarumizu.kohei@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518063032.2377351-7-tarumizu.kohei@fujitsu.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 03:30:30PM +0900, Kohei Tarumizu wrote:
> +/*
> + * Returns the cpu number of the cpu_device(/sys/devices/system/cpu/cpuX)
> + * in the ancestor directory of prefetch_control.
> + *
> + * When initializing this driver, it is verified that the cache directory exists
> + * under cpuX device. Therefore, the third level up from prefetch_control is
> + * cpuX device as shown below.
> + *
> + * /sys/devices/system/cpu/cpuX/cache/indexX/prefetch_control
> + */
> +static inline unsigned int pfctl_dev_get_cpu(struct device *pfctl_dev)
> +{
> +	return pfctl_dev->parent->parent->parent->id;

As much fun as it is to see a function like this, that is not ok, and
never guaranteed to keep working, sorry.  Please find the device
properly, never assume a specific driver model topology as they are
guaranteed to break over time and never supposed to be static like this.



> +}
> +
> +static ssize_t
> +pfctl_show(struct device *pfctl_dev, struct device_attribute *attr, char *buf)
> +{
> +	unsigned int cpu = pfctl_dev_get_cpu(pfctl_dev);
> +	struct x86_pfctl_attr *xa;
> +	u64 val;
> +
> +	xa = container_of(attr, struct x86_pfctl_attr, attr);
> +
> +	rdmsrl_on_cpu(cpu, MSR_MISC_FEATURE_CONTROL, &val);
> +	return sysfs_emit(buf, "%d\n", val & xa->mask ? 0 : 1);
> +}
> +
> +struct write_info {
> +	u64 mask;
> +	bool enable;
> +};
> +
> +/*
> + * wrmsrl() in this patch is only done inside of an interrupt-disabled region
> + * to avoid a conflict of write access from other drivers,
> + */
> +static void pfctl_write(void *info)
> +{
> +	struct write_info *winfo = info;
> +	u64 reg;
> +
> +	reg = 0;
> +	rdmsrl(MSR_MISC_FEATURE_CONTROL, reg);
> +
> +	if (winfo->enable)
> +		reg &= ~winfo->mask;
> +	else
> +		reg |= winfo->mask;
> +
> +	wrmsrl(MSR_MISC_FEATURE_CONTROL, reg);
> +}
> +
> +/*
> + * MSR_MISC_FEATURE_CONTROL has "core" scope, so define the lock to avoid a
> + * conflict of write access from different logical processors in the same core.
> + */
> +static DEFINE_MUTEX(pfctl_mutex);
> +
> +static ssize_t
> +pfctl_store(struct device *pfctl_dev, struct device_attribute *attr,
> +	    const char *buf, size_t size)
> +{
> +	unsigned int cpu = pfctl_dev_get_cpu(pfctl_dev);
> +	struct x86_pfctl_attr *xa;
> +	struct write_info info;
> +
> +	xa = container_of(attr, struct x86_pfctl_attr, attr);
> +	info.mask = xa->mask;
> +
> +	if (strtobool(buf, &info.enable) < 0)
> +		return -EINVAL;
> +
> +	mutex_lock(&pfctl_mutex);
> +	smp_call_function_single(cpu, pfctl_write, &info, true);
> +	mutex_unlock(&pfctl_mutex);
> +
> +	return size;
> +}
> +
> +#define PFCTL_ATTR(_name, _level, _bit)					\
> +	struct x86_pfctl_attr attr_l##_level##_##_name = {		\
> +		.attr = __ATTR(_name, 0600, pfctl_show, pfctl_store),	\
> +		.mask = BIT_ULL(_bit), }
> +
> +static PFCTL_ATTR(hardware_prefetcher_enable,			1, 2);
> +static PFCTL_ATTR(hardware_prefetcher_enable,			2, 0);
> +static PFCTL_ATTR(ip_prefetcher_enable,				1, 3);
> +static PFCTL_ATTR(adjacent_cache_line_prefetcher_enable,	2, 1);
> +
> +static struct device_attribute *l1_attrs[] __ro_after_init = {

How do you know attributes are to be marked read only after init?  Do
other parts of the kernel do that?  I don't think the driver core
guarantees that at all.

thanks,

greg k-h
