Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B415551B3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376999AbiFVQuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376825AbiFVQsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:48:55 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16673DDC2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:48:14 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id i15so15877547plr.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EPjBWJp4+cnUmhtsaExpC0uH3Ar9b7Yqno9YlbKDpEM=;
        b=O/WI9RxqyY3j9zZPBjaivC4PBQRKM241XaCzEoMcdZCZTaGiYw5vhL0IzXVEeZ9/cu
         AfzrnymnQw3E1bgnkaS1k+2DFHWec4a+AZuK3hAage/ENOYpm2dD8Z9M7e5BmGsmhX5M
         cvZh0UuXxLxLDa1UHU6e2uVEKX93bEm5xoncoyPX6AqX9KyS7X9r4NOwTuBYMN3eSDVP
         i2tOv6T/D30iwOCZdCgvOrVLW/fJ+JYJMS3WSKTk7Dp8La6AAiKBEK3z+eYYndqeVoZ9
         5oLHSzh9t87UCBwDWN2LjbIb5ypDPhnPGz6qQsD75wgIuDAoMEVuOMdd3S/OHMKGCeIR
         bwyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EPjBWJp4+cnUmhtsaExpC0uH3Ar9b7Yqno9YlbKDpEM=;
        b=Jfin5JsUEoaGzePxA8Hv6z+HtpCpxXiol/c/z0cTzkSM0XoZerdhDZvwiDBHSksAz/
         ZNJsuQiyHOXACOQxQBfkvaDtTEXzxAms+rlPCW6GzNDvNEOj08D0xqT80Wewn2zAgGh8
         1cfHOoEgVHJv0t6By99Loq7sZLZj4IWWsxahGZyZbD0w1lvbzSklqD7tPgc/Kcb2BMfh
         ebMwCS8gbTGQ2DV8wVnh5jORRczzo9gkDaDEPd4JouLbWzR6Liz+/2cI17/oHOGun3Q2
         mPShg9HR+1TBL1BO4zE/u1paA+IJcKD2GqhtSYao8ZvBrG2/ke1xIyqFm0oYNR/JT1xe
         gPbg==
X-Gm-Message-State: AJIora+SLV9pQcIz2d5+bpNAwQKsrJgNwB8y3mGoXayxsBUXnFjsADfi
        CsnKFQg82pUaw4GNNQYC0mMlog==
X-Google-Smtp-Source: AGRyM1vZBhmsccGkxKPwH1Yo3egL09IVaEXsJhBfwL5fLkZIk1hFm8xi2xqkz2GE870z9R+SkO1ZgQ==
X-Received: by 2002:a17:902:8689:b0:14e:f1a4:d894 with SMTP id g9-20020a170902868900b0014ef1a4d894mr35075563plo.65.1655916493753;
        Wed, 22 Jun 2022 09:48:13 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id x82-20020a627c55000000b0052089e1b88esm7425385pfc.192.2022.06.22.09.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 09:48:12 -0700 (PDT)
Date:   Wed, 22 Jun 2022 10:48:10 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc: imx_rproc: Fix refcount leak in
 imx_rproc_addr_init
Message-ID: <20220622164810.GB1606016@p14s>
References: <20220512045558.7142-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512045558.7142-1-linmq006@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 08:55:58AM +0400, Miaoqian Lin wrote:
> of_parse_phandle() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not needed anymore.
> This function has two paths missing of_node_put().
> 
> Fixes: 6e962bfe56b9 ("remoteproc: imx_rproc: add missing of_node_put")
> Fixes: a0ff4aa6f010 ("remoteproc: imx_rproc: add a NXP/Freescale imx_rproc driver")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/remoteproc/imx_rproc.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index 7a096f1891e6..6363ed40854a 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -559,16 +559,17 @@ static int imx_rproc_addr_init(struct imx_rproc *priv,
>  
>  		node = of_parse_phandle(np, "memory-region", a);
>  		/* Not map vdevbuffer, vdevring region */
> -		if (!strncmp(node->name, "vdev", strlen("vdev")))
> +		if (!strncmp(node->name, "vdev", strlen("vdev"))) {
> +			of_node_put(node);
>  			continue;
> +		}
>  		err = of_address_to_resource(node, 0, &res);
> +		of_node_put(node);

Applied.

Thanks,
Mathieu

>  		if (err) {
>  			dev_err(dev, "unable to resolve memory region\n");
>  			return err;
>  		}
>  
> -		of_node_put(node);
> -
>  		if (b >= IMX_RPROC_MEM_MAX)
>  			break;
>  
> -- 
> 2.25.1
> 
