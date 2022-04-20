Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90078508223
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 09:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359709AbiDTHcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 03:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242171AbiDTHcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:32:04 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4C33B017;
        Wed, 20 Apr 2022 00:29:17 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5D7DC1C000F;
        Wed, 20 Apr 2022 07:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650439756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QxxLqwZKbkp7nwz1evA3eEbo/hQsneWeBfjxoXN5fbk=;
        b=QaoQkCNjXRxpHyEnKepPy5eRNox30saqO9EWU4NqDUYFtGsZT/6R1PLy9ytaQXFtQkQIIB
        jFxg4bNlQjzF+CD2oTt1Fvx3jsV/lYUsDmouPwuTNpFPrtlt2jx/dflMQhqgk+TiEkddNB
        47McAh5hHEf9pOPFzAqAPVqIK+nYpWk+luM+Cb/pyqbzWev+3Y+1M0ZCVvtD6Tx+RlN2VP
        zlG8yEuJIyDiKnSoNi8YgEQiIwm9z3OWV+9HH0O9pmeJPE6MX8KChtxcBb5jz+jy/D7lva
        GHasc3PxTP8p4Fq3zcINMD5HG7xIgnnxU/qmhu154x0JCb8XHiD4p7qL1VsVVQ==
Date:   Wed, 20 Apr 2022 09:29:12 +0200
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
Message-ID: <20220420092912.10ce66ec@xps13>
In-Reply-To: <126691f4-bc6b-10cd-ee2c-ff4006bc6518@amlogic.com>
References: <20220402074921.13316-1-liang.yang@amlogic.com>
        <20220402074921.13316-2-liang.yang@amlogic.com>
        <20220404103034.48ec16b1@xps13>
        <50105d6b-8ced-1b72-30cb-a709c4a4dd26@amlogic.com>
        <d5a33645-fac1-9c69-afe6-654bfe93ca48@amlogic.com>
        <20220419102629.1c77aa2a@xps13>
        <2e382e3e-c231-c9e4-73a1-0637288fcd4f@amlogic.com>
        <20220419172528.2dd75e7b@xps13>
        <126691f4-bc6b-10cd-ee2c-ff4006bc6518@amlogic.com>
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

Hi Liang,

liang.yang@amlogic.com wrote on Wed, 20 Apr 2022 13:44:32 +0800:

> Hi Miquel,
>=20
> On 2022/4/19 23:25, Miquel Raynal wrote:
> > [ EXTERNAL EMAIL ]
> >=20
> > Hello,
> >=20
> > liang.yang@amlogic.com wrote on Tue, 19 Apr 2022 17:17:48 +0800:
> >  =20
> >> Hello Miquel,
> >>
> >> On 2022/4/19 16:26, Miquel Raynal wrote: =20
> >>> [ EXTERNAL EMAIL ]
> >>>
> >>> Hello,
> >>>
> >>> liang.yang@amlogic.com wrote on Mon, 18 Apr 2022 11:40:10 +0800: =20
> >>>    >>>> Hi Miquel, =20
> >>>>
> >>>> i have some confusion when i prepare the patches. for DT compatibili=
ty, it falls back to the old DT when failed to get resource by the new DT, =
but there is some points:
> >>>> a. old DT depends on MMC sub clock driver, but it never be merged, s=
o it can't work. =20
> >>>
> >>> I don't get what you mean here, sorry. I believe there is a new way to
> >>> describe this clock but grabbing the one from the MMC still works, do=
es
> >>> not it? =20
> >>>    >> =20
> >> No, it doesn't. after the NFC driver using the MMC sub clock framework=
 was merged into the mainline of kernel, we didn't continue to submit the s=
eries of patches about MMC sub clock after v9. when i found that, we made a=
 discussion to decide whether to recover the series of patches about MMC su=
b clock framework, finally, see the description from cover letter, we plan =
to abandon it and adopt the new clock scheme in this series of patches. =20
> >=20
> > I am not sure to follow. Is the current code completely broken? I
> > believe it is not, so I don't understand your issue. =20
>=20
> i think only the code about the clock is completely broken.
>=20
> >=20
> > Can you please summarize the situation? =20
>=20
> Yes. the current NFC clock implementation depends on the following series=
 of patches [https://lore.kernel.org/all/20220121074508.42168-5-liang.yang@=
amlogic.com], which we call "Meson MMC Sub Clock Controller Driver".
> when i was preparing the NFC patchset at that time, we discussed how the =
clock should be implemented base on the special clock framework for NFC and=
 EMMC port. then we decided to implement a driver "Meson MMC Sub Clock Cont=
roller Driver". so another people begin to prepare "Meson MMC Sub Clock Con=
troller Driver", but submitted it by different patchset.
> finally, now the meson NFC patchset is accepted and merged, but "Meson MM=
C Sub Clock Controller Driver" patchset is not. also we decide to abandon t=
he patset "Meson MMC Sub Clock Controller Driver" and implement the new clo=
ck design in this series.

Ok thanks for the summary and the link with the discussion with Jerome
and Neil, it's informative.

So in the end, we are not really breaking anything here as this NAND
controller driver never worked in the first place? Or is it only one of
the two compatibles which is not working?

If this never worked then please do the binding changes (in the first
patch of your series) and then do the necessary changes in the code. If
this worked with at least one of the two compatibles, then you have to
create dedicated helpers, one for each, in order to grab the clocks
differently and not break anybody.

>=20
> >  =20
> >>
> >> Thanks.
> >> =20
> >>>> b. if it falls back to the old DT, beside the regmap lookup below, i=
t seems that we have to preserve the code of the old clock setting in nfc_c=
lk_init(). =20
> >>>
> >>> Yes, probably. =20
> >>>    >>>> do we still need to avoid break DT compatibility? =20
> >>>
> >>> We should try our best to avoid breaking the DT, yes. =20
> >>>    >>>> =20
> >>>> Thanks.
> >>>>
> >>>> On 2022/4/11 10:40, Liang Yang wrote: =20
> >>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfc->dev =3D dev;
> >>>>>>> -=C2=A0=C2=A0=C2=A0 res =3D platform_get_resource(pdev, IORESOURC=
E_MEM, 0);
> >>>>>>> -=C2=A0=C2=A0=C2=A0 nfc->reg_base =3D devm_ioremap_resource(dev, =
res);
> >>>>>>> +=C2=A0=C2=A0=C2=A0 nfc->reg_base =3D devm_platform_ioremap_resou=
rce_byname(pdev, "nfc"); =20
> >>>>>>
> >>>>>> This change seems unrelated. =20
> >>>>>
> >>>>> To be consistent with the following > devm_platform_ioremap_resourc=
e_byname(pdev, "emmc"). do you mean that we > don't need it?> =20
> >>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(nfc->reg_base))
> >>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return P=
TR_ERR(nfc->reg_base);
> >>>>>>> -=C2=A0=C2=A0=C2=A0 nfc->reg_clk =3D
> >>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 syscon_regmap_lookup_=
by_phandle(dev->of_node,
> >>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 "amlogic,mmc-syscon");
> >>>>>>> -=C2=A0=C2=A0=C2=A0 if (IS_ERR(nfc->reg_clk)) {
> >>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(dev, "Failed =
to lookup clock base\n");
> >>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR(nfc->r=
eg_clk);
> >>>>>>> -=C2=A0=C2=A0=C2=A0 }
> >>>>>>> +=C2=A0=C2=A0=C2=A0 nfc->sd_emmc_clock =3D devm_platform_ioremap_=
resource_byname(pdev, >>> "emmc");
> >>>>>>> +=C2=A0=C2=A0=C2=A0 if (IS_ERR(nfc->sd_emmc_clock))
> >>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR(nfc->s=
d_emmc_clock); =20
> >>>>>>
> >>>>>> While I agree this is much better than the previous solution, we c=
annot
> >>>>>> break DT compatibility, so you need to try getting the emmc clock,=
 but
> >>>>>> if it fails you should fallback to the regmap lookup. =20
> >>>>>
> >>>>> ok, i will fix it next version. thanks. =20
> >>>>>     >>>>   >>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 irq =3D platform_g=
et_irq(pdev, 0); =20
> >>>
> >>>
> >>> Thanks,
> >>> Miqu=C3=A8l
> >>>
> >>> . =20
> >=20
> >=20
> > Thanks,
> > Miqu=C3=A8l
> >=20
> > . =20


Thanks,
Miqu=C3=A8l
