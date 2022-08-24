Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11DCB59F6F9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 11:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236025AbiHXJ6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 05:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbiHXJ6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 05:58:17 -0400
Received: from smtpout1.mo528.mail-out.ovh.net (smtpout1.mo528.mail-out.ovh.net [46.105.34.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD5012AFC;
        Wed, 24 Aug 2022 02:58:16 -0700 (PDT)
Received: from pro2.mail.ovh.net (unknown [10.108.20.149])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 964C31220F409;
        Wed, 24 Aug 2022 11:58:14 +0200 (CEST)
Received: from [192.168.1.41] (88.161.25.233) by DAG1EX1.emp2.local
 (172.16.2.1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12; Wed, 24 Aug
 2022 11:58:14 +0200
Message-ID: <5bb9955e-4c2f-ca55-0e77-c082a868371a@traphandler.com>
Date:   Wed, 24 Aug 2022 11:58:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND PATCH v6 2/3] leds: Add driver for the TLC5925 LED
 controller
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220722081146.47262-1-jjhiblot@traphandler.com>
 <20220722081146.47262-3-jjhiblot@traphandler.com>
 <CAHp75Vdu-EJRRxkK7+TfuE=zEDkJye1QCXSB+cDLrqxuykJjkA@mail.gmail.com>
 <5ba34982-52c7-e41a-fba8-d88d93529e47@traphandler.com>
 <20220804210412.GA30210@duo.ucw.cz>
 <0663c616-97c8-444c-f390-275fae402453@traphandler.com>
 <CAHp75Vf1cT81cx38VQ80PbyG9i9xbiegMnQoMWwZEZf+7fWJuQ@mail.gmail.com>
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
In-Reply-To: <CAHp75Vf1cT81cx38VQ80PbyG9i9xbiegMnQoMWwZEZf+7fWJuQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [88.161.25.233]
X-ClientProxiedBy: DAG4EX2.emp2.local (172.16.2.32) To DAG1EX1.emp2.local
 (172.16.2.1)
X-Ovh-Tracer-Id: 17741367783541651931
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejuddgvddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgihesthejredttdefjeenucfhrhhomheplfgvrghnqdflrggtqhhuvghsucfjihgslhhothcuoehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomheqnecuggftrfgrthhtvghrnhepieejfedukeevudfghfetudevhffhhfekjeeiudegtdehueevgfdvgeeivdeifedvnecukfhppedtrddtrddtrddtpdekkedrudeiuddrvdehrddvfeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehprhhovddrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhohedvke
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/08/2022 10:55, Andy Shevchenko wrote:
> On Wed, Aug 24, 2022 at 11:39 AM Jean-Jacques Hiblot
> <jjhiblot@traphandler.com> wrote:
>> On 04/08/2022 23:04, Pavel Machek wrote:
>>> On Thu 2022-08-04 22:23:00, Jean-Jacques Hiblot wrote:
>>>> On 31/07/2022 21:28, Andy Shevchenko wrote:
>>>>> On Fri, Jul 22, 2022 at 10:14 AM Jean-Jacques Hiblot
>>>>> <jjhiblot@traphandler.com> wrote:
> ...
>
>>>>> Sorry for my slowpokeness, but I just realized that this driver may
>>>>> not be needed. What is the difference to existing gpio-74x164?
>>>> It might work. However it might not be as practical and efficient as the
>>>> dedicated LED driver.
>>>>
>>>> I'll give a try.
>>> It is certainly preffered solution. If you decide to re-submit the
>>> driver anyway, please mention that we already have GPIO driver for
>>> compatible chip, and explain why this is superior.
>> sorry for the delay. I tried with the  74x164 gpio driver and it works
>> as expected.
>>
>> The only drawbacks are:
>>
>> - as-is the 74x164 gpio driver supports only one output-enable gpio.
>> However in practice I don't think multiple OE GPIOs will ever be used.
> Let's leave it to the case when it will be needed. So, we can skip this point.
>
>> - with this approach, every time a LED status is changed the whole
>> register has to be sent on the SPI bus. In other words, changes cannot
>> be coalesced.
> But isn't it the same as what you do in your driver? To me it looks
> like you send the entire range of the values each time you change one
> LED's brightness. I don't see any differences with the GPIO driver.
No. The TLC5925 driver updates the register asynchronously: the cached 
value of the register is updated synchronously and then it is 
transferred over SPI using a workqueue. This way if multiple LED are set 
in a short time, the changes are coalesced into a single SPI transfer. 
This is however probably not a must-have feature.
>
>> I don't know if this is enough to make a dedicated TLC5925 driver
>> desirable in the kernel.
> I don't think you have enough justification for a new driver.
>
