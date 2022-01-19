Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D2A49403D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 19:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356952AbiASS7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 13:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbiASS65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 13:58:57 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0051FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 10:58:56 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id h13so2528377plf.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 10:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KVCbO/zBQSuPDv2Qo3g+XS7TOlXwA0ETja4CXg7oELk=;
        b=FN/qNvZs6asA+BpDQPhKVkibYzKevrkQfKWzy3s+8cuVDYVGMaHWKJV9P6O6k1Q8TI
         /+54N8YcRba/sObW6AnQnfTOUd9GJP3JS6Xx2ZT85uD2bLFuEIIoiWhTG7Nd0NO1CzJX
         RgeMVA6O1orM+3PgaE6XdrlhLFcuoHko0WrWPfhP7HJtgvvsr3q8lMCe7wV6lLllsJ3n
         llLKpoDvBT7lWef6l2Cnh5r75CWfwMMKnT4vaPs1Tik6zScRyvlnN6tr+eOGPBa6in3E
         fTctY1FlpfDQPFpWvqbLBeCVtJX1S8QmQdKpD4g4MWFZ11svTtVlrAq/ZoXPXivv+Ly8
         5lUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KVCbO/zBQSuPDv2Qo3g+XS7TOlXwA0ETja4CXg7oELk=;
        b=tR2ess1N4E8ZF51N7+EtusVWfNN4nytZ4kcrufeKNW9onOyoEcTpRxJ41DEtD3cOSC
         6nWqem1AbMqhhe1aON50a6uNR1gLx/a6FBmMS6CV3FnpLvzv99Uy+ME2R/9+HmaQHMBa
         4qwbtoKLoxhDkf5U3Vjnq8WvqdDOwt6VWPjbVowEC1IfrZ4+NfijVmaulrRXFzRhFBdO
         N+UUeDOsXCTiYiDjRghdgq5bqMWQx4kK9VoHiZxeUWLxZ5Ogb4sNyEikwxvofY/YwMH4
         Tr1KG3vyqF+52KEfa3DK35+BtlWU6gavVoFVJCv1TB8r2WcS5/6xQ3hnaMe+Ial2IzMs
         RUkQ==
X-Gm-Message-State: AOAM530/q865kQNKyqx2SCuxtMpuHSzP7VYquieTq26L6hCoJ7DUUHWn
        599Yfe/1AHop+btCB6ncvr48cQ==
X-Google-Smtp-Source: ABdhPJypgOfByERIAkxGzI7t3DN2HEXlgJPIuzEhjJYKpf4Aq+W6RWVuLkHKcRDFka7cx5qjAB+5yA==
X-Received: by 2002:a17:902:7d8f:b0:14a:b712:bbfb with SMTP id a15-20020a1709027d8f00b0014ab712bbfbmr17292816plm.63.1642618736462;
        Wed, 19 Jan 2022 10:58:56 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id x7sm375505pfh.178.2022.01.19.10.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 10:58:54 -0800 (PST)
Date:   Wed, 19 Jan 2022 11:58:52 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     bjorn.andersson@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 7/9] remoteproc: imx_rproc: support kicking Mcore from
 Linux for i.MX8QXP
Message-ID: <20220119185852.GB1284752@p14s>
References: <20220111033333.403448-1-peng.fan@oss.nxp.com>
 <20220111033333.403448-10-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111033333.403448-10-peng.fan@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 11:33:31AM +0800, Peng Fan (OSS) wrote:
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
>  drivers/remoteproc/imx_rproc.c | 64 +++++++++++++++++++++++++++++++++-
>  1 file changed, 63 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index 5f04aea2f6a1..09d2a06e5ed6 100644
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
> @@ -97,6 +98,9 @@ struct imx_rproc {
>  	struct notifier_block		proc_nb;
>  	u32				rproc_pt;
>  	u32				rsrc;
> +	int                             num_pd;
> +	struct device                   **pd_dev;
> +	struct device_link              **pd_dev_link;
>  };
>  
>  static const struct imx_rproc_att imx_rproc_att_imx8qxp[] = {
> @@ -305,6 +309,9 @@ static int imx_rproc_start(struct rproc *rproc)
>  		arm_smccc_smc(IMX_SIP_RPROC, IMX_SIP_RPROC_START, 0, 0, 0, 0, 0, 0, &res);
>  		ret = res.a0;
>  		break;
> +	case IMX_RPROC_SCU_API:
> +		ret = imx_sc_pm_cpu_start(priv->ipc_handle, priv->rsrc, true, 0x34fe0000);

Where does the 0x34fe0000 comes from and what happens when the boot address
changes?  This should come from the device tree or some HW register somewhere.

> +		break;
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> @@ -334,6 +341,9 @@ static int imx_rproc_stop(struct rproc *rproc)
>  		if (res.a1)
>  			dev_info(dev, "Not in wfi, force stopped\n");
>  		break;
> +	case IMX_RPROC_SCU_API:
> +		ret = imx_sc_pm_cpu_start(priv->ipc_handle, priv->rsrc, false, 0x34fe0000);
> +		break;

Same as above.

>  	default:
>  		return -EOPNOTSUPP;
>  	}
> @@ -719,6 +729,56 @@ static int imx_rproc_partition_notify(struct notifier_block *nb,
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
> +	}
> +
> +	return ret;
> +}
> +
>  static int imx_rproc_detect_mode(struct imx_rproc *priv)
>  {
>  	struct regmap_config config = { .name = "imx-rproc" };
> @@ -749,13 +809,13 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
>  			return ret;
>  		}
>  
> +		priv->has_clk = false;

This statement seems to imply that for imx8qxq processors, which is the only one
to use the IMX_RPROC_SCU_API, priv->has_clk is always false.  If so then why
bother with a flag at all?

More comments tomorrow...

>  		/*
>  		 * If Mcore resource is not owned by Acore partition, It is kicked by ROM,
>  		 * and Linux could only do IPC with Mcore and nothing else.
>  		 */
>  		if (!imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc)) {
>  
> -			priv->has_clk = false;
>  			priv->rproc->self_recovery = true;
>  			priv->rproc->state = RPROC_DETACHED;
>  
> @@ -782,6 +842,8 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
>  				dev_warn(dev, "Enable irq failed.\n");
>  				return ret;
>  			}
> +		} else {
> +			return imx_rproc_attach_pd(priv);
>  		}
>  
>  		return 0;
> -- 
> 2.25.1
> 
