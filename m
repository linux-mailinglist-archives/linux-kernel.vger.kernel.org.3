Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBAD53BBBA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 17:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236538AbiFBPml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 11:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236515AbiFBPmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 11:42:40 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5989B27623C;
        Thu,  2 Jun 2022 08:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654184559; x=1685720559;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dHXkcn+vdeBtOzMm0MELukXq9yPGsPhdHl1IklX7ohk=;
  b=Rk+xjUM+v9sVwqmueaT8orb/8VmNQKis4QsFVGypBE9rwAOAf+MHMtxo
   N3iMiub4U4oB9MDiQ74ReEZIumK0juVpDHA5/DhJRxmPWBJpBf+aIHZuC
   S7B8FiHXBsjQRP8onmz09D4XK+xYIG0kGY2cNr3B+iK1Pf2joNMJLAnGZ
   k=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 02 Jun 2022 08:42:38 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 08:42:37 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 2 Jun 2022 08:42:37 -0700
Received: from [10.216.8.63] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 2 Jun 2022
 08:42:34 -0700
Message-ID: <cb802fb1-d0b8-68af-1c04-f73bc1beca77@quicinc.com>
Date:   Thu, 2 Jun 2022 21:12:31 +0530
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
 <ff029402-f90c-096a-7366-b58f53555ace@quicinc.com>
 <fb44af37-daf7-974d-95fe-1a6c2cdab676@samsung.com>
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
In-Reply-To: <fb44af37-daf7-974d-95fe-1a6c2cdab676@samsung.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 6/2/2022 3:55 AM, Marek Szyprowski wrote:
> Hi,
>
> On 01.06.2022 13:24, Vijaya Krishna Nivarthi wrote:
>> On 5/24/2022 5:24 PM, Marek Szyprowski wrote:
>>> On 23.05.2022 23:32, Marek Szyprowski wrote:
>>>> Hi,
>>>>
>>>> On 16.05.2022 11:20, Vijaya Krishna Nivarthi wrote:
>>>>> For the case of console_suspend disabled, if back to back
>>>>> suspend/resume
>>>>> test is executed, at the end of test, sometimes console would
>>>>> appear to
>>>>> be frozen not responding to input. This would happen because, during
>>>>> resume, rx transactions can come in before system is ready,
>>>>> malfunction
>>>>> of rx happens in turn resulting in console appearing to be stuck.
>>>>>
>>>>> Do a stop_rx in suspend sequence to prevent this.
>>>>>
>>>>> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
>>>>> ---
>>>>> v4: moved the change to serial core to apply for all drivers
>>>>> v3: swapped the order of conditions to be more human readable
>>>>> v2: restricted patch to contain only stop_rx in suspend sequence
>>>>> v1: intial patch contained 2 additional unrelated changes in vicinity
>>>>> ---
>>>> This patch landed recently in linux-next as commit c9d2325cdb92
>>>> ("serial: core: Do stop_rx in suspend path for console if
>>>> console_suspend is disabled").
>>>>
>>>> Unfortunately it breaks console operation on my test systems after
>>>> system suspend/resume cycle if 'no_console_suspend' kernel parameter
>>>> is present. System properly resumes from suspend, the console displays
>>>> all the messages and even command line prompt, but then doesn't react
>>>> on any input. If I remove the 'no_console_suspend' parameter, the
>>>> console is again operational after system suspend/resume cycle. Before
>>>> this patch it worked fine regardless the 'no_console_suspend'
>>>> parameter.
>>>>
>>>> If this matters, the test system is ARM 32bit Samsung Exynos5422-based
>>>> Odroid XU3lite board.
>>> One more information. This issue can be easily reproduced with QEMU. It
>>> happens both on ARM 32bit and ARM 64bit QEMU's 'virt' machines when
>>> 'no_console_suspend' is added to kernel's cmdline.
>>>
>> Ideally, as comments indicate, the set_termios should have done
>> stop_rx at begin and start_rx at end to take care of this issue.
>>
>> This is probably missing in your driver. Can we check if this can be
>> fixed?
> Sure, just point me what need to be added in amba-pl011.c and
> samsung_tty.c. I've briefly compared the suspend/resume paths of those
> drivers with other drivers and I don't see anything missing there.
>
>> OR other option is
>>
>> Add a start_rx in uart_resume_port after call to set_termios to handle
>> this scenario for other drivers.
>>
>> Please let me know if there are any concerns for this options.
> IMHO this looks like an issue that affects lots of drivers and it should
> be handled in the core.

Sure, we will look into both aspects and get back as soon as possible.

Thank you.

>
>   > ...
>
> Best regards
