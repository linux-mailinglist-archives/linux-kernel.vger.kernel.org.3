Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7581B53A3F5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 13:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351199AbiFALZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 07:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352643AbiFALZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 07:25:01 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3FC4664A;
        Wed,  1 Jun 2022 04:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654082695; x=1685618695;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oU0TXYjoeSYGvAnbOhKPOk9x41DF16IWFxcwFwX4/jk=;
  b=BXXzCvkAVE+x1nrWk9cm8K/wneNJ905rcBpZiGet47nVQpErtLsJXMu1
   m6JD+3MgqSF/0jIGf3vUswoXXLtsBxCUzjeQkxOBnim2CS3ZTzq7Sof1u
   5HYl5NjclljtE+lR7Yx6Kz/IhUae5aTGJalB6Zmw4+B6Sl0lx3Se9eBbv
   8=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 01 Jun 2022 04:24:55 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 04:24:55 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 1 Jun 2022 04:24:54 -0700
Received: from [10.216.8.63] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 1 Jun 2022
 04:24:51 -0700
Message-ID: <ff029402-f90c-096a-7366-b58f53555ace@quicinc.com>
Date:   Wed, 1 Jun 2022 16:54:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [V4] serial: core: Do stop_rx in suspend path for console if
 console_suspend is disabled
Content-Language: en-CA
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_msavaliy@quicinc.com>, <dianders@chromium.org>,
        <mka@chromium.org>, <swboyd@chromium.org>
References: <1652692810-31148-1-git-send-email-quic_vnivarth@quicinc.com>
 <bf7eec57-6ad6-2c1a-ea61-0e1d06fc77f5@samsung.com>
 <CGME20220524115408eucas1p1ddda7aae4db0a65a7d67d6f8c59d404b@eucas1p1.samsung.com>
 <3866c083-0064-ac9a-4587-91a83946525d@samsung.com>
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
In-Reply-To: <3866c083-0064-ac9a-4587-91a83946525d@samsung.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/24/2022 5:24 PM, Marek Szyprowski wrote:
> On 23.05.2022 23:32, Marek Szyprowski wrote:
>> Hi,
>>
>> On 16.05.2022 11:20, Vijaya Krishna Nivarthi wrote:
>>> For the case of console_suspend disabled, if back to back suspend/resume
>>> test is executed, at the end of test, sometimes console would appear to
>>> be frozen not responding to input. This would happen because, during
>>> resume, rx transactions can come in before system is ready, malfunction
>>> of rx happens in turn resulting in console appearing to be stuck.
>>>
>>> Do a stop_rx in suspend sequence to prevent this.
>>>
>>> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
>>> ---
>>> v4: moved the change to serial core to apply for all drivers
>>> v3: swapped the order of conditions to be more human readable
>>> v2: restricted patch to contain only stop_rx in suspend sequence
>>> v1: intial patch contained 2 additional unrelated changes in vicinity
>>> ---
>> This patch landed recently in linux-next as commit c9d2325cdb92
>> ("serial: core: Do stop_rx in suspend path for console if
>> console_suspend is disabled").
>>
>> Unfortunately it breaks console operation on my test systems after
>> system suspend/resume cycle if 'no_console_suspend' kernel parameter
>> is present. System properly resumes from suspend, the console displays
>> all the messages and even command line prompt, but then doesn't react
>> on any input. If I remove the 'no_console_suspend' parameter, the
>> console is again operational after system suspend/resume cycle. Before
>> this patch it worked fine regardless the 'no_console_suspend' parameter.
>>
>> If this matters, the test system is ARM 32bit Samsung Exynos5422-based
>> Odroid XU3lite board.
>
> One more information. This issue can be easily reproduced with QEMU. It
> happens both on ARM 32bit and ARM 64bit QEMU's 'virt' machines when
> 'no_console_suspend' is added to kernel's cmdline.
>
Ideally, as comments indicate, the set_termios should have done stop_rx 
at begin and start_rx at end to take care of this issue.

This is probably missing in your driver. Can we check if this can be 
fixed? OR other option is

Add a start_rx in uart_resume_port after call to set_termios to handle 
this scenario for other drivers.

Please let me know if there are any concerns for this options.

>>>    drivers/tty/serial/serial_core.c | 11 +++++++++--
>>>    1 file changed, 9 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/tty/serial/serial_core.c
>>> b/drivers/tty/serial/serial_core.c
>>> index 82a1770..9a85b41 100644
>>> --- a/drivers/tty/serial/serial_core.c
>>> +++ b/drivers/tty/serial/serial_core.c
>>> @@ -2211,9 +2211,16 @@ int uart_suspend_port(struct uart_driver *drv,
>>> struct uart_port *uport)
>>>        }
>>>        put_device(tty_dev);
>>>    -    /* Nothing to do if the console is not suspending */
>>> -    if (!console_suspend_enabled && uart_console(uport))
>>> +    /*
>>> +     * Nothing to do if the console is not suspending
>>> +     * except stop_rx to prevent any asynchronous data
>>> +     * over RX line. Re-start_rx, when required, is
>>> +     * done by set_termios in resume sequence
>>> +     */
>>> +    if (!console_suspend_enabled && uart_console(uport)) {
>>> +        uport->ops->stop_rx(uport);
>>>            goto unlock;
>>> +    }
>>>          uport->suspended = 1;
>> Best regards
> Best regards
Thank you.
