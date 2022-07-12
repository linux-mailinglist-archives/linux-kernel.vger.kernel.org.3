Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9773B5717B6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbiGLKzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiGLKzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:55:48 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14B5AE547;
        Tue, 12 Jul 2022 03:55:47 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AEA1D66018EA;
        Tue, 12 Jul 2022 11:55:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657623346;
        bh=DLaYxFIWkAJn3tcNqLPJQTGx0exX21x7gM2Ae11yJO0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KgNMfTrvhsabhWF0VV9IpRlpnGfR71xy9IgeIrpNj1LivRs3Na8RpMaZY8seKO0E4
         ab2DKzU/ShgM763rCC6mYbT1640gu3YdgpglBxYlKRFeXM75xYQXW9eXlhPhw4KSRP
         8dbAFK9rcyRkabSqgzlcjdbIXXznvYrgBilJGY3tL3pnL/EOSZS19dEPLEUehs7s0T
         H0XL4kVCA3j7HrORI3pWWH0lrj1HB5AmwlTUUNYFgG6JpSsjImikdGhSPTyiIG+ea7
         CKqwm0L5HdyYMt2HlopypX71p7/K9zamFpgZkAuZzC21BhsIt1+TZud8/cM514fgbv
         W1fX4d5aB9Gjw==
Message-ID: <473aa749-fcfe-bd38-0d83-95375aeef8a3@collabora.com>
Date:   Tue, 12 Jul 2022 12:55:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] clk: mediatek: Don't check HW status for mt8192/5's
 imp_iic_wrap clocks
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, kernel@collabora.com,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Ran Jianping <ran.jianping@zte.com.cn>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20220711205733.203963-1-nfraprado@collabora.com>
 <CAGXv+5Enkz20o8BLXmnCUBmB930sH+20U=XvTWA82neaiqqc2A@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5Enkz20o8BLXmnCUBmB930sH+20U=XvTWA82neaiqqc2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/07/22 12:44, Chen-Yu Tsai ha scritto:
> Hi,
> 
> On Tue, Jul 12, 2022 at 4:57 AM Nícolas F. R. A. Prado
> <nfraprado@collabora.com> wrote:
>>
>> The imp_iic_wrap clocks on mt8192/mt8195 require that the i2c_sel parent
>> clock be enabled before their hardware status can be checked. Since this
>> wasn't taken into account, reading from the clk_summary debugfs file
>> would cause the system to completely freeze.
>>
>> Assuming that this clock is managed only by the kernel, and not by any
>> firmware, simply drop the is_enabled() optional callback and instead
>> rely on the enable count for the imp_iic_wrap clocks.
> 
> That's the wrong way to go about it.
> 
> The I2C clocks already have the CLK_OPS_PARENT_ENABLE flag set. So the
> issue is that somewhere in the clk core, a piece of code is not honoring
> that flag.
> 
> And it seems that's in more than one place.
> 

Uhm, you're right. I gave my Tested-by, but not a Reviewed-by because I
wasn't really convinced about this solution being the best.

Now that I think of it, the solution may be as simple as:

clk.c

static bool clk_core_is_enabled(struct clk_core *core)
{
	bool ret = false;

	/*
	 * If this clock needs parent enabled, but its parent is
	 * off, we directly return false for two reasons:
	 * 1. This clock being enabled would be impossible
	 * 2. The platform may crash for unclocked access while
	 *    reading the status of this clock (where a .is_enabled
	 *    callback is provided).
	 */
	if (core->flags & CLK_OPS_PARENT_ENABLE &&
	    !clk_core_is_enabled(core->parent))
		return false;

	... etc etc etc ...
}

Nícolas, did you try this approach?

> Regards
> ChenYu
> 
>> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>>
>> ---
>>
>>   drivers/clk/mediatek/clk-gate.c                | 6 ++++++
>>   drivers/clk/mediatek/clk-gate.h                | 1 +
>>   drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c | 2 +-
>>   drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c | 2 +-
>>   4 files changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk-gate.c
>> index 421806236228..8e7c719a69b3 100644
>> --- a/drivers/clk/mediatek/clk-gate.c
>> +++ b/drivers/clk/mediatek/clk-gate.c
>> @@ -124,6 +124,12 @@ static void mtk_cg_disable_inv_no_setclr(struct clk_hw *hw)
>>          mtk_cg_clr_bit_no_setclr(hw);
>>   }
>>
>> +const struct clk_ops mtk_clk_gate_ops_setclr_counted = {
>> +       .enable         = mtk_cg_enable,
>> +       .disable        = mtk_cg_disable,
>> +};
>> +EXPORT_SYMBOL_GPL(mtk_clk_gate_ops_setclr_counted);
>> +
>>   const struct clk_ops mtk_clk_gate_ops_setclr = {
>>          .is_enabled     = mtk_cg_bit_is_cleared,
>>          .enable         = mtk_cg_enable,
>> diff --git a/drivers/clk/mediatek/clk-gate.h b/drivers/clk/mediatek/clk-gate.h
>> index d9897ef53528..b5502b2911f5 100644
>> --- a/drivers/clk/mediatek/clk-gate.h
>> +++ b/drivers/clk/mediatek/clk-gate.h
>> @@ -19,6 +19,7 @@ extern const struct clk_ops mtk_clk_gate_ops_setclr;
>>   extern const struct clk_ops mtk_clk_gate_ops_setclr_inv;
>>   extern const struct clk_ops mtk_clk_gate_ops_no_setclr;
>>   extern const struct clk_ops mtk_clk_gate_ops_no_setclr_inv;
>> +extern const struct clk_ops mtk_clk_gate_ops_setclr_counted;
>>
>>   struct mtk_gate_regs {
>>          u32 sta_ofs;
>> diff --git a/drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c b/drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c
>> index 700356ac6a58..900ee601169c 100644
>> --- a/drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c
>> +++ b/drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c
>> @@ -20,7 +20,7 @@ static const struct mtk_gate_regs imp_iic_wrap_cg_regs = {
>>
>>   #define GATE_IMP_IIC_WRAP(_id, _name, _parent, _shift)                 \
>>          GATE_MTK_FLAGS(_id, _name, _parent, &imp_iic_wrap_cg_regs, _shift,      \
>> -               &mtk_clk_gate_ops_setclr, CLK_OPS_PARENT_ENABLE)
>> +               &mtk_clk_gate_ops_setclr_counted, CLK_OPS_PARENT_ENABLE)
>>
>>   static const struct mtk_gate imp_iic_wrap_c_clks[] = {
>>          GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_C_I2C10, "imp_iic_wrap_c_i2c10", "infra_i2c0", 0),
>> diff --git a/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c b/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c
>> index fbc809d05072..e50a77b844f4 100644
>> --- a/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c
>> +++ b/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c
>> @@ -18,7 +18,7 @@ static const struct mtk_gate_regs imp_iic_wrap_cg_regs = {
>>
>>   #define GATE_IMP_IIC_WRAP(_id, _name, _parent, _shift)                         \
>>          GATE_MTK_FLAGS(_id, _name, _parent, &imp_iic_wrap_cg_regs, _shift,      \
>> -               &mtk_clk_gate_ops_setclr, CLK_OPS_PARENT_ENABLE)
>> +               &mtk_clk_gate_ops_setclr_counted, CLK_OPS_PARENT_ENABLE)
>>
>>   static const struct mtk_gate imp_iic_wrap_s_clks[] = {
>>          GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_S_I2C5, "imp_iic_wrap_s_i2c5", "top_i2c", 0),
>> --
>> 2.37.0
>>


