Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638B44D3169
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 16:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbiCIPFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 10:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbiCIPFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 10:05:32 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB4914D259;
        Wed,  9 Mar 2022 07:04:32 -0800 (PST)
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 505268C4;
        Wed,  9 Mar 2022 16:04:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1646838270;
        bh=gq6PcsAoQxhIfL4EM3xCongxEseifjmoDcqpLyOPPLY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=AjG7FtuGePYveAiWSlQ+5TdVC0gyRdXY+lvnOD/kAjo3oxXRvI4n+OhIlAQWjq1pD
         /3QbFegHtqK8+JnbYYg/eMOdW8T1+AKNgTltOkjTZd8CWBGemeAAmA6g5Q9ofviAA8
         +ia5YAxadRN+tFGpNNgwYWz5LFH/TLe3H+vwoc1A=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220309115507.30019-1-laurentiu.palcu@oss.nxp.com>
References: <20220309115507.30019-1-laurentiu.palcu@oss.nxp.com>
Subject: Re: [PATCH v2] media: i2c: rdacm2x: properly set subdev entity function
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Niklas =?utf-8?q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Rob Herring <robh@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Date:   Wed, 09 Mar 2022 15:04:28 +0000
Message-ID: <164683826808.123014.1703937676440784435@Monstersaurus>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Laurentiu Palcu (2022-03-09 11:55:06)
> The subdevice entity function was left unset, which produces a warning
> when probing the device:
>=20
> mxc-md bus@58000000:camera: Entity type for entity rdacm20 19-0051 was
> not initialized!
>=20
> This patch will set entity function to MEDIA_ENT_F_CAM_SENSOR and leave
> flags unset.
>=20
> Fixes: 34009bffc1c6 ("media: i2c: Add RDACM20 driver")
> Fixes: a59f853b3b4b ("media: i2c: Add driver for RDACM21 camera module")

Ohh, I've never seen a use case for two fixes tags before.
I don't think this requires two patches to implement the fix though.

Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> ---
> Changes in v2:
>         * leave entity flags unset;
>=20
> Cheers,
> Laurentiu
>=20
>  drivers/media/i2c/rdacm20.c | 2 +-
>  drivers/media/i2c/rdacm21.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/media/i2c/rdacm20.c b/drivers/media/i2c/rdacm20.c
> index 025a610de893..9c6f66cab564 100644
> --- a/drivers/media/i2c/rdacm20.c
> +++ b/drivers/media/i2c/rdacm20.c
> @@ -611,7 +611,7 @@ static int rdacm20_probe(struct i2c_client *client)
>                 goto error_free_ctrls;
> =20
>         dev->pad.flags =3D MEDIA_PAD_FL_SOURCE;
> -       dev->sd.entity.flags |=3D MEDIA_ENT_F_CAM_SENSOR;
> +       dev->sd.entity.function =3D MEDIA_ENT_F_CAM_SENSOR;
>         ret =3D media_entity_pads_init(&dev->sd.entity, 1, &dev->pad);
>         if (ret < 0)
>                 goto error_free_ctrls;
> diff --git a/drivers/media/i2c/rdacm21.c b/drivers/media/i2c/rdacm21.c
> index 12ec5467ed1e..ef31cf5f23ca 100644
> --- a/drivers/media/i2c/rdacm21.c
> +++ b/drivers/media/i2c/rdacm21.c
> @@ -583,7 +583,7 @@ static int rdacm21_probe(struct i2c_client *client)
>                 goto error_free_ctrls;
> =20
>         dev->pad.flags =3D MEDIA_PAD_FL_SOURCE;
> -       dev->sd.entity.flags |=3D MEDIA_ENT_F_CAM_SENSOR;
> +       dev->sd.entity.function =3D MEDIA_ENT_F_CAM_SENSOR;
>         ret =3D media_entity_pads_init(&dev->sd.entity, 1, &dev->pad);
>         if (ret < 0)
>                 goto error_free_ctrls;
> --=20
> 2.17.1
>
