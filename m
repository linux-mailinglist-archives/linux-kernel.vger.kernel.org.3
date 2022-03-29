Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29CB74EB1FD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 18:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239779AbiC2Qn7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 29 Mar 2022 12:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239761AbiC2QnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 12:43:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782A424EDB0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 09:41:38 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nZEuV-0005rU-3T; Tue, 29 Mar 2022 18:41:35 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nZEuR-003pAt-Jj; Tue, 29 Mar 2022 18:41:34 +0200
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nZEuT-000Ale-Jy; Tue, 29 Mar 2022 18:41:33 +0200
Message-ID: <933830e163f5f514a24e8b6137c0ff2e4c89e7e5.camel@pengutronix.de>
Subject: Re: [PATCH] drm/imx: dw_hdmi-imx: Fix bailout in error cases of
 probe
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Date:   Tue, 29 Mar 2022 18:41:33 +0200
In-Reply-To: <20220128091944.3831256-1-victor.liu@nxp.com>
References: <20220128091944.3831256-1-victor.liu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fr, 2022-01-28 at 17:19 +0800, Liu Ying wrote:
> In dw_hdmi_imx_probe(), if error happens after dw_hdmi_probe()
> returns
> successfully, dw_hdmi_remove() should be called where necessary as
> bailout.
> 
> Fixes: c805ec7eb210 ("drm/imx: dw_hdmi-imx: move initialization into
> probe")
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
>  drivers/gpu/drm/imx/dw_hdmi-imx.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/imx/dw_hdmi-imx.c
> b/drivers/gpu/drm/imx/dw_hdmi-imx.c
> index 87428fb23d9f..a2277a0d6d06 100644
> --- a/drivers/gpu/drm/imx/dw_hdmi-imx.c
> +++ b/drivers/gpu/drm/imx/dw_hdmi-imx.c
> @@ -222,6 +222,7 @@ static int dw_hdmi_imx_probe(struct
> platform_device *pdev)
>         struct device_node *np = pdev->dev.of_node;
>         const struct of_device_id *match =
> of_match_node(dw_hdmi_imx_dt_ids, np);
>         struct imx_hdmi *hdmi;
> +       int ret;
>  
>         hdmi = devm_kzalloc(&pdev->dev, sizeof(*hdmi), GFP_KERNEL);
>         if (!hdmi)
> @@ -243,10 +244,15 @@ static int dw_hdmi_imx_probe(struct
> platform_device *pdev)
>         hdmi->bridge = of_drm_find_bridge(np);
>         if (!hdmi->bridge) {
>                 dev_err(hdmi->dev, "Unable to find bridge\n");
> +               dw_hdmi_remove(hdmi->hdmi);
>                 return -ENODEV;
>         }
>  
> -       return component_add(&pdev->dev, &dw_hdmi_imx_ops);
> +       ret = component_add(&pdev->dev, &dw_hdmi_imx_ops);
> +       if (ret)
> +               dw_hdmi_remove(hdmi->hdmi);
> +
> +       return ret;
>  }
>  
>  static int dw_hdmi_imx_remove(struct platform_device *pdev)

Thank you, applied to imx-drm/fixes.

regards
Philipp
