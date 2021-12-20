Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5483A47AE06
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 15:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236177AbhLTO5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 09:57:30 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:54846 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239025AbhLTOy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 09:54:58 -0500
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 613FCB9C;
        Mon, 20 Dec 2021 15:54:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1640012096;
        bh=/guRRmIERl/qLzatv9YDpEOMXqaanjVtGvX/PBxiWRA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=g7P6bDMUQcLcXYfXzz6ctYt+YXhWqJxnOiald35pv5ivVeulQfIlBGhSCMZQLq/9A
         NYbDxkmEVdnA4RyaL4K0dZAe6g0tXzHs5uyyLmIFdnjOjghon0RZ4GK6/QWWjD/VcA
         WxMJn/0io3UiRUDnPbvpK6NZ7hlqnI+CqE8/z0UU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211218182804.208906-1-antonio.borneo@foss.st.com>
References: <20211218182804.208906-1-antonio.borneo@foss.st.com>
Subject: Re: [PATCH] drm: adv7511: override i2c address of cec before accessing it
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     Antonio Borneo <antonio.borneo@foss.st.com>,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Antonio Borneo <antonio.borneo@foss.st.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel@lists.freedesktop.org
Date:   Mon, 20 Dec 2021 14:54:54 +0000
Message-ID: <164001209406.2512616.469307346369770543@Monstersaurus>
User-Agent: alot/0.10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Antonio,

Quoting Antonio Borneo (2021-12-18 18:28:04)
> Commit 680532c50bca ("drm: adv7511: Add support for
> i2c_new_secondary_device") allows a device tree node to override
> the default addresses of the secondary i2c devices. This is useful
> for solving address conflicts on the i2c bus.
>=20
> In adv7511_init_cec_regmap() the new i2c address of cec device is
> read from device tree and immediately accessed, well before it is
> written in the proper register to override the default address.
> This can cause an i2c error during probe and a consequent probe
> failure.

Ouch, it does seem that way. I guess no one has used the CEC for quite
some time, as it must have been like this for a while?

> Once the new i2c address is read from the device tree, override
> the default address before any attempt to access the cec.

Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

> Tested with adv7533 and stm32mp157f.
>=20
> Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
> Fixes: 680532c50bca ("drm: adv7511: Add support for i2c_new_secondary_dev=
ice")
> ---
> To: Andrzej Hajda <a.hajda@samsung.com>
> To: Neil Armstrong <narmstrong@baylibre.com>
> To: Robert Foss <robert.foss@linaro.org>
> To: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> To: Jonas Karlman <jonas@kwiboo.se>
> To: Jernej Skrabec <jernej.skrabec@gmail.com>
> To: David Airlie <airlied@linux.ie>
> To: Daniel Vetter <daniel@ffwll.ch>
> To: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> To: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-stm32@st-md-mailman.stormreply.com
> ---
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/d=
rm/bridge/adv7511/adv7511_drv.c
> index 76555ae64e9c..629e05286fd9 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> @@ -1048,6 +1048,10 @@ static int adv7511_init_cec_regmap(struct adv7511 =
*adv)
>                                                 ADV7511_CEC_I2C_ADDR_DEFA=
ULT);
>         if (IS_ERR(adv->i2c_cec))
>                 return PTR_ERR(adv->i2c_cec);
> +
> +       regmap_write(adv->regmap, ADV7511_REG_CEC_I2C_ADDR,
> +                    adv->i2c_cec->addr << 1);
> +
>         i2c_set_clientdata(adv->i2c_cec, adv);
> =20
>         adv->regmap_cec =3D devm_regmap_init_i2c(adv->i2c_cec,
> @@ -1252,9 +1256,6 @@ static int adv7511_probe(struct i2c_client *i2c, co=
nst struct i2c_device_id *id)
>         if (ret)
>                 goto err_i2c_unregister_packet;
> =20
> -       regmap_write(adv7511->regmap, ADV7511_REG_CEC_I2C_ADDR,
> -                    adv7511->i2c_cec->addr << 1);
> -
>         INIT_WORK(&adv7511->hpd_work, adv7511_hpd_work);
> =20
>         if (i2c->irq) {
>=20
> base-commit: fc74881c28d314b10efac016ef49df4ff40b8b97
> --=20
> 2.34.1
>
