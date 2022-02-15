Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5884B630F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 06:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbiBOFr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 00:47:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234190AbiBOFrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 00:47:55 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613277652;
        Mon, 14 Feb 2022 21:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644904066; x=1676440066;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tCYGnve93Lv4ejFxUIRd/Ltx7QSUv1nDOkb6h6k60F0=;
  b=rI4MCAm/jQ//CTDIvhAcWj+A2sb1QyY+wKaPIM9RPbeANVGmh0npZwnB
   mA6MMx7m44IkI67RdTrDPcbjTPTgHVlitB0Ytbh3A/EMggqA0FhvHuEa9
   TCcjYxJsUoNxOg8+uY8ih1u4Hz5k2Sraym79B8SWArmI3JnLjF15K2BlS
   Y=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 14 Feb 2022 21:47:45 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 21:47:44 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 14 Feb 2022 21:47:43 -0800
Received: from [10.216.16.231] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 14 Feb
 2022 21:47:38 -0800
Message-ID: <33d67a7c-4f71-266a-f952-6d202ed4b51e@quicinc.com>
Date:   Tue, 15 Feb 2022 11:17:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 2/8] mailbox: qcom: Add support for SDX65 APCS IPC
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <jassisinghbrar@gmail.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1644821755-27059-1-git-send-email-quic_rohiagar@quicinc.com>
 <20220214083409.GB3494@thinkpad> <20220214084957.GH3494@thinkpad>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <20220214084957.GH3494@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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


On 2/14/2022 2:19 PM, Manivannan Sadhasivam wrote:
> On Mon, Feb 14, 2022 at 02:04:14PM +0530, Manivannan Sadhasivam wrote:
>> On Mon, Feb 14, 2022 at 12:25:55PM +0530, Rohit Agarwal wrote:
>>> In SDX65, the IPC bits are located in the APCS GCC block. Also, this block
>>> can provide clock functionality. Hence, add support for IPC with correct
>>> offset and name of the clock provider.
>>>
>>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>
>> Thanks,
>> Mani
>>
>>> ---
>>>   drivers/mailbox/qcom-apcs-ipc-mailbox.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
>>> index 9325d2a..3f8612c 100644
>>> --- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
>>> +++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
>>> @@ -53,6 +53,10 @@ static const struct qcom_apcs_ipc_data sdx55_apcs_data = {
>>>   	.offset = 0x1008, .clk_name = "qcom-sdx55-acps-clk"
>>>   };
>>>   
>>> +static const struct qcom_apcs_ipc_data sdx65_apcs_data = {
>>> +	.offset = 0x1008, .clk_name = "qcom-sdx65-acps-clk"
>>> +};
>>> +
> After looking at patch 7/8, I think we should be able to reuse
> "qcom-sdx55-acps-clk" for SDX65.
Yes. Will update the patch. Thanks
>
> Thanks,
> Mani
>>>   static const struct regmap_config apcs_regmap_config = {
>>>   	.reg_bits = 32,
>>>   	.reg_stride = 4,
>>> @@ -159,6 +163,7 @@ static const struct of_device_id qcom_apcs_ipc_of_match[] = {
>>>   	{ .compatible = "qcom,sm8150-apss-shared", .data = &apps_shared_apcs_data },
>>>   	{ .compatible = "qcom,sm6115-apcs-hmss-global", .data = &msm8994_apcs_data },
>>>   	{ .compatible = "qcom,sdx55-apcs-gcc", .data = &sdx55_apcs_data },
>>> +	{ .compatible = "qcom,sdx65-apcs-gcc", .data = &sdx65_apcs_data },
>>>   	{}
>>>   };
>>>   MODULE_DEVICE_TABLE(of, qcom_apcs_ipc_of_match);
>>> -- 
>>> 2.7.4
>>>
