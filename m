Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3774ADEB8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 17:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383610AbiBHQy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 11:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383602AbiBHQy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 11:54:57 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F27C061579
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 08:54:56 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id 10so6414112plj.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 08:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mYKqorhY2yoXLPrUdcMqI1ztlkgvGtnVJG8WChD1TOY=;
        b=zt7WxsTnEzIZmPwHzg6cZ26mO39xuudUFURwhqlIaKG8C5fFrFqG5q6CalzsKqiiCZ
         vBEYUEnLEUYKa9+QzwR20J7Uk4IRFToqMNdgskx/UvzXv/cbjpN2pDYpbdzHwdvlAmqZ
         GyO6mwucNMtnz+jQ7m4ciQYLV2uOdr8nKqhH/uSSrVHZZZ/QRJqJFaXO/xJ1d3Itn+Y0
         wfBNl/h5Eq5Aknck4ChjUOZNmoIOrrxj54efC37z0m9MowG60JAvbtbFaUlT66vDdIR/
         fawKlTBBcjGcUdpsl6FzVTWloQ3w+YiKYQ7zIy3wbanNvE6OGm2a4aSIoxJO3rYvQLzs
         6p2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mYKqorhY2yoXLPrUdcMqI1ztlkgvGtnVJG8WChD1TOY=;
        b=Ch9N4IH0WAduuw5cXLdE2z1NsjjnCZCC6s2ZuI2KvVLGe0u/OrH8sgku4OG+EAul1m
         VwuvPDAwvrV6ReKCS/BemeUyy3GEh76x8tkkSGkWdxDdUHLF8l1Cb32T9BePdjynk5mP
         r2MPibiThzXe+Cid2fpDd558vcJYwuYWQkJk83VgJkYl2cqNFpndAtgMUXvsTVGLdRTZ
         Y3aEX8bKAl60e3v8qMogFWg1tZuTAXbPwkAdJg76nsRU9K0E7o1t6CxwtT9rnX9c+S1l
         JOADJ6Nb6JR7XUfmGcbTLAz8jU/2j+n8+0VUsCWo7R/c13uEGcz95tClKJAmqMHyYgI6
         +V6g==
X-Gm-Message-State: AOAM530FdSnNtWkr7XTmCiZ2NMB9fqsyn+wr05EQ33fDTZcbXZYDNmbt
        fEMv7dVoVN3phwMXACH75zFV5A==
X-Google-Smtp-Source: ABdhPJwUB7Ft8l8MPRVH8nysN4qSodaeLS8cuOhiorVg8MvubTJkh4yld84aUu7Xw2aI/3EVrqjAfg==
X-Received: by 2002:a17:902:b184:: with SMTP id s4mr5336578plr.7.1644339296029;
        Tue, 08 Feb 2022 08:54:56 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id f12sm16924826pfv.30.2022.02.08.08.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 08:54:54 -0800 (PST)
Date:   Tue, 8 Feb 2022 09:54:52 -0700
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
Message-ID: <20220208165452.GB3495196@p14s>
References: <20211123062050.1442712-1-tanmay.shah@xilinx.com>
 <20211123062050.1442712-7-tanmay.shah@xilinx.com>
 <20211207183118.GA1099463@p14s>
 <2138161e-bf6b-c22d-1c73-a93bc334da4f@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2138161e-bf6b-c22d-1c73-a93bc334da4f@xilinx.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tanmay,

[...]

> > 
> > I am done reviewing this set - the overall structure is sound but there is a
> > fair amount of work to be done.  There is no need to rush another revision as I
> > won't have time to review it before the holidays.  On that front, change
> > _only_ the things I have commented on.  We can address other issues as we move
> > forward.  Last but not least, please run the sparse checker on your work.
> > 
> > Thanks,
> > Mathieu
> 
> Hi Mathieu,
> 
> I am ready to post v3 in this patch series.
> 
> I have developed v3 based on rproc-next. However, when I rebased my work on
> tip of linux-next branch,

Are the merge conflicts related to drivers/remoteproc or drivers/rpmsg?  That
would be surprising since the code that is in rproc-next and rpmsg-next is also
in linux-next.

In any case I would suggest to base your v3 on _today's_ for-next branch [1] and
explicitly mention any dependency in the cover letter.  From there I might be
able to see where the problems are and advise further.

[1]. https://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git/log/?h=for-next

> 
> I faced merge-conflicts.
> 
> What is preferred way to proceed in such case? Should I post my patch based
> on rproc-next or linux-next?
> 
> Or any other way to proceed further?
> 
> 
> > > +
> > > +	dev = r5_core->dev;
> > > +
> > > +	ret = add_tcm_banks(rproc);
> > > +	if (ret) {
> > > +		dev_err(dev, "failed to get TCM banks, err %d\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	ret = add_mem_regions(rproc);
> > > +	if (ret)
> > > +		dev_warn(dev, "failed to get reserve mem regions %d\n", ret);
> > > +
> > > +	ret = rproc_elf_load_rsc_table(rproc, fw);
> > > +	if (ret == -EINVAL) {
> > > +		/*
> > > +		 * resource table only required for IPC.
> > > +		 * if not present, this is not necessarily an error;
> > > +		 * for example, loading r5 hello world application
> > > +		 * so simply inform user and keep going.
> > > +		 */
> > > +		dev_info(&rproc->dev, "no resource table found.\n");
> > > +		ret = 0;
> > > +	}
> > > +	return ret;
> > > +}
> > > +
> > > +static struct rproc_ops zynqmp_r5_rproc_ops = {
> > > +	.start		= zynqmp_r5_rproc_start,
> > > +	.stop		= zynqmp_r5_rproc_stop,
> > > +	.load		= rproc_elf_load_segments,
> > > +	.parse_fw	= zynqmp_r5_parse_fw,
> > > +	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
> > > +	.sanity_check	= rproc_elf_sanity_check,
> > > +	.get_boot_addr	= rproc_elf_get_boot_addr,
> > > +};
> > > +
> > > +static void zynqmp_r5_print_dt_node_info(struct zynqmp_r5_cluster *cluster)
> > > +{
> > > +	int i, j, k;
> > > +	struct zynqmp_r5_core *r5_core;
> > > +
> > > +	dev_dbg(cluster->dev, "Printing dt node info\n");
> > > +
> > > +	pr_debug("cluster mode = %d\n", cluster->mode);
> > > +	pr_debug("r5f cluster in %s mode\n", (cluster->mode == 0) ? "SPLIT" :
> > > +		 cluster->mode == 1 ? "LOCKSTEP" : "SINGLE_CPU");
> > > +	pr_debug("r5f num cores = %d\n", cluster->core_count);
> > > +
> > > +	for (i = 0; i < cluster->core_count; i++) {
> > > +		r5_core = &cluster->r5_cores[i];
> > > +		if (!r5_core) {
> > > +			pr_err("can't get r5_core\n");
> > > +			continue;
> > > +		}
> > > +
> > > +		pr_debug("r5 core %d nodes\n", i);
> > > +		pr_debug("TCM banks = %d\n", r5_core->tcm_bank_count);
> > > +		for (k = 0; k < r5_core->tcm_bank_count; k++) {
> > > +			pr_debug("tcm %d addr=0x%llx size=0x%lx, pm_id=%d, %s\n",
> > > +				 k, r5_core->tcm_banks[k].addr,
> > > +				 r5_core->tcm_banks[k].size,
> > > +				 r5_core->tcm_banks[k].pm_domain_id,
> > > +				 r5_core->tcm_banks[k].bank_name);
> > > +		}
> > > +
> > > +		pr_debug("reserve mem regions = %d\n", r5_core->res_mem_count);
> > > +
> > > +		for (j = 0; j < r5_core->res_mem_count; j++) {
> > > +			pr_debug("mem %d addr=0x%llx, size=0x%llx, name=%s\n",
> > > +				 j, r5_core->res_mem[j].base,
> > > +				 r5_core->res_mem[j].size,
> > > +				 r5_core->res_mem[j].name);
> > > +		}
> > > +	}
> > > +}
> > > +
> > > +/**
> > > + * zynqmp_r5_add_rproc_core() - Probes ZynqMP R5 processor device node
> > > + *		       this is called for each individual R5 core to
> > > + *		       set up mailbox, Xilinx platform manager unique ID,
> > > + *		       add to rproc core
> > > + *
> > > + * @r5_core: zynqmp_r5_core r5 core object to initialize
> > > + *
> > > + * Return: 0 for success, negative value for failure.
> > > + */
> > > +static int zynqmp_r5_add_rproc_core(struct zynqmp_r5_core *r5_core)
> > > +{
> > > +	int ret;
> > > +	struct rproc *r5_rproc;
> > > +	struct device *dev;
> > > +
> > > +	dev = r5_core->dev;
> > > +
> > > +	/* Set up DMA mask */
> > > +	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	/* Allocate remoteproc instance */
> > > +	r5_rproc = devm_rproc_alloc(dev, dev_name(dev), &zynqmp_r5_rproc_ops,
> > > +				    NULL, sizeof(struct zynqmp_r5_core));
> > > +	if (IS_ERR_OR_NULL(r5_rproc))
> > > +		return -ENOMEM;
> > > +
> > > +	r5_rproc->auto_boot = false;
> > > +	r5_rproc->priv = r5_core;
> > > +
> > > +	/* Add R5 remoteproc */
> > > +	ret = devm_rproc_add(dev, r5_rproc);
> > > +	if (ret) {
> > > +		pr_err("failed to add r5 remoteproc\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	return 0;
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
