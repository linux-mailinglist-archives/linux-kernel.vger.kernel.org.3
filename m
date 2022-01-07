Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7526748751F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 10:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346562AbiAGJ56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 04:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236788AbiAGJ55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 04:57:57 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15FDC061245
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 01:57:56 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id a5so6073074wrh.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 01:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1IZqUjWkbAq5US45cpfqtGiebAZUmtmT5YPBcyZTpRQ=;
        b=PqqVhMoj+owVCMG9LvSkPGWej+CULO18z3hWTH8JN1swEXM6y9F56L0zvPY7K8OFvJ
         2N1Z9B2szLF9MDrJo9W+KXDimF9Mzwb0Em4m4a+5AAz2f7U50P3ZXzJUgObtasB5n2EZ
         kEtV1vWisamtEtCZ1nhqfHe94rnrV8TL81kUL9Yj+meMV9tmu/3WBhHXK0oamsgulgtx
         DQ+W0/dmSzWPUWGpeeSvtTOtNxbwlpbcp2skQTGsHoDrOjqYU+8K9GuTa0r2lWR/SzhF
         L58ZMLExzOvMC6Pa0H2I1xGl9VD9tF+ruLBQ6R1wqkMGUFzbKSjoGCiF7QM7aohCn+Zo
         keSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=1IZqUjWkbAq5US45cpfqtGiebAZUmtmT5YPBcyZTpRQ=;
        b=SSZ8rVpGonY/kDLvDmIcNTZKirpYDu88BzN8E228Wxg7n1kRICH51GIg9bDfLsmclF
         YZ0Cxu7f7ut78P3l/xfmFJvaRGx1fu8btDxKnmZdYZisAQ2Txo1esNyiKBRk5y6Nnd8L
         uwSzhx362osixuMRZcDEkSEAuUpcqqQR0nG3og8q9UBzZlQWjKGQzK1wct+y/FnIoMKm
         mlVKZXBdCdP2J4vfKFiPNaUvtz5j9THj0IIhooSrnmPhGRdBbAqEETzP9HwkJUVDDUHn
         quxeF+VZ38xL/mtRrZ/ccVia3I1XRQgZ7njPC9XI4l6OezzAPybBBixO/ddBT3pSpvQ/
         /D6A==
X-Gm-Message-State: AOAM5310Pm1JVrhKf8h/J927KROLdxpuEN47yexXNnF5h/aEFI7LBROS
        TSSFrq3/iIXJ3i/nMcVbvV5xbQ==
X-Google-Smtp-Source: ABdhPJwqJEuT0JFejp8EPqzyDrgnX7FMMBSUmdMavSGj5nLKDwzESb6ifT38tWza0qvIrB/hDGQI4Q==
X-Received: by 2002:a5d:4207:: with SMTP id n7mr51825264wrq.708.1641549475022;
        Fri, 07 Jan 2022 01:57:55 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:fc89:e826:8938:cbde? ([2001:861:44c0:66c0:fc89:e826:8938:cbde])
        by smtp.gmail.com with ESMTPSA id m17sm4251854wrw.11.2022.01.07.01.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jan 2022 01:57:54 -0800 (PST)
Subject: Re: [PATCH] mtd: rawnand: meson: fix the clock after discarding
 sd_emmc_c_clkc
To:     Liang Yang <liang.yang@amlogic.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org
Cc:     Richard Weinberger <richard@nod.at>,
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
References: <20220106032504.23310-1-liang.yang@amlogic.com>
 <1jfsq1z22l.fsf@starbuckisacylon.baylibre.com>
 <151ded4b-a28b-dac9-31e1-5b817cd9dc44@amlogic.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <e4942f0e-3670-fb52-5cfa-b131a037320a@baylibre.com>
Date:   Fri, 7 Jan 2022 10:57:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <151ded4b-a28b-dac9-31e1-5b817cd9dc44@amlogic.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07/01/2022 05:04, Liang Yang wrote:
> Hi Jerome,
> 
> On 2022/1/6 16:16, Jerome Brunet wrote:
>> [ EXTERNAL EMAIL ]
>>
>>
>> On Thu 06 Jan 2022 at 11:25, Liang Yang <liang.yang@amlogic.com> wrote:
>>
>>> Because EMMC and NAND have the same control clock register, so we
>>> implement a 'sd_emmc_c_clkc'. Previously DTS is defined as below:
>>>
>>>     sd_emmc_c_clkc: mmc@7000 {
>>>         compatible = "amlogic,meson-axg-mmc-clkc", "syscon";
>>>         reg = <0x0 0x7000 0x0 0x800>;
>>>     };
>>>
>>>     nand-controller@7800 {
>>>         ......
>>>
>>>         clocks = <&clkc CLKID_SD_EMMC_C>,
>>>             <&sd_emmc_c_clkc CLKID_MMC_DIV>,
>>>             <&sd_emmc_c_clkc CLKID_MMC_PHASE_RX>,
>>>             <&sd_emmc_c_clkc CLKID_MMC_PHASE_TX>;
>>>         clock-names = "core", "device", "rx", "tx";
>>>         amlogic,mmc-syscon = <&sd_emmc_c_clkc>;
>>>
>>>         ......
>>>     }
>>>
>>> but in fact, above implementation is rejected. so now registering
>>> a nand_divider.
>>
>> Can you give a bit of context ? a link to the discussion rejecting this
>>
> Maybe I mistake the meaning of [jianxin.pan@amlogic.com], so i need him to clarify it.
>> As far as remember, things were getting done for A1 and stopped before
>> clock part was finished. I'm saying the change is wrong, just that a
>> discussion is needed before a decision is made.
>>
> ok.
> previous discussion in this link:
> https://lore.kernel.org/all/86789d73-5a6c-7729-ecd1-dcd342b2fcde@amlogic.com/
> it never go on since v6.

Looking at the serie I don't see any major blockers, if you're willing to take ownership
of this patchset and send a v6 with all issues/comments addressed, it would be easier than
restarting the whole design discussion

Neil

> 
>>>
>>> Change-Id: Ibeb4c7ff886f5886aac4d6c664d7bbd1b1bcb997
>>> Signed-off-by: Liang Yang <liang.yang@amlogic.com>
>>> ---
>>>   drivers/mtd/nand/raw/meson_nand.c | 88 +++++++++++++++++--------------
>>>   1 file changed, 49 insertions(+), 39 deletions(-)
>>>
>>> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
>>> index ac3be92872d0..4472363059c2 100644
>>> --- a/drivers/mtd/nand/raw/meson_nand.c
>>> +++ b/drivers/mtd/nand/raw/meson_nand.c
>>> @@ -2,7 +2,7 @@
>>>   /*
>>>    * Amlogic Meson Nand Flash Controller Driver
>>>    *
>>> - * Copyright (c) 2018 Amlogic, inc.
>>> + * Copyright (c) 2018-2021 Amlogic, inc.
>>>    * Author: Liang Yang <liang.yang@amlogic.com>
>>>    */
>>>   @@ -10,6 +10,7 @@
>>>   #include <linux/dma-mapping.h>
>>>   #include <linux/interrupt.h>
>>>   #include <linux/clk.h>
>>> +#include <linux/clk-provider.h>
>>>   #include <linux/mtd/rawnand.h>
>>>   #include <linux/mtd/mtd.h>
>>>   #include <linux/mfd/syscon.h>
>>> @@ -55,6 +56,7 @@
>>>   #define NFC_REG_VER        0x38
>>>     #define NFC_RB_IRQ_EN        BIT(21)
>>> +#define NFC_CMD_FIFO_RESET    BIT(31)
>>>     #define CMDRWGEN(cmd_dir, ran, bch, short_mode, page_size, pages)    \
>>>       (                                \
>>> @@ -104,6 +106,9 @@
>>>     #define PER_INFO_BYTE        8
>>>   +#define CLK_DIV_SHIFT        0
>>> +#define CLK_DIV_WIDTH        6
>>> +
>>>   struct meson_nfc_nand_chip {
>>>       struct list_head node;
>>>       struct nand_chip nand;
>>> @@ -151,15 +156,15 @@ struct meson_nfc {
>>>       struct nand_controller controller;
>>>       struct clk *core_clk;
>>>       struct clk *device_clk;
>>> -    struct clk *phase_tx;
>>> -    struct clk *phase_rx;
>>
>> I would have been nice to explain why these clock are no longer
>> required, in the change description maybe ?
> 
> i got the reply from our vlsi members that rx and tx doesn't make sense to meson NFC timing. so previous commit about this should be wrong.
>>
>>> +    struct clk *nand_clk;
>>> +    struct clk_divider nand_divider;
>>>         unsigned long clk_rate;
>>>       u32 bus_timing;
>>>         struct device *dev;
>>>       void __iomem *reg_base;
>>> -    struct regmap *reg_clk;
>>> +    void __iomem *reg_clk;
>>>       struct completion completion;
>>>       struct list_head chips;
>>>       const struct meson_nfc_data *data;
>>> @@ -406,12 +411,14 @@ static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms)
>>>       cmd = NFC_CMD_RB | NFC_CMD_RB_INT
>>>           | nfc->param.chip_select | nfc->timing.tbers_max;
>>>       writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>> -
>>> +    meson_nfc_drain_cmd(nfc);
>>
>> is this clock related ?
> ok, i will split it in another patch.
>>
>>>       ret = wait_for_completion_timeout(&nfc->completion,
>>>                         msecs_to_jiffies(timeout_ms));
>>>       if (ret == 0)
>>>           ret = -1;
>>>   +    /* reset command fifo to avoid lock */
>>> +    writel(NFC_CMD_FIFO_RESET, nfc->reg_base + NFC_REG_CMD);
>>
>> Again, not seem to be clock related - does not belong in this patch
> ok, i will split it in another patch.
>>
>>>       return ret;
>>>   }
>>>   @@ -988,8 +995,9 @@ static const struct mtd_ooblayout_ops meson_ooblayout_ops = {
>>>   static int meson_nfc_clk_init(struct meson_nfc *nfc)
>>>   {
>>>       int ret;
>>> +    struct clk_init_data init = {0};
>>> +    const char *fix_div2_pll_name[1];
>>>   -    /* request core clock */
>>
>> Why is the comment bothering you ?
>>
>>>       nfc->core_clk = devm_clk_get(nfc->dev, "core");
>>>       if (IS_ERR(nfc->core_clk)) {
>>>           dev_err(nfc->dev, "failed to get core clock\n");
>>> @@ -1002,21 +1010,25 @@ static int meson_nfc_clk_init(struct meson_nfc *nfc)
>>>           return PTR_ERR(nfc->device_clk);
>>>       }
>>>   -    nfc->phase_tx = devm_clk_get(nfc->dev, "tx");
>>> -    if (IS_ERR(nfc->phase_tx)) {
>>> -        dev_err(nfc->dev, "failed to get TX clk\n");
>>> -        return PTR_ERR(nfc->phase_tx);
>>> -    }
>>> -
>>> -    nfc->phase_rx = devm_clk_get(nfc->dev, "rx");
>>> -    if (IS_ERR(nfc->phase_rx)) {
>>> -        dev_err(nfc->dev, "failed to get RX clk\n");
>>> -        return PTR_ERR(nfc->phase_rx);
>>> -    }
>>> +    init.name = devm_kstrdup(nfc->dev, "nfc#div", GFP_KERNEL);
>>> +    init.ops = &clk_divider_ops;
>>> +    fix_div2_pll_name[0] = __clk_get_name(nfc->device_clk);
>>
>> You should be using "fw_name" so CCF looks a DT directly, instead of this
> ok
>>
>>> +    init.parent_names = fix_div2_pll_name;
>>> +    init.num_parents = 1;
>>> +    nfc->nand_divider.reg = nfc->reg_clk;
>>> +    nfc->nand_divider.shift = CLK_DIV_SHIFT;
>>> +    nfc->nand_divider.width = CLK_DIV_WIDTH;
>>> +    nfc->nand_divider.hw.init = &init;
>>> +    nfc->nand_divider.flags = CLK_DIVIDER_ONE_BASED |
>>> +                  CLK_DIVIDER_ROUND_CLOSEST |
>>> +                        CLK_DIVIDER_ALLOW_ZERO;
>>> +
>>> +    nfc->nand_clk = devm_clk_register(nfc->dev, &nfc->nand_divider.hw);
>>> +    if (IS_ERR(nfc->nand_clk))
>>> +        return PTR_ERR(nfc->nand_clk);
>>>         /* init SD_EMMC_CLOCK to sane defaults w/min clock rate */
>>> -    regmap_update_bits(nfc->reg_clk,
>>> -               0, CLK_SELECT_NAND, CLK_SELECT_NAND);
>>> +    writel(CLK_SELECT_NAND | readl(nfc->reg_clk), nfc->reg_clk);
>>>         ret = clk_prepare_enable(nfc->core_clk);
>>>       if (ret) {
>>> @@ -1030,29 +1042,21 @@ static int meson_nfc_clk_init(struct meson_nfc *nfc)
>>>           goto err_device_clk;
>>>       }
>>>   -    ret = clk_prepare_enable(nfc->phase_tx);
>>> +    ret = clk_prepare_enable(nfc->nand_clk);
>>>       if (ret) {
>>> -        dev_err(nfc->dev, "failed to enable TX clock\n");
>>> -        goto err_phase_tx;
>>> -    }
>>> -
>>> -    ret = clk_prepare_enable(nfc->phase_rx);
>>> -    if (ret) {
>>> -        dev_err(nfc->dev, "failed to enable RX clock\n");
>>> -        goto err_phase_rx;
>>> +        dev_err(nfc->dev, "pre enable NFC divider fail\n");
>>> +        goto err_nand_clk;
>>>       }
>>>         ret = clk_set_rate(nfc->device_clk, 24000000);
>>>       if (ret)
>>> -        goto err_disable_rx;
>>> +        goto err_disable_clk;
>>>         return 0;
>>>   -err_disable_rx:
>>> -    clk_disable_unprepare(nfc->phase_rx);
>>> -err_phase_rx:
>>> -    clk_disable_unprepare(nfc->phase_tx);
>>> -err_phase_tx:
>>> +err_disable_clk:
>>> +    clk_disable_unprepare(nfc->nand_clk);
>>> +err_nand_clk:
>>>       clk_disable_unprepare(nfc->device_clk);
>>>   err_device_clk:
>>>       clk_disable_unprepare(nfc->core_clk);
>>> @@ -1061,8 +1065,7 @@ static int meson_nfc_clk_init(struct meson_nfc *nfc)
>>>     static void meson_nfc_disable_clk(struct meson_nfc *nfc)
>>>   {
>>> -    clk_disable_unprepare(nfc->phase_rx);
>>> -    clk_disable_unprepare(nfc->phase_tx);
>>> +    clk_disable_unprepare(nfc->nand_clk);
>>>       clk_disable_unprepare(nfc->device_clk);
>>>       clk_disable_unprepare(nfc->core_clk);
>>>   }
>>> @@ -1375,6 +1378,7 @@ static int meson_nfc_probe(struct platform_device *pdev)
>>>       struct device *dev = &pdev->dev;
>>>       struct meson_nfc *nfc;
>>>       struct resource *res;
>>> +    u32 ext_clk_reg;
>>>       int ret, irq;
>>>         nfc = devm_kzalloc(dev, sizeof(*nfc), GFP_KERNEL);
>>> @@ -1396,9 +1400,15 @@ static int meson_nfc_probe(struct platform_device *pdev)
>>>       if (IS_ERR(nfc->reg_base))
>>>           return PTR_ERR(nfc->reg_base);
>>>   -    nfc->reg_clk =
>>> -        syscon_regmap_lookup_by_phandle(dev->of_node,
>>> -                        "amlogic,mmc-syscon");
>>> +    ret = of_property_read_u32(pdev->dev.of_node,
>>> +                   "sd_emmc_c_clkc",
>>> +                   &ext_clk_reg);
>>> +    if (ret) {
>>> +        dev_err(dev, "failed to get NAND external clock register\n");
>>> +        return ret;
>>> +    }
>>> +
>>> +    nfc->reg_clk = devm_ioremap(&pdev->dev, ext_clk_reg, sizeof(int));
>>
>> That's how you should get a register region.
>> If you want an example of a device claiming several region on amlogic,
>> have a look at the pinctrl driver.
> ok
>>
>>>       if (IS_ERR(nfc->reg_clk)) {
>>>           dev_err(dev, "Failed to lookup clock base\n");
>>>           return PTR_ERR(nfc->reg_clk);
>>
>> .

