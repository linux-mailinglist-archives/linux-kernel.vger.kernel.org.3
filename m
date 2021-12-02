Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5A9466986
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 18:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376502AbhLBSCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 13:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhLBSCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 13:02:31 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE8CC06174A;
        Thu,  2 Dec 2021 09:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:Subject:
        From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=PbNRTWvVFrQhSfiFmSEKFvbhIel4YjxA0wnIzvHb8r0=; b=E/oitWV4Vohr250EjbMQbna/JR
        chMwbzdnr9hplbVWpNh6OpTMETeCCIS8oFoItBPiwA74gexrdYw/muEeMadTPKkaElBa3TcEe9HAE
        SRCUs9PTaR4oeCGIDAf2BKfvaV0K1kELPcyuSNzFmZZ/dVhNJw9uicqnfBzxm+13IGv4=;
Received: from p54ae943f.dip0.t-ipconnect.de ([84.174.148.63] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1msqMK-0001s4-RS; Thu, 02 Dec 2021 18:59:04 +0100
Message-ID: <c42f4ea0-2879-01cf-1db8-ed39844959fc@nbd.name>
Date:   Thu, 2 Dec 2021 18:59:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <brgl@bgdev.pl>, john@phrozen.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20211129153330.37719-1-nbd@nbd.name>
 <20211129153330.37719-13-nbd@nbd.name>
 <CACRpkdacgoT-K4qZoBpMx8RiPcvOf=YmrTP36LKyizcQk+VyUQ@mail.gmail.com>
From:   Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH v5 12/13] gpio: Add support for Airoha EN7523 GPIO
 controller
In-Reply-To: <CACRpkdacgoT-K4qZoBpMx8RiPcvOf=YmrTP36LKyizcQk+VyUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021-12-02 02:47, Linus Walleij wrote:
> Hi Felix!
> 
> Thanks for your patch!
> 
> On Mon, Nov 29, 2021 at 4:54 PM Felix Fietkau <nbd@nbd.name> wrote:
> 
>> From: John Crispin <john@phrozen.org>
>>
>> Airoha's GPIO controller on their ARM EN7523 SoCs consists of two banks of 32
>> GPIOs. Each instance in DT is for an single bank.
>>
>> Signed-off-by: John Crispin <john@phrozen.org>
>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> 
> (...)
>> +config GPIO_EN7523
>> +       tristate "Airoha GPIO support"
>> +       depends on ARCH_AIROHA
>> +       default ARCH_AIROHA
>> +       select GPIO_GENERIC
> 
> Yes that looks applicable, but why isn't it used?
> 
> The few 32-bit registers look like an ideal candidate for
> using the generic GPIO. Check similar drivers such as
> drivers/gpio/gpio-ftgpio010.c and how it uses
> bgpio_init() and the nice doc for bgpio_init() in
> drivers/gpio/gpio-mmio.c.
I just looked at the datasheet and the driver code again, and I think 
EN7523 is too strange for proper generic GPIO support.

For each bank there are two control registers (not consecutive), which 
have 2-bit fields for every GPIO line to control direction. No idea why 
2 bits per line, because only values 0 and 1 are valid, the rest are 
reserved.
For lines configured as output, an extra output-enable bit also needs to 
be set in a separate register before output values can be written.

The code does use bgpio to read/write values, but that's about it.
I don't think it would do the generic GPIO code any good to support this 
weirdness.

- Felix
