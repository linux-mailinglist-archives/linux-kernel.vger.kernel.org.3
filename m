Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B325C552AED
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 08:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345622AbiFUGUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 02:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236786AbiFUGUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 02:20:40 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE2E5FB9;
        Mon, 20 Jun 2022 23:20:39 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 59295104;
        Tue, 21 Jun 2022 08:20:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1655792437;
        bh=QxqGI8u7Mcjy3hAKsyC9Lq9xMXJUcfr/8cXBFAGKrXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Um0skpAxHmGTSW5KKa9z6qFSD447639lNm8xsuDGUtCDvnxWVWxm4oydnlFJ9PVwb
         0tOOgMIePz4s/oh+Lo48RnSPA9Qz2j/6XjVucwtIBS/vnloeur3715E9IPgyvg72fP
         P0BZRSU9B5A4FAHOP5VlpBrO2tj5O7FBOl7Ks6co=
Date:   Tue, 21 Jun 2022 09:20:21 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm: shmobile: Use backlight helper
Message-ID: <YrFjJa6aLSK5P3lY@pendragon.ideasonboard.com>
References: <20220616170821.1348169-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220616170821.1348169-1-steve@sk2.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Thank you for the patch.

On Thu, Jun 16, 2022 at 07:08:21PM +0200, Stephen Kitt wrote:
> This started with work on the removal of backlight_properties'
> deprecated fb_blank field, much of which can be taken care of by using
> helper functions provided by backlight.h instead of directly accessing
> fields in backlight_properties. This patch series doesn't involve
> fb_blank, but it still seems useful to use helper functions where
> appropriate.
> 
> Instead of retrieving the backlight brightness in struct
> backlight_properties manually, and then checking whether the backlight
> should be on at all, use backlight_get_brightness() which does all
> this and insulates this from future changes.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> Changes since v1: clarified commit message, this doesn't touch fb_blank
> ---
>  drivers/gpu/drm/shmobile/shmob_drm_backlight.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/shmobile/shmob_drm_backlight.c b/drivers/gpu/drm/shmobile/shmob_drm_backlight.c
> index f6628a5ee95f..794573badfe8 100644
> --- a/drivers/gpu/drm/shmobile/shmob_drm_backlight.c
> +++ b/drivers/gpu/drm/shmobile/shmob_drm_backlight.c
> @@ -18,11 +18,7 @@ static int shmob_drm_backlight_update(struct backlight_device *bdev)
>  	struct shmob_drm_connector *scon = bl_get_data(bdev);
>  	struct shmob_drm_device *sdev = scon->connector.dev->dev_private;
>  	const struct shmob_drm_backlight_data *bdata = &sdev->pdata->backlight;
> -	int brightness = bdev->props.brightness;
> -
> -	if (bdev->props.power != FB_BLANK_UNBLANK ||
> -	    bdev->props.state & BL_CORE_SUSPENDED)
> -		brightness = 0;
> +	int brightness = backlight_get_brightness(bdev);
>  
>  	return bdata->set_brightness(brightness);
>  }
> 
> base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56

-- 
Regards,

Laurent Pinchart
