Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC703574EC5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239703AbiGNNOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239687AbiGNNOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:14:46 -0400
Received: from wp126.webpack.hosteurope.de (wp126.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8485::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0993946D9C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:14:44 -0700 (PDT)
Received: from p5098d998.dip0.t-ipconnect.de ([80.152.217.152] helo=hermes.fivetechno.de); authenticated
        by wp126.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1oByfy-0001bF-4V; Thu, 14 Jul 2022 15:14:42 +0200
X-Virus-Scanned: by amavisd-new 2.12.2 using newest ClamAV at
        linuxbbg.five-lan.de
Received: from [192.168.34.101] (p5098d998.dip0.t-ipconnect.de [80.152.217.152])
        (authenticated bits=0)
        by hermes.fivetechno.de (8.15.2/8.16.1/SUSE Linux 0.8) with ESMTPSA id 26EDEd4W012445
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Thu, 14 Jul 2022 15:14:40 +0200
Message-ID: <3b808af9-5bbc-0b58-860e-dbb8ac1e3be9@fivetechno.de>
Date:   Thu, 14 Jul 2022 15:14:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] arm64: dts: rockchip: Fix SD card init on rk3399-nanopi4
Content-Language: de-DE
To:     =?UTF-8?Q?Christian_Kohlsch=c3=bctter?= 
        <christian@kohlschutter.com>, Robin Murphy <robin.murphy@arm.com>
Cc:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <C639AD88-77A1-4485-BAEA-2FF8FC15A844@kohlschutter.com>
 <12878108.O9o76ZdvQC@diego> <103b714c-b07c-f016-1062-84bd94786b22@arm.com>
 <9AF1E75F-5947-49B0-887D-82C426527B99@kohlschutter.com>
From:   Markus Reichl <m.reichl@fivetechno.de>
Organization: five technologies GmbH
In-Reply-To: <9AF1E75F-5947-49B0-887D-82C426527B99@kohlschutter.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;m.reichl@fivetechno.de;1657804484;885ebedc;
X-HE-SMSGID: 1oByfy-0001bF-4V
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,Am 14.07.22 um 14:14 schrieb Christian Kohlschütter:
>> Am 14.07.2022 um 13:41 schrieb Robin Murphy <robin.murphy@arm.com>:
>> 
>> On 2022-07-14 00:41, Heiko Stübner wrote:
>>> Hi Christian,
>>> Am Donnerstag, 14. Juli 2022, 00:22:23 CEST schrieb Christian Kohlschütter:
>>>> mmc/SD-card initialization may sometimes fail on NanoPi r4s with
>>>> "mmc1: problem reading SD Status register" /
>>>> "mmc1: error -110 whilst initialising SD card"
>>>> 
>>>> Moreover, rebooting would also sometimes hang.
>>>> 
>>> Nit: here the commit message should continue with something like:
>>> -----
>>> This is caused by the vcc3v0-sd regulator referencing the wrong gpio.
>>> Fix the regulator to use the correct pin and drop the always-on property.
>>> -----
>>>> Signed-off-by: Christian Kohlschütter <christian@kohlschutter.com>
>>>> ---
>>>>  arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi | 6 +++---
>>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>> 
>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
>>>> index 8c0ff6c96e03..91789801ab03 100644
>>>> --- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
>>>> @@ -67,10 +67,10 @@ vcc1v8_s3: vcc1v8-s3 {
>>>>  	vcc3v0_sd: vcc3v0-sd {
>>>>  		compatible = "regulator-fixed";
>>>>  		enable-active-high;
>>>> -		gpio = <&gpio0 RK_PA1 GPIO_ACTIVE_HIGH>;
>>>> +		gpio = <&gpio0 RK_PD6 GPIO_ACTIVE_HIGH>;
>>> The interesting question would be how nano-pi-specific that gpio is.
>>> I.e. this is the rk3399-nanopi4.dtsi that is shared by multiple board types,
>>> so can you check in schematics if gpio0-d6 is always used on all of them?
>> 
>> On the R4S schematic, this is GPIO0_A1 same as the others. GPIO0 doesn't even have a bank D on RK3399, it only goes up to B5 :/
>> 
>>> Thanks
>>> Heiko
>>>>  		pinctrl-names = "default";
>>>>  		pinctrl-0 = <&sdmmc0_pwr_h>;
>>>> -		regulator-always-on;
>>>> +		regulator-boot-on;
>>>>  		regulator-min-microvolt = <3000000>;
>>>>  		regulator-max-microvolt = <3000000>;
>>>>  		regulator-name = "vcc3v0_sd";
>>>> @@ -580,7 +580,7 @@ wifi_reg_on_h: wifi-reg_on-h {
>>>>    	sdmmc {
>>>>  		sdmmc0_det_l: sdmmc0-det-l {
>>>> -			rockchip,pins = <0 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up>;
>>>> +			rockchip,pins = <0 RK_PD6 RK_FUNC_GPIO &pcfg_pull_up>;
>> 
>> ...and claiming the card detect is on the same non-existent pin as the regulator enable is clearly even more wrong.
>> 
>> Is this another case where a UHS card is involved, such that VCC_SDIO gets left at 1.8V after a reboot, so subsequent attempts to do the initial handshake where the card is expecting 3V logic levels fail? (AKA the Tinkerboard problem). Hobbling the regulator such that Linux can never actually turn VCC3V0_SD off, thus the card never gets reset, might appear to "work", but isn't the right thing to do.
>> 
>> Robin.
> 
> Right, this is all very strange.
> 
> Indeed, I have a UHS card and the problem you describe.
> I've actually looked into the other RK3399 dts files to come up with that patch (e.g. rk3399-roc-pc.dtsi, which does this; also see [1])

rk3399-roc-pc uses GPIO4-D6 for SDMMC0_PWR to enable VCC3V0_SD.

> 
> I understand that we should do the right thing, but I am by no means sure what the "right" thing for this problem is.
> That said, I wished someone with expertise and authority in the mmc/rockchip community would fix this for good.
> 
> There are several patches around this 1.8V/3V voltage dance that do work, get used by several distributions but didn't get merged to mainline because, well, there could be a better right thing to do (like [2], which is also still needed when using mainline u-boot).
> 
> Given the state of this issue, at least aligning the code to match another board's fix — which already is in the mainline kernel — seems a sensible approach to me. It unblocks users like me who would perhaps otherwise just give up on using these devices.
> 
> [1] https://lore.kernel.org/linux-mmc/3364813.APbW32NlgJ@phil/T/#m1b23cd2c43b600b5a6f084461ae53e482ad65316
> [2] https://patchwork.kernel.org/project/linux-mmc/patch/AM3PR03MB09664161A7FA2BD68B2800A7AC620@AM3PR03MB0966.eurprd03.prod.outlook.com/
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

Gruß,
-- 
Markus Reichl
