Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0B45929AA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 08:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbiHOGhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 02:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiHOGhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 02:37:15 -0400
Received: from smtp.smtpout.orange.fr (smtp07.smtpout.orange.fr [80.12.242.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E48C1ADBC
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 23:37:11 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id NTilozE1IUoLVNTilo20hb; Mon, 15 Aug 2022 08:37:08 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 15 Aug 2022 08:37:08 +0200
X-ME-IP: 90.11.190.129
Message-ID: <6d551cf9-94b4-653b-122a-938ee5504150@wanadoo.fr>
Date:   Mon, 15 Aug 2022 08:37:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 6/7] remoteproc: qcom: Add support for memory sandbox
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
References: <1660308466-410-1-git-send-email-quic_srivasam@quicinc.com>
 <1660308466-410-7-git-send-email-quic_srivasam@quicinc.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     agross@kernel.org, bgoswami@quicinc.com,
        bjorn.andersson@linaro.org, broonie@kernel.org,
        devicetree@vger.kernel.org, judyhsiao@chromium.org,
        lgirdwood@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        perex@perex.cz, quic_plai@quicinc.com, quic_rohkumar@quicinc.com,
        robh+dt@kernel.org, srinivas.kandagatla@linaro.org,
        swboyd@chromium.org, tiwai@suse.com
In-Reply-To: <1660308466-410-7-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 12/08/2022 à 14:47, Srinivasa Rao Mandadapu a écrit :
> Update pil driver with SMMU mapping for allowing authorised
> memory access to ADSP firmware, by reading required memory
> regions either from device tree file or from resource table
> embedded in ADSP binary header.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org>
> ---
> Changes since V3:
> 	-- Rename is_adsp_sb_needed to adsp_sandbox_needed.
> 	-- Add smmu unmapping in error case and in adsp stop.
> Changes since V2:
> 	-- Replace platform_bus_type with adsp->dev->bus.
> 	-- Use API of_parse_phandle_with_args() instead of of_parse_phandle_with_fixed_args().
> 	-- Replace adsp->is_wpss with adsp->is_adsp.
> 	-- Update error handling in adsp_start().
> 
>   drivers/remoteproc/qcom_q6v5_adsp.c | 172 +++++++++++++++++++++++++++++++++++-
>   1 file changed, 170 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
> index b0a63a0..ca45d2c 100644
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
> @@ -333,6 +336,155 @@ static int adsp_load(struct rproc *rproc, const struct firmware *fw)
>   	return 0;
>   }
>   
> +static void adsp_of_unmap_smmu(struct iommu_domain *iommu_dom, const __be32 *prop, int len)
> +{
> +	unsigned long mem_phys;
> +	unsigned long iova;
> +	unsigned int mem_size;
> +	int access_level;
> +	int i;
> +
> +	for (i = 0; i < len; i++) {
> +		iova = be32_to_cpu(prop[i++]);
> +		mem_phys = be32_to_cpu(prop[i++]);
> +		mem_size = be32_to_cpu(prop[i++]);
> +		access_level = be32_to_cpu(prop[i]);
> +		iommu_unmap(iommu_dom, iova, mem_size);
> +	}
> +}
> +
> +static void adsp_rproc_unmap_smmu(struct rproc *rproc, int len)
> +{
> +	struct fw_rsc_devmem *rsc_fw;
> +	struct fw_rsc_hdr *hdr;
> +	int offset;
> +	int i;
> +
> +	for (i = 0; i < len; i++) {
> +		offset = rproc->table_ptr->offset[i];
> +		hdr = (void *)rproc->table_ptr + offset;
> +		rsc_fw = (struct fw_rsc_devmem *)hdr + sizeof(*hdr);
> +
> +		iommu_unmap(rproc->domain, rsc_fw->da, rsc_fw->len);
> +	}
> +}
> +
> +static void adsp_unmap_smmu(struct rproc *rproc)
> +{

When I proposed a adsp_unmap_smmu() function, the idea was to undo 
everything that is donne by adsp_map_smmu().
iommu_domain_alloc() and iommu_map(adsp->iommu_dom, ..) are not undone here.

If this make sense, it would improve the semantic, simplify the 
'adsp_smmu_unmap' label in adsp_start() and avoid what looks like a leak 
to me in adsp_stop().


> +	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
> +	const __be32 *prop;
> +	unsigned int len;
> +
> +	prop = of_get_property(adsp->dev->of_node, "qcom,adsp-memory-regions", &len);
> +	if (prop) {

In the allocation path, you have a "len /= sizeof(__be32);" which is not 
here. Is it needed?

You call adsp_unmap_smmu() from the error handling path of 
adsp_map_smmu(). If needed, maybe it should be part of adsp_of_unmap_smmu()?

> +		adsp_of_unmap_smmu(adsp->iommu_dom, prop, len);
> +	} else {
> +		if (rproc->table_ptr)
> +			adsp_rproc_unmap_smmu(rproc, rproc->table_ptr->num);
> +	}
> +}
> +
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

Are ret and rc both needed?

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
> +		ret = -ENOMEM;
> +		goto domain_free;
> +	}
> +
> +	ret = iommu_attach_device(adsp->iommu_dom, adsp->dev);
> +	if (ret) {
> +		dev_err(adsp->dev, "could not attach device ret = %d\n", ret);
> +		ret = -EBUSY;
> +		goto detach_device;
> +	}
> +
> +	/* Add SID configuration for ADSP Firmware to SMMU */
> +	adsp->mem_phys =  adsp->mem_phys | (sid << 32);
> +
> +	ret = iommu_map(adsp->iommu_dom, adsp->mem_phys, adsp->mem_phys,
> +			adsp->mem_size,	IOMMU_READ | IOMMU_WRITE);
> +	if (ret) {
> +		dev_err(adsp->dev, "Unable to map ADSP Physical Memory\n");
> +		goto sid_unmap;
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
> +				goto smmu_unmap;
> +			}
> +		}
> +	} else {
> +		if (!rproc->table_ptr)
> +			goto sid_unmap;
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
> +				goto rproc_smmu_unmap;
> +			}
> +		}
> +	}

If you introduce a adsp_of_unmap_smmu() and adsp_rproc_unmap_smmu(), 
would it make things more readable to have the same kind of functions 
when allocating the resources?

Symmetry often helps.

> +	return 0;

Add an empty new line here?

> +rproc_smmu_unmap:
> +	adsp_rproc_unmap_smmu(rproc, i);
> +	goto sid_unmap;
> +smmu_unmap:
> +	adsp_of_unmap_smmu(adsp->iommu_dom, prop, i);
> +sid_unmap:
> +	iommu_unmap(adsp->iommu_dom, adsp->mem_phys, adsp->mem_size);
> +detach_device:
> +	iommu_domain_free(adsp->iommu_dom);
> +domain_free:
> +	return ret;
> +}
> +
> +
>   static int adsp_start(struct rproc *rproc)
>   {
>   	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
> @@ -343,9 +495,16 @@ static int adsp_start(struct rproc *rproc)
>   	if (ret)
>   		return ret;
>   
> +	if (adsp->adsp_sandbox_needed) {
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
> @@ -401,6 +560,12 @@ static int adsp_start(struct rproc *rproc)
>   	qcom_rproc_pds_disable(adsp, adsp->proxy_pds, adsp->proxy_pd_count);
>   disable_xo_clk:
>   	clk_disable_unprepare(adsp->xo);
> +adsp_smmu_unmap:
> +	if (adsp->adsp_sandbox_needed) {
> +		iommu_unmap(adsp->iommu_dom, adsp->mem_phys, adsp->mem_size);
> +		adsp_unmap_smmu(rproc);
> +		iommu_domain_free(adsp->iommu_dom);
> +	}
>   disable_irqs:
>   	qcom_q6v5_unprepare(&adsp->q6v5);
>   
> @@ -429,6 +594,9 @@ static int adsp_stop(struct rproc *rproc)
>   	if (ret)
>   		dev_err(adsp->dev, "failed to shutdown: %d\n", ret);
>   
> +	if (adsp->adsp_sandbox_needed)
> +		adsp_unmap_smmu(rproc);

No need to call iommu_unmap() and iommu_domain_free() here?
(this is the same comment as the one in adsp_rproc_unmap_smmu(). This is 
just a blind guess based on symmetry of the code.)

> +
>   	handover = qcom_q6v5_unprepare(&adsp->q6v5);
>   	if (handover)
>   		qcom_adsp_pil_handover(&adsp->q6v5);

