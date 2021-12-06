Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1B846A555
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 20:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348215AbhLFTI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 14:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347046AbhLFTIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 14:08:25 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AD4C0613F8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 11:04:56 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id cq22-20020a17090af99600b001a9550a17a5so54177pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 11:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W/w6/DUyBNJdb/thGlHdj3m2+5/pQAkRd23hmes5C2g=;
        b=bEndfV4TJgRDkM21/+7r/pIiBnc0TLygIOZudKiPKhup+JKMbYDSdImGeE2RTkx/+H
         0gZmOsCBJ+qeN6WXc10ZlaPKa8GwKugZ7vFXtUSK5ModiwU0YqjYR+6kycCE6MUlTdhd
         VZUi1461A60CWNsf/Xt6idF4sNU0rlcRS1mSRwbix1yNafUTmlpJgrVwJhH3nO8lKJPu
         lVXw7vHj/LgQBataViKvIqp3WcQit4fO3Y+8/F2XirI261Qq18gIoqXSKv5BAr5ZTrbl
         87BVVNAcm7Ey952F7SDucXGtCJ8Dr+FaAYgh2FlBvxLNFmVJd6TftpFqa3yspARgTPp7
         dx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W/w6/DUyBNJdb/thGlHdj3m2+5/pQAkRd23hmes5C2g=;
        b=h7dS01dJsoOhplbGu4Rb8OjOUGg43jqIx0M1RbIF160yrfsKQXRxBUNW289PxClXP3
         XemTCx1mhQiDwTDbcRP1avEA3MLIx+yNObQw61kEUUJRW8mNai90KqyfjkzqNiroxUMc
         4+xO/PJ/v4KuOHKJS9w0ADa42xj/JgQPTnuW6TVrJaAJjcX0OiylQzIXFXwY8xgMvj3p
         9FyutK1Mo/b18CeI+e/p6IVpern6+8kf+mAx7bZ48pX4H4Xl6WELI9dE8PF6DE55AKV7
         Tm+iGIHPI2Y+rCZnRGPWXCAeNK5/A3Fk/2Fkc6fo6xhy8sA6zdACUTKj+V9kcfc/sYaq
         51ng==
X-Gm-Message-State: AOAM5309ZJDujvGZWwrg2oY5Qe4R2sSdGIq1MGBg/Gri8NxThA2c2i09
        nioYvb9F4IRxT0k2sGmv8dPXkrfOcZGG9Q==
X-Google-Smtp-Source: ABdhPJwTK7nKdOzNTc9dp7pcdvPov5JBSgOBMfAC/3s8N42EjhIkVatqUYXPEcBqUeRVjWCEFNttsg==
X-Received: by 2002:a17:90a:e00f:: with SMTP id u15mr462291pjy.123.1638817496053;
        Mon, 06 Dec 2021 11:04:56 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id n16sm109663pja.46.2021.12.06.11.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 11:04:54 -0800 (PST)
Date:   Mon, 6 Dec 2021 12:04:51 -0700
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
Message-ID: <20211206190451.GA1059064@p14s>
References: <20211123062050.1442712-1-tanmay.shah@xilinx.com>
 <20211123062050.1442712-7-tanmay.shah@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123062050.1442712-7-tanmay.shah@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 10:20:50PM -0800, Tanmay Shah wrote:
> This driver enables r5f dual core Real time Processing Unit subsystem
> available on Xilinx Zynq Ultrascale MPSoC Platform. RPU subsystem
> (cluster) can be configured in different modes e.g. split mode in which
> two r5f cores work independent of each other and lock-step mode in which
> both r5f cores execute same code clock-for-clock and notify if the
> result is different.
> 
> The Xilinx r5 Remoteproc Driver boots the RPU cores via calls to the Xilinx
> Platform Management Unit that handles the R5 configuration, memory access
> and R5 lifecycle management. The interface to this manager is done in this
> driver via zynqmp_pm_* function calls.
> 
> Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
> Signed-off-by: Tanmay Shah <tanmay.shah@xilinx.com>
> ---
>  drivers/remoteproc/Kconfig              |  12 +
>  drivers/remoteproc/Makefile             |   1 +
>  drivers/remoteproc/xlnx_r5_remoteproc.c | 959 ++++++++++++++++++++++++
>  3 files changed, 972 insertions(+)
>  create mode 100644 drivers/remoteproc/xlnx_r5_remoteproc.c
> 
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index f30d00a3aabe..27f66910d8d3 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -315,6 +315,18 @@ config TI_K3_R5_REMOTEPROC
>  	  It's safe to say N here if you're not interested in utilizing
>  	  a slave processor.
>  
> +config XLNX_R5_REMOTEPROC
> +	tristate "Xilinx R5 remoteproc support"
> +	depends on PM && ARCH_ZYNQMP
> +	depends on ZYNQMP_FIRMWARE
> +	select RPMSG_VIRTIO
> +	select ZYNQMP_IPI_MBOX
> +	help
> +	  Say y or m here to support Xilinx R5 remote processors via the remote
> +	  processor framework.
> +
> +	  It's safe to say N if not interested in using RPU r5f cores.
> +
>  endif # REMOTEPROC
>  
>  endmenu
> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
> index bb26c9e4ef9c..334a8bed4c14 100644
> --- a/drivers/remoteproc/Makefile
> +++ b/drivers/remoteproc/Makefile
> @@ -35,3 +35,4 @@ obj-$(CONFIG_ST_SLIM_REMOTEPROC)	+= st_slim_rproc.o
>  obj-$(CONFIG_STM32_RPROC)		+= stm32_rproc.o
>  obj-$(CONFIG_TI_K3_DSP_REMOTEPROC)	+= ti_k3_dsp_remoteproc.o
>  obj-$(CONFIG_TI_K3_R5_REMOTEPROC)	+= ti_k3_r5_remoteproc.o
> +obj-$(CONFIG_XLNX_R5_REMOTEPROC)	+= xlnx_r5_remoteproc.o
> diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
> new file mode 100644
> index 000000000000..c2167fd3869d
> --- /dev/null
> +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
> @@ -0,0 +1,959 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ZynqMP R5 Remote Processor driver
> + *
> + */
> +
> +#include <dt-bindings/power/xlnx-zynqmp-power.h>
> +#include <linux/firmware/xlnx-zynqmp.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/mailbox/zynqmp-ipi-message.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_reserved_mem.h>
> +#include <linux/platform_device.h>
> +#include <linux/remoteproc.h>
> +#include <linux/skbuff.h>
> +#include <linux/sysfs.h>
> +
> +#include "remoteproc_internal.h"
> +
> +/* settings for RPU cluster mode */
> +enum zynqmp_r5_cluster_mode {
> +	SPLIT_MODE = 0, // RPU cluster mode when cores run as separate processor
> +	LOCKSTEP_MODE = 1, // cores execute same code in lockstep,clk-for-clk
> +	SINGLE_CPU_MODE = 2, // core0 is held in reset and only core1 runs
> +};
> +
> +/**
> + * struct mem_bank_data - Memory Bank description
> + *
> + * @addr: Start address of memory bank
> + * @size: Size of Memory bank
> + * @pm_domain_id: Power-domains id of memory bank for firmware to turn on/off
> + * @bank_name: name of the bank for remoteproc framework
> + */
> +struct mem_bank_data {
> +	phys_addr_t addr;
> +	size_t size;
> +	enum pm_node_id pm_domain_id;
> +	char *bank_name;
> +};
> +
> +static const struct mem_bank_data zynqmp_tcm_banks[] = {
> +	{0xffe00000UL, 0x10000UL, PD_R5_0_ATCM, "atcm0"}, /* TCM 64KB each */
> +	{0xffe20000UL, 0x10000UL, PD_R5_0_BTCM, "btcm0"},
> +	{0xffe90000UL, 0x10000UL, PD_R5_1_ATCM, "atcm1"},
> +	{0xffeb0000UL, 0x10000UL, PD_R5_1_BTCM, "btcm1"},
> +};
> +
> +/**
> + * struct zynqmp_r5_core - ZynqMP R5 core structure
> + *
> + * @dev: device of RPU instance
> + * @np: device node of RPU instance
> + * @tcm_bank_count: number TCM banks accessible to this RPU
> + * @tcm_banks: array of each TCM bank data
> + * @res_mem_count: number of Reserved Memory regions per core
> + * @res_mem: array of reserved memory regions
> + * @rproc: rproc handle
> + * @pm_domain_id: RPU CPU power domain id
> + */
> +struct zynqmp_r5_core {
> +	struct device *dev;
> +	struct device_node *np;
> +	int tcm_bank_count;
> +	struct mem_bank_data *tcm_banks;
> +	int res_mem_count;
> +	struct reserved_mem *res_mem;
> +	struct rproc *rproc;
> +	enum pm_node_id pm_domain_id;
> +};
> +
> +/**
> + * struct zynqmp_r5_cluster - ZynqMP R5 cluster structure
> + *
> + * @dev: r5f subsystem cluster device node
> + * @mode: cluster mode of type zynqmp_r5_cluster_mode
> + * @core_count: number of r5 cores used for this cluster mode
> + * @r5_cores: Array of r5 cores of type struct zynqmp_r5_core
> + */
> +struct zynqmp_r5_cluster {
> +	struct device *dev;
> +	enum  zynqmp_r5_cluster_mode mode;
> +	int core_count;
> +	struct zynqmp_r5_core *r5_cores;
> +};
> +
> +/*
> + * zynqmp_r5_set_mode - set RPU operation mode
> + *
> + * set RPU operation mode
> + *
> + * Return: 0 for success, negative value for failure
> + */
> +static int zynqmp_r5_set_mode(struct zynqmp_r5_core *r5_core,
> +			      enum zynqmp_r5_cluster_mode rpu_mode)
> +{
> +	enum rpu_tcm_comb tcm_mode;
> +	int ret, reg_val;
> +
> +	reg_val = (rpu_mode == LOCKSTEP_MODE ? 0 : 1);

Here split and single-cpu mode are treated the same... Is this an omission or
really how the HW works?  A good dose of documentation is definitely needed.

> +
> +	ret = zynqmp_pm_set_rpu_mode(r5_core->pm_domain_id, reg_val);
> +	if (ret < 0) {
> +		pr_err("failed to set RPU mode\n");
> +		return ret;
> +	}
> +
> +	tcm_mode = (rpu_mode == LOCKSTEP_MODE) ?
> +		    PM_RPU_TCM_COMB : PM_RPU_TCM_SPLIT;
> +	ret = zynqmp_pm_set_tcm_config(r5_core->pm_domain_id, tcm_mode);
> +	if (ret < 0)
> +		pr_err("failed to configure TCM\n");
> +
> +	return ret;
> +}
> +
> +/*
> + * zynqmp_r5_rproc_start
> + * @rproc: single R5 core's corresponding rproc instance
> + *
> + * Start R5 Core from designated boot address.
> + *
> + * return 0 on success, otherwise non-zero value on failure
> + */
> +static int zynqmp_r5_rproc_start(struct rproc *rproc)
> +{
> +	struct zynqmp_r5_core *r5_core = rproc->priv;
> +	enum rpu_boot_mem bootmem;
> +	int ret;
> +
> +	if (!r5_core) {
> +		pr_err("can't get r5 core\n");
> +		return -EINVAL;
> +	}
> +
> +	bootmem = (rproc->bootaddr >= 0xFFFC0000) ?
> +		   PM_RPU_BOOTMEM_HIVEC : PM_RPU_BOOTMEM_LOVEC;
> +
> +	dev_dbg(r5_core->dev, "RPU boot addr 0x%llx from %s.", rproc->bootaddr,
> +		bootmem == PM_RPU_BOOTMEM_HIVEC ? "OCM" : "TCM");
> +
> +	ret = zynqmp_pm_request_wake(r5_core->pm_domain_id, 1,
> +				     bootmem, ZYNQMP_PM_REQUEST_ACK_NO);
> +	if (ret)
> +		pr_err("failed to start RPU = %d\n", r5_core->pm_domain_id);
> +	return ret;
> +}
> +
> +/*
> + * zynqmp_r5_rproc_stop
> + * @rproc: single R5 core's corresponding rproc instance
> + *
> + * Power down  R5 Core.
> + *
> + * return 0 on success, otherwise non-zero value on failure
> + */
> +static int zynqmp_r5_rproc_stop(struct rproc *rproc)
> +{
> +	struct zynqmp_r5_core *r5_core = rproc->priv;
> +	int ret;
> +
> +	ret = zynqmp_pm_force_pwrdwn(r5_core->pm_domain_id,
> +				     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> +	if (ret)
> +		pr_err("failed to stop remoteproc RPU %d\n", ret);
> +
> +	return ret;
> +}
> +
> +/*
> + * zynqmp_r5_rproc_mem_map
> + * @rproc: single R5 core's corresponding rproc instance
> + * @mem: mem entry to map
> + *
> + * Callback to map va for memory-region's carveout.
> + *
> + * return 0 on success, otherwise non-zero value on failure
> + */
> +static int zynqmp_r5_rproc_mem_map(struct rproc *rproc,
> +				   struct rproc_mem_entry *mem)
> +{
> +	void __iomem *va;
> +
> +	va = ioremap_wc(mem->dma, mem->len);
> +	if (IS_ERR_OR_NULL(va))
> +		return -ENOMEM;
> +
> +	mem->va = (void *)va;
> +
> +	return 0;
> +}
> +
> +/*
> + * zynqmp_r5_rproc_mem_unmap
> + * @rproc: single R5 core's corresponding rproc instance
> + * @mem: mem entry to unmap
> + *
> + * Unmap memory-region carveout
> + *
> + * return 0 on success, otherwise non-zero value on failure
> + */
> +static int zynqmp_r5_rproc_mem_unmap(struct rproc *rproc,
> +				     struct rproc_mem_entry *mem)
> +{
> +	iounmap((void __iomem *)mem->va);
> +	return 0;
> +}
> +
> +/*
> + * add_mem_regions
> + * @rproc: single R5 core's corresponding rproc instance
> + *
> + * Construct rproc mem carveouts from carveout provided in
> + * memory-region property
> + *
> + * return 0 on success, otherwise non-zero value on failure
> + */
> +static int add_mem_regions(struct rproc *rproc)
> +{
> +	struct device *dev;
> +	struct rproc_mem_entry *mem;
> +	struct reserved_mem *rmem;
> +	struct zynqmp_r5_core *r5_core;
> +	int i;
> +
> +	r5_core = rproc->priv;
> +	dev = r5_core->dev;
> +
> +	/* Register associated reserved memory regions */
> +	for (i = 0; i < r5_core->res_mem_count; i++) {
> +		rmem = &r5_core->res_mem[i];
> +		mem = rproc_mem_entry_init(dev, NULL,
> +					   (dma_addr_t)rmem->base,
> +					   rmem->size, rmem->base,
> +					   zynqmp_r5_rproc_mem_map,
> +					   zynqmp_r5_rproc_mem_unmap,
> +					   rmem->name);
> +		if (IS_ERR_OR_NULL(mem))
> +			return -ENOMEM;
> +
> +		rproc_add_carveout(rproc, mem);
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * zynqmp_r5_rproc_mem_unmap
> + * @rproc: single R5 core's corresponding rproc instance
> + * @mem: mem entry to unmap
> + *
> + * Unmap TCM banks when powering down R5 core.
> + *
> + * return 0 on success, otherwise non-zero value on failure
> + */
> +static int tcm_mem_unmap(struct rproc *rproc, struct rproc_mem_entry *mem)
> +{
> +	struct zynqmp_r5_core *r5_core;
> +	int i;
> +	enum pm_node_id pm_domain_id;
> +
> +	r5_core = rproc->priv;
> +	if (!r5_core) {
> +		pr_err("r5 core is not available\n");
> +		return -EINVAL;
> +	}
> +
> +	iounmap((void __iomem *)mem->va);
> +
> +	for (i = 0; i < r5_core->tcm_bank_count; i++) {
> +		pm_domain_id = r5_core->tcm_banks[i].pm_domain_id;
> +		if (zynqmp_pm_release_node(pm_domain_id))
> +			pr_warn("can't turn off TCM bank %d", pm_domain_id);
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * tcm_mem_map
> + * @rproc: single R5 core's corresponding rproc instance
> + * @mem: mem entry to initialize the va and da fields of
> + *
> + * Given TCM bank entry, this callback will set device address for R5
> + * running on TCM and also setup virtual address for TCM bank
> + * remoteproc carveout.
> + *
> + * return 0 on success, otherwise non-zero value on failure
> + */
> +static int tcm_mem_map(struct rproc *rproc,
> +			 struct rproc_mem_entry *mem)
> +{
> +	void __iomem *va;
> +
> +	va = ioremap_wc(mem->dma, mem->len);
> +	if (IS_ERR_OR_NULL(va))
> +		return -ENOMEM;
> +
> +	/* Update memory entry va */
> +	mem->va = (void *)va;
> +
> +	/* clear TCMs */
> +	memset_io(va, 0, mem->len);
> +
> +	/*
> +	 * The R5s expect their TCM banks to be at address 0x0 and 0x2000,
> +	 * while on the Linux side they are at 0xffexxxxx.
> +	 *
> +	 * Zero out the high 12 bits of the address. This will give
> +	 * expected values for TCM Banks 0A and 0B (0x0 and 0x20000).
> +	 */
> +	mem->da &= 0x000fffff;
> +
> +	/*
> +	 * TCM Banks 1A and 1B still have to be translated.
> +	 *
> +	 * Below handle these two banks' absolute addresses (0xffe90000 and
> +	 * 0xffeb0000) and convert to the expected relative addresses
> +	 * (0x0 and 0x20000).
> +	 */
> +	if (mem->da == 0x90000 || mem->da == 0xB0000)
> +		mem->da -= 0x90000;
> +
> +	/* if translated TCM bank address is not valid report error */
> +	if (mem->da != 0x0 && mem->da != 0x20000) {
> +		dev_err(&rproc->dev, "invalid TCM address: %x\n", mem->da);
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static int add_tcm_carveout_split_mode(struct rproc *rproc)
> +{
> +	int i, num_banks, ret;
> +	struct rproc_mem_entry *mem;
> +	enum pm_node_id pm_domain_id;
> +	u32 bank_addr;
> +	size_t bank_size = 0;
> +	char *bank_name;
> +	struct device *dev;
> +	struct zynqmp_r5_core *r5_core;
> +
> +	r5_core = (struct zynqmp_r5_core *)rproc->priv;
> +	if (!r5_core)
> +		return -EINVAL;
> +
> +	dev = r5_core->dev;
> +
> +	/* go through zynqmp banks for r5 node */
> +	num_banks = r5_core->tcm_bank_count;
> +	if (num_banks <= 0) {
> +		dev_err(dev, "need to specify TCM banks\n");
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < num_banks; i++) {
> +		bank_addr = (u32)r5_core->tcm_banks[i].addr;
> +		bank_name = r5_core->tcm_banks[i].bank_name;
> +		bank_size = r5_core->tcm_banks[i].size;
> +		pm_domain_id = r5_core->tcm_banks[i].pm_domain_id;
> +
> +		ret = zynqmp_pm_request_node(pm_domain_id,
> +					     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
> +					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> +		if (ret < 0) {
> +			dev_err(dev, "failed to turn on TCM %d", pm_domain_id);
> +			return ret;
> +		}
> +
> +		dev_dbg(dev, "TCM carveout split mode %s addr=%x, size=0x%lx",
> +			bank_name, bank_addr, bank_size);
> +
> +		/* add carveout */
> +		mem = rproc_mem_entry_init(dev, NULL, bank_addr,
> +					   bank_size, bank_addr,
> +					   tcm_mem_map, tcm_mem_unmap,
> +					   bank_name);
> +		if (IS_ERR_OR_NULL(mem)) {
> +			/* Turn off all TCM banks turned on before */
> +			do {
> +				pm_domain_id = r5_core->tcm_banks[i].pm_domain_id;
> +				ret = zynqmp_pm_release_node((u32)pm_domain_id);
> +				if (ret)
> +					dev_warn(dev,
> +						 "fail to release node: %x, %x\n",
> +						 (u32)pm_domain_id, ret);
> +			} while (i--);
> +			return -ENOMEM;
> +		}
> +
> +		rproc_add_carveout(rproc, mem);
> +	}
> +
> +	return 0;
> +}
> +
> +static int add_tcm_carveout_lockstep_mode(struct rproc *rproc)
> +{
> +	int i, num_banks, ret;
> +	struct rproc_mem_entry *mem;
> +	enum pm_node_id pm_domain_id;
> +	u32 bank_addr;
> +	size_t bank_size = 0;
> +	char *bank_name;
> +	struct device *dev;
> +	struct platform_device *parent_pdev;
> +	struct zynqmp_r5_cluster *cluster;
> +	struct zynqmp_r5_core *r5_core;
> +
> +	r5_core = (struct zynqmp_r5_core *)rproc->priv;
> +	if (!r5_core)
> +		return -EINVAL;
> +
> +	dev = r5_core->dev;
> +	if (!dev) {
> +		pr_err("r5 core device unavailable\n");
> +		return -ENODEV;
> +	}
> +
> +	/* go through zynqmp banks for r5 node */
> +	num_banks = r5_core->tcm_bank_count;
> +	if (num_banks <= 0) {
> +		dev_err(dev, "need to specify TCM banks\n");
> +		return -EINVAL;
> +	}
> +
> +	bank_addr = (u32)r5_core->tcm_banks[0].addr;
> +	bank_name = r5_core->tcm_banks[0].bank_name;
> +	for (i = 0; i < num_banks; i++) {
> +		bank_size += r5_core->tcm_banks[i].size;
> +		pm_domain_id = r5_core->tcm_banks[i].pm_domain_id;
> +
> +		ret = zynqmp_pm_request_node(pm_domain_id,
> +					     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
> +					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> +		if (ret < 0) {
> +			dev_err(dev, "failed to turn on TCM %d", pm_domain_id);
> +			return ret;
> +		}
> +	}
> +
> +	dev_dbg(dev, "TCM add carveout lockstep mode %s addr=0x%x, size=0x%lx",
> +		bank_name, bank_addr, bank_size);
> +
> +	/* add carveout */
> +	mem = rproc_mem_entry_init(dev, NULL, bank_addr,
> +				   bank_size, bank_addr,
> +				   tcm_mem_map, tcm_mem_unmap,
> +				   bank_name);
> +	if (IS_ERR_OR_NULL(mem)) {
> +		for (i = 0; i < num_banks; i++) {
> +			pm_domain_id = r5_core->tcm_banks[i].pm_domain_id;
> +			ret = zynqmp_pm_release_node((u32)pm_domain_id);
> +			if (ret)
> +				dev_warn(dev,
> +					 "fail to release node: %x ret: %x\n",
> +					 (u32)pm_domain_id, ret);
> +		}
> +		return -ENOMEM;
> +	}
> +
> +	rproc_add_carveout(rproc, mem);
> +
> +	return 0;
> +}
> +
> +/*
> + * add_tcm_banks()
> + * @rproc: single R5 core's corresponding rproc instance
> + *
> + * Given R5 node in remoteproc instance
> + * allocate remoteproc carveout for TCM memory
> + * needed for firmware to be loaded
> + *
> + * return 0 on success, otherwise non-zero value on failure
> + */
> +static int add_tcm_banks(struct rproc *rproc)
> +{
> +	struct device *dev;
> +	struct platform_device *parent_pdev;
> +	struct zynqmp_r5_cluster *cluster;
> +	struct zynqmp_r5_core *r5_core;
> +
> +	r5_core = (struct zynqmp_r5_core *)rproc->priv;
> +	if (!r5_core)
> +		return -EINVAL;
> +
> +	dev = r5_core->dev;
> +	if (!dev) {
> +		pr_err("r5 core device unavailable\n");
> +		return -ENODEV;
> +	}
> +
> +	parent_pdev = to_platform_device(dev->parent);
> +	if (!parent_pdev) {
> +		dev_err(dev, "parent platform dev unavailable\n");
> +		return -ENODEV;
> +	}
> +
> +	cluster = platform_get_drvdata(parent_pdev);
> +	if (!cluster) {
> +		dev_err(&parent_pdev->dev, "Invalid driver data\n");
> +		return -EINVAL;
> +	}
> +
> +	if (cluster->mode == SPLIT_MODE)
> +		return add_tcm_carveout_split_mode(rproc);
> +	else if (cluster->mode == LOCKSTEP_MODE)
> +		return add_tcm_carveout_lockstep_mode(rproc);
> +
> +	dev_err(cluster->dev, "invalid cluster mode\n");
> +	return -EINVAL;
> +}
> +
> +/*
> + * zynqmp_r5_parse_fw()
> + * @rproc: single R5 core's corresponding rproc instance
> + * @fw: ptr to firmware to be loaded onto r5 core
> + *
> + * When loading firmware, ensure the necessary carveouts are in remoteproc
> + *
> + * return 0 on success, otherwise non-zero value on failure
> + */
> +static int zynqmp_r5_parse_fw(struct rproc *rproc, const struct firmware *fw)
> +{
> +	int ret;
> +	struct zynqmp_r5_core *r5_core;
> +	struct device *dev;
> +
> +	r5_core = rproc->priv;
> +	if (!r5_core) {
> +		dev_err(&rproc->dev, "r5 core not available\n");
> +		return -EINVAL;
> +	}
> +
> +	dev = r5_core->dev;
> +
> +	ret = add_tcm_banks(rproc);
> +	if (ret) {
> +		dev_err(dev, "failed to get TCM banks, err %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = add_mem_regions(rproc);
> +	if (ret)
> +		dev_warn(dev, "failed to get reserve mem regions %d\n", ret);
> +
> +	ret = rproc_elf_load_rsc_table(rproc, fw);
> +	if (ret == -EINVAL) {
> +		/*
> +		 * resource table only required for IPC.
> +		 * if not present, this is not necessarily an error;
> +		 * for example, loading r5 hello world application
> +		 * so simply inform user and keep going.
> +		 */
> +		dev_info(&rproc->dev, "no resource table found.\n");
> +		ret = 0;
> +	}
> +	return ret;
> +}
> +
> +static struct rproc_ops zynqmp_r5_rproc_ops = {
> +	.start		= zynqmp_r5_rproc_start,
> +	.stop		= zynqmp_r5_rproc_stop,
> +	.load		= rproc_elf_load_segments,
> +	.parse_fw	= zynqmp_r5_parse_fw,
> +	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
> +	.sanity_check	= rproc_elf_sanity_check,
> +	.get_boot_addr	= rproc_elf_get_boot_addr,
> +};
> +
> +static void zynqmp_r5_print_dt_node_info(struct zynqmp_r5_cluster *cluster)
> +{
> +	int i, j, k;
> +	struct zynqmp_r5_core *r5_core;
> +
> +	dev_dbg(cluster->dev, "Printing dt node info\n");
> +
> +	pr_debug("cluster mode = %d\n", cluster->mode);
> +	pr_debug("r5f cluster in %s mode\n", (cluster->mode == 0) ? "SPLIT" :
> +		 cluster->mode == 1 ? "LOCKSTEP" : "SINGLE_CPU");
> +	pr_debug("r5f num cores = %d\n", cluster->core_count);
> +
> +	for (i = 0; i < cluster->core_count; i++) {
> +		r5_core = &cluster->r5_cores[i];
> +		if (!r5_core) {
> +			pr_err("can't get r5_core\n");
> +			continue;
> +		}
> +
> +		pr_debug("r5 core %d nodes\n", i);
> +		pr_debug("TCM banks = %d\n", r5_core->tcm_bank_count);
> +		for (k = 0; k < r5_core->tcm_bank_count; k++) {
> +			pr_debug("tcm %d addr=0x%llx size=0x%lx, pm_id=%d, %s\n",
> +				 k, r5_core->tcm_banks[k].addr,
> +				 r5_core->tcm_banks[k].size,
> +				 r5_core->tcm_banks[k].pm_domain_id,
> +				 r5_core->tcm_banks[k].bank_name);
> +		}
> +
> +		pr_debug("reserve mem regions = %d\n", r5_core->res_mem_count);
> +
> +		for (j = 0; j < r5_core->res_mem_count; j++) {
> +			pr_debug("mem %d addr=0x%llx, size=0x%llx, name=%s\n",
> +				 j, r5_core->res_mem[j].base,
> +				 r5_core->res_mem[j].size,
> +				 r5_core->res_mem[j].name);
> +		}
> +	}
> +}
> +
> +/**
> + * zynqmp_r5_add_rproc_core() - Probes ZynqMP R5 processor device node
> + *		       this is called for each individual R5 core to
> + *		       set up mailbox, Xilinx platform manager unique ID,
> + *		       add to rproc core
> + *

Please get rid of the indentations.  That way it conforms to the rest of the
style in this file.

> + * @r5_core: zynqmp_r5_core r5 core object to initialize
> + *
> + * Return: 0 for success, negative value for failure.
> + */
> +static int zynqmp_r5_add_rproc_core(struct zynqmp_r5_core *r5_core)
> +{
> +	int ret;
> +	struct rproc *r5_rproc;
> +	struct device *dev;
> +
> +	dev = r5_core->dev;
> +
> +	/* Set up DMA mask */
> +	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
> +	if (ret)
> +		return ret;
> +
> +	/* Allocate remoteproc instance */
> +	r5_rproc = devm_rproc_alloc(dev, dev_name(dev), &zynqmp_r5_rproc_ops,
> +				    NULL, sizeof(struct zynqmp_r5_core));
> +	if (IS_ERR_OR_NULL(r5_rproc))
> +		return -ENOMEM;

devm_rproc_alloc() doesn't return an error code.

> +
> +	r5_rproc->auto_boot = false;
> +	r5_rproc->priv = r5_core;

Here the original value of rproc->priv allocated by rproc_alloc() is replaced by
@r5_core, resulting in a memory leak.

> +
> +	/* Add R5 remoteproc */
> +	ret = devm_rproc_add(dev, r5_rproc);
> +	if (ret) {
> +		pr_err("failed to add r5 remoteproc\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int zynqmp_r5_get_tcm_node(struct zynqmp_r5_cluster *cluster)
> +{
> +	int tcm_bank_count, tcm_node;
> +	int i = 0, j;
> +	struct zynqmp_r5_core *r5_core;
> +	const struct mem_bank_data *tcm = zynqmp_tcm_banks;
> +	struct device *dev = cluster->dev;
> +
> +	/* ToDo: Use predefined TCM address space values from driver until
> +	 * system-dt spec is not final fot TCM
> +	 */
> +	tcm_bank_count = ARRAY_SIZE(zynqmp_tcm_banks);
> +
> +	/* count per core tcm banks */
> +	tcm_bank_count = tcm_bank_count / cluster->core_count;
> +
> +	/* r5 core 0 will use all of TCM banks in lockstep mode.
> +	 * In split mode, r5 core0 will use 128k and r5 core1 will use another
> +	 * 128k. Assign TCM banks to each core accordingly
> +	 */
> +	tcm_node = 0;
> +	for (j = 0; j < cluster->core_count; j++) {
> +		r5_core = &cluster->r5_cores[j];
> +		r5_core->tcm_banks = devm_kzalloc(dev, sizeof(struct mem_bank_data) *
> +						  tcm_bank_count, GFP_KERNEL);
> +		if (IS_ERR_OR_NULL(r5_core->tcm_banks))
> +			return -ENOMEM;
> +
> +		for (i = 0; i < tcm_bank_count; i++) {
> +			/* Use pre-defined TCM reg values.
> +			 * Eventually this should be replaced by values
> +			 * parsed from dts.
> +			 */
> +			r5_core->tcm_banks[i].addr = tcm[tcm_node].addr;
> +			r5_core->tcm_banks[i].size = tcm[tcm_node].size;
> +			r5_core->tcm_banks[i].pm_domain_id = tcm[tcm_node].pm_domain_id;
> +			r5_core->tcm_banks[i].bank_name = tcm[tcm_node].bank_name;
> +			tcm_node++;
> +		}
> +
> +		r5_core->tcm_bank_count = tcm_bank_count;
> +	}

Please use 'i' for the outer loop and 'j' for the inner one.  Otherwise people
are looking for a subtlety that isn't here.

> +
> +	return 0;
> +}
> +
> +static int zynqmp_r5_get_mem_region_node(struct zynqmp_r5_core *r5_core)
> +{
> +	int res_mem_count, i;
> +	struct device *dev;
> +	struct device_node *np, *rmem_np;
> +	struct reserved_mem *rmem;
> +
> +	dev = r5_core->dev;
> +
> +	np = r5_core->np;
> +	if (IS_ERR_OR_NULL(np)) {
> +		pr_err("invalid device node of r5 core\n");
> +		return -EINVAL;
> +	}

In normal cases this kind of defensive programming makes sense but here
r5_core->np has just been set in zynqmp_r5_cluster_init() where there is
plenty of gards against errors.  Please remove.
> +
> +	res_mem_count = of_property_count_elems_of_size(np, "memory-region",
> +							sizeof(phandle));
> +	if (res_mem_count <= 0) {
> +		dev_warn(dev, "failed to get memory-region property %d\n",
> +			 res_mem_count);
> +		return -EINVAL;
> +	}
> +
> +	r5_core->res_mem = devm_kzalloc(dev,
> +					res_mem_count * sizeof(struct reserved_mem),
> +					GFP_KERNEL);

Use devm_kcalloc() when more than one element is required.  Here and throughout
the driver.

> +	if (!r5_core->res_mem) {
> +		dev_err(dev, "failed to allocate mem region memory\n");
> +		return -ENOMEM;
> +	}
> +
> +	for (i = 0; i < res_mem_count; i++) {
> +		rmem_np = of_parse_phandle(np, "memory-region", i);
> +		if (!rmem_np)
> +			return -EINVAL;
> +
> +		rmem = of_reserved_mem_lookup(rmem_np);
> +		if (!rmem) {
> +			of_node_put(rmem_np);
> +			return -EINVAL;
> +		}
> +
> +		memcpy(&r5_core->res_mem[i], rmem,
> +		       sizeof(struct reserved_mem));

Why is the whole reserved_mem is duplicated when only ->base, ->size and ->name
are used?  And even those I'm not sure about really needing them...

> +		of_node_put(rmem_np);
> +	}
> +
> +	r5_core->res_mem_count = res_mem_count;
> +
> +	return 0;
> +}
> +
> +static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster)
> +{
> +	int ret, i;
> +	struct zynqmp_r5_core *r5_core;
> +	struct device *dev = cluster->dev;
> +
> +	ret = zynqmp_r5_get_tcm_node(cluster);
> +	if (ret < 0) {
> +		dev_err(dev, "can't get tcm node, err %d\n", ret);
> +		return ret;
> +	}
> +
> +	for (i = 0; i < cluster->core_count; i++) {
> +		r5_core = &cluster->r5_cores[i];
> +		if (!r5_core) {
> +			pr_err("invalid r5 core\n");
> +			return -EINVAL;
> +		}

Same here - please remove.

> +
> +		ret = zynqmp_r5_get_mem_region_node(r5_core);
> +		if (ret)
> +			dev_warn(dev, "memory-region prop failed %d\n", ret);
> +
> +		ret = of_property_read_u32_index(r5_core->np, "power-domains",
> +						 1, &r5_core->pm_domain_id);
> +		if (ret) {
> +			dev_err(dev, "failed to get power-domains property\n");
> +			return ret;
> +		}
> +
> +		ret = zynqmp_r5_set_mode(r5_core, cluster->mode);
> +		if (ret)
> +			return ret;
> +
> +		ret = zynqmp_r5_add_rproc_core(r5_core);
> +		if (ret) {
> +			dev_err(dev, "failed to init r5 core %d\n", i);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int zynqmp_r5_cluster_init(struct zynqmp_r5_cluster *cluster)
> +{
> +	struct device *dev = cluster->dev;
> +	struct device_node *dev_node = dev_of_node(dev);
> +	struct device_node *child;
> +	struct platform_device *child_pdev;
> +	int core_count = 0, ret, i;
> +	enum zynqmp_r5_cluster_mode cluster_mode = LOCKSTEP_MODE;
> +	struct zynqmp_r5_core *r5_cores;
> +
> +	ret = of_property_read_u32(dev_node, "xlnx,cluster-mode", &cluster_mode);
> +
> +	/* on success returns 0, if not defined then returns -EINVAL,
> +	 * In that case, default is LOCKSTEP mode
> +	 */
> +	if (ret != -EINVAL && ret != 0) {
> +		dev_err(dev, "Invalid xlnx,cluster-mode property\n");
> +		return -EINVAL;
> +	}
> +
> +	if (cluster_mode == SINGLE_CPU_MODE) {
> +		dev_err(dev, "driver does not support single cpu mode\n");
> +		return -EINVAL;
> +	} else if ((cluster_mode != SPLIT_MODE &&
> +		   cluster_mode != LOCKSTEP_MODE)) {
> +		dev_err(dev, "Invalid cluster mode\n");
> +		return -EINVAL;
> +	}
> +
> +	core_count = of_get_available_child_count(dev_node);
> +	if (core_count <= 0) {
> +		dev_err(dev, "Invalid number of r5 cores %d", core_count);
> +		return -EINVAL;
> +	} else if (cluster_mode == SPLIT_MODE && core_count != 2) {
> +		dev_err(dev, "Invalid number of r5 cores for split mode\n");
> +		return -EINVAL;
> +	} else if (cluster_mode == LOCKSTEP_MODE && core_count == 2) {
> +		dev_warn(dev, "Only r5 core0 will be used\n");
> +		core_count = 1;
> +	}
> +
> +	r5_cores = devm_kzalloc(dev, sizeof(struct zynqmp_r5_core) *
> +						 core_count, GFP_KERNEL);
> +	if (IS_ERR_OR_NULL(r5_cores)) {
> +		dev_err(dev, "can't allocate memory for cores\n");
> +		return -ENOMEM;
> +	}
> +
> +	i = 0;
> +	for_each_available_child_of_node(dev_node, child) {
> +		child_pdev = of_find_device_by_node(child);
> +		if (!child_pdev)
> +			return -ENODEV;
> +
> +		r5_cores[i].dev = &child_pdev->dev;
> +		if (!r5_cores[i].dev) {
> +			pr_err("can't get device for r5 core %d\n", i);
> +			return -ENODEV;
> +		}
> +
> +		r5_cores[i].np = dev_of_node(r5_cores[i].dev);
> +		if (!r5_cores[i].np) {
> +			pr_err("can't get device node for r5 core %d\n", i);
> +			return -ENODEV;
> +		}

The error path for both if() conditions above needs to release the
child_pdev->dev, as instructed by the documentation for
of_find_device_by_node().  The same needs to be done when there is no errors.

More comments to come tomorrow.

Thanks,
Mathieu

> +
> +		i++;
> +		if (i == core_count)
> +			break;
> +	}
> +
> +	cluster->mode = cluster_mode;
> +	cluster->core_count = core_count;
> +	cluster->r5_cores = r5_cores;
> +
> +	ret = zynqmp_r5_core_init(cluster);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to init r5 core err %d\n", ret);
> +		return ret;
> +	}
> +
> +	zynqmp_r5_print_dt_node_info(cluster);
> +
> +	return 0;
> +}
> +
> +static void zynqmp_r5_cluster_exit(void *data)
> +{
> +	struct platform_device *pdev = (struct platform_device *)data;
> +
> +	platform_set_drvdata(pdev, NULL);
> +
> +	pr_info("Exit r5f subsystem driver\n");
> +}
> +
> +/*
> + * zynqmp_r5_remoteproc_probe()
> + *
> + * @pdev: domain platform device for R5 cluster
> + *
> + * called when driver is probed, for each R5 core specified in DT,
> + * setup as needed to do remoteproc-related operations
> + *
> + * Return: 0 for success, negative value for failure.
> + */
> +static int zynqmp_r5_remoteproc_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct zynqmp_r5_cluster *cluster;
> +	struct device *dev = &pdev->dev;
> +
> +	cluster = devm_kzalloc(dev, sizeof(*cluster), GFP_KERNEL);
> +	if (IS_ERR_OR_NULL(cluster))
> +		return -ENOMEM;
> +
> +	cluster->dev = dev;
> +
> +	ret = devm_of_platform_populate(dev);
> +	if (ret) {
> +		dev_err(dev, "failed to populate platform dev %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* wire in so each core can be cleaned up at driver remove */
> +	platform_set_drvdata(pdev, cluster);
> +
> +	ret = devm_add_action_or_reset(dev, zynqmp_r5_cluster_exit, pdev);
> +	if (ret)
> +		return ret;
> +
> +	ret = zynqmp_r5_cluster_init(cluster);
> +	if (ret) {
> +		dev_err(dev, "Invalid r5f subsystem device tree\n");
> +		return ret;
> +	}
> +
> +	dev_info(dev, "Xilinx r5f remoteproc driver probe success\n");
> +	return 0;
> +}
> +
> +/* Match table for OF platform binding */
> +static const struct of_device_id zynqmp_r5_remoteproc_match[] = {
> +	{ .compatible = "xlnx,zynqmp-r5fss", },
> +	{ /* end of list */ },
> +};
> +MODULE_DEVICE_TABLE(of, zynqmp_r5_remoteproc_match);
> +
> +static struct platform_driver zynqmp_r5_remoteproc_driver = {
> +	.probe = zynqmp_r5_remoteproc_probe,
> +	.driver = {
> +		.name = "zynqmp_r5_remoteproc",
> +		.of_match_table = zynqmp_r5_remoteproc_match,
> +	},
> +};
> +module_platform_driver(zynqmp_r5_remoteproc_driver);
> +
> +MODULE_DESCRIPTION("Xilinx R5F remote processor driver");
> +MODULE_AUTHOR("Xilinx Inc.");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.25.1
> 
