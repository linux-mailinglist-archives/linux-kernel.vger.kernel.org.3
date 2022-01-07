Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0A24873CC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 08:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbiAGH5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 02:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235102AbiAGH5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 02:57:53 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8863DC061201
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 23:57:52 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id p1-20020a1c7401000000b00345c2d068bdso4917056wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 23:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=PZin4roehuy60w/tXe1ZRViR91oJ0PvjdCYYB9vWsO0=;
        b=X9IIrroc8lo2re/A4caFdNBUy+S6M8LRgRU5Plrcg5XEpPoII5BzUKky1Vg7nDHyfb
         dvSw6ourztg69nN3XIrREXTt6zEsJFaO/DjXr5rOZ3zDFmA2zTOn1FOhiRDaqSwyTF5D
         EQDizcnot0yXt8NWcVaRfg4FPWwQ2Dmu8DGv4YkZxh/twjNR8KRnsYwt1Nyt1XG7pCFs
         U5lLY8hjOkes6/NUueVWrTxtCNQz85f0icQEJFZOyHKyw1J2ZsITmi9Yw4r5WbTUeMj1
         fpImmFdBd531Qq03XZ9LOzfo5lkRUTxwr30kl6n7U8CpLB/ED+MljDvNe8SsOgVXXqk4
         s7Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=PZin4roehuy60w/tXe1ZRViR91oJ0PvjdCYYB9vWsO0=;
        b=UWfDjhdKRDjvLCrXTha2H5ODzpKXrEfiea8+wpHZZ2720LGFEQXntmeMT1V3uqLMZO
         9CZZYoFKkQNGnZgqaLw2gS0u+h7ubdt7fAq0cvU+ovk7Zi+wmOPRNisqq9gnDBKs1UjE
         uggCHFPAbfwJXNnAHbgtoxhjPtsitK1Kcb6D60D2MhhAkdomk1zcqnCfFtwNSqqALajk
         8PfKLMlgWmPOPbRsF9IxtdFGynfV+7MtjUNLoEFIE6JvR+vamLDm2ESdedIwkfkAOmDr
         prI7oJJEDmgg0Pv4HCx7XYKs5gfd3gY6YLk6pghYgF13QAOCzzjaI4hD7eBP1yIBjhk8
         BnFg==
X-Gm-Message-State: AOAM532tezhT+4zv8cY9MEYxpyhW8FZ20DuENHoi9KYcjw06eB/KSKBg
        dthSnElLIEiyKoUXdbAQwPMgnw==
X-Google-Smtp-Source: ABdhPJwtBdMIeiodKdeoSQMrZoVjent3jw2+2omXR6wxmVNKhxDgRcKQsAz37FN/Ls/dk9hFX2j42g==
X-Received: by 2002:a1c:a788:: with SMTP id q130mr5421043wme.68.1641542271018;
        Thu, 06 Jan 2022 23:57:51 -0800 (PST)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id e18sm4856688wrx.36.2022.01.06.23.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 23:57:50 -0800 (PST)
References: <20220106032504.23310-1-liang.yang@amlogic.com>
 <20220106090832.42225c49@xps13>
 <9c7b1d77-cff1-b40c-6d02-f67ca8b9b683@amlogic.com>
User-agent: mu4e 1.6.10; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        YongHui Yu <yonghui.yu@amlogic.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: meson: fix the clock after discarding
 sd_emmc_c_clkc
Date:   Fri, 07 Jan 2022 08:54:45 +0100
In-reply-to: <9c7b1d77-cff1-b40c-6d02-f67ca8b9b683@amlogic.com>
Message-ID: <1jh7agou4i.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 07 Jan 2022 at 10:40, Liang Yang <liang.yang@amlogic.com> wrote:

> Hi Miquel,
>
> Meson NFC clock depends on the implementation of sd_emmc_c_clkc, but i
> don't find the commit in
> linux mainline. then the information i got from [jianxin.pan@amlogic.com]
> is the rejection of
> serial patches. I just look into the corresponding emails in link:
>
> https://lore.kernel.org/all/86789d73-5a6c-7729-ecd1-dcd342b2fcde@amlogic.=
com/
> it seems the patch never go on since V6, so [jianxin.pan@amlogic.com],
> could you help to clear it?
> let us address the discussion in another email from
> [jbrunet@baylibre.com].

That V6 was "rejected" because some comments from thre V5 were still not
addressed.=20

>
> On 2022/1/6 16:08, Miquel Raynal wrote:
>> [ EXTERNAL EMAIL ]
>> Hi Liang,
>> liang.yang@amlogic.com wrote on Thu, 6 Jan 2022 11:25:04 +0800:
>>=20
>>> Because EMMC and NAND have the same control clock register, so we
>>> implement a 'sd_emmc_c_clkc'. Previously DTS is defined as below:
>>>
>>> 	sd_emmc_c_clkc: mmc@7000 {
>>> 		compatible =3D "amlogic,meson-axg-mmc-clkc", "syscon";
>>> 		reg =3D <0x0 0x7000 0x0 0x800>;
>>> 	};
>>>
>>> 	nand-controller@7800 {
>>> 		......
>>>
>>> 		clocks =3D <&clkc CLKID_SD_EMMC_C>,
>>> 			<&sd_emmc_c_clkc CLKID_MMC_DIV>,
>>> 			<&sd_emmc_c_clkc CLKID_MMC_PHASE_RX>,
>>> 			<&sd_emmc_c_clkc CLKID_MMC_PHASE_TX>;
>>> 		clock-names =3D "core", "device", "rx", "tx";
>>> 		amlogic,mmc-syscon =3D <&sd_emmc_c_clkc>;
>>>
>>> 		......
>>> 	}
>>>
>>> but in fact, above implementation is rejected. so now registering
>>> a nand_divider.
>> What is rejected?
>> Why is it rejected?
>> What is nand_divider?
> i simplify our clock framework below, so nand divider is SD_EMMC_CLOCK[5:=
0]
> here.
> 			   -----          -----		    -----
> 	   the other------|	\        |     |	   |	 |
>          		  | mux	| -----  |  N  | ----------| NFC/|
> 	   FCLK_DIV2------|     |        |     |	   | EMMC|
> 			   -----/         ----- 	    -----
> 		    SD_EMMC_CLOCK[7:6] SD_EMMC_CLOCK[5:0]
>>=20
>>>
>>> Change-Id: Ibeb4c7ff886f5886aac4d6c664d7bbd1b1bcb997
>> Change Ids are not expected in the upstream kernel.
>> But if you fix something you should have a Fixes:.
>>=20
>>> Signed-off-by: Liang Yang <liang.yang@amlogic.com>
>>> ---
>>>   drivers/mtd/nand/raw/meson_nand.c | 88 +++++++++++++++++--------------
>>>   1 file changed, 49 insertions(+), 39 deletions(-)
>>>
>>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/m=
eson_nand.c
>>> index ac3be92872d0..4472363059c2 100644
>>> --- a/drivers/mtd/nand/raw/meson_nand.c
>>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>>> @@ -2,7 +2,7 @@
>>>   /*
>>>    * Amlogic Meson Nand Flash Controller Driver
>>>    *
>>> - * Copyright (c) 2018 Amlogic, inc.
>>> + * Copyright (c) 2018-2021 Amlogic, inc.
>>>    * Author: Liang Yang <liang.yang@amlogic.com>
>>>    */
>>>   @@ -10,6 +10,7 @@
>>>   #include <linux/dma-mapping.h>
>>>   #include <linux/interrupt.h>
>>>   #include <linux/clk.h>
>>> +#include <linux/clk-provider.h>
>>>   #include <linux/mtd/rawnand.h>
>>>   #include <linux/mtd/mtd.h>
>>>   #include <linux/mfd/syscon.h>
>>> @@ -55,6 +56,7 @@
>>>   #define NFC_REG_VER		0x38
>>>     #define NFC_RB_IRQ_EN		BIT(21)
>>> +#define NFC_CMD_FIFO_RESET	BIT(31)
>>>     #define CMDRWGEN(cmd_dir, ran, bch, short_mode, page_size, pages)
>>> \
>>>   	(								\
>>> @@ -104,6 +106,9 @@
>>>     #define PER_INFO_BYTE		8
>>>   +#define CLK_DIV_SHIFT		0
>>> +#define CLK_DIV_WIDTH		6
>>> +
>>>   struct meson_nfc_nand_chip {
>>>   	struct list_head node;
>>>   	struct nand_chip nand;
>>> @@ -151,15 +156,15 @@ struct meson_nfc {
>>>   	struct nand_controller controller;
>>>   	struct clk *core_clk;
>>>   	struct clk *device_clk;
>>> -	struct clk *phase_tx;
>>> -	struct clk *phase_rx;
>>> +	struct clk *nand_clk;
>>> +	struct clk_divider nand_divider;
>>>     	unsigned long clk_rate;
>>>   	u32 bus_timing;
>>>     	struct device *dev;
>>>   	void __iomem *reg_base;
>>> -	struct regmap *reg_clk;
>>> +	void __iomem *reg_clk;
>>>   	struct completion completion;
>>>   	struct list_head chips;
>>>   	const struct meson_nfc_data *data;
>>> @@ -406,12 +411,14 @@ static int meson_nfc_queue_rb(struct meson_nfc *n=
fc, int timeout_ms)
>>>   	cmd =3D NFC_CMD_RB | NFC_CMD_RB_INT
>>>   		| nfc->param.chip_select | nfc->timing.tbers_max;
>>>   	writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>> -
>>> +	meson_nfc_drain_cmd(nfc);
>>>   	ret =3D wait_for_completion_timeout(&nfc->completion,
>>>   					  msecs_to_jiffies(timeout_ms));
>>>   	if (ret =3D=3D 0)
>>>   		ret =3D -1;
>>>   +	/* reset command fifo to avoid lock */
>>> +	writel(NFC_CMD_FIFO_RESET, nfc->reg_base + NFC_REG_CMD);
>>>   	return ret;
>>>   }
>>>   @@ -988,8 +995,9 @@ static const struct mtd_ooblayout_ops
>>> meson_ooblayout_ops =3D {
>>>   static int meson_nfc_clk_init(struct meson_nfc *nfc)
>>>   {
>>>   	int ret;
>>> +	struct clk_init_data init =3D {0};
>>> +	const char *fix_div2_pll_name[1];
>>>   -	/* request core clock */
>>>   	nfc->core_clk =3D devm_clk_get(nfc->dev, "core");
>>>   	if (IS_ERR(nfc->core_clk)) {
>>>   		dev_err(nfc->dev, "failed to get core clock\n");
>>> @@ -1002,21 +1010,25 @@ static int meson_nfc_clk_init(struct meson_nfc =
*nfc)
>>>   		return PTR_ERR(nfc->device_clk);
>>>   	}
>>>   -	nfc->phase_tx =3D devm_clk_get(nfc->dev, "tx");
>>> -	if (IS_ERR(nfc->phase_tx)) {
>>> -		dev_err(nfc->dev, "failed to get TX clk\n");
>>> -		return PTR_ERR(nfc->phase_tx);
>>> -	}
>>> -
>>> -	nfc->phase_rx =3D devm_clk_get(nfc->dev, "rx");
>>> -	if (IS_ERR(nfc->phase_rx)) {
>>> -		dev_err(nfc->dev, "failed to get RX clk\n");
>>> -		return PTR_ERR(nfc->phase_rx);
>>> -	}
>>> +	init.name =3D devm_kstrdup(nfc->dev, "nfc#div", GFP_KERNEL);
>>> +	init.ops =3D &clk_divider_ops;
>>> +	fix_div2_pll_name[0] =3D __clk_get_name(nfc->device_clk);
>>> +	init.parent_names =3D fix_div2_pll_name;
>>> +	init.num_parents =3D 1;
>>> +	nfc->nand_divider.reg =3D nfc->reg_clk;
>>> +	nfc->nand_divider.shift =3D CLK_DIV_SHIFT;
>>> +	nfc->nand_divider.width =3D CLK_DIV_WIDTH;
>>> +	nfc->nand_divider.hw.init =3D &init;
>>> +	nfc->nand_divider.flags =3D CLK_DIVIDER_ONE_BASED |
>>> +				  CLK_DIVIDER_ROUND_CLOSEST |
>>> +          			  CLK_DIVIDER_ALLOW_ZERO;
>>> +
>>> +	nfc->nand_clk =3D devm_clk_register(nfc->dev, &nfc->nand_divider.hw);
>>> +	if (IS_ERR(nfc->nand_clk))
>>> +		return PTR_ERR(nfc->nand_clk);
>>>     	/* init SD_EMMC_CLOCK to sane defaults w/min clock rate */
>>> -	regmap_update_bits(nfc->reg_clk,
>>> -			   0, CLK_SELECT_NAND, CLK_SELECT_NAND);
>>> +	writel(CLK_SELECT_NAND | readl(nfc->reg_clk), nfc->reg_clk);
>>>     	ret =3D clk_prepare_enable(nfc->core_clk);
>>>   	if (ret) {
>>> @@ -1030,29 +1042,21 @@ static int meson_nfc_clk_init(struct meson_nfc =
*nfc)
>>>   		goto err_device_clk;
>>>   	}
>>>   -	ret =3D clk_prepare_enable(nfc->phase_tx);
>>> +	ret =3D clk_prepare_enable(nfc->nand_clk);
>>>   	if (ret) {
>>> -		dev_err(nfc->dev, "failed to enable TX clock\n");
>>> -		goto err_phase_tx;
>>> -	}
>>> -
>>> -	ret =3D clk_prepare_enable(nfc->phase_rx);
>>> -	if (ret) {
>>> -		dev_err(nfc->dev, "failed to enable RX clock\n");
>>> -		goto err_phase_rx;
>>> +		dev_err(nfc->dev, "pre enable NFC divider fail\n");
>>> +		goto err_nand_clk;
>>>   	}
>>>     	ret =3D clk_set_rate(nfc->device_clk, 24000000);
>>>   	if (ret)
>>> -		goto err_disable_rx;
>>> +		goto err_disable_clk;
>>>     	return 0;
>>>   -err_disable_rx:
>>> -	clk_disable_unprepare(nfc->phase_rx);
>>> -err_phase_rx:
>>> -	clk_disable_unprepare(nfc->phase_tx);
>>> -err_phase_tx:
>>> +err_disable_clk:
>>> +	clk_disable_unprepare(nfc->nand_clk);
>>> +err_nand_clk:
>>>   	clk_disable_unprepare(nfc->device_clk);
>>>   err_device_clk:
>>>   	clk_disable_unprepare(nfc->core_clk);
>>> @@ -1061,8 +1065,7 @@ static int meson_nfc_clk_init(struct meson_nfc *n=
fc)
>>>     static void meson_nfc_disable_clk(struct meson_nfc *nfc)
>>>   {
>>> -	clk_disable_unprepare(nfc->phase_rx);
>>> -	clk_disable_unprepare(nfc->phase_tx);
>>> +	clk_disable_unprepare(nfc->nand_clk);
>>>   	clk_disable_unprepare(nfc->device_clk);
>>>   	clk_disable_unprepare(nfc->core_clk);
>>>   }
>>> @@ -1375,6 +1378,7 @@ static int meson_nfc_probe(struct platform_device=
 *pdev)
>>>   	struct device *dev =3D &pdev->dev;
>>>   	struct meson_nfc *nfc;
>>>   	struct resource *res;
>>> +	u32 ext_clk_reg;
>>>   	int ret, irq;
>>>     	nfc =3D devm_kzalloc(dev, sizeof(*nfc), GFP_KERNEL);
>>> @@ -1396,9 +1400,15 @@ static int meson_nfc_probe(struct platform_devic=
e *pdev)
>>>   	if (IS_ERR(nfc->reg_base))
>>>   		return PTR_ERR(nfc->reg_base);
>>>   -	nfc->reg_clk =3D
>>> -		syscon_regmap_lookup_by_phandle(dev->of_node,
>>> -						"amlogic,mmc-syscon");
>>> +	ret =3D of_property_read_u32(pdev->dev.of_node,
>>> +				   "sd_emmc_c_clkc",
>>> +				   &ext_clk_reg);
>>> +	if (ret) {
>>> +		dev_err(dev, "failed to get NAND external clock register\n");
>>> +		return ret;
>>> +	}
>>> +
>>> +	nfc->reg_clk =3D devm_ioremap(&pdev->dev, ext_clk_reg, sizeof(int));
>>>   	if (IS_ERR(nfc->reg_clk)) {
>>>   		dev_err(dev, "Failed to lookup clock base\n");
>>>   		return PTR_ERR(nfc->reg_clk);
>>=20
>> Thanks,
>> Miqu=C3=A8l
>> .

