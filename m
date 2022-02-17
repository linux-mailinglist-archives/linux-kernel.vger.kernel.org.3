Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A8A4BA29C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 15:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240016AbiBQOIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 09:08:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiBQOIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 09:08:32 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C812838E6;
        Thu, 17 Feb 2022 06:08:16 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E324DFF810;
        Thu, 17 Feb 2022 14:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645106894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Irnc71t6sIpvAau3FPruuts4J8cX0QFTebragmAHbBw=;
        b=PzrrJYrXPvHAs9FGZ0QLdgAqMfhjGRHXHcia5yASFkhrSZ45kJf/7+wD2ymiWx8aOvuw11
        6Eg03U1rjrdFrHReBOb2GsE8NLURbKECNBUZ+CQV3llVaSaBwYlY1R5t1Gi0p2bS98JeTE
        vqHEn/2e0nkr0D03WVqwcMEcXQHFerjI+kVSoAtj4SR0YRJURJIONt9QQhcw2yDEWN/m77
        TUsDsz/qWN1qh3qpyv6OSqr5gmaNH7OngSwM0Ef7+HKVWhJPV5oK/9TTPjxdZ9cnJv3mTA
        XKLI/bO0ulwNMUeUvo0brTa5QNORXIRqDaevGsfz+v6eXm06NtS6QSJOwx719w==
Date:   Thu, 17 Feb 2022 15:08:10 +0100
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
Message-ID: <20220217150810.354dfa62@xps13>
In-Reply-To: <8ae6faa4-a46e-bb72-799c-b4a04513b3e4@linaro.org>
References: <20220131095755.8981-1-christophe.kerello@foss.st.com>
        <20220131095755.8981-5-christophe.kerello@foss.st.com>
        <20220131144309.0ffe7cc8@xps13>
        <20220201104727.7xvcyexf3yucegcb@ti.com>
        <eebfa629-ead2-d63f-9cfb-4cafc1534678@foss.st.com>
        <20220202115327.53oqg5n7tx6b6q7u@ti.com>
        <f6687807-607c-f672-2394-ad463735d597@foss.st.com>
        <d1000482-5385-c6f1-d10e-e5396218e0ea@linaro.org>
        <20220217094819.2548a25e@xps13>
        <8ae6faa4-a46e-bb72-799c-b4a04513b3e4@linaro.org>
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

srinivas.kandagatla@linaro.org wrote on Thu, 17 Feb 2022 11:00:23 +0000:

> On 17/02/2022 08:48, Miquel Raynal wrote:
> > Hi Srinivas,
> >=20
> > srinivas.kandagatla@linaro.org wrote on Wed, 16 Feb 2022 09:24:29 +0000:
> >  =20
> >> On 16/02/2022 08:46, Christophe Kerello wrote: =20
> >>> Hi Miquel, Pratyush, Srinivas,
> >>>
> >>> On 2/2/22 12:53, Pratyush Yadav wrote: =20
> >>>> + Khouloud, Linus, Bartosz
> >>>>
> >>>> On 02/02/22 11:44AM, Christophe Kerello wrote: =20
> >>>>> Hi,
> >>>>>
> >>>>> On 2/1/22 11:47, Pratyush Yadav wrote: =20
> >>>>>> On 31/01/22 02:43PM, Miquel Raynal wrote: =20
> >>>>>>> Hi Vignesh, Tudory, Pratyush,
> >>>>>>>
> >>>>>>> + Tudor and Pratyush
> >>>>>>>
> >>>>>>> christophe.kerello@foss.st.com wrote on Mon, 31 Jan 2022 10:57:55=
 >>>>> +0100: =20
> >>>>>>>   >>>>>>>> Wp-gpios property can be used on NVMEM nodes and the s=
ame property >>>>>> can =20
> >>>>>>>> be also used on MTD NAND nodes. In case of the wp-gpios property=
 is
> >>>>>>>> defined at NAND level node, the GPIO management is done at NAND =
>>>>>> driver
> >>>>>>>> level. Write protect is disabled when the driver is probed or re=
sumed
> >>>>>>>> and is enabled when the driver is released or suspended.
> >>>>>>>>
> >>>>>>>> When no partitions are defined in the NAND DT node, then the NAN=
D >>>>>> DT node
> >>>>>>>> will be passed to NVMEM framework. If wp-gpios property is defin=
ed in
> >>>>>>>> this node, the GPIO resource is taken twice and the NAND control=
ler
> >>>>>>>> driver fails to probe.
> >>>>>>>>
> >>>>>>>> A new Boolean flag named skip_wp_gpio has been added in nvmem_co=
nfig.
> >>>>>>>> In case skip_wp_gpio is set, it means that the GPIO is handled b=
y the
> >>>>>>>> provider. Lets set this flag in MTD layer to avoid the conflict =
on
> >>>>>>>> wp_gpios property.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.co=
m>
> >>>>>>>> ---
> >>>>>>>>  =C2=A0=C2=A0 drivers/mtd/mtdcore.c | 2 ++
> >>>>>>>>  =C2=A0=C2=A0 1 file changed, 2 insertions(+)
> >>>>>>>>
> >>>>>>>> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> >>>>>>>> index 70f492dce158..e6d251594def 100644
> >>>>>>>> --- a/drivers/mtd/mtdcore.c
> >>>>>>>> +++ b/drivers/mtd/mtdcore.c
> >>>>>>>> @@ -546,6 +546,7 @@ static int mtd_nvmem_add(struct mtd_info *mt=
d)
> >>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 config.stride =3D 1;
> >>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 config.read_only =3D true;
> >>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 config.root_only =3D true;
> >>>>>>>> +=C2=A0=C2=A0=C2=A0 config.skip_wp_gpio =3D true;
> >>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 config.no_of_node =3D !of_=
device_is_compatible(node, >>>>>> "nvmem-cells");
> >>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 config.priv =3D mtd;
> >>>>>>>> @@ -833,6 +834,7 @@ static struct nvmem_device >>>>>> *mtd_otp_n=
vmem_register(struct mtd_info *mtd,
> >>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 config.owner =3D THIS_MODU=
LE;
> >>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 config.type =3D NVMEM_TYPE=
_OTP;
> >>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 config.root_only =3D true;
> >>>>>>>> +=C2=A0=C2=A0=C2=A0 config.skip_wp_gpio =3D true;
> >>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 config.reg_read =3D reg_re=
ad;
> >>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 config.size =3D size;
> >>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 config.of_node =3D np; =20
> >>>>>>>
> >>>>>>> TLDR: There is a conflict between MTD and NVMEM, who should handl=
e the
> >>>>>>> WP pin when there is one? At least for raw NAND devices, I don't =
want
> >>>>>>> the NVMEM core to handle the wp pin. So we've introduced this
> >>>>>>> skip_wp_gpio nvmem config option. But there are two places where =
this
> >>>>>>> boolean can be set and one of these is for otp regions (see above=
). In
> >>>>>>> this case, I don't know if it is safe or if CFI/SPI-NOR rely on t=
he
> >>>>>>> nvmem protection. Please tell us if you think this is fine for yo=
u. =20
> >>>>>>
> >>>>>> Why does NVMEM touch hardware write protection in the first place?=
 The
> >>>>>> purpose of the framework is to provide a way to retrieve config st=
ored
> >>>>>> in memory. It has no business dealing with details of the chip lik=
e the
> >>>>>> WP line. That should be MTD's job (which it should delegate to SPI=
 NOR,
> >>>>>> SPI NAND, etc.). If you want to write protect a cell then do it in
> >>>>>> software. I don't see why NVMEM should be dealing with hardware >>=
>> directly
> >>>>>> at all.
> >>>>>>
> >>>>>> That is my mental model of how things _should_ work. I have not sp=
ent
> >>>>>> much time digging into how things actually work currently. =20
> >>>>>>   >>>>> =20
> >>>>> Wp-gpios property management was added in MVMEM framework in Januar=
y >>> 2020 =3D>
> >>>>> sha1: 2a127da461a9d8d97782d6e82b227041393eb4d2
> >>>>> "
> >>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 nvmem: add support for the write-protect =
pin
> >>>>>
> >>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 The write-protect pin handling looks like=
 a standard property that
> >>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 could benefit other users if available in=
 the core nvmem framework.
> >>>>>
> >>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 Instead of modifying all the memory drive=
rs to check this pin, make
> >>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 the NVMEM subsystem check if the write-pr=
otect GPIO being passed
> >>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 through the nvmem_config or defined in th=
e device tree and pull it
> >>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 low whenever writing to the memory.
> >>>>> "
> >>>>>
> >>>>> And this modification was done for EEPROMs flashes =3D> sha1:
> >>>>> 1c89074bf85068d1b86f2e0f0c2110fdd9b83c9f
> >>>>> "
> >>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 eeprom: at24: remove the write-protect pi=
n support
> >>>>>
> >>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 NVMEM framework is an interface for the a=
t24 EEPROMs as well as for
> >>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 other drivers, instead of passing the wp-=
gpios over the different
> >>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 drivers each time, it would be better to =
pass it over the NVMEM
> >>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 subsystem once and for all.
> >>>>>
> >>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 Removing the support for the write-protec=
t pin after adding it to
> >>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 the NVMEM subsystem.
> >>>>> "
> >>>>>
> >>>>> Current NVMEM framework implementation toggles the WP GPIO when >>>=
 reg_write
> >>>>> nvmem_config API is defined. In case of MTD framework, reg_write is=
 not
> >>>>> defined in nvmem_config. =20
> >>>>
> >>>> Thanks for digging these up. I think this was the wrong decision to
> >>>> make. NVMEM should just provide the APIs for handling read/write, and
> >>>> leave the rest to the drivers.
> >>>>
> >>>> It might be convenient for some drivers to put the WP GPIO handling =
to
> >>>> NVMEM core but I just don't think it is the job of the framework to =
deal
> >>>> with this, and it just does not know enough about the device to deal
> >>>> with correctly and completely anyway. For example, wp-gpio is only o=
ne
> >>>> of the ways to write protect a chip. SPI NOR flashes have a WP# pin =
that
> >>>> is often toggled via the SPI controller. There could also be registe=
rs
> >>>> that do the write protection.
> >>>>
> >>>> One would have to make strong justifications for making nvmem direct=
ly
> >>>> deal with hardware level details to convince me it is a good idea. I=
MHO
> >>>> if AT24 EEPROM is the only driver relying on this as of now then we
> >>>> should just revert the patches and not have to deal with the
> >>>> skip_wp_gpio hackery. =20
> >>>>   >>> =20
> >>> Based on the=C2=A0 bindings documentation, AT24 EEPROM driver is not =
the only
> >>> driver relying on this implementation. At least, AT25 EEPROM driver w=
ill
> >>> have to be modified to handle the Write Protect management, and there=
 is
> >>> probably others drivers relying on this implementation.
> >>>
> >>> So, should we keep the legacy and apply the proposal patch to fix this
> >>> conflict (I can send a V3 with a fixes tag on patch 3 and 4 as
> >>> recommended by Miquel)?
> >>> Or should we revert the Write Protect management in NVMEM framework
> >>> but in this case I will not be able to handle such modifications (I am
> >>> not able to test those drivers). =20
> >>
> >> Firstly sorry for such a long delay to reply this thread as I was in t=
ravel.
> >>
> >> I agree with comments from Pratyush but I see no harm in handling simp=
le usecases of write-protect gpio in nvmem core. In fact wp-gpios and read-=
only are part of nvmem provider bindings.
> >>
> >> But usecases like the ones described in this patch series which do not=
 want nvmem core to deal with this pin should set this new flag. I think th=
is is a balanced choice.
> >>
> >> reverting the wp-gpio patch is going to break other providers that are=
 using this bindings. =20
> >=20
> > I am always puzzled when the community deeply cares about non-mainline
> > drivers.
> >=20
> > On one side I can understand that creating a 'grab-the-wp-line'
> > flag would immediately break all external users but this is, as
> > reported by Pratyush, the more logical approach IMHO. However we might
> > possibly miss situations where the flag is necessary and break these
> > devices.
> >=20
> > Otherwise the 'ignore-wp' flag is more conservative, it does not =20
>=20
> ingore-wp seems to be more sensible flag than skip_wp_gpio flag.
>=20
>=20
> > break the existing users but would just address the MTD case for now, we
> > might have other in-tree subsystem that are affected.
> >=20
> > I'm fine either way TBH :-) I would just like this patchset to go in =20
>=20
> Am okay either way too, It is just that ingore-wp seems a balanced choice=
 in the current situation :-).
>=20
> > through the next merge window. =20
> Sure.
>=20
> I can Ack nvmem patch if you wish to carry it via mtd tree.

Yes, that would be ideal to prevent build issues during the merge
window/in linux-next.

>=20
> or
>=20
> nvmem patches go via Greg's char-misc tree. I can take 4/4 if you ack it =
once V3 is sent

Thanks,
Miqu=C3=A8l
