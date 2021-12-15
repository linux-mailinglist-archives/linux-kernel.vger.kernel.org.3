Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9207A475508
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 10:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241115AbhLOJUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 04:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236374AbhLOJUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 04:20:35 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A9CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 01:20:34 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1mxQSf-000162-FC; Wed, 15 Dec 2021 10:20:33 +0100
Message-ID: <1dece3a3593d271eaef7fa388957bc0ca6397851.camel@pengutronix.de>
Subject: Re: [PATCH 16/60] drm/imx/dcss: Add support for the nomodeset
 kernel parameter
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Date:   Wed, 15 Dec 2021 10:20:31 +0100
In-Reply-To: <20211215010008.2545520-17-javierm@redhat.com>
References: <20211215010008.2545520-1-javierm@redhat.com>
         <20211215010008.2545520-17-javierm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, dem 15.12.2021 um 01:59 +0100 schrieb Javier Martinez Canillas:
> According to disable Documentation/admin-guide/kernel-parameters.txt, this
> parameter can be used to disable kernel modesetting.
> 
> DRM drivers will not perform display-mode changes or accelerated rendering
> and only the systewm system framebuffer will be available if it was set-up.
                    ^ typo in all the patches.
> 
> But only a few DRM drivers currently check for nomodeset, make this driver
> to also support the command line parameter.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
> 
>  drivers/gpu/drm/imx/dcss/dcss-drv.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/imx/dcss/dcss-drv.c b/drivers/gpu/drm/imx/dcss/dcss-drv.c
> index 8dc2f85c514b..5be591da7389 100644
> --- a/drivers/gpu/drm/imx/dcss/dcss-drv.c
> +++ b/drivers/gpu/drm/imx/dcss/dcss-drv.c
> @@ -38,6 +38,9 @@ static int dcss_drv_platform_probe(struct platform_device *pdev)
>  	int err = 0;
>  	bool hdmi_output = true;
>  
> +	if (drm_firmware_drivers_only())
> +		return -ENODEV;
> +
>  	if (!dev->of_node)
>  		return -ENODEV;
>  


