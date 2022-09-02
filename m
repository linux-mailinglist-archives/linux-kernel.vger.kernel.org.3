Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92EC5AA6BA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 06:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbiIBEE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 00:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiIBEEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 00:04:54 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3369211174;
        Thu,  1 Sep 2022 21:04:53 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28244GTv012420;
        Fri, 2 Sep 2022 04:04:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=wfbrIGOocPvZH/uoLYPFS6hXByh0b+uzqQ72Z9SCWRE=;
 b=jnDT/rKkqy7ri6GdpwUNfUL0G0AksVUDFeHwoe3eRWm8mmyOEr/kYc+lr29gVOZtyhMc
 7inIeOYh/OmNwi8rm4gwRm4q5UJn71McrO6PLDFRZ06oz5H4+fCqzMWo3plGhUxiuHnF
 MqsriZGHrM0b7dj42IcyS7T+kp1yG7+JaKi/C26WTdVyvT+VlD1Vm8i+uvx02upzfO0V
 6VfCIRf45H5x/ATAHQTzYVMNuokU2cz5zmTr+7+3UqL7zbaKZUcvppOU9cBFJch+McA1
 xH41u8jjt3aYiIB8judQZnf3upcHKCJfOap3j21DEwvTe3o/2EjIkoTBiJMZmkocv8pD yg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jbafy8015-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 04:04:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28244idr028804
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Sep 2022 04:04:44 GMT
Received: from [10.216.15.81] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 1 Sep 2022
 21:04:41 -0700
Message-ID: <33c61f23-6442-6d9b-492f-dd6e9c64a8c1@quicinc.com>
Date:   Fri, 2 Sep 2022 09:34:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/4] soc: qcom: icc-bwmon: add support for sc7280 LLCC
 BWMON
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@somainline.org>, <robh+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20220901124730.19460-1-quic_rjendra@quicinc.com>
 <20220901124730.19460-3-quic_rjendra@quicinc.com>
 <4ca517a4-c4a1-2359-7b60-86ac529ed741@linaro.org>
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
In-Reply-To: <4ca517a4-c4a1-2359-7b60-86ac529ed741@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FHD6_3GxhzsMQ7fZN1sfngspQuqrBIHv
X-Proofpoint-GUID: FHD6_3GxhzsMQ7fZN1sfngspQuqrBIHv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_12,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 adultscore=0
 clxscore=1015 mlxscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209020018
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/1/2022 8:57 PM, Krzysztof Kozlowski wrote:
> On 01/09/2022 15:47, Rajendra Nayak wrote:
>> Add support for sc7280 BWMON instance measuring traffic between LLCC and
>> memory with the v5 register layout.
>>
>> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
>> ---
>>   drivers/soc/qcom/icc-bwmon.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
>> index 47c2c3e7bb3f..44a10009b45e 100644
>> --- a/drivers/soc/qcom/icc-bwmon.c
>> +++ b/drivers/soc/qcom/icc-bwmon.c
>> @@ -656,6 +656,18 @@ static const struct icc_bwmon_data sdm845_llcc_bwmon_data = {
>>   	.regmap_cfg = &sdm845_llcc_bwmon_regmap_cfg,
>>   };
>>   
>> +static const struct icc_bwmon_data sc7280_llcc_bwmon_data = {
>> +	.sample_ms = 4,
>> +	.count_unit_kb = 64,
> 
> This makes me wonder if I put correct count unit for SDM845 LLCC...

These numbers seem to vary from SoC to SoC, I looked up the sdm845.dtsi from
the CAF kernels [1] and it seems like it should be 4096 instead of 1024?

[1] https://source.codeaurora.org/quic/la/kernel/msm-4.9/tree/arch/arm64/boot/dts/qcom/sdm845.dtsi
  
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof
