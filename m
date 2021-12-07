Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B81746BD20
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 15:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237453AbhLGODk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 09:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbhLGODi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 09:03:38 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873B8C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 06:00:08 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1mub0i-0006xW-KF; Tue, 07 Dec 2021 15:00:00 +0100
Subject: Re: [Linux-stm32] [PATCH v2 1/4] ASoC: dt-bindings: stm32: i2s: add
 audio-graph-card port
To:     Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Rob Herring <robh@kernel.org>,
        Olivier MOYSAN <olivier.moysan@foss.st.com>
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        alain.volmat@foss.st.com, arnaud.pouliquen@foss.st.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
References: <20211125144053.774-1-olivier.moysan@foss.st.com>
 <20211125144053.774-2-olivier.moysan@foss.st.com>
 <1637875562.357461.2858318.nullmailer@robh.at.kernel.org>
 <237f56b3-0597-2526-a182-f1fbdd327338@foss.st.com>
 <Yaf4jiZIp8+ndaXs@robh.at.kernel.org>
 <627777a4-7458-88ed-e7c5-d11e3db847b5@foss.st.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <cf5f994b-aecf-e051-f5c9-4a46e6414207@pengutronix.de>
Date:   Tue, 7 Dec 2021 14:59:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <627777a4-7458-88ed-e7c5-d11e3db847b5@foss.st.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alex,

On 07.12.21 14:52, Alexandre TORGUE wrote:
> Hi Rob
> 
> On 12/1/21 11:34 PM, Rob Herring wrote:
>> On Fri, Nov 26, 2021 at 11:25:27AM +0100, Olivier MOYSAN wrote:
>>> Hi Rob,
>>>
>>> On 11/25/21 10:26 PM, Rob Herring wrote:
>>>> On Thu, 25 Nov 2021 15:40:50 +0100, Olivier Moysan wrote:
>>>>> The STM2 I2S DAI can be connected via the audio-graph-card.
>>>>> Add port entry into the bindings.
>>>>>
>>>>> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
>>>>> ---
>>>>>    Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml | 5 +++++
>>>>>    1 file changed, 5 insertions(+)
>>>>>
>>>>
>>>> Running 'make dtbs_check' with the schema in this patch gives the
>>>> following warnings. Consider if they are expected or the schema is
>>>> incorrect. These may not be new warnings.
>>>>
>>>> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
>>>> This will change in the future.
>>>>
>>>> Full log is available here: https://patchwork.ozlabs.org/patch/1559750
>>>>
>>>>
>>>> audio-controller@4000b000: 'port' does not match any of the regexes: '^port@[0-9]', 'pinctrl-[0-9]+'
>>>>     arch/arm/boot/dts/stm32mp157a-dk1.dt.yaml
>>>>     arch/arm/boot/dts/stm32mp157c-dk2.dt.yaml
>>>>
>>>
>>> This warning is not a new one.
>>>
>>> The i2s2 node in stm32mp15xx-dkx.dtsi would require the following binding:
>>> port:
>>>     $ref: audio-graph-port.yaml#
>>>     unevaluatedProperties: false
>>>
>>> However the spi binding requires to introduce a unit address:
>>> patternProperties:
>>>    '^port@[0-9]':
>>>      $ref: audio-graph-port.yaml#
>>>      unevaluatedProperties: false
>>>
>>> The warning can be removed by re-ordering the bindings patches in the serie,
>>> as "additionalProperties: true" makes the check more tolerant on extra
>>> properties.
>>
>> That's never right.
>>
>>> The patch "ASoC: dt-bindings: stm32: i2s: add audio-graph-card port" can
>>> even be merely dropped.
>>> So, I suggest to resend the serie without audio-graph-card patch.
>>
>> Only if you aren't using audio-graph-card.
>>
>>>
>>> Does it sound too permissive to you ?
>>
>> I think perhaps you need to combine the schemas into 1. Or you need to
>> restructure your dtsi files such that you only add spi specific
>> properties when spi mode is enabled and only add i2s specific properties
>> when i2s mode is enabled. Or use the /delete-property/ directive.
> 
> Initially the aim of this series was to fix a "make W=1" warnings seen on spi and i2s nodes (duplicate unit-address). Moving both nodes in a common node + using a different compatible depending on SPI or I2S usage sounded good) but it is not enough. In this series the common node is named as following: "spi2s2: spi@4000b000". It is fine for a spi usage but if we want to use this "common node" with I2S compatible and specific bindings, the node name remains spi@... and then specific spi checks are done. For this with this series applied we got this issue reported by spi-controller.yaml:
> 
> spi@4000b000: port@0: 'compatible' is a required property
> 
> So, if we use two separates nodes we got W=1 warning and if we use a common node we got yaml check issue. One possibility would be to use a common node with a new node name (for example i2spi@...) but I think it is not acceptable.
> 
> How to progress ?

Atmel Flexcom can be configured to be either UART, SPI or i2c. Functions
are child nodes of the flexcom node and the MFD driver matching against it,
just configure the operating mode and then calls of_platform_populate.

Would something along these lines fit here as well?

Cheers,
Ahmad

> 
> Thanks
> Alex
> 
> 
>> Rob
>>
> 
> _______________________________________________
> Linux-stm32 mailing list
> Linux-stm32@st-md-mailman.stormreply.com
> https://st-md-mailman.stormreply.com/mailman/listinfo/linux-stm32
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
