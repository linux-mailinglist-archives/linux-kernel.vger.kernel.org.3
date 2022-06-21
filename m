Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312215532AC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 14:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351115AbiFUM7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 08:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351153AbiFUM6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 08:58:36 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7312A2;
        Tue, 21 Jun 2022 05:58:34 -0700 (PDT)
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6800B104;
        Tue, 21 Jun 2022 14:58:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1655816312;
        bh=QeBzIO+U3oKdldlfZMcuLeVK7EiSrArkPksFp8cBSkM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=OO5/5+9Yhc4qSTux6Py6LT4Iy9hqrC9FAcbdk89g+PfRJ9mfNx/9LXQfiVqPfMl6B
         l/HtiR7/BVJjXnB3PuCTdJ9rho2pL2COKVqdaXTmuizWOt9m7IN1wjsDio7LVg3ePB
         sCpnfC6Tove2EPl7XyJUAFnmnCL1okn8xaSvBPgs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220616170821.1348169-1-steve@sk2.org>
References: <20220616170821.1348169-1-steve@sk2.org>
Subject: Re: [PATCH v2] drm: shmobile: Use backlight helper
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     Stephen Kitt <steve@sk2.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Stephen Kitt <steve@sk2.org>
Date:   Tue, 21 Jun 2022 13:58:29 +0100
Message-ID: <165581630958.18145.12909267841116831017@Monstersaurus>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Kitt (2022-06-16 18:08:21)
> This started with work on the removal of backlight_properties'
> deprecated fb_blank field, much of which can be taken care of by using
> helper functions provided by backlight.h instead of directly accessing
> fields in backlight_properties. This patch series doesn't involve
> fb_blank, but it still seems useful to use helper functions where
> appropriate.
>=20
> Instead of retrieving the backlight brightness in struct
> backlight_properties manually, and then checking whether the backlight
> should be on at all, use backlight_get_brightness() which does all
> this and insulates this from future changes.
>=20
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>


Hi Stephen,

This looks reasonable to me too.

Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> ---
> Changes since v1: clarified commit message, this doesn't touch fb_blank
> ---
>  drivers/gpu/drm/shmobile/shmob_drm_backlight.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/shmobile/shmob_drm_backlight.c b/drivers/gpu=
/drm/shmobile/shmob_drm_backlight.c
> index f6628a5ee95f..794573badfe8 100644
> --- a/drivers/gpu/drm/shmobile/shmob_drm_backlight.c
> +++ b/drivers/gpu/drm/shmobile/shmob_drm_backlight.c
> @@ -18,11 +18,7 @@ static int shmob_drm_backlight_update(struct backlight=
_device *bdev)
>         struct shmob_drm_connector *scon =3D bl_get_data(bdev);
>         struct shmob_drm_device *sdev =3D scon->connector.dev->dev_privat=
e;
>         const struct shmob_drm_backlight_data *bdata =3D &sdev->pdata->ba=
cklight;
> -       int brightness =3D bdev->props.brightness;
> -
> -       if (bdev->props.power !=3D FB_BLANK_UNBLANK ||
> -           bdev->props.state & BL_CORE_SUSPENDED)
> -               brightness =3D 0;
> +       int brightness =3D backlight_get_brightness(bdev);
> =20
>         return bdata->set_brightness(brightness);
>  }
>=20
> base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
> --=20
> 2.30.2
>
