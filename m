Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0DF590B84
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 07:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236919AbiHLFdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 01:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234432AbiHLFdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 01:33:05 -0400
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E3DA0275
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 22:33:01 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id MNHyo5KHrKOP1MNHzoioqr; Fri, 12 Aug 2022 07:32:59 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 12 Aug 2022 07:32:59 +0200
X-ME-IP: 90.11.190.129
Message-ID: <080f3e2b-af7b-0ac0-1716-a33da73290e4@wanadoo.fr>
Date:   Fri, 12 Aug 2022 07:32:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 7/8] remoteproc: qcom: Add support for memory sandbox
Content-Language: fr
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        linux-remoteproc@vger.kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, quic_plai@quicinc.com,
        bgoswami@quicinc.com, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, quic_rohkumar@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        devicetree@vger.kernel.org
References: <1660117558-21829-1-git-send-email-quic_srivasam@quicinc.com>
 <1660117558-21829-8-git-send-email-quic_srivasam@quicinc.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <1660117558-21829-8-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 10/08/2022 à 09:45, Srinivasa Rao Mandadapu a écrit :
> Update pil driver with SMMU mapping for allowing authorised
> memory access to ADSP firmware, by reading required memory
> regions either from device tree file or from resource table
> embedded in ADSP binary header.
> 

Hi,

comments below about error handling paths that look incomplete to me.

Just my 2c.

> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> ---
> Changes since V2:
> 	-- Replace platform_bus_type with adsp->dev->bus.
> 	-- Use API of_parse_phandle_with_args() instead of of_parse_phandle_with_fixed_args().
> 	-- Replace adsp->is_wpss with adsp->is_adsp.
> 	-- Update error handling in adsp_start().
> 
>   drivers/remoteproc/qcom_q6v5_adsp.c | 107 +++++++++++++++++++++++++++++++++++-
>   1 file changed, 105 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
> index f2945bf..b9cafe2 100644
> --- a/drivers/remoteproc/qcom_q6v5_adsp.c
> +++ b/drivers/remoteproc/qcom_q6v5_adsp.c
> @@ -9,6 +9,7 @@
>   #include <linux/firmware.h>
>   #include <linux/interrupt.h>
>   #include <linux/io.h>
> +#include <linux/iommu.h>
>   #include <linux/iopoll.h>
>   #include <linux/kernel.h>
>   #include <linux/mfd/syscon.h>
> @@ -48,6 +49,8 @@
>   #define LPASS_PWR_ON_REG		0x10
>   #define LPASS_HALTREQ_REG		0x0
>   
> +#define SID_MASK_DEFAULT        0xF
> +
>   #define QDSP6SS_XO_CBCR		0x38
>   #define QDSP6SS_CORE_CBCR	0x20
>   #define QDSP6SS_SLEEP_CBCR	0x3c
> @@ -78,7 +81,7 @@ struct adsp_pil_data {
>   struct qcom_adsp {
>   	struct device *dev;
>   	struct rproc *rproc;
> -
> +	struct iommu_domain *iommu_dom;
>   	struct qcom_q6v5 q6v5;
>   
>   	struct clk *xo;
> @@ -333,6 +336,94 @@ static int adsp_load(struct rproc *rproc, const struct firmware *fw)
>   	return 0;
>   }
>   
> +static int adsp_map_smmu(struct qcom_adsp *adsp, struct rproc *rproc)
> +{
> +	struct of_phandle_args args;
> +	struct fw_rsc_devmem *rsc_fw;
> +	struct fw_rsc_hdr *hdr;
> +	const __be32 *prop;
> +	long long sid;
> +	unsigned long mem_phys;
> +	unsigned long iova;
> +	unsigned int mem_size;
> +	unsigned int flag;
> +	unsigned int len;
> +	int access_level;
> +	int offset;
> +	int ret;
> +	int rc;
> +	int i;
> +
> +	rc = of_parse_phandle_with_args(adsp->dev->of_node, "iommus", "#iommu-cells", 0, &args);
> +	if (rc < 0)
> +		sid = -1;
> +	else
> +		sid = args.args[0] & SID_MASK_DEFAULT;
> +
> +	adsp->iommu_dom = iommu_domain_alloc(adsp->dev->bus);
> +	if (!adsp->iommu_dom) {
> +		dev_err(adsp->dev, "failed to allocate iommu domain\n");
> +		return -ENOMEM;
> +	}
> +
> +	ret = iommu_attach_device(adsp->iommu_dom, adsp->dev);
> +	if (ret) {
> +		dev_err(adsp->dev, "could not attach device ret = %d\n", ret);

iommu_domain_free() or error handling path (see below)?

> +		return -EBUSY;
> +	}
> +
> +	/* Add SID configuration for ADSP Firmware to SMMU */
> +	adsp->mem_phys =  adsp->mem_phys | (sid << 32);
> +
> +	ret = iommu_map(adsp->iommu_dom, adsp->mem_phys, adsp->mem_phys,
> +			adsp->mem_size,	IOMMU_READ | IOMMU_WRITE);
> +	if (ret) {
> +		dev_err(adsp->dev, "Unable to map ADSP Physical Memory\n");

iommu_domain_free() or error handling path (see below)?

> +		return ret;
> +	}
> +
> +	prop = of_get_property(adsp->dev->of_node, "qcom,adsp-memory-regions", &len);
> +	if (prop) {
> +		len /= sizeof(__be32);
> +		for (i = 0; i < len; i++) {
> +			iova = be32_to_cpu(prop[i++]);
> +			mem_phys = be32_to_cpu(prop[i++]);
> +			mem_size = be32_to_cpu(prop[i++]);
> +			access_level = be32_to_cpu(prop[i]);
> +
> +			if (access_level)
> +				flag = IOMMU_READ | IOMMU_WRITE;
> +			else
> +				flag = IOMMU_READ;
> +
> +			ret = iommu_map(adsp->iommu_dom, iova, mem_phys, mem_size, flag);
> +			if (ret) {
> +				dev_err(adsp->dev, "failed to map addr = %p mem_size = %x\n",
> +						&(mem_phys), mem_size);
> +				return ret;

Should there be an error handling path to undo iommu_domain_alloc() and 
iommu_map() above.
Same for iommu_map() already done in the loop.

> +			}
> +		}
> +	} else {
> +		if (!rproc->table_ptr)
> +			return 0;
> +
> +		for (i = 0; i < rproc->table_ptr->num; i++) {
> +			offset = rproc->table_ptr->offset[i];
> +			hdr = (void *)rproc->table_ptr + offset;
> +			rsc_fw = (struct fw_rsc_devmem *)hdr + sizeof(*hdr);
> +
> +			ret = iommu_map(rproc->domain, rsc_fw->da, rsc_fw->pa,
> +						rsc_fw->len, rsc_fw->flags);
> +			if (ret) {
> +				pr_err("%s; unable to map adsp memory address\n", __func__);
> +				return ret;

Same comment.

> +			}
> +		}
> +	}
> +	return 0;
> +}
> +
> +
>   static int adsp_start(struct rproc *rproc)
>   {
>   	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
> @@ -343,9 +434,16 @@ static int adsp_start(struct rproc *rproc)
>   	if (ret)
>   		return ret;
>   
> +	if (adsp->is_adsp_sb_needed) {
> +		ret = adsp_map_smmu(adsp, rproc);
> +		if (ret) {
> +			dev_err(adsp->dev, "ADSP smmu mapping failed\n");
> +			goto disable_irqs;
> +		}
> +	}
>   	ret = clk_prepare_enable(adsp->xo);
>   	if (ret)
> -		goto disable_irqs;
> +		goto adsp_smmu_unmap;
>   
>   	ret = qcom_rproc_pds_enable(adsp, adsp->proxy_pds,
>   				    adsp->proxy_pd_count);
> @@ -401,6 +499,11 @@ static int adsp_start(struct rproc *rproc)
>   	qcom_rproc_pds_disable(adsp, adsp->proxy_pds, adsp->proxy_pd_count);
>   disable_xo_clk:
>   	clk_disable_unprepare(adsp->xo);
> +adsp_smmu_unmap:
> +	if (adsp->is_adsp_sb_needed) {
> +		iommu_unmap(adsp->iommu_dom, adsp->mem_phys, adsp->mem_size);
> +		iommu_domain_free(adsp->iommu_dom);

Hi,

Do the iommu_map() in the for loops of adsp_map_smmu() also need some 
iommu_unmap() here?

Maybe introducing a adsp_unmap_smmu() would simplify the release of 
resources.

Does the same resource release makes sense in adsp_stop() or somewhere else?

CJ


> +	}
>   disable_irqs:
>   	qcom_q6v5_unprepare(&adsp->q6v5);
>   

