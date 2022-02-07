Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447104AC297
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 16:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357484AbiBGPIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 10:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442374AbiBGOto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:49:44 -0500
X-Greylist: delayed 904 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 06:49:43 PST
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D86C0401C1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 06:49:43 -0800 (PST)
Received: from [192.168.0.105] (101.228.68.195) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Mon, 7 Feb
 2022 22:19:33 +0800
Message-ID: <ad0493ac-af20-f207-9333-561042d7fc49@amlogic.com>
Date:   Mon, 7 Feb 2022 22:19:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH V6 0/5] Use CCF to describe the UART baud rate clock
Content-Language: en-US
To:     Kevin Hilman <khilman@baylibre.com>,
        <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "Jerome Brunet" <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220118030911.12815-1-yu.tu@amlogic.com>
 <7hfspjqrn7.fsf@baylibre.com>
 <cc3b971f-c630-4ce2-e6dd-c13bcba89d22@amlogic.com>
 <7hbl00ykhf.fsf@baylibre.com>
From:   Yu Tu <yu.tu@amlogic.com>
In-Reply-To: <7hbl00ykhf.fsf@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [101.228.68.195]
X-ClientProxiedBy: mail-sh.amlogic.com (10.18.11.5) To mail-sh.amlogic.com
 (10.18.11.5)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi Kevin,
	First of all,thank you very much for your reply.Due to the Chinese 
Spring Festival holiday recently, so i just reply to you now。

On 2022/1/25 3:58, Kevin Hilman wrote:
> [ EXTERNAL EMAIL ]
> 
> Yu Tu <yu.tu@amlogic.com> writes:
> 
>> Hi Kevin,
>> 	Thank you very much for your reply.
>>
>> On 2022/1/20 6:37, Kevin Hilman wrote:
>>> [ EXTERNAL EMAIL ]
>>>
>>> Hello,
>>>
>>> Yu Tu <yu.tu@amlogic.com> writes:
>>>
>>>> Using the common Clock code to describe the UART baud rate
>>>> clock makes it easier for the UART driver to be compatible
>>>> with the baud rate requirements of the UART IP on different
>>>> meson chips. Add Meson S4 SoC compatible.
>>>
>>> Could you describe how this was tested and on which SoCs?  There seem to
>>> be some changes in this series that might affect previous SoCs.
>>>
>> For me, the board starts normally and prints. My intention was to add
>> the S4 SOC UART compatible, but for the S4 our baud rate clock is
>> calculated at 12MHz by default.So a series of changes were made at your
>> suggestion.
>>
>> Since most SoCs are too old, I was able to find all the platforms myself
>> such as Meson6, Meson8, Meson8b, GXL and so on. I only tested it with
>> G12A and S4.But when I talked to Martin earlier he tried meson8b's log.
>> The test patch is in the attachment.
>>
>> I have found that on some boards with this change, the initcall_debug
>> Uart driver takes longer to initialize. Running the stty command to
>> change the baud rate at the same time may cause a jam.
> 
> This kind of detail is important to document in the cover letter,
> including a bit more detail on how to reproduce so that other can help
> test or may have ideas for how to solve.
> 
The problem recurrence method is described below:
First, add the patch I changed. It then launches normally to the console 
command line.  Finally, run the stty command to change buad rate. The 
detailed commands are as follows:
stty -F /dev/ttyAML0 115200 and stty -F /dev/ttyAML0 921600 .Alternate 
execution can reproduce.

>> I'd love to know what else you suggest.
> 
> I don't expect you to be able to test on all SoCs, but just to list what
> SoCs and which boards you tested on.  This way, those who have other
> boards can help test and we can have a better idea of how this was
> tested before merging.
> 
I only have S4 and G12A so far, so I've only tested on those two platforms.

> Thanks,
> 
> Kevin
> 
