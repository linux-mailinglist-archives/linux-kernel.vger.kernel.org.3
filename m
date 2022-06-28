Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E090455CBA1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344585AbiF1LqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344512AbiF1LqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:46:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657CF340D3;
        Tue, 28 Jun 2022 04:44:36 -0700 (PDT)
Received: from [192.168.2.145] (109-252-118-164.nat.spd-mgts.ru [109.252.118.164])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CFC37660184F;
        Tue, 28 Jun 2022 12:44:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656416674;
        bh=Vq5C4bT0TiadIpd2tEqU0JzUXydBEhR40E+ZcKSOCUo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RKEY5opDUA/HZSdk6HwnKhzBmq6nRVCS3v/NWKqMu1PMIeBdeXeSWbRS4Xn5uUMk1
         k/xdYJxpKVUEGLs5pqjQwwATIdGwwAZYKzKrmACKz1LePsPHNyftCwaSj1tZBGF6uq
         0eS3Zp8Ck+LQx5u+5fPlF8RoBwLxpl3/z4+POjHgUIJ8GABDDGrOuwCHXtXMcb/axL
         IdvCkh81M1oPN4HTUGDdeXZuVBNxs33s4pLAE3b7x8TmO2CJRVOsqvgVm1LucQwFCj
         JqDFHKPaE7R7E9tJRvZamO3oo4wU5QH+0yUjttlJX1njblanMhjZBrrhgqBbYovpx7
         LJq1Ml1P1vqyg==
Message-ID: <d186bb7d-cbe6-8ec4-82a1-8323b3901ac2@collabora.com>
Date:   Tue, 28 Jun 2022 14:44:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/3] thermal/drivers/tegra: Remove get_trend function
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
        Hardware Monitoring <linux-hwmon@vger.kernel.org>,
        rafael@kernel.org
References: <20220616202537.303655-1-daniel.lezcano@linaro.org>
 <20220616202537.303655-2-daniel.lezcano@linaro.org>
 <7841a809-e180-70d2-df9b-b30b411647ce@linaro.org>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <7841a809-e180-70d2-df9b-b30b411647ce@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/22 11:41, Daniel Lezcano wrote:
> 
> Thierry, Dmitry,
> 
> are fine with this patch?

Seems should be good. I couldn't test it using recent the linux-next
because of a lockup in LM90 driver. There were quite a lot of changes in
LM90 recently, adding Guenter.

INFO: task kworker/3:1:44 blocked for more than 61 seconds.
      Not tainted 5.19.0-rc4-next-20220627-00012-g08b697b94b8a #2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/3:1     state:D stack:    0 pid:   44 ppid:     2
flags:0x00000000
Workqueue: events_freezable_power_ thermal_zone_device_check
Backtrace:
 __schedule from schedule+0x60/0xcc
 r10:c0fead70 r9:c2854c94 r8:df9a1dac r7:c2814b40 r6:00000002 r5:c1883020
 r4:c2814b40
 schedule from schedule_preempt_disabled+0x28/0x38
 r5:c1883020 r4:c2814b40
 schedule_preempt_disabled from __mutex_lock.constprop.0+0x1e0/0x9ac
 r5:c1883020 r4:c2854c90
 __mutex_lock.constprop.0 from __mutex_lock_slowpath+0x1c/0x20
 r10:00000000 r9:c1882ae0 r8:c2854c90 r7:c2854c40 r6:00000001 r5:00000001
 r4:c2854c90
 __mutex_lock_slowpath from mutex_lock+0x60/0x64
 mutex_lock from lm90_read+0x40/0x3d4
 r5:00000001 r4:c2854e08
 lm90_read from hwmon_thermal_get_temp+0x58/0x8c
 r9:c1882ae0 r8:c2814b40 r7:de6aee00 r6:c1db1660 r5:c0af7940 r4:df9a1eb8
 hwmon_thermal_get_temp from of_thermal_get_temp+0x38/0x44
 r5:df9a1eb8 r4:c1db1400
 of_thermal_get_temp from thermal_zone_get_temp+0x58/0x78
 thermal_zone_get_temp from thermal_zone_device_update.part.0+0x4c/0x450
 r7:de6aee00 r6:c1db1400 r5:00000000 r4:c1db1400
 thermal_zone_device_update.part.0 from thermal_zone_device_check+0x58/0x5c
 r10:00000000 r9:c1882ae0 r8:c2814b40 r7:de6aee00 r6:c1db1400 r5:c1db1660
 r4:00000001
 thermal_zone_device_check from process_one_work+0x21c/0x530
 r7:de6aee00 r6:de6ab600 r5:c2802c00 r4:c1db167c
 process_one_work from worker_thread+0x19c/0x5cc
 r10:00000008 r9:c2814b40 r8:c1703d40 r7:de6ab61c r6:c2802c18 r5:de6ab600
 r4:c2802c00
 worker_thread from kthread+0x100/0x120
 r10:00000000 r9:df895e80 r8:c285e3c0 r7:c2802c00 r6:c014cf84 r5:c285e300
 r4:c2814b40
 kthread from ret_from_fork+0x14/0x2c
Exception stack(0xdf9a1fb0 to 0xdf9a1ff8)

> On 16/06/2022 22:25, Daniel Lezcano wrote:
>> The get_trend function does already what the generic framework does.
>>
>> Remove it.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   drivers/thermal/tegra/soctherm.c | 32 --------------------------------
>>   1 file changed, 32 deletions(-)
>>
>> diff --git a/drivers/thermal/tegra/soctherm.c
>> b/drivers/thermal/tegra/soctherm.c
>> index 210325f92559..825eab526619 100644
>> --- a/drivers/thermal/tegra/soctherm.c
>> +++ b/drivers/thermal/tegra/soctherm.c
>> @@ -633,37 +633,6 @@ static int tegra_thermctl_set_trip_temp(void
>> *data, int trip, int temp)
>>       return 0;
>>   }
>>   -static int tegra_thermctl_get_trend(void *data, int trip,
>> -                    enum thermal_trend *trend)
>> -{
>> -    struct tegra_thermctl_zone *zone = data;
>> -    struct thermal_zone_device *tz = zone->tz;
>> -    int trip_temp, temp, last_temp, ret;
>> -
>> -    if (!tz)
>> -        return -EINVAL;
>> -
>> -    ret = tz->ops->get_trip_temp(zone->tz, trip, &trip_temp);
>> -    if (ret)
>> -        return ret;
>> -
>> -    temp = READ_ONCE(tz->temperature);
>> -    last_temp = READ_ONCE(tz->last_temperature);
>> -
>> -    if (temp > trip_temp) {
>> -        if (temp >= last_temp)
>> -            *trend = THERMAL_TREND_RAISING;
>> -        else
>> -            *trend = THERMAL_TREND_STABLE;
>> -    } else if (temp < trip_temp) {
>> -        *trend = THERMAL_TREND_DROPPING;
>> -    } else {
>> -        *trend = THERMAL_TREND_STABLE;
>> -    }
>> -
>> -    return 0;
>> -}
>> -
>>   static void thermal_irq_enable(struct tegra_thermctl_zone *zn)
>>   {
>>       u32 r;
>> @@ -716,7 +685,6 @@ static int tegra_thermctl_set_trips(void *data,
>> int lo, int hi)
>>   static const struct thermal_zone_of_device_ops tegra_of_thermal_ops = {
>>       .get_temp = tegra_thermctl_get_temp,
>>       .set_trip_temp = tegra_thermctl_set_trip_temp,
>> -    .get_trend = tegra_thermctl_get_trend,
>>       .set_trips = tegra_thermctl_set_trips,
>>   };
>>   
> 
> 

