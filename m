Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32385139E0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 18:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350069AbiD1QfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 12:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350065AbiD1QfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 12:35:03 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009257DE02;
        Thu, 28 Apr 2022 09:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651163509; x=1682699509;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IWjeCxTCtHM7X/VtwHEV8uloK8O55Amxh8Nwcutg5+0=;
  b=avzv8ta5vb2PbK3YUV+rTxCjSOEUZkVRclp8giAZflI+1QCtVw5DOII7
   fQKIQdNEhmNOV6P1qere4lzBZrZ7yR9t3S2fY6xERp1ik1+JnZB9QDrmE
   JdPiYXYI+CoEwOmQnN/VD62+CNI7M4Pg8SzI3eJiXbwE8eFMHsZRRfB5E
   c=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 28 Apr 2022 09:31:48 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 09:31:45 -0700
Received: from [10.110.12.199] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 28 Apr
 2022 09:31:44 -0700
Message-ID: <e11455d8-78c2-68e8-215e-a4e3587f3e4a@quicinc.com>
Date:   Thu, 28 Apr 2022 09:31:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCHv12 8/9] serial: qcom_geni_serial: Disable MMIO tracing for
 geni serial
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>
CC:     <arnd@arndb.de>, <catalin.marinas@arm.com>, <rostedt@goodmis.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <maz@kernel.org>, <quic_psodagud@quicinc.com>, <will@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <cover.1651139070.git.quic_saipraka@quicinc.com>
 <3fef68a94e4947d58a199709929d30e0e2bf2e44.1651139070.git.quic_saipraka@quicinc.com>
 <Ympxa0ZY0VxZGEjA@kroah.com>
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <Ympxa0ZY0VxZGEjA@kroah.com>
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

On 4/28/2022 3:50 AM, Greg KH wrote:
> On Thu, Apr 28, 2022 at 03:25:31PM +0530, Sai Prakash Ranjan wrote:
>> Disable MMIO tracing for geni serial driver as it is a high
>> frequency operation for serial driver with many register reads/
>> writes and not very useful to log all MMIO traces and prevent
>> excessive logging.
>>
>> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
>> Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
>> ---
>>   drivers/tty/serial/qcom_geni_serial.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
>> index 1543a6028856..5b48e6c2bf3c 100644
>> --- a/drivers/tty/serial/qcom_geni_serial.c
>> +++ b/drivers/tty/serial/qcom_geni_serial.c
>> @@ -1,5 +1,11 @@
>>   // SPDX-License-Identifier: GPL-2.0
>> -// Copyright (c) 2017-2018, The Linux foundation. All rights reserved.
>> +/*
>> + * Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
> 
> I strongly disagree that adding a single line here warrants a copyright
> update.  If your lawyers will sign off on this change, I am willing to
> reconsider.

I am not a lawyer, we can skip adding QuIC copyright here since it is 
just one line change, but at the same time we can't add 2022 year in the 
existing copyright. If that is fine, we can skip the copyright year 
update entirely.

---Trilok Soni
