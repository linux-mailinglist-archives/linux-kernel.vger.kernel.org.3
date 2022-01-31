Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD164A4881
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 14:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240507AbiAaNnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 08:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiAaNnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 08:43:16 -0500
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54653C061714;
        Mon, 31 Jan 2022 05:43:15 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 8F55A200014;
        Mon, 31 Jan 2022 13:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643636592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fNzzdrv2WUeULNwAyESjeTV+GL3fcftB5PM2h9pueek=;
        b=McTkn4xGuStHaGZwMMzwEHdXEZ1ZTskZtYmiln/jpDbssu2slFXlEV0LkL+BjV1Csi94cy
        9TAoEDRKoFgK8o8b+26uxzMYFbqL3EsqyKjcjPu5iI+T7Dh6DRmHzr7zbhBvFvureek5L/
        9j/d0wKtOMG8f/th0CbBOcF/rGk46muyGCzJeghyKaqufm7fHi36K62rU+SDmKYBXbrqxM
        lIYN4k8ATVj/mEXwnVfqp0O0/aKlOqxLVb0U7umRvs6JOiIRznkOhckJWye/Uxd3p4i9Gl
        JYhRsEVxixoBHmncpmVbF2B8JcDv36S8ZniYGtWZ8dzuAUbt7c4aFH2KcxDIVA==
Date:   Mon, 31 Jan 2022 14:43:09 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christophe Kerello <christophe.kerello@foss.st.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>, <robh+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <chenshumin86@sina.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>
Subject: Re: [PATCH v2 4/4] mtd: core: Fix a conflict between MTD and NVMEM
 on wp-gpios property
Message-ID: <20220131144309.0ffe7cc8@xps13>
In-Reply-To: <20220131095755.8981-5-christophe.kerello@foss.st.com>
References: <20220131095755.8981-1-christophe.kerello@foss.st.com>
        <20220131095755.8981-5-christophe.kerello@foss.st.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vignesh, Tudory, Pratyush,

+ Tudor and Pratyush

christophe.kerello@foss.st.com wrote on Mon, 31 Jan 2022 10:57:55 +0100:

> Wp-gpios property can be used on NVMEM nodes and the same property can
> be also used on MTD NAND nodes. In case of the wp-gpios property is
> defined at NAND level node, the GPIO management is done at NAND driver
> level. Write protect is disabled when the driver is probed or resumed
> and is enabled when the driver is released or suspended.
>=20
> When no partitions are defined in the NAND DT node, then the NAND DT node
> will be passed to NVMEM framework. If wp-gpios property is defined in
> this node, the GPIO resource is taken twice and the NAND controller
> driver fails to probe.
>=20
> A new Boolean flag named skip_wp_gpio has been added in nvmem_config.
> In case skip_wp_gpio is set, it means that the GPIO is handled by the
> provider. Lets set this flag in MTD layer to avoid the conflict on
> wp_gpios property.
>=20
> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
> ---
>  drivers/mtd/mtdcore.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index 70f492dce158..e6d251594def 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -546,6 +546,7 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
>  	config.stride =3D 1;
>  	config.read_only =3D true;
>  	config.root_only =3D true;
> +	config.skip_wp_gpio =3D true;
>  	config.no_of_node =3D !of_device_is_compatible(node, "nvmem-cells");
>  	config.priv =3D mtd;
> =20
> @@ -833,6 +834,7 @@ static struct nvmem_device *mtd_otp_nvmem_register(st=
ruct mtd_info *mtd,
>  	config.owner =3D THIS_MODULE;
>  	config.type =3D NVMEM_TYPE_OTP;
>  	config.root_only =3D true;
> +	config.skip_wp_gpio =3D true;
>  	config.reg_read =3D reg_read;
>  	config.size =3D size;
>  	config.of_node =3D np;

TLDR: There is a conflict between MTD and NVMEM, who should handle the
WP pin when there is one? At least for raw NAND devices, I don't want
the NVMEM core to handle the wp pin. So we've introduced this
skip_wp_gpio nvmem config option. But there are two places where this
boolean can be set and one of these is for otp regions (see above). In
this case, I don't know if it is safe or if CFI/SPI-NOR rely on the
nvmem protection. Please tell us if you think this is fine for you.

Thanks,
Miqu=C3=A8l
