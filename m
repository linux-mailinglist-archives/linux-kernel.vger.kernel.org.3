Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139675AB90D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 21:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbiIBT7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 15:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiIBT7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 15:59:10 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD96D34E9
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 12:59:07 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id t5so3048588pjs.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 12:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=dGK7WWAPGizMxBGKUMh+FvHewx1Mr93Lo4bVqiaiirA=;
        b=VFFkGttZfBJiRrzaJZvMz2ztkWWT/BcUmpVRh4lxAdICIbqR/sC2O9Ewh/fi75InDP
         3wDxXOIot7i6yfnwQigC10UVDVnS+1bnSj6zBCrBAYA1ygE49BZWzimXy/oJrdcTejZj
         gytUmRcC7YLlBzIYACz6HDr7NR6+sMmePbAu62fJptKZ7VaWMnZ6up7xyqpki3x3FZRF
         ZXKvciv/en8/oWL5XWRramH+IYv/xhJZoCclaPvoYRfwJMzcKrrU8UOZ2noNuocf4s7y
         pD8j8/VkaeFgN2ua0OpKbMhNWDA3RvF41d1bysBcpnQqYOZn7eupoPGeitWjKXpIVgSh
         ivPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=dGK7WWAPGizMxBGKUMh+FvHewx1Mr93Lo4bVqiaiirA=;
        b=E3qwTkdPnQioWav6GChi5fAbvRhMyyXgGb0QD5lMqnemtT9D4Xj4SchMYO0ISm1Y0I
         4OhApI/3jnVk/Z3XHO8njl1J5Z0jIiVva4eVYCDiZA1+EiAXhQ/yCjlgTTCocY8Bh8w1
         ftK2CRV7O1IbeEuPTNf82CVeaoh4QNd/hptTzsX3QENpWCKponguOpXVhewZkdbxWVlf
         SqylB3nI9PNeV+2CZaqGrKwSt9Afawm3IcDPqT//vBRoCjc/5/tROJCnX6/XNZtgIecQ
         M5C6LBzdyuZeq+8puuSBGFynXeiwML+e46Rq51npIrG6HFhay8gJMwtd65YWjcjmLrLI
         JaMQ==
X-Gm-Message-State: ACgBeo0IV50uYQJDFG8HRBwnk1NBAEklu2dlIqmhpvu/s9UP9puRG0nS
        LNMqZvbm+j+9XUywaHN7m9thvA==
X-Google-Smtp-Source: AA6agR7CZQpU238NDro/ZPLlEbYC08h0PdgJfvn8EJ//LePSPJFMGFvuNGAhREt18+wROZ36j+immA==
X-Received: by 2002:a17:902:e80e:b0:174:b2e1:8b5c with SMTP id u14-20020a170902e80e00b00174b2e18b5cmr25200428plg.20.1662148746714;
        Fri, 02 Sep 2022 12:59:06 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id s64-20020a17090a69c600b001fdc88d206fsm1870426pjj.9.2022.09.02.12.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 12:59:05 -0700 (PDT)
Date:   Fri, 2 Sep 2022 13:59:03 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tanmay Shah <tanmays@amd.com>
Cc:     Tanmay Shah <tanmay.shah@amd.com>, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        michal.simek@xilinx.com, ben.levinsky@xilinx.com,
        tanmay.shah@xilinx.com, michal.simek@amd.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 6/6] drivers: remoteproc: Add Xilinx r5 remoteproc
 driver
Message-ID: <20220902195903.GB1787913@p14s>
References: <20220708013955.2340449-1-tanmay.shah@amd.com>
 <20220708013955.2340449-7-tanmay.shah@amd.com>
 <20220901202517.GB626605@p14s>
 <bd7a8e2c-0d9f-fed5-4a5c-920817adbad2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd7a8e2c-0d9f-fed5-4a5c-920817adbad2@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[...]

> > > +
> > > +static const struct rproc_ops zynqmp_r5_rproc_ops = {
> > > +	.prepare	= zynqmp_r5_rproc_prepare,
> > > +	.unprepare	= zynqmp_r5_rproc_unprepare,
> > > +	.start		= zynqmp_r5_rproc_start,
> > > +	.stop		= zynqmp_r5_rproc_stop,
> > > +	.load		= rproc_elf_load_segments,
> > > +	.parse_fw	= zynqmp_r5_parse_fw,
> > > +	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
> > > +	.sanity_check	= rproc_elf_sanity_check,
> > > +	.get_boot_addr	= rproc_elf_get_boot_addr,
> > > +};
> > > +
> > > +/**
> > > + * zynqmp_r5_add_rproc_core()
> > > + * Probes ZynqMP R5 processor device node
> > > + * this is called for each individual R5 core
> > > + *
> > > + * @cdev: Device node of each r5 core
> > > + *
> > > + * Return: zynqmp_r5_core object for success, error pointer in case of error.
> > > + */
> > > +static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
> > > +{
> > > +	struct zynqmp_r5_core *r5_core;
> > > +	struct rproc *r5_rproc;
> > > +	int ret;
> > > +
> > > +	/* Set up DMA mask */
> > > +	ret = dma_set_coherent_mask(cdev, DMA_BIT_MASK(32));
> > > +	if (ret)
> > > +		return ERR_PTR(ret);
> > > +
> > > +	/* Allocate remoteproc instance */
> > > +	r5_rproc = rproc_alloc(cdev, dev_name(cdev),
> > > +			       &zynqmp_r5_rproc_ops,
> > > +			       NULL, sizeof(struct zynqmp_r5_core));
> > > +	if (!r5_rproc) {
> > > +		dev_err(cdev, "failed to allocate memory for rproc instance\n");
> > > +		return ERR_PTR(-ENOMEM);
> > > +	}
> > > +
> > > +	r5_rproc->auto_boot = false;
> > > +	r5_core = (struct zynqmp_r5_core *)r5_rproc->priv;
> > > +	r5_core->dev = cdev;
> > > +	r5_core->np = dev_of_node(cdev);
> > > +	if (!r5_core->np) {
> > > +		dev_err(cdev, "can't get device node for r5 core\n");
> > > +		return ERR_PTR(-EINVAL);
> > Here @r5_rproc is leaked and r5_rproc->rproc never free'ed.
> 
> This function is only used in cluster_init.
> 
> r5_rproc->rproc is free'ed in release_r5_core label in
> zynqmp_r5_cluster_init function if this function fails.

It would be the case if @r5_core was returned, but it is not.  A such
@r5_core[i] zynqmp_r5_cluster_init() is still null and the memory leaked.


> 
> This avoids multiple free of same resource.
> 
> > 
> > > +	}
> > > +
> > > +	/* Add R5 remoteproc core */
> > > +	ret = rproc_add(r5_rproc);
> > > +	if (ret) {
> > > +		dev_err(cdev, "failed to add r5 remoteproc\n");
> > > +		return ERR_PTR(ret);
> > Same.
> Same as above.
> > 
> > > +	}
> > > +
> > > +	r5_core->rproc = r5_rproc;
> > > +	return r5_core;
> > > +}
> > > +
> > > +/**
> > > + * zynqmp_r5_get_tcm_node()
> > > + * Ideally this function should parse tcm node and store information
> > > + * in r5_core instance. We will use hardcoded TCM information from
> > > + * driver for now in this function.
> > > + *
> > It would be a good idea to explain _why_ hardcoded values are used.
> It is explained in function, but will add in description too.
> > 
> > 
> > > + * @cluster: pointer to zynqmp_r5_cluster type object
> > > + *
> > > + * Return: 0 for success and error code for failure.
> > > + */
> > > +static int zynqmp_r5_get_tcm_node(struct zynqmp_r5_cluster *cluster)
> > > +{
> > > +	struct device *dev = cluster->dev;
> > > +	struct zynqmp_r5_core *r5_core;
> > > +	int tcm_bank_count, tcm_node;
> > > +	int i, j;
> > > +
> > > +	/*
> > > +	 * ToDo: Use predefined TCM address space values from driver while
> > I'm not sure why there is a "ToDo" here since this is exactly what you are
> > doing.
> Ack. ToDo needs to go.
> > > +	 * system-dt spec is not final for TCM
> > > +	 */
> > > +	tcm_bank_count = ARRAY_SIZE(zynqmp_tcm_banks);
> > > +
> > > +	/* count per core tcm banks */
> > > +	tcm_bank_count = tcm_bank_count / cluster->core_count;
> > > +
> > > +	if (tcm_bank_count <= 0)
> > > +		return -EINVAL;
> > As far as I can tell this can't happen and as such should be removed.
> 
> I kept this check for future, when we add TCM dt nodes. I will remove it.
> 
> > 
> > > +
> > > +	/*
> > > +	 * r5 core 0 will use all of TCM banks in lockstep mode.
> > > +	 * In split mode, r5 core0 will use 128k and r5 core1 will use another
> > > +	 * 128k. Assign TCM banks to each core accordingly
> > > +	 */
> > > +	tcm_node = 0;
> > > +	for (i = 0; i < cluster->core_count; i++) {
> > > +		r5_core = cluster->r5_cores[i];
> > > +		r5_core->tcm_banks = devm_kcalloc(dev, tcm_bank_count,
> > > +						  sizeof(struct mem_bank_data *),
> > > +						  GFP_KERNEL);
> > > +		if (!r5_core->tcm_banks)
> > > +			return -ENOMEM;
> > > +
> > > +		for (j = 0; j < tcm_bank_count; j++) {
> > > +			/*
> > > +			 * Use pre-defined TCM reg values.
> > > +			 * Eventually this should be replaced by values
> > > +			 * parsed from dts.
> > > +			 */
> > > +			r5_core->tcm_banks[j] =
> > > +				(struct mem_bank_data *)&zynqmp_tcm_banks[tcm_node];
> > > +			tcm_node++;
> > > +		}
> > > +
> > > +		r5_core->tcm_bank_count = tcm_bank_count;
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
> > > +	struct device_node *np, *rmem_np;
> > > +	struct reserved_mem **rmem;
> > > +	int res_mem_count, i;
> > > +	struct device *dev;
> > > +
> > > +	dev = r5_core->dev;
> > > +	np = r5_core->np;
> > > +
> > > +	res_mem_count = of_property_count_elems_of_size(np, "memory-region",
> > > +							sizeof(phandle));
> > > +	if (res_mem_count <= 0) {
> > > +		dev_warn(dev, "failed to get memory-region property %d\n",
> > > +			 res_mem_count);
> > > +		r5_core->rmem_count = 0;
> > > +		return 0;
> > > +	}
> > > +
> > > +	rmem = devm_kcalloc(dev, res_mem_count,
> > > +			    sizeof(struct reserved_mem *), GFP_KERNEL);
> > > +	if (!rmem)
> > > +		return -ENOMEM;
> > > +
> > > +	for (i = 0; i < res_mem_count; i++) {
> > > +		rmem_np = of_parse_phandle(np, "memory-region", i);
> > > +		if (!rmem_np)
> > > +			goto release_rmem;
> > > +
> > > +		rmem[i] = of_reserved_mem_lookup(rmem_np);
> > > +		if (!rmem[i]) {
> > > +			of_node_put(rmem_np);
> > > +			goto release_rmem;
> > > +		}
> > > +
> > > +		of_node_put(rmem_np);
> > > +	}
> > > +
> > > +	r5_core->rmem_count = res_mem_count;
> > > +	r5_core->rmem = rmem;
> > > +	return 0;
> > > +
> > > +release_rmem:
> > > +	for (i--; i >= 0; i--)
> > > +		kfree(rmem[i]);
> > Function of_reserved_mem_lookup() doesn't allocate a new reserved_mem structure,
> > you get a reference to an existing one.  As such there is no need to explicitly
> > free individual elements of the rmem array.
> Ack.
> > 
> > > +	devm_kfree(dev, rmem);
> > > +	return -ENOMEM;
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
> > > +static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
> > > +			       enum rpu_oper_mode fw_reg_val,
> > > +			       enum rpu_tcm_comb tcm_mode)
> > > +{
> > > +	struct device *dev = cluster->dev;
> > > +	struct zynqmp_r5_core *r5_core;
> > > +	int ret, i;
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
> > > +		ret = zynqmp_r5_set_mode(r5_core, fw_reg_val, tcm_mode);
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
> > > +	enum zynqmp_r5_cluster_mode cluster_mode = LOCKSTEP_MODE;
> > > +	struct device *dev = cluster->dev;
> > > +	struct device_node *dev_node = dev_of_node(dev);
> > > +	struct platform_device *child_pdev;
> > > +	struct zynqmp_r5_core **r5_cores;
> > > +	enum rpu_oper_mode fw_reg_val;
> > > +	struct device **child_devs;
> > > +	struct device_node *child;
> > > +	enum rpu_tcm_comb tcm_mode;
> > > +	int core_count, ret, i;
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
> > > +	 * fail driver probe if either of that is not set in dts.
> > > +	 */
> > > +	if (cluster_mode == LOCKSTEP_MODE) {
> > Why is are LOCKSTEP_MODE and LOCKSTEP_MODE defined when the same values were
> > already added in xlnx-zynqmp.h in patch 3/6?
> 
> Actually LOCKSTEP_MODE defined in this driver is taken from dt-bindings of
> this driver. However, PM_RPU_MODE_LOCKSTEP defined in firmware represents
> value expected by firmware. They are not the same defines. LOCKSTEP_MODE = 1
> which is defined as per xlnx,cluster-mode bindings and similar to ti
> cluster-mode bindings. PM_RPU_MODE_LOCKSTEP = 0 which is expected from
> firmware.

Ah yes, you are correct.

> 
> 
> >    And why not add SINGLE_CPU_MODE
> > there as well instead of duplicating things in enum zynqmp_r5_cluster_mode?
> 
> 
> SINGLE_CPU_MODE just represents xlnx,cluster-mode value from dt-bindings. It
> is not supported in firmware.
> 
> There are multiple ways to configure r5 cluster in single-cpu mode.
> 
> 1) Add new EEMI call which asks firmware to configure cluster in single-cpu
> mode.
> 
> or 2) use existing EEMI calls and configure cores from driver. As
> single-cpu-mode is not supported yet, I am not sure, how it will
> 
> be implemented or what its design will look like. So, I haven't modified
> anything in firmware driver related to single-cpu mode.
> 
>

That is fine.

> > > +		tcm_mode = PM_RPU_TCM_COMB;
> > > +		fw_reg_val = PM_RPU_MODE_LOCKSTEP;
> > > +	} else if (cluster_mode == SPLIT_MODE) {
> > > +		tcm_mode = PM_RPU_TCM_SPLIT;
> > > +		fw_reg_val = PM_RPU_MODE_SPLIT;
> > > +	} else {
> > > +		dev_err(dev, "driver does not support cluster mode %d\n", cluster_mode);
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
> > > +	child_devs = kcalloc(core_count, sizeof(struct device *), GFP_KERNEL);
> > > +	if (!child_devs)
> > > +		return -ENOMEM;
> > > +
> > > +	r5_cores = kcalloc(core_count,
> > > +			   sizeof(struct zynqmp_r5_core *), GFP_KERNEL);
> > > +	if (!r5_cores) {
> > > +		kfree(child_devs);
> > > +		return -ENOMEM;
> > > +	}
> > > +
> > > +	i = 0;
> > > +	for_each_available_child_of_node(dev_node, child) {
> > > +		child_pdev = of_find_device_by_node(child);
> > > +		if (!child_pdev) {
> > > +			of_node_put(child);
> > > +			ret = -ENODEV;
> > > +			goto release_r5_cores;
> > > +		}
> > > +
> > > +		child_devs[i] = &child_pdev->dev;
> > > +
> > > +		/* create and add remoteproc instance of type struct rproc */
> > > +		r5_cores[i] = zynqmp_r5_add_rproc_core(&child_pdev->dev);
> > > +		if (IS_ERR(r5_cores[i])) {
> > > +			of_node_put(child);
> > > +			ret = PTR_ERR(r5_cores[i]);
> > > +			goto release_r5_cores;
> > If we are here and i == 0, we are leaking a reference to child_pdev since the
> > loop in release_r5_cores won't execute.
> Ack. I will check if i == 0 and put_device() before jumping to
> release_r5_cores.
> > 
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
> > Instead of using the i to check the cores, simply break if cluster_mode ==
> > LOCKSTEP_MODE.  That will avoid the fragile dance around the manipulation of
> > variable i and simplify the release of resources in release_r5_cores.
> > 
> Actually variable name "i" needs to be changed. I need that variable to
> track how many cores  are added successfully.
> 
> So, if first core is added and second core fails, then I can release
> resources allocated for first core successfully.
> 
> So, instead of "i" I can use meaningful variable name like "cores_added" or
> "cores_allocated".


You can still use variable @i, just don't use it to break out of the loop.  As I
pointed out, it would be much easier to simply do that if in lockstep mode.

> 
> > > +	}
> > > +
> > > +	cluster->mode = cluster_mode;
> > > +	cluster->core_count = core_count;
> > > +	cluster->r5_cores = r5_cores;
> > > +
> > > +	ret = zynqmp_r5_core_init(cluster, fw_reg_val, tcm_mode);
> > > +	if (ret < 0) {
> > > +		dev_err(dev, "failed to init r5 core err %d\n", ret);
> > > +		cluster->core_count = 0;
> > > +		cluster->r5_cores = NULL;
> > > +		goto release_r5_cores;
> > > +	}
> > > +
> > > +	kfree(child_devs);
> > > +	return 0;
> > > +
> > > +release_r5_cores:
> > > +	for (i--; i >= 0; i--) {
> > > +		put_device(child_devs[i]);
> > > +		rproc_del(r5_cores[i]->rproc);
> > > +		rproc_free(r5_cores[i]->rproc);
> > > +	}
> > > +	kfree(r5_cores);
> > > +	kfree(child_devs);
> > > +	return ret;
> > > +}
> > > +
> > > +static void zynqmp_r5_cluster_exit(void *data)
> > > +{
> > > +	struct platform_device *pdev = (struct platform_device *)data;
> > > +	struct zynqmp_r5_cluster *cluster;
> > > +	struct zynqmp_r5_core *r5_core;
> > > +	int i;
> > > +
> > > +	cluster = (struct zynqmp_r5_cluster *)platform_get_drvdata(pdev);
> > > +	if (!cluster)
> > > +		return;
> > > +
> > > +	for (i = 0; i < cluster->core_count; i++) {
> > > +		r5_core = cluster->r5_cores[i];
> > > +		put_device(r5_core->dev);
> > > +		rproc_del(r5_core->rproc);
> > > +		rproc_free(r5_core->rproc);
> > > +	}
> > > +
> > > +	kfree(cluster->r5_cores);
> > > +	kfree(cluster);
> > > +	platform_set_drvdata(pdev, NULL);
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
> > > +	struct zynqmp_r5_cluster *cluster;
> > > +	struct device *dev = &pdev->dev;
> > > +	int ret;
> > > +
> > > +	cluster = kzalloc(sizeof(*cluster), GFP_KERNEL);
> > > +	if (!cluster)
> > > +		return -ENOMEM;
> > > +
> > > +	cluster->dev = dev;
> > > +
> > > +	ret = devm_of_platform_populate(dev);
> > > +	if (ret) {
> > > +		dev_err_probe(dev, ret, "failed to populate platform dev\n");
> > > +		kfree(cluster);
> > > +		return ret;
> > > +	}
> > > +
> > > +	/* wire in so each core can be cleaned up at driver remove */
> > > +	platform_set_drvdata(pdev, cluster);
> > > +
> > > +	ret = zynqmp_r5_cluster_init(cluster);
> > > +	if (ret) {
> > > +		zynqmp_r5_cluster_exit(pdev);
> > > +		dev_err_probe(dev, ret, "Invalid r5f subsystem device tree\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	ret = devm_add_action_or_reset(dev, zynqmp_r5_cluster_exit, pdev);
> > > +	if (ret)
> > > +		return ret;
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
> > > +MODULE_LICENSE("GPL");
> > There is a discrepency between the GPL-2.0 in the SPDS identifier and the above.
> > 
> > More comments tomorrow or Tuesday.
> > 
> > Thanks,
> > Mathieu
> > 
> > > -- 
> > > 2.25.1
> > > 
