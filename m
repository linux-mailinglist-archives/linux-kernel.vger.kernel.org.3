Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02374D307D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 14:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbiCINvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 08:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbiCINvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 08:51:06 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25FE15042A;
        Wed,  9 Mar 2022 05:50:07 -0800 (PST)
Received: (Authenticated sender: jacopo@jmondi.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 9EBDCC000A;
        Wed,  9 Mar 2022 13:50:03 +0000 (UTC)
Date:   Wed, 9 Mar 2022 14:50:01 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] media: i2c: rdacm2x: properly set subdev entity
 function
Message-ID: <20220309135001.gsffmzd7qezyib2c@uno.localdomain>
References: <20220309115507.30019-1-laurentiu.palcu@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220309115507.30019-1-laurentiu.palcu@oss.nxp.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurentiu

On Wed, Mar 09, 2022 at 01:55:06PM +0200, Laurentiu Palcu wrote:
> The subdevice entity function was left unset, which produces a warning
> when probing the device:
>
> mxc-md bus@58000000:camera: Entity type for entity rdacm20 19-0051 was
> not initialized!
>
> This patch will set entity function to MEDIA_ENT_F_CAM_SENSOR and leave
> flags unset.
>
> Fixes: 34009bffc1c6 ("media: i2c: Add RDACM20 driver")
> Fixes: a59f853b3b4b ("media: i2c: Add driver for RDACM21 camera module")
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>

Thanks!

Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

> ---
> Changes in v2:
> 	* leave entity flags unset;
>
> Cheers,
> Laurentiu
>
>  drivers/media/i2c/rdacm20.c | 2 +-
>  drivers/media/i2c/rdacm21.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/i2c/rdacm20.c b/drivers/media/i2c/rdacm20.c
> index 025a610de893..9c6f66cab564 100644
> --- a/drivers/media/i2c/rdacm20.c
> +++ b/drivers/media/i2c/rdacm20.c
> @@ -611,7 +611,7 @@ static int rdacm20_probe(struct i2c_client *client)
>  		goto error_free_ctrls;
>
>  	dev->pad.flags = MEDIA_PAD_FL_SOURCE;
> -	dev->sd.entity.flags |= MEDIA_ENT_F_CAM_SENSOR;
> +	dev->sd.entity.function = MEDIA_ENT_F_CAM_SENSOR;
>  	ret = media_entity_pads_init(&dev->sd.entity, 1, &dev->pad);
>  	if (ret < 0)
>  		goto error_free_ctrls;
> diff --git a/drivers/media/i2c/rdacm21.c b/drivers/media/i2c/rdacm21.c
> index 12ec5467ed1e..ef31cf5f23ca 100644
> --- a/drivers/media/i2c/rdacm21.c
> +++ b/drivers/media/i2c/rdacm21.c
> @@ -583,7 +583,7 @@ static int rdacm21_probe(struct i2c_client *client)
>  		goto error_free_ctrls;
>
>  	dev->pad.flags = MEDIA_PAD_FL_SOURCE;
> -	dev->sd.entity.flags |= MEDIA_ENT_F_CAM_SENSOR;
> +	dev->sd.entity.function = MEDIA_ENT_F_CAM_SENSOR;
>  	ret = media_entity_pads_init(&dev->sd.entity, 1, &dev->pad);
>  	if (ret < 0)
>  		goto error_free_ctrls;
> --
> 2.17.1
>
