Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2C955EBD2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 20:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbiF1SDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 14:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbiF1SDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 14:03:06 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638AB13CCD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 11:03:01 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so16722847pjl.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 11:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FEIGoq/0A/uJII60z+SnyujUiEDbTX6Par33hXQlLZw=;
        b=UWK2A29VLIlv8+6eVr7iaft60FNUEMTkSYhhGhxQmOi2LUvhIlIQFc9Jmof6g1G8/H
         KnbGMGQ123M+2kwyTX582uyJSjVFALI7M96BGZBoB+99ED5xV0SZEFqTXB/xkZgfEJk6
         f+hh2RgfCw3ffDVQSn8xEyl9mOWj7ZvSRishSnLJ+id/uliTP4V3rPQ+tLJqVjeaPH44
         SeyWjSPPdw385wwy1nQpkwtlfDNebAy9KnGlo7jOkpDcnvAlW4Ao2/Ophw/ZtyBQCv9s
         WTTdw9rOmrnz2aj01S7GHl9zTwuddBAQlk/gWJribcf/TkMvkbGv+Plk8iZsa1sAQ502
         yTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FEIGoq/0A/uJII60z+SnyujUiEDbTX6Par33hXQlLZw=;
        b=sBqjDlIvJrcnlGJDgi+NK71KWhrVm0TkuoodaBEipiYc+oJVD3hhW7nu0/BnTC8fiF
         pLnGVY20enYqmqIpSfqb89g4SfUizBMlmTf27VYM79gYQ59v0ZwPFBzN+onia7Fxn4iN
         QNuqJ0npv8fbJuTdKLF28cTkmjrEtVzxhUkhobeCm7Ga+MwB4LnuE2iwGQ0WIO7sSk6O
         iIdSHoCWwOGaiiuAKrggSVNvq5YhRmo5wwdWkptrHfoJVDn1D+FccPh71Dc2Wyiqxc0e
         vVXpUVMdKzA2bivEy+pjA4kTvpkblVz/bTcUr62wSXw49fJ7nCV/mmLjTL9hnlKgSDzA
         Xfqw==
X-Gm-Message-State: AJIora/WeaT2KbeonGNwpkQ9o8c6UQnm9d85IfXcGcEL+EwE4z5vfPOv
        RHPc/3i8tO4UMM6pvz7/wBQoQA==
X-Google-Smtp-Source: AGRyM1v2mLeRbPTqnEMWprebvSTGDOJvCRi7MJqhHzOVSY8TkZZ6dHq1/au0ZEz8SPaBw2K7pfsNeA==
X-Received: by 2002:a17:90b:1d04:b0:1ec:f898:d863 with SMTP id on4-20020a17090b1d0400b001ecf898d863mr914455pjb.79.1656439380846;
        Tue, 28 Jun 2022 11:03:00 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id u1-20020a17090a1d4100b001ecb5602944sm143529pju.28.2022.06.28.11.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 11:02:59 -0700 (PDT)
Date:   Tue, 28 Jun 2022 12:02:57 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     bjorn.andersson@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V3 5/6] remoteproc: imx_rproc: support i.MX8QM
Message-ID: <20220628180257.GD1942439@p14s>
References: <20220517064937.4033441-1-peng.fan@oss.nxp.com>
 <20220517064937.4033441-6-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517064937.4033441-6-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 02:49:36PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Most logic are same as i.MX8QXP, but i.MX8QM has two general purpose
> M4 cores, the two cores runs independently and they has different resource
> id, different start address from SCFW view.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/imx_rproc.c | 41 +++++++++++++++++++++++++++++++---
>  1 file changed, 38 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index 49cce9dd55c7..8326193c13d6 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -3,6 +3,7 @@
>   * Copyright (c) 2017 Pengutronix, Oleksij Rempel <kernel@pengutronix.de>
>   */
>  
> +#include <dt-bindings/firmware/imx/rsrc.h>
>  #include <linux/arm-smccc.h>
>  #include <linux/clk.h>
>  #include <linux/err.h>
> @@ -75,10 +76,13 @@ struct imx_rproc_mem {
>  	size_t size;
>  };
>  
> -/* att flags */
> +/* att flags: lower 16 bits specifying core, higher 16 bits for flags  */
>  /* M4 own area. Can be mapped at probe */
> -#define ATT_OWN		BIT(1)
> -#define ATT_IOMEM	BIT(2)
> +#define ATT_OWN         BIT(31)
> +#define ATT_IOMEM       BIT(30)
> +
> +#define ATT_CORE_MASK   0xffff
> +#define ATT_CORE(I)     BIT((I))
>  
>  struct imx_rproc {
>  	struct device			*dev;
> @@ -99,6 +103,7 @@ struct imx_rproc {
>  	u32				rsrc_id;	/* resource id */
>  	u32				entry;		/* cpu start address */
>  	int                             num_pd;
> +	u32				core_index;
>  	struct device                   **pd_dev;
>  	struct device_link              **pd_dev_link;
>  };
> @@ -129,6 +134,19 @@ static const struct imx_rproc_att imx_rproc_att_imx93[] = {
>  	{ 0xD0000000, 0xa0000000, 0x10000000, 0 },
>  };
>  
> +static const struct imx_rproc_att imx_rproc_att_imx8qm[] = {
> +	/* dev addr , sys addr  , size      , flags */
> +	{ 0x08000000, 0x08000000, 0x10000000, 0},
> +	/* TCML */
> +	{ 0x1FFE0000, 0x34FE0000, 0x00020000, ATT_OWN | ATT_IOMEM | ATT_CORE(0)},
> +	{ 0x1FFE0000, 0x38FE0000, 0x00020000, ATT_OWN | ATT_IOMEM | ATT_CORE(1)},
> +	/* TCMU */
> +	{ 0x20000000, 0x35000000, 0x00020000, ATT_OWN | ATT_IOMEM | ATT_CORE(0)},
> +	{ 0x20000000, 0x39000000, 0x00020000, ATT_OWN | ATT_IOMEM | ATT_CORE(1)},
> +	/* DDR (Data) */
> +	{ 0x80000000, 0x80000000, 0x60000000, 0 },
> +};
> +
>  static const struct imx_rproc_att imx_rproc_att_imx8qxp[] = {
>  	{ 0x08000000, 0x08000000, 0x10000000, 0 },
>  	/* TCML/U */
> @@ -279,6 +297,12 @@ static const struct imx_rproc_dcfg imx_rproc_cfg_imx8mq = {
>  	.method		= IMX_RPROC_MMIO,
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
> @@ -395,6 +419,11 @@ static int imx_rproc_da_to_sys(struct imx_rproc *priv, u64 da,
>  	for (i = 0; i < dcfg->att_size; i++) {
>  		const struct imx_rproc_att *att = &dcfg->att[i];
>  
> +		if (att->flags & ATT_CORE_MASK) {
> +			if (!((BIT(priv->core_index)) & (att->flags & ATT_CORE_MASK)))
> +				continue;
> +		}

This is very cryptic - I just spent 20 minutes looking at it and I'm still not
sure I got the full meaning.  Please add enough comments to make things obvious
on first read.

I am done reviewing this patchset.

Thanks,
Mathieu


> +
>  		if (da >= att->da && da + len < att->da + att->size) {
>  			unsigned int offset = da - att->da;
>  
> @@ -815,6 +844,11 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
>  			return ret;
>  		}
>  
> +		if (priv->rsrc_id == IMX_SC_R_M4_1_PID0)
> +			priv->core_index = 1;
> +		else
> +			priv->core_index = 0;
> +
>  		/*
>  		 * If Mcore resource is not owned by Acore partition, It is kicked by ROM,
>  		 * and Linux could only do IPC with Mcore and nothing else.
> @@ -1008,6 +1042,7 @@ static const struct of_device_id imx_rproc_of_match[] = {
>  	{ .compatible = "fsl,imx8mn-cm7", .data = &imx_rproc_cfg_imx8mn },
>  	{ .compatible = "fsl,imx8mp-cm7", .data = &imx_rproc_cfg_imx8mn },
>  	{ .compatible = "fsl,imx8qxp-cm4", .data = &imx_rproc_cfg_imx8qxp },
> +	{ .compatible = "fsl,imx8qm-cm4", .data = &imx_rproc_cfg_imx8qm },
>  	{ .compatible = "fsl,imx8ulp-cm33", .data = &imx_rproc_cfg_imx8ulp },
>  	{ .compatible = "fsl,imx93-cm33", .data = &imx_rproc_cfg_imx93 },
>  	{},
> -- 
> 2.25.1
> 
