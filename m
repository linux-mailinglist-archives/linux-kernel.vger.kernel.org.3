Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3A24BE69F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379399AbiBUPnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 10:43:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348013AbiBUPnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 10:43:43 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF93622B0D;
        Mon, 21 Feb 2022 07:43:19 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id f10so13043412qkg.9;
        Mon, 21 Feb 2022 07:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=fnv2CA3CXLhV9zUWiwOd3ew24NJh0NPxMi5GC2dqx58=;
        b=E9sa5bYYmbLzI+ApcAIqNvFwo2ioZ6Pu5rmKBfRK+161EO9Rr6PUnCNfSDK7HEuv+M
         ezpoc4YGMwHoKp+23uIF9ytxGdaCslVGZxtAcC5Ze18g1JfMsH8zO9ZIfuktU83zy/cF
         Cl8AuRJzTpIk8dWp49/jor8eFX4/xnqskCkg98v1qABMHVYuwaEqbHyt4vXfVaWjoFbb
         UjnzN7PZFZaS3Go47J3+n/ew1aP7KX6n2QtHFsdgBm9NIC0vHqd8S/28oI/kQgM2ZKpO
         cokLYx7UMb/TV34etSi1mzrPtZu9OodrqLh+YPpvVk0RgBa5H8vuRsERVCPScU9RwcWh
         X46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=fnv2CA3CXLhV9zUWiwOd3ew24NJh0NPxMi5GC2dqx58=;
        b=kpQ20TlIVaUAttcqH1r4C0feKCx9rHG6AzWNsDXUdF5IT5B8ZeKdjEQulzSyHF6Y0r
         DmHIfEI18QzhraLhfMvv7dOfrF2nwCptCdtNnNxAiFdjZOxn8iPh8lr1CoifyFVw7etY
         JTJrKu+9lKQ6fDL/8wSgRY1UDPBvCHrL1CuCtFkglQrxBaa0I5V9HJ9hzFovJ/z5I40W
         hPUEUqH7/ziqZ8MlaCE/hWQehVSd12UmyQ9/EYk8nGO7xxovtu0saywQnuAdddCikk7V
         Pg5oKDag9TSTuV6LHk2d3yt4dfgfjGWYsAfi83C6OtSjygBGP6ABubQje6meAJ7cUwrO
         Zb1Q==
X-Gm-Message-State: AOAM530U6Bn1a5DNTTXZs033AV+P15RYyB/zGr/TKWzjsAoMS07UpghN
        U3o6bKCZonjZ1q5ZbPFBcFQ=
X-Google-Smtp-Source: ABdhPJzIYEcQwhc+ZoLryEqJ6lhYs1dxTsRwSnSbGA7rFcuqT40r3GT4SP+PTyr24dIgJz1RKclqsQ==
X-Received: by 2002:a37:f719:0:b0:648:cd93:3198 with SMTP id q25-20020a37f719000000b00648cd933198mr4108766qkj.179.1645458199024;
        Mon, 21 Feb 2022 07:43:19 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u9sm26827239qko.110.2022.02.21.07.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 07:43:18 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2aae3bac-c9b3-ab47-aae4-a3c7b6fb4bb5@roeck-us.net>
Date:   Mon, 21 Feb 2022 07:43:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Jon Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20210618215455.19986-1-digetx@gmail.com>
 <20210618215455.19986-3-digetx@gmail.com>
 <9580f660-2a11-40e4-2986-f05703822d72@nvidia.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 2/4] hwmon: (lm90) Use hwmon_notify_event()
In-Reply-To: <9580f660-2a11-40e4-2986-f05703822d72@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/22 04:01, Jon Hunter wrote:
> Hi Dmitry,
> 
> On 18/06/2021 22:54, Dmitry Osipenko wrote:
>> Use hwmon_notify_event() to notify userspace and thermal core about
>> temperature changes.
>>
>> Suggested-by: Guenter Roeck <linux@roeck-us.net>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>   drivers/hwmon/lm90.c | 44 +++++++++++++++++++++++++++++++++-----------
>>   1 file changed, 33 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
>> index 2e057fad05b4..e7b678a40b39 100644
>> --- a/drivers/hwmon/lm90.c
>> +++ b/drivers/hwmon/lm90.c
>> @@ -465,6 +465,7 @@ enum lm90_temp11_reg_index {
>>   struct lm90_data {
>>       struct i2c_client *client;
>> +    struct device *hwmon_dev;
>>       u32 channel_config[4];
>>       struct hwmon_channel_info temp_info;
>>       const struct hwmon_channel_info *info[3];
>> @@ -1731,22 +1732,41 @@ static bool lm90_is_tripped(struct i2c_client *client, u16 *status)
>>       if ((st & (LM90_STATUS_LLOW | LM90_STATUS_LHIGH | LM90_STATUS_LTHRM)) ||
>>           (st2 & MAX6696_STATUS2_LOT2))
>> -        dev_warn(&client->dev,
>> -             "temp%d out of range, please check!\n", 1);
>> +        dev_dbg(&client->dev,
>> +            "temp%d out of range, please check!\n", 1);
>>       if ((st & (LM90_STATUS_RLOW | LM90_STATUS_RHIGH | LM90_STATUS_RTHRM)) ||
>>           (st2 & MAX6696_STATUS2_ROT2))
>> -        dev_warn(&client->dev,
>> -             "temp%d out of range, please check!\n", 2);
>> +        dev_dbg(&client->dev,
>> +            "temp%d out of range, please check!\n", 2);
>>       if (st & LM90_STATUS_ROPEN)
>> -        dev_warn(&client->dev,
>> -             "temp%d diode open, please check!\n", 2);
>> +        dev_dbg(&client->dev,
>> +            "temp%d diode open, please check!\n", 2);
>>       if (st2 & (MAX6696_STATUS2_R2LOW | MAX6696_STATUS2_R2HIGH |
>>              MAX6696_STATUS2_R2THRM | MAX6696_STATUS2_R2OT2))
>> -        dev_warn(&client->dev,
>> -             "temp%d out of range, please check!\n", 3);
>> +        dev_dbg(&client->dev,
>> +            "temp%d out of range, please check!\n", 3);
>>       if (st2 & MAX6696_STATUS2_R2OPEN)
>> -        dev_warn(&client->dev,
>> -             "temp%d diode open, please check!\n", 3);
>> +        dev_dbg(&client->dev,
>> +            "temp%d diode open, please check!\n", 3);
>> +
>> +    if (st & LM90_STATUS_LLOW)
>> +        hwmon_notify_event(data->hwmon_dev, hwmon_temp,
>> +                   hwmon_temp_min, 0);
>> +    if (st & LM90_STATUS_RLOW)
>> +        hwmon_notify_event(data->hwmon_dev, hwmon_temp,
>> +                   hwmon_temp_min, 1);
>> +    if (st2 & MAX6696_STATUS2_R2LOW)
>> +        hwmon_notify_event(data->hwmon_dev, hwmon_temp,
>> +                   hwmon_temp_min, 2);
>> +    if (st & LM90_STATUS_LHIGH)
>> +        hwmon_notify_event(data->hwmon_dev, hwmon_temp,
>> +                   hwmon_temp_max, 0);
>> +    if (st & LM90_STATUS_RHIGH)
>> +        hwmon_notify_event(data->hwmon_dev, hwmon_temp,
>> +                   hwmon_temp_max, 1);
>> +    if (st2 & MAX6696_STATUS2_R2HIGH)
>> +        hwmon_notify_event(data->hwmon_dev, hwmon_temp,
>> +                   hwmon_temp_max, 2);
> 
> 
> We observed a random null pointer deference crash somewhere in the
> thermal core (crash log below is not very helpful) when calling
> mutex_lock(). It looks like we get an interrupt when this crash
> happens.
> 
> Looking at the lm90 driver, per the above, I now see we are calling
> hwmon_notify_event() from the lm90 interrupt handler. Looking at
> hwmon_notify_event() I see that ...
> 
> hwmon_notify_event()
>    --> hwmon_thermal_notify()
>      --> thermal_zone_device_update()
>        --> update_temperature()
>          --> mutex_lock()
> 
> So although I don't completely understand the crash, it does seem
> that we should not be calling hwmon_notify_event() from the
> interrupt handler.
> 
As mentioned separately, this is not the problem.

I think the problem may be that this is not a devicetree system
(or the lm90 devide does not have a devicetree node), but thermal
notification currently only works in such systems because the hwmon
subsystem uses the devicetree registration method. At the same time,
CONFIG_THERMAL_OF is obviously enabled. Unfortunately, the hwmon code
does not bail out in that situation due to another bug.

I'll revert the related patches. This will have to be sorted out
separately in a later kernel release.

Thanks,
Guenter

> BTW I have not reproduced this myself yet, so I have just been
> reviewing the code to try and understand this.
> 
> Jon
> 
> [ 7465.595066] Unable to handle kernel NULL pointer dereference at virtual address 00000000000003cd
> [ 7465.596619] Mem abort info:
> [ 7465.597854]   ESR = 0x96000021
> [ 7465.599097]   EC = 0x25: DABT (current EL), IL = 32 bits
> [ 7465.600338]   SET = 0, FnV = 0
> [ 7465.601526]   EA = 0, S1PTW = 0
> [ 7465.602705]   FSC = 0x21: alignment fault
> [ 7465.603885] Data abort info:
> [ 7465.605017]   ISV = 0, ISS = 0x00000021
> [ 7465.606171]   CM = 0, WnR = 0
> [ 7465.607301] user pgtable: 64k pages, 48-bit VAs, pgdp=00000001041f1800
> [ 7465.608490] [00000000000003cd] pgd=0000000000000000, p4d=0000000000000000, pud=0000000000000000
> [ 7465.609814] Internal error: Oops: 96000021 [#1] PREEMPT SMP
> [ 7465.610991] Modules linked in: bridge stp llc snd_soc_tegra210_admaif snd_soc_tegra_pcm snd_soc_tegra210_mixer snd_soc_tegra210_mvc snd_soc_tegra210_i2s snd_soc_tegra210_dmic sn
> d_soc_tegra210_adx snd_soc_tegra210_sfc snd_soc_tegra210_amx snd_soc_tegra210_ahub tegra210_adma snd_soc_rt5659 snd_soc_rl6231 pwm_tegra tegra_aconnect snd_hda_codec_hdmi rfkill snd_hda_tegra snd_hda_codec at24 phy_tegra194_p2u snd_hda_core lm90 snd_soc_tegra_audio_graph_card tegra_bpmp_thermal snd_soc_audio_graph_card snd_soc_simple_card_utils pwm_fan crct10dif_ce pcie_tegra194 cec drm_kms_helper drm ip_tables x_tables ipv6
> [ 7465.632232] CPU: 2 PID: 433 Comm: irq/140-lm90 Tainted: G           O      5.16.0-tegra-g9d109504d83a #1
> [ 7465.636285] Hardware name: Unknown NVIDIA Jetson AGX Xavier Developer Kit/NVIDIA Jetson AGX Xavier Developer Kit, BIOS v1.1.2-901d3c52 02/07/2022
> [ 7465.650457] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [ 7465.656210] pc : mutex_lock+0x18/0x60
> [ 7465.660134] lr : thermal_zone_device_update+0x40/0x2e0
> [ 7465.665117] sp : ffff800014c4fc60
> [ 7465.668781] x29: ffff800014c4fc60 x28: ffff365ee3f6e000 x27: ffffdde218426790
> [ 7465.675882] x26: ffff365ee3f6e000 x25: 0000000000000000 x24: ffff365ee3f6e000
> [ 7465.683485] x23: ffffdde218426870 x22: ffff365ee3f6e000 x21: 00000000000003cd
> [ 7465.690816] x20: ffff365ee8bf3308 x19: ffffffffffffffed x18: 0000000000000000
> [ 7465.697982] x17: ffffdde21842689c x16: ffffdde1cb7a0b7c x15: 0000000000000040
> [ 7465.705320] x14: ffffdde21a4889a0 x13: 0000000000000228 x12: 0000000000000000
> [ 7465.712493] x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
> [ 7465.719580] x8 : 0000000001120000 x7 : 0000000000000001 x6 : 0000000000000000
> [ 7465.727099] x5 : 0068000878e20f07 x4 : 0000000000000000 x3 : 00000000000003cd
> [ 7465.734348] x2 : ffff365ee3f6e000 x1 : 0000000000000000 x0 : 00000000000003cd
> [ 7465.741347] Call trace:
> [ 7465.744207]  mutex_lock+0x18/0x60
> [ 7465.747427]  hwmon_notify_event+0xfc/0x110
> [ 7465.751358]  0xffffdde1cb7a0a90
> [ 7465.754574]  0xffffdde1cb7a0b7c
> [ 7465.757705]  irq_thread_fn+0x2c/0xa0
> [ 7465.760937]  irq_thread+0x134/0x240
> [ 7465.764850]  kthread+0x178/0x190
> [ 7465.768083]  ret_from_fork+0x10/0x20
> [ 7465.771748] Code: d503201f d503201f d2800001 aa0103e4 (c8e47c02)
> [ 7465.777865] ---[ end trace f0b3723991411538 ]---
> 

