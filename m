Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E953B54B273
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 15:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239428AbiFNNoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 09:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238780AbiFNNoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 09:44:25 -0400
Received: from smtpout1.mo528.mail-out.ovh.net (smtpout1.mo528.mail-out.ovh.net [46.105.34.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936BE22B07;
        Tue, 14 Jun 2022 06:44:21 -0700 (PDT)
Received: from pro2.mail.ovh.net (unknown [10.109.156.149])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 544B810C08DE9;
        Tue, 14 Jun 2022 15:44:16 +0200 (CEST)
Received: from [192.168.1.41] (88.161.25.233) by DAG1EX2.emp2.local
 (172.16.2.2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.9; Tue, 14 Jun
 2022 15:44:14 +0200
Message-ID: <84da79a6-9515-2b42-b34a-0c089d7a41b7@traphandler.com>
Date:   Tue, 14 Jun 2022 15:44:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 3/3] leds: tlc5925: Add support for non blocking
 operations
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Pavel Machek <pavel@ucw.cz>, <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220609162734.1462625-1-jjhiblot@traphandler.com>
 <20220609162734.1462625-4-jjhiblot@traphandler.com>
 <CAHp75VftbVOwPFra83T-k5d1qu3NnD_sDHYxiiSEDDrW3NObNQ@mail.gmail.com>
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
In-Reply-To: <CAHp75VftbVOwPFra83T-k5d1qu3NnD_sDHYxiiSEDDrW3NObNQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [88.161.25.233]
X-ClientProxiedBy: DAG2EX1.emp2.local (172.16.2.11) To DAG1EX2.emp2.local
 (172.16.2.2)
X-Ovh-Tracer-Id: 10425833138685622747
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrudduledgieejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgihesthejredttdefjeenucfhrhhomheplfgvrghnqdflrggtqhhuvghsucfjihgslhhothcuoehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomheqnecuggftrfgrthhtvghrnhepieejfedukeevudfghfetudevhffhhfekjeeiudegtdehueevgfdvgeeivdeifedvnecukfhppedtrddtrddtrddtpdekkedrudeiuddrvdehrddvfeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehprhhovddrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhohedvke
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09/06/2022 18:43, Andy Shevchenko wrote:
> On Thu, Jun 9, 2022 at 6:29 PM Jean-Jacques Hiblot
> <jjhiblot@traphandler.com> wrote:
>> Settings multiple LEDs in a row can be a slow operation because of the
>> time required to acquire the bus and prepare the transfer.
>> And, in most cases, it is not required that the operation is synchronous.
>>
>> Implementing the non-blocking brightness_set() for such cases.
>> A work queue is used to perform the actual SPI transfer.
>>
>> The blocking method is still available in case someone needs to perform
>> this operation synchronously (ie by calling led_set_brightness_sync()).
> i.e.
>
>> +#define BITS_PER_ATOMIC (sizeof(atomic_t) * 8)
> We have BITS_PER_TYPE(). Use it directly in the code, no need for a
> whole new macro.
>
> ...
>
>> +static int xmit(struct tlc5925_leds_priv *priv)
>> +{
>> +       int i;
>> +
>> +       spin_lock(&priv->lock);
> This can't be called during IRQ?
>
>> +       for (i = 0; i < priv->max_state / (sizeof(atomic_t) * 8) ; i++)
> BITS_PER_TYPE() ?
>
>> +               priv->spi_buffer[i] = atomic_read(&priv->state[i]);
>> +       spin_unlock(&priv->lock);
>> +
>> +       return spi_write(priv->spi, priv->spi_buffer, priv->max_num_leds / 8);
>> +}
> ...
>
>> +static void xmit_work(struct work_struct *ws)
>> +{
>> +       struct tlc5925_leds_priv *priv =
>> +               container_of(ws, struct tlc5925_leds_priv, xmit_work);
> One line?
>
> Missed blank line here.
>
>> +       xmit(priv);
>> +};
> ...
>
>>          if (brightness)
>> -               priv->state[index / 8] |= (1 << (index % 8));
>> +               atomic_or(1 << (index % BITS_PER_ATOMIC),
>> +                         &priv->state[index / BITS_PER_ATOMIC]);
>>          else
>> -               priv->state[index / 8] &= ~(1 << (index % 8));
>> -       spin_unlock(&priv->lock);
>> +               atomic_and(~(1 << (index % BITS_PER_ATOMIC)),
>> +                          &priv->state[index / BITS_PER_ATOMIC]);
> The whole bunch looks like reinventing the bitmap / bitops.
> Use unsigned long (or DECLARE_BITMAP() if it can be higher than 32)
> for state and set_bit() / clear_bit() / assign_bit() that are atomic.

Thanks for pointing this out.

It will drastically simplify the code.

>
> ...
>
>> +       if (brightness)
>> +               atomic_or(1 << (index % BITS_PER_ATOMIC),
>> +                         &priv->state[index / BITS_PER_ATOMIC]);
>> +       else
>> +               atomic_and(~(1 << (index % BITS_PER_ATOMIC)),
>> +                          &priv->state[index / BITS_PER_ATOMIC]);
> assign_bit()
>
> ...
>
>> +       // Allocate the buffer used to hold the state of each LED
>> +       priv->max_state = round_up(max_num_leds, BITS_PER_ATOMIC);
>> +       priv->state = devm_kzalloc(dev,
>> +                                  priv->max_state / 8,
>> +                                  GFP_KERNEL);
>>          if (!priv->state)
>>                  return -ENOMEM;
> devm_bitmap_zalloc() ?
>
> ...
>
>> +       // Allocate a second buffer for the communication on the SPI bus
>> +       priv->spi_buffer = devm_kzalloc(dev,
>> +                                  priv->max_state / 8,
>> +                                  GFP_KERNEL);
> Not sure I understand the output, but perhaps here the BITS_TO_BYTES()
> should be used.
>
