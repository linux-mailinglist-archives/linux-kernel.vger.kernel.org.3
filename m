Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D34532709
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 12:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235994AbiEXKDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 06:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235971AbiEXKDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 06:03:38 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83177220D;
        Tue, 24 May 2022 03:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653386616; x=1684922616;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=+lUhJq6lPcMXtDJjczyhfBhO0UQMN1XOtJ1PSE9n+js=;
  b=nHhxwpFsqoTXaiuMpIECOJYV3FbzRpKCH+HjhpyijUWhLecWCkMIGiYp
   Kkzf/d0oJ0fufpRtp55b9tnf+vNEyqK263kX7dQL2bp8raNECF1mSITrd
   G/rRrEYnZHAJD/Tuvc2T2YiSsnYC0Kc5xxCmdvXWl9lgWa9F+reasZi/a
   0=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 24 May 2022 03:03:36 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 03:03:36 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 24 May 2022 03:03:36 -0700
Received: from [10.79.43.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 24 May
 2022 03:03:33 -0700
Subject: Re: [PATCH 2/2 V2] remoteproc: qcom: Add full coredump fallback
 mechanism
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     Yogesh Lal <quic_ylal@quicinc.com>, <bjorn.andersson@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Siddharth Gupta <sidgup@codeaurora.org>
References: <1652181930-22212-1-git-send-email-quic_ylal@quicinc.com>
 <1652181930-22212-2-git-send-email-quic_ylal@quicinc.com>
 <271132da-4a6a-afd9-4509-47035dd18a8e@quicinc.com>
Message-ID: <b581789c-2c0c-b06e-924b-002b32f1a52a@quicinc.com>
Date:   Tue, 24 May 2022 15:33:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <271132da-4a6a-afd9-4509-47035dd18a8e@quicinc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/21/22 11:44 AM, Sibi Sankar wrote:
> Hey Yogesh,
> Looks like you missed adding the patch that uses the exported
> rproc_cleanup api.
> 
> 
> On 5/10/22 4:55 PM, Yogesh Lal wrote:
>> From: Siddharth Gupta <sidgup@codeaurora.org>
>>
>> If a remoteproc's firmware does not support minidump but the driver
>> adds an ID, the minidump driver does not collect any coredumps when
>> the remoteproc crashes. This hinders the purpose of coredump
>> collection. This change adds a fallback mechanism in the event of a
>> crash.
>>
> 
> Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>
> 
>> Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>
>> Signed-off-by: Yogesh Lal <quic_ylal@quicinc.com>
>> ---
>>   drivers/remoteproc/qcom_common.c   | 7 +++++--
>>   drivers/remoteproc/qcom_q6v5_pas.c | 1 +
>>   2 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/remoteproc/qcom_common.c 
>> b/drivers/remoteproc/qcom_common.c
>> index 4b91e3c..b3fdc66 100644
>> --- a/drivers/remoteproc/qcom_common.c
>> +++ b/drivers/remoteproc/qcom_common.c
>> @@ -163,8 +163,11 @@ void qcom_minidump(struct rproc *rproc, unsigned 
>> int minidump_id)
>>        */
>>       if (subsystem->regions_baseptr == 0 ||
>>           le32_to_cpu(subsystem->status) != 1 ||
>> -        le32_to_cpu(subsystem->enabled) != MD_SS_ENABLED ||
>> -        le32_to_cpu(subsystem->encryption_status) != MD_SS_ENCR_DONE) {
>> +        le32_to_cpu(subsystem->enabled) != MD_SS_ENABLED) {
>> +        return rproc_coredump(rproc);
>> +    }
>> +
>> +    if (le32_to_cpu(subsystem->encryption_status) != MD_SS_ENCR_DONE) {
>>           dev_err(&rproc->dev, "Minidump not ready, skipping\n");
>>           return;
>>       }

Yogesh,

  /**

   * Clear out the dump segments populated by parse_fw before

   * re-populating them with minidump segments.

   */
   rproc_coredump_cleanup(rproc);

You'll still need to cleanup segments populated by parse_fw
before you move onto to minidumps.

>> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c 
>> b/drivers/remoteproc/qcom_q6v5_pas.c
>> index 401b1ec..6e5cbca 100644
>> --- a/drivers/remoteproc/qcom_q6v5_pas.c
>> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
>> @@ -274,6 +274,7 @@ static const struct rproc_ops adsp_minidump_ops = {
>>       .start = adsp_start,
>>       .stop = adsp_stop,
>>       .da_to_va = adsp_da_to_va,
>> +    .parse_fw = qcom_register_dump_segments,
>>       .load = adsp_load,
>>       .panic = adsp_panic,
>>       .coredump = adsp_minidump,
>>
