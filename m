Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5348C517AF4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 01:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiEBXvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 19:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiEBXv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 19:51:27 -0400
Received: from skyrocket.fabmicro.ru (skyrocket.fabmicro.ru [217.116.57.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6943056D
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 16:47:55 -0700 (PDT)
Received: from mail.fabmicro.ru (skyrocket.fabmicro.ru [217.116.57.130])
        by skyrocket.fabmicro.ru (8.14.9/8.14.9) with ESMTP id 242Nl6QG033711;
        Mon, 2 May 2022 23:47:06 GMT
        (envelope-from rz@fabmicro.ru)
MIME-Version: 1.0
Date:   Tue, 03 May 2022 04:47:06 +0500
From:   Ruslan Zalata <rz@fabmicro.ru>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2] hwmon: (sun4i-lradc) Add driver for LRADC found on
 Allwinner A13/A20 SoC
In-Reply-To: <59e91f45-7263-eb41-4b47-db217af54910@roeck-us.net>
References: <20220428210906.29527-1-rz@fabmicro.ru>
 <f79a8edf-36d4-02af-da8f-32b4e491bd47@roeck-us.net>
 <e0b57c7587dded38a92411994f353b3d@fabmicro.ru>
 <e4d1a6c8-1afd-671e-76bf-b5bde9dc282f@roeck-us.net>
 <59e91f45-7263-eb41-4b47-db217af54910@roeck-us.net>
User-Agent: Roundcube Webmail/1.4.3
Message-ID: <f315a4ddb51cdfd8596103836acbe7dd@fabmicro.ru>
X-Sender: rz@fabmicro.ru
Organization: Fabmicro, LLC.
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

I'm sorry to disappoint you, but continuous mode for LRADC works only 
for key presses (significant voltage change), it does not work for raw 
data. Here's an excerpt from the manual that supports my discovery 
(punctuation and grammar preserved):

> The LRADC have three mode, Normal Mode、Single Mode and Continue Mode. 
> Normal mode is that the LRADC will
> report the result data of each convert all the time when the key is 
> down. Single Mode is that the LRADC
> will only report the first convert result data when the key is down. 
> Continue Mode is that the LRADC will
> report one of 8*(N+1) (N is program can set) sample convert result data 
> when key is down.

In other words, all three modes require key down event (voltage change) 
and IRQ is the only way to get continuous raw data updates from LRADC. 
I've experimented quite a lot with this for past few days, there are no 
changes to values in ADC data regs except in DATA IRQ mode.

Regarding variant structure. Vref is not the only difference between 
different implementations of LRADC in different Allwinner SoCs. For 
example, A83T has only one channel LRADC instead of two channels in 
A10/A13/A20. Some other SoCs may have even more differences. I 
introduced hwmon_chip_info structure into variant to encapsulate such 
differences in one place. Patch version 3 will follow. Thank you.

---
Regards,
Ruslan.

Fabmicro, LLC.

On 2022-04-29 11:03, Guenter Roeck wrote:
> On 4/28/22 22:32, Guenter Roeck wrote:
>> On 4/28/22 17:28, Ruslan Zalata wrote:
>>> Thank you Guenter for your valuable time.
>>> 
>>> I have added update_interval option (it's in ms units, right?) and 
>>> fixed all other issues you pointed to. Will test it on real hardware 
>>> and send third version of the patch for review.
>>> 
>>> Regarding IRQ. Alternatively the driver would need to sit and poll 
>>> conversion ready bit in a loop which might cause a much worse load on 
>>> system, is not it ? Anyway, the real problem with this piece of 
>>> hardware is that there's no "conversion ready bit" provided, the only 
>>> way to know data ready status is to receive an interrupt.
>>> 
>> 
>> Not necessarily. The data does not have to be "current", after all,
>> if the hardware is able to continuously convert. If not, the question
>> is how long a conversion takes. If it doesn't take too long, it would
>> be better to initiate a conversion and then wait for the completion.
>> 
>>> I think it still needs a semaphore/seqlock to synchronize conversions 
>>> and reads. I.e. two consequent reads should not return same old 
>>> value. Although it's not an issue in my case, but could be a problem 
>>> for others.
>>> 
>> Why ? That happens for almost all hwmon devices. They will all report
>> the most recent conversion value. Some of them can take seconds
>> to complete a new conversion, so the reported value is always "old"
>> for a given defition of old (ie any time smaller than a conversion
>> interval).
>> 
>> Sigh. Looks like I'll have to dig up the documentation and read about
>> the ADC myself.
>> 
> 
> I did, for both A13 and A20. The ADC supports continuous mode. That
> means it can be configured accordingly, and reading the ADC value
> just returns the most recent conversion value. There is absolutely
> no need to keep reading the conversion values using interrupts.
> 
> Also,
> 
> +struct lradc_variant {
> +	u32 bits;
> +	u32 resolution;
> +	u32 vref;
> +};
> 
> is unnecessary because the values are the same for both supported 
> chips.
> That means that defines can and should be used. Yes, I can see that
> A83T uses a different voltage, but even that doesn't need a structure -
> the voltage can be set in struct sun4i_lradc_data if/when needed,
> and the resolution and number of bits is still the same.
> 
> Guenter
