Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F044BD827
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 09:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243980AbiBUIYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 03:24:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiBUIYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 03:24:33 -0500
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71D160F2;
        Mon, 21 Feb 2022 00:24:10 -0800 (PST)
Received: from [10.18.29.173] (10.18.29.173) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Mon, 21 Feb
 2022 16:24:07 +0800
Message-ID: <1cd6e368-e1ce-d587-fb5d-d8bd46dbeb99@amlogic.com>
Date:   Mon, 21 Feb 2022 16:24:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH V6 4/5] tty: serial: meson: Make some bit of the REG5
 register writable
Content-Language: en-US
To:     Jerome Brunet <jbrunet@baylibre.com>,
        <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220118030911.12815-1-yu.tu@amlogic.com>
 <20220118030911.12815-5-yu.tu@amlogic.com>
 <1j7dau2hxi.fsf@starbuckisacylon.baylibre.com>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <1j7dau2hxi.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.29.173]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,
	Thank you very much for your reply. At present, the problem of 
switching uART baud rate stuck has been solved. I'm ready to send the 
next edition.

On 2022/1/21 5:49, Jerome Brunet wrote:
> [ EXTERNAL EMAIL ]
> 
> 
> On Tue 18 Jan 2022 at 11:09, Yu Tu <yu.tu@amlogic.com> wrote:
> 
>> The UART_REG5 register defaults to 0. The console port is set in
>> ROMCODE. But other UART ports default to 0, so make bit24 and
>> bit[26,27] writable so that the UART can choose a more
>> appropriate clock.
> 
> Suggestion: Instead of talking bits (which is a bit cryptic) tell us
> what is actually does
> 
> Something like:
>   Make the internal clock source mux and divider writeable, allowing the
>   uart to deviate from the settings intially applied by the ROMCode and
>   using the most appropriate clocks
> 
Your description is better, I will follow your suggestion in the next 
edition.
>>
>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>> ---
>>   drivers/tty/serial/meson_uart.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
>> index 92fa91c825e6..4e7b2b38ab0a 100644
>> --- a/drivers/tty/serial/meson_uart.c
>> +++ b/drivers/tty/serial/meson_uart.c
>> @@ -678,7 +678,7 @@ static int meson_uart_probe_clocks(struct uart_port *port)
>>   							CLK_SET_RATE_NO_REPARENT,
>>   							port->membase + AML_UART_REG5,
>>   							26, 2,
>> -							CLK_DIVIDER_READ_ONLY,
>> +							CLK_DIVIDER_ROUND_CLOSEST,
>>   							xtal_div_table, NULL);
>>   		if (IS_ERR(hw))
>>   			return PTR_ERR(hw);
>> @@ -708,7 +708,7 @@ static int meson_uart_probe_clocks(struct uart_port *port)
>>   					CLK_SET_RATE_PARENT,
>>   					port->membase + AML_UART_REG5,
>>   					24, 0x1,
>> -					CLK_MUX_READ_ONLY,
>> +					CLK_MUX_ROUND_CLOSEST,
>>   					NULL, NULL);
>>   	if (IS_ERR(hw))
>>   		return PTR_ERR(hw);
> 
