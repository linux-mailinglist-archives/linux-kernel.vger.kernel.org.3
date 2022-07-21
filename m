Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA2D57CA9A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 14:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbiGUMZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 08:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbiGUMZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 08:25:08 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6F632C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 05:25:06 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 28F41496;
        Thu, 21 Jul 2022 14:25:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1658406304;
        bh=Emp/6tFuyFlwG6QHbyW9jzXRmPRexPwIgBYyovQerJM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pmFgHDk6rGBfrUbse68M/3VoyInH8PcSKFdWsM1dLMQxVrMMv7rpgumH95jQIbcHd
         yTKslEAg/vwlqeAOfWkLYcvrd9UlVS7KPqHuREhrAx9LpE6rnk1gxKRdKz6VJEDn6U
         l5TufDS+IcQBv+07gJHstmjK0P3ODcWaN0bqqobQ=
Date:   Thu, 21 Jul 2022 15:25:02 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/imx/dcss: get rid of HPD warning message
Message-ID: <YtlFniiVnYUoZCPM@pendragon.ideasonboard.com>
References: <20220721120912.6639-1-laurentiu.palcu@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220721120912.6639-1-laurentiu.palcu@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurentiu,

Thank you for the patch.

On Thu, Jul 21, 2022 at 03:09:12PM +0300, Laurentiu Palcu wrote:
> When DCSS + MIPI_DSI is used, and the last bridge in the chain supports
> HPD, we can see a "Hot plug detection already enabled" warning stack
> trace dump that's thrown when DCSS is initialized.
> 
> The problem appeared when HPD was enabled by default in the
> bridge_connector initialization, which made the
> drm_bridge_connector_enable_hpd() call, in DCSS init path, redundant.
> So, let's remove that call.
> 
> Fixes: 09077bc311658 ("drm/bridge_connector: enable HPD by default if supported")
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/imx/dcss/dcss-kms.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/imx/dcss/dcss-kms.c b/drivers/gpu/drm/imx/dcss/dcss-kms.c
> index 9b84df34a6a12..8cf3352d88582 100644
> --- a/drivers/gpu/drm/imx/dcss/dcss-kms.c
> +++ b/drivers/gpu/drm/imx/dcss/dcss-kms.c
> @@ -142,8 +142,6 @@ struct dcss_kms_dev *dcss_kms_attach(struct dcss_dev *dcss)
>  
>  	drm_kms_helper_poll_init(drm);
>  
> -	drm_bridge_connector_enable_hpd(kms->connector);
> -
>  	ret = drm_dev_register(drm, 0);
>  	if (ret)
>  		goto cleanup_crtc;

-- 
Regards,

Laurent Pinchart
