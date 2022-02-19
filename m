Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84E64BC9F5
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 19:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242875AbiBSSh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 13:37:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237333AbiBSShZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 13:37:25 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF7341305;
        Sat, 19 Feb 2022 10:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645295825; x=1676831825;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GhY3fDCHu53ziSnkTw5eFSyoPC2rhAzNSF2CnP6JEi4=;
  b=I8v92+VeW5ypO7DaWL+jYPZ42M3jUP+4u3IQ1nUvPyZhjeVlWf76JONd
   LJZ7hx+pBFVQQgdGkNZ6iSameez0OPYe+s7ymmAgsPJjqRAPXkWE1sS0A
   fxSHW2Z2XrV1QkEdLpzBQh8qfRq1ClOzHyk6g69nX8EATbXl4UTny3dqd
   w=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 19 Feb 2022 10:37:05 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2022 10:37:04 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Sat, 19 Feb 2022 10:36:51 -0800
Received: from [10.216.20.52] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Sat, 19 Feb
 2022 10:36:44 -0800
Message-ID: <a3bb48ec-1174-ba2f-eca5-0fed78c55799@quicinc.com>
Date:   Sun, 20 Feb 2022 00:06:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v6 7/7] pinctrl: qcom: Update clock voting as optional
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <agross@kernel.org>, <alsa-devel@alsa-project.org>,
        <bgoswami@codeaurora.org>, <bjorn.andersson@linaro.org>,
        <broonie@kernel.org>, <devicetree@vger.kernel.org>,
        <judyhsiao@chromium.org>, <lgirdwood@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <perex@perex.cz>,
        <quic_plai@quicinc.com>, <robh+dt@kernel.org>,
        <rohitkr@codeaurora.org>, <tiwai@suse.com>
CC:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1644851994-22732-1-git-send-email-quic_srivasam@quicinc.com>
 <1644851994-22732-8-git-send-email-quic_srivasam@quicinc.com>
 <a209336a-9108-f1ac-ee6d-a838df115c6d@linaro.org>
 <b663f63f-4a5a-3a2a-9be7-fa7258ce93c5@quicinc.com>
 <09b00fe9-1770-1723-3c4c-6c494da87e8d@linaro.org>
 <CAE-0n5009g2WwnTsmUeKs5jgrnrUf21SgEL1s65C3FL+HJefkQ@mail.gmail.com>
From:   "Srinivasa Rao Mandadapu (Temp)" <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <CAE-0n5009g2WwnTsmUeKs5jgrnrUf21SgEL1s65C3FL+HJefkQ@mail.gmail.com>
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


On 2/19/2022 8:16 AM, Stephen Boyd wrote:
Thanks for Your time Stephen!!!
> Quoting Srinivas Kandagatla (2022-02-16 07:38:02)
>>
>> On 16/02/2022 14:41, Srinivasa Rao Mandadapu wrote:
>>> On 2/16/2022 7:50 PM, Srinivas Kandagatla wrote:
>>> Thanks for Your Time Srini!!!
>>>> On 14/02/2022 15:19, Srinivasa Rao Mandadapu wrote:
>>>>> diff --git a/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
>>>>> b/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
>>>>> index 5bf30d97..4277e31 100644
>>>>> --- a/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
>>>>> +++ b/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
>>>>> @@ -143,6 +143,7 @@ static const struct lpi_pinctrl_variant_data
>>>>> sc7280_lpi_data = {
>>>>>        .ngroups = ARRAY_SIZE(sc7280_groups),
>>>>>        .functions = sc7280_functions,
>>>>>        .nfunctions = ARRAY_SIZE(sc7280_functions),
>>>>> +    .is_clk_optional = 1,
>>>> This is forcefully set assuming that sc7280 is always used in ADSP
>>>> bypass mode. Which is not correct.
>>>>
>>>> Can't you use devm_clk_bulk_get_optional instead?
>>> Yes. Agreed. Initially used devm_clk_bulk_get_optional, but Bjorn
>>> suggested for conditional check instead of optional.
>>>
>>> Again Shall we go for optional clock voting?
>> That means that the condition has to be dynamic based on the platform
>> using DSP or not. Which is impossible to deduce without some help from DT.
>>
>> I would prefer to stay with optional clock unless Bjorn has some strong
>> objection on not using int.
> I think we need the combination of optional API and bool flag. My
> understanding is it's optional on sc7280, but not on the previous
> revision, so we want to be very strict on previous revision and less
> strict on sc7280. Hence the flag. Maybe we should change it to
> clk_required and then assume optional going forward. Then the callsite
> can use one or the other API?
Okay.Will change accordingly.
