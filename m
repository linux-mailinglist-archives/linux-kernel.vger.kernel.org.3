Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C545A4C86
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 14:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiH2Mym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 08:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiH2MyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:54:17 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6C88D3FE
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 05:43:32 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id bv25so3002653wrb.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 05:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:to:from:user-agent
         :references:from:to:cc;
        bh=NuDtPSZGsUB4/CSpCp0BYNq4Z61X61IoPrDP4sjDs8g=;
        b=tVOpcOkvELJfESUge43zatRu60HyutEJwNjPUtTcK0b8tCXDTqoNHJzA+1GeV4GTAL
         n2Yy22KIjn+ZL600oAvGIjSrYbnKF8r0GgofyQHExGN3EfCkWxgmRD15EzP+/uJRNWvl
         hTiRvJvFDh+b4/TcaDF3QNmHPNSDMyGLa/mn+6okolljsh5ntht3lTYzZrr7kf399isW
         8Ht4xRmPqcMZ6FUO0UMd2r1K4GF3bCG13akL+s8+PQWFsbX1gDEm79P9+nFgRpttaZjY
         /ZLD4VD15lz0zukROxQF6NCkIgJXaQkQqO77sTESyfvICdWdsXDPelMjEQD0Q+z1S6ve
         nauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:to:from:user-agent
         :references:x-gm-message-state:from:to:cc;
        bh=NuDtPSZGsUB4/CSpCp0BYNq4Z61X61IoPrDP4sjDs8g=;
        b=jYj3V5TcPA5gBw5PNOW+QMgruLVbi9y8CNgNYKKNSQYN5dmu8jcHicz0/90cJhxGaa
         KpnmPiofj5jDYsj400t3L1eUL4TW7GsLOQGiw4OY1R9g/owaXaS2CO5bfgFpg6JCdE3D
         8/IcVDISOMOBsZ4fh2VRmVMRIMRbJ6/2fQRZYNESyF6At+JDTr084WGIgzE/oUfb6/Mt
         eFy+v/wf4g+8d+nfVbElHgjsmbKohpjWSRk7e97+P7OwpgDs0kcAATlnrIPCZX0tK0Lj
         S2O6UsiN7HNU/qbUP3qFvrsVM3OV/6+8xV0kJPGsl4vw1gAANuGmFS1bivKwiGt8fbB6
         QHgw==
X-Gm-Message-State: ACgBeo3aZfeh9Zb0bT54dxJas0UK41tn5cVta96+RfwjpF2bx8K6eo1Q
        qnvRMKOTvmB3GI15htSxR7wU4Q==
X-Google-Smtp-Source: AA6agR4g54C4i+JaM6ngjD20lfOuvr3Z3k/pbaJDJw1GAipj5i9NLSpSGO14T5zArba6MMO/CWoydw==
X-Received: by 2002:adf:ce08:0:b0:226:d1ba:3e23 with SMTP id p8-20020adfce08000000b00226d1ba3e23mr5679234wrn.374.1661777010387;
        Mon, 29 Aug 2022 05:43:30 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id v5-20020a5d59c5000000b002257fd37877sm7320643wry.6.2022.08.29.05.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 05:43:29 -0700 (PDT)
References: <20220805085716.5635-1-yu.tu@amlogic.com>
 <20220805085716.5635-7-yu.tu@amlogic.com>
 <1jedxlzxyz.fsf@starbuckisacylon.baylibre.com>
 <8f40cb49-fdc5-20cd-343b-8ce50e5d6d97@amlogic.com>
User-agent: mu4e 1.8.7; emacs 28.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Yu Tu <yu.tu@amlogic.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH V3 6/6] clk: meson: s4: add s4 SoC peripheral clock
 controller driver
Date:   Mon, 29 Aug 2022 14:19:15 +0200
In-reply-to: <8f40cb49-fdc5-20cd-343b-8ce50e5d6d97@amlogic.com>
Message-ID: <1j7d2rte33.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 16 Aug 2022 at 20:00, Yu Tu <yu.tu@amlogic.com> wrote:

Please trim your replies 

>>> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
>>> index f4244edc7b28..ec6beb9284d3 100644
>>> --- a/drivers/clk/meson/Kconfig
>>> +++ b/drivers/clk/meson/Kconfig
>>> @@ -127,4 +127,17 @@ config COMMON_CLK_S4_PLL
>>>   	  Support for the pll clock controller on Amlogic S805X2 and S905Y4 devices,
>>>   	  aka s4. Amlogic S805X2 and S905Y4 devices include AQ222 and AQ229.
>>>   	  Say Y if you want peripherals and CPU frequency scaling to work.
>>> +
>>> +config COMMON_CLK_S4
>>> +	tristate "S4 SoC Peripherals clock controllers support"
>>> +	depends on ARM64
>>> +	default y
>>> +	select COMMON_CLK_MESON_REGMAP
>>> +	select COMMON_CLK_MESON_DUALDIV
>>> +	select COMMON_CLK_MESON_VID_PLL_DIV
>>> +	select COMMON_CLK_S4_PLL
>> Do you really this ? your driver does not even include the related
>> header.
> If the PLL driver is not turned on in DTS, will it not cause an error?
>>

I don't get the question.
Kconfig list compile deps. S4 PLL is not a compile dep of the peripheral
controller.

If you really want to, you may use 'imply'.
>> 
>>> +static const struct clk_parent_data sys_ab_clk_parent_data[] = {
>>> +	{ .fw_name = "xtal" },
>>> +	{ .fw_name = "fclk_div2" },
>>> +	{ .fw_name = "fclk_div3" },
>>> +	{ .fw_name = "fclk_div4" },
>>> +	{ .fw_name = "fclk_div5" },
>>> +	{ .fw_name = "fclk_div7" },
>>> +	{ .hw = &s4_rtc_clk.hw }
>>> +};
>>> +
>>> +static struct clk_regmap s4_sysclk_b_sel = {
>>> +	.data = &(struct clk_regmap_mux_data){
>>> +		.offset = CLKCTRL_SYS_CLK_CTRL0,
>>> +		.mask = 0x7,
>>> +		.shift = 26,
>>> +		.table = mux_table_sys_ab_clk_sel,
>>> +	},
>>> +	.hw.init = &(struct clk_init_data){
>>> +		.name = "sysclk_b_sel",
>>> +		.ops = &clk_regmap_mux_ro_ops,
>> Why is this using the RO ops ?
> Sys_clk is initialized during the Uboot phase and is fixed at
> 166.666MHz. So I'm going to change it to ro.

That really much depends on the bootloader and is a pretty weak design.
The bootloader deps should be kept as minimal as possible.

I see no reason for RO. 

You may cut rate propagation on the user if you need to and continue to
whatever you want in your u-boot

>> 
>>> +		.parent_data = sys_ab_clk_parent_data,
>>> +		.num_parents = ARRAY_SIZE(sys_ab_clk_parent_data),
>>> +	},
>>> +};
>>> +
>>> +static struct clk_regmap s4_sysclk_b_div = {
>>> +	.data = &(struct clk_regmap_div_data){
>>> +		.offset = CLKCTRL_SYS_CLK_CTRL0,
>>> +		.shift = 16,
>>> +		.width = 10,
>>> +	},
>>> +	.hw.init = &(struct clk_init_data){
>>> +		.name = "sysclk_b_div",
>>> +		.ops = &clk_regmap_divider_ro_ops,
>> Same here and for the rest of the sys part
> Same above.

We can play that game for a while

>>> +
>>> +/* Video Clocks */
>>> +static struct clk_regmap s4_vid_pll_div = {
>>> +	.data = &(struct meson_vid_pll_div_data){
>>> +		.val = {
>>> +			.reg_off = CLKCTRL_VID_PLL_CLK_DIV,
>>> +			.shift   = 0,
>>> +			.width   = 15,
>>> +		},
>>> +		.sel = {
>>> +			.reg_off = CLKCTRL_VID_PLL_CLK_DIV,
>>> +			.shift   = 16,
>>> +			.width   = 2,
>>> +		},
>>> +	},
>>> +	.hw.init = &(struct clk_init_data) {
>>> +		.name = "vid_pll_div",
>>> +		.ops = &meson_vid_pll_div_ro_ops,
>> Why RO ? applies to the rest of the video part.
> Because vid_pll_div parent is HDMI_PLL, and HDMI_PLL is a fixed
> frequency. Flags is CLK_SET_RATE_PARENT. So we use RO.

If the HDMI_PLL is fixed somehow, that is not reason for this clock to
be RO

> Can I remove RO and use CLK_SET_RATE_NO_REPARENT instead, which one do you
> think is more reasonable?

Neither. CLK_SET_RATE_NO_REPARENT makes no sense, it is not mux

>
>> 
>>> +		.parent_data = (const struct clk_parent_data []) {
>>> +			{ .fw_name = "hdmi_pll", }
>>> +		},
>>> +		.num_parents = 1,
>>> +		.flags = CLK_SET_RATE_PARENT,
>>> +	},
>>> +};
>>> +
>>> +static struct clk_regmap s4_vid_pll_sel = {
>>> +	.data = &(struct clk_regmap_mux_data){
>>> +		.offset = CLKCTRL_VID_PLL_CLK_DIV,
>>> +		.mask = 0x1,
>>> +		.shift = 18,
>>> +	},
>>> +	.hw.init = &(struct clk_init_data){
>>> +		.name = "vid_pll_sel",
>>> +		.ops = &clk_regmap_mux_ops,
>>> +		/*
>>> +		 * bit 18 selects from 2 possible parents:
>>> +		 * vid_pll_div or hdmi_pll
>>> +		 */
>>> +		.parent_data = (const struct clk_parent_data []) {
>>> +			{ .hw = &s4_vid_pll_div.hw },
>>> +			{ .fw_name = "hdmi_pll", }
>>> +		},
>>> +		.num_parents = 2,
>>> +		.flags = CLK_SET_RATE_NO_REPARENT,
>> Why ? are you planning to DT assigned clocks to statically set this ?
> Because vid_pll_sel one parent is HDMI_PLL, and HDMI_PLL is a fixed
> frequency. To prevent modification, use CLK_SET_RATE_NO_REPARENT.

Again, this makes no sense.

>> 
>>> +	},
>>> +};
>>> +
>>> +static struct clk_regmap s4_vid_pll = {
>>> +	.data = &(struct clk_regmap_gate_data){
>>> +		.offset = CLKCTRL_VID_PLL_CLK_DIV,
>>> +		.bit_idx = 19,
>>> +	},
>>> +	.hw.init = &(struct clk_init_data) {
>>> +		.name = "vid_pll",
>>> +		.ops = &clk_regmap_gate_ops,
>>> +		.parent_hws = (const struct clk_hw *[]) {
>>> +			&s4_vid_pll_sel.hw
>>> +		},
>>> +		.num_parents = 1,
>>> +		.flags = CLK_SET_RATE_PARENT,
>>> +	},
>>> +};
>>> +
>>> +static const struct clk_parent_data s4_vclk_parent_data[] = {
>>> +	{ .hw = &s4_vid_pll.hw },
>>> +	{ .fw_name = "gp0_pll", },
>>> +	{ .fw_name = "hifi_pll", },
>>> +	{ .fw_name = "mpll1", },
>>> +	{ .fw_name = "fclk_div3", },
>>> +	{ .fw_name = "fclk_div4", },
>>> +	{ .fw_name = "fclk_div5", },
>>> +	{ .fw_name = "fclk_div7", },
>>> +};
>>> +
>>> +static struct clk_regmap s4_vclk_sel = {
>>> +	.data = &(struct clk_regmap_mux_data){
>>> +		.offset = CLKCTRL_VID_CLK_CTRL,
>>> +		.mask = 0x7,
>>> +		.shift = 16,
>>> +	},
>>> +	.hw.init = &(struct clk_init_data){
>>> +		.name = "vclk_sel",
>>> +		.ops = &clk_regmap_mux_ops,
>>> +		.parent_data = s4_vclk_parent_data,
>>> +		.num_parents = ARRAY_SIZE(s4_vclk_parent_data),
>>> +		.flags = CLK_SET_RATE_NO_REPARENT,
>> Same
> Since fclk_div* is a fixed frequency value, mplL1 and hifi_pll and gp0_pll
> are used by other specialized modules, vid_pll has CLK_SET_RATE_PARENT. The
> parent of vid_pll is that vid_pll_sel uses CLK_SET_RATE_NO_REPARENT.

Still not good.

You don't have CLK_SET_RATE, propagation is stopped and parent clock
will not changed. The best parent will be picked but not changed.

If one parent MUST NOT be picked, just remove it from the list and add a
explaining why

[...]

>>> +
>>> +static struct clk_regmap s4_ts_clk_div = {
>>> +	.data = &(struct clk_regmap_div_data){
>>> +		.offset = CLKCTRL_TS_CLK_CTRL,
>>> +		.shift = 0,
>>> +		.width = 8,
>>> +	},
>>> +	.hw.init = &(struct clk_init_data){
>>> +		.name = "ts_clk_div",
>>> +		.ops = &clk_regmap_divider_ops,
>>> +		.parent_data = &(const struct clk_parent_data) {
>>> +			.fw_name = "xtal",
>>> +		},
>>> +		.num_parents = 1,
>> propagation stopped ?
> Its parent is xtal, so I should use CLK_SET_RATE_NO_REPARENT.

Still no. You seem to have problem with the meaning of
CLK_SET_RATE_NO_REPARENT.

* CLK_SET_RATE_NO_REPARENT: means the parent will no be changed, even if
  selecting another parent would result in a closer rate to the
  request. It makes sense only if the clock has several parents

* CLK_SET_RATE_PARENT: means rate change may propagate the parent,
  meaning the rate of the parent may change if it help the child achieve
  a closer rate to the request

>> 
>>> +	},
>>> +};
>>> +
>>> +static struct clk_regmap s4_ts_clk_gate = {
>>> +	.data = &(struct clk_regmap_gate_data){
>>> +		.offset = CLKCTRL_TS_CLK_CTRL,
>>> +		.bit_idx = 8,
>>> +	},
>>> +	.hw.init = &(struct clk_init_data){
>>> +		.name = "ts_clk",
>>> +		.ops = &clk_regmap_gate_ops,
>>> +		.parent_hws = (const struct clk_hw *[]) {
>>> +			&s4_ts_clk_div.hw
>>> +		},
>>> +		.num_parents = 1,
>>> +	},
>> propagation stopped ?
> I will add CLK_SET_RATE_PARENT.

[...]

>>> +/* EMMC/NAND clock */
>>> +
>>> +static const struct clk_parent_data s4_sd_emmc_clk0_parent_data[] = {
>>> +	{ .fw_name = "xtal", },
>>> +	{ .fw_name = "fclk_div2", },
>>> +	{ .fw_name = "fclk_div3", },
>>> +	{ .fw_name = "hifi_pll", },
>>> +	{ .fw_name = "fclk_div2p5", },
>>> +	/*
>>> +	 * Following these parent clocks, we should also have had mpll2, mpll3
>>> +	 * and gp0_pll but these clocks are too precious to be used here. All
>>> +	 * the necessary rates for MMC and NAND operation can be acheived using
>>> +	 * hifi_pll or fclk_div clocks
>>> +	 */
>> You don't want to list mplls but hifi_pll is fine ? seems dangerous.
> hifi pll is for EMMC and NAND on this SoC.

That deserve a better explanation.
Why can't it use fdiv2 and xtal like the previous SoCs ?

Which PLLs are you using for Audio then ?
Typical operation on these SoCs usually require 3 PLLs to acheive all rates

>>


>>> +/*
>>> + * gen clk is designed for debug/monitor some internal clock quality. Some of the
>>> + * corresponding clock sources are not described in the clock tree, so they are skipped.
>>> + */
>> Still feels a bit light, don't you think ? Among all the clocks, can't
>> you add a bit more parents here ? It would certainly help debug down the road
> [16:12]	is gen_clk source select.All is:
> 0: cts_oscin_clk
> 1:cts_rtc_clk
> 2:sys_pll_div16 (internal clock)
> 3:ddr_pll_div32  (internal clock)
> 4: vid_pll
> 5: gp0_pll
> 7: hifi_pll
> 10:adc_dpll_clk_b3 (internal clock for debug)
> 11:adc_dpll_intclk (internal clock for debug)
> 12:clk_msr_src(select from all internal clock except PLLs);
> 16: no used
> 17: sys_cpu_clk_div16 (internal clock)
> 19: fclk_div2
> 20: fclk_div2p5
> 21: fclk_div3
> 22: fclk_div4
> 23: fclk_div5
> 24: fclk_div7
> 25: mpll0
> 26: mpll1
> 27: mpll2
> 28: mpll3
> So i only added the clocks that will actually be used, and some debugging
> clock peripherals will not be used.

you may at least add vid_pll

>> 
>>> +static u32 s4_gen_clk_mux_table[] = { 0, 5, 7, 19, 21, 22,
>>> +				      23, 24, 25, 26, 27, 28 };
>>> +static const struct clk_parent_data s4_gen_clk_parent_data[] = {
>>> +	{ .fw_name = "xtal", },
>>> +	{ .fw_name = "gp0_pll", },
>>> +	{ .fw_name = "hifi_pll", },
>>> +	{ .fw_name = "fclk_div2", },
>>> +	{ .fw_name = "fclk_div3", },
>>> +	{ .fw_name = "fclk_div4", },
>>> +	{ .fw_name = "fclk_div5", },
>>> +	{ .fw_name = "fclk_div7", },
>>> +	{ .fw_name = "mpll0", },
>>> +	{ .fw_name = "mpll1", },
>>> +	{ .fw_name = "mpll2", },
>>> +	{ .fw_name = "mpll3", },
>>> +};
