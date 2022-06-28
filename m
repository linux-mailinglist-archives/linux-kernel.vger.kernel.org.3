Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4232555EB3C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 19:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbiF1Rnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 13:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbiF1Rna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 13:43:30 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A3C5F8A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 10:43:19 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id c6-20020a17090abf0600b001eee794a478so6008677pjs.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 10:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Rr14SIHqelCsw7/8K+Wlj+54peZR7WyMvbQmB8Ja3NY=;
        b=Cq1OgaFxbIxuOWrZxydWl+elvVBphIjnA9sULhzOr1/yJjIph4P+OzxGZW/ULc3m3L
         PsCCWLOP5R0hhcN3KfgZ8ySfYB71jfKRht4g6Ik8J9UmNoJ1DfAI5PuvvpiIsu82k9B+
         QAJogtytZTQRX9gCm1wsQasycg3s8xO5IWNRV0nfVhC0pyKW58UzWlUycX5ujqNG3fFK
         FuitU7yTem/JhqTm91xjEuXFMCk97gWoQj/E+JIznBJCu3N2L5zrNAWOzJdVR/8+jH68
         d73TvBMizVcFKfnLGh2jpy/Bhcg7o6mjTDfmQ0KNZSlCM3fWLsUD3BfzYsOLbCxNkuol
         877Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rr14SIHqelCsw7/8K+Wlj+54peZR7WyMvbQmB8Ja3NY=;
        b=JlEifj4RErtYZ2Oj6+GrYJEM9XZrsToOkbDfAmHXEFDhLBtkF/tmG5c3zfbo/6zlWc
         wBxIVBv5Qy+8luzNT/O0B4n6tVXC+qD94ZYPHDwXCtQprUbWUNxf5Hx9/FhzudkDh2x5
         kUHCapUAENnBuy+znAEStzQUJZ8bG/LCZJoMq2fKAiLj4rg4ZVLgxLhoylrtuo9v41r3
         BVz6vQC4r/YIDNAgrXwHNO59IGdA/X1TttM6Qwp2YVC3+bgt2oTtvKK7aI/rXSvMWXtk
         tEK1LYrMVHv0L6HWCU9PziyzHDw4hjUbjua8VDe6TW4uLFLGEBtRZyY/8FUKcHszlAHG
         xaxA==
X-Gm-Message-State: AJIora8AWeY4gvrBlmb2MLzJxcc/LByqvNCS5uNRXDaF+KKwJ2o1U8yn
        P1uejJ8S8XMtFSscejy2vw7oOQ==
X-Google-Smtp-Source: AGRyM1uYOy8dhkDmhkatcxtbjx7rsFzSefCxT7PvAMOulrJ/YRzJQytlLiNSsgFJZlcy1Fkjd7YBkA==
X-Received: by 2002:a17:902:da83:b0:16a:7ca5:36c1 with SMTP id j3-20020a170902da8300b0016a7ca536c1mr6167452plx.81.1656438199296;
        Tue, 28 Jun 2022 10:43:19 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id z5-20020a056a00240500b005255165be67sm9862029pfh.23.2022.06.28.10.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 10:43:18 -0700 (PDT)
Date:   Tue, 28 Jun 2022 11:43:16 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     bjorn.andersson@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V3 4/6] remoteproc: imx_rproc: support kicking Mcore from
 Linux for i.MX8QXP
Message-ID: <20220628174316.GC1942439@p14s>
References: <20220517064937.4033441-1-peng.fan@oss.nxp.com>
 <20220517064937.4033441-5-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517064937.4033441-5-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 02:49:35PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> When M4 is in the same hardware partition with Cortex-A, it
> could be start/stop by Linux.
> 
> Added power domain to make sure M4 could run, it requires several power
> domains to work. Make clk always optional for i.MX8QXP, because
> SCFW handles it when power up M4 core.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/imx_rproc.c | 69 +++++++++++++++++++++++++++++++++-
>  1 file changed, 67 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index 2e751fc90760..49cce9dd55c7 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -16,6 +16,7 @@
>  #include <linux/of_reserved_mem.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
>  #include <linux/regmap.h>
>  #include <linux/remoteproc.h>
>  #include <linux/workqueue.h>
> @@ -96,6 +97,10 @@ struct imx_rproc {
>  	struct notifier_block		rproc_nb;
>  	u32				rproc_pt;	/* partition id */
>  	u32				rsrc_id;	/* resource id */
> +	u32				entry;		/* cpu start address */
> +	int                             num_pd;
> +	struct device                   **pd_dev;
> +	struct device_link              **pd_dev_link;
>  };
>  
>  static const struct imx_rproc_att imx_rproc_att_imx93[] = {
> @@ -335,6 +340,9 @@ static int imx_rproc_start(struct rproc *rproc)
>  		arm_smccc_smc(IMX_SIP_RPROC, IMX_SIP_RPROC_START, 0, 0, 0, 0, 0, 0, &res);
>  		ret = res.a0;
>  		break;
> +	case IMX_RPROC_SCU_API:
> +		ret = imx_sc_pm_cpu_start(priv->ipc_handle, priv->rsrc_id, true, priv->entry);
> +		break;
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> @@ -364,6 +372,9 @@ static int imx_rproc_stop(struct rproc *rproc)
>  		if (res.a1)
>  			dev_info(dev, "Not in wfi, force stopped\n");
>  		break;
> +	case IMX_RPROC_SCU_API:
> +		ret = imx_sc_pm_cpu_start(priv->ipc_handle, priv->rsrc_id, false, priv->entry);
> +		break;
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> @@ -724,6 +735,56 @@ static int imx_rproc_partition_notify(struct notifier_block *nb,
>  	return 0;
>  }
>  
> +static int imx_rproc_attach_pd(struct imx_rproc *priv)
> +{
> +	struct device *dev = priv->dev;
> +	int ret, i;
> +
> +	priv->num_pd = of_count_phandle_with_args(dev->of_node, "power-domains",
> +						  "#power-domain-cells");
> +	if (priv->num_pd < 0)
> +		return priv->num_pd;
> +
> +	if (!priv->num_pd)
> +		return 0;
> +
> +	priv->pd_dev = devm_kmalloc_array(dev, priv->num_pd, sizeof(*priv->pd_dev), GFP_KERNEL);
> +	if (!priv->pd_dev)
> +		return -ENOMEM;
> +
> +	priv->pd_dev_link = devm_kmalloc_array(dev, priv->num_pd, sizeof(*priv->pd_dev_link),
> +					       GFP_KERNEL);
> +
> +	if (!priv->pd_dev_link)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < priv->num_pd; i++) {
> +		priv->pd_dev[i] = dev_pm_domain_attach_by_id(dev, i);
> +		if (IS_ERR(priv->pd_dev[i])) {
> +			ret = PTR_ERR(priv->pd_dev[i]);
> +			goto detach_pd;
> +		}
> +
> +		priv->pd_dev_link[i] = device_link_add(dev, priv->pd_dev[i], DL_FLAG_STATELESS |
> +						       DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE);
> +		if (!priv->pd_dev_link[i]) {
> +			dev_pm_domain_detach(priv->pd_dev[i], false);
> +			ret = -EINVAL;
> +			goto detach_pd;
> +		}
> +	}
> +
> +	return 0;
> +
> +detach_pd:
> +	while (--i >= 0) {
> +		device_link_del(priv->pd_dev_link[i]);
> +		dev_pm_domain_detach(priv->pd_dev[i], false);

Same here - why are these not called during driver removal and along the error
path in probe()?

> +	}
> +
> +	return ret;
> +}
> +
>  static int imx_rproc_detect_mode(struct imx_rproc *priv)
>  {
>  	struct regmap_config config = { .name = "imx-rproc" };
> @@ -758,8 +819,12 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
>  		 * If Mcore resource is not owned by Acore partition, It is kicked by ROM,
>  		 * and Linux could only do IPC with Mcore and nothing else.
>  		 */
> -		if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id))
> -			return 0;
> +		if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id)) {
> +			if (of_property_read_u32(dev->of_node, "fsl,entry-address", &priv->entry))
> +				return -EINVAL;
> +
> +			return imx_rproc_attach_pd(priv);
> +		}
>  
>  		priv->rproc->state = RPROC_DETACHED;
>  		priv->rproc->recovery_disabled = true;
> -- 
> 2.25.1
> 
