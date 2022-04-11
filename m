Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED334FB452
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 09:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237230AbiDKHCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 03:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbiDKHCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 03:02:35 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A084329A4;
        Mon, 11 Apr 2022 00:00:20 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A54D120000C;
        Mon, 11 Apr 2022 07:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649660419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zwcdMhW28wSivY+7fR+VgYm0ZsDvKLkmMB9zTX/7Twc=;
        b=eHBEm4eFgXZYhS4aOfM2riVwE98eeUJbjZQ32w12NSM0Xy2kfG4UIWQmX+xVCGNSG6UVp0
        RV3gddhZmXH8llj0f+++FYaik+cfuwWN5Bm8Iwim2ntyT/1kAbDCskkbIGBq4m+e+pIoIv
        yDu0a73bBA34D+n3jJ9Hl9+9KkSMAZbeboOutSMZsZDKmxLEjbtnP4sPdLns3xWtOLYeR5
        isXRSDEwDSEviVG+3Oges3NqxNSIqTWsvgNzmOachxPQiCgln2Lvv/LG35lmirrvEnbn2m
        GcpFWCyQixeNRljWoCgDmoGOAYq5aBHF3CGPXSlSGC5IWQPBoG0NHHnQLlP5IA==
Date:   Mon, 11 Apr 2022 09:00:15 +0200
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
Message-ID: <20220411090015.6290b0b0@xps13>
In-Reply-To: <50105d6b-8ced-1b72-30cb-a709c4a4dd26@amlogic.com>
References: <20220402074921.13316-1-liang.yang@amlogic.com>
        <20220402074921.13316-2-liang.yang@amlogic.com>
        <20220404103034.48ec16b1@xps13>
        <50105d6b-8ced-1b72-30cb-a709c4a4dd26@amlogic.com>
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

liang.yang@amlogic.com wrote on Mon, 11 Apr 2022 10:40:15 +0800:

> Hi Miquel,
>=20
> On 2022/4/4 16:30, Miquel Raynal wrote:
> > [ EXTERNAL EMAIL ]
> >=20
> > Hi Liang,
> >=20
> > liang.yang@amlogic.com wrote on Sat, 2 Apr 2022 15:49:19 +0800:
> >  =20
> >> EMMC and NAND have the same clock control register named 'SD_EMMC_CLOC=
K' which is
> >> defined in EMMC port internally. bit0~5 of 'SD_EMMC_CLOCK' is the divi=
der and
> >> bit6~7 is the mux for fix pll and xtal.A common MMC and NAND sub-clock=
 has been
> >> implemented and can be used by the eMMC and NAND controller (which are=
 mutually
> >> exclusive anyway). Let's use this new clock.
> >>
> >> Signed-off-by: Liang Yang <liang.yang@amlogic.com>
> >> ---
> >>   drivers/mtd/nand/raw/meson_nand.c | 89 +++++++++++++++--------------=
--
> >>   1 file changed, 42 insertions(+), 47 deletions(-)
> >>
> >> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/=
meson_nand.c
> >> index ac3be92872d0..1b1a9407fb2f 100644
> >> --- a/drivers/mtd/nand/raw/meson_nand.c
> >> +++ b/drivers/mtd/nand/raw/meson_nand.c
> >> @@ -10,6 +10,7 @@
> >>   #include <linux/dma-mapping.h>
> >>   #include <linux/interrupt.h>
> >>   #include <linux/clk.h>
> >> +#include <linux/clk-provider.h>
> >>   #include <linux/mtd/rawnand.h>
> >>   #include <linux/mtd/mtd.h>
> >>   #include <linux/mfd/syscon.h>
> >> @@ -19,6 +20,7 @@
> >>   #include <linux/iopoll.h>
> >>   #include <linux/of.h>
> >>   #include <linux/of_device.h>
> >> +#include <linux/of_address.h>
> >>   #include <linux/sched/task_stack.h> =20
> >>   >>   #define NFC_REG_CMD		0x00 =20
> >> @@ -104,6 +106,9 @@ =20
> >>   >>   #define PER_INFO_BYTE		8
> >>   >> +#define CLK_DIV_SHIFT		0 =20
> >> +#define CLK_DIV_WIDTH		6
> >> +
> >>   struct meson_nfc_nand_chip {
> >>   	struct list_head node;
> >>   	struct nand_chip nand;
> >> @@ -151,15 +156,15 @@ struct meson_nfc {
> >>   	struct nand_controller controller;
> >>   	struct clk *core_clk;
> >>   	struct clk *device_clk;
> >> -	struct clk *phase_tx;
> >> -	struct clk *phase_rx;
> >> +	struct clk *nand_clk;
> >> +	struct clk_divider nand_divider; =20
> >>   >>   	unsigned long clk_rate; =20
> >>   	u32 bus_timing; =20
> >>   >>   	struct device *dev; =20
> >>   	void __iomem *reg_base;
> >> -	struct regmap *reg_clk;
> >> +	void __iomem *sd_emmc_clock;
> >>   	struct completion completion;
> >>   	struct list_head chips;
> >>   	const struct meson_nfc_data *data;
> >> @@ -235,7 +240,7 @@ static void meson_nfc_select_chip(struct nand_chip=
 *nand, int chip)
> >>   	nfc->timing.tbers_max =3D meson_chip->tbers_max; =20
> >>   >>   	if (nfc->clk_rate !=3D meson_chip->clk_rate) { =20
> >> -		ret =3D clk_set_rate(nfc->device_clk, meson_chip->clk_rate);
> >> +		ret =3D clk_set_rate(nfc->nand_clk, meson_chip->clk_rate);
> >>   		if (ret) {
> >>   			dev_err(nfc->dev, "failed to set clock rate\n");
> >>   			return;
> >> @@ -406,7 +411,6 @@ static int meson_nfc_queue_rb(struct meson_nfc *nf=
c, int timeout_ms)
> >>   	cmd =3D NFC_CMD_RB | NFC_CMD_RB_INT
> >>   		| nfc->param.chip_select | nfc->timing.tbers_max;
> >>   	writel(cmd, nfc->reg_base + NFC_REG_CMD);
> >> - =20
> >=20
> > Please avoid these spacing changes in the middle of a commit. =20
>=20
> ok, i will fix it.
> >  =20
> >>   	ret =3D wait_for_completion_timeout(&nfc->completion,
> >>   					  msecs_to_jiffies(timeout_ms));
> >>   	if (ret =3D=3D 0)
> >> @@ -985,9 +989,11 @@ static const struct mtd_ooblayout_ops meson_oobla=
yout_ops =3D {
> >>   	.free =3D meson_ooblayout_free,
> >>   }; =20
> >>   >> +struct clk_parent_data nfc_divider_parent_data[1]; =20
> >>   static int meson_nfc_clk_init(struct meson_nfc *nfc)
> >>   {
> >>   	int ret;
> >> +	struct clk_init_data init =3D {0}; =20
> >>   >>   	/* request core clock */ =20
> >>   	nfc->core_clk =3D devm_clk_get(nfc->dev, "core");
> >> @@ -1002,21 +1008,26 @@ static int meson_nfc_clk_init(struct meson_nfc=
 *nfc)
> >>   		return PTR_ERR(nfc->device_clk);
> >>   	} =20
> >>   >> -	nfc->phase_tx =3D devm_clk_get(nfc->dev, "tx"); =20
> >> -	if (IS_ERR(nfc->phase_tx)) {
> >> -		dev_err(nfc->dev, "failed to get TX clk\n");
> >> -		return PTR_ERR(nfc->phase_tx);
> >> -	}
> >> -
> >> -	nfc->phase_rx =3D devm_clk_get(nfc->dev, "rx");
> >> -	if (IS_ERR(nfc->phase_rx)) {
> >> -		dev_err(nfc->dev, "failed to get RX clk\n");
> >> -		return PTR_ERR(nfc->phase_rx);
> >> -	}
> >> +	init.name =3D devm_kstrdup(nfc->dev, "nfc#div", GFP_KERNEL);
> >> +	init.ops =3D &clk_divider_ops;
> >> +	nfc_divider_parent_data[0].fw_name =3D "device";
> >> +	init.parent_data =3D nfc_divider_parent_data;
> >> +	init.num_parents =3D 1;
> >> +	nfc->nand_divider.reg =3D nfc->sd_emmc_clock;
> >> +	nfc->nand_divider.shift =3D CLK_DIV_SHIFT;
> >> +	nfc->nand_divider.width =3D CLK_DIV_WIDTH;
> >> +	nfc->nand_divider.hw.init =3D &init;
> >> +	nfc->nand_divider.flags =3D CLK_DIVIDER_ONE_BASED |
> >> +				  CLK_DIVIDER_ROUND_CLOSEST |
> >> +				  CLK_DIVIDER_ALLOW_ZERO;
> >> +
> >> +	nfc->nand_clk =3D devm_clk_register(nfc->dev, &nfc->nand_divider.hw);
> >> +	if (IS_ERR(nfc->nand_clk))
> >> +		return PTR_ERR(nfc->nand_clk); =20
> >>   >>   	/* init SD_EMMC_CLOCK to sane defaults w/min clock rate */ =20
> >> -	regmap_update_bits(nfc->reg_clk,
> >> -			   0, CLK_SELECT_NAND, CLK_SELECT_NAND);
> >> +	writel(CLK_SELECT_NAND | readl(nfc->sd_emmc_clock),
> >> +	       nfc->sd_emmc_clock); =20
> >>   >>   	ret =3D clk_prepare_enable(nfc->core_clk); =20
> >>   	if (ret) {
> >> @@ -1030,29 +1041,21 @@ static int meson_nfc_clk_init(struct meson_nfc=
 *nfc)
> >>   		goto err_device_clk;
> >>   	} =20
> >>   >> -	ret =3D clk_prepare_enable(nfc->phase_tx); =20
> >> +	ret =3D clk_prepare_enable(nfc->nand_clk);
> >>   	if (ret) {
> >> -		dev_err(nfc->dev, "failed to enable TX clock\n");
> >> -		goto err_phase_tx;
> >> +		dev_err(nfc->dev, "pre enable NFC divider fail\n");
> >> +		goto err_nand_clk;
> >>   	} =20
> >>   >> -	ret =3D clk_prepare_enable(nfc->phase_rx); =20
> >> -	if (ret) {
> >> -		dev_err(nfc->dev, "failed to enable RX clock\n");
> >> -		goto err_phase_rx;
> >> -	}
> >> -
> >> -	ret =3D clk_set_rate(nfc->device_clk, 24000000);
> >> +	ret =3D clk_set_rate(nfc->nand_clk, 24000000); =20
> >=20
> > Is this rename really useful? =20
>=20
> yes, it works.

I understand it works, but if this is just a name change of a variable
in your driver that has implications everywhere in this driver, then
it's probably best to do it in a separate commit to ease the review.

>=20
> >  =20
> >>   	if (ret)
> >> -		goto err_disable_rx;
> >> +		goto err_disable_clk; =20
> >>   >>   	return 0;
> >>   >> -err_disable_rx: =20
> >> -	clk_disable_unprepare(nfc->phase_rx);
> >> -err_phase_rx:
> >> -	clk_disable_unprepare(nfc->phase_tx);
> >> -err_phase_tx:
> >> +err_disable_clk:
> >> +	clk_disable_unprepare(nfc->nand_clk);
> >> +err_nand_clk:
> >>   	clk_disable_unprepare(nfc->device_clk);
> >>   err_device_clk:
> >>   	clk_disable_unprepare(nfc->core_clk);
> >> @@ -1061,8 +1064,7 @@ static int meson_nfc_clk_init(struct meson_nfc *=
nfc) =20
> >>   >>   static void meson_nfc_disable_clk(struct meson_nfc *nfc) =20
> >>   {
> >> -	clk_disable_unprepare(nfc->phase_rx);
> >> -	clk_disable_unprepare(nfc->phase_tx);
> >> +	clk_disable_unprepare(nfc->nand_clk);
> >>   	clk_disable_unprepare(nfc->device_clk);
> >>   	clk_disable_unprepare(nfc->core_clk);
> >>   }
> >> @@ -1374,7 +1376,6 @@ static int meson_nfc_probe(struct platform_devic=
e *pdev)
> >>   {
> >>   	struct device *dev =3D &pdev->dev;
> >>   	struct meson_nfc *nfc;
> >> -	struct resource *res;
> >>   	int ret, irq; =20
> >>   >>   	nfc =3D devm_kzalloc(dev, sizeof(*nfc), GFP_KERNEL); =20
> >> @@ -1388,21 +1389,15 @@ static int meson_nfc_probe(struct platform_dev=
ice *pdev)
> >>   	nand_controller_init(&nfc->controller);
> >>   	INIT_LIST_HEAD(&nfc->chips);
> >>   	init_completion(&nfc->completion);
> >> - =20
> >=20
> > Please don't modify spacing in this commit.
> >ok =20
>=20
> >>   	nfc->dev =3D dev; =20
> >>   >> -	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0); =20
> >> -	nfc->reg_base =3D devm_ioremap_resource(dev, res);
> >> +	nfc->reg_base =3D devm_platform_ioremap_resource_byname(pdev, "nfc")=
; =20
> >=20
> > This change seems unrelated. =20
>=20
> To be consistent with the following devm_platform_ioremap_resource_byname=
(pdev, "emmc"). do you mean that we don't need it?>

So indeed it should not be in this commit. You can do that as a
preparation patch if you wish.

> >>   	if (IS_ERR(nfc->reg_base))
> >>   		return PTR_ERR(nfc->reg_base); =20
> >>   >> -	nfc->reg_clk =3D =20
> >> -		syscon_regmap_lookup_by_phandle(dev->of_node,
> >> -						"amlogic,mmc-syscon");
> >> -	if (IS_ERR(nfc->reg_clk)) {
> >> -		dev_err(dev, "Failed to lookup clock base\n");
> >> -		return PTR_ERR(nfc->reg_clk);
> >> -	}
> >> +	nfc->sd_emmc_clock =3D devm_platform_ioremap_resource_byname(pdev, "=
emmc");
> >> +	if (IS_ERR(nfc->sd_emmc_clock))
> >> +		return PTR_ERR(nfc->sd_emmc_clock); =20
> >=20
> > While I agree this is much better than the previous solution, we cannot
> > break DT compatibility, so you need to try getting the emmc clock, but
> > if it fails you should fallback to the regmap lookup. =20
>=20
> ok, i will fix it next version. thanks.
>=20
> >  =20
> >>   >>   	irq =3D platform_get_irq(pdev, 0); =20
> >>   	if (irq < 0) =20
> >=20
> >=20
> > Thanks,
> > Miqu=C3=A8l
> >=20
> > . =20


Thanks,
Miqu=C3=A8l
