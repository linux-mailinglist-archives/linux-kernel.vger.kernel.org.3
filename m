Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11994D2AC6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 09:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbiCIIoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 03:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbiCIIoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 03:44:19 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B399B7C77;
        Wed,  9 Mar 2022 00:43:19 -0800 (PST)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 936BBC0014;
        Wed,  9 Mar 2022 08:43:12 +0000 (UTC)
Date:   Wed, 9 Mar 2022 09:43:11 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: i2c: rdacm2x: properly set subdev entity function
Message-ID: <20220309084311.vn3awybkxzxd32i4@uno.localdomain>
References: <20220308125549.9676-1-laurentiu.palcu@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220308125549.9676-1-laurentiu.palcu@oss.nxp.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurentiu,

On Tue, Mar 08, 2022 at 02:55:49PM +0200, Laurentiu Palcu wrote:
> The subdevice entity function was left unset, which produces a warning
> when probing the device:
>
> mxc-md bus@58000000:camera: Entity type for entity rdacm20 19-0051 was
> not initialized!
>
> Also, set the entity flags to MEDIA_ENT_FL_DEFAULT instead of
> MEDIA_ENT_F_CAM_SENSOR which will be used for entity's function instead.
>
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> ---
> Hi,
>
> Only tested the rdacm20 part but I believe rdacm21 should work as well.
>
> Cheers,
> laurentiu
>
>  drivers/media/i2c/rdacm20.c | 3 ++-
>  drivers/media/i2c/rdacm21.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/i2c/rdacm20.c b/drivers/media/i2c/rdacm20.c
> index 025a610de893..ea5b7d5151ee 100644
> --- a/drivers/media/i2c/rdacm20.c
> +++ b/drivers/media/i2c/rdacm20.c
> @@ -611,7 +611,8 @@ static int rdacm20_probe(struct i2c_client *client)
>  		goto error_free_ctrls;
>
>  	dev->pad.flags = MEDIA_PAD_FL_SOURCE;
> -	dev->sd.entity.flags |= MEDIA_ENT_F_CAM_SENSOR;
> +	dev->sd.entity.flags |= MEDIA_ENT_FL_DEFAULT;

I'm not sure if setting the DEFAULT flag is right:

 * %MEDIA_ENT_FL_DEFAULT
 *    indicates the default entity for a given type.
 *    This can be used to report the default audio and video devices or the
 *    default camera sensor.

In a typical setup there will be several RDACM2x in use, marking all
of them as "default" seems not right (if I understood the flag
description right).


> +	dev->sd.entity.function = MEDIA_ENT_F_CAM_SENSOR;

This seems right, and it's probably worth a Fixes tag?

Thanks
   j

>  	ret = media_entity_pads_init(&dev->sd.entity, 1, &dev->pad);
>  	if (ret < 0)
>  		goto error_free_ctrls;
> diff --git a/drivers/media/i2c/rdacm21.c b/drivers/media/i2c/rdacm21.c
> index 12ec5467ed1e..be89bd43e88b 100644
> --- a/drivers/media/i2c/rdacm21.c
> +++ b/drivers/media/i2c/rdacm21.c
> @@ -583,7 +583,8 @@ static int rdacm21_probe(struct i2c_client *client)
>  		goto error_free_ctrls;
>
>  	dev->pad.flags = MEDIA_PAD_FL_SOURCE;
> -	dev->sd.entity.flags |= MEDIA_ENT_F_CAM_SENSOR;
> +	dev->sd.entity.flags |= MEDIA_ENT_FL_DEFAULT;
> +	dev->sd.entity.function = MEDIA_ENT_F_CAM_SENSOR;
>  	ret = media_entity_pads_init(&dev->sd.entity, 1, &dev->pad);
>  	if (ret < 0)
>  		goto error_free_ctrls;
> --
> 2.33.0
>
