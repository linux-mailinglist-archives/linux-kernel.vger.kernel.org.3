Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157C4513A97
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 19:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350435AbiD1REP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 13:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350474AbiD1REB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 13:04:01 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33020AAE20;
        Thu, 28 Apr 2022 10:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651165246; x=1682701246;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EuQcZti+hxcKWsdT48NjbY/CPsSbRARHXUDJm9hZezw=;
  b=EZJ/wk+dswjWtR+YVnfXSehY0EqzMWWFe80guDvgFJKkXc/wZJCUkTDb
   S+dMbA1qDETLsaR/P0w3G2LVDce/lhmDCvnPvHUgIsP1qMtKz/eAxYNJB
   VT6IyC0w3iAdQowen8P/YOE8/NZ4dHMwK9mfb6Hz+VBHWEo1svLhMTl8J
   Q=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 28 Apr 2022 10:00:46 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 10:00:45 -0700
Received: from [10.110.12.199] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 28 Apr
 2022 10:00:44 -0700
Message-ID: <a2d1bd9f-2bb4-bea9-f59a-08d91db5572a@quicinc.com>
Date:   Thu, 28 Apr 2022 10:00:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCHv12 8/9] serial: qcom_geni_serial: Disable MMIO tracing for
 geni serial
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>, <arnd@arndb.de>,
        <catalin.marinas@arm.com>, <rostedt@goodmis.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <maz@kernel.org>, <quic_psodagud@quicinc.com>, <will@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <cover.1651139070.git.quic_saipraka@quicinc.com>
 <3fef68a94e4947d58a199709929d30e0e2bf2e44.1651139070.git.quic_saipraka@quicinc.com>
 <Ympxa0ZY0VxZGEjA@kroah.com>
 <e11455d8-78c2-68e8-215e-a4e3587f3e4a@quicinc.com>
 <YmrFlce26p2uvtDZ@kroah.com>
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <YmrFlce26p2uvtDZ@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/2022 9:49 AM, Greg KH wrote:
> On Thu, Apr 28, 2022 at 09:31:43AM -0700, Trilok Soni wrote:
>> On 4/28/2022 3:50 AM, Greg KH wrote:
>>> On Thu, Apr 28, 2022 at 03:25:31PM +0530, Sai Prakash Ranjan wrote:
>>>> Disable MMIO tracing for geni serial driver as it is a high
>>>> frequency operation for serial driver with many register reads/
>>>> writes and not very useful to log all MMIO traces and prevent
>>>> excessive logging.
>>>>
>>>> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
>>>> Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
>>>> ---
>>>>    drivers/tty/serial/qcom_geni_serial.c | 8 +++++++-
>>>>    1 file changed, 7 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
>>>> index 1543a6028856..5b48e6c2bf3c 100644
>>>> --- a/drivers/tty/serial/qcom_geni_serial.c
>>>> +++ b/drivers/tty/serial/qcom_geni_serial.c
>>>> @@ -1,5 +1,11 @@
>>>>    // SPDX-License-Identifier: GPL-2.0
>>>> -// Copyright (c) 2017-2018, The Linux foundation. All rights reserved.
>>>> +/*
>>>> + * Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
>>>> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
>>>> + */
>>>
>>> I strongly disagree that adding a single line here warrants a copyright
>>> update.  If your lawyers will sign off on this change, I am willing to
>>> reconsider.
>>
>> I am not a lawyer, we can skip adding QuIC copyright here since it is just
>> one line change, but at the same time we can't add 2022 year in the existing
>> copyright.
> 
> That is correct, because you are not making a copyrightable change,
> otherwise the single line addition would be ok.
> 
> Talk to your lawyers about this :)
> 
>> If that is fine, we can skip the copyright year update entirely.
> 
> Please do.
> 

Sai, please go ahead and remove QuIC copyright line here.

---Trilok Soni
