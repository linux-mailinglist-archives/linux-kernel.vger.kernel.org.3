Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2675D4C55E4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 13:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbiBZMsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 07:48:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiBZMsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 07:48:45 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3AE201AA;
        Sat, 26 Feb 2022 04:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645879691; x=1677415691;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ipC4nUk5VmMIUHO2SyxXsAdIlnW8TcsY2v8syl/NQWc=;
  b=Po+LAl5gwRNYP/3CNrllhRWUf8Vvvv57/kELn+aR0HTc4DoHhuFiQaV6
   P1iIlkBq3WRaDlxOD4pxuZLJ6YK16ve/OSlF7v8N2LbIKJOKlJdJGZNja
   +9t3C/6unG8QFqDsOzHP4yvQQNqjV3o0uTgG1JCBJM0npsT5OM6CxeGt9
   U=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 26 Feb 2022 04:48:11 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2022 04:48:10 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Sat, 26 Feb 2022 04:48:09 -0800
Received: from [10.216.36.82] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Sat, 26 Feb
 2022 04:48:02 -0800
Message-ID: <764e7a03-048b-750e-49ef-106863775738@quicinc.com>
Date:   Sat, 26 Feb 2022 18:17:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2] soundwire: qcom: remove redundant wait for completion
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>,
        <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@codeaurora.org>,
        <perex@perex.cz>, <tiwai@suse.com>, <rohitkr@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        <yung-chuan.liao@linux.intel.com>, <sanyog.r.kale@intel.com>
CC:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1645800257-27025-1-git-send-email-quic_srivasam@quicinc.com>
 <a99a59eb-cd59-f566-b98d-486c94f32eec@linaro.org>
 <06650d56-eed3-73ad-d6b4-6b56a5a70669@linux.intel.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <06650d56-eed3-73ad-d6b4-6b56a5a70669@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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


On 2/25/2022 9:13 PM, Pierre-Louis Bossart wrote:
Thanks for your time Bossart!!!
>
> On 2/25/22 08:45, Srinivas Kandagatla wrote:
>>
>> On 25/02/2022 14:44, Srinivasa Rao Mandadapu wrote:
>>> Remove wait_for_completion_timeout from soundwire probe as it seems
>>> unnecessary and device enumeration is anyway not happening here,
>>> hence this api is blocking till it completes max wait time.
>>> Also, as device enumeration event is dependent on wcd938x probe to be
>>> completed, its of no use waiting here.
>>> Waiting here increasing the boot time almost 4 seconds and impacting
>>> other modules like touch screen.
>>>
>>> Fixes: 06dd96738d618 ("soundwire: qcom: wait for enumeration to be
>>> complete in probe")
>>>
>>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> LGTM,
>>
>> Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> I don't get the idea, sorry.
>
> If you look at the code, these are the cases where this 'struct
> completion' is used
>
> 	struct completion enumeration;
> 	complete(&ctrl->enumeration);
> 	/* Enable Auto enumeration */
> 	init_completion(&ctrl->enumeration);
> 	wait_for_completion_timeout(&ctrl->enumeration,
>
>
> so if you remove the wait_for_completeion, then you might just as well
> remove the whole thing and revert 06dd96738d618
>
> what am I missing?
Okay. Sent new patch with reverting commit 06dd96738d618
>
>
>>> ---
>>>    drivers/soundwire/qcom.c | 2 --
>>>    1 file changed, 2 deletions(-)
>>>
>>> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
>>> index 5481341..9a32a24 100644
>>> --- a/drivers/soundwire/qcom.c
>>> +++ b/drivers/soundwire/qcom.c
>>> @@ -1309,8 +1309,6 @@ static int qcom_swrm_probe(struct
>>> platform_device *pdev)
>>>        }
>>>          qcom_swrm_init(ctrl);
>>> -    wait_for_completion_timeout(&ctrl->enumeration,
>>> -                    msecs_to_jiffies(TIMEOUT_MS));
>>>        ret = qcom_swrm_register_dais(ctrl);
>>>        if (ret)
>>>            goto err_master_add;
