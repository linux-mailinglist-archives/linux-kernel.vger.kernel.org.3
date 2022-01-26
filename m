Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F98E49CDB8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 16:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242639AbiAZPO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 10:14:26 -0500
Received: from box.trvn.ru ([194.87.146.52]:55205 "EHLO box.trvn.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242627AbiAZPOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 10:14:25 -0500
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id C19254004F;
        Wed, 26 Jan 2022 20:14:21 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1643210062; bh=ZkAZXMIgqilPJj8e1mA63+BflcezAKtWBuHyp0zxpAg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HEHJK4TGhMCf8ucDJEoUAc1FrJh6B5rQImzxOguKYBmEcNx56wWEMAY+IvtoBhbTU
         rt/ZQBF/4yy8OelwqQDzpXLS/m+1AamP9gjgISLY7Xc8WgrrbasGd3iSdqaytbENn3
         YGFOrfOHFouCM/He5S2+plvRM0VNi/Kx0SpHz6F+Sz64f/mLlKn4yBfXmHEJoV4he3
         g3KrCE3zxxKRPDAM46f9OG3KsHmOP72s6OFuOuZJb43JDncFmIni59r3+L21b0ACB5
         BrQXkFYotElWxoDGuFe2Y5eTfs1rtZjalOR7Z9U/vSHvtWTueCGUs6v27nGpw15ci7
         MQoEjEOcjMG5g==
MIME-Version: 1.0
Date:   Wed, 26 Jan 2022 20:14:21 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linus.walleij@linaro.org, mturquette@baylibre.com,
        bjorn.andersson@linaro.org, agross@kernel.org, tdas@codeaurora.org,
        svarbanov@mm-sol.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 1/4] clk: qcom: clk-rcg2: Fail Duty-Cycle configuration if
 MND divider is not enabled.
In-Reply-To: <20220110201452.2B3E4C36AE3@smtp.kernel.org>
References: <20211209163720.106185-1-nikita@trvn.ru>
 <20211209163720.106185-2-nikita@trvn.ru>
 <20220108005209.5140EC36AEB@smtp.kernel.org>
 <991533e0fddd6999c8a06a536ae57999@trvn.ru>
 <20220110201452.2B3E4C36AE3@smtp.kernel.org>
Message-ID: <cc4241105bfd2249c1c309a4efa2e6aa@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Boyd писал(а) 11.01.2022 01:14:
> Quoting Nikita Travkin (2022-01-07 23:25:19)
>> Hi,
>>
>> Stephen Boyd писал(а) 08.01.2022 05:52:
>> > Quoting Nikita Travkin (2021-12-09 08:37:17)
>> I'm adding this error here primarily to bring attention of the
>> user (e.g. developer enabling some peripheral that needs
>> duty cycle control) who might have to change their clock tree
>> to make this control effective. So, assuming that if someone
>> sets the duty cycle to 50% then they might set it to some other
>> value later, it makes sense to fail the first call anyway.
>>
>> If you think there are some other possibilities for this call
>> to happen specifically with 50% duty cycle (e.g. some
>> preparations or cleanups in the clk subsystem or some drivers
>> that I'm not aware of) then I can make an exemption in the check
>> for that.
>>
> 
> I don't see anywhere in clk_set_duty_cycle() where it would bail out
> early if the duty cycle was set to what it already is. The default for
> these clks is 50%, so I worry that some driver may try to set the duty
> cycle to 50% and then fail now. Either we need to check the duty cycle
> in the core before calling down into the driver or we need to check it
> here in the driver. Can you send a patch to check the current duty cycle
> in the core before calling down into the clk ops?

Hi, sorry for a rather delayed response,
I spent a bit of time looking at how to make the clk core be
careful with ineffective duty-cycle calls and I can't find a
nice way to do this... My idea was something like this:

static int clk_core_set_duty_cycle_nolock(struct clk_core *core,
					  struct clk_duty *duty)
{	/* ... */

	/* Update core->duty values */
	clk_core_update_duty_cycle_nolock(core);

	if ( /* duty doesn't match core->duty */ ) {
		ret = core->ops->set_duty_cycle(core->hw, duty);
	/* ... */
}

However there seem to be drawbacks to any variant of the
comparison that I could come up with:

Naive one would be to do
    if (duty->num != core->duty->num || duty->den != core->duty->den)
but it won't correctly compare e.g. 1/2 and 10/20.

Other idea was to do
    if (duty->den / duty->num != core->duty->den / core->duty->num)
but it will likely fail with very close values (e.g. 100/500 and 101/500)

I briefly thought of some more sophisticated math but I don't
like the idea of complicating this too far.

I briefly grepped the kernel sources for duty-cycle related methods
and I saw only one user of the clk_set_duty_cycle:
    sound/soc/meson/axg-tdm-interface.c
Notably it sets the cycle to 1/2 in some cases, though it seems to
be tied to the drivers/clk/meson/sclk-div.c clock driver by being
the blocks of the same SoC.

Thinking of it a bit more, I saw another approach to the problem
I want to solve: Since I just want to make developers aware of the
hardware quirk, maybe I don't need to fail the set but just put a
WARN or even WARN_ONCE there? This way the behavior will be unchanged.

Thanks,
Nikita
