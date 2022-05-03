Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45408518885
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 17:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238464AbiECPa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238439AbiECPay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:30:54 -0400
Received: from skyrocket.fabmicro.ru (skyrocket.fabmicro.ru [217.116.57.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2347D24587
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 08:27:20 -0700 (PDT)
Received: from mail.fabmicro.ru (skyrocket.fabmicro.ru [217.116.57.130])
        by skyrocket.fabmicro.ru (8.14.9/8.14.9) with ESMTP id 243FQIbs075026;
        Tue, 3 May 2022 15:26:18 GMT
        (envelope-from rz@fabmicro.ru)
MIME-Version: 1.0
Date:   Tue, 03 May 2022 20:26:18 +0500
From:   Ruslan Zalata <rz@fabmicro.ru>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Maxime Ripard <maxime@cerno.tech>, Icenowy Zheng <icenowy@aosc.io>,
        Jean Delvare <jdelvare@suse.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2] hwmon: (sun4i-lradc) Add driver for LRADC found on
 Allwinner A13/A20 SoC
In-Reply-To: <4aabfd63-18e2-65c5-d1c2-d7600afc1c40@roeck-us.net>
References: <20220428210906.29527-1-rz@fabmicro.ru>
 <20220502110010.q7vvdkdpaiz5acjl@houat>
 <7433B295-D896-4BF8-87DF-87EB89D7A550@aosc.io>
 <20220502112112.3ne7zy4b6gggxzoo@houat>
 <4aabfd63-18e2-65c5-d1c2-d7600afc1c40@roeck-us.net>
User-Agent: Roundcube Webmail/1.4.3
Message-ID: <97e3af18e947492b1ac968c058ba509f@fabmicro.ru>
X-Sender: rz@fabmicro.ru
Organization: Fabmicro, LLC.
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

LRADC does generate continuous interrupts as long as input voltage is 
below LevelB threshold. The max possible LevelB is 0x3C which in case of 
A20 SoC is close to 1.90V and that's what my driver sets LevelB to. 
Perhaps this needs to be documented more thoroughly.

It is possible to implement this same driver for IIO subsystem, but I 
would prefer to keep it in hwmon along with many other simple ADC 
drivers used for temp and battery status monitoring.

If we talk about IIO, it will be necessary to implement serialization of 
reads and updates which brings up some complexity I would try to avoid 
at the moment. :)

---
Regards,
Ruslan.

Fabmicro, LLC.

On 2022-05-03 07:02, Guenter Roeck wrote:
> On 5/2/22 04:21, Maxime Ripard wrote:
>> On Mon, May 02, 2022 at 07:15:01PM +0800, Icenowy Zheng wrote:
>>> 
>>> 
>>> 于 2022年5月2日 GMT+08:00 下午7:00:10, Maxime Ripard <maxime@cerno.tech> 
>>> 写到:
>>>> Hi,
>>>> 
>>>> On Thu, Apr 28, 2022 at 09:09:03PM +0000, Ruslan Zalata wrote:
>>>>> Some Allwinner SoCs like A13, A20 or T2 are equipped with 
>>>>> two-channel
>>>>> low rate (6 bit) ADC that is often used for extra keys. There's a 
>>>>> driver
>>>>> for that already implementing standard input device, but it has 
>>>>> these
>>>>> limitations: 1) it cannot be used for general ADC data equisition, 
>>>>> and
>>>>> 2) it uses only one LRADC channel of two available.
>>>>> 
>>>>> This driver provides basic hwmon interface to both channels of 
>>>>> LRADC on
>>>>> such Allwinner SoCs.
>>>>> 
>>>>> Signed-off-by: Ruslan Zalata <rz@fabmicro.ru>
>>>>> ---
>>>>>   MAINTAINERS                       |   6 +
>>>>>   drivers/hwmon/Kconfig             |  13 ++
>>>>>   drivers/hwmon/Makefile            |   1 +
>>>>>   drivers/hwmon/sun4i-lradc-hwmon.c | 280 
>>>>> ++++++++++++++++++++++++++++++
>>>>>   4 files changed, 300 insertions(+)
>>>>>   create mode 100644 drivers/hwmon/sun4i-lradc-hwmon.c
>>>>> 
>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>> index 5e8c2f61176..d9c71e94133 100644
>>>>> --- a/MAINTAINERS
>>>>> +++ b/MAINTAINERS
>>>>> @@ -18861,6 +18861,12 @@ S:	Maintained
>>>>>   
>>>>> F:	Documentation/devicetree/bindings/input/allwinner,sun4i-a10-lradc-keys.yaml
>>>>>   F:	drivers/input/keyboard/sun4i-lradc-keys.c
>>>>>   +SUN4I LOW RES ADC HWMON DRIVER
>>>>> +M:	Ruslan Zalata <rz@fabmicro.ru>
>>>>> +L:	linux-hwmon@vger.kernel.org
>>>>> +S:	Maintained
>>>>> +F:	drivers/hwmon/sun4i-lradc-hwmon.c
>>>>> +
>>>>>   SUNDANCE NETWORK DRIVER
>>>>>   M:	Denis Kirjanov <kda@linux-powerpc.org>
>>>>>   L:	netdev@vger.kernel.org
>>>>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>>>>> index 68a8a27ab3b..86776488a81 100644
>>>>> --- a/drivers/hwmon/Kconfig
>>>>> +++ b/drivers/hwmon/Kconfig
>>>>> @@ -1691,6 +1691,19 @@ config SENSORS_SIS5595
>>>>>   	  This driver can also be built as a module. If so, the module
>>>>>   	  will be called sis5595.
>>>>>   +config SENSORS_SUN4I_LRADC
>>>>> +	tristate "Allwinner A13/A20 LRADC hwmon"
>>>>> +	depends on ARCH_SUNXI && !KEYBOARD_SUN4I_LRADC
>>>>> +	help
>>>>> +	  Say y here to support the LRADC found in Allwinner A13/A20 
>>>>> SoCs.
>>>>> +	  Both channels are supported.
>>>>> +
>>>>> +	  This driver can also be built as module. If so, the module
>>>>> +	  will be called sun4i-lradc-hwmon.
>>>>> +
>>>>> +	  This option is not compatible with KEYBOARD_SUN4I_LRADC, one
>>>>> +	  of these must be used at a time.
>>>> 
>>>> How do you plan on enforcing that?
>>>> 
>>>> I guess a better path forward would be to either register an hwmon
>>>> device in the original driver, or convert that driver to iio and use
>>>> iio-hwmon.
>>> 
>>> I think this driver should be use IIO, and then try to probe an IIO 
>>> input
>>> if possible.
>> 
>> It's been a while, but if I remember well we couldn't use IIO for that
>> driver because it's not generating interrupts all the time but only 
>> when
>> it goes over a given threshold:
>> 
>> https://lore.kernel.org/all/52C5E9F1.9010700@redhat.com/
>> 
>> I'm not sure if it's still relevant, so we might just need to add an
>> hwmon driver to the existing driver
>> 
> 
> So now we have conflicting claims that the hwmon driver would need
> to implement continuous interrupts because the chip otherwise doesn't
> continuously measure ADC input, and that implementing an IIO driver
> isn't possible or doesn't make sense because the chip would not support
> generating continuous interrupts. Which one is it ? Am I missing 
> something ?
> 
> Guenter
