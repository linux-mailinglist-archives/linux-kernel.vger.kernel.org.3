Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8E64934C0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 07:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351653AbiASGAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 01:00:55 -0500
Received: from mail-sh.amlogic.com ([58.32.228.43]:6385 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349845AbiASGAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 01:00:48 -0500
Received: from [10.18.29.173] (10.18.29.173) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Wed, 19 Jan
 2022 14:00:45 +0800
Message-ID: <21eea0cd-5bf1-dec6-a776-f417aefa5bda@amlogic.com>
Date:   Wed, 19 Jan 2022 14:00:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH V6 3/5] tty: serial: meson: Describes the calculation of
 the UART baud rate clock using a clock frame
Content-Language: en-US
To:     Jiri Slaby <jirislaby@kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220118030911.12815-1-yu.tu@amlogic.com>
 <20220118030911.12815-4-yu.tu@amlogic.com>
 <7a8016ba-730b-f599-2032-31cf03990a55@kernel.org>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <7a8016ba-730b-f599-2032-31cf03990a55@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.18.29.173]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,
	Thank you very much for your patient reply.I learned a lot from your 
response.

On 2022/1/18 17:39, Jiri Slaby wrote:
> [ EXTERNAL EMAIL ]
> 
> On 18. 01. 22, 4:09, Yu Tu wrote:
>> Using the common Clock code to describe the UART baud rate clock
>> makes it easier for the UART driver to be compatible with the
>> baud rate requirements of the UART IP on different meson chips.
> ...
>> --- a/drivers/tty/serial/meson_uart.c
>> +++ b/drivers/tty/serial/meson_uart.c
> ...
>> @@ -629,57 +640,105 @@ static struct uart_driver meson_uart_driver = {
>>       .cons        = MESON_SERIAL_CONSOLE,
>>   };
>> -static inline struct clk *meson_uart_probe_clock(struct device *dev,
>> -                         const char *id)
>> -{
>> -    struct clk *clk = NULL;
>> -    int ret;
>> -
>> -    clk = devm_clk_get(dev, id);
>> -    if (IS_ERR(clk))
>> -        return clk;
>> -
>> -    ret = clk_prepare_enable(clk);
>> -    if (ret) {
>> -        dev_err(dev, "couldn't enable clk\n");
>> -        return ERR_PTR(ret);
>> -    }
>> -
>> -    devm_add_action_or_reset(dev,
>> -            (void(*)(void *))clk_disable_unprepare,
>> -            clk);
>> -
>> -    return clk;
>> -}
>> +static struct clk_div_table xtal_div_table[] = {
> 
> This can be const, right?
You are right.
> 
>> +    {0, 3},
>> +    {1, 1},
>> +    {2, 2},
>> +    {3, 2},
> 
> Not sure if you didn't remove too much whitespace. I think it should be 
> like: "{ 0, 3 },". But I actually don't care, it's a minor thing.
> 
Ok, I will correct it if it needs to be changed.
> I cannot comment on the rest (clk and OF part) as my knowledge is pretty 
> limited there. Leaving up to others.
> 
Anyway, thanks for your reply.
> thanks,
