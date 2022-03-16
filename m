Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEBA24DAEC2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 12:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355280AbiCPLSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 07:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355272AbiCPLSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 07:18:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9465D65787
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 04:17:16 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1nUReM-0003ml-JI; Wed, 16 Mar 2022 12:17:06 +0100
Message-ID: <e888d777-71f8-8ddc-7590-53e181ae0ad4@pengutronix.de>
Date:   Wed, 16 Mar 2022 12:17:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [Linux-stm32] [PATCH v2 12/13] ARM: dts: stm32: enable optee
 firmware and SCMI support on STM32MP13
Content-Language: en-US
To:     Etienne Carriere <etienne.carriere@linaro.org>,
        Gabriel FERNANDEZ <gabriel.fernandez@foss.st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <CAN5uoS9F1cjN+WLks1S=GzA1SHw=o-ibFbu-VsUzJ4NydAkAdw@mail.gmail.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <CAN5uoS9F1cjN+WLks1S=GzA1SHw=o-ibFbu-VsUzJ4NydAkAdw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Etienne,

On 16.03.22 12:01, Etienne Carriere wrote:
> Hi Ahmad,
> 
>> Helo Gabriel,
>>
>> On 03.03.22 14:09, Gabriel FERNANDEZ wrote:
>>>
>>> On 2/25/22 16:13, Ahmad Fatoum wrote:
>>>> Hello Gabriel,
>>>>
>>>> On 25.02.22 14:31, gabriel.fernandez@foss.st.com wrote:
>>>>> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>>>>> +    firmware {
>>>>> +        optee {
>>>>> +            method = "smc";
>>>>> +            compatible = "linaro,optee-tz";
>>>>> +        };
>>>>> +
>>>>> +        scmi: scmi {
>>>>> +            compatible = "linaro,scmi-optee";
>>>> This compatible doesn't seem to be documented upstream. I am looking at v5.17-rc5.
>>>> Do you have a reference detailing the difference between this conduit and
>>>> plain arm,scmi-smc (as used with TF-A on the STM32MP151).
>>>>
>>>> Cheers,
>>>> Ahmad
>>>
>>> Hi
>>>
>>> Ahmad,
>>>
>>> it's on going.
>>>
>>> https://lore.kernel.org/linux-arm-kernel/20211029102118.GG6526@e120937-lin/T/#mf46c83f0aadce3061ee93fa22159405f38d881a0
>>
>> I've found that thread in the meantime and got some clarification on why a new
>> transport for OP-TEE was added. One question I still have though is why make
>> this transport the default for STM32MP13x instead of using SCMI over SMC like
>> you do for STM32MP15x. OP-TEE could still be made to service SCMI over SMC
>> and it would allow people employing TF-A as SCMI provider an easier migration
>> to the newer SoC.
>>
> 
> Just to rephrase a bit what's being said in the referred mail thread:
> On STM32MP13x, there are SCMI messages that must be processed inside a
> thread execution context in the SCMI server. There is no standard SMC
> function ID defined that the SCMI/SMC transport could use for that
> purpose. OP-TEE provides such a threaded context. Therefore STM32MP13x
> explicitly expects SCMI services based on SCMI/OP-TEE transport, not
> SCMI/SMC transport.

I see. Users can still override it as they see fit and I understand that
ST would prefer to have the "fully-featured" boot chain be the default
for the new SoC. So no concerns from my side.

Thanks a lot for the clarification!

Cheers,
Ahmad

> 
> Best regards,
> etienne
> 
>> Cheers,
>> Ahmad
> 
>>
>>>
>>>> +            #address-cells = <1>;
>>>> +            #size-cells = <0>;
>>>> +            linaro,optee-channel-id = <0>;
>>>> +            shmem = <&scmi_shm>;
>>>> +
>>>> +            scmi_clk: protocol@14 {
>>>> +                reg = <0x14>;
>>>> +                #clock-cells = <1>;
>>>> +            };
>>>> +
>>>> +            scmi_reset: protocol@16 {
>>>> +                reg = <0x16>;
>>>> +                #reset-cells = <1>;
>>>> +            };
>>>> +        };
>>>> +    };
>>>>       clocks {
>>>>           clk_axi: clk-axi {
>>>>               #clock-cells = <0>;
>>>
>>
> 
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
