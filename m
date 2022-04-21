Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F67509CA8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387835AbiDUJtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387833AbiDUJtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:49:01 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE9327B32;
        Thu, 21 Apr 2022 02:46:11 -0700 (PDT)
Received: from [10.18.29.47] (10.18.29.47) by mail-sh.amlogic.com (10.18.11.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Thu, 21 Apr
 2022 17:46:08 +0800
Message-ID: <b6067d55-4800-b533-2ec7-02166977c825@amlogic.com>
Date:   Thu, 21 Apr 2022 17:46:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V2 1/2] tty: serial: meson: Add a 12MHz internal clock
 rate to calculate baud rate in order to meet the baud rate requirements of
 special BT modules
Content-Language: en-US
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220418053202.24528-1-yu.tu@amlogic.com>
 <20220418053202.24528-2-yu.tu@amlogic.com>
 <CAHp75VeW65dV9jJu8-yUWME+XKnaxZBu5Zv8iEJxP2dizA=HUg@mail.gmail.com>
 <ea86eee0-409c-2d19-3669-35a8eaded53e@baylibre.com>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <ea86eee0-409c-2d19-3669-35a8eaded53e@baylibre.com>
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

Hi Neil,

On 2022/4/21 16:46, Neil Armstrong wrote:
> [ EXTERNAL EMAIL ]
> 
> Hi Andy,
> 
> On 18/04/2022 14:09, Andy Shevchenko wrote:
>> On Mon, Apr 18, 2022 at 8:50 AM Yu Tu <yu.tu@amlogic.com> wrote:
>>>
>>> A /2 divider over XTAL was introduced since G12A, and is preferred
>>> to be used over the still present /3 divider since it provides much
>>> closer frequencies vs the request baudrate.Especially the BT module
>>
>> 'e. E' (mind the space)
>>
>>> uses 3Mhz baud rate. 8Mhz calculations can lead to baud rate bias,
>>> causing some problems.
>>
>> ...
>>
>>> +struct meson_uart_data {
>>> +       bool has_xtal_div2;
>>
>> I would prefer to see this as an unsigned int and with a less
>> particular name, e.g. xtal_div would suffice.
>>
>>> +};
>>
>> ...
>>
>>> +               unsigned int xtal_div = 3;
>>
>>> +               if (private_data && private_data->has_xtal_div2) {
>>> +                       xtal_div = 2;
>>
>> Better to define privata data always
> 
> While I'm in favor of defining private data, here 3 and 2 are actually 
> the values
> 2 and 3 used to divide.
> 
> The code is easy to read and we quickly understand this value is the 
> clock divider.
> 
Therefore, this place should be modified according to your previous 
suggestion.I will prepare the next version.
>>
>>
>>> +                       val |= AML_UART_BAUD_XTAL_DIV2;
>>> +               }
>>> +               val |= DIV_ROUND_CLOSEST(port->uartclk / xtal_div, 
>>> baud) - 1;
>>
>>
> 
> .
