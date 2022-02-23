Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CD24C196E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 18:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243173AbiBWRG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 12:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243188AbiBWRGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 12:06:24 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DB55372C;
        Wed, 23 Feb 2022 09:05:56 -0800 (PST)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 14AB31C000A;
        Wed, 23 Feb 2022 17:05:52 +0000 (UTC)
Date:   Wed, 23 Feb 2022 18:05:51 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     linux-media@vger.kernel.org, hverkuil-cisco@xs4all.nl,
        nicolas.ferre@microchip.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        claudiu.beznea@microchip.com, Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH v5 02/13] media: atmel: atmel-isc-base: replace
 is_streaming call in s_fmt_vid_cap
Message-ID: <20220223170551.6wbehkwjsddfzg5h@uno.localdomain>
References: <20220217135645.1427466-1-eugen.hristev@microchip.com>
 <20220217135645.1427466-3-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220217135645.1427466-3-eugen.hristev@microchip.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugen

On Thu, Feb 17, 2022 at 03:56:34PM +0200, Eugen Hristev wrote:
> In s_fmt_vid_cap, we should check if vb2_is_busy and return EBUSY,
> not check if it's streaming to return the busy state.
>
> Suggested-by: Hans Verkuil <hverkuil@xs4all.nl>
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>

Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>

Thanks
   j

> ---
>  drivers/media/platform/atmel/atmel-isc-base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/atmel/atmel-isc-base.c b/drivers/media/platform/atmel/atmel-isc-base.c
> index d2cc6c99984f..67b4a2323fed 100644
> --- a/drivers/media/platform/atmel/atmel-isc-base.c
> +++ b/drivers/media/platform/atmel/atmel-isc-base.c
> @@ -1029,7 +1029,7 @@ static int isc_s_fmt_vid_cap(struct file *file, void *priv,
>  {
>  	struct isc_device *isc = video_drvdata(file);
>
> -	if (vb2_is_streaming(&isc->vb2_vidq))
> +	if (vb2_is_busy(&isc->vb2_vidq))
>  		return -EBUSY;
>
>  	return isc_set_fmt(isc, f);
> --
> 2.25.1
>
