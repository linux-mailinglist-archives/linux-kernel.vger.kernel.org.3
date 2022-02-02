Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B380B4A6F44
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 11:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241156AbiBBK51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 05:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiBBK50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 05:57:26 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8D8C061714;
        Wed,  2 Feb 2022 02:57:26 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3B0A0C0009;
        Wed,  2 Feb 2022 10:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643799444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JA/sZXpu8XHNvzUk8TEDPhep6Z0mt6Duy6phBKTReYU=;
        b=TX5doXrF/JBQ54Tc79wsM5qT3CZrwggUxoF/xgbHc9hJEhDSdCns/YfQ8HiExBZNVEFESV
        SKeuvCG/acR14pAlV7SyBD1ARPkCO28KgmjdqRbAvkdfezkKtb43pPajsogLUXqdWvLvnJ
        biW4noF3zmpE+YGVm7Nmidp/v/fEq4gZqdIPQncBzX3LQpvJdsZiruGQRNXrJ9gWJAEaiC
        6MbuxMj/j8XoI5vDv1Elpn1lWS8olUBTYJxlszPQL8OzhugfJLkGDWNRCV2iSfFHPqVKq1
        g/VPHDrWPa8w2QVlsOWK7U+W1LpFnhOAJxeArbCUA2d+OuqnMprDQJ/z5J6cCA==
Date:   Wed, 2 Feb 2022 11:57:20 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christophe Kerello <christophe.kerello@foss.st.com>
Cc:     Pratyush Yadav <p.yadav@ti.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <robh+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <chenshumin86@sina.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH v2 4/4] mtd: core: Fix a conflict between MTD and NVMEM
 on wp-gpios property
Message-ID: <20220202115720.741a0139@xps13>
In-Reply-To: <eebfa629-ead2-d63f-9cfb-4cafc1534678@foss.st.com>
References: <20220131095755.8981-1-christophe.kerello@foss.st.com>
        <20220131095755.8981-5-christophe.kerello@foss.st.com>
        <20220131144309.0ffe7cc8@xps13>
        <20220201104727.7xvcyexf3yucegcb@ti.com>
        <eebfa629-ead2-d63f-9cfb-4cafc1534678@foss.st.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

christophe.kerello@foss.st.com wrote on Wed, 2 Feb 2022 11:44:31 +0100:

> Hi,
>=20
> On 2/1/22 11:47, Pratyush Yadav wrote:
> > On 31/01/22 02:43PM, Miquel Raynal wrote: =20
> >> Hi Vignesh, Tudory, Pratyush,
> >>
> >> + Tudor and Pratyush
> >>
> >> christophe.kerello@foss.st.com wrote on Mon, 31 Jan 2022 10:57:55 +010=
0:
> >> =20
> >>> Wp-gpios property can be used on NVMEM nodes and the same property can
> >>> be also used on MTD NAND nodes. In case of the wp-gpios property is
> >>> defined at NAND level node, the GPIO management is done at NAND driver
> >>> level. Write protect is disabled when the driver is probed or resumed
> >>> and is enabled when the driver is released or suspended.
> >>>
> >>> When no partitions are defined in the NAND DT node, then the NAND DT =
node
> >>> will be passed to NVMEM framework. If wp-gpios property is defined in
> >>> this node, the GPIO resource is taken twice and the NAND controller
> >>> driver fails to probe.
> >>>
> >>> A new Boolean flag named skip_wp_gpio has been added in nvmem_config.
> >>> In case skip_wp_gpio is set, it means that the GPIO is handled by the
> >>> provider. Lets set this flag in MTD layer to avoid the conflict on
> >>> wp_gpios property.
> >>>
> >>> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
> >>> ---
> >>>   drivers/mtd/mtdcore.c | 2 ++
> >>>   1 file changed, 2 insertions(+)
> >>>
> >>> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> >>> index 70f492dce158..e6d251594def 100644
> >>> --- a/drivers/mtd/mtdcore.c
> >>> +++ b/drivers/mtd/mtdcore.c
> >>> @@ -546,6 +546,7 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
> >>>   	config.stride =3D 1;
> >>>   	config.read_only =3D true;
> >>>   	config.root_only =3D true;
> >>> +	config.skip_wp_gpio =3D true;
> >>>   	config.no_of_node =3D !of_device_is_compatible(node, "nvmem-cells"=
);
> >>>   	config.priv =3D mtd; =20
> >>>   >>> @@ -833,6 +834,7 @@ static struct nvmem_device *mtd_otp_nvmem_r=
egister(struct mtd_info *mtd, =20
> >>>   	config.owner =3D THIS_MODULE;
> >>>   	config.type =3D NVMEM_TYPE_OTP;
> >>>   	config.root_only =3D true;
> >>> +	config.skip_wp_gpio =3D true;
> >>>   	config.reg_read =3D reg_read;
> >>>   	config.size =3D size;
> >>>   	config.of_node =3D np; =20
> >>
> >> TLDR: There is a conflict between MTD and NVMEM, who should handle the
> >> WP pin when there is one? At least for raw NAND devices, I don't want
> >> the NVMEM core to handle the wp pin. So we've introduced this
> >> skip_wp_gpio nvmem config option. But there are two places where this
> >> boolean can be set and one of these is for otp regions (see above). In
> >> this case, I don't know if it is safe or if CFI/SPI-NOR rely on the
> >> nvmem protection. Please tell us if you think this is fine for you. =20
> >=20
> > Why does NVMEM touch hardware write protection in the first place? The
> > purpose of the framework is to provide a way to retrieve config stored
> > in memory. It has no business dealing with details of the chip like the
> > WP line. That should be MTD's job (which it should delegate to SPI NOR,
> > SPI NAND, etc.). If you want to write protect a cell then do it in
> > software. I don't see why NVMEM should be dealing with hardware directly
> > at all.
> >=20
> > That is my mental model of how things _should_ work. I have not spent
> > much time digging into how things actually work currently.
> >  =20
>=20
> Wp-gpios property management was added in MVMEM framework in January 2020=
 =3D> sha1: 2a127da461a9d8d97782d6e82b227041393eb4d2
> "
>      nvmem: add support for the write-protect pin

Perhaps this could be pointed as part of a Fixes tag, because this
might actually break other users which we haven't noticed yet.

>=20
>      The write-protect pin handling looks like a standard property that
>      could benefit other users if available in the core nvmem framework.
>=20
>      Instead of modifying all the memory drivers to check this pin, make
>      the NVMEM subsystem check if the write-protect GPIO being passed
>      through the nvmem_config or defined in the device tree and pull it
>      low whenever writing to the memory.
> "
>=20
> And this modification was done for EEPROMs flashes =3D> sha1: 1c89074bf85=
068d1b86f2e0f0c2110fdd9b83c9f
> "
>      eeprom: at24: remove the write-protect pin support
>=20
>      NVMEM framework is an interface for the at24 EEPROMs as well as for
>      other drivers, instead of passing the wp-gpios over the different
>      drivers each time, it would be better to pass it over the NVMEM
>      subsystem once and for all.
>=20
>      Removing the support for the write-protect pin after adding it to
>      the NVMEM subsystem.
> "
>=20
> Current NVMEM framework implementation toggles the WP GPIO when reg_write=
 nvmem_config API is defined. In case of MTD framework, reg_write is not de=
fined in nvmem_config.
>=20
> Based on the comments made, it seems that we also agree that this write p=
rotection should be handled by MTD subsystems or associated drivers and not=
 by MVMEN framework for MTD use cases.
>=20
> The proposal implementation should solve this conflict for MTD framework =
without breaking anything for others NVMEM users (EEPROMs flashes for examp=
le).

I'm not sure neither why EEPROM flashes decided to delegate the
wp handling to NVMEM, but in any case we don't want it to be
handled at NVMEM level in the case of MTD, so your series looks fine to
me.

>=20
> Regards,
> Christophe Kerello.
>=20
>=20


Thanks,
Miqu=C3=A8l
