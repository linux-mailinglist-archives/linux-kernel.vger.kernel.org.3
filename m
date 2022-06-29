Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6350560962
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 20:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiF2Sok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 14:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiF2Soj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 14:44:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8354F2558E;
        Wed, 29 Jun 2022 11:44:38 -0700 (PDT)
Received: from [10.10.0.109] (unknown [186.189.224.65])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: adalessandro)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 77C356601924;
        Wed, 29 Jun 2022 19:44:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656528276;
        bh=JZJmmVefkY6Pjhld3W1zj0Pcgi0dRvhTO1IcFibOrfw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jPLBrRyB4RSTShwzvOZ4m6BmSMJQBIluDuqP1GyRQnvRh00x4lOkKPnHjDODBExxF
         ep4iMQOxeBlTn+tQDssy1yn5mNQzo5VxhO4otVTrMRoHYhKxupemBxn1DqeuIWeAb4
         AWVrINmTmuhv20PpwCCSA2T8qRnJnnKbl8nKglbG09ay0XGKdAWx6Qtpvx3/l85KP9
         O0LrXzEeLrJb0sKy33uapGZrrqgJwr3BYuRNBL6Nvutz1UOoUQ4FkMAPWDy7i0Alho
         pirWbv7R3dubjkLGtjnLyuCZk/rlq65YtJQaQl85CSuoAYcAr19oha0s5XOj5biPGj
         CbpVrMss3ty0g==
Message-ID: <5a2d2365-effb-2663-1ace-fddb59ee61b7@collabora.com>
Date:   Wed, 29 Jun 2022 15:44:26 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] ARM: dts: bcm2711-rpi: Use aliases to set custom MMC
 device index
Content-Language: en-US
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        krzysztof.kozlowski+dt@linaro.org, nsaenz@kernel.org,
        robh+dt@kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        pbrobinson@gmail.com, f.fainelli@gmail.com
References: <20220614141208.15614-1-ariel.dalessandro@collabora.com>
 <c3c62929-77ba-6bae-1e0c-4d4ece9c9b32@i2se.com>
From:   Ariel D'Alessandro <ariel.dalessandro@collabora.com>
In-Reply-To: <c3c62929-77ba-6bae-1e0c-4d4ece9c9b32@i2se.com>
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

Hi Stefan,

Sorry for the delay.

On 6/14/22 17:47, Stefan Wahren wrote:
> Hi Ariel,
> 
> Am 14.06.22 um 16:12 schrieb Ariel D'Alessandro:
>> Add MMC aliases to ensure that the /dev/mmcblk ID for the first
>> eMMC/SD card won't change depending on the probe order of the MMC
>> drivers.
> 
> this changes the emmc2 from mmc1 to mmc0 in my case (RPi 4,
> multi_v7_defconfig), which i consider as a regression / unexpected
> change in userspace.
> 
> Could you please explain your actual motivation of your patch?

That's a good point. The original reason comes from u-boot in fact, I
just sent the patch here as u-boot is syncing the dts files from the kernel.

U-boot uses the same defconfig `configs/rpi_arm64_defconfig` for
different RPi versions, which have different mmcblk ids numbering.

In order to use bootcount support in u-boot, the config option
CONFIG_SYS_BOOTCOUNT_EXT_DEVPART needs to be filled with the fixed
dev/part ids. In general I'd expect mmcblk0 to be eMMC/SD, which is not
in this case, at least for RPi4.

Anyway, this is probably something to be discussed on the u-boot mailing
list, not here.

Thanks,
Ariel

> 
>>
>> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
>> ---
>>
>> Changes in v2:
>> * Moved alias from bcm2711-rpi-4-b.dts to bcm2711-rpi.dtsi
>>
>>   arch/arm/boot/dts/bcm2711-rpi.dtsi | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/boot/dts/bcm2711-rpi.dtsi
>> b/arch/arm/boot/dts/bcm2711-rpi.dtsi
>> index ca266c5d9f9b..a39b2f68e4cc 100644
>> --- a/arch/arm/boot/dts/bcm2711-rpi.dtsi
>> +++ b/arch/arm/boot/dts/bcm2711-rpi.dtsi
>> @@ -13,6 +13,7 @@ memory@0 {
>>       aliases {
>>           emmc2bus = &emmc2bus;
>>           ethernet0 = &genet;
>> +        mmc0 = &emmc2;    /* mmcblk0 for eMMC/SD */
>>           pcie0 = &pcie0;
>>           blconfig = &blconfig;
>>       };
