Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0F34BC604
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 07:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241346AbiBSGcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 01:32:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbiBSGck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 01:32:40 -0500
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59E61928A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 22:32:21 -0800 (PST)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 749F3403DB;
        Sat, 19 Feb 2022 11:32:15 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1645252337; bh=i/Xc3rXnQ31VWvth9DwfVBUyC4C2QCHs5CrNABz1B+g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PvRkxicWdFiMqfWBz74nha0w4PHEwhZR6tF+ZDG/YTlzojHskGlrFlKuOZCPY38Hv
         PO+bgGJg9jaFsh/YzW6ZCBvMKBRwUDYCPUmzxFUck0aFWgdnQHVwC0V7QSUEs0yXUs
         q3W5YjWWXjtmxvTSCfdvWtdQAkzm7vCiardPMfmRY7k5QAZ8CHkgu6MRufc7h+9S60
         aapOH3eKCgnbfw0KOS2wJlNcIwbw8+Aoso9wtFH8s39LrHawpb1Z09qDkGQu0deBXg
         DZVh1cKyesH+Ql4Yry6HZqk/4LrdXYJqP7FE8DP4Cejj+rgguo/7vippcA16DMtYA4
         dKgygWZpkdOGQ==
MIME-Version: 1.0
Date:   Sat, 19 Feb 2022 11:32:15 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linus.walleij@linaro.org, mturquette@baylibre.com,
        bjorn.andersson@linaro.org, agross@kernel.org, tdas@codeaurora.org,
        svarbanov@mm-sol.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 1/4] clk: qcom: clk-rcg2: Fail Duty-Cycle configuration if
 MND divider is not enabled.
In-Reply-To: <20220217223736.DFC2EC340E8@smtp.kernel.org>
References: <20211209163720.106185-1-nikita@trvn.ru>
 <20211209163720.106185-2-nikita@trvn.ru>
 <20220108005209.5140EC36AEB@smtp.kernel.org>
 <991533e0fddd6999c8a06a536ae57999@trvn.ru>
 <20220110201452.2B3E4C36AE3@smtp.kernel.org>
 <cc4241105bfd2249c1c309a4efa2e6aa@trvn.ru>
 <20220217223736.DFC2EC340E8@smtp.kernel.org>
Message-ID: <6c3d2f619b1e87ef21effc02bb6df1cb@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Stephen Boyd писал(а) 18.02.2022 03:37:
> Quoting Nikita Travkin (2022-01-26 07:14:21)
>> Stephen Boyd писал(а) 11.01.2022 01:14:
>> > Quoting Nikita Travkin (2022-01-07 23:25:19)
>> >> Hi,
>> >>
>> >> Stephen Boyd писал(а) 08.01.2022 05:52:
>> >> > Quoting Nikita Travkin (2021-12-09 08:37:17)
>> >> I'm adding this error here primarily to bring attention of the
>> >> user (e.g. developer enabling some peripheral that needs
>> >> duty cycle control) who might have to change their clock tree
>> >> to make this control effective. So, assuming that if someone
>> >> sets the duty cycle to 50% then they might set it to some other
>> >> value later, it makes sense to fail the first call anyway.
>> >>
>> >> If you think there are some other possibilities for this call
>> >> to happen specifically with 50% duty cycle (e.g. some
>> >> preparations or cleanups in the clk subsystem or some drivers
>> >> that I'm not aware of) then I can make an exemption in the check
>> >> for that.
>> >>
>> >
>> > I don't see anywhere in clk_set_duty_cycle() where it would bail out
>> > early if the duty cycle was set to what it already is. The default for
>> > these clks is 50%, so I worry that some driver may try to set the duty
>> > cycle to 50% and then fail now. Either we need to check the duty cycle
>> > in the core before calling down into the driver or we need to check it
>> > here in the driver. Can you send a patch to check the current duty cycle
>> > in the core before calling down into the clk ops?
>>
>> Hi, sorry for a rather delayed response,
>> I spent a bit of time looking at how to make the clk core be
>> careful with ineffective duty-cycle calls and I can't find a
>> nice way to do this... My idea was something like this:
>>
>> static int clk_core_set_duty_cycle_nolock(struct clk_core *core,
>>                                           struct clk_duty *duty)
>> {       /* ... */
>>
>>         /* Update core->duty values */
>>         clk_core_update_duty_cycle_nolock(core);
>>
>>         if ( /* duty doesn't match core->duty */ ) {
>>                 ret = core->ops->set_duty_cycle(core->hw, duty);
>>         /* ... */
>> }
>>
>> However there seem to be drawbacks to any variant of the
>> comparison that I could come up with:
>>
>> Naive one would be to do
>>     if (duty->num != core->duty->num || duty->den != core->duty->den)
>> but it won't correctly compare e.g. 1/2 and 10/20.
>>
>> Other idea was to do
>>     if (duty->den / duty->num != core->duty->den / core->duty->num)
>> but it will likely fail with very close values (e.g. 100/500 and 101/500)
>>
>> I briefly thought of some more sophisticated math but I don't
>> like the idea of complicating this too far.
>>
>> I briefly grepped the kernel sources for duty-cycle related methods
>> and I saw only one user of the clk_set_duty_cycle:
>>     sound/soc/meson/axg-tdm-interface.c
>> Notably it sets the cycle to 1/2 in some cases, though it seems to
>> be tied to the drivers/clk/meson/sclk-div.c clock driver by being
>> the blocks of the same SoC.
> 
> Indeed, so this patch is untested? I doubt the qcom driver is being used
> with the one caller of clk_set_duty_cycle() in the kernel.
> 

While right now, to my knowledge, there is no users of the duty cycle
control, I'm adding a generic driver that uses it in another series [1]
with an intention to use it across multiple qcom based devices.

While making it I spent quite a bit of time staring at the oscilloscope
to figure out that I need changes from patch 4/4 of this series and I'd
like to make this quirk a bit more obvious to others.

[1] https://lore.kernel.org/linux-pwm/20220212162342.72646-1-nikita@trvn.ru/

>>
>> Thinking of it a bit more, I saw another approach to the problem
>> I want to solve: Since I just want to make developers aware of the
>> hardware quirk, maybe I don't need to fail the set but just put a
>> WARN or even WARN_ONCE there? This way the behavior will be unchanged.
>>
> 
> I don't like the idea of a WARN or a WARN_ONCE as most likely nobody is
> going to read it or do anything about it. Returning an error should be
> fine then. If the duty cycle call fails for 50% then that's something we
> have to live with.

I intend this WARN or error to be hit by a person bringing up something
new, user should never see it. For example a possible story could be:

- Backlight control is connected to the clock on device X
- Developer adds (future) pwm-clk adapter and pwm-backlight to the DT
- Backlight slider in UI doesn't work anyway. (don't think UIs show
  errors here)
- Developer troubleshoots the thing and either finds WARN in dmesg
  or that the sysfs write errors out.

In my experience, people bringing devices up pay a very close attention
to dmesg so I think giving a WARN is fine, but I'm fine with whichever
approach you prefer.

Nikita
