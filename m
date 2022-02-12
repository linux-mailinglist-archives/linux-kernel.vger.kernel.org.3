Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F244B36F6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 19:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiBLSLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 13:11:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiBLSLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 13:11:49 -0500
Received: from 189.cn (ptr.189.cn [183.61.185.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA2504B405;
        Sat, 12 Feb 2022 10:11:41 -0800 (PST)
HMM_SOURCE_IP: 10.64.8.41:60616.1189609616
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.41])
        by 189.cn (HERMES) with SMTP id 611C3100139;
        Sun, 13 Feb 2022 02:11:33 +0800 (CST)
Received: from  ([172.27.8.53])
        by gateway-151646-dep-b7fbf7d79-9vctg with ESMTP id 30291ab50f664b3aaf0ab2bf57b87b99 for maxime@cerno.tech;
        Sun, 13 Feb 2022 02:11:40 CST
X-Transaction-ID: 30291ab50f664b3aaf0ab2bf57b87b99
X-Real-From: 15330273260@189.cn
X-Receive-IP: 172.27.8.53
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <8b7bcb57-4450-ed67-bd5f-d8e8f2e74510@189.cn>
Date:   Sun, 13 Feb 2022 02:11:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 1/3] drm/lsdc: add drm driver for loongson display
 controller
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        suijingfeng <suijingfeng@loongson.cn>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Randy Dunlap <rdunlap@infradead.org>
References: <20220203082546.3099-1-15330273260@189.cn>
 <20220203082546.3099-2-15330273260@189.cn>
 <20220203085851.yqstkfgt4dz7rcnw@houat>
 <11ac5696-29e3-fefa-31c0-b7b86c88bbdc@189.cn>
 <20220209084908.kub4bs64rzhvpvon@houat>
 <84bfb2fc-595c-3bae-e8a0-c19ccbcfcfd8@189.cn>
 <20220209161624.42ijbnhanaaari46@houat>
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <20220209161624.42ijbnhanaaari46@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/2/10 00:16, Maxime Ripard wrote:
> On Wed, Feb 09, 2022 at 10:38:41PM +0800, Sui Jingfeng wrote:
>> On 2022/2/9 16:49, Maxime Ripard wrote:
>>> On Fri, Feb 04, 2022 at 12:04:19AM +0800, Sui Jingfeng wrote:
>>>>>> +/* Get the simple EDID data from the device tree
>>>>>> + * the length must be EDID_LENGTH, since it is simple.
>>>>>> + *
>>>>>> + * @np: device node contain edid data
>>>>>> + * @edid_data: where the edid data to store to
>>>>>> + */
>>>>>> +static bool lsdc_get_edid_from_dtb(struct device_node *np,
>>>>>> +				   unsigned char *edid_data)
>>>>>> +{
>>>>>> +	int length;
>>>>>> +	const void *prop;
>>>>>> +
>>>>>> +	if (np == NULL)
>>>>>> +		return false;
>>>>>> +
>>>>>> +	prop = of_get_property(np, "edid", &length);
>>>>>> +	if (prop && (length == EDID_LENGTH)) {
>>>>>> +		memcpy(edid_data, prop, EDID_LENGTH);
>>>>>> +		return true;
>>>>>> +	}
>>>>>> +
>>>>>> +	return false;
>>>>>> +}
>>>>> You don't have a device tree binding for that driver, this is something
>>>>> that is required. And it's not clear to me why you'd want EDID in the
>>>>> DTB?
>>>> 1) It is left to the end user of this driver.
>>>>
>>>> The downstream motherboard maker may use a dpi(XRGB888) or LVDS panel
>>>> which don't have DDC support either, doing this way allow them put a
>>>> EDID property into the dc device node in the DTS. Then the entire system works.
>>>> Note those panel usually support only one display mode.
>>> I guess it depends on what we mean exactly by the user, but the DTB
>>> usually isn't under the (end) user control. And the drm.edid_firmware is
>>> here already to address exactly this issue.
>>>
>>> On the other end, if the board has a static panel without any DDC lines,
>>> then just put the timings in the device tree, there's no need for an
>>> EDID blob.
>> Loongson have a long history of using PMON firmware, The PMON firmware
>> support flush the dtb into the the firmware before grub loading the kernel.
>> You press 'c' key, then the PMON will give you a shell. it is much like a
>> UEFI shell. Suppose foo.dtb is what you want to pass to the vmlinuz.
>> Then type the follow single command can flush the dtb into the PMON firmware.
>>
>> |load_dtb /dev/fs/fat@usb0/foo.dtb|
>>
>> For our PMON firmware, it**is**  totally under developer/pc board maker's control.
>> You can flush whatever dtb every time you bootup until you satisfied.
>> It(the pmon firmware) is designed to let downstream motherboard maker and/or
>> customers to play easily.
>>
>> Support of reading EDID from the dtb is really a feature which downstream
>> motherboard maker or customer wanted. They sometimes using eDP also whose
>> resolution is not 1024x768. This is out of control for a graphic driver
>> developer like me.
> And, to reinstate, we already have a mechanism to set an EDID, and if it
> wasn't an option, the DT is not the place to store an EDID blob.

I know, put edid blob in the dts maybe abuse, but i am not push dts with edid blob either.

It is left to other people, and the ./arch/powerpc/boot/dts/ac14xx.dts already have edid blob.

>> And drm.edid_firmware have only a few limited resolution which is weak.
> You're wrong. There's no limitation, it's just as limited as your
> solution. You put the same thing, you get the same thing out of it. The
> only difference is where the data are coming from.

It is extremely difficult to use, it have difficulty to specify which firmware edid is for which connector.
because we have a 1024x600 panel and a 1920x1080 monitor.

It require you to know the connector's name at first, it is not as intuitive as my method.
I am exhausted by it.

>> I will consider to adding drm.edid_firmware support, thanks.
> It just works if you use drm_get_edid.
>
>>>> 2) That is for the display controller in ls2k1000 SoC.
>>>>
>>>> Currently, the upstream kernel still don't have GPIO, PWM and I2C driver support
>>>> for LS2K1000 SoC.
>>>>
>>>> How dose you read EDID from the monitor without a I2C driver?
>>>>
>>>> without reading EDID the device tree support, the screen just black,
>>>> the lsdc driver just stall. With reading EDID from device tree support
>>>> we do not need a i2c driver to light up the monitor.
>>>>
>>>> This make lsdc drm driver work on various ls2k1000 development board
>>>> before I2C driver and GPIO driver and PWM backlight driver is upstream.
>>>>
>>>> I have many local private dts with the bindings, those local change just can not
>>>> upstream at this time, below is an example.
>>>>
>>>> The device tree is a platform description language. It's there to let
>>>> the OS know what the hardware is, but the state of hardware support in
>>>> the said OS isn't a parameter we have to take into account for a new
>>>> binding.
>>>>
>>>> If you don't have any DDC support at the moment, use the firmware
>>>> mechanism above, or add fixed modes using drm_add_modes_noedid in the
>>>> driver, and leave the DT out of it. Once you'll gain support for the
>>>> EDID readout in the driver, then it'll just work and you won't need to
>>>> change the DT again.
>>>>
>> The resolution will be 1024x768, it will also add a lot modes which may
>> not supported by the specific panel. Take 1024x600 as an example,
>> Both drm_add_modes_noedid() and firmware mechanism above will fail.
>>
>> Because the user supply EDID only and manufacturer of some strange panel
>> supply EDID only.
> It's fairly easy to address: if the panel has some EDID, make the driver
> able to read it; if it doesn't, describe the mode in the DT.
>
> And if you want to be nice to your users, the firmware can even patch
> the DT at boot time to add the necessary bits based on whatever info it
> has, it doesn't have to be static.
>
> Maxime
