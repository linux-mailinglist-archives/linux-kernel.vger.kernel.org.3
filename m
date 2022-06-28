Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DB055E77F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347122AbiF1PKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 11:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345950AbiF1PKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 11:10:34 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4771D95A8;
        Tue, 28 Jun 2022 08:10:33 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id w24so12860046pjg.5;
        Tue, 28 Jun 2022 08:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PQdhoN5Y92Sffq/hOjS2nUMXws/DtAotkv6AY0an4t4=;
        b=V6dMZ0z58UrUfatSTJEe0X1KX+7nyCpO3U8PTqJXLtBpT+teARJDVA4MzcJXAP6MD1
         lOrpaAuItF/+ir7d8LcC3UJD8ygiU1cw2pN+3yDEVyLr1PN2AC5G5GP4Subgk/2NUkBk
         P42NOacoYZhr2TH2WQAfNIi4PaV4y6x2zBnLP8xu/FYzvRHfvewW6xfZ0rtR9fvzyN5C
         NmjMdYbx8nvkvaIBhypP3fJmeBRH8sXNDWP79HnCnXJZci6ul5xAaG9+AA0GCupRMIqM
         5aaiAZPmbL8pa8aFf0xn17XhjCHkdkBfjnqkG742tKGwus7GPiZAXoFaVSpPPSwqau69
         D3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=PQdhoN5Y92Sffq/hOjS2nUMXws/DtAotkv6AY0an4t4=;
        b=RjUMVHKoPODeep3YLr8AgiOsEKgapRLBMp1Urq9BanTb3HNiFqSfGmvNMI5KXiYz90
         3af2fz/7p+CTfipWQcYcWlCSkToVU43GMndNFGlDC9ycLH86YtO+mk2TkPOfXzkPC811
         Vc4YI+OxdxJf91DJjjlJ9JCeCUh8UfGzRzCR17KsE8DeP+GoA4HbsluomeSjOQdx7lGi
         wgBYU1el6BVe8LkQ1lI8fxkw0Pkh2Y+aBa2faZrOo3wmxiAKwEs9Y4iBJosxCDWTER2B
         byYTIA5p63Hwo+MaN+bL5PtlYsvWx8wZvZ8ClGVIgfUCUlyTO/uwb1DmvXm+ssN0/9yI
         3p6Q==
X-Gm-Message-State: AJIora+65/Z0+a15CuXRl7d9FTGfCfEgHtfJRokaMaNEdoDGwMgN6K4z
        unTxHKk4xQM2+ZOV4MwYlag=
X-Google-Smtp-Source: AGRyM1tsPj/V6CDv94LXNl91i1dCBmE8JH99oIjI9o2Cw/MrR03bgs+VohPLlMK2LhEtjyDRhNt8+Q==
X-Received: by 2002:a17:902:ec06:b0:16a:1877:425 with SMTP id l6-20020a170902ec0600b0016a18770425mr4057838pld.131.1656429032710;
        Tue, 28 Jun 2022 08:10:32 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n24-20020a056a000d5800b00517c84fd24asm9972175pfv.172.2022.06.28.08.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 08:10:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 28 Jun 2022 08:10:30 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
        Hardware Monitoring <linux-hwmon@vger.kernel.org>,
        rafael@kernel.org
Subject: Re: [PATCH 2/3] thermal/drivers/tegra: Remove get_trend function
Message-ID: <20220628151030.GA3361452@roeck-us.net>
References: <20220616202537.303655-1-daniel.lezcano@linaro.org>
 <20220616202537.303655-2-daniel.lezcano@linaro.org>
 <7841a809-e180-70d2-df9b-b30b411647ce@linaro.org>
 <d186bb7d-cbe6-8ec4-82a1-8323b3901ac2@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d186bb7d-cbe6-8ec4-82a1-8323b3901ac2@collabora.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 02:44:31PM +0300, Dmitry Osipenko wrote:
> On 6/28/22 11:41, Daniel Lezcano wrote:
> > 
> > Thierry, Dmitry,
> > 
> > are fine with this patch?
> 
> Seems should be good. I couldn't test it using recent the linux-next
> because of a lockup in LM90 driver. There were quite a lot of changes in
> LM90 recently, adding Guenter.
> 

Weird, I tested those changes to death with real hardware, and I don't
see a code path where the mutex can be left in blocked state unless the
underlying i2c driver locks up for some reason. What is the platform,
and can you point me to the devicetree file ? Also, is there anything
else lm90 or i2c related in the kernel log ?

Thanks,
Guenter

> INFO: task kworker/3:1:44 blocked for more than 61 seconds.
>       Not tainted 5.19.0-rc4-next-20220627-00012-g08b697b94b8a #2
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/3:1     state:D stack:    0 pid:   44 ppid:     2
> flags:0x00000000
> Workqueue: events_freezable_power_ thermal_zone_device_check
> Backtrace:
>  __schedule from schedule+0x60/0xcc
>  r10:c0fead70 r9:c2854c94 r8:df9a1dac r7:c2814b40 r6:00000002 r5:c1883020
>  r4:c2814b40
>  schedule from schedule_preempt_disabled+0x28/0x38
>  r5:c1883020 r4:c2814b40
>  schedule_preempt_disabled from __mutex_lock.constprop.0+0x1e0/0x9ac
>  r5:c1883020 r4:c2854c90
>  __mutex_lock.constprop.0 from __mutex_lock_slowpath+0x1c/0x20
>  r10:00000000 r9:c1882ae0 r8:c2854c90 r7:c2854c40 r6:00000001 r5:00000001
>  r4:c2854c90
>  __mutex_lock_slowpath from mutex_lock+0x60/0x64
>  mutex_lock from lm90_read+0x40/0x3d4
>  r5:00000001 r4:c2854e08
>  lm90_read from hwmon_thermal_get_temp+0x58/0x8c
>  r9:c1882ae0 r8:c2814b40 r7:de6aee00 r6:c1db1660 r5:c0af7940 r4:df9a1eb8
>  hwmon_thermal_get_temp from of_thermal_get_temp+0x38/0x44
>  r5:df9a1eb8 r4:c1db1400
>  of_thermal_get_temp from thermal_zone_get_temp+0x58/0x78
>  thermal_zone_get_temp from thermal_zone_device_update.part.0+0x4c/0x450
>  r7:de6aee00 r6:c1db1400 r5:00000000 r4:c1db1400
>  thermal_zone_device_update.part.0 from thermal_zone_device_check+0x58/0x5c
>  r10:00000000 r9:c1882ae0 r8:c2814b40 r7:de6aee00 r6:c1db1400 r5:c1db1660
>  r4:00000001
>  thermal_zone_device_check from process_one_work+0x21c/0x530
>  r7:de6aee00 r6:de6ab600 r5:c2802c00 r4:c1db167c
>  process_one_work from worker_thread+0x19c/0x5cc
>  r10:00000008 r9:c2814b40 r8:c1703d40 r7:de6ab61c r6:c2802c18 r5:de6ab600
>  r4:c2802c00
>  worker_thread from kthread+0x100/0x120
>  r10:00000000 r9:df895e80 r8:c285e3c0 r7:c2802c00 r6:c014cf84 r5:c285e300
>  r4:c2814b40
>  kthread from ret_from_fork+0x14/0x2c
> Exception stack(0xdf9a1fb0 to 0xdf9a1ff8)
> 
> > On 16/06/2022 22:25, Daniel Lezcano wrote:
> >> The get_trend function does already what the generic framework does.
> >>
> >> Remove it.
> >>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> ---
> >>   drivers/thermal/tegra/soctherm.c | 32 --------------------------------
> >>   1 file changed, 32 deletions(-)
> >>
> >> diff --git a/drivers/thermal/tegra/soctherm.c
> >> b/drivers/thermal/tegra/soctherm.c
> >> index 210325f92559..825eab526619 100644
> >> --- a/drivers/thermal/tegra/soctherm.c
> >> +++ b/drivers/thermal/tegra/soctherm.c
> >> @@ -633,37 +633,6 @@ static int tegra_thermctl_set_trip_temp(void
> >> *data, int trip, int temp)
> >>       return 0;
> >>   }
> >>   -static int tegra_thermctl_get_trend(void *data, int trip,
> >> -                    enum thermal_trend *trend)
> >> -{
> >> -    struct tegra_thermctl_zone *zone = data;
> >> -    struct thermal_zone_device *tz = zone->tz;
> >> -    int trip_temp, temp, last_temp, ret;
> >> -
> >> -    if (!tz)
> >> -        return -EINVAL;
> >> -
> >> -    ret = tz->ops->get_trip_temp(zone->tz, trip, &trip_temp);
> >> -    if (ret)
> >> -        return ret;
> >> -
> >> -    temp = READ_ONCE(tz->temperature);
> >> -    last_temp = READ_ONCE(tz->last_temperature);
> >> -
> >> -    if (temp > trip_temp) {
> >> -        if (temp >= last_temp)
> >> -            *trend = THERMAL_TREND_RAISING;
> >> -        else
> >> -            *trend = THERMAL_TREND_STABLE;
> >> -    } else if (temp < trip_temp) {
> >> -        *trend = THERMAL_TREND_DROPPING;
> >> -    } else {
> >> -        *trend = THERMAL_TREND_STABLE;
> >> -    }
> >> -
> >> -    return 0;
> >> -}
> >> -
> >>   static void thermal_irq_enable(struct tegra_thermctl_zone *zn)
> >>   {
> >>       u32 r;
> >> @@ -716,7 +685,6 @@ static int tegra_thermctl_set_trips(void *data,
> >> int lo, int hi)
> >>   static const struct thermal_zone_of_device_ops tegra_of_thermal_ops = {
> >>       .get_temp = tegra_thermctl_get_temp,
> >>       .set_trip_temp = tegra_thermctl_set_trip_temp,
> >> -    .get_trend = tegra_thermctl_get_trend,
> >>       .set_trips = tegra_thermctl_set_trips,
> >>   };
> >>   
> > 
> > 
> 
