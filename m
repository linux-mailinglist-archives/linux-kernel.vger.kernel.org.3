Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15705506716
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 10:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350093AbiDSIqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 04:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344219AbiDSIp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 04:45:59 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEB3DB0;
        Tue, 19 Apr 2022 01:43:16 -0700 (PDT)
Received: from [10.18.29.47] (10.18.29.47) by mail-sh.amlogic.com (10.18.11.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Tue, 19 Apr
 2022 16:43:13 +0800
Message-ID: <654f9cb8-5a88-3b96-8a2a-80ef7bb5eef9@amlogic.com>
Date:   Tue, 19 Apr 2022 16:43:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V2 1/2] tty: serial: meson: Add a 12MHz internal clock
 rate to calculate baud rate in order to meet the baud rate requirements of
 special BT modules
Content-Language: en-US
To:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220418053202.24528-1-yu.tu@amlogic.com>
 <20220418053202.24528-2-yu.tu@amlogic.com>
 <CAHp75VeW65dV9jJu8-yUWME+XKnaxZBu5Zv8iEJxP2dizA=HUg@mail.gmail.com>
 <d10e27ff-e674-87bd-2c98-63c7040baeb1@amlogic.com>
 <9af92c78-73a7-d524-182c-3ebffa69b08a@kernel.org>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <9af92c78-73a7-d524-182c-3ebffa69b08a@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.18.29.47]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,
	Thanks for the tip.

On 2022/4/19 15:38, Jiri Slaby wrote:
> [ EXTERNAL EMAIL ]
> 
> Hi,
> 
> On 19. 04. 22, 9:29, Yu Tu wrote:
>> Hi Andy,
>>      Thank you for your advice.
>>
>> On 2022/4/18 20:09, Andy Shevchenko wrote:
>>> [ EXTERNAL EMAIL ]
>>>
>>> On Mon, Apr 18, 2022 at 8:50 AM Yu Tu <yu.tu@amlogic.com> wrote:
>>>>
>>>> A /2 divider over XTAL was introduced since G12A, and is preferred
>>>> to be used over the still present /3 divider since it provides much
>>>> closer frequencies vs the request baudrate.Especially the BT module
>>>
>>> 'e. E' (mind the space)
>> My statement is a whole. There should be no spaces.
> 
> Period should be followed by a space, of course.
I got it .This will be corrected in the next version.

> 
>>>> uses 3Mhz baud rate. 8Mhz calculations can lead to baud rate bias,
>>>> causing some problems.
>>>
>>> ...
>>>
>>>> +struct meson_uart_data {
>>>> +       bool has_xtal_div2;
>>>
>>> I would prefer to see this as an unsigned int and with a less
>>> particular name, e.g. xtal_div would suffice.
>> I don't have a problem with your suggestion.Let's see What Neil has to 
>> say.
> 
> Actually why uint provided it's a boolean value? Or do you mean to store 
> the divisor directly in this member, Andy?
> 
> thanks,
