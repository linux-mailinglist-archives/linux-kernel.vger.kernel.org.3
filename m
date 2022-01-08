Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0B5488225
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 08:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbiAHHZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 02:25:26 -0500
Received: from box.trvn.ru ([194.87.146.52]:56037 "EHLO box.trvn.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233484AbiAHHZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 02:25:25 -0500
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 513EC4038B;
        Sat,  8 Jan 2022 12:25:19 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1641626721; bh=xSTjwXWm03zXFQo0llbV1rDWCB+tlvOs66q7D/jrNgg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=epAcW3haHkcxECO4fhpYKScBgMXqNlBNUG2+cW5jDomY+kcf0MDNq3gAPA6UuyXM+
         yKTgRwUYchNnwuexw8rggh7wSOkYc3Y9+bpc88nQd0ApHcJGU83jR2Sr0VFOtBljH7
         cX1o/eGahOki14stGjyeiRwDZNNms7owI7d4I/GVPv2IDaPLKRZp2sEeXv/HwQezBK
         fBujLPdT6vZNaoTMQ53mVYlaK3tvHE1r3HWMvb3vl5NM+L+vPrDCAVHjY8JRTYavWw
         hkSreKo+bgTthBvEbg+LMs6JYtRDbPAuECg5n1ZbNa0j1Cx0gf7Es7N4DRTiUUsPUe
         65q5iO/G5lgWA==
MIME-Version: 1.0
Date:   Sat, 08 Jan 2022 12:25:19 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linus.walleij@linaro.org, mturquette@baylibre.com,
        bjorn.andersson@linaro.org, agross@kernel.org, tdas@codeaurora.org,
        svarbanov@mm-sol.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 1/4] clk: qcom: clk-rcg2: Fail Duty-Cycle configuration if
 MND divider is not enabled.
In-Reply-To: <20220108005209.5140EC36AEB@smtp.kernel.org>
References: <20211209163720.106185-1-nikita@trvn.ru>
 <20211209163720.106185-2-nikita@trvn.ru>
 <20220108005209.5140EC36AEB@smtp.kernel.org>
Message-ID: <991533e0fddd6999c8a06a536ae57999@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Stephen Boyd писал(а) 08.01.2022 05:52:
> Quoting Nikita Travkin (2021-12-09 08:37:17)
>> In cases when MND is not enabled (e.g. when only Half Integer Divider is
>> used), setting D registers makes no effect. Fail instead of making
>> ineffective write.
>>
>> Fixes: 7f891faf596e ("clk: qcom: clk-rcg2: Add support for duty-cycle for RCG")
>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>> ---
>>  drivers/clk/qcom/clk-rcg2.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
>> index e1b1b426fae4..6964cf914b60 100644
>> --- a/drivers/clk/qcom/clk-rcg2.c
>> +++ b/drivers/clk/qcom/clk-rcg2.c
>> @@ -396,7 +396,7 @@ static int clk_rcg2_get_duty_cycle(struct clk_hw *hw, struct clk_duty *duty)
>>  static int clk_rcg2_set_duty_cycle(struct clk_hw *hw, struct clk_duty *duty)
>>  {
>>         struct clk_rcg2 *rcg = to_clk_rcg2(hw);
>> -       u32 notn_m, n, m, d, not2d, mask, duty_per;
>> +       u32 notn_m, n, m, d, not2d, mask, duty_per, cfg;
>>         int ret;
>>
>>         /* Duty-cycle cannot be modified for non-MND RCGs */
>> @@ -407,6 +407,11 @@ static int clk_rcg2_set_duty_cycle(struct clk_hw *hw, struct clk_duty *duty)
>>
>>         regmap_read(rcg->clkr.regmap, RCG_N_OFFSET(rcg), &notn_m);
>>         regmap_read(rcg->clkr.regmap, RCG_M_OFFSET(rcg), &m);
>> +       regmap_read(rcg->clkr.regmap, RCG_CFG_OFFSET(rcg), &cfg);
>> +
>> +       /* Duty-cycle cannot be modified if MND divider is in bypass mode. */
>> +       if (!(cfg & CFG_MODE_MASK))
>> +               return -EINVAL;
> 
> Should we still allow 50% duty cycle to succeed?

*Technically* setting 50% duty cycle works since it's the default,
but how I understand it, the main way to get there is to call
clk_set_duty_cycle() which implies that it's caller intends
to control duty cycle specifically but the call doesn't actually
control anything as the hardware block is disabled.

I'm adding this error here primarily to bring attention of the
user (e.g. developer enabling some peripheral that needs
duty cycle control) who might have to change their clock tree
to make this control effective. So, assuming that if someone
sets the duty cycle to 50% then they might set it to some other
value later, it makes sense to fail the first call anyway.

If you think there are some other possibilities for this call
to happen specifically with 50% duty cycle (e.g. some
preparations or cleanups in the clk subsystem or some drivers
that I'm not aware of) then I can make an exemption in the check
for that.

Thanks,
Nikita
