Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37CE466A1F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 20:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356364AbhLBTGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 14:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348436AbhLBTGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 14:06:17 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CECDC06174A;
        Thu,  2 Dec 2021 11:02:54 -0800 (PST)
Received: from [2a04:4540:1400:db00:91f3:71ad:3324:436c]
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1msrM1-00047k-82; Thu, 02 Dec 2021 20:02:49 +0100
Message-ID: <c721ac4a-8b80-2241-3380-6b55e953d754@phrozen.org>
Date:   Thu, 2 Dec 2021 20:02:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v5 12/13] gpio: Add support for Airoha EN7523 GPIO
 controller
Content-Language: en-GB
To:     Felix Fietkau <nbd@nbd.name>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20211129153330.37719-1-nbd@nbd.name>
 <20211129153330.37719-13-nbd@nbd.name>
 <CACRpkdacgoT-K4qZoBpMx8RiPcvOf=YmrTP36LKyizcQk+VyUQ@mail.gmail.com>
 <c42f4ea0-2879-01cf-1db8-ed39844959fc@nbd.name>
From:   John Crispin <john@phrozen.org>
In-Reply-To: <c42f4ea0-2879-01cf-1db8-ed39844959fc@nbd.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02.12.21 18:59, Felix Fietkau wrote:
> 
> On 2021-12-02 02:47, Linus Walleij wrote:
>> Hi Felix!
>>
>> Thanks for your patch!
>>
>> On Mon, Nov 29, 2021 at 4:54 PM Felix Fietkau <nbd@nbd.name> wrote:
>>
>>> From: John Crispin <john@phrozen.org>
>>>
>>> Airoha's GPIO controller on their ARM EN7523 SoCs consists of two 
>>> banks of 32
>>> GPIOs. Each instance in DT is for an single bank.
>>>
>>> Signed-off-by: John Crispin <john@phrozen.org>
>>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>>
>> (...)
>>> +config GPIO_EN7523
>>> +       tristate "Airoha GPIO support"
>>> +       depends on ARCH_AIROHA
>>> +       default ARCH_AIROHA
>>> +       select GPIO_GENERIC
>>
>> Yes that looks applicable, but why isn't it used?
>>
>> The few 32-bit registers look like an ideal candidate for
>> using the generic GPIO. Check similar drivers such as
>> drivers/gpio/gpio-ftgpio010.c and how it uses
>> bgpio_init() and the nice doc for bgpio_init() in
>> drivers/gpio/gpio-mmio.c.
> I just looked at the datasheet and the driver code again, and I think 
> EN7523 is too strange for proper generic GPIO support.
> 
> For each bank there are two control registers (not consecutive), which 
> have 2-bit fields for every GPIO line to control direction. No idea why 
> 2 bits per line, because only values 0 and 1 are valid, the rest are 
> reserved.
> For lines configured as output, an extra output-enable bit also needs to 
> be set in a separate register before output values can be written.
> 
> The code does use bgpio to read/write values, but that's about it.
> I don't think it would do the generic GPIO code any good to support this 
> weirdness.
> 
> - Felix
Hi Linus,
I sent an email to you 16.06.21 explaining all of this and you replied, 
telling me that this approach is the most reasonable one to take.
	John
