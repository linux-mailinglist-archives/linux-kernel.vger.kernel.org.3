Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DD057541D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 19:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238921AbiGNRfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 13:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbiGNRfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 13:35:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16FD45F10C;
        Thu, 14 Jul 2022 10:35:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27AFF1D13;
        Thu, 14 Jul 2022 10:35:42 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA56E3F70D;
        Thu, 14 Jul 2022 10:35:40 -0700 (PDT)
Message-ID: <5ca9bd94-54d9-04f8-0098-a56ffb6f5fe1@arm.com>
Date:   Thu, 14 Jul 2022 18:35:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] arm64: dts: rockchip: Fix SD card init on
 rk3399-nanopi4
Content-Language: en-GB
To:     wens@kernel.org,
        =?UTF-8?Q?Christian_Kohlsch=c3=bctter?= 
        <christian@kohlschutter.com>
Cc:     Markus Reichl <m.reichl@fivetechno.de>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
References: <C639AD88-77A1-4485-BAEA-2FF8FC15A844@kohlschutter.com>
 <12878108.O9o76ZdvQC@diego> <103b714c-b07c-f016-1062-84bd94786b22@arm.com>
 <9AF1E75F-5947-49B0-887D-82C426527B99@kohlschutter.com>
 <590f7a08-a6ca-be54-4254-363343642a52@arm.com>
 <A6B896E5-CD25-4441-B6A5-0BE1FA284B2C@kohlschutter.com>
 <A9634366-A012-43D2-B253-8BB9BF6005C7@kohlschutter.com>
 <CAGb2v65Ehbu1wrib2CzF1fDZuD3fHZQDhKfVusyUF9KnxTvi+Q@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CAGb2v65Ehbu1wrib2CzF1fDZuD3fHZQDhKfVusyUF9KnxTvi+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2022 6:02 pm, Chen-Yu Tsai wrote:
> On Fri, Jul 15, 2022 at 12:27 AM Christian Kohlschütter
> <christian@kohlschutter.com> wrote:
>>
>> mmc/SD-card initialization may fail on NanoPi r4s with
>> "mmc1: problem reading SD Status register" /
>> "mmc1: error -110 whilst initialising SD card"
>>
>> Moreover, rebooting would also sometimes hang.
>>
>> This is caused by the gpio entry for the vcc3v0-sd regulator;
>> even though it appears to be the correct GPIO pin, the presence
>> of the binding causes these errors.
>>
>> Fix the regulator to drop the gpio binding and add a comment
>> to prevent accidental reintroduction of that entry.
>>
>> Signed-off-by: Christian Kohlschütter <christian@kohlschutter.com>
>> ---
>>   arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
>> index 8c0ff6c96e03..d5f8a62e01be 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
>> @@ -67,7 +67,7 @@ vcc1v8_s3: vcc1v8-s3 {
>>          vcc3v0_sd: vcc3v0-sd {
>>                  compatible = "regulator-fixed";
>>                  enable-active-high;
>> -               gpio = <&gpio0 RK_PA1 GPIO_ACTIVE_HIGH>;
>> +               // gpio = <&gpio0 RK_PA1 GPIO_ACTIVE_HIGH>; // breaks SDHC card support
> 
> This change only means that the regulator no longer gets cycled when
> it probes. It's not a proper fix. You're leaving the kernel without
> any control over SD card power, and with whatever state the bootloader
> left the GPIO in. If the bootloader left the GPIO low, then you don't
> get to use the SD card, ever.
> 
> It cycles because of the lack of regulator-boot-on, so the driver
> requests the GPIO with initial low state, and then drives it
> high to enable the regulator.

Hmm, that's a good point - by the time we get to Linux, we should have 
control over the VCC_SDIO regulator and the I/O domain as well, so a 
full clean reset should really be no problem :/

The "Tinkerboard problem" I was thinking of is when the SD card is the 
boot medium, VCC_SDIO stays at 1.8V over a reboot but the I/O domain 
gets reset back to 3.3V mode, thus cannot see a logic high on any of the 
I/O lines, thus the boot ROM gives up after failing to detect the card. 
If we're still able to boot as far as Linux, it's probably a different 
thing. Apologies for the confusion.

>>                  pinctrl-names = "default";
>>                  pinctrl-0 = <&sdmmc0_pwr_h>;
>>                  regulator-always-on;
> 
> I think dropping "regulator-always-on" so that Linux can cycle power
> and properly reset the SD card is the proper fix to the card being
> stuck in UHS and not responding.
> 
> Also, the regulator used is RT9193, according to the schematics. That
> chip has an enable delay under 50 micro-seconds. If that needs to be
> modeled, then add regulator-enable-ramp-delay.

Indeed, if it's a slow regulator and we're simply trying to probe the 
card too soon before its supply voltage has actually stabilised, that 
sounds entirely plausible, particularly if the failure is only intermittent.

Thanks,
Robin.
