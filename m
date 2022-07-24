Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C9457F7B1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 01:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbiGXX2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 19:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiGXX2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 19:28:32 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A37DF36
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 16:28:30 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id p21so3647903ljh.12
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 16:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1eu5YjbpGJQ9ulEiNLSYfLw+X2MYg9M8E1wl1Tk8HG4=;
        b=U8fdS/QOg+atlTmhhaKSMykrsbFn1qLU6FrKhFfyxupMGeOFvUroqwF5ujdscN7JYq
         8lisR8MUrEKgCyWL+UpuZ7UErCTmKF/ArVb55Yj1DvZH7rg4r1BrD/7nxszwCt84loPu
         /zwNu9Ta9Xga/cyh11c8fv5bBAy+OK0cnK84ojBfPQN5CnVmmUsP9DkpxteXdn0puFB7
         rfr8PAXGJFjQbM8RV/Th5u8+5fgERyGSNy5clP6p2r/wYtGRkdSkiSeNLszcQxShfuET
         ArKqo/e1zP9CJ1NN5NDRdlWYNguVFt1WHea+CQPMUwpApeXC4XfJBRiZlpEFicekhRG7
         8prQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1eu5YjbpGJQ9ulEiNLSYfLw+X2MYg9M8E1wl1Tk8HG4=;
        b=fPjKc4oRSeBsR9dg/z+BHabAVbuUwl5HBwuk/e44JoFxHq7WahMj9KWxJVUf1sMmat
         6epVS9NqARzZr3Ea7mCuVwIRSEVJ3WgFJVQCOCOT2FeEjW8dPEUgYgWjIR/4nnHMvLjO
         0WcmHq7TjlHeKKuFovQtQSB4gF8k/zT73uBmlw/siavqvUMIUXQ6znB/UGRmwky49RHm
         3m1p1weCulikmqGrGb72vc226buNEKbjDVT/TksgKzEZJ6N3wtzAqMeTP0eM102ck0Sq
         9lVK4J1DcNjjTkNKclRShZCbhPt615U+kyRNiZ97C7C0Ybt48zClG3IaJhBCEvkU4h7s
         3low==
X-Gm-Message-State: AJIora80mLvqf62IS6O5NiNgl1Azs++eYSlY6QSKmJIwBVU9bbs8wOWt
        +9exXiv4NYkFdSDl+TzDWc84Cw==
X-Google-Smtp-Source: AGRyM1v+SJhtbeF+JBiDSw/8YTQEAP5o3ZstTXafAMA3VbXngiXScwHb3IwV6uahVurZsJrXyJGWsA==
X-Received: by 2002:a2e:9cd1:0:b0:25d:f617:f531 with SMTP id g17-20020a2e9cd1000000b0025df617f531mr3046937ljj.380.1658705308513;
        Sun, 24 Jul 2022 16:28:28 -0700 (PDT)
Received: from localhost (h-46-59-88-103.A463.priv.bahnhof.se. [46.59.88.103])
        by smtp.gmail.com with ESMTPSA id s7-20020a056512202700b0048a7c86f4e7sm1362162lfs.291.2022.07.24.16.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 16:28:28 -0700 (PDT)
Date:   Mon, 25 Jul 2022 01:28:26 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Daniel Lezcano <daniel.lezcano@linexp.org>
Cc:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com,
        khilman@baylibre.com, abailon@baylibre.com, amitk@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "open list:RENESAS R-CAR THERMAL DRIVERS" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v1 17/33] thermal/drivers/rcar: Switch to new of API
Message-ID: <Yt3Vmt/AAzqzDzBF@oden.dyn.berto.se>
References: <20220710212423.681301-1-daniel.lezcano@linexp.org>
 <20220710212423.681301-18-daniel.lezcano@linexp.org>
 <YtZ1IExNlsYaJkC9@oden.dyn.berto.se>
 <18ade2d0-ebda-0526-71f3-65a0b2685068@linexp.org>
 <Yt2W5UCXaB3Memzg@oden.dyn.berto.se>
 <e2a56ac3-057c-2b17-7bde-7e860a86807d@linexp.org>
 <Yt3KDSO248WebZ/w@oden.dyn.berto.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yt3KDSO248WebZ/w@oden.dyn.berto.se>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi (again) Daniel,

I figured it out, the thermal zone is disabled after this change. For 
both rcar sensors with the new API thermal_zone_device_enable() is never 
called.

In the old API the zone is enabled in the call chain of 
devm_thermal_zone_of_sensor_register(). While after this change the zone 
is not enabled by the core when calling thermal_zone_device_enable().

If I add a call to thermal_zone_device_enable() together with the new 
API everything works as before. But I'm not sure if the correct solution 
is to add a call to thermal_zone_device_enable() in the sensor drivers 
or in the call chain of the new API?

On 2022-07-25 00:39:10 +0200, Niklas Söderlund wrote:
> Hi Daniel,
> 
> I tested your branch, unfortunately with the same result for 
> rcar_gen3_thermal. Manipulation of emul_temp file do not trigger 
> actions.
> 
> If I on-top of your branch revert:
> 
>     409ca214f4c6bd5b ("thermal/of: Remove old OF code")
>     7b43f76d3428227e ("thermal/drivers/rcar: Switch to new of API")
> 
> I'm able to 'restore' the behavior where I can change the cooling state 
> and trigger the critical trip point using emul_temp to shutdown the 
> board.
> 
> As the change in question also effects the rcar_thermal sensor I gave 
> that a try too. It have no cooling on this system I have so my only 
> test-case is to write a temperature above the critical trip point to 
> emul_temp as see if that shutdown the system.  And just as with 
> rcar_gen3_thermal with your series nothing happens while with the two 
> commits outline above reverted the system shuts down.
> 
>     echo 110000 > /sys/devices/virtual/thermal/thermal_zone0/emul_temp
> 
> If it's any help writing to emul_temp have some effect as the emulated 
> temperature is read back from the temp sysfs while. For rcar_thermal 
> where the critical trip point is 95 degrees,
> 
>     * With this series
>     # grep . /sys/devices/virtual/thermal/thermal_zone0/trip_point_0_*
>     /sys/devices/virtual/thermal/thermal_zone0/trip_point_0_hyst:0
>     /sys/devices/virtual/thermal/thermal_zone0/trip_point_0_temp:95000
>     /sys/devices/virtual/thermal/thermal_zone0/trip_point_0_type:critical
>     # cat /sys/devices/virtual/thermal/thermal_zone0/temp
>     35000
>     # echo 50000 > /sys/devices/virtual/thermal/thermal_zone0/emul_temp
>     # cat /sys/devices/virtual/thermal/thermal_zone0/temp
>     50000
>     # echo 110000 > /sys/devices/virtual/thermal/thermal_zone0/emul_temp
>     # cat /sys/devices/virtual/thermal/thermal_zone0/temp
>     110000
>     *** system alive ***
> 
>     * With this series and the two patches reverted or plain v5.19-rc4
>     # grep .  /sys/devices/virtual/thermal/thermal_zone0/trip_point_0_* 
>     /sys/devices/virtual/thermal/thermal_zone0/trip_point_0_hyst:0
>     /sys/devices/virtual/thermal/thermal_zone0/trip_point_0_temp:95000
>     /sys/devices/virtual/thermal/thermal_zone0/trip_point_0_type:critical
>     # cat /sys/devices/virtual/thermal/thermal_zone0/temp
>     35000
>     # echo 50000 > /sys/devices/virtual/thermal/thermal_zone0/emul_temp
>     # cat /sys/devices/virtual/thermal/thermal_zone0/temp
>     50000
>     # echo 110000 > /sys/devices/virtual/thermal/thermal_zone0/emul_temp
>     [  121.380054] thermal thermal_zone0: cpu-thermal: critical temperature reached, shutting down
>     [  121.388482] reboot: HARDWARE PROTECTION shutdown (Temperature too high)
>     *** system shuts down ***
> 
> And to make it more problematic I don't think the lack of action is 
> limited to the emul_temp interface. With rcar_thermal I lowered the 
> critical trip point value to 45C and used the cpuburn application to 
> generate load and raise the temperature.
> 
> The result mirrors the findings above, with your branch the system do 
> not trigger the critical trip point. If I revert the two commits or run 
> plain v5.19-rc4, once the temperature reaches 45C the critical trip 
> point kicks in and shuts down the system.
> 
> I hope this helps, I'm sorry I can't find the real issue diging in the 
> core changes. I'm happy to help trying to find the root cause for this 
> and I think the idea behind the new API is good.
> 
> On 2022-07-24 23:11:47 +0200, Daniel Lezcano wrote:
> > 
> > Hi Niklas,
> > 
> > I give another try but failed to reproduce the issue. Perhaps my board has a
> > path different from yours.
> > 
> > Thanks for proposing to test the series. I've uploaded the branch here:
> > 
> > https://github.com/dlezcano/linux-thermal
> > 
> > 
> > On 24/07/2022 21:00, Niklas Söderlund wrote:
> > > Hi Daniel,
> > > 
> > > On 2022-07-24 20:27:54 +0200, Daniel Lezcano wrote:
> > > > Hi Niklas,
> > > > 
> > > > I tried to reproduce the issue but without success.
> > > > 
> > > > What sensor are you using ?
> > > I was using rcar_gen3_thermal.
> > > 
> > > I did my tests starting on v5.19-rc7 and then picked '[PATCH v5 00/12]
> > > thermal OF rework' from [1] and finally applied this full series on-top
> > > of that. If you have a branch or some specific test you wish me to try
> > > I'm happy to so.
> > > 
> > > 1. https://lore.kernel.org/lkml/20220710123512.1714714-1-daniel.lezcano@linexp.org/
> > > 
> > > > 
> > > > On 19/07/2022 11:10, Niklas Söderlund wrote:
> > > > > Hi Daniel,
> > > > > 
> > > > > Thanks for your work.
> > > > > 
> > > > > On 2022-07-10 23:24:07 +0200, Daniel Lezcano wrote:
> > > > > > The thermal OF code has a new API allowing to migrate the OF
> > > > > > initialization to a simpler approach.
> > > > > > 
> > > > > > Use this new API.
> > > > > I tested this together with the series it depends on and while
> > > > > temperature monitoring seems to work fine it breaks the emul_temp
> > > > > interface (/sys/class/thermal/thermal_zone2/emul_temp).
> > > > > 
> > > > > Before this change I can write a temperature to this file and have it
> > > > > trigger actions, in my test-case changing the cooling state, which I
> > > > > observe in /sys/class/thermal/cooling_device0/cur_state.
> > > > > 
> > > > > Likewise before this change I could trip the critical trip-point that
> > > > > would power off the board using the emul_temp interface, this too no
> > > > > longer works,
> > > > > 
> > > > >       echo 120000 > /sys/class/thermal/thermal_zone2/emul_temp
> > > > > 
> > > > > Is this an intention change of the new API?
> > > > 
> > > > 
> > > > 
> > 
> 
> -- 
> Kind Regards,
> Niklas Söderlund

-- 
Kind Regards,
Niklas Söderlund
