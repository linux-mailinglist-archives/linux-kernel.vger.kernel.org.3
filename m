Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09269566A42
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 13:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbiGELx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 07:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbiGELxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:53:31 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD08BF51;
        Tue,  5 Jul 2022 04:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657022010; x=1688558010;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=t0jdRRxvBRqLaphgAV4C75lY4+jAufKtnXYqkuwxxi8=;
  b=fFLIzI2kIIoofweoDoz6up5pUKnLdfq0yvJPv+fIW0nOIHBRQQuegEC8
   3BaKIGe+e9oJUNXjr6fxSIaILtNgsSPG7pNxrNq3dypCAteDcQHGoiYLE
   lC120GxLobXP6ekMejWTJWJwygHewyXfruTG0zPpdIKyE95ZhLaIiViYm
   I=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 05 Jul 2022 04:53:30 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 04:53:30 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 5 Jul 2022 04:53:29 -0700
Received: from [10.79.43.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 5 Jul 2022
 04:53:27 -0700
Subject: Re: [PATCH] remoteproc: qcom: pas: Add decrypt shutdown support for
 modem
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <dmitry.baryshkov@linaro.org>, <agross@kernel.org>,
        <mathieu.poirier@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1653031684-14771-1-git-send-email-quic_sibis@quicinc.com>
 <Yr35Q2G8NNvYaI8M@builder.lan>
From:   Sibi Sankar <quic_sibis@quicinc.com>
Message-ID: <a4373b5d-fd01-9692-2660-792b5b84d08c@quicinc.com>
Date:   Tue, 5 Jul 2022 17:23:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <Yr35Q2G8NNvYaI8M@builder.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Bjorn,
Thanks for taking time to review the series.

On 7/1/22 12:58 AM, Bjorn Andersson wrote:
> On Fri 20 May 02:28 CDT 2022, Sibi Sankar wrote:
> 
>> The initial shutdown request to modem on SM8450 SoCs would start the
>> decryption process and will keep returning errors until the modem shutdown
>> is complete. Fix this by retrying shutdowns in fixed intervals.
>>
>> Err Logs on modem shutdown:
>> qcom_q6v5_pas 4080000.remoteproc: failed to shutdown: -22
>> remoteproc remoteproc3: can't stop rproc: -22
>>
>> Fixes: 5cef9b48458d ("remoteproc: qcom: pas: Add SM8450 remoteproc support")
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> 
> Looks reasonable, just two inquiries below.
> 
>> ---
>>   drivers/remoteproc/qcom_q6v5_pas.c | 67 +++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 66 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
>> index 6ae39c5653b1..d04c4b877e12 100644
>> --- a/drivers/remoteproc/qcom_q6v5_pas.c
>> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
>> @@ -8,6 +8,7 @@
>>    */
>>   
>>   #include <linux/clk.h>
>> +#include <linux/delay.h>
>>   #include <linux/firmware.h>
>>   #include <linux/interrupt.h>
>>   #include <linux/kernel.h>
>> @@ -29,6 +30,8 @@
>>   #include "qcom_q6v5.h"
>>   #include "remoteproc_internal.h"
>>   
>> +#define ADSP_DECRYPT_SHUTDOWN_DELAY_MS	100
>> +
>>   struct adsp_data {
>>   	int crash_reason_smem;
>>   	const char *firmware_name;
>> @@ -36,6 +39,7 @@ struct adsp_data {
>>   	unsigned int minidump_id;
>>   	bool has_aggre2_clk;
>>   	bool auto_boot;
>> +	bool decrypt_shutdown;
>>   
>>   	char **proxy_pd_names;
>>   
>> @@ -65,6 +69,7 @@ struct qcom_adsp {
>>   	unsigned int minidump_id;
>>   	int crash_reason_smem;
>>   	bool has_aggre2_clk;
>> +	bool decrypt_shutdown;
>>   	const char *info_name;
>>   
>>   	struct completion start_done;
>> @@ -128,6 +133,20 @@ static void adsp_pds_disable(struct qcom_adsp *adsp, struct device **pds,
>>   	}
>>   }
>>   
>> +static int adsp_decrypt_shutdown(struct qcom_adsp *adsp)
>> +{
>> +	int retry_num = 50;
> 
> Seems unsigned to me.

ack

> 
>> +	int ret = -EINVAL;
>> +
>> +	while (retry_num && ret) {
>> +		msleep(ADSP_DECRYPT_SHUTDOWN_DELAY_MS);
>> +		ret = qcom_scm_pas_shutdown(adsp->pas_id);
>> +		retry_num--;
>> +	}
> 
> Will qcom_scm_pas_shutdown() ever return any other errors than -EINVAL?
> 
> Would it make sense to make this:
> 
> 	do {
> 		...;
> 	} while (ret == -EINVAL && --retry_num);
> 

Just checking on ret would cover the -EINVAL case as well but like you
said pas_shutdown() won't return any other error. So I'll just stick
with your suggestion.

>> +
>> +	return ret;
>> +}
>> +
>>   static int adsp_unprepare(struct rproc *rproc)
>>   {
>>   	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
>> @@ -249,6 +268,9 @@ static int adsp_stop(struct rproc *rproc)
>>   		dev_err(adsp->dev, "timed out on wait\n");
>>   
>>   	ret = qcom_scm_pas_shutdown(adsp->pas_id);
>> +	if (ret && adsp->decrypt_shutdown)
>> +		ret = adsp_decrypt_shutdown(adsp);
>> +
>>   	if (ret)
>>   		dev_err(adsp->dev, "failed to shutdown: %d\n", ret);
>>   
>> @@ -459,6 +481,7 @@ static int adsp_probe(struct platform_device *pdev)
>>   	adsp->pas_id = desc->pas_id;
>>   	adsp->has_aggre2_clk = desc->has_aggre2_clk;
>>   	adsp->info_name = desc->sysmon_name;
>> +	adsp->decrypt_shutdown = desc->decrypt_shutdown;
>>   	platform_set_drvdata(pdev, adsp);
>>   
>>   	device_wakeup_enable(adsp->dev);
>> @@ -533,6 +556,7 @@ static const struct adsp_data adsp_resource_init = {
>>   		.pas_id = 1,
>>   		.has_aggre2_clk = false,
>>   		.auto_boot = true,
>> +		.decrypt_shutdown = false,
> 
> With all these booleans, I would prefer if we cleaned it up to not list
> the disabled options. That would make it quicker to spot which features
> are actually enabled for each remoteproc.

ack and ack to the adsp_shutdown_poll_decrypt() as well.

> 
> Regards,
> Bjorn
> 
