Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9657A548EE0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343934AbiFMPVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 11:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242503AbiFMPVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 11:21:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B3312F0D2;
        Mon, 13 Jun 2022 05:47:10 -0700 (PDT)
Received: from [10.10.0.109] (unknown [186.189.224.65])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: adalessandro)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9A75C66015BE;
        Mon, 13 Jun 2022 13:47:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655124428;
        bh=57qBytTfgYArCi7OQkHwm8tHdu4tMguIIFNnrR6lAiA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CavIbQ/X+EB8IPUuRvUIv/aBeGr+ViCz0T/8yLav8mwNynNt8Lo8syg8VcccGBAaK
         fWcu7Usu208oAMEnEMO2eVaXjGlyv5q4TskPYS6lgOGxjPfPqB9uSOGNfGNOPLhwkk
         FVQoOBYTnR1AdfczuWFJAXIiM/xsCTHNJABJbampe4KibeAO6NazI8x32KAI+QuvDF
         JySMXoCuv05SncucIwhFH1kx2oE69KzW2x0Wop0Taby+RGZgYf9GLHoH7jXdITuqL2
         +TGxioM5j30FmJteGniLqVzRi2fmnkZ0yUS63oTnyQjIbGZFrUpWbqnw58NoNvykNO
         j09J+4MdLcnpg==
Message-ID: <f83690bb-5513-db87-2d97-7cbd981aa0f7@collabora.com>
Date:   Mon, 13 Jun 2022 09:46:58 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] ARM: dts: bcm2711-rpi-4-b: Use aliases to set custom MMC
 device index
Content-Language: en-US
To:     Peter Robinson <pbrobinson@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        gbcm-kernel-feedback-list@broadcom.com,
        gkrzysztof.kozlowski+dt@linaro.org, gnsaenz@kernel.org,
        grobh+dt@kernel.org, nsaenz@kernel.org, stefan.wahren@i2se.com
References: <20220608123233.13439-1-ariel.dalessandro@collabora.com>
 <CALeDE9PR80qS63wwAKB-hENWbEj1xNHj+k81tyWkPPfZ0TS8Pw@mail.gmail.com>
From:   Ariel D'Alessandro <ariel.dalessandro@collabora.com>
In-Reply-To: <CALeDE9PR80qS63wwAKB-hENWbEj1xNHj+k81tyWkPPfZ0TS8Pw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 6/12/22 17:38, Peter Robinson wrote:
> On Wed, Jun 8, 2022 at 1:35 PM Ariel D'Alessandro
> <ariel.dalessandro@collabora.com> wrote:
>>
>> Add MMC aliases to ensure that the /dev/mmcblk ID for SD card won't
>> change depending on the probe order of the MMC drivers.
> 
> Is  the bcm2711-rpi.dtsi a better place for it given there's other
> aliases there and it will be consistent across variations?

Yes, indeed, it makes sense moving it to bcm2711-rpi.dtsi

The other board what will be affected by this alias is the Raspberry Pi
Compute Module 4 IO Board, on which emmc2 is the eMMC. However, the
alias makes sense, to have that as the first mmc device.

Maybe we can add the alias as follows?

    mmc0 = &emmc2;  /* mmcblk0 for eMMC/SD */

Regards,
Ariel

> 
>> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
>> ---
>>  arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
>> index 4432412044de..780812542bad 100644
>> --- a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
>> +++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
>> @@ -14,6 +14,10 @@ chosen {
>>                 stdout-path = "serial1:115200n8";
>>         };
>>
>> +       aliases {
>> +               mmc0 = &emmc2;  /* mmcblk0 for SD */
>> +       };
>> +
>>         leds {
>>                 led-act {
>>                         gpios = <&gpio 42 GPIO_ACTIVE_HIGH>;
>> --
>> 2.34.1
>>
>>
>> _______________________________________________
>> linux-rpi-kernel mailing list
>> linux-rpi-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel
