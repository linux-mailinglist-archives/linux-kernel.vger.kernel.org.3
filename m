Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E004C811D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 03:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbiCACoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 21:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbiCACob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 21:44:31 -0500
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5CD369E6;
        Mon, 28 Feb 2022 18:43:50 -0800 (PST)
Received: from [10.18.29.173] (10.18.29.173) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Tue, 1 Mar
 2022 10:43:48 +0800
Message-ID: <aa9c6622-4d3c-5bb8-ba25-d25b8b73a038@amlogic.com>
Date:   Tue, 1 Mar 2022 10:43:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH V3] tty: serial: meson: Fix the compile link error
 reported by kernel test robot
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
CC:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        kernel test robot <lkp@intel.com>
References: <20220228135530.6918-1-yu.tu@amlogic.com>
 <20220228142751.GF2812@kadam> <Yh09abhySKsjart4@kroah.com>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <Yh09abhySKsjart4@kroah.com>
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

Hi greg and dan,
	Thank you very much for your reply. I will make a separate submission 
as you suggested to fix Dan's suggestion.

On 2022/3/1 5:23, Greg Kroah-Hartman wrote:
> [ EXTERNAL EMAIL ]
> 
> On Mon, Feb 28, 2022 at 05:27:52PM +0300, Dan Carpenter wrote:
>> On Mon, Feb 28, 2022 at 09:55:30PM +0800, Yu Tu wrote:
>>> Describes the calculation of the UART baud rate clock using a clock
>>> frame. Forgot to add in Kconfig kernel test Robot compilation error
>>> due to COMMON_CLK dependency.
>>>
>>> Fixes: ("tty: serial:meson: Describes the calculation of the UART baud rate clock using a clock frame“)
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>>> ---
>>>   drivers/tty/serial/Kconfig      |  1 +
>>>   drivers/tty/serial/meson_uart.c | 37 +++++++++++++++++++++++----------
>>>   2 files changed, 27 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
>>> index e952ec5c7a7c..a0f2b82fc18b 100644
>>> --- a/drivers/tty/serial/Kconfig
>>> +++ b/drivers/tty/serial/Kconfig
>>> @@ -200,6 +200,7 @@ config SERIAL_KGDB_NMI
>>>   config SERIAL_MESON
>>>   	tristate "Meson serial port support"
>>>   	depends on ARCH_MESON || COMPILE_TEST
>>> +	depends on COMMON_CLK
>>>   	select SERIAL_CORE
>>>   	help
>>>   	  This enables the driver for the on-chip UARTs of the Amlogic
>>
>>
>> This is a link issue.  The rest is an unrelated error handling fix.
>> It should really be sent as two patches.
> 
> I'll take the first version of this patch, which just did this portion,
> and the rest can be an independant change.
> 
> thanks,
> 
> greg k-h
> 
