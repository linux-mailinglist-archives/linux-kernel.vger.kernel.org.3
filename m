Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65124C46C1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241547AbiBYNkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239345AbiBYNkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:40:20 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62C4210469;
        Fri, 25 Feb 2022 05:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645796388; x=1677332388;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9OdzSD1XsrbczLLfCeXnsbqUptTDr7RDbwNE8J8aeuI=;
  b=WcFh0F4uU2bpE/EzvuDvnZOdsFzkrvpTiRmBk7VH9J7TSk+Sm+G+ZeBl
   w27RpULu+7AMCAY45QRf7cnKfH1St0sURTCeyPwv0hO1KSCBpLZ4ddPQU
   axJ66nujcRKuD/MY1ESNi9TsznzFuSvhkT2zME4Wv4yLV54bJdXRpSvzn
   o=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 25 Feb 2022 05:39:48 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 05:39:48 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 25 Feb 2022 05:39:47 -0800
Received: from [10.216.25.108] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Fri, 25 Feb
 2022 05:39:41 -0800
Message-ID: <5f4a158f-d50a-0022-5a62-46ce84fec12c@quicinc.com>
Date:   Fri, 25 Feb 2022 19:09:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] soundwire: qcom: remove redundant wait for completion
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@codeaurora.org>,
        <perex@perex.cz>, <tiwai@suse.com>, <rohitkr@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>, <koul@kernel.org>,
        <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>
CC:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1645795667-20176-1-git-send-email-quic_srivasam@quicinc.com>
 <861cd4c1-43a9-8175-7ad1-e7e51f5781b4@linaro.org>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <861cd4c1-43a9-8175-7ad1-e7e51f5781b4@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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


On 2/25/2022 7:07 PM, Srinivas Kandagatla wrote:
Thanks for Your time Srini!!
>
> On 25/02/2022 13:27, Srinivasa Rao Mandadapu wrote:
>> Remove wait_for_completion_timeout from soundwire probe
>> as it seems unnecessary and device enumeration is anyway not
>> happening here.
>
> May be some details on the side effects of this wait would be good to 
> add in the log.
Okay. Will elaborate issue observed here.
>
>> Also, as device enumeration event is dependent on wcd938x probe to be
>> completed, its of no use waiting here.
>
> fix tag is missing
>
> Fixes: 06dd96738d618 ("soundwire: qcom: wait for enumeration to be 
> complete in probe")
Okay. Will add and re post.
>
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> ---
>>   drivers/soundwire/qcom.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
>> index 5481341..9a32a24 100644
>> --- a/drivers/soundwire/qcom.c
>> +++ b/drivers/soundwire/qcom.c
>> @@ -1309,8 +1309,6 @@ static int qcom_swrm_probe(struct 
>> platform_device *pdev)
>>       }
>>         qcom_swrm_init(ctrl);
>> -    wait_for_completion_timeout(&ctrl->enumeration,
>> -                    msecs_to_jiffies(TIMEOUT_MS));
>>       ret = qcom_swrm_register_dais(ctrl);
>>       if (ret)
>>           goto err_master_add;
