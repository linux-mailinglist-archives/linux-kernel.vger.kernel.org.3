Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24B24F499F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443268AbiDEWUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379324AbiDENNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 09:13:43 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABD6366B6;
        Tue,  5 Apr 2022 05:14:52 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id DB32E1F42AF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649160890;
        bh=5htqzeboi78pw+EZSDMSeRcR1q+P7L+C7qMifFBCIkg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Bwg80AKVhxXtveM6MoDiSFvGSKmbnOcjJT9oyUjIkBzLWKj2Z4ENiBNWEpciMwmxM
         Bztv6v0Xd8NraKnqMsJLeGVP+p9/kfkureZOEqQf1HQ0nM072ezuYyzGEWfYRMqHlp
         YFRaQFcGWB3XoDRNOoshBi8QWLQxrfOSvtluSGGYN0wHeHJ9bBblII9nEQg49ZyowC
         Vqu7VJKBEbADrq7EqsTHx13njjGUmwjRIQmiGG2QaBlrXGuJvXE5Q1pmNwyn6R3Cxe
         0S4G2WJKxdqrc/I0i/JV5WzxhFu86RESUM3v9HS1SyojOV8xRpx7o477YJ7Y6H30bz
         ggiyeeqYr4EXw==
Message-ID: <b627639a-d050-66af-31d3-c6a6c04eb4e0@collabora.com>
Date:   Tue, 5 Apr 2022 14:14:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 0/2] thermal: Add support of multiple sensors
Content-Language: en-US
To:     Kevin Hilman <khilman@baylibre.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        daniel.lezcano@linaro.org
Cc:     rafael@kernel.org, rui.zhang@intel.com, amitk@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.tseng@mediatek.com, mka@chromium.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
References: <7hlex0s6ag.fsf@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <7hlex0s6ag.fsf@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/03/22 22:33, Kevin Hilman ha scritto:
> Hi Eduardo, Daniel,
> 
> Eduardo Valentin <eduval@amazon.com> writes:
> 
>> On Fri, Feb 18, 2022 at 09:46:02AM +0100, Alexandre Bailon wrote:
>>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>>>
>>>
>>>
>>> Following this comment [1], this updates thermal_of to support multiple
>>> sensors.
>>>
>>> This has some limitations:
>>> - A sensor must have its own termal zone, even if it is also registered
>>>    inside a thermal zone supporting multiple sensors.
>>> - Some callbacks (such as of_thermal_set_trips) have been updated to support
>>>    multiple sensors but I don't know if this really make sense.
>>> - of_thermal_get_trend have not been updated to support multiple sensors.
>>>    This would probably make sense to support it but I am not sure how to do it,
>>>    especially for the average.
>>
>> Great to see this having somewhat a form now!
>>
>> Overall the idea is sane and aligned to what I had in mind back during the 2019 Linux plumbers: one thermal zone should have multiple sensor inputs.
>> https://lpc.events/event/4/page/34-accepted-microconferences#PMSummary
>>
>> In fact, that is aligned to what I originally wrote in the thermal device tree bindings:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/thermal/thermal-zones.yaml#n79
>>
>> The only major concern with your series is the usage of of-thermal to achieve the multiple sensors per thermal zone.
>> While that solves the problem, it has the following limitations:
>> (1) limited to devices described in device tree. everybody else is left out.
>> (2) it keeps extending the code duplication in of-thermal.
>>
>> My suggestion here is have the thermal core aware of the multiple sensors per thermal zone.
>>
>> That has the advantage of:
>> (a) cleanup the sensor handling within of-thermal
>> (b) expand the multi sensor per zone to all types of thermal drivers
>> (c) standardize the way to handle the multi sensor.
> 
> This cleanup all sounds like the right direction to be headed, but since
> this has been planned since 2019 and nothing has happended, what is the
> level of urgency is for this of-thermal -> thermal core cleanup/rework?
> 
> In $SUBJECT series, we have a fully functional series that solves an
> existing problem and takes a big step in the right long-term direction.
> While it indeed has the has limitations you mention, I don't think that
> should block the merging of this series.  More importantly, there are
> existing drivers[1] as well as forthcoming ones from MTK that depend on
> this series. Those are blocked if you require the of-thermal -> core
> move first.
> 
> As a maintainer also, I fully understand that maintainer bandwith is
> limited, and it's always nice to have contributors do core framework
> development when possible, but IMO, in this case I don't think it should
> be a prerequisite since a follow-up series to do the core work would not
> affect any functionality or bindings etc.  I don't see any reasons not
> do to this incrementally.
> 
> So I would kindly request (read: beg, plead & grovel) that you seriously
> consider merging this series as a first phase and the of-thermal -> core
> change be done as a second phase.  Yes, I fully understand that punting
> this to a second phase means it might not get done soon.  But it's been
> waiting for years already, so it seems the urgency is low.  Meanwhile,
> there are OF users that are ready to use this feature today.
> 
> Thanks for considering,
> 
> Kevin
> 
> [1] https://lore.kernel.org/linux-mediatek/20210617114707.10618-1-ben.tseng@mediatek.com/
> 
> 

Hello Eduardo, Kevin,

I would like to add that this series is not only benefitting MediaTek platforms,
and not only Chromebooks.
On some Qualcomm SoCs (from SDM845 onwards, if I'm not wrong!), downstream, there
is some "qti virtual sensor" driver, which is addressing this kind of situation:
on these platforms, averaging, min and max (and some interpolation too, but that's
another story, I guess) is happening and that's used as some advanced way to
ensure that both performance stays high and that the device is safe to operate.
On these platforms, this is done by evaluating CPU, GPU, Hexagon DSPs, modem, wifi
and (modem,wifi)PA IPs and deciding on a thermal throttling strategy.

You understand that, while this is not "excessively" important for a Chromebook,
which is a laptop, it may become even a safety concern in devices of other form
factor, like smartphones, where there is a very strict thermal headroom (hence
requiring a fine grained thermal management).

Even though, on MediaTek, I guess that the primary usecase is Chromebooks and this
kind of mechanism is required primarily for the LVTS sensors that are used for SVS
calculations (read: better power efficiency), the Linux community is huge - and,
with this kept in mind, there will probably be someone that will like to upstream
their MTK smartphone for a reason or another (I think! This happened with Qualcomm
so I guess that it's going to happen with "any other thing")... and that adds up
to this problem being a safety concern to fix.

Of course, I agree with you, Eduardo, about the needed cleanup but, for all of
the aforementioned reasons - mine and Kevin's, like him, I would also beg, plead
and grovel that you consider merging this series as a first phase, and accept the
cleanup and use-case expansion as a second phase.

P.S.: I'm adding Marijn and Konrad to the loop, as people interested to the
       Qualcomm side of things, and mainly upstreaming smartphones.

Kind regards,
Angelo
