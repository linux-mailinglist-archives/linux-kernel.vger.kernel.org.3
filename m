Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB3E464DE6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 13:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349318AbhLAMdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 07:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243419AbhLAMda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 07:33:30 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DACC061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 04:30:09 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1msOkR-00015d-J2; Wed, 01 Dec 2021 13:30:07 +0100
Message-ID: <40a8113ebb566f3c87648ffa86d39846fc63d8a4.camel@pengutronix.de>
Subject: Re: [PATCH] drm/etnaviv: constify static struct cooling_ops
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, etnaviv@lists.freedesktop.org,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Russell King <linux+etnaviv@armlinux.org.uk>
Date:   Wed, 01 Dec 2021 13:30:06 +0100
In-Reply-To: <20211128201916.10230-1-rikard.falkeborn@gmail.com>
References: <20211128201916.10230-1-rikard.falkeborn@gmail.com>
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

Am Sonntag, dem 28.11.2021 um 21:19 +0100 schrieb Rikard Falkeborn:
> The only usage of cooling_ops is to pass its address to
> thermal_of_cooling_device_register(), which takes a pointer to const
> struct thermal_cooling_device_ops as input. Make it const to allow the
> compiler to put it in read-only memory.
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Applied to my etnaviv/next branch.

Regards,
Lucas

> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> index 06bde46df451..37018bc55810 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> @@ -1658,7 +1658,7 @@ etnaviv_gpu_cooling_set_cur_state(struct thermal_cooling_device *cdev,
>  	return 0;
>  }
>  
> -static struct thermal_cooling_device_ops cooling_ops = {
> +static const struct thermal_cooling_device_ops cooling_ops = {
>  	.get_max_state = etnaviv_gpu_cooling_get_max_state,
>  	.get_cur_state = etnaviv_gpu_cooling_get_cur_state,
>  	.set_cur_state = etnaviv_gpu_cooling_set_cur_state,


