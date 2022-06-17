Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021D754F874
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 15:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237095AbiFQNoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 09:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbiFQNoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 09:44:17 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648BA255B0;
        Fri, 17 Jun 2022 06:44:16 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E10682A5;
        Fri, 17 Jun 2022 15:44:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1655473454;
        bh=FZtYLwWL/y44ETYIRueGKdBDN96xDgwzEGOEPrL7Dps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q+A6Z0j38vpRSNIviGjiNz2n/Q+7TjZmoew9hFjpKbFEaagsPJCCVosRatp6nU/V+
         tD7wAfa7g1r8h0CCsNFNZ8oZf8lmqu0LlKV8vcqveKYTcDy+LS4Koei/Vafvenuq0d
         y9ytWmLb95Ir6TD1kt2UaNbk8GUL97cz3163lNMg=
Date:   Fri, 17 Jun 2022 16:44:02 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org, senozhatsky@chromium.org, yunkec@google.com
Subject: Re: [PATCH v7 2/8] media: uvcvideo: Add support for per-device
 control mapping overrides
Message-ID: <YqyFIq8iv/FZ6tNe@pendragon.ideasonboard.com>
References: <20220617103645.71560-1-ribalda@chromium.org>
 <20220617103645.71560-3-ribalda@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220617103645.71560-3-ribalda@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

Thank you for the patch.

On Fri, Jun 17, 2022 at 12:36:39PM +0200, Ricardo Ribalda wrote:
> Some devices do not implement all their controls in a way that complies
> with the UVC specification. This is for instance the case for several
> devices that do not support the disabled mode for the power line
> frequency control. Add a mechanism to allow per-device control mapping
> overrides to avoid errors when accessing non-compliant controls.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 35 ++++++++++++++++++++++++++------
>  drivers/media/usb/uvc/uvcvideo.h |  1 +
>  2 files changed, 30 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index a709ebbb4d69..092decfdaa62 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -2403,9 +2403,8 @@ static void uvc_ctrl_init_ctrl(struct uvc_video_chain *chain,
>  {
>  	const struct uvc_control_info *info = uvc_ctrls;
>  	const struct uvc_control_info *iend = info + ARRAY_SIZE(uvc_ctrls);
> -	const struct uvc_control_mapping *mapping = uvc_ctrl_mappings;
> -	const struct uvc_control_mapping *mend =
> -		mapping + ARRAY_SIZE(uvc_ctrl_mappings);
> +	const struct uvc_control_mapping *mapping;
> +	const struct uvc_control_mapping *mend;
>  
>  	/* XU controls initialization requires querying the device for control
>  	 * information. As some buggy UVC devices will crash when queried
> @@ -2433,14 +2432,38 @@ static void uvc_ctrl_init_ctrl(struct uvc_video_chain *chain,
>  	if (!ctrl->initialized)
>  		return;
>  
> -	/* Process common mappings first. */
> -	for (; mapping < mend; ++mapping) {
> +	/*
> +	 * First check if the device provides a custom mapping for this control,
> +	 * used to override standard mappings for non-conformant devices. Don't
> +	 * process standard mappings if a custom mapping is found. This
> +	 * mechanism doesn't support combining standard and custom mappings for
> +	 * a single control.
> +	 */
> +	if (chain->dev->info->mappings) {
> +		bool custom = false;
> +		unsigned int i;
> +
> +		for (i = 0; (mapping = chain->dev->info->mappings[i]); ++i) {
> +			if (uvc_entity_match_guid(ctrl->entity, mapping->entity) &&
> +			    ctrl->info.selector == mapping->selector) {
> +				__uvc_ctrl_add_mapping(chain, ctrl, mapping);
> +				custom = true;
> +			}
> +		}
> +
> +		if (custom)
> +			return;
> +	}
> +
> +	/* Process common mappings next. */
> +	mend = mapping + ARRAY_SIZE(uvc_ctrl_mappings);

I don't think mapping has the right value here, it could even be
uninitialized. Let's make this

	mapping = uvc_ctrl_mappings;
	mend = mapping + ARRAY_SIZE(uvc_ctrl_mappings);

	for (; mapping < mend; ++mapping) {

to match the code below.

> +	for (mapping = uvc_ctrl_mappings; mapping < mend; ++mapping) {
>  		if (uvc_entity_match_guid(ctrl->entity, mapping->entity) &&
>  		    ctrl->info.selector == mapping->selector)
>  			__uvc_ctrl_add_mapping(chain, ctrl, mapping);
>  	}
>  
> -	/* And then version-specific mappings. */
> +	/* Finally process version-specific mappings. */
>  	if (chain->dev->uvc_version < 0x0150) {
>  		mapping = uvc_ctrl_mappings_uvc11;
>  		mend = mapping + ARRAY_SIZE(uvc_ctrl_mappings_uvc11);
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index c5b4febd2d94..fff5c5c99a3d 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -667,6 +667,7 @@ struct uvc_device_info {
>  	u32	quirks;
>  	u32	meta_format;
>  	u16	uvc_version;
> +	const struct uvc_control_mapping **mappings;
>  };
>  
>  struct uvc_device {

-- 
Regards,

Laurent Pinchart
