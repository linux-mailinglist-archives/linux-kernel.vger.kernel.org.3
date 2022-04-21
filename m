Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997FA509CBA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387866AbiDUJuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387823AbiDUJu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:50:27 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF13245BE;
        Thu, 21 Apr 2022 02:47:37 -0700 (PDT)
Received: from [10.18.29.47] (10.18.29.47) by mail-sh.amlogic.com (10.18.11.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Thu, 21 Apr
 2022 17:47:34 +0800
Message-ID: <3c7e9ce4-4c01-4289-2ccd-7050774990fb@amlogic.com>
Date:   Thu, 21 Apr 2022 17:47:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V2 2/2] tty: serial: meson: Added S4 SOC compatibility
Content-Language: en-US
To:     Neil Armstrong <narmstrong@baylibre.com>,
        <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
CC:     Jiri Slaby <jirislaby@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220418053202.24528-1-yu.tu@amlogic.com>
 <20220418053202.24528-3-yu.tu@amlogic.com>
 <3f5df9df-7699-7210-6253-4dd03f4444a0@baylibre.com>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <3f5df9df-7699-7210-6253-4dd03f4444a0@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.18.29.47]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/4/21 16:49, Neil Armstrong wrote:
> [ EXTERNAL EMAIL ]
> 
> On 18/04/2022 07:32, Yu Tu wrote:
>> Make UART driver compatible with S4 SOC UART. Meanwhile, the S4 SOC
>> UART uses 12MHz as the clock source for baud rate calculations.
>>
>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>> ---
>>   drivers/tty/serial/meson_uart.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/tty/serial/meson_uart.c 
>> b/drivers/tty/serial/meson_uart.c
>> index 58bd2723c004..43941f21735f 100644
>> --- a/drivers/tty/serial/meson_uart.c
>> +++ b/drivers/tty/serial/meson_uart.c
>> @@ -790,11 +790,19 @@ static int meson_uart_remove(struct 
>> platform_device *pdev)
>>       return 0;
>>   }
>> +static struct meson_uart_data s4_uart_date = {
> 
> Should be s4_uart_data instead of s4_uart_date
> 
I will prepare the next version and  correct it.
>> +    .has_xtal_div2 = true,
>> +};
>> +
>>   static const struct of_device_id meson_uart_dt_match[] = {
>>       { .compatible = "amlogic,meson6-uart" },
>>       { .compatible = "amlogic,meson8-uart" },
>>       { .compatible = "amlogic,meson8b-uart" },
>>       { .compatible = "amlogic,meson-gx-uart" },
>> +    {
>> +        .compatible = "amlogic,meson-s4-uart",
>> +        .data = (void *)&s4_uart_date,
> 
> Here same
> 
>> +    },
>>       { /* sentinel */ },
>>   };
>>   MODULE_DEVICE_TABLE(of, meson_uart_dt_match);
> With this change, it's fine for me.
> 
> Neil
> 
> .
