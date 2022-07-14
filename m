Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3FC574FD3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240162AbiGNNvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240066AbiGNNuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:50:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 834295A2CB;
        Thu, 14 Jul 2022 06:50:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C99F1D13;
        Thu, 14 Jul 2022 06:50:17 -0700 (PDT)
Received: from [10.57.86.49] (unknown [10.57.86.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E9D093F73D;
        Thu, 14 Jul 2022 06:50:15 -0700 (PDT)
Message-ID: <590f7a08-a6ca-be54-4254-363343642a52@arm.com>
Date:   Thu, 14 Jul 2022 14:50:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] arm64: dts: rockchip: Fix SD card init on rk3399-nanopi4
Content-Language: en-GB
To:     =?UTF-8?Q?Christian_Kohlsch=c3=bctter?= 
        <christian@kohlschutter.com>
Cc:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux MMC List <linux-mmc@vger.kernel.org>
References: <C639AD88-77A1-4485-BAEA-2FF8FC15A844@kohlschutter.com>
 <12878108.O9o76ZdvQC@diego> <103b714c-b07c-f016-1062-84bd94786b22@arm.com>
 <9AF1E75F-5947-49B0-887D-82C426527B99@kohlschutter.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <9AF1E75F-5947-49B0-887D-82C426527B99@kohlschutter.com>
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

On 2022-07-14 13:14, Christian Kohlschütter wrote:
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
>>>>   arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi | 6 +++---
>>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
>>>> index 8c0ff6c96e03..91789801ab03 100644
>>>> --- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
>>>> @@ -67,10 +67,10 @@ vcc1v8_s3: vcc1v8-s3 {
>>>>   	vcc3v0_sd: vcc3v0-sd {
>>>>   		compatible = "regulator-fixed";
>>>>   		enable-active-high;
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
>>>>   		pinctrl-names = "default";
>>>>   		pinctrl-0 = <&sdmmc0_pwr_h>;
>>>> -		regulator-always-on;
>>>> +		regulator-boot-on;
>>>>   		regulator-min-microvolt = <3000000>;
>>>>   		regulator-max-microvolt = <3000000>;
>>>>   		regulator-name = "vcc3v0_sd";
>>>> @@ -580,7 +580,7 @@ wifi_reg_on_h: wifi-reg_on-h {
>>>>     	sdmmc {
>>>>   		sdmmc0_det_l: sdmmc0-det-l {
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

That patch is simply adding a description of the VCC3V0_SD regulator 
which is correct for that board (at least according to the 
roc-rk3399-pc-plus schematic that I could find); very different from 
breaking an existing already-correct description.

> I understand that we should do the right thing, but I am by no means sure what the "right" thing for this problem is.
> That said, I wished someone with expertise and authority in the mmc/rockchip community would fix this for good.
> 
> There are several patches around this 1.8V/3V voltage dance that do work, get used by several distributions but didn't get merged to mainline because, well, there could be a better right thing to do (like [2], which is also still needed when using mainline u-boot).
> 
> Given the state of this issue, at least aligning the code to match another board's fix — which already is in the mainline kernel — seems a sensible approach to me. It unblocks users like me who would perhaps otherwise just give up on using these devices.

Indeed it's an unfortunate situation, and I'd like to see the "proper" 
solution too, but my point is more that this patch isn't even the 
correct way to do what this patch actually achieves. Tricking Linux into 
toggling a non-existent pin prevents it from turning this regulator off 
(or on, so we're already hoping that someone else has done that); 
however that's what the "regulator-always-on" property should already 
imply, so the patch should at least explain why we're taking this more 
drastic measure instead of trying to fix whatever causes the always-on 
property to apparently not be honoured. Furthermore, if it is justified 
to remove Linux's ability to control the regulator at all, then making 
up a bogus GPIO is still nonsensical (just remove it completely), and 
changing regulator-always-on to regulator-boot-on (saying that Linux 
*is* permitted to try to do the thing you're actively preventing it from 
doing) even more so.

The other concern I have is whether this is really a sufficiently robust 
workaround anyway. I'm not familiar enough to know whether a soft-reset 
at potentially the wrong I/O voltage is something that all cards are 
going to handle reliably and without risk of damage. Furthermore, if a 
card reset happens anyway for any other reason, e.g. the user physically 
swaps cards during the reboot, then it's still not going to work.

Thanks,
Robin.

> [1] https://lore.kernel.org/linux-mmc/3364813.APbW32NlgJ@phil/T/#m1b23cd2c43b600b5a6f084461ae53e482ad65316
> [2] https://patchwork.kernel.org/project/linux-mmc/patch/AM3PR03MB09664161A7FA2BD68B2800A7AC620@AM3PR03MB0966.eurprd03.prod.outlook.com/
> 
