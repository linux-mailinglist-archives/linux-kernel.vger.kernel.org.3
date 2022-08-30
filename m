Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712E55A5D18
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiH3Hhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbiH3Hhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:37:33 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61182C650C;
        Tue, 30 Aug 2022 00:37:29 -0700 (PDT)
Received: from [10.18.29.47] (10.18.29.47) by mail-sh.amlogic.com (10.18.11.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.9; Tue, 30 Aug
 2022 15:37:26 +0800
Message-ID: <9f9cf980-c0c6-d5c3-ced8-8ab50e392470@amlogic.com>
Date:   Tue, 30 Aug 2022 15:37:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH V3 3/6] clk: meson: S4: add support for Amlogic S4 SoC PLL
 clock driver
Content-Language: en-US
To:     Jerome Brunet <jbrunet@baylibre.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220805085716.5635-1-yu.tu@amlogic.com>
 <20220805085716.5635-4-yu.tu@amlogic.com>
 <1jiln0yzgj.fsf@starbuckisacylon.baylibre.com>
 <ed4038fb-c230-fc27-800c-c99bd1770a1c@amlogic.com>
 <4e3cdd6b-5861-8a4f-1df7-af763f77bad5@amlogic.com>
 <1jsflftm1y.fsf@starbuckisacylon.baylibre.com>
 <0c7e6d90-2ce3-25ab-84b6-026ce8a238a8@amlogic.com>
 <1jtu5uz0ry.fsf@starbuckisacylon.baylibre.com>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <1jtu5uz0ry.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.18.29.47]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/8/30 14:44, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
> 
> 
> On Tue 30 Aug 2022 at 14:13, Yu Tu <yu.tu@amlogic.com> wrote:
> 
>> On 2022/8/29 17:48, Jerome Brunet wrote:
>>> [ EXTERNAL EMAIL ]
>>> On Mon 15 Aug 2022 at 21:20, Yu Tu <yu.tu@amlogic.com> wrote:
>>>
>>>>>>> +
>>>>>>> +static struct clk_regmap s4_hdmi_pll_dco = {
>>>>>>> +    .data = &(struct meson_clk_pll_data){
>>>>>>> +        .en = {
>>>>>>> +            .reg_off = ANACTRL_HDMIPLL_CTRL0,
>>>>>>> +            .shift   = 28,
>>>>>>> +            .width   = 1,
>>>>>>> +        },
>>>>>>> +        .m = {
>>>>>>> +            .reg_off = ANACTRL_HDMIPLL_CTRL0,
>>>>>>> +            .shift   = 0,
>>>>>>> +            .width   = 8,
>>>>>>> +        },
>>>>>>> +        .n = {
>>>>>>> +            .reg_off = ANACTRL_HDMIPLL_CTRL0,
>>>>>>> +            .shift   = 10,
>>>>>>> +            .width   = 5,
>>>>>>> +        },
>>>>>>> +        .frac = {
>>>>>>> +            .reg_off = ANACTRL_HDMIPLL_CTRL1,
>>>>>>> +            .shift   = 0,
>>>>>>> +            .width   = 17,
>>>>>>> +        },
>>>>>>> +        .l = {
>>>>>>> +            .reg_off = ANACTRL_HDMIPLL_CTRL0,
>>>>>>> +            .shift   = 31,
>>>>>>> +            .width   = 1,
>>>>>>> +        },
>>>>>>> +        .rst = {
>>>>>>> +            .reg_off = ANACTRL_HDMIPLL_CTRL0,
>>>>>>> +            .shift   = 29,
>>>>>>> +            .width   = 1,
>>>>>>> +        },
>>>>>>> +    },
>>>>>>> +    .hw.init = &(struct clk_init_data){
>>>>>>> +        .name = "hdmi_pll_dco",
>>>>>>> +        .ops = &meson_clk_pll_ro_ops,
>>>>>>> +        .parent_data = (const struct clk_parent_data []) {
>>>>>>> +            { .fw_name = "xtal", }
>>>>>>> +        },
>>>>>>> +        .num_parents = 1,
>>>>>>> +        /*
>>>>>>> +         * Display directly handle hdmi pll registers ATM, we need
>>>>>>> +         * NOCACHE to keep our view of the clock as accurate as
>>>>>>> +         * possible
>>>>>>> +         */
>>>>>>
>>>>>> Is it really ?
>>>>>>
>>>>>> Given that HDMI support for the s4 is there yet, the
>>>>>> addresses have changes and the region is no longer a syscon, it is time
>>>>>> for the HDMI driver to get fixed.
>>>> The HDMI PLL is configured in the Uboot phase and does not change the
>>>> frequency in the kernel phase. So we use the NOCACHE flag and
>>>> "ro_ops".
>>> That's no reason to put NOCACHE or ro-ops
>>> If you want the frequencies to be statically assinged, the correct way
>>> would be through assigned-rate in DT I guess.
>>
>> Okay. You're right. However, when registering with OPS, HDMI PLL will be
>> reset. It takes time for PLL to stabilize the output frequency, which will
>> lead to the startup screen flashing.
>>
>> I would like to know how to solve this problem if not using ro_ops.
>>
>>>
> 
> You can add new ops or tweak the current init function.

HDMI PLL is not different from other PLLS, so I think adding OPS is weird.

> 
> Safest would be to do the following :
>   * Check if the PLLs is already on.
>   * Check if the 'pll->init_regs' matches what is already set
>     - if so, you can skip the reset
>     - if not, you need to reset as usual

static int meson_clk_pll_init(struct clk_hw *hw) 

{ 

         struct clk_regmap *clk = to_clk_regmap(hw); 

         struct meson_clk_pll_data *pll = meson_clk_pll_data(clk); 

 

         if (pll->init_count) { 

                 meson_parm_write(clk->map, &pll->rst, 1); 

                 regmap_multi_reg_write(clk->map, pll->init_regs, 

                                 |      pll->init_count); 

                 meson_parm_write(clk->map, &pll->rst, 0); 

         } 

 

         return 0; 

}

Because the init function looks like this. Therefore, HDMI PLL 
init_count is not given. Can I change it like this?
