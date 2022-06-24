Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C5B55A18B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 21:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbiFXTA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 15:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbiFXTAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 15:00:19 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1F081C5C;
        Fri, 24 Jun 2022 12:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1656097215; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=THNfze9JEECbMTbkniNl4WxsrwffazR6yHW49pczds4=;
        b=K941P0DpIoJDcsyNQjtu54obkjlHXfjLrCJBJoMhBy8bzMbVZkEcE5OXtUNtK5CFnOQVkC
        6PUACCO5JqQSInC01JnI685UZIAKzhA5KZvrb3V5xUdLntYxsH1Uu/73nVZ7r6AM66/277
        4NZVnmpuPNbMaBbBZIo99FOznMgIXUY=
Date:   Fri, 24 Jun 2022 20:00:05 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] drm/ingenic: Use resource_size function on resource
 object
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, linux-mips@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>
Message-Id: <5SWZDR.5KODQDXQB5142@crapouillou.net>
In-Reply-To: <20220624013159.88646-1-jiapeng.chong@linux.alibaba.com>
References: <20220624013159.88646-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le ven., juin 24 2022 at 09:31:59 +0800, Jiapeng Chong=20
<jiapeng.chong@linux.alibaba.com> a =E9crit :
> This was found by coccicheck:
>=20
> ./drivers/gpu/drm/ingenic/ingenic-drm-drv.c:1149:35-38: WARNING:=20
> Suspicious code. resource_size is maybe missing with res.
>=20
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c=20
> b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> index 2c559885347a..5514b163999f 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> @@ -1146,7 +1146,7 @@ static int ingenic_drm_bind(struct device *dev,=20
> bool has_components)
>  	}
>=20
>  	regmap_config =3D ingenic_drm_regmap_config;
> -	regmap_config.max_register =3D res->end - res->start;
> +	regmap_config.max_register =3D resource_size(res);

These two are not equivalent. resource_size() is (res->end - res->start=20
+ 1).

If the memory resource has a size of 0x10 bytes, then using=20
resource_size() will set .max_register =3D=3D 0x10, which is invalid, as it=
=20
is already outside the memory resource.

Cheers,
-Paul


>  	priv->map =3D devm_regmap_init_mmio(dev, base,
>  					  &regmap_config);
>  	if (IS_ERR(priv->map)) {
> --
> 2.20.1.7.g153144c
>=20


