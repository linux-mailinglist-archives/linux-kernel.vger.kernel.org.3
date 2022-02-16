Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760ED4B902B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 19:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237634AbiBPS1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 13:27:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbiBPS1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 13:27:02 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1322A27B21
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 10:26:47 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id c14so3510537qvl.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 10:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UlEhhnOOImzfxxcMjXhjioCkes7EGcgon316PcY1vuY=;
        b=AHFTSXfNu2rgGDITFVDQMtSArq74OXm6GwY+tDo/JhaBiYWHbCX9F7SbmZz7bx/5Ga
         n+JIEpPtTrsGtPhhscLhKvR/k2Xe4rrAfKMyoEJQDEtkX52bssU7k11gAonklFOLZdzn
         aojBHFwXReNvG7/liWmGK9+PBHqAPwzVplMaco4xeLLjnSRv4tYCqZRDwfeX/KN1z+FG
         lT8EAG6B9DiagJ8uNldWEJP7xnhanjPuR10ySLC0rckuzZuqbtW+HQMYlAjXY80sjkcj
         hkdvizr4XaG+hzjhemfJhs+J7n9rnP4joaCWLnTsuuHiP2DKWHTJ/h+0lYCApxElyS20
         Q/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UlEhhnOOImzfxxcMjXhjioCkes7EGcgon316PcY1vuY=;
        b=mUdSYhSdkUanzp/NA6OddukSXlEF8oVPnkVA+BwRFh/NNZhn0EFMPwxtxgm0cyMh8t
         XnNu7okpz6+lUf76dkmRR0jQZzOAokg7AGycK37FrnO1rPSIxURnowepjQ+jlwbvHR/j
         i4He4xYj7Pu0/ys0JRJvsqyYB05u/5kPpA/aSDJGkXf+YwH9qCMygOADh9uacppL6+6J
         9QC49HoExTviviOPFsepIRafwhDQ6W89LSB+Kic3u7sjXlKrmAf/xuk5yw9+Fxvmhch6
         jMDPy8zwv2X0lzyntIlQQXWhhncabI0IHedCD2t8JAkAuiJeVBFPtB6ELKYQLOlypeV3
         319w==
X-Gm-Message-State: AOAM533EAn+DPelOxC0DiONeZVUIyT9TWmyVaVZQv5nJoVnWDwDOoULV
        tx/4SwfMn/VBYv/wWQdvaiMhXtkUbDZZHw==
X-Google-Smtp-Source: ABdhPJzXQLeIvzKz4scosvgNYhw4F1cISpj4S/GzQ24S3e3LSFL4G3LNAOFpEu/YAAn6HeYuSd35Dg==
X-Received: by 2002:a17:902:8a8a:b0:14d:bd69:e797 with SMTP id p10-20020a1709028a8a00b0014dbd69e797mr3742636plo.49.1645035995005;
        Wed, 16 Feb 2022 10:26:35 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e16sm37805pfd.214.2022.02.16.10.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 10:26:33 -0800 (PST)
Date:   Wed, 16 Feb 2022 11:26:31 -0700
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
Message-ID: <20220216182631.GA347485@p14s>
References: <20220210112824.2084724-1-tanmay.shah@xilinx.com>
 <20220210112824.2084724-7-tanmay.shah@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210112824.2084724-7-tanmay.shah@xilinx.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 03:28:24AM -0800, Tanmay Shah wrote:
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
> 
> Changes in v3:
>   - Fix checkpatch script indentation warning
>   - Remove unused variable from xilinx remoteproc driver
>   - use C style comments, i.e /*...*/
>   - Remove redundant debug information which can be derived using /proc/device-tree
>   - Fix multilined comment format
>   - s/"final fot TCM"/"final for TCM"
>   - Function devm_kzalloc() does not return an code on error, just NULL.
>     Remove redundant error check for this function throughout the driver.
>   - Fix RPU mode configuration and add documentation accordingly
>   - Get rid of the indentations to match function documentation style with rest of the driver
>   - Fix memory leak by only using r5_rproc->priv and not replace it with new instance
>   - Use 'i' for the outer loop and 'j' for the inner one as per convention
>   - Remove redundant error and NULL checks throughout the driver
>   - Use devm_kcalloc() when more than one element is required
>   - Add memory-regions carveouts during driver probe instead of parse_fw call
>     This removes redundant copy of reserved_mem object in r5_core structure.
>   - Fix memory leak by using of_node_put()
>   - Fix indentation of tcm_mem_map function args
>   - Remove redundant init of variables
>   - Initialize tcm bank size variable for lockstep mode
>   - Replace u32 with phys_addr_t for variable stroing memory bank address
>   - Add documentation of TCM behavior in lockstep mode
>   - Use dev_get_drvdata instead of platform driver API
>   - Remove info level messages
>   - Fix checkpatch.pl warnings
>   - Add documentation for the Xilinx r5f platform to understand driver design 
> 
>  drivers/remoteproc/Kconfig              |  12 +
>  drivers/remoteproc/Makefile             |   1 +
>  drivers/remoteproc/xlnx_r5_remoteproc.c | 973 ++++++++++++++++++++++++
>  3 files changed, 986 insertions(+)
>  create mode 100644 drivers/remoteproc/xlnx_r5_remoteproc.c
> 
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index 166019786653..5637a71c0677 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -352,6 +352,18 @@ config TI_K3_R5_REMOTEPROC
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
> index 5478c7cb9e07..91314a9b43ce 100644
> --- a/drivers/remoteproc/Makefile
> +++ b/drivers/remoteproc/Makefile
> @@ -38,3 +38,4 @@ obj-$(CONFIG_ST_SLIM_REMOTEPROC)	+= st_slim_rproc.o
>  obj-$(CONFIG_STM32_RPROC)		+= stm32_rproc.o
>  obj-$(CONFIG_TI_K3_DSP_REMOTEPROC)	+= ti_k3_dsp_remoteproc.o
>  obj-$(CONFIG_TI_K3_R5_REMOTEPROC)	+= ti_k3_r5_remoteproc.o
> +obj-$(CONFIG_XLNX_R5_REMOTEPROC)	+= xlnx_r5_remoteproc.o
> diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
> new file mode 100644
> index 000000000000..ce2ac364b995
> --- /dev/null
> +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
> @@ -0,0 +1,973 @@
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
> +	SPLIT_MODE = 0, /* When cores run as separate processor */
> +	LOCKSTEP_MODE = 1, /* cores execute same code in lockstep,clk-for-clk */
> +	SINGLE_CPU_MODE = 2, /* core0 is held in reset and only core1 runs */
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
> +	u32 pm_domain_id;
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
> + * @rproc: rproc handle
> + * @pm_domain_id: RPU CPU power domain id
> + */
> +struct zynqmp_r5_core {
> +	struct device *dev;
> +	struct device_node *np;
> +	int tcm_bank_count;
> +	struct mem_bank_data *tcm_banks;
> +	struct rproc *rproc;
> +	u32 pm_domain_id;
> +};
> +
> +/**
> + * struct zynqmp_r5_cluster - ZynqMP R5 cluster structure
> + *
> + * @dev: r5f subsystem cluster device node
> + * @mode: cluster mode of type zynqmp_r5_cluster_mode
> + * @core_count: number of r5 cores used for this cluster mode
> + * @r5_cores: Array of pointers pointing to r5 core
> + */
> +struct zynqmp_r5_cluster {
> +	struct device *dev;
> +	enum  zynqmp_r5_cluster_mode mode;
> +	int core_count;
> +	struct zynqmp_r5_core **r5_cores;
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
> +	/*
> +	 * SINGLE CPU mode is not supported in driver yet.
> +	 * For now we only set lockstep mode or split mode.
> +	 */
> +	if (rpu_mode == LOCKSTEP_MODE) {
> +		reg_val = 0;
> +	} else if (rpu_mode == SPLIT_MODE) {
> +		reg_val = 1;
> +	} else if (rpu_mode == SINGLE_CPU_MODE) {
> +		pr_err("RPU single cpu mode is not supported\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = zynqmp_pm_set_rpu_mode(r5_core->pm_domain_id, reg_val);
> +	if (ret < 0) {
> +		pr_err("failed to set RPU mode\n");
> +		return ret;
> +	}
> +
> +	/*
> +	 * At this point RPU is assumed to be configured only in
> +	 * lockstep mode or split mode. Configure TCM accordingly.
> +	 */
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
> +	/*
> +	 * The exception vector pointers (EVP) refer to the base-address of
> +	 * exception vectors (for reset, IRQ, FIQ, etc). The reset-vector
> +	 * starts at the base-address and subsequent vectors are on 4-byte
> +	 * boundaries.
> +	 *
> +	 * Exception vectors can start either from 0x0000_0000 (LOVEC) or
> +	 * from 0xFFFF_0000 (HIVEC) which is mapped in the OCM (On-Chip Memory)
> +	 *
> +	 * Usually firmware will put Exception vectors at LOVEC.
> +	 *
> +	 * It is not recommend that you change the exception vector.
> +	 * Changing the EVP to HIVEC will result in increased interrupt latency
> +	 * and jitter. Also, if the OCM is secured and the Cortex-R5F processor
> +	 * is non-secured, then the Cortex-R5F processor cannot access the
> +	 * HIVEC exception vectors in the OCM.
> +	 */
> +	bootmem = (rproc->bootaddr >= 0xFFFC0000) ?
> +		   PM_RPU_BOOTMEM_HIVEC : PM_RPU_BOOTMEM_LOVEC;
> +
> +	dev_dbg(r5_core->dev, "RPU boot addr 0x%llx from %s.", rproc->bootaddr,
> +		bootmem == PM_RPU_BOOTMEM_HIVEC ? "OCM" : "TCM");
> +
> +	ret = zynqmp_pm_request_wake(r5_core->pm_domain_id, 1,
> +				     bootmem, ZYNQMP_PM_REQUEST_ACK_NO);
> +	if (ret)
> +		pr_err("failed to start RPU = 0x%x\n", r5_core->pm_domain_id);
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
> + * @r5_core: single R5 core's corresponding zynqmp_r5_core type instance
> + * @rmem: reserved mem region parsed from dt node
> + *
> + * Construct rproc mem carveouts from carveout provided in
> + * memory-region property
> + *
> + * return 0 on success, otherwise non-zero value on failure
> + */
> +static int add_mem_regions_carveout(struct zynqmp_r5_core *r5_core,
> +				    struct reserved_mem *rmem)
> +{
> +	struct device *dev;
> +	struct rproc_mem_entry *mem;
> +	struct rproc *rproc;
> +
> +	rproc = r5_core->rproc;
> +	dev = r5_core->dev;
> +
> +	/* Register associated reserved memory regions */
> +	mem = rproc_mem_entry_init(dev, NULL,
> +				   (dma_addr_t)rmem->base,
> +				   rmem->size, rmem->base,
> +				   zynqmp_r5_rproc_mem_map,
> +				   zynqmp_r5_rproc_mem_unmap,
> +				   rmem->name);
> +	if (!mem)
> +		return -ENOMEM;
> +
> +	rproc_add_carveout(rproc, mem);
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
> +	u32 pm_domain_id;
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
> +			pr_warn("can't turn off TCM bank 0x%x", pm_domain_id);
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
> +		       struct rproc_mem_entry *mem)
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
> +	u32 pm_domain_id;
> +	phys_addr_t bank_addr;
> +	size_t bank_size;
> +	char *bank_name;
> +	struct device *dev;
> +	struct zynqmp_r5_core *r5_core;
> +
> +	r5_core = (struct zynqmp_r5_core *)rproc->priv;
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
> +	/*
> +	 * Power-on Each 64KB TCM,
> +	 * register its address space, map and unmap functions
> +	 * and add carveouts accordingly
> +	 */
> +	for (i = 0; i < num_banks; i++) {
> +		bank_addr = r5_core->tcm_banks[i].addr;
> +		bank_name = r5_core->tcm_banks[i].bank_name;
> +		bank_size = r5_core->tcm_banks[i].size;
> +		pm_domain_id = r5_core->tcm_banks[i].pm_domain_id;
> +
> +		ret = zynqmp_pm_request_node(pm_domain_id,
> +					     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
> +					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> +		if (ret < 0) {
> +			dev_err(dev, "failed to turn on TCM 0x%x", pm_domain_id);
> +			return ret;
> +		}
> +
> +		dev_dbg(dev, "TCM carveout split mode %s addr=%llx, size=0x%lx",
> +			bank_name, bank_addr, bank_size);
> +
> +		mem = rproc_mem_entry_init(dev, NULL, bank_addr,
> +					   bank_size, bank_addr,
> +					   tcm_mem_map, tcm_mem_unmap,
> +					   bank_name);
> +		if (!mem) {
> +			/* If failed, Turn off all TCM banks turned on before */
> +			do {
> +				pm_domain_id = r5_core->tcm_banks[i].pm_domain_id;
> +				ret = zynqmp_pm_release_node(pm_domain_id);
> +				if (ret)
> +					dev_warn(dev,
> +						 "fail to release node: 0x%x, %x\n",
> +						 pm_domain_id, ret);
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
> +	u32 pm_domain_id;
> +	phys_addr_t bank_addr;
> +	size_t bank_size = 0;
> +	char *bank_name;
> +	struct device *dev;
> +	struct zynqmp_r5_core *r5_core;
> +
> +	r5_core = (struct zynqmp_r5_core *)rproc->priv;
> +	dev = r5_core->dev;
> +
> +	/* Go through zynqmp banks for r5 node */
> +	num_banks = r5_core->tcm_bank_count;
> +	if (num_banks <= 0) {
> +		dev_err(dev, "need to specify TCM banks\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * In lockstep mode, TCM is contiguous memory block
> +	 * However, each TCM block still needs to be enabled individually.
> +	 * So, Enable each TCM block individually, but add their size
> +	 * to create contiguous memory region.
> +	 */
> +	bank_addr = r5_core->tcm_banks[0].addr;
> +	bank_name = r5_core->tcm_banks[0].bank_name;
> +
> +	for (i = 0; i < num_banks; i++) {
> +		bank_size += r5_core->tcm_banks[i].size;
> +		pm_domain_id = r5_core->tcm_banks[i].pm_domain_id;
> +
> +		/* Turn on each TCM bank individually */
> +		ret = zynqmp_pm_request_node(pm_domain_id,
> +					     ZYNQMP_PM_CAPABILITY_ACCESS, 0,
> +					     ZYNQMP_PM_REQUEST_ACK_BLOCKING);
> +		if (ret < 0) {
> +			dev_err(dev, "failed to turn on TCM 0x%x", pm_domain_id);
> +			return ret;
> +		}
> +	}
> +
> +	dev_dbg(dev, "TCM add carveout lockstep mode %s addr=0x%llx, size=0x%lx",
> +		bank_name, bank_addr, bank_size);
> +
> +	/* Register TCM address range, TCM map and unmap functions */
> +	mem = rproc_mem_entry_init(dev, NULL, bank_addr,
> +				   bank_size, bank_addr,
> +				   tcm_mem_map, tcm_mem_unmap,
> +				   bank_name);
> +	if (!mem) {
> +		/* In case of error, turn off TCM banks */
> +		for (i = 0; i < num_banks; i++) {
> +			pm_domain_id = r5_core->tcm_banks[i].pm_domain_id;
> +			ret = zynqmp_pm_release_node(pm_domain_id);
> +			if (ret)
> +				dev_warn(dev,
> +					 "fail to release node: 0x%x ret: %x\n",
> +					 pm_domain_id, ret);
> +		}
> +		return -ENOMEM;
> +	}
> +
> +	/* If registration is success, add carveouts */
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
> +
> +	cluster = dev_get_drvdata(dev->parent);
> +	if (!cluster) {
> +		dev_err(&parent_pdev->dev, "Invalid driver data\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * In lockstep mode TCM banks are one contiguous memory region of 256Kb
> +	 * In split mode, each TCM bank is 64Kb and not contiguous.
> +	 * We add memory carveouts accordingly.
> +	 */
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
> +
> +	dev = r5_core->dev;
> +
> +	ret = add_tcm_banks(rproc);
> +	if (ret) {
> +		dev_err(dev, "failed to get TCM banks, err %d\n", ret);
> +		return ret;
> +	}
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
> +/**
> + * zynqmp_r5_add_rproc_core()
> + * Probes ZynqMP R5 processor device node
> + * this is called for each individual R5 core
> + *
> + * @cdev: Device node of each r5 core
> + *
> + * Return: zynqmp_r5_core object for success, error pointer in case of error.
> + */
> +static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
> +{
> +	int ret;
> +	struct rproc *r5_rproc;
> +	struct zynqmp_r5_core *r5_core;
> +
> +	/* Set up DMA mask */
> +	ret = dma_set_coherent_mask(cdev, DMA_BIT_MASK(32));
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	/* Allocate remoteproc instance */
> +	r5_rproc = devm_rproc_alloc(cdev, dev_name(cdev),
> +				    &zynqmp_r5_rproc_ops,
> +				    NULL, sizeof(struct zynqmp_r5_core));
> +	if (!r5_rproc) {
> +		dev_err(cdev, "failed to allocate memory for rproc instance\n");
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	r5_rproc->auto_boot = false;
> +	r5_core = (struct zynqmp_r5_core *)r5_rproc->priv;
> +	r5_core->dev = cdev;
> +
> +	/* Add R5 remoteproc core */
> +	ret = devm_rproc_add(cdev, r5_rproc);
> +	if (ret) {
> +		dev_err(cdev, "failed to add r5 remoteproc\n");
> +		return ERR_PTR(ret);
> +	}
> +
> +	r5_core->rproc = r5_rproc;
> +	return r5_core;
> +}
> +
> +/**
> + * zynqmp_r5_get_tcm_node()
> + * Ideally this function should parse tcm node and store information
> + * in r5_core instance. We will use hardcoded TCM information from
> + * driver for now in this function.
> + *
> + * @cluster: pointer to zynqmp_r5_cluster type object
> + *
> + * Return: 0 for success and error code for failure.
> + */
> +static int zynqmp_r5_get_tcm_node(struct zynqmp_r5_cluster *cluster)
> +{
> +	int tcm_bank_count, tcm_node;
> +	int i = 0, j;
> +	struct zynqmp_r5_core *r5_core;
> +	const struct mem_bank_data *tcm = zynqmp_tcm_banks;
> +	struct device *dev = cluster->dev;
> +
> +	/*
> +	 * ToDo: Use predefined TCM address space values from driver until
> +	 * system-dt spec is not final for TCM
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
> +	for (i = 0; i < cluster->core_count; i++) {
> +		r5_core = cluster->r5_cores[i];
> +		r5_core->tcm_banks = devm_kcalloc(dev, tcm_bank_count,
> +						  sizeof(struct mem_bank_data),
> +						  GFP_KERNEL);
> +		if (!r5_core->tcm_banks)
> +			return -ENOMEM;
> +
> +		for (j = 0; j < tcm_bank_count; j++) {
> +			/* Use pre-defined TCM reg values.
> +			 * Eventually this should be replaced by values
> +			 * parsed from dts.
> +			 */
> +			r5_core->tcm_banks[j].addr = tcm[tcm_node].addr;
> +			r5_core->tcm_banks[j].size = tcm[tcm_node].size;
> +			r5_core->tcm_banks[j].pm_domain_id = tcm[tcm_node].pm_domain_id;
> +			r5_core->tcm_banks[j].bank_name = tcm[tcm_node].bank_name;
> +			tcm_node++;
> +		}
> +
> +		r5_core->tcm_bank_count = tcm_bank_count;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * zynqmp_r5_get_mem_region_node()
> + * parse memory-region property from dt node and add
> + * memory region carveouts
> + *
> + * @r5_core: pointer to zynqmp_r5_core type object
> + *
> + * Return: 0 for success and error code for failure.
> + */
> +static int zynqmp_r5_get_mem_region_node(struct zynqmp_r5_core *r5_core)
> +{
> +	int res_mem_count, i, ret;
> +	struct device *dev;
> +	struct device_node *np, *rmem_np;
> +	struct reserved_mem *rmem;
> +
> +	dev = r5_core->dev;
> +
> +	np = r5_core->np;
> +
> +	res_mem_count = of_property_count_elems_of_size(np, "memory-region",
> +							sizeof(phandle));
> +	if (res_mem_count <= 0) {
> +		dev_warn(dev, "failed to get memory-region property %d\n",
> +			 res_mem_count);
> +		return -EINVAL;
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
> +		ret = add_mem_regions_carveout(r5_core, rmem);
> +		if (ret)
> +			dev_warn(dev, "failed to get reserve mem regions %d\n",
> +				 ret);
> +
> +		of_node_put(rmem_np);
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * zynqmp_r5_core_init()
> + * Create and initialize zynqmp_r5_core type object
> + *
> + * @cluster: pointer to zynqmp_r5_cluster type object
> + *
> + * Return: 0 for success and error code for failure.
> + */
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
> +		r5_core = cluster->r5_cores[i];
> +
> +		ret = zynqmp_r5_get_mem_region_node(r5_core);
> +		if (ret)
> +			dev_warn(dev, "memory-region prop failed %d\n", ret);
> +
> +		/* Initialize r5 cores with power-domains parsed from dts */
> +		ret = of_property_read_u32_index(r5_core->np, "power-domains",
> +						 1, &r5_core->pm_domain_id);
> +		if (ret) {
> +			dev_err(dev, "failed to get power-domains property\n");
> +			return ret;
> +		}
> +
> +		ret = zynqmp_r5_set_mode(r5_core, cluster->mode);
> +		if (ret) {
> +			dev_err(dev, "failed to set r5 cluster mode %d, err %d\n",
> +				cluster->mode, ret);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * zynqmp_r5_cluster_init()
> + * Create and initialize zynqmp_r5_cluster type object
> + *
> + * @cluster: pointer to zynqmp_r5_cluster type object
> + *
> + * Return: 0 for success and error code for failure.
> + */
> +static int zynqmp_r5_cluster_init(struct zynqmp_r5_cluster *cluster)
> +{
> +	struct device *dev = cluster->dev;
> +	struct device_node *dev_node = dev_of_node(dev);
> +	struct device_node *child;
> +	struct platform_device *child_pdev;
> +	int core_count = 0, ret, i;
> +	enum zynqmp_r5_cluster_mode cluster_mode = LOCKSTEP_MODE;
> +	struct zynqmp_r5_core **r5_cores;
> +
> +	ret = of_property_read_u32(dev_node, "xlnx,cluster-mode", &cluster_mode);
> +
> +	/*
> +	 * on success returns 0, if not defined then returns -EINVAL,
> +	 * In that case, default is LOCKSTEP mode
> +	 */
> +	if (ret != -EINVAL && ret != 0) {
> +		dev_err(dev, "Invalid xlnx,cluster-mode property\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * For now driver only supports split mode and lockstep mode.
> +	 * fail driver probe if either of that is not set in dts
> +	 */
> +	if (cluster_mode == SINGLE_CPU_MODE) {
> +		dev_err(dev, "driver does not support single cpu mode\n");
> +		return -EINVAL;
> +	} else if ((cluster_mode != SPLIT_MODE &&
> +		   cluster_mode != LOCKSTEP_MODE)) {
> +		dev_err(dev, "Invalid cluster mode\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Number of cores is decided by number of child nodes of
> +	 * r5f subsystem node in dts. If Split mode is used in dts
> +	 * 2 child nodes are expected.
> +	 * In lockstep mode if two child nodes are available,
> +	 * only use first child node and consider it as core0
> +	 * and ignore core1 dt node.
> +	 */
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
> +	r5_cores = devm_kcalloc(dev, core_count,
> +				sizeof(struct zynqmp_r5_core *), GFP_KERNEL);
> +	if (!r5_cores)
> +		return -ENOMEM;
> +
> +	i = 0;
> +	for_each_available_child_of_node(dev_node, child) {
> +		child_pdev = of_find_device_by_node(child);
> +		if (!child_pdev) {
> +			of_node_put(child);
> +			return -ENODEV;
> +		}
> +
> +		/* create and add remoteproc instance of type struct rproc */
> +		r5_cores[i] = zynqmp_r5_add_rproc_core(&child_pdev->dev);

Function zynqmp_r5_add_rproc_core() returns an error code on error that is never
checked.

> +		r5_cores[i]->dev = &child_pdev->dev;

This will result in a kernel stack trace if zynqmp_r5_add_rproc_core() fails.

> +		if (!r5_cores[i]->dev) {
> +			dev_err(dev, "can't get device for r5 core %d\n", i);
> +			of_node_put(child);
> +			return -ENODEV;
> +		}

And here the validity of child_pdev->dev is checked _after_ it has been passed
to zynqmp_r5_add_rproc_core().  This check should not be needed if proper
error handling is done above. 

> +
> +		r5_cores[i]->np = dev_of_node(r5_cores[i]->dev);
> +		if (!r5_cores[i]->np) {
> +			dev_err(dev, "can't get device node for r5 core %d\n", i);
> +			of_node_put(child);

As mention in the documentation for of_find_device_by_node(), the function takes
a reference to child_pdev->dev that needs to be released with put_device().  In
fact I don't see the reference dropped anywhere, even when the driver is
released.

Moreover, if we end up here for r5_cores[1], resources acquired for r5_core[0]
are not released. 

> +			return -ENODEV;
> +		}
> +
> +		i++;
> +
> +		/*
> +		 * If two child nodes are available in dts in lockstep mode,
> +		 * then ignore second child node.
> +		 */
> +		if (i == core_count) {
> +			of_node_put(child);
> +			break;
> +		}
> +		of_node_put(child);

This one is not needed as it is already done by the
for_each_available_child_of_node() loop.

More comments tomorrow.

Thanks,
Mathieu

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
> +	if (!cluster)
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
