Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49BF514A85
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 15:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359798AbiD2NdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 09:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347736AbiD2NdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 09:33:17 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2B761612;
        Fri, 29 Apr 2022 06:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651238999; x=1682774999;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Btlb4CgDcjwJRkvMOtx4nRpvsq3KlJpwPzQzTvO4w5A=;
  b=LjZuKR0mlBMz9t/Day16yvgV7GMZrm4UhDstX6/Wlt0UnFo0FUTZqM4J
   TN6+SJSwd8mnbqRlpFOpo6hSocDY4oduT2r5zv4eb+GyXgwh6ZgVRHyds
   X8Ew6tgQO8WKduBLUUSYaQOvPVs1zOywUu1kkOwFocJsbVbT10YGeGIQm
   s=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 29 Apr 2022 06:29:59 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 06:29:58 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 29 Apr 2022 06:29:58 -0700
Received: from [10.50.11.55] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 29 Apr
 2022 06:29:52 -0700
Message-ID: <498791a7-cc9c-536a-0859-b03a332dc922@quicinc.com>
Date:   Fri, 29 Apr 2022 18:59:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCHv13 9/9] soc: qcom: geni: Disable MMIO tracing for GENI SE
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <arnd@arndb.de>, <catalin.marinas@arm.com>,
        <gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <maz@kernel.org>, <quic_psodagud@quicinc.com>,
        <quic_tsoni@quicinc.com>, <will@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <cover.1651149615.git.quic_saipraka@quicinc.com>
 <3b2fb1e02f7a9836b2388b9f2ce2184c5a0cd444.1651149615.git.quic_saipraka@quicinc.com>
 <20220428092959.175b48ae@gandalf.local.home>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <20220428092959.175b48ae@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On 4/28/2022 6:59 PM, Steven Rostedt wrote:
> On Thu, 28 Apr 2022 18:14:12 +0530
> Sai Prakash Ranjan <quic_saipraka@quicinc.com> wrote:
>
>> Disable MMIO tracing for geni serial engine driver as it is a
>> high frequency operation with many register reads/writes and
>> not very useful to log all MMIO traces and prevent excessive
>> logging.
> This states what it does but does not really state why. Are you using MMIO
> tracing in other locations and this is causing too much noise?
> What is the real issue. Just saying "excessive logging" is not sufficient.
> That would be a reason to disable function tracing ;-)
>
> -- Steve
>

Disabling MMIO trace is what it does and why it does is to prevent excessive logging.
I will add more details on why preventing excessive logging is required here.

It is quite known that any access over serial console would involve a lot of TX and RX
register accesses (and few others), so these MMIO read/write trace events in these
drivers cause a lot of unwanted noise because of the high frequency of such operations
and is not very useful tracing these events for such driver. And we want to enable these
trace events on development devices(maybe not production devices) where performance
also really matters since we want to debug and track any crashes with such register
accesses on these devices and not just something which runs with every debug option
out there (meaning we enable this MMIO tracing with almost on par production kernels).
And these traces of such driver add additional overhead both in terms of memory and
CPU cycles.

And also one more reason is that if we try to display trace buffer containing these register
trace events onto serial console, then it would also involve register accesses from these
drivers which would lead to recursive tracing.

I will update the commit text adding these details and since we got your attention, can you
also please look at patch 5 [1] which was updated based on your previous review comments.
If you could review/ack them, then Arnd can take this series into his tree once I post the next
version with these updated commit text.

[1] https://lore.kernel.org/lkml/9827bae40f6f319f294d06859c9e3c7442f067f2.1651149615.git.quic_saipraka@quicinc.com/

Thanks,
Sai

>> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
>> Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
>> ---
>>   drivers/soc/qcom/qcom-geni-se.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
>> index 28a8c0dda66c..a0ceeede450f 100644
>> --- a/drivers/soc/qcom/qcom-geni-se.c
>> +++ b/drivers/soc/qcom/qcom-geni-se.c
>> @@ -1,6 +1,9 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>   // Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
>>   
>> +/* Disable MMIO tracing to prevent excessive logging of unwanted MMIO traces */
>> +#define __DISABLE_TRACE_MMIO__
>> +
>>   #include <linux/acpi.h>
>>   #include <linux/clk.h>
>>   #include <linux/slab.h>

