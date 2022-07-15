Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA34576690
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 20:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiGOSLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 14:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiGOSLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 14:11:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BAE53564EE;
        Fri, 15 Jul 2022 11:11:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FDA212FC;
        Fri, 15 Jul 2022 11:11:45 -0700 (PDT)
Received: from [10.57.86.139] (unknown [10.57.86.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E769E3F792;
        Fri, 15 Jul 2022 11:11:43 -0700 (PDT)
Message-ID: <17a4c6f6-d79c-a7b2-860f-e5944b778f9f@arm.com>
Date:   Fri, 15 Jul 2022 19:11:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4] arm64: dts: rockchip: Fix SD card init on
 rk3399-nanopi4
Content-Language: en-GB
To:     =?UTF-8?Q?Christian_Kohlsch=c3=bctter?= 
        <christian@kohlschutter.com>, wens@kernel.org,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Markus Reichl <m.reichl@fivetechno.de>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
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
 <5ca9bd94-54d9-04f8-0098-a56ffb6f5fe1@arm.com>
 <502b3fbe-3077-407e-6010-a8cb3ffce7d6@arm.com>
 <449292CA-CE60-4B90-90F7-295FBFEAB3F8@kohlschutter.com>
 <73F9AED0-D2A8-4294-B6E1-1B92D2A36529@kohlschutter.com>
 <115AD6A4-021B-4879-BFB5-BC7689A0203E@kohlschutter.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <115AD6A4-021B-4879-BFB5-BC7689A0203E@kohlschutter.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-15 18:16, Christian Kohlschütter wrote:
> OK, this took me a while to figure out.
> 
> When no undervoltage limit is configured, I can reliably trigger the initialization bug upon boot.
> When the limit is set to 3.0V, it rarely occurs, but just after I send the v3 patch, I was able to reproduce...

Well this has to be in the running for "weirdest placebo ever"... :/

All it actually seems to achieve is printing an error[1] (this is after 
all a tiny 5-pin fixed-voltage LDO regulator, not an intelligent PMIC), 
and if that makes an appreciable difference then there has to be some 
kind of weird timing condition at play. Maybe regulator_register() ends 
up turning it off and on again rapidly enough that the card sees a 
voltage brownout and glitches, and adding more delay by printing to the 
console somewhere in the middle gives it enough time to act as a proper 
power cycle with no ill effect?

If you just whack something like an mdelay(500) at around that point in 
set_machine_constraints(), without the DT property, does it have the 
same effect?

Robin.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/regulator/core.c#n1521

>> Am 15.07.2022 um 19:12 schrieb Christian Kohlschütter <christian@kohlschutter.com>:
>>
>> mmc/SD-card initialization may fail on NanoPi R4S with
>> "mmc1: problem reading SD Status register" /
>> "mmc1: error -110 whilst initialising SD card"
>> either on cold boot or after a reboot.
>>
>> Moreover, the system would also sometimes hang upon reboot.
>>
>> This is prevented by setting an explicit undervoltage protection limit
>> for the SD-card-specific vcc3v0_sd voltage regulator.
>>
>> Set the undervoltage protection limit to 2.7V, which is the minimum
>> permissible SD card operating voltage.
>>
>> Signed-off-by: Christian Kohlschütter <christian@kohlschutter.com>
>> ---
>> arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi | 4 ++++
>> 1 file changed, 4 insertions(+)
>> mode change 100644 => 100755 arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
>> old mode 100644
>> new mode 100755
>> index 8c0ff6c96e03..669c74ce4d13
>> --- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
>> @@ -73,6 +73,10 @@ vcc3v0_sd: vcc3v0-sd {
>> 		regulator-always-on;
>> 		regulator-min-microvolt = <3000000>;
>> 		regulator-max-microvolt = <3000000>;
>> +
>> +		// must be configured or SD card may fail to initialize occasionally
>> +		regulator-uv-protection-microvolt = <2700000>;
>> +
>> 		regulator-name = "vcc3v0_sd";
>> 		vin-supply = <&vcc3v3_sys>;
>> 	};
>> -- 
>> 2.36.1
> 
