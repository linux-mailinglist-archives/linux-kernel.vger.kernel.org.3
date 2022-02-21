Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E894BE109
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358055AbiBUMhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 07:37:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348022AbiBUMhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 07:37:16 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D3DE63;
        Mon, 21 Feb 2022 04:36:53 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id o6so14405588ljp.3;
        Mon, 21 Feb 2022 04:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mEernK9EmKj7bI8X1Jd6lo2HouXSyKPu6/emVUbRPRc=;
        b=av1lhYgsNUd7hm9q4wRn3Ags/yGBsnkT9e/GTSzGAskHpNx78RYq3cQxHbsdh4Ma2H
         Me6tCEjgKzMt2gu73QPu4DFSF96O9yhfMgDjREanAEVEPwIBymgxnVAx9+EEPsIWdrPK
         /WZfIaLGl4RHZtZ1pw+ZKgTTOn3+JZwKdqJTm494NETYx4hzeXdM8pKzZVZkNWB/MN9c
         zv/T2VC1cyScSYFHB8yC0ynvsjxtNEd/QWCd0enZtegrf7KMzFP8/H9oeQaIPo2uR6Hj
         Nfac196cYvY+U9spmlXfH0t9OlxzaVZDFjXUvZYr3z5MtPOKoJQJOZ+tRun+NtScQGcO
         fUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mEernK9EmKj7bI8X1Jd6lo2HouXSyKPu6/emVUbRPRc=;
        b=NJf/gE5W04vI/Ua73RUSX+VRINDRWuzgs5VCYV/8Tld3k4UWNieFGzWg6a/IYeFnIo
         U36OHdaAX9qKCK2QlNcg7ez+nURUs5odpStYHNEpff7ZViNlv3I9kDLOAtZsT/WfvnBB
         L1PkMHDG0ps+jUALhoEBgmekp3UCWK+Lpuj/gDXFOAx3utQdGKZ79G0WYLK4tfgohcD2
         hmixhI9qc1e6IY7WTXcMWcDjrW6+36xVZ4/m+psKs7bjtCpFWaMlTpKYKb4x19YlaHQd
         mubKdhxcstEOOor55S0vXoB01xIQG1NL3dnWwddIyDVbMBjxtE4cugg/OhfPfJjh/2sz
         neNg==
X-Gm-Message-State: AOAM530C6bsxpwNTx+HqZyJyvnm/A9FouPMeBUNHW6rhK7qBbTM2KoNi
        TatTFX/O6btg8Vymy9Nujrw=
X-Google-Smtp-Source: ABdhPJwwu7gPAthFqypL6MPtpCZMVcSXzW7wobVDtXZFxJoCOcaaB05GK4ZdvxWKKHA4YhvL30K20w==
X-Received: by 2002:a2e:9693:0:b0:239:3f32:671f with SMTP id q19-20020a2e9693000000b002393f32671fmr14613668lji.42.1645447011403;
        Mon, 21 Feb 2022 04:36:51 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.googlemail.com with ESMTPSA id f2sm1316874ljn.11.2022.02.21.04.36.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 04:36:50 -0800 (PST)
Message-ID: <8d0c818a-d714-d8ab-f825-073cf549b959@gmail.com>
Date:   Mon, 21 Feb 2022 15:36:50 +0300
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
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <9580f660-2a11-40e4-2986-f05703822d72@nvidia.com>
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

21.02.2022 15:01, Jon Hunter пишет:
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
>>     struct lm90_data {
>>       struct i2c_client *client;
>> +    struct device *hwmon_dev;
>>       u32 channel_config[4];
>>       struct hwmon_channel_info temp_info;
>>       const struct hwmon_channel_info *info[3];
>> @@ -1731,22 +1732,41 @@ static bool lm90_is_tripped(struct i2c_client
>> *client, u16 *status)
>>         if ((st & (LM90_STATUS_LLOW | LM90_STATUS_LHIGH |
>> LM90_STATUS_LTHRM)) ||
>>           (st2 & MAX6696_STATUS2_LOT2))
>> -        dev_warn(&client->dev,
>> -             "temp%d out of range, please check!\n", 1);
>> +        dev_dbg(&client->dev,
>> +            "temp%d out of range, please check!\n", 1);
>>       if ((st & (LM90_STATUS_RLOW | LM90_STATUS_RHIGH |
>> LM90_STATUS_RTHRM)) ||
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
>   --> hwmon_thermal_notify()
>     --> thermal_zone_device_update()
>       --> update_temperature()
>         --> mutex_lock()
> 
> So although I don't completely understand the crash, it does seem
> that we should not be calling hwmon_notify_event() from the
> interrupt handler.
> 
> BTW I have not reproduced this myself yet, so I have just been
> reviewing the code to try and understand this.

Matt Merhar was experiencing a similar issue on T30 Ouya, but I never
managed to reproduce it on Nexus 7 and Acer A500 tablets, and couldn't
spot any problem in the code. IIRC, it was a NULL dereference of another
pointer within that code.

We tried to add couple debug printks and the problem disappears when you
try to look at it, which is very suspicious.

> 
> [ 7465.595066] Unable to handle kernel NULL pointer dereference at
> virtual address 00000000000003cd
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
> [ 7465.608490] [00000000000003cd] pgd=0000000000000000,
> p4d=0000000000000000, pud=0000000000000000
> [ 7465.609814] Internal error: Oops: 96000021 [#1] PREEMPT SMP
> [ 7465.610991] Modules linked in: bridge stp llc snd_soc_tegra210_admaif
> snd_soc_tegra_pcm snd_soc_tegra210_mixer snd_soc_tegra210_mvc
> snd_soc_tegra210_i2s snd_soc_tegra210_dmic sn
> d_soc_tegra210_adx snd_soc_tegra210_sfc snd_soc_tegra210_amx
> snd_soc_tegra210_ahub tegra210_adma snd_soc_rt5659 snd_soc_rl6231
> pwm_tegra tegra_aconnect snd_hda_codec_hdmi rfkill snd_hda_tegra
> snd_hda_codec at24 phy_tegra194_p2u snd_hda_core lm90
> snd_soc_tegra_audio_graph_card tegra_bpmp_thermal
> snd_soc_audio_graph_card snd_soc_simple_card_utils pwm_fan crct10dif_ce
> pcie_tegra194 cec drm_kms_helper drm ip_tables x_tables ipv6
> [ 7465.632232] CPU: 2 PID: 433 Comm: irq/140-lm90 Tainted: G          
> O      5.16.0-tegra-g9d109504d83a #1
> [ 7465.636285] Hardware name: Unknown NVIDIA Jetson AGX Xavier Developer
> Kit/NVIDIA Jetson AGX Xavier Developer Kit, BIOS v1.1.2-901d3c52 02/07/2022
> [ 7465.650457] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS
> BTYPE=--)
> [ 7465.656210] pc : mutex_lock+0x18/0x60
> [ 7465.660134] lr : thermal_zone_device_update+0x40/0x2e0
> [ 7465.665117] sp : ffff800014c4fc60
> [ 7465.668781] x29: ffff800014c4fc60 x28: ffff365ee3f6e000 x27:
> ffffdde218426790
> [ 7465.675882] x26: ffff365ee3f6e000 x25: 0000000000000000 x24:
> ffff365ee3f6e000
> [ 7465.683485] x23: ffffdde218426870 x22: ffff365ee3f6e000 x21:
> 00000000000003cd
> [ 7465.690816] x20: ffff365ee8bf3308 x19: ffffffffffffffed x18:
> 0000000000000000
> [ 7465.697982] x17: ffffdde21842689c x16: ffffdde1cb7a0b7c x15:
> 0000000000000040
> [ 7465.705320] x14: ffffdde21a4889a0 x13: 0000000000000228 x12:
> 0000000000000000
> [ 7465.712493] x11: 0000000000000000 x10: 0000000000000000 x9 :
> 0000000000000000
> [ 7465.719580] x8 : 0000000001120000 x7 : 0000000000000001 x6 :
> 0000000000000000
> [ 7465.727099] x5 : 0068000878e20f07 x4 : 0000000000000000 x3 :
> 00000000000003cd
> [ 7465.734348] x2 : ffff365ee3f6e000 x1 : 0000000000000000 x0 :
> 00000000000003cd
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

