Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019224F5E70
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbiDFM5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiDFM4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:56:48 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D031A61CA;
        Wed,  6 Apr 2022 01:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1649235406; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YEZzm96WsgNKWPm41tm0nV++Aa+9P3fevYoGMhYP/zw=;
        b=K+QzKAh62GkPKnK6Gcgil9rxSfp1+cvt8KVYpFNbuVCaJH7XGTYwPrKQ3lC7uwqNN8o536
        3JB6vTsSqYEFI1tFPO+F5hs2nPadagcbo0of12TC1/Y+AvX3xXOncEdw7MmSOglpKij/Vg
        BEoimLtYd35UCWOAMqeHaRsgdOEH7sg=
Date:   Wed, 06 Apr 2022 09:56:31 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: linux-next: build failure after merge of the drm-misc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Message-Id: <76UW9R.TLZ8ZU2LVHZW2@crapouillou.net>
In-Reply-To: <20220406105049.5f5e01c1@canb.auug.org.au>
References: <20220406105049.5f5e01c1@canb.auug.org.au>
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

Hi Stephen,

Le mer., avril 6 2022 at 10:50:49 +1000, Stephen Rothwell=20
<sfr@canb.auug.org.au> a =E9crit :
> Hi all,
>=20
> After merging the drm-misc tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> drivers/gpu/drm/panel/panel-newvision-nv3052c.c:478:19: error:=20
> initialization of 'void (*)(struct spi_device *)' from incompatible=20
> pointer type 'int (*)(struct spi_device *)'=20
> [-Werror=3Dincompatible-pointer-types]
>   478 |         .remove =3D nv3052c_remove,
>       |                   ^~~~~~~~~~~~~~
> drivers/gpu/drm/panel/panel-newvision-nv3052c.c:478:19: note: (near=20
> initialization for 'nv3052c_driver.remove')
>=20
> Caused by commit
>=20
>   49956b505c53 ("drm/panel: Add panel driver for NewVision NV3052C=20
> based LCDs")
>=20
> interacting with commit
>=20
>   2cbfa2128662 ("spi: make remove callback a void function")
>=20
> from Linus' tree (merged in v5.18-rc1).
>=20
> I applied the following merge resolution patch for today.

Sorry about that, my fault.

I compile-tested Christophe's patchset *then* rebased to the latest=20
drm-misc-next and pushed, should have done the other way around.

-Paul

> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Wed, 6 Apr 2022 10:46:57 +1000
> Subject: [PATCH] fixup for "spi: make remove callback a void function"
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/gpu/drm/panel/panel-newvision-nv3052c.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panel/panel-newvision-nv3052c.c=20
> b/drivers/gpu/drm/panel/panel-newvision-nv3052c.c
> index 127bcfdb59df..cf078f0d3cd3 100644
> --- a/drivers/gpu/drm/panel/panel-newvision-nv3052c.c
> +++ b/drivers/gpu/drm/panel/panel-newvision-nv3052c.c
> @@ -416,15 +416,13 @@ static int nv3052c_probe(struct spi_device *spi)
>  	return 0;
>  }
>=20
> -static int nv3052c_remove(struct spi_device *spi)
> +static void nv3052c_remove(struct spi_device *spi)
>  {
>  	struct nv3052c *priv =3D spi_get_drvdata(spi);
>=20
>  	drm_panel_remove(&priv->panel);
>  	drm_panel_disable(&priv->panel);
>  	drm_panel_unprepare(&priv->panel);
> -
> -	return 0;
>  }
>=20
>  static const struct drm_display_mode ltk035c5444t_modes[] =3D {
> --
> 2.35.1
>=20
> --
> Cheers,
> Stephen Rothwell


