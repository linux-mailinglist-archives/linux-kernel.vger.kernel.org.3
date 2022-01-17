Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1381049093B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 14:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237137AbiAQNJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 08:09:44 -0500
Received: from box.trvn.ru ([194.87.146.52]:59119 "EHLO box.trvn.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229486AbiAQNJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 08:09:43 -0500
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id D2671403F5;
        Mon, 17 Jan 2022 18:09:38 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1642424979; bh=U7N7pywrcgTwM56ulbabdmYwmPLvirjgvUmHgBMzXDI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zgoyDK0XsVS/dHyQ7llxbSQMWZv0NtvF5JRkJcegWT1OfV5pPvzyO6y2nGlZ38kH1
         tK0Q0eRsquuX62OVcqWjjSfbXJfkrUULdgUQi3GKITMc3NMxufxbNB8atn5pPyrimZ
         qUXWhxnuiF5ivf0L1eDbdLNl0bSmOFIYrHrYHNeY0CfQLTDLQKibfoCydNgiwfZUgN
         yihVrnP7TeZaQmk7Ql0MxVn9KuChUCBj2oa/0R+NYcxNXr/SleBBQ2k/stcoNa18a+
         DhUwhohIKZ6Gj6JpvNYXhtUk8qqTuRwdVy9UDhPCgP9B8j5ownz96FpXNs2AgaoxPq
         C6y4P8gUgvP9Q==
MIME-Version: 1.0
Date:   Mon, 17 Jan 2022 18:09:38 +0500
From:   Nikita Travkin <nikita@trvn.ru>
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org,
        sboyd@kernel.org, linus.walleij@linaro.org, masneyb@onstation.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 0/2] Clock based PWM output driver
In-Reply-To: <20220117121000.3lgohyenamvwmcur@pengutronix.de>
References: <20211213150335.51888-1-nikita@trvn.ru>
 <20220117121000.3lgohyenamvwmcur@pengutronix.de>
Message-ID: <2b54833618e527b03657446290d35524@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uwe Kleine-König писал(а) 17.01.2022 17:10:
> Hello Nikita,
> 
> On Mon, Dec 13, 2021 at 08:03:33PM +0500, Nikita Travkin wrote:
>> This series introduces an "adapter" driver that allows PWM consumers
>> to control clock outputs with duty-cycle control.
>>
>> Some platforms (e.g. some Qualcomm chipsets) have "General Purpose"
>> clocks that can be muxed to GPIO outputs and used as PWM outputs.
>> Those outputs may be connected to various peripherals such as
>> leds in display backlight or haptic feedback motor driver.
>>
>> To avoid re-implementing every single PWM consumer driver with clk
>> support (like in [1]) and don't put the burden of providing the PWM
>> sources on the clock drivers (as was proposed in [2]), clk based
>> pwm controller driver is introduced.
>>
>> There is an existing driver that provides the opposite function
>> in drivers/clk/clk-pwm.c with a compatible "pwm-clock" so the new
>> driver uses the opposite naming scheme: drivers/pwm/pwm-clk.c
>> and compatible "clk-pwm".
> 
> You got some feedback on your patches and didn't respond to it. Are you
> interested to improve your patch set? If yes, I'm willing to review more
> deeply. If not, I'm not.
> 

Hi, I do intend on finishing this and getting the patches upstream
however I was very short on time for the last while and couldn't get
to it.

For this v2 I see the dt bindings check failure, I think it's the
regex in the core schema that was defined incorrectly but my attempt
to fix it has failed last time I tried it for some reason.
(Now looking at it one more time, I see that '^pwm(@.*|-[0-9a-f])*$'
only allows [a-f] and I just tried to move the * to the correct place)
I also see that I've used the wrong division with rounding macro.

I am planning to send a v3 a bit later with those fixed.

Sorry for delaying the response
Nikita 


> Best regards
> Uwe
