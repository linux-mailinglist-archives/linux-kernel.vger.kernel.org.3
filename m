Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEA74C85A6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 08:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbiCAH6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 02:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbiCAH6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 02:58:42 -0500
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366A850B21;
        Mon, 28 Feb 2022 23:58:01 -0800 (PST)
Received: from [10.18.29.173] (10.18.29.173) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Tue, 1 Mar
 2022 15:57:57 +0800
Message-ID: <154c3e60-f111-6760-aa08-b9851d66b034@amlogic.com>
Date:   Tue, 1 Mar 2022 15:57:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH V7 0/6] Use CCF to describe the UART baud rate clock
Content-Language: en-US
To:     Neil Armstrong <narmstrong@baylibre.com>,
        <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220225073922.3947-1-yu.tu@amlogic.com>
 <849a95fd-ae81-9a3b-0c06-dd7826af9eb2@baylibre.com>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <849a95fd-ae81-9a3b-0c06-dd7826af9eb2@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Neil,

On 2022/3/1 15:25, Neil Armstrong wrote:
> [ EXTERNAL EMAIL ]
> 
> Hi,
> 
> Le 25/02/2022 à 08:39, Yu Tu a écrit :
>> Using the common Clock code to describe the UART baud rate
>> clock makes it easier for the UART driver to be compatible
>> with the baud rate requirements of the UART IP on different
>> meson chips. Add Meson S4 SoC compatible.
>>
>> The test method:
>> Start the console and run the following commands in turn:
>> stty -F /dev/ttyAML0 115200 and stty -F /dev/ttyAML0 921600.
>>
>> Since most SoCs are too old, I was able to find all the platforms myself
>> such as Meson6, Meson8, Meson8b, GXL and so on. I only tested it with
>> G12A and S4.
>>
>> Yu Tu (6):
>>    tty: serial: meson: Move request the register region to probe
>>    tty: serial: meson: Use devm_ioremap_resource to get register mapped
>>      memory
>>    tty: serial: meson: Describes the calculation of the UART baud rate
>>      clock using a clock frame
>>    tty: serial: meson: Make some bit of the REG5 register writable
>>    tty: serial: meson: The system stuck when you run the stty command on
>>      the console to change the baud rate
>>    tty: serial: meson: Added S4 SOC compatibility
>>
>> V6 -> V7: To solve the system stuck when you run the stty command on
>> the console to change the baud rate.
>> V5 -> V6: Change error format as discussed in the email.
>> V4 -> V5: Change error format.
>> V3 -> V4: Change CCF to describe the UART baud rate clock as discussed
>> in the email.
>> V2 -> V3: add compatible = "amlogic,meson-gx-uart". Because it must 
>> change
>> the DTS before it can be deleted
>> V1 -> V2: Use CCF to describe the UART baud rate clock.Make some 
>> changes as
>> discussed in the email
>>
>> Link:https://lore.kernel.org/linux-amlogic/20220118030911.12815-4-yu.tu@amlogic.com/ 
>>
>>
>>   drivers/tty/serial/meson_uart.c | 221 ++++++++++++++++++++++----------
>>   1 file changed, 154 insertions(+), 67 deletions(-)
>>
>>
>> base-commit: a603ca60cebff8589882427a67f870ed946b3fc8
> 
> Could you send the emails To Kevin, Jerome, Martin & me, and put the 
> various lists in CC instead ? otherwise we are not notified when the 
> patch is accepted by the tty maintainer.
The fact is that sending is adding you up, you see
Link: 
https://lore.kernel.org/linux-amlogic/20220225073922.3947-1-yu.tu@amlogic.com/
> 
> Thanks,
> Neil
> 
