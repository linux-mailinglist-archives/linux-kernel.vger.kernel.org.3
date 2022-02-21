Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB764BE767
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377178AbiBUN7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 08:59:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347740AbiBUN7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:59:54 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04521A3A4;
        Mon, 21 Feb 2022 05:59:30 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id o6so14752450ljp.3;
        Mon, 21 Feb 2022 05:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0Q2WCf/LNvc1a1im3j+pPkek7blrVzXb3qPqxF+waaM=;
        b=kJbOHHG0/aXh3ndm/PTuMMbmmKLFMnY6NkqH3gkdIKMCZYiheFw0a4GTX45dy4xLGK
         u1uUlvZwRdYedKqhLb8d5z0P44zDf6A0ej139Z+dpyY09mBaQ9XU945+0UtznYz7xpXv
         Yk+9Dn/yTbLPvgjbTPUAky/p/LWEKUp+w/LOjrV/tJ4MVtfn2m/M53/PuFmlX6nelxsA
         ifs7qyRwL1mnXwYusDE+n50ODrakh/KxJ1+D3XZRyAA2UXJAMxFwPgEeJUV2lVGdYS3M
         n6nnpboAlOQMS2lquRkh5g5oBwjUL2l4Ia7wGEpo33v9fUFU6+JMktASP52n+vVXsgUk
         Mz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0Q2WCf/LNvc1a1im3j+pPkek7blrVzXb3qPqxF+waaM=;
        b=irLpVHEtA487fOxxBQ6ehbFP/YblfK5/+/ZBRe1knAoIsNxemo/4G/uiQ6LSmO8N6W
         tL5yA+7W8ePreCBDzUWALLpDS/AJPNKg1n/gyLFQdfN6pcbhmIEC/KjxeKLZKx71SA8m
         m7wMlNspGvONUm/WMa32qPpG71gFhno5CtVd9YwQs7QxAuwHuBEOpx9hES1JXv59pd+G
         nHg1iekKVTJ+bs/Caxwn2S/iJvbZkKhfKD8VgbH4Gha/gAS878X5JSO2Ka9FxjKMd6Fh
         MooxonVs9/cZ4zk0+q90cQvWyJGpUi4sUw4QhrHk2ZKVUi/63v+VQTcWi5WsHap4ldS0
         66Hw==
X-Gm-Message-State: AOAM532a6VCoQWMvwT4c47Jmu7RXtnprDt+N9tkkK3BYuPthai9wL2PH
        gCwQ8mJrXOx7KbsnXjFLCA0=
X-Google-Smtp-Source: ABdhPJxxGLltQHFT3SdEpkYSOtWrgLO8Y5X2Okiyj3vy0VU3i4qp/r9Od0UbNCCCjygHu9jIdtqQ4g==
X-Received: by 2002:a2e:9b4d:0:b0:244:da30:84c2 with SMTP id o13-20020a2e9b4d000000b00244da3084c2mr14465804ljj.359.1645451968950;
        Mon, 21 Feb 2022 05:59:28 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.googlemail.com with ESMTPSA id h6sm1357737ljk.38.2022.02.21.05.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 05:59:27 -0800 (PST)
Message-ID: <a557b848-034e-0562-2ba9-c18d8c674fad@gmail.com>
Date:   Mon, 21 Feb 2022 16:59:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/4] hwmon: (lm90) Use hwmon_notify_event()
Content-Language: en-US
To:     Jon Hunter <jonathanh@nvidia.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20210618215455.19986-1-digetx@gmail.com>
 <20210618215455.19986-3-digetx@gmail.com>
 <9580f660-2a11-40e4-2986-f05703822d72@nvidia.com>
 <8d0c818a-d714-d8ab-f825-073cf549b959@gmail.com>
 <13b07bb3-90e4-a501-469c-ce64bc90bfd5@nvidia.com>
 <4c12cab4-6265-78c0-46ce-d4014c9919fe@gmail.com>
 <f6c833fa-e93e-9bca-4951-3043d638c1ac@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <f6c833fa-e93e-9bca-4951-3043d638c1ac@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

21.02.2022 16:50, Jon Hunter пишет:
> 
> On 21/02/2022 12:59, Dmitry Osipenko wrote:
>> 21.02.2022 15:56, Jon Hunter пишет:
>>>
>>> On 21/02/2022 12:36, Dmitry Osipenko wrote:
>>>> 21.02.2022 15:01, Jon Hunter пишет:
>>>>> Hi Dmitry,
>>>>>
>>>>> On 18/06/2021 22:54, Dmitry Osipenko wrote:
>>>>>> Use hwmon_notify_event() to notify userspace and thermal core about
>>>>>> temperature changes.
>>>>>>
>>>>>> Suggested-by: Guenter Roeck <linux@roeck-us.net>
>>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>>>> ---
>>>>>>     drivers/hwmon/lm90.c | 44
>>>>>> +++++++++++++++++++++++++++++++++-----------
>>>>>>     1 file changed, 33 insertions(+), 11 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
>>>>>> index 2e057fad05b4..e7b678a40b39 100644
>>>>>> --- a/drivers/hwmon/lm90.c
>>>>>> +++ b/drivers/hwmon/lm90.c
>>>>>> @@ -465,6 +465,7 @@ enum lm90_temp11_reg_index {
>>>>>>       struct lm90_data {
>>>>>>         struct i2c_client *client;
>>>>>> +    struct device *hwmon_dev;
>>>>>>         u32 channel_config[4];
>>>>>>         struct hwmon_channel_info temp_info;
>>>>>>         const struct hwmon_channel_info *info[3];
>>>>>> @@ -1731,22 +1732,41 @@ static bool lm90_is_tripped(struct i2c_client
>>>>>> *client, u16 *status)
>>>>>>           if ((st & (LM90_STATUS_LLOW | LM90_STATUS_LHIGH |
>>>>>> LM90_STATUS_LTHRM)) ||
>>>>>>             (st2 & MAX6696_STATUS2_LOT2))
>>>>>> -        dev_warn(&client->dev,
>>>>>> -             "temp%d out of range, please check!\n", 1);
>>>>>> +        dev_dbg(&client->dev,
>>>>>> +            "temp%d out of range, please check!\n", 1);
>>>>>>         if ((st & (LM90_STATUS_RLOW | LM90_STATUS_RHIGH |
>>>>>> LM90_STATUS_RTHRM)) ||
>>>>>>             (st2 & MAX6696_STATUS2_ROT2))
>>>>>> -        dev_warn(&client->dev,
>>>>>> -             "temp%d out of range, please check!\n", 2);
>>>>>> +        dev_dbg(&client->dev,
>>>>>> +            "temp%d out of range, please check!\n", 2);
>>>>>>         if (st & LM90_STATUS_ROPEN)
>>>>>> -        dev_warn(&client->dev,
>>>>>> -             "temp%d diode open, please check!\n", 2);
>>>>>> +        dev_dbg(&client->dev,
>>>>>> +            "temp%d diode open, please check!\n", 2);
>>>>>>         if (st2 & (MAX6696_STATUS2_R2LOW | MAX6696_STATUS2_R2HIGH |
>>>>>>                MAX6696_STATUS2_R2THRM | MAX6696_STATUS2_R2OT2))
>>>>>> -        dev_warn(&client->dev,
>>>>>> -             "temp%d out of range, please check!\n", 3);
>>>>>> +        dev_dbg(&client->dev,
>>>>>> +            "temp%d out of range, please check!\n", 3);
>>>>>>         if (st2 & MAX6696_STATUS2_R2OPEN)
>>>>>> -        dev_warn(&client->dev,
>>>>>> -             "temp%d diode open, please check!\n", 3);
>>>>>> +        dev_dbg(&client->dev,
>>>>>> +            "temp%d diode open, please check!\n", 3);
>>>>>> +
>>>>>> +    if (st & LM90_STATUS_LLOW)
>>>>>> +        hwmon_notify_event(data->hwmon_dev, hwmon_temp,
>>>>>> +                   hwmon_temp_min, 0);
>>>>>> +    if (st & LM90_STATUS_RLOW)
>>>>>> +        hwmon_notify_event(data->hwmon_dev, hwmon_temp,
>>>>>> +                   hwmon_temp_min, 1);
>>>>>> +    if (st2 & MAX6696_STATUS2_R2LOW)
>>>>>> +        hwmon_notify_event(data->hwmon_dev, hwmon_temp,
>>>>>> +                   hwmon_temp_min, 2);
>>>>>> +    if (st & LM90_STATUS_LHIGH)
>>>>>> +        hwmon_notify_event(data->hwmon_dev, hwmon_temp,
>>>>>> +                   hwmon_temp_max, 0);
>>>>>> +    if (st & LM90_STATUS_RHIGH)
>>>>>> +        hwmon_notify_event(data->hwmon_dev, hwmon_temp,
>>>>>> +                   hwmon_temp_max, 1);
>>>>>> +    if (st2 & MAX6696_STATUS2_R2HIGH)
>>>>>> +        hwmon_notify_event(data->hwmon_dev, hwmon_temp,
>>>>>> +                   hwmon_temp_max, 2);
>>>>>
>>>>>
>>>>> We observed a random null pointer deference crash somewhere in the
>>>>> thermal core (crash log below is not very helpful) when calling
>>>>> mutex_lock(). It looks like we get an interrupt when this crash
>>>>> happens.
>>>>>
>>>>> Looking at the lm90 driver, per the above, I now see we are calling
>>>>> hwmon_notify_event() from the lm90 interrupt handler. Looking at
>>>>> hwmon_notify_event() I see that ...
>>>>>
>>>>> hwmon_notify_event()
>>>>>     --> hwmon_thermal_notify()
>>>>>       --> thermal_zone_device_update()
>>>>>         --> update_temperature()
>>>>>           --> mutex_lock()
>>>>>
>>>>> So although I don't completely understand the crash, it does seem
>>>>> that we should not be calling hwmon_notify_event() from the
>>>>> interrupt handler.
>>>>>
>>>>> BTW I have not reproduced this myself yet, so I have just been
>>>>> reviewing the code to try and understand this.
>>>>
>>>> Matt Merhar was experiencing a similar issue on T30 Ouya, but I never
>>>> managed to reproduce it on Nexus 7 and Acer A500 tablets, and couldn't
>>>> spot any problem in the code. IIRC, it was a NULL dereference of
>>>> another
>>>> pointer within that code.
>>>
>>>
>>> OK. From looking at the above I don't think we can call
>>> hwmon_notify_event() from an interrupt handler because this is going to
>>> try and request a mutex. So we need to fix that.
>>
>> The interrupt is threaded, so it can take a mutex.
> 
> 
> Ah yes, I clearly overlooked that detail.
> 
> Good news is that I have been able to reproduce this on Jetson Xavier by
> ...
> 
> $ echo 40000 | sudo tee
> /sys/devices/platform/bpmp/bpmp\:i2c/i2c-0/0-004c/hwmon/hwmon0/temp1_max
> 40000
> [  105.890995] Unable to handle kernel NULL pointer dereference at
> virtual address 00000000000003cd
> [  105.900105] Mem abort info:
> [  105.903328]   ESR = 0x96000021
> [  105.906673]   EC = 0x25: DABT (current EL), IL = 32 bits
> [  105.912407]   SET = 0, FnV = 0
> [  105.915751]   EA = 0, S1PTW = 0
> [  105.919230]   FSC = 0x21: alignment fault
> [  105.923698] Data abort info:
> [  105.926853]   ISV = 0, ISS = 0x00000021
> [  105.931139]   CM = 0, WnR = 0
> [  105.934420] user pgtable: 64k pages, 48-bit VAs, pgdp=0000000101f6b600
> [  105.941230] [00000000000003cd] pgd=0000000000000000,
> p4d=0000000000000000, pud=0000000000000000
> [  105.950864] Internal error: Oops: 96000021 [#1] PREEMPT SMP
> [  105.956608] Modules linked in: btrfs blake2b_generic libcrc32c xor
> xor_neon raid6_pq zstd_compress rfkill snd_soc_tegra210_mixer
> snd_soc_tegra210_adx snd_soc_tegra210_dmic snd_soc_tegra210_mvc
> snd_soc_tegra210_amx snd_soc_tegra210_sfc snd_soc_tegra210_admaif
> snd_soc_tegra_pcm snd_soc_tegra210_i2s snd_soc_tegra210_ahub uvcvideo
> videobuf2_vmalloc tegra210_adma videobuf2_memops videobuf2_v4l2 cec
> videobuf2_common drm_kms_
> helper videodev mc snd_soc_rt5659 snd_soc_rl6231 pwm_tegra
> tegra_aconnect snd_hda_codec_hdmi lm90 tegra_bpmp_thermal snd_hda_tegra
> snd_soc_tegra_audio_graph_card snd_hda_codec snd_hda_core
> phy_tegra194_p2u snd_soc_
> audio_graph_card at24 snd_soc_simple_card_utils pwm_fan pcie_tegra194
> crct10dif_ce drm ip_tables x_tables ipv6
> [  106.032497] CPU: 3 PID: 296 Comm: irq/126-lm90 Tainted: G          
> O      5.16.0-tegra-291805-gf905a41db850 #3
> [  106.042869] Hardware name: Unknown NVIDIA Jetson AGX Xavier Developer
> Kit/NVIDIA Jetson AGX Xavier Developer Kit, BIOS v1.1.2-901d3c52ed23
> 02/14/2022
> [  106.056392] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS
> BTYPE=--)
> [  106.063903] pc : mutex_lock+0x18/0x60
> [  106.067750] lr : thermal_zone_device_update+0x40/0x2e0
> [  106.073161] sp : ffff80001494fc60
> [  106.076553] x29: ffff80001494fc60 x28: ffff59bb27801c00 x27:
> ffffa4295d826790
> [  106.084052] x26: ffff59bb27801c00 x25: 0000000000000000 x24:
> ffff59bb27801c00
> [  106.091541] x23: ffffa4295d826870 x22: ffff59bb27801c00 x21:
> 00000000000003cd
> [  106.098905] x20: ffff59bb28078f08 x19: ffffffffffffffed x18:
> 0000000000000000
> [  106.106387] x17: ffffa4295d82689c x16: ffffa4292d400b7c x15:
> 0000000000000040
> [  106.113766] x14: ffffa4295f8889a0 x13: 0000000000000228 x12:
> 0000000000000000
> [  106.121294] x11: 0000000000000000 x10: 0000000000000000 x9 :
> 0000000000000000
> [  106.128793] x8 : 0000000000c2f000 x7 : 0000000000000001 x6 :
> 0000000000000000
> [  106.136133] x5 : 006800047a8e0f07 x4 : 0000000000000000 x3 :
> 00000000000003cd
> [  106.143473] x2 : ffff59bb27801c00 x1 : 0000000000000000 x0 :
> 00000000000003cd
> [  106.150813] Call trace:
> [  106.153333]  mutex_lock+0x18/0x60
> [  106.156804]  hwmon_notify_event+0xfc/0x110
> [  106.161164]  0xffffa4292d400a74
> [  106.164417]  0xffffa4292d400b7c
> [  106.167659]  irq_thread_fn+0x2c/0xa0
> [  106.171359]  irq_thread+0x134/0x240
> [  106.174971]  kthread+0x178/0x190
> [  106.178469]  ret_from_fork+0x10/0x20
> [  106.182187] Code: d503201f d503201f d2800001 aa0103e4 (c8e47c02)
> [  106.188550] ---[ end trace 62bf0e0b37a16815 ]---
> [  106.193261] Kernel panic - not syncing: Oops: Fatal exception
> [  106.199106] SMP: stopping secondary CPUs
> [  106.203401] Kernel Offset: 0x24294d740000 from 0xffff800010000000
> [  106.209584] PHYS_OFFSET: 0xffffa645e0000000
> [  106.214011] CPU features: 0x0,40000843,06400846
> [  106.218651] Memory Limit: none
> [  106.221822] ---[ end Kernel panic - not syncing: Oops: Fatal
> exception ]---
> 
> 
> I am wondering if this is some sort of race condition in the thermal
> shutdown path. I would be interested to know if you see the same.

Indeed, it feels like a race condition. I tried to reproduce again on
A500 using next-20220217 and nothing bad happens.

# sensors
nct1008-i2c-2-4c
Adapter: 7000d000.i2c
temp1:        +31.0°C  (low  = -64.0°C, high = +30.0°C)  ALARM (HIGH)
                       (crit = +120.0°C, hyst = +110.0°C)
temp2:        +37.8°C  (low  = -64.0°C, high = +30.0°C)  ALARM (HIGH)
                       (crit = +115.0°C, hyst = +105.0°C)
