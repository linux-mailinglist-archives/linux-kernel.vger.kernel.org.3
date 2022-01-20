Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6AA49531D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 18:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377351AbiATRXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 12:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377233AbiATRXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 12:23:47 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6F4C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 09:23:47 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id n16-20020a17090a091000b001b46196d572so6376290pjn.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 09:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=57MlWgTciyxXwlhqlF3nVQS9i7uH1Dz0RfKk3iP2XAw=;
        b=fIlwDTmIcIU6AGBGW573iDAcwDD1t0MyZPs0tsVV3oAwgz439OBuIOzcFqvWVdpxDK
         zVwuRWDBsD3Hj99e1DzG/p8ov+gBXjIbV2N5+yXDiPd0dFp8CwPQ7N3/VbQjhdWt+wzR
         3eU8YcKKVktcwXCRaEfp7zta8VGkSXvN26O8Nvl0Y5aDLMOsh9ood7Lh8uZOzldDJ54c
         zGkWEkXGMx1Yz9JiErx/nmohmDgGnPQUpryyIhKhi4/cCvDJThBOorqf10PYf/JwgiM+
         9TEONCHRYLpc65FIUps7nnyj6hhOmLb6b1xyNbNEsyNM7/KsBCRZ1cTkIVxq1oaUe6uk
         SdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=57MlWgTciyxXwlhqlF3nVQS9i7uH1Dz0RfKk3iP2XAw=;
        b=6oSxUWTPSlFELBvRojyS0J9Aq+wgIOO/g0vZ7AJUNXqwDL6kCCepL9M8REQEYYByMY
         9sI6Q84XWCpSqq8MFyath6XH+8Vdi5HEzsI6oKPaQJelpVJJMadYWmPXtqL1ynWWboHF
         8nu42txFErcNevGJVQvTwnkcfAj4mR3pnIRFBph7uc2G9ZLIVb/O/aTEVcye/P5n9WyM
         av71d5c7iD8VnWN3gV1DQP94erA4BxSVDztsQS0Nb6vNg3Hxt4wjmhwddAtT5y21rztJ
         oJkzcKdPtB8UHhCVsFEk8zxZgQKg0hHaZhumOP1h2ZZiMveRANzJWlK2Kbnhz1gESHMt
         odzg==
X-Gm-Message-State: AOAM530gRMLkOsh3ItNAJVoDzsKNTLoPx3tkOknNYkoNPBYN3nq/BOCe
        NUh6Ukih/2x4ZOHyv6njNryDcFte5ObO3Q==
X-Google-Smtp-Source: ABdhPJwsKxXKcx7FolSUNG7zSGPWZFQs5W4Redl5G4sTK5OO76GZwZNbj86yHMbHr+IlQ75YdhmTOA==
X-Received: by 2002:a17:90b:4c0e:: with SMTP id na14mr12192436pjb.84.1642699427041;
        Thu, 20 Jan 2022 09:23:47 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id t23sm2935750pgg.30.2022.01.20.09.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 09:23:45 -0800 (PST)
Date:   Thu, 20 Jan 2022 10:23:43 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     bjorn.andersson@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 8/9] remoteproc: imx_rproc: support i.MX8QM
Message-ID: <20220120172343.GA1338735@p14s>
References: <20220111033333.403448-1-peng.fan@oss.nxp.com>
 <20220111033333.403448-11-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111033333.403448-11-peng.fan@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 11:33:32AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Most logic are same as i.MX8QXP, but i.MX8QM has two general purpose
> M4 cores:
>  Use the lower 16 bits specifying core, higher 16 bits for flags.
>  The 2nd core has different start address from SCFW view

Are the cores running independently or in lockstep?  This is relevant
information that should be in the changelog.  The above is an implementation
detail that should be added as comments in the code. 

> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/imx_rproc.c | 55 +++++++++++++++++++++++++++++++---
>  1 file changed, 51 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index 09d2a06e5ed6..7bc274fbce9f 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -77,8 +77,11 @@ struct imx_rproc_mem {
>  
>  /* att flags */
>  /* M4 own area. Can be mapped at probe */
> -#define ATT_OWN		BIT(1)
> -#define ATT_IOMEM	BIT(2)
> +#define ATT_OWN         BIT(31)
> +#define ATT_IOMEM       BIT(30)

ATT_OWN was defined in 2017 and has had the same value since.  ATT_IOMEM was
introduced by this commit [1] (that you signed off on), which as supposed to be
a fix for another commit.

Now, overnight, both bitfields are changed without any explanation other than a
cryptic comments.  What about all the other platforms that previously used those
bitfields - was this change tested on those as well?

I will stop here with this patchset - it needs to much work for me to continue
reviewing it.

Thanks,
Mathieu

[1]. 91bb26637353 remoteproc: imx_rproc: Fix TCM io memory type


> +/* I = [0:7] */
> +#define ATT_CORE_MASK   0xffff
> +#define ATT_CORE(I)     BIT((I))
>  
>  struct imx_rproc {
>  	struct device			*dev;
> @@ -98,11 +101,25 @@ struct imx_rproc {
>  	struct notifier_block		proc_nb;
>  	u32				rproc_pt;
>  	u32				rsrc;
> +	u32				reg;
>  	int                             num_pd;
>  	struct device                   **pd_dev;
>  	struct device_link              **pd_dev_link;
>  };
>  
> +static const struct imx_rproc_att imx_rproc_att_imx8qm[] = {
> +	/* dev addr , sys addr  , size      , flags */
> +	{ 0x08000000, 0x08000000, 0x10000000, 0},
> +	/* TCML */
> +	{ 0x1FFE0000, 0x34FE0000, 0x00020000, ATT_OWN | ATT_CORE(0)},
> +	{ 0x1FFE0000, 0x38FE0000, 0x00020000, ATT_OWN | ATT_CORE(1)},
> +	/* TCMU */
> +	{ 0x20000000, 0x35000000, 0x00020000, ATT_OWN | ATT_CORE(0)},
> +	{ 0x20000000, 0x39000000, 0x00020000, ATT_OWN | ATT_CORE(1)},
> +	/* DDR (Data) */
> +	{ 0x80000000, 0x80000000, 0x60000000, 0 },
> +};
> +
>  static const struct imx_rproc_att imx_rproc_att_imx8qxp[] = {
>  	/* dev addr , sys addr  , size	    , flags */
>  	{ 0x08000000, 0x08000000, 0x10000000, 0},
> @@ -260,6 +277,12 @@ static const struct imx_rproc_dcfg imx_rproc_cfg_imx8ulp = {
>  	.method		= IMX_RPROC_NONE,
>  };
>  
> +static const struct imx_rproc_dcfg imx_rproc_cfg_imx8qm = {
> +	.att            = imx_rproc_att_imx8qm,
> +	.att_size       = ARRAY_SIZE(imx_rproc_att_imx8qm),
> +	.method         = IMX_RPROC_SCU_API,
> +};
> +
>  static const struct imx_rproc_dcfg imx_rproc_cfg_imx8qxp = {
>  	.att		= imx_rproc_att_imx8qxp,
>  	.att_size	= ARRAY_SIZE(imx_rproc_att_imx8qxp),
> @@ -310,7 +333,10 @@ static int imx_rproc_start(struct rproc *rproc)
>  		ret = res.a0;
>  		break;
>  	case IMX_RPROC_SCU_API:
> -		ret = imx_sc_pm_cpu_start(priv->ipc_handle, priv->rsrc, true, 0x34fe0000);
> +		if (priv->reg)
> +			ret = imx_sc_pm_cpu_start(priv->ipc_handle, priv->rsrc, true, 0x38fe0000);
> +		else
> +			ret = imx_sc_pm_cpu_start(priv->ipc_handle, priv->rsrc, true, 0x34fe0000);
>  		break;
>  	default:
>  		return -EOPNOTSUPP;
> @@ -342,7 +368,10 @@ static int imx_rproc_stop(struct rproc *rproc)
>  			dev_info(dev, "Not in wfi, force stopped\n");
>  		break;
>  	case IMX_RPROC_SCU_API:
> -		ret = imx_sc_pm_cpu_start(priv->ipc_handle, priv->rsrc, false, 0x34fe0000);
> +		if (priv->reg)
> +			ret = imx_sc_pm_cpu_start(priv->ipc_handle, priv->rsrc, false, 0x38fe0000);
> +		else
> +			ret = imx_sc_pm_cpu_start(priv->ipc_handle, priv->rsrc, false, 0x34fe0000);
>  		break;
>  	default:
>  		return -EOPNOTSUPP;
> @@ -364,6 +393,11 @@ static int imx_rproc_da_to_sys(struct imx_rproc *priv, u64 da,
>  	for (i = 0; i < dcfg->att_size; i++) {
>  		const struct imx_rproc_att *att = &dcfg->att[i];
>  
> +		if (att->flags & ATT_CORE_MASK) {
> +			if (!((BIT(priv->reg)) & (att->flags & ATT_CORE_MASK)))
> +				continue;
> +		}
> +
>  		if (da >= att->da && da + len < att->da + att->size) {
>  			unsigned int offset = da - att->da;
>  
> @@ -594,6 +628,11 @@ static int imx_rproc_addr_init(struct imx_rproc *priv,
>  		if (!(att->flags & ATT_OWN))
>  			continue;
>  
> +		if (att->flags & ATT_CORE_MASK) {
> +			if (!((BIT(priv->reg)) & (att->flags & ATT_CORE_MASK)))
> +				continue;
> +		}
> +
>  		if (b >= IMX_RPROC_MEM_MAX)
>  			break;
>  
> @@ -809,6 +848,13 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
>  			return ret;
>  		}
>  
> +		priv->reg = of_get_cpu_hwid(dev->of_node, 0);
> +		if (priv->reg == ~0U)
> +			priv->reg = 0;
> +
> +		if (priv->reg > 1)
> +			return -EINVAL;
> +
>  		priv->has_clk = false;
>  		/*
>  		 * If Mcore resource is not owned by Acore partition, It is kicked by ROM,
> @@ -1005,6 +1051,7 @@ static const struct of_device_id imx_rproc_of_match[] = {
>  	{ .compatible = "fsl,imx8mn-cm7", .data = &imx_rproc_cfg_imx8mn },
>  	{ .compatible = "fsl,imx8mp-cm7", .data = &imx_rproc_cfg_imx8mn },
>  	{ .compatible = "fsl,imx8qxp-cm4", .data = &imx_rproc_cfg_imx8qxp },
> +	{ .compatible = "fsl,imx8qm-cm4", .data = &imx_rproc_cfg_imx8qm },
>  	{ .compatible = "fsl,imx8ulp-cm33", .data = &imx_rproc_cfg_imx8ulp },
>  	{},
>  };
> -- 
> 2.25.1
> 
