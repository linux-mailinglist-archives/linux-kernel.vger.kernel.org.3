Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6A55066E7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 10:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349997AbiDSI3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 04:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240524AbiDSI3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 04:29:17 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BD92DD46;
        Tue, 19 Apr 2022 01:26:34 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5B566FF804;
        Tue, 19 Apr 2022 08:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650356793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VXBlhum4y6XFxuELbe8JGMivZRApx0IpgXnue2l+2tA=;
        b=En4XckKRy2XUHcPmxdD3HS/8imGMUX23JA+DVW2whyGf+0TkYT1GxTJToeKg7JxW6sp5YD
        5T0JqZyLmOcpT1Iscp4JTrMcF69FqaC2psvhgVarurkbtDHCd+TQMp1LDZQTn6fSMVP84V
        m2EAoe4FtF7XBLmH+M/XIhq17fudmWBlAwS/Wj97MBQcbsMXbn0E16axGlemoqdzPpyoya
        fAisPIPcnZTYKVRtov653V9gvO5sDfdIPJe/GZr/3QyP8Ea81PUSS5b6v3GY9CSZBnVm0t
        RyH6QoClKUE+YOkWoXhtMnMlpeNu/C5hwRwH4GI3lUOr9PNnM21z0cRB9bfj7Q==
Date:   Tue, 19 Apr 2022 10:26:29 +0200
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
Message-ID: <20220419102629.1c77aa2a@xps13>
In-Reply-To: <d5a33645-fac1-9c69-afe6-654bfe93ca48@amlogic.com>
References: <20220402074921.13316-1-liang.yang@amlogic.com>
        <20220402074921.13316-2-liang.yang@amlogic.com>
        <20220404103034.48ec16b1@xps13>
        <50105d6b-8ced-1b72-30cb-a709c4a4dd26@amlogic.com>
        <d5a33645-fac1-9c69-afe6-654bfe93ca48@amlogic.com>
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

liang.yang@amlogic.com wrote on Mon, 18 Apr 2022 11:40:10 +0800:

> Hi Miquel,
>=20
> i have some confusion when i prepare the patches. for DT compatibility, i=
t falls back to the old DT when failed to get resource by the new DT, but t=
here is some points:
> a. old DT depends on MMC sub clock driver, but it never be merged, so it =
can't work.

I don't get what you mean here, sorry. I believe there is a new way to
describe this clock but grabbing the one from the MMC still works, does
not it?

> b. if it falls back to the old DT, beside the regmap lookup below, it see=
ms that we have to preserve the code of the old clock setting in nfc_clk_in=
it().

Yes, probably.

> do we still need to avoid break DT compatibility?

We should try our best to avoid breaking the DT, yes.

>=20
> Thanks.
>=20
> On 2022/4/11 10:40, Liang Yang wrote:
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfc->dev =3D dev;
> >>> -=C2=A0=C2=A0=C2=A0 res =3D platform_get_resource(pdev, IORESOURCE_ME=
M, 0);
> >>> -=C2=A0=C2=A0=C2=A0 nfc->reg_base =3D devm_ioremap_resource(dev, res);
> >>> +=C2=A0=C2=A0=C2=A0 nfc->reg_base =3D devm_platform_ioremap_resource_=
byname(pdev, "nfc"); =20
> >>
> >> This change seems unrelated. =20
> >=20
> > To be consistent with the following > devm_platform_ioremap_resource_by=
name(pdev, "emmc"). do you mean that we > don't need it?> =20
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(nfc->reg_base))
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR=
(nfc->reg_base);
> >>> -=C2=A0=C2=A0=C2=A0 nfc->reg_clk =3D
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 syscon_regmap_lookup_by_p=
handle(dev->of_node,
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "a=
mlogic,mmc-syscon");
> >>> -=C2=A0=C2=A0=C2=A0 if (IS_ERR(nfc->reg_clk)) {
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(dev, "Failed to l=
ookup clock base\n");
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR(nfc->reg_c=
lk);
> >>> -=C2=A0=C2=A0=C2=A0 }
> >>> +=C2=A0=C2=A0=C2=A0 nfc->sd_emmc_clock =3D devm_platform_ioremap_reso=
urce_byname(pdev, >>> "emmc");
> >>> +=C2=A0=C2=A0=C2=A0 if (IS_ERR(nfc->sd_emmc_clock))
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR(nfc->sd_em=
mc_clock); =20
> >>
> >> While I agree this is much better than the previous solution, we cannot
> >> break DT compatibility, so you need to try getting the emmc clock, but
> >> if it fails you should fallback to the regmap lookup. =20
> >=20
> > ok, i will fix it next version. thanks.
> >  =20
> >> =20
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 irq =3D platform_get_irq(pdev, 0); =20


Thanks,
Miqu=C3=A8l
