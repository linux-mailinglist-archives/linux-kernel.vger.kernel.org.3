Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBC250FAD5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239196AbiDZKfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349158AbiDZKfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:35:21 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7523CBC0C;
        Tue, 26 Apr 2022 03:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650968154; x=1682504154;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ED9E86mWaIi1Q6en5l7HRo4ItpanEZ0wiCJUj9mkLTE=;
  b=rpMHai2H4YFP3BRCQlPmaEf6Y6Hsqp+hK1g89J2CNJcTGW0vZROEfVmM
   2B37wM/yee9D4FKMdDZk4s2hyMk12KwITYE7yKcQFPRcbsoQ+Z0VCJugA
   gTR26YAgXlLY100hJEL9B0rnF6Qzt0XbpsmelVzddgCgs1ZyG7FjpK5QD
   A=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 26 Apr 2022 03:15:51 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 03:15:51 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 26 Apr 2022 03:15:51 -0700
Received: from [10.216.37.34] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 26 Apr
 2022 03:15:47 -0700
Message-ID: <7a9fb53f-61a8-0e1e-decf-60629be0a478@quicinc.com>
Date:   Tue, 26 Apr 2022 15:45:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] remoteproc: qcom: Add fallback mechanism for full
 coredump collection
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     "Sibi Sankar (QUIC)" <quic_sibis@quicinc.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1649269662-20338-1-git-send-email-quic_ylal@quicinc.com>
 <YmLIMG62vPv4qtVe@builder.lan>
From:   Yogesh Lal <quic_ylal@quicinc.com>
In-Reply-To: <YmLIMG62vPv4qtVe@builder.lan>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/22/2022 8:52 PM, Bjorn Andersson wrote:
> WARNING: This email originated from outside of Qualcomm. Please be wary of any links or attachments, and do not enable macros.
>
> On Wed 06 Apr 13:27 CDT 2022, Yogesh Lal wrote:
>
>> In case remoteproc's firmware missing minidump support, during crash
>> scenario coredump does not collected. This change adds a fallback
>> mechanism for full coredump collection in the event of a crash.
>>
>> Signed-off-by: Yogesh Lal <quic_ylal@quicinc.com>
>> ---
>>   drivers/remoteproc/qcom_common.c   | 11 ++++++++---
>>   drivers/remoteproc/qcom_q6v5_pas.c |  1 +
>>   2 files changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
>> index 4b91e3c..68bd0bc 100644
>> --- a/drivers/remoteproc/qcom_common.c
>> +++ b/drivers/remoteproc/qcom_common.c
>> @@ -162,13 +162,18 @@ void qcom_minidump(struct rproc *rproc, unsigned int minidump_id)
>>         * is initialized in memory and encryption status is set.
>>         */
>>        if (subsystem->regions_baseptr == 0 ||
>> -         le32_to_cpu(subsystem->status) != 1 ||
>> -         le32_to_cpu(subsystem->enabled) != MD_SS_ENABLED ||
>> -         le32_to_cpu(subsystem->encryption_status) != MD_SS_ENCR_DONE) {
>> +             le32_to_cpu(subsystem->status) != 1 ||
>> +             le32_to_cpu(subsystem->enabled) != MD_SS_ENABLED) {
>> +                     return rproc_coredump(rproc);
>> +             }
>> +
>> +     if (le32_to_cpu(subsystem->encryption_status) != MD_SS_ENCR_DONE) {
>>                dev_err(&rproc->dev, "Minidump not ready, skipping\n");
>>                return;
>>        }
>>
>> +     rproc_coredump_cleanup(rproc);
> The patch looks good, but could you please explain in the commit message
> why this needs to be added? If the thing described in the message
> happens this code path wouldn't be taken.
>
> Should it be a separate patch, or is it needed because of the fallback
> etc?
>
> Thanks,
> Bjorn

Will push separate patch for it.

Thanks

Yogesh Lal


>> +
>>        ret = qcom_add_minidump_segments(rproc, subsystem);
>>        if (ret) {
>>                dev_err(&rproc->dev, "Failed with error: %d while adding minidump entries\n", ret);
>> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
>> index 1ae47cc..40bf747 100644
>> --- a/drivers/remoteproc/qcom_q6v5_pas.c
>> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
>> @@ -293,6 +293,7 @@ static const struct rproc_ops adsp_minidump_ops = {
>>        .start = adsp_start,
>>        .stop = adsp_stop,
>>        .da_to_va = adsp_da_to_va,
>> +     .parse_fw = qcom_register_dump_segments,
>>        .load = adsp_load,
>>        .panic = adsp_panic,
>>        .coredump = adsp_minidump,
>> --
>> 2.7.4
>>
