Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE26473432
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 19:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241890AbhLMSkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 13:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbhLMSkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 13:40:01 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7283C061748
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 10:40:00 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so15318095pja.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 10:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WFGpT3wiu5CVNcvYqgjAcE3S0aIPJxs+TGBSN+X1ruQ=;
        b=uPgtM1UYCUhoR2uFrbRwhPc0hv/n18TfnKrPtruDqoBKr7PfZ98xMoGNDDsb7nICVb
         1uI6B8Tq99RO7mffYIysmLUB2l3cI+hH+L03MCe6iO1kV9Cnfpcr9frnyfzshIUqkg5V
         wNZuPcVmcQ/3kFyFRjikkR8uAtnhzyxi+8JKeuHzNwzwDX1F6AvKB4pYopaHqg76jDRF
         LPuOgH5IPk54oOKMJf2TH2lGhphMRao2k1PNy9woxuK0wD3w9O3uZ0gqtWb80EQ46WOa
         mgOtglNdvLvKVG55BUldvZnUNkWnewIdoOZjb5h98H43plFmnjS6Hw234GsizEJvH4mJ
         Q28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WFGpT3wiu5CVNcvYqgjAcE3S0aIPJxs+TGBSN+X1ruQ=;
        b=49c89HRjrVapbrEgJiQ1ZRUQp8DfZkxkAoXdoRtz9vpBgBaXQrLb4HvP5cWz2bUCCS
         M69uesSU1l55fmVPurovQAzzWdq4cNDi6ajusmyUOwDz7xb0p692NR3lBRM1IzfuMNZY
         9Cy7WbptiiET4JZK0o63WNyFAlho4rMzS+/5rqTHcVIeACij+VfseC3QrXaURdzd2KW4
         VdloX4s5eFAVFz4bmEJwATIfXSsU+dWD39MFlxcPVsz92MSgSdBPZvD37gnYHFyktCNR
         wy2mXOvoX/RA+Vh8g5xORamB+a3H5NZzxMeiom00JaDH5SOUrAm/42f4feYfMqfVlWxc
         7nqA==
X-Gm-Message-State: AOAM531QAppvbxZceoI7fXujP3rtqT0LssHlXmPxpZ6aFMlJobHKm9Yx
        5oComgWkNJnIj8FimarZFT1Mgw==
X-Google-Smtp-Source: ABdhPJwvt4I+xp62YgTXHt3xUplDSubOEkd2gWsqy26Mqv60cqCrmXi5avhcDq/bUdHQn6V+Wi0RPA==
X-Received: by 2002:a17:90a:880a:: with SMTP id s10mr27034pjn.214.1639420800300;
        Mon, 13 Dec 2021 10:40:00 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id d15sm13856029pfl.126.2021.12.13.10.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 10:39:59 -0800 (PST)
Date:   Mon, 13 Dec 2021 11:39:56 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tanmay Shah <tanmay.shah@xilinx.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ben Levinsky <ben.levinsky@xilinx.com>,
        Bill Mills <bill.mills@linaro.org>,
        Sergei Korneichuk <sergei.korneichuk@xilinx.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 6/6] drivers: remoteproc: Add Xilinx r5 remoteproc
 driver
Message-ID: <20211213183956.GA1398742@p14s>
References: <20211123062050.1442712-1-tanmay.shah@xilinx.com>
 <20211123062050.1442712-7-tanmay.shah@xilinx.com>
 <20211203185518.GA942034@p14s>
 <6debe673-8c88-53f1-badc-23f2dfc15350@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6debe673-8c88-53f1-badc-23f2dfc15350@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> > > +}
> > > +
> > > +static int zynqmp_r5_get_tcm_node(struct zynqmp_r5_cluster *cluster)
> > > +{
> > > +	int tcm_bank_count, tcm_node;
> > > +	int i = 0, j;
> > > +	struct zynqmp_r5_core *r5_core;
> > > +	const struct mem_bank_data *tcm = zynqmp_tcm_banks;
> > > +	struct device *dev = cluster->dev;
> > > +
> > > +	/* ToDo: Use predefined TCM address space values from driver until
> > > +	 * system-dt spec is not final fot TCM
> > > +	 */
> > Multilined comment should be as follow:
> > 
> >          /*
> >           * ToDo: Use predefined TCM address space values from driver until
> > 	 * system-dt spec is not final fot TCM
> >           */
> > 
> > s/"final fot TCM"/"final for TCM"
> > 
> > Any reason this can't be done with "reg" properties like TI did for K3?  It
> > would be nice to have TCMs included in the yaml file example.
> > 
> R5 TCM on Xilinx platforms contains separate power-domains than RPU
> power-domains. So, I believe they can be operated separately than RPU. That
> is why I chose not to include as reg property. I believe we will include TCM
> as sram property in future.
> 
> Now, explanation about why TCM is hardcode in driver:
> 
> When I started developing driver, system-dt spec was in progress, to avoid
> extra maintenance effort I defined TCM information in driver instead of
> defining them in YAML.
> I agree with idea that there is no need to maintain two separate bindings
> and until system-dt specs are maturing we can hardcode TCM related
> information driver. This was discussed previously here: https://lore.kernel.org/all/CAL_JsqLGo380SRYska+xGgJhgF8NCRvY56ewafvSCU6c-LmhZw@mail.gmail.com/
>

Thanks for the link. 

> Patchwork link for the same: https://patchwork.kernel.org/project/linux-remoteproc/patch/1587749770-15082-5-git-send-email-ben.levinsky@xilinx.com/#23414963
>
> Also, I will sync with system-dt team about its current status and keep
> updating about system-dt specs.
> 
> Please let me know your opinion / suggestion for any alternative approach.
> 

There is no point in burdening Rob any further than he already is - for the time
being the current approach will work.

> 
> I agree with rest of the comments in this thread, and I will address them
> all in next revision.
> 
> > > +	tcm_bank_count = ARRAY_SIZE(zynqmp_tcm_banks);
> > > +
> > > +	/* count per core tcm banks */
> > > +	tcm_bank_count = tcm_bank_count / cluster->core_count;
> > > +
> > > +	/* r5 core 0 will use all of TCM banks in lockstep mode.
> > > +	 * In split mode, r5 core0 will use 128k and r5 core1 will use another
> > > +	 * 128k. Assign TCM banks to each core accordingly
> > > +	 */
> > > +	tcm_node = 0;
> > > +	for (j = 0; j < cluster->core_count; j++) {
> > > +		r5_core = &cluster->r5_cores[j];
> > > +		r5_core->tcm_banks = devm_kzalloc(dev, sizeof(struct mem_bank_data) *
> > > +						  tcm_bank_count, GFP_KERNEL);
> > > +		if (IS_ERR_OR_NULL(r5_core->tcm_banks))
> > > +			return -ENOMEM;
> > > +
> > > +		for (i = 0; i < tcm_bank_count; i++) {
> > > +			/* Use pre-defined TCM reg values.
> > > +			 * Eventually this should be replaced by values
> > > +			 * parsed from dts.
> > > +			 */
> > > +			r5_core->tcm_banks[i].addr = tcm[tcm_node].addr;
> > > +			r5_core->tcm_banks[i].size = tcm[tcm_node].size;
> > > +			r5_core->tcm_banks[i].pm_domain_id = tcm[tcm_node].pm_domain_id;
> > > +			r5_core->tcm_banks[i].bank_name = tcm[tcm_node].bank_name;
> > > +			tcm_node++;
> > > +		}
> > > +
> > > +		r5_core->tcm_bank_count = tcm_bank_count;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int zynqmp_r5_get_mem_region_node(struct zynqmp_r5_core *r5_core)
> > > +{
> > > +	int res_mem_count, i;
> > > +	struct device *dev;
> > > +	struct device_node *np, *rmem_np;
> > > +	struct reserved_mem *rmem;
> > > +
> > > +	dev = r5_core->dev;
> > > +
> > > +	np = r5_core->np;
> > > +	if (IS_ERR_OR_NULL(np)) {
> > > +		pr_err("invalid device node of r5 core\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	res_mem_count = of_property_count_elems_of_size(np, "memory-region",
> > > +							sizeof(phandle));
> > > +	if (res_mem_count <= 0) {
> > > +		dev_warn(dev, "failed to get memory-region property %d\n",
> > > +			 res_mem_count);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	r5_core->res_mem = devm_kzalloc(dev,
> > > +					res_mem_count * sizeof(struct reserved_mem),
> > > +					GFP_KERNEL);
> > > +	if (!r5_core->res_mem) {
> > > +		dev_err(dev, "failed to allocate mem region memory\n");
> > > +		return -ENOMEM;
> > > +	}
> > > +
> > > +	for (i = 0; i < res_mem_count; i++) {
> > > +		rmem_np = of_parse_phandle(np, "memory-region", i);
> > > +		if (!rmem_np)
> > > +			return -EINVAL;
> > > +
> > > +		rmem = of_reserved_mem_lookup(rmem_np);
> > > +		if (!rmem) {
> > > +			of_node_put(rmem_np);
> > > +			return -EINVAL;
> > > +		}
> > > +
> > > +		memcpy(&r5_core->res_mem[i], rmem,
> > > +		       sizeof(struct reserved_mem));
> > > +		of_node_put(rmem_np);
> > > +	}
> > > +
> > > +	r5_core->res_mem_count = res_mem_count;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster)
> > > +{
> > > +	int ret, i;
> > > +	struct zynqmp_r5_core *r5_core;
> > > +	struct device *dev = cluster->dev;
> > > +
> > > +	ret = zynqmp_r5_get_tcm_node(cluster);
> > > +	if (ret < 0) {
> > > +		dev_err(dev, "can't get tcm node, err %d\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	for (i = 0; i < cluster->core_count; i++) {
> > > +		r5_core = &cluster->r5_cores[i];
> > > +		if (!r5_core) {
> > > +			pr_err("invalid r5 core\n");
> > > +			return -EINVAL;
> > > +		}
> > > +
> > > +		ret = zynqmp_r5_get_mem_region_node(r5_core);
> > > +		if (ret)
> > > +			dev_warn(dev, "memory-region prop failed %d\n", ret);
> > > +
> > > +		ret = of_property_read_u32_index(r5_core->np, "power-domains",
> > > +						 1, &r5_core->pm_domain_id);
> > > +		if (ret) {
> > > +			dev_err(dev, "failed to get power-domains property\n");
> > > +			return ret;
> > > +		}
> > > +
> > > +		ret = zynqmp_r5_set_mode(r5_core, cluster->mode);
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		ret = zynqmp_r5_add_rproc_core(r5_core);
> > > +		if (ret) {
> > > +			dev_err(dev, "failed to init r5 core %d\n", i);
> > > +			return ret;
> > > +		}
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int zynqmp_r5_cluster_init(struct zynqmp_r5_cluster *cluster)
> > > +{
> > > +	struct device *dev = cluster->dev;
> > > +	struct device_node *dev_node = dev_of_node(dev);
> > > +	struct device_node *child;
> > > +	struct platform_device *child_pdev;
> > > +	int core_count = 0, ret, i;
> > > +	enum zynqmp_r5_cluster_mode cluster_mode = LOCKSTEP_MODE;
> > > +	struct zynqmp_r5_core *r5_cores;
> > > +
> > > +	ret = of_property_read_u32(dev_node, "xlnx,cluster-mode", &cluster_mode);
> > > +
> > > +	/* on success returns 0, if not defined then returns -EINVAL,
> > > +	 * In that case, default is LOCKSTEP mode
> > > +	 */
> > > +	if (ret != -EINVAL && ret != 0) {
> > > +		dev_err(dev, "Invalid xlnx,cluster-mode property\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	if (cluster_mode == SINGLE_CPU_MODE) {
> > > +		dev_err(dev, "driver does not support single cpu mode\n");
> > > +		return -EINVAL;
> > > +	} else if ((cluster_mode != SPLIT_MODE &&
> > > +		   cluster_mode != LOCKSTEP_MODE)) {
> > > +		dev_err(dev, "Invalid cluster mode\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	core_count = of_get_available_child_count(dev_node);
> > > +	if (core_count <= 0) {
> > > +		dev_err(dev, "Invalid number of r5 cores %d", core_count);
> > > +		return -EINVAL;
> > > +	} else if (cluster_mode == SPLIT_MODE && core_count != 2) {
> > > +		dev_err(dev, "Invalid number of r5 cores for split mode\n");
> > > +		return -EINVAL;
> > > +	} else if (cluster_mode == LOCKSTEP_MODE && core_count == 2) {
> > > +		dev_warn(dev, "Only r5 core0 will be used\n");
> > > +		core_count = 1;
> > > +	}
> > > +
> > > +	r5_cores = devm_kzalloc(dev, sizeof(struct zynqmp_r5_core) *
> > > +						 core_count, GFP_KERNEL);
> > > +	if (IS_ERR_OR_NULL(r5_cores)) {
> > > +		dev_err(dev, "can't allocate memory for cores\n");
> > > +		return -ENOMEM;
> > > +	}
> > > +
> > > +	i = 0;
> > > +	for_each_available_child_of_node(dev_node, child) {
> > > +		child_pdev = of_find_device_by_node(child);
> > > +		if (!child_pdev)
> > > +			return -ENODEV;
> > > +
> > > +		r5_cores[i].dev = &child_pdev->dev;
> > > +		if (!r5_cores[i].dev) {
> > > +			pr_err("can't get device for r5 core %d\n", i);
> > > +			return -ENODEV;
> > > +		}
> > > +
> > > +		r5_cores[i].np = dev_of_node(r5_cores[i].dev);
> > > +		if (!r5_cores[i].np) {
> > > +			pr_err("can't get device node for r5 core %d\n", i);
> > > +			return -ENODEV;
> > > +		}
> > > +
> > > +		i++;
> > > +		if (i == core_count)
> > > +			break;
> > > +	}
> > > +
> > > +	cluster->mode = cluster_mode;
> > > +	cluster->core_count = core_count;
> > > +	cluster->r5_cores = r5_cores;
> > > +
> > > +	ret = zynqmp_r5_core_init(cluster);
> > > +	if (ret < 0) {
> > > +		dev_err(dev, "failed to init r5 core err %d\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	zynqmp_r5_print_dt_node_info(cluster);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static void zynqmp_r5_cluster_exit(void *data)
> > > +{
> > > +	struct platform_device *pdev = (struct platform_device *)data;
> > > +
> > > +	platform_set_drvdata(pdev, NULL);
> > > +
> > > +	pr_info("Exit r5f subsystem driver\n");
> > > +}
> > > +
> > > +/*
> > > + * zynqmp_r5_remoteproc_probe()
> > > + *
> > > + * @pdev: domain platform device for R5 cluster
> > > + *
> > > + * called when driver is probed, for each R5 core specified in DT,
> > > + * setup as needed to do remoteproc-related operations
> > > + *
> > > + * Return: 0 for success, negative value for failure.
> > > + */
> > > +static int zynqmp_r5_remoteproc_probe(struct platform_device *pdev)
> > > +{
> > > +	int ret;
> > > +	struct zynqmp_r5_cluster *cluster;
> > > +	struct device *dev = &pdev->dev;
> > > +
> > > +	cluster = devm_kzalloc(dev, sizeof(*cluster), GFP_KERNEL);
> > > +	if (IS_ERR_OR_NULL(cluster))
> > > +		return -ENOMEM;
> > Function devm_kzalloc() does not return an code on error, just NULL.  Please fix
> > throughout the driver.
> > 
> > > +
> > > +	cluster->dev = dev;
> > > +
> > > +	ret = devm_of_platform_populate(dev);
> > > +	if (ret) {
> > > +		dev_err(dev, "failed to populate platform dev %d\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	/* wire in so each core can be cleaned up at driver remove */
> > > +	platform_set_drvdata(pdev, cluster);
> > > +
> > > +	ret = devm_add_action_or_reset(dev, zynqmp_r5_cluster_exit, pdev);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = zynqmp_r5_cluster_init(cluster);
> > > +	if (ret) {
> > > +		dev_err(dev, "Invalid r5f subsystem device tree\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	dev_info(dev, "Xilinx r5f remoteproc driver probe success\n");
> > Please remove this.
> > 
> > I am out of time for today and will continue on Monday.
> > 
> > Thanks,
> > Mathieu
> > 
> > > +	return 0;
> > > +}
> > > +
> > > +/* Match table for OF platform binding */
> > > +static const struct of_device_id zynqmp_r5_remoteproc_match[] = {
> > > +	{ .compatible = "xlnx,zynqmp-r5fss", },
> > > +	{ /* end of list */ },
> > > +};
> > > +MODULE_DEVICE_TABLE(of, zynqmp_r5_remoteproc_match);
> > > +
> > > +static struct platform_driver zynqmp_r5_remoteproc_driver = {
> > > +	.probe = zynqmp_r5_remoteproc_probe,
> > > +	.driver = {
> > > +		.name = "zynqmp_r5_remoteproc",
> > > +		.of_match_table = zynqmp_r5_remoteproc_match,
> > > +	},
> > > +};
> > > +module_platform_driver(zynqmp_r5_remoteproc_driver);
> > > +
> > > +MODULE_DESCRIPTION("Xilinx R5F remote processor driver");
> > > +MODULE_AUTHOR("Xilinx Inc.");
> > > +MODULE_LICENSE("GPL v2");
> > > -- 
> > > 2.25.1
> > > 
