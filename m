Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8184BFF74
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbiBVQ6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234505AbiBVQ6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:58:04 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473DE16BFBE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:57:38 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id o23so1095926pgk.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iYp8eNy/Nx7jP2HPM3fRAaeyIaFSVJven/4EBmZrFm8=;
        b=xky7X+BDn1zEZL2FTEf/96Htn3+aok0xwUM+Vh1i7P2bboofy7dVqAq2iDwBgYZdSs
         sZTI4yXLuuBF+yLzxyzcxII2639wLht6hTNyMWeQUw8QsCHqKVm0TCUO7bJSVNbV43Ga
         Q/t5AdpDP2OREntcgl/d60pmJCQyhS5gvt/NxP66uoSVeTfnE3Onoviamw19LYJmyhJT
         NWY4qi3RPwPacYOc7DsrGi3GYE9L4bt1tzlz3N4Tk+TroeUROk9ylFjBlOYjvKRH2yNn
         QMWSzGwengkSi6aBhjcQC8Yrh+wRgOzyTcK0WdLSJcXiTEQiHC3dtGDl38VgOtQhsSje
         7PtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iYp8eNy/Nx7jP2HPM3fRAaeyIaFSVJven/4EBmZrFm8=;
        b=QRyeIL2QjTijuSMMtr8TnMHBAcCI8f9iDLcZBzASnOFmKS+9y1RUCTyEpEd+nAwGpc
         4zXJHcX6tIj6l4hGb/6xGwB+LAJVjm30J8VTboCLSjCZLA9FNpAQrlcluGSTwnfoS0Jx
         ODGw6vj8ks5017ryYhX9MHWVEcN/QDn2XRvOOwyJsMfeCRZu6KkMtml4R2uOOOJbQMvA
         17UeGzojeB4lRE5OzHla1omMYAXi3414cCUy5basyFkiVqpVwBIPTMclyxUX/jgVAkF2
         hk4ocJm0gv6zot2kWnYCTg1pWwPb7vYk92e7Wc1lkHg2rwRT7yubXwfKQd1Eh45icT/T
         VsqA==
X-Gm-Message-State: AOAM532+MwywqVUOcEzFkdpHvcBHQVO3/aPDJEeBRbB47+Boymxu+bfH
        JlVQq/Bk/qsZgB+I/dnejvZjvw==
X-Google-Smtp-Source: ABdhPJwFdk/RNl7RlT45tPUzDsvynRxqxHgx1ERD0B9uZttQc4ul4gr/UUI9jxV5KadXmOh5VTyHNw==
X-Received: by 2002:a63:3c1:0:b0:36c:6a33:6652 with SMTP id 184-20020a6303c1000000b0036c6a336652mr20482198pgd.316.1645549057655;
        Tue, 22 Feb 2022 08:57:37 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id f60sm33510pjk.39.2022.02.22.08.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 08:57:36 -0800 (PST)
Date:   Tue, 22 Feb 2022 09:57:34 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tanmay Shah <tanmay.shah@xilinx.com>
Cc:     bjorn.andersson@linaro.org, robh+dt@kernel.org,
        michal.simek@xilinx.com, laurent.pinchart@ideasonboard.com,
        ben.levinsky@xilinx.com, bill.mills@linaro.org,
        sergei.korneichuk@xilinx.com, arun.balaji.kannan@xilinx.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 6/6] drivers: remoteproc: Add Xilinx r5 remoteproc
 driver
Message-ID: <20220222165734.GC923552@p14s>
References: <20220210112824.2084724-1-tanmay.shah@xilinx.com>
 <20220210112824.2084724-7-tanmay.shah@xilinx.com>
 <20220218191150.GB574087@p14s>
 <6a9dcca9-3c86-f603-d13a-acc74161f1a1@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a9dcca9-3c86-f603-d13a-acc74161f1a1@xilinx.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[...]

> > > +/**
> > > + * zynqmp_r5_get_tcm_node()
> > > + * Ideally this function should parse tcm node and store information
> > > + * in r5_core instance. We will use hardcoded TCM information from
> > > + * driver for now in this function.
> > > + *
> > > + * @cluster: pointer to zynqmp_r5_cluster type object
> > > + *
> > > + * Return: 0 for success and error code for failure.
> > > + */
> > > +static int zynqmp_r5_get_tcm_node(struct zynqmp_r5_cluster *cluster)
> > > +{
> > > +	int tcm_bank_count, tcm_node;
> > > +	int i = 0, j;
> > Variable @i doesn't need to be initialised.
> Agree.
> > > +	struct zynqmp_r5_core *r5_core;
> > > +	const struct mem_bank_data *tcm = zynqmp_tcm_banks;
> > > +	struct device *dev = cluster->dev;
> > > +
> > > +	/*
> > > +	 * ToDo: Use predefined TCM address space values from driver until
> > > +	 * system-dt spec is not final for TCM
> > > +	 */
> > > +	tcm_bank_count = ARRAY_SIZE(zynqmp_tcm_banks);
> > > +
> > > +	/* count per core tcm banks */
> > > +	tcm_bank_count = tcm_bank_count / cluster->core_count;
> > > +
> > > +	/* r5 core 0 will use all of TCM banks in lockstep mode.
> > > +	 * In split mode, r5 core0 will use 128k and r5 core1 will use another
> > > +	 * 128k. Assign TCM banks to each core accordingly
> > > +	 */
> > Comment format problem.
> My bad. I will fix it.
> > > +	tcm_node = 0;
> > > +	for (i = 0; i < cluster->core_count; i++) {
> > > +		r5_core = cluster->r5_cores[i];
> > > +		r5_core->tcm_banks = devm_kcalloc(dev, tcm_bank_count,
> > > +						  sizeof(struct mem_bank_data),
> > > +						  GFP_KERNEL);
> > > +		if (!r5_core->tcm_banks)
> > > +			return -ENOMEM;
> > > +
> > > +		for (j = 0; j < tcm_bank_count; j++) {
> > > +			/* Use pre-defined TCM reg values.
> > > +			 * Eventually this should be replaced by values
> > > +			 * parsed from dts.
> > > +			 */
> > Same.  I commented on that in my previous review of this set.
> Yes. I will fix it.
> > > +			r5_core->tcm_banks[j].addr = tcm[tcm_node].addr;
> > > +			r5_core->tcm_banks[j].size = tcm[tcm_node].size;
> > > +			r5_core->tcm_banks[j].pm_domain_id = tcm[tcm_node].pm_domain_id;
> > > +			r5_core->tcm_banks[j].bank_name = tcm[tcm_node].bank_name;
> > > +			tcm_node++;
> > > +		}
> > > +
> > > +		r5_core->tcm_bank_count = tcm_bank_count;
> > Why do we need to copy the exact same information from zynqmp_tcm_banks to ->tcm_banks?  Why can't ->tcm_banks point to an offset in zynqmp_tcm_banks and ->tcm_bank_count set accordingly?
> 
> zynqmp_tcm_banks is global variable. If I use ->tcm_banks point to offset of
> zynqmp_tcm_banks and use it in driver, that section of code won't be thread
> safe anymore.
> 
> I might have to use mutex to protect it. So Instead of pointing it to global
> variable, I decided to copy information from global variable to ->tcm_banks.

As far as I can tell ->tcm_banks is a read-only field and as such shouldn't
need mutext protection.

Thanks,
Mathieu

> 
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +/**
> > > + * zynqmp_r5_get_mem_region_node()
> > > + * parse memory-region property from dt node and add
> > > + * memory region carveouts
> > > + *
> > > + * @r5_core: pointer to zynqmp_r5_core type object
> > > + *
> > > + * Return: 0 for success and error code for failure.
> > > + */
> > > +static int zynqmp_r5_get_mem_region_node(struct zynqmp_r5_core *r5_core)
> > > +{
> > > +	int res_mem_count, i, ret;
> > > +	struct device *dev;
> > > +	struct device_node *np, *rmem_np;
> > > +	struct reserved_mem *rmem;
> > > +
> > > +	dev = r5_core->dev;
> > > +
> > > +	np = r5_core->np;
> > > +
> > > +	res_mem_count = of_property_count_elems_of_size(np, "memory-region",
> > > +							sizeof(phandle));
> > > +	if (res_mem_count <= 0) {
> > > +		dev_warn(dev, "failed to get memory-region property %d\n",
> > > +			 res_mem_count);
> > > +		return -EINVAL;
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
> > What happens to previously allocated regions when there is a failure?
> 
> Right, I need to unmap memory and use kfree(rmem) to de-allocate memory.
> 
> > > +		}
> > > +
> > > +		ret = add_mem_regions_carveout(r5_core, rmem);
> > > +		if (ret)
> > > +			dev_warn(dev, "failed to get reserve mem regions %d\n",
> > > +				 ret);
> > Same here.
> 
> Here as well. I will release reserved mem dev with
> of_reserved_mem_device_release API.
> 
> One more thing. I moved add_mem_regions_carveout from parse_fw to
> zynqmp_r5_get_mem_region_node.
> 
> However, I believe I should move it back to parse_fw.
> 
> Following test case is failing in when add_mem_regions_carveout is not
> available in parse_fw:
> 
> load_rpu_fw -> start rpu -> stop rpu -> start rpu again
> 
> In above case, during mem regions are not added again.
> 
> Is it fine, if I move this add_mem_regions_carveout back to
> zynqmp_r5_parse_fw ?
> 
> > I am out of time for this set.  Please address comments provided up to here and
> > we will see about the rest in a future revision.
> > 
> > Thanks,
> > Mathieu
> > 
> > > +
> > > +		of_node_put(rmem_np);
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +/*
> > > + * zynqmp_r5_core_init()
> > > + * Create and initialize zynqmp_r5_core type object
> > > + *
> > > + * @cluster: pointer to zynqmp_r5_cluster type object
> > > + *
> > > + * Return: 0 for success and error code for failure.
> > > + */
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
> > > +		r5_core = cluster->r5_cores[i];
> > > +
> > > +		ret = zynqmp_r5_get_mem_region_node(r5_core);
> > > +		if (ret)
> > > +			dev_warn(dev, "memory-region prop failed %d\n", ret);
> > > +
> > > +		/* Initialize r5 cores with power-domains parsed from dts */
> > > +		ret = of_property_read_u32_index(r5_core->np, "power-domains",
> > > +						 1, &r5_core->pm_domain_id);
> > > +		if (ret) {
> > > +			dev_err(dev, "failed to get power-domains property\n");
> > > +			return ret;
> > > +		}
> > > +
> > > +		ret = zynqmp_r5_set_mode(r5_core, cluster->mode);
> > > +		if (ret) {
> > > +			dev_err(dev, "failed to set r5 cluster mode %d, err %d\n",
> > > +				cluster->mode, ret);
> > > +			return ret;
> > > +		}
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +/*
> > > + * zynqmp_r5_cluster_init()
> > > + * Create and initialize zynqmp_r5_cluster type object
> > > + *
> > > + * @cluster: pointer to zynqmp_r5_cluster type object
> > > + *
> > > + * Return: 0 for success and error code for failure.
> > > + */
> > > +static int zynqmp_r5_cluster_init(struct zynqmp_r5_cluster *cluster)
> > > +{
> > > +	struct device *dev = cluster->dev;
> > > +	struct device_node *dev_node = dev_of_node(dev);
> > > +	struct device_node *child;
> > > +	struct platform_device *child_pdev;
> > > +	int core_count = 0, ret, i;
> > > +	enum zynqmp_r5_cluster_mode cluster_mode = LOCKSTEP_MODE;
> > > +	struct zynqmp_r5_core **r5_cores;
> > > +
> > > +	ret = of_property_read_u32(dev_node, "xlnx,cluster-mode", &cluster_mode);
> > > +
> > > +	/*
> > > +	 * on success returns 0, if not defined then returns -EINVAL,
> > > +	 * In that case, default is LOCKSTEP mode
> > > +	 */
> > > +	if (ret != -EINVAL && ret != 0) {
> > > +		dev_err(dev, "Invalid xlnx,cluster-mode property\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	/*
> > > +	 * For now driver only supports split mode and lockstep mode.
> > > +	 * fail driver probe if either of that is not set in dts
> > > +	 */
> > > +	if (cluster_mode == SINGLE_CPU_MODE) {
> > > +		dev_err(dev, "driver does not support single cpu mode\n");
> > > +		return -EINVAL;
> > > +	} else if ((cluster_mode != SPLIT_MODE &&
> > > +		   cluster_mode != LOCKSTEP_MODE)) {
> > > +		dev_err(dev, "Invalid cluster mode\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	/*
> > > +	 * Number of cores is decided by number of child nodes of
> > > +	 * r5f subsystem node in dts. If Split mode is used in dts
> > > +	 * 2 child nodes are expected.
> > > +	 * In lockstep mode if two child nodes are available,
> > > +	 * only use first child node and consider it as core0
> > > +	 * and ignore core1 dt node.
> > > +	 */
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
> > > +	r5_cores = devm_kcalloc(dev, core_count,
> > > +				sizeof(struct zynqmp_r5_core *), GFP_KERNEL);
> > > +	if (!r5_cores)
> > > +		return -ENOMEM;
> > > +
> > > +	i = 0;
> > > +	for_each_available_child_of_node(dev_node, child) {
> > > +		child_pdev = of_find_device_by_node(child);
> > > +		if (!child_pdev) {
> > > +			of_node_put(child);
> > > +			return -ENODEV;
> > > +		}
> > > +
> > > +		/* create and add remoteproc instance of type struct rproc */
> > > +		r5_cores[i] = zynqmp_r5_add_rproc_core(&child_pdev->dev);
> > > +		r5_cores[i]->dev = &child_pdev->dev;
> > > +		if (!r5_cores[i]->dev) {
> > > +			dev_err(dev, "can't get device for r5 core %d\n", i);
> > > +			of_node_put(child);
> > > +			return -ENODEV;
> > > +		}
> > > +
> > > +		r5_cores[i]->np = dev_of_node(r5_cores[i]->dev);
> > > +		if (!r5_cores[i]->np) {
> > > +			dev_err(dev, "can't get device node for r5 core %d\n", i);
> > > +			of_node_put(child);
> > > +			return -ENODEV;
> > > +		}
> > > +
> > > +		i++;
> > > +
> > > +		/*
> > > +		 * If two child nodes are available in dts in lockstep mode,
> > > +		 * then ignore second child node.
> > > +		 */
> > > +		if (i == core_count) {
> > > +			of_node_put(child);
> > > +			break;
> > > +		}
> > > +		of_node_put(child);
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
> > > +	if (!cluster)
> > > +		return -ENOMEM;
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
