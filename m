Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEC44901ED
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 07:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbiAQGYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 01:24:34 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:60889 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234661AbiAQGYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 01:24:32 -0500
Received: from [10.28.39.106] (10.28.39.106) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 17 Jan
 2022 14:24:28 +0800
Message-ID: <fe77fd6b-788f-1694-f260-f95e54cf4ef3@amlogic.com>
Date:   Mon, 17 Jan 2022 14:24:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v9 4/4] clk: meson: add sub MMC clock controller driver
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-clk@vger.kernel.org>
CC:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        YongHui Yu <yonghui.yu@amlogic.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20220113115745.45826-1-liang.yang@amlogic.com>
 <20220113115745.45826-5-liang.yang@amlogic.com>
 <20220113213513.9819AC36AEA@smtp.kernel.org>
 <09ff9044-9abc-d1ad-26c1-5e6ece56d30c@amlogic.com>
 <20220114230130.35EAAC36AE7@smtp.kernel.org>
From:   Liang Yang <liang.yang@amlogic.com>
In-Reply-To: <20220114230130.35EAAC36AE7@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.28.39.106]
X-ClientProxiedBy: mail-sz.amlogic.com (10.28.11.5) To mail-sz.amlogic.com
 (10.28.11.5)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/1/15 7:01, Stephen Boyd wrote:
> [ EXTERNAL EMAIL ]
> 
> Quoting Liang Yang (2022-01-13 21:14:46)
>> On 2022/1/14 5:35, Stephen Boyd wrote:
>>> Quoting Liang Yang (2022-01-13 03:57:45)
>>>> diff --git a/drivers/clk/meson/mmc-clkc.c b/drivers/clk/meson/mmc-clkc.c
>>>> new file mode 100644
>>>> index 000000000000..f53977f61390
>>>> --- /dev/null
>>>> +++ b/drivers/clk/meson/mmc-clkc.c
>>>> @@ -0,0 +1,300 @@
> [..]
>>>> +
>>>> +static int mmc_clkc_probe(struct platform_device *pdev)
>>>> +{
>>>> +       struct clk_hw_onecell_data *onecell_data;
>>>> +       struct device *dev = &pdev->dev;
>>>> +       struct mmc_clkc_data *data;
>>>> +       struct regmap *map;
>>>> +       struct clk_regmap *clk, *core;
>>>> +       struct meson_sclk_div_data *div_data;
>>>> +
>>>> +       /*cast to drop the const in match->data*/
>>>
>>> Space after *, also why do we need to cast away const? The user of this
>>> pointer passes it all the way down to mmc_clkc_register_clk() which
>>> could take the data as const void pointer and decide to cast away const
>>> there.
>>
>> if use 'const' here, it  will report a warning:
>> drivers/clk/meson/mmc-clkc.c:224:7: error: assignment discards ‘const’
>> qualifier from pointer targe
>> t type [-Werror=discarded-qualifiers]
>>
>>     data = (const struct mmc_clkc_data *)of_device_get_match_data(dev);
> 
> Of course. The type declaration up above needs const added to it.The parm of mmc_clkc_register_clk_with_parent(...., void *data) does not 
have 'const', so make the type declaration cause a further 'const' cast 
warning. Could i copy these infos just like below:

struct mmc_clkc_data *data_clkc;
......
data = of_device_get_match_data(dev);
data_clkc = devm_kmalloc(dev, sizeof(*data_clkc), GFP_KERNEL);
memcpy(data_clkc, data, sizeof(*data_clkc));
......
clk = mmc_clkc_register_clk_with_parent(...., &data_clkc->rx);

> 
> .
