Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D28574C59
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239035AbiGNLlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiGNLlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:41:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA4BE5B075
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 04:41:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0E2613D5;
        Thu, 14 Jul 2022 04:41:10 -0700 (PDT)
Received: from [10.57.86.49] (unknown [10.57.86.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 685453F792;
        Thu, 14 Jul 2022 04:41:09 -0700 (PDT)
Message-ID: <103b714c-b07c-f016-1062-84bd94786b22@arm.com>
Date:   Thu, 14 Jul 2022 12:41:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] arm64: dts: rockchip: Fix SD card init on rk3399-nanopi4
Content-Language: en-GB
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Christian_Kohlsch=c3=bctter?= 
        <christian@kohlschutter.com>
References: <C639AD88-77A1-4485-BAEA-2FF8FC15A844@kohlschutter.com>
 <12878108.O9o76ZdvQC@diego>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <12878108.O9o76ZdvQC@diego>
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

On 2022-07-14 00:41, Heiko Stübner wrote:
> Hi Christian,
> 
> Am Donnerstag, 14. Juli 2022, 00:22:23 CEST schrieb Christian Kohlschütter:
>> mmc/SD-card initialization may sometimes fail on NanoPi r4s with
>> "mmc1: problem reading SD Status register" /
>> "mmc1: error -110 whilst initialising SD card"
>>
>> Moreover, rebooting would also sometimes hang.
>>
> 
> Nit: here the commit message should continue with something like:
> -----
> This is caused by the vcc3v0-sd regulator referencing the wrong gpio.
> 
> Fix the regulator to use the correct pin and drop the always-on property.
> -----
>> Signed-off-by: Christian Kohlschütter <christian@kohlschutter.com>
>> ---
>>   arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
>> index 8c0ff6c96e03..91789801ab03 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
>> @@ -67,10 +67,10 @@ vcc1v8_s3: vcc1v8-s3 {
>>   	vcc3v0_sd: vcc3v0-sd {
>>   		compatible = "regulator-fixed";
>>   		enable-active-high;
>> -		gpio = <&gpio0 RK_PA1 GPIO_ACTIVE_HIGH>;
>> +		gpio = <&gpio0 RK_PD6 GPIO_ACTIVE_HIGH>;
> 
> The interesting question would be how nano-pi-specific that gpio is.
> 
> I.e. this is the rk3399-nanopi4.dtsi that is shared by multiple board types,
> so can you check in schematics if gpio0-d6 is always used on all of them?

On the R4S schematic, this is GPIO0_A1 same as the others. GPIO0 doesn't 
even have a bank D on RK3399, it only goes up to B5 :/

> 
> Thanks
> Heiko
> 
>>   		pinctrl-names = "default";
>>   		pinctrl-0 = <&sdmmc0_pwr_h>;
>> -		regulator-always-on;
>> +		regulator-boot-on;
>>   		regulator-min-microvolt = <3000000>;
>>   		regulator-max-microvolt = <3000000>;
>>   		regulator-name = "vcc3v0_sd";
>> @@ -580,7 +580,7 @@ wifi_reg_on_h: wifi-reg_on-h {
>>   
>>   	sdmmc {
>>   		sdmmc0_det_l: sdmmc0-det-l {
>> -			rockchip,pins = <0 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up>;
>> +			rockchip,pins = <0 RK_PD6 RK_FUNC_GPIO &pcfg_pull_up>;

...and claiming the card detect is on the same non-existent pin as the 
regulator enable is clearly even more wrong.

Is this another case where a UHS card is involved, such that VCC_SDIO 
gets left at 1.8V after a reboot, so subsequent attempts to do the 
initial handshake where the card is expecting 3V logic levels fail? (AKA 
the Tinkerboard problem). Hobbling the regulator such that Linux can 
never actually turn VCC3V0_SD off, thus the card never gets reset, might 
appear to "work", but isn't the right thing to do.

Robin.

>>   		};
>>   
>>   		sdmmc0_pwr_h: sdmmc0-pwr-h {
>>
> 
> 
> 
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
