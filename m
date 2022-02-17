Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2B84B9B6D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 09:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238020AbiBQIsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 03:48:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235672AbiBQIsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 03:48:42 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A47E2A2286;
        Thu, 17 Feb 2022 00:48:26 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8A1A3C0003;
        Thu, 17 Feb 2022 08:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645087704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bkwv3ADXYTR6oqmLTt5vm/dXewEtDiujJ4xXuyIbJ7c=;
        b=V4pi27X+WUd5r213i03Yup6cBs1UF+AKK0i2TOOuw1wS0AeTlrrWmsfBFUbBS6RpncfXlH
        KuByUSoQ91BOJsN3atyoshfp19oA/59SlxTxxgeh2lqW9DVkKBTQr/G9//Tlup4PhFhfxK
        q20dZd2DY0F0vCi48CwTgasC5Jewy2Wu58jqiBMrSeAHjNChy8h0jDyaBYODjPMh1042G+
        GD26I3VR3NSL0c9gxY4U9Pnb+UoWnEj/bexTsiQH2x0XA8TFMXJXYdybtw2NnrUvOR28EL
        JaJkmU7cclpkvqYfTlxHcy7gdbALryG6dbheKr7uMbIdNC+BS33yyq4mCqTF4g==
Date:   Thu, 17 Feb 2022 09:48:19 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Christophe Kerello <christophe.kerello@foss.st.com>,
        Pratyush Yadav <p.yadav@ti.com>, richard@nod.at,
        vigneshr@ti.com, robh+dt@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org, chenshumin86@sina.com,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Khouloud Touil <ktouil@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 4/4] mtd: core: Fix a conflict between MTD and NVMEM
 on wp-gpios property
Message-ID: <20220217094819.2548a25e@xps13>
In-Reply-To: <d1000482-5385-c6f1-d10e-e5396218e0ea@linaro.org>
References: <20220131095755.8981-1-christophe.kerello@foss.st.com>
        <20220131095755.8981-5-christophe.kerello@foss.st.com>
        <20220131144309.0ffe7cc8@xps13>
        <20220201104727.7xvcyexf3yucegcb@ti.com>
        <eebfa629-ead2-d63f-9cfb-4cafc1534678@foss.st.com>
        <20220202115327.53oqg5n7tx6b6q7u@ti.com>
        <f6687807-607c-f672-2394-ad463735d597@foss.st.com>
        <d1000482-5385-c6f1-d10e-e5396218e0ea@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

srinivas.kandagatla@linaro.org wrote on Wed, 16 Feb 2022 09:24:29 +0000:

> On 16/02/2022 08:46, Christophe Kerello wrote:
> > Hi Miquel, Pratyush, Srinivas,
> >=20
> > On 2/2/22 12:53, Pratyush Yadav wrote: =20
> >> + Khouloud, Linus, Bartosz
> >>
> >> On 02/02/22 11:44AM, Christophe Kerello wrote: =20
> >>> Hi,
> >>>
> >>> On 2/1/22 11:47, Pratyush Yadav wrote: =20
> >>>> On 31/01/22 02:43PM, Miquel Raynal wrote: =20
> >>>>> Hi Vignesh, Tudory, Pratyush,
> >>>>>
> >>>>> + Tudor and Pratyush
> >>>>>
> >>>>> christophe.kerello@foss.st.com wrote on Mon, 31 Jan 2022 10:57:55 >=
>>>> +0100:
> >>>>> =20
> >>>>>> Wp-gpios property can be used on NVMEM nodes and the same property=
 >>>>>> can
> >>>>>> be also used on MTD NAND nodes. In case of the wp-gpios property is
> >>>>>> defined at NAND level node, the GPIO management is done at NAND >>=
>>>> driver
> >>>>>> level. Write protect is disabled when the driver is probed or resu=
med
> >>>>>> and is enabled when the driver is released or suspended.
> >>>>>>
> >>>>>> When no partitions are defined in the NAND DT node, then the NAND =
>>>>>> DT node
> >>>>>> will be passed to NVMEM framework. If wp-gpios property is defined=
 in
> >>>>>> this node, the GPIO resource is taken twice and the NAND controller
> >>>>>> driver fails to probe.
> >>>>>>
> >>>>>> A new Boolean flag named skip_wp_gpio has been added in nvmem_conf=
ig.
> >>>>>> In case skip_wp_gpio is set, it means that the GPIO is handled by =
the
> >>>>>> provider. Lets set this flag in MTD layer to avoid the conflict on
> >>>>>> wp_gpios property.
> >>>>>>
> >>>>>> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
> >>>>>> ---
> >>>>>> =C2=A0=C2=A0 drivers/mtd/mtdcore.c | 2 ++
> >>>>>> =C2=A0=C2=A0 1 file changed, 2 insertions(+)
> >>>>>>
> >>>>>> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> >>>>>> index 70f492dce158..e6d251594def 100644
> >>>>>> --- a/drivers/mtd/mtdcore.c
> >>>>>> +++ b/drivers/mtd/mtdcore.c
> >>>>>> @@ -546,6 +546,7 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 config.stride =3D 1;
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 config.read_only =3D true;
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 config.root_only =3D true;
> >>>>>> +=C2=A0=C2=A0=C2=A0 config.skip_wp_gpio =3D true;
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 config.no_of_node =3D !of_dev=
ice_is_compatible(node, >>>>>> "nvmem-cells");
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 config.priv =3D mtd;
> >>>>>> @@ -833,6 +834,7 @@ static struct nvmem_device >>>>>> *mtd_otp_nvm=
em_register(struct mtd_info *mtd,
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 config.owner =3D THIS_MODULE;
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 config.type =3D NVMEM_TYPE_OT=
P;
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 config.root_only =3D true;
> >>>>>> +=C2=A0=C2=A0=C2=A0 config.skip_wp_gpio =3D true;
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 config.reg_read =3D reg_read;
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 config.size =3D size;
> >>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 config.of_node =3D np; =20
> >>>>>
> >>>>> TLDR: There is a conflict between MTD and NVMEM, who should handle =
the
> >>>>> WP pin when there is one? At least for raw NAND devices, I don't wa=
nt
> >>>>> the NVMEM core to handle the wp pin. So we've introduced this
> >>>>> skip_wp_gpio nvmem config option. But there are two places where th=
is
> >>>>> boolean can be set and one of these is for otp regions (see above).=
 In
> >>>>> this case, I don't know if it is safe or if CFI/SPI-NOR rely on the
> >>>>> nvmem protection. Please tell us if you think this is fine for you.=
 =20
> >>>>
> >>>> Why does NVMEM touch hardware write protection in the first place? T=
he
> >>>> purpose of the framework is to provide a way to retrieve config stor=
ed
> >>>> in memory. It has no business dealing with details of the chip like =
the
> >>>> WP line. That should be MTD's job (which it should delegate to SPI N=
OR,
> >>>> SPI NAND, etc.). If you want to write protect a cell then do it in
> >>>> software. I don't see why NVMEM should be dealing with hardware >>>>=
 directly
> >>>> at all.
> >>>>
> >>>> That is my mental model of how things _should_ work. I have not spent
> >>>> much time digging into how things actually work currently.
> >>>> =20
> >>>
> >>> Wp-gpios property management was added in MVMEM framework in January =
>>> 2020 =3D>
> >>> sha1: 2a127da461a9d8d97782d6e82b227041393eb4d2
> >>> "
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 nvmem: add support for the write-protect pin
> >>>
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 The write-protect pin handling looks like a =
standard property that
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 could benefit other users if available in th=
e core nvmem framework.
> >>>
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 Instead of modifying all the memory drivers =
to check this pin, make
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 the NVMEM subsystem check if the write-prote=
ct GPIO being passed
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 through the nvmem_config or defined in the d=
evice tree and pull it
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 low whenever writing to the memory.
> >>> "
> >>>
> >>> And this modification was done for EEPROMs flashes =3D> sha1:
> >>> 1c89074bf85068d1b86f2e0f0c2110fdd9b83c9f
> >>> "
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 eeprom: at24: remove the write-protect pin s=
upport
> >>>
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 NVMEM framework is an interface for the at24=
 EEPROMs as well as for
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 other drivers, instead of passing the wp-gpi=
os over the different
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 drivers each time, it would be better to pas=
s it over the NVMEM
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 subsystem once and for all.
> >>>
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 Removing the support for the write-protect p=
in after adding it to
> >>> =C2=A0=C2=A0=C2=A0=C2=A0 the NVMEM subsystem.
> >>> "
> >>>
> >>> Current NVMEM framework implementation toggles the WP GPIO when >>> r=
eg_write
> >>> nvmem_config API is defined. In case of MTD framework, reg_write is n=
ot
> >>> defined in nvmem_config. =20
> >>
> >> Thanks for digging these up. I think this was the wrong decision to
> >> make. NVMEM should just provide the APIs for handling read/write, and
> >> leave the rest to the drivers.
> >>
> >> It might be convenient for some drivers to put the WP GPIO handling to
> >> NVMEM core but I just don't think it is the job of the framework to de=
al
> >> with this, and it just does not know enough about the device to deal
> >> with correctly and completely anyway. For example, wp-gpio is only one
> >> of the ways to write protect a chip. SPI NOR flashes have a WP# pin th=
at
> >> is often toggled via the SPI controller. There could also be registers
> >> that do the write protection.
> >>
> >> One would have to make strong justifications for making nvmem directly
> >> deal with hardware level details to convince me it is a good idea. IMHO
> >> if AT24 EEPROM is the only driver relying on this as of now then we
> >> should just revert the patches and not have to deal with the
> >> skip_wp_gpio hackery.
> >> =20
> >=20
> > Based on the=C2=A0 bindings documentation, AT24 EEPROM driver is not th=
e only
> > driver relying on this implementation. At least, AT25 EEPROM driver will
> > have to be modified to handle the Write Protect management, and there is
> > probably others drivers relying on this implementation.
> >=20
> > So, should we keep the legacy and apply the proposal patch to fix this
> > conflict (I can send a V3 with a fixes tag on patch 3 and 4 as
> > recommended by Miquel)?
> > Or should we revert the Write Protect management in NVMEM framework
> > but in this case I will not be able to handle such modifications (I am
> > not able to test those drivers). =20
>=20
> Firstly sorry for such a long delay to reply this thread as I was in trav=
el.
>=20
> I agree with comments from Pratyush but I see no harm in handling simple =
usecases of write-protect gpio in nvmem core. In fact wp-gpios and read-onl=
y are part of nvmem provider bindings.
>=20
> But usecases like the ones described in this patch series which do not wa=
nt nvmem core to deal with this pin should set this new flag. I think this =
is a balanced choice.
>=20
> reverting the wp-gpio patch is going to break other providers that are us=
ing this bindings.

I am always puzzled when the community deeply cares about non-mainline
drivers.

On one side I can understand that creating a 'grab-the-wp-line'
flag would immediately break all external users but this is, as
reported by Pratyush, the more logical approach IMHO. However we might
possibly miss situations where the flag is necessary and break these
devices.

Otherwise the 'ignore-wp' flag is more conservative, it does not
break the existing users but would just address the MTD case for now, we
might have other in-tree subsystem that are affected.

I'm fine either way TBH :-) I would just like this patchset to go in
through the next merge window.

Thanks,
Miqu=C3=A8l
