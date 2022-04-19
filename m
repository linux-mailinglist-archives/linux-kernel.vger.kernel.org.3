Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860A05071B2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 17:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353802AbiDSP2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 11:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354260AbiDSP2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 11:28:18 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9ABDEDD;
        Tue, 19 Apr 2022 08:25:34 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 59F30FF80D;
        Tue, 19 Apr 2022 15:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650381932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bq9PeeGKcHRkxdXVgUr01rmzSL3+CeljQ3EucZX0P7Y=;
        b=D5GBhDkyZrK5yvyrOhTnlTFai3nybJgtqeJ4Btz8MX+iAYbIB8QguBUEXby9NcFEsox2Ay
        nEBVao0mKpzibIZwXRjI+fegNSQSw7yP0VTNq2TEF9zGIcyMj40seUL5zSgEDw6yP0fImV
        lJF05G0KenAPpCFxgqJkSYhSYBiG/PZ/bVpCHQ4t0OlvyMid9HQRfk/ROI9Kgcj6DyTUMD
        xvSthEuLiZuwLSoV+spy5qdHex3A5uN+vsMGrjnOmyQmI94UOSi1NIfHY47bk0U1gnoFxS
        +z+RfEv5dQrJmZydxKRtn5ikkNVGrQpVuMaMw2rcPP/XoxZz0Iya3GbS7msmUg==
Date:   Tue, 19 Apr 2022 17:25:28 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Liang Yang <liang.yang@amlogic.com>
Cc:     <linux-mtd@lists.infradead.org>, Rob Herring <robh+dt@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        YongHui Yu <yonghui.yu@amlogic.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] mtd: rawnand: meson: discard the common MMC sub
 clock framework
Message-ID: <20220419172528.2dd75e7b@xps13>
In-Reply-To: <2e382e3e-c231-c9e4-73a1-0637288fcd4f@amlogic.com>
References: <20220402074921.13316-1-liang.yang@amlogic.com>
        <20220402074921.13316-2-liang.yang@amlogic.com>
        <20220404103034.48ec16b1@xps13>
        <50105d6b-8ced-1b72-30cb-a709c4a4dd26@amlogic.com>
        <d5a33645-fac1-9c69-afe6-654bfe93ca48@amlogic.com>
        <20220419102629.1c77aa2a@xps13>
        <2e382e3e-c231-c9e4-73a1-0637288fcd4f@amlogic.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

liang.yang@amlogic.com wrote on Tue, 19 Apr 2022 17:17:48 +0800:

> Hello Miquel,
>=20
> On 2022/4/19 16:26, Miquel Raynal wrote:
> > [ EXTERNAL EMAIL ]
> >=20
> > Hello,
> >=20
> > liang.yang@amlogic.com wrote on Mon, 18 Apr 2022 11:40:10 +0800:
> >  =20
> >> Hi Miquel,
> >>
> >> i have some confusion when i prepare the patches. for DT compatibility=
, it falls back to the old DT when failed to get resource by the new DT, bu=
t there is some points:
> >> a. old DT depends on MMC sub clock driver, but it never be merged, so =
it can't work. =20
> >=20
> > I don't get what you mean here, sorry. I believe there is a new way to
> > describe this clock but grabbing the one from the MMC still works, does
> > not it?
> >  =20
>=20
> No, it doesn't. after the NFC driver using the MMC sub clock framework wa=
s merged into the mainline of kernel, we didn't continue to submit the seri=
es of patches about MMC sub clock after v9. when i found that, we made a di=
scussion to decide whether to recover the series of patches about MMC sub c=
lock framework, finally, see the description from cover letter, we plan to =
abandon it and adopt the new clock scheme in this series of patches.

I am not sure to follow. Is the current code completely broken? I
believe it is not, so I don't understand your issue.

Can you please summarize the situation?

>=20
> Thanks.
>=20
> >> b. if it falls back to the old DT, beside the regmap lookup below, it =
seems that we have to preserve the code of the old clock setting in nfc_clk=
_init(). =20
> >=20
> > Yes, probably.
> >  =20
> >> do we still need to avoid break DT compatibility? =20
> >=20
> > We should try our best to avoid breaking the DT, yes.
> >  =20
> >>
> >> Thanks.
> >>
> >> On 2022/4/11 10:40, Liang Yang wrote: =20
> >>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfc->dev =3D dev;
> >>>>> -=C2=A0=C2=A0=C2=A0 res =3D platform_get_resource(pdev, IORESOURCE_=
MEM, 0);
> >>>>> -=C2=A0=C2=A0=C2=A0 nfc->reg_base =3D devm_ioremap_resource(dev, re=
s);
> >>>>> +=C2=A0=C2=A0=C2=A0 nfc->reg_base =3D devm_platform_ioremap_resourc=
e_byname(pdev, "nfc"); =20
> >>>>
> >>>> This change seems unrelated. =20
> >>>
> >>> To be consistent with the following > devm_platform_ioremap_resource_=
byname(pdev, "emmc"). do you mean that we > don't need it?> =20
> >>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(nfc->reg_base))
> >>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return PTR_=
ERR(nfc->reg_base);
> >>>>> -=C2=A0=C2=A0=C2=A0 nfc->reg_clk =3D
> >>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 syscon_regmap_lookup_by=
_phandle(dev->of_node,
> >>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "a=
mlogic,mmc-syscon");
> >>>>> -=C2=A0=C2=A0=C2=A0 if (IS_ERR(nfc->reg_clk)) {
> >>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(dev, "Failed to=
 lookup clock base\n");
> >>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR(nfc->reg=
_clk);
> >>>>> -=C2=A0=C2=A0=C2=A0 }
> >>>>> +=C2=A0=C2=A0=C2=A0 nfc->sd_emmc_clock =3D devm_platform_ioremap_re=
source_byname(pdev, >>> "emmc");
> >>>>> +=C2=A0=C2=A0=C2=A0 if (IS_ERR(nfc->sd_emmc_clock))
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR(nfc->sd_=
emmc_clock); =20
> >>>>
> >>>> While I agree this is much better than the previous solution, we can=
not
> >>>> break DT compatibility, so you need to try getting the emmc clock, b=
ut
> >>>> if it fails you should fallback to the regmap lookup. =20
> >>>
> >>> ok, i will fix it next version. thanks. =20
> >>>    >>>>   >>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 irq =3D platform_get_=
irq(pdev, 0); =20
> >=20
> >=20
> > Thanks,
> > Miqu=C3=A8l
> >=20
> > . =20


Thanks,
Miqu=C3=A8l
