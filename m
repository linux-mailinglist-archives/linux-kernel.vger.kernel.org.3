Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DC352E167
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 02:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344150AbiETAwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 20:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbiETAwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 20:52:42 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C282741999;
        Thu, 19 May 2022 17:52:40 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id t6so9445286wra.4;
        Thu, 19 May 2022 17:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=8wmu68V4CsX/EUhtdLMZtJOtGaV8vxzQ5sczCJqnhcM=;
        b=NT5kma0B7Op4v2qovqLRUNpC6SqHdqRVsspUeL4JOFv0uoOWMVa5xL2KWipXwhCATy
         8BWz8tjm3Ta4bflZp1Ev59HwdwK7evHDpFx6gKeUneLZ9OPr7ci0m8mKBxjJpw2QePlo
         XlrCGrJ7vj828yV3jF9K50FWfEd1Z6tVdR4ClhBHE1SvwEzAliKtP8HV88kgVmNhGt4w
         BKBQBokvWv1RH96525koPJtWHNc2DCywF1W2CzDT07Bp7jv0bWyinSbCOTEvTNQFMrq6
         PRN9WfEV57n9Op3wqTeG6xbpP4xdMR7NDFRPysdFIb/8tvJfXDWu0F9zWCfUTHvbxuIC
         WA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=8wmu68V4CsX/EUhtdLMZtJOtGaV8vxzQ5sczCJqnhcM=;
        b=LFR7gVKKXgQ/QYchyVglMRtPIm7vn7uidvopUDoVEgj7nKHcRou3fRpV3wDouAdZXx
         IXWf/7gtedVJPsdmgkig/wnE73Xkr+5QEw9RPyXoI2jc4pvWF051GU6985g1mcWXWX2i
         VMe11lOM4/7+Sga3U4w+hvITuDgkv37xgxRpZphtQbzLHntgqPX5Me5++U6hXq/Z5fa+
         vpEgqKxOL4Hyyqzzu23tnZhADwoSRGYqhd30G3pyYclYGMS6DTI8wPLYz/vcuK2fTahR
         L+TgZb4vDyWRj0db0OKTsjkWHC3LXheFvB28aUpph31r9RYHWEIB1ypGXdia3SFKdV2D
         bWYQ==
X-Gm-Message-State: AOAM530U0BxftzxMKlem+H2s+4FptYvBZE4ymZg2+xDgnqjk6Xkn+55N
        P7fQvwd3DNaUdudyFh5jS4A=
X-Google-Smtp-Source: ABdhPJwc8Bb01KOPGzN1thsODDHXEi1v+DZ6lfdVI+U7aMQ4AnhZTFY7m7MqzcIcJIx0+cRpfWhBnQ==
X-Received: by 2002:a05:6000:1acc:b0:20c:67ff:e8b7 with SMTP id i12-20020a0560001acc00b0020c67ffe8b7mr6170381wry.646.1653007959005;
        Thu, 19 May 2022 17:52:39 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id e30-20020adfa45e000000b0020c5253d8e6sm916921wra.50.2022.05.19.17.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 17:52:38 -0700 (PDT)
Message-ID: <6286e656.1c69fb81.27e64.4cfc@mx.google.com>
X-Google-Original-Message-ID: <YobmVODvpR9Uk0Hu@Ansuel-xps.>
Date:   Fri, 20 May 2022 02:52:36 +0200
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/2] devfreq: qcom: Add L2 Krait Cache devfreq scaling
 driver
References: <CGME20200929162941epcas1p4a6f524f2406785934918c2a9f556ae4b@epcas1p4.samsung.com>
 <20200929162926.139-1-ansuelsmth@gmail.com>
 <53bcf684-54e7-13e2-2b41-26b6791f7469@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53bcf684-54e7-13e2-2b41-26b6791f7469@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 10:11:16AM +0900, Chanwoo Choi wrote:
> Hi Ansuel,
> 
> 
> The 5.19-rc1 will support the cpu based scaling support[2]
> as your needed. So that if you use passive governor with CPUFREQ_PARENT_DEV,
> you can scale the cache frequency according to cpu frequency change.
> 
> [1] https://patchwork.kernel.org/project/linux-pm/patch/3acd6c32-6e78-dfc2-3e45-84f69a7d5f36@samsung.com/
> [2] PM / devfreq: Add cpu based scaling support to passive governor
> 
> 
> Best Regards,
> Chanwoo Choi
>

Oh wow thanks a lot for this. Wonder if this is finally the right time
for a correct handling of cache scaling for krait. Will rework this and
send a new version with the new implementation!
Again thanks.

> On 9/30/20 1:29 AM, Ansuel Smith wrote:
> > Qcom L2 Krait CPUs use the generic cpufreq-dt driver and doesn't actually
> > scale the Cache frequency when the CPU frequency is changed. This
> > devfreq driver register with the cpu notifier and scale the Cache
> > based on the max Freq across all core as the CPU cache is shared across
> > all of them. If provided this also scale the voltage of the regulator
> > attached to the CPU cache. The scaling logic is based on the CPU freq
> > and the 3 scaling interval are set by the device dts.
> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> > v2:
> > * Change cpu-freq to qcom,cpu-freq
> > * Skip freq change if prev is the same target freq
> > 
> >  drivers/devfreq/Kconfig               |  10 +
> >  drivers/devfreq/Makefile              |   1 +
> >  drivers/devfreq/krait-cache-devfreq.c | 301 ++++++++++++++++++++++++++
> >  3 files changed, 312 insertions(+)
> >  create mode 100644 drivers/devfreq/krait-cache-devfreq.c
> > 
> > diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> > index 37dc40d1fcfb..99051aaf9c5e 100644
> > --- a/drivers/devfreq/Kconfig
> > +++ b/drivers/devfreq/Kconfig
> > @@ -143,6 +143,16 @@ config ARM_RK3399_DMC_DEVFREQ
> >  	  It sets the frequency for the memory controller and reads the usage counts
> >  	  from hardware.
> >  
> > +config ARM_KRAIT_CACHE_DEVFREQ
> > +	tristate "Scaling support for Krait CPU Cache Devfreq"
> > +	depends on ARCH_QCOM || COMPILE_TEST
> > +	help
> > +	  This adds the DEVFREQ driver for the Krait CPU L2 Cache shared by all cores.
> > +
> > +	  The driver register with the cpufreq notifier and find the right frequency
> > +	  based on the max frequency across all core and the range set in the device
> > +	  dts. If provided this scale also the regulator attached to the l2 cache.
> > +
> >  source "drivers/devfreq/event/Kconfig"
> >  
> >  endif # PM_DEVFREQ
> > diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
> > index 3ca1ad0ecb97..bb87925a6a2d 100644
> > --- a/drivers/devfreq/Makefile
> > +++ b/drivers/devfreq/Makefile
> > @@ -14,6 +14,7 @@ obj-$(CONFIG_ARM_IMX8M_DDRC_DEVFREQ)	+= imx8m-ddrc.o
> >  obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
> >  obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra30-devfreq.o
> >  obj-$(CONFIG_ARM_TEGRA20_DEVFREQ)	+= tegra20-devfreq.o
> > +obj-$(CONFIG_ARM_KRAIT_CACHE_DEVFREQ)	+= krait-cache-devfreq.o
> >  
> >  # DEVFREQ Event Drivers
> >  obj-$(CONFIG_PM_DEVFREQ_EVENT)		+= event/
> > diff --git a/drivers/devfreq/krait-cache-devfreq.c b/drivers/devfreq/krait-cache-devfreq.c
> > new file mode 100644
> > index 000000000000..101a13b6927a
> > --- /dev/null
> > +++ b/drivers/devfreq/krait-cache-devfreq.c
> > @@ -0,0 +1,301 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/init.h>
> > +#include <linux/module.h>
> > +#include <linux/cpufreq.h>
> > +#include <linux/devfreq.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/clk.h>
> > +#include <linux/slab.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/pm_opp.h>
> > +
> > +#include "governor.h"
> > +
> > +struct krait_data {
> > +	struct device *dev;
> > +	struct devfreq *devfreq;
> > +
> > +	struct clk *l2_clk;
> > +
> > +	unsigned long *freq_table; /* L2 bus clock rate */
> > +	unsigned int *l2_cpufreq; /* L2 target CPU frequency */
> > +
> > +	struct notifier_block nb;
> > +};
> > +
> > +static int krait_cache_set_opp(struct dev_pm_set_opp_data *data)
> > +{
> > +	unsigned long old_freq = data->old_opp.rate, freq = data->new_opp.rate;
> > +	struct dev_pm_opp_supply *supply = &data->new_opp.supplies[0];
> > +	struct regulator *reg = data->regulators[0];
> > +	struct clk *clk = data->clk;
> > +	struct krait_data *kdata;
> > +	unsigned long idle_freq;
> > +	int ret;
> > +
> > +	kdata = (struct krait_data *)dev_get_drvdata(data->dev);
> > +
> > +	idle_freq = kdata->freq_table[0];
> > +
> > +	if (reg) {
> > +		ret = regulator_set_voltage_triplet(reg, supply->u_volt_min,
> > +						    supply->u_volt,
> > +						    supply->u_volt_max);
> > +		if (ret)
> > +			goto exit;
> > +	}
> > +
> > +	/*
> > +	 * Set to idle bin if switching from normal to high bin
> > +	 * or vice versa. It has been notice that a bug is triggered
> > +	 * in cache scaling when more than one bin is scaled, to fix
> > +	 * this we first need to transition to the base rate and then
> > +	 * to target rate
> > +	 */
> > +	if (likely(freq != idle_freq && old_freq != idle_freq)) {
> > +		ret = clk_set_rate(clk, idle_freq);
> > +		if (ret)
> > +			goto exit;
> > +	}
> > +
> > +	ret = clk_set_rate(clk, freq);
> > +	if (ret)
> > +		goto exit;
> > +
> > +exit:
> > +	return ret;
> > +};
> > +
> > +static int krait_cache_target(struct device *dev, unsigned long *freq,
> > +			      u32 flags)
> > +{
> > +	return dev_pm_opp_set_rate(dev, *freq);
> > +};
> > +
> > +static int krait_cache_get_dev_status(struct device *dev,
> > +				      struct devfreq_dev_status *stat)
> > +{
> > +	struct krait_data *data = dev_get_drvdata(dev);
> > +
> > +	stat->busy_time = 0;
> > +	stat->total_time = 0;
> > +	stat->current_frequency = clk_get_rate(data->l2_clk);
> > +
> > +	return 0;
> > +};
> > +
> > +static int krait_cache_get_cur_freq(struct device *dev, unsigned long *freq)
> > +{
> > +	struct krait_data *data = dev_get_drvdata(dev);
> > +
> > +	*freq = clk_get_rate(data->l2_clk);
> > +
> > +	return 0;
> > +};
> > +
> > +static struct devfreq_dev_profile tegra_devfreq_profile = {
> > +	.target = krait_cache_target,
> > +	.get_dev_status = krait_cache_get_dev_status,
> > +	.get_cur_freq = krait_cache_get_cur_freq
> > +};
> > +
> > +static int krait_cache_notifier(struct notifier_block *nb, unsigned long action,
> > +				void *v)
> > +{
> > +	struct cpufreq_freqs *freqs;
> > +	unsigned int cpu, cur_cpu;
> > +	struct krait_data *data;
> > +	struct devfreq *devfreq;
> > +	unsigned long freq;
> > +	int ret = 0;
> > +
> > +	if (action != CPUFREQ_POSTCHANGE)
> > +		return NOTIFY_OK;
> > +
> > +	data = container_of(nb, struct krait_data, nb);
> > +	devfreq = data->devfreq;
> > +
> > +	mutex_lock_nested(&devfreq->lock, SINGLE_DEPTH_NESTING);
> > +
> > +	freqs = (struct cpufreq_freqs *)v;
> > +	freq = freqs->new;
> > +	cur_cpu = freqs->policy->cpu;
> > +
> > +	/* find the max freq across all core */
> > +	for_each_present_cpu(cpu)
> > +		if (cpu != cur_cpu)
> > +			freq = max(freq, (unsigned long)cpufreq_quick_get(cpu));
> > +
> > +	devfreq->governor->get_target_freq(devfreq, &freq);
> > +
> > +	if (devfreq->previous_freq == freq)
> > +		goto out;
> > +
> > +	ret = devfreq->profile->target(data->dev, &freq, 0);
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +	if (devfreq->profile->freq_table &&
> > +	    (devfreq_update_status(devfreq, freq)))
> > +		dev_err(data->dev,
> > +			"Couldn't update frequency transition information.\n");
> > +
> > +	devfreq->previous_freq = freq;
> > +
> > +out:
> > +	mutex_unlock(&devfreq->lock);
> > +	return notifier_from_errno(ret);
> > +};
> > +
> > +static int krait_cache_governor_get_target(struct devfreq *devfreq,
> > +					   unsigned long *freq)
> > +{
> > +	unsigned int *l2_cpufreq;
> > +	unsigned long *freq_table;
> > +	unsigned long target_freq = *freq;
> > +	struct krait_data *data = dev_get_drvdata(devfreq->dev.parent);
> > +
> > +	l2_cpufreq = data->l2_cpufreq;
> > +	freq_table = data->freq_table;
> > +
> > +	/*
> > +	 * Find the highest l2 freq interval based on the max cpufreq
> > +	 * across all core
> > +	 */
> > +	while (*(l2_cpufreq = l2_cpufreq + 1) && target_freq >= *l2_cpufreq)
> > +		freq_table = freq_table + 1;
> > +
> > +	*freq = *freq_table;
> > +
> > +	return 0;
> > +};
> > +
> > +static int krait_cache_governor_event_handler(struct devfreq *devfreq,
> > +					      unsigned int event, void *data)
> > +{
> > +	struct krait_data *kdata = dev_get_drvdata(devfreq->dev.parent);
> > +	int ret = 0;
> > +
> > +	switch (event) {
> > +	case DEVFREQ_GOV_START:
> > +		kdata->nb.notifier_call = krait_cache_notifier;
> > +		ret = cpufreq_register_notifier(&kdata->nb,
> > +						CPUFREQ_TRANSITION_NOTIFIER);
> > +		break;
> > +
> > +	case DEVFREQ_GOV_STOP:
> > +		cpufreq_unregister_notifier(&kdata->nb,
> > +					    CPUFREQ_TRANSITION_NOTIFIER);
> > +		break;
> > +	}
> > +
> > +	return ret;
> > +};
> > +
> > +static struct devfreq_governor krait_devfreq_governor = {
> > +	.name = "krait_governor",
> > +	.get_target_freq = krait_cache_governor_get_target,
> > +	.event_handler = krait_cache_governor_event_handler,
> > +	.immutable = true,
> > +};
> > +
> > +static int krait_cache_probe(struct platform_device *pdev)
> > +{
> > +	int ret, count;
> > +	struct opp_table *table;
> > +	struct krait_data *data;
> > +	struct device *dev = &pdev->dev;
> > +	struct device_node *node = dev->of_node;
> > +
> > +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> > +	if (!data)
> > +		return -ENOMEM;
> > +
> > +	data->dev = dev;
> > +
> > +	data->l2_clk = devm_clk_get(dev, "l2");
> > +	if (IS_ERR(data->l2_clk))
> > +		return PTR_ERR(data->l2_clk);
> > +
> > +	table = dev_pm_opp_set_regulators(dev, (const char *[]){ "l2" }, 1);
> > +	if (IS_ERR(table)) {
> > +		ret = PTR_ERR(table);
> > +		dev_err(dev, "failed to set regulators %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ret = PTR_ERR_OR_ZERO(
> > +		dev_pm_opp_register_set_opp_helper(dev, krait_cache_set_opp));
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = dev_pm_opp_of_add_table(dev);
> > +	if (ret) {
> > +		dev_err(dev, "failed to parse L2 freq thresholds\n");
> > +		return ret;
> > +	}
> > +
> > +	count = dev_pm_opp_get_opp_count(dev);
> > +
> > +	data->l2_cpufreq =
> > +		devm_kzalloc(dev, sizeof(unsigned int) * count, GFP_KERNEL);
> > +	if (!data->l2_cpufreq)
> > +		return -ENOMEM;
> > +
> > +	ret = of_property_read_u32_array(node, "qcom,l2-cpufreq", data->l2_cpufreq,
> > +					 count);
> > +	if (ret) {
> > +		dev_err(dev, "failed to parse L2 cpufreq thresholds\n");
> > +		return ret;
> > +	}
> > +
> > +	ret = devfreq_add_governor(&krait_devfreq_governor);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "Failed to add governor: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	platform_set_drvdata(pdev, data);
> > +
> > +	data->devfreq = devfreq_add_device(&pdev->dev, &tegra_devfreq_profile,
> > +					   "krait_governor", NULL);
> > +
> > +	/* Cache freq_table to quickly get it when needed */
> > +	data->freq_table = data->devfreq->profile->freq_table;
> > +
> > +	if (IS_ERR(data->devfreq))
> > +		return PTR_ERR(data->devfreq);
> > +
> > +	return 0;
> > +};
> > +
> > +static int krait_cache_remove(struct platform_device *pdev)
> > +{
> > +	struct krait_data *data = platform_get_drvdata(pdev);
> > +
> > +	dev_pm_opp_remove_table(data->dev);
> > +
> > +	return 0;
> > +};
> > +
> > +static const struct of_device_id krait_cache_match_table[] = {
> > +	{ .compatible = "qcom,krait-cache" },
> > +	{}
> > +};
> > +
> > +static struct platform_driver krait_cache_driver = {
> > +	.probe		= krait_cache_probe,
> > +	.remove		= krait_cache_remove,
> > +	.driver		= {
> > +		.name   = "krait-cache-scaling",
> > +		.of_match_table = krait_cache_match_table,
> > +	},
> > +};
> > +module_platform_driver(krait_cache_driver);
> > +
> > +MODULE_DESCRIPTION("Krait CPU Cache Scaling driver");
> > +MODULE_AUTHOR("Ansuel Smith <ansuelsmth@gmail.com>");
> > +MODULE_LICENSE("GPL v2");
> > 
> 
> 
> -- 
> Best Regards,
> Chanwoo Choi
> Samsung Electronics

-- 
	Ansuel
