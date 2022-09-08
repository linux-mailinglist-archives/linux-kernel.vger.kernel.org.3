Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52BD65B2AAE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 01:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiIHX53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 19:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiIHX5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 19:57:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132CDFBF20;
        Thu,  8 Sep 2022 16:57:21 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 288LltR0016279;
        Thu, 8 Sep 2022 23:57:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=DP+1a705Ln6azuRbeCkaSx6hxJZpQPx385zZM8JCxVc=;
 b=WTslEZ8quKY0pkQI0Unoz7Qou0LBoSDfEPWldx5LNnEdTEelGlGosHlY5x75gE0Mj7NQ
 vxPePqv2ud3BhvGd+/TPj2XvcsbuMpw+b4sxun9PfvNlCK0uR2JQ8i7KOaMN5TbLYJpg
 ssXjw8er6V6KzyFMHPLGnMsEQLhuUREaEokix0bT/zmCAaZbaY3qPgIBNahR44Ct8uHq
 DSy0c/bKzUmG8y+th9RP9VNppDvcW9xnnIbuJx67FmtnP6u05KPuEOm5jZDD0A6TKgWo
 kYvZqML+/puGKKEd7K2iVGcY4mi81f5pdDDyvrFxKx85eYw6ncWxabelj0UlsgJj3I0b dw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jf85138yh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 23:57:12 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 288NqBWk025748
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Sep 2022 23:52:11 GMT
Received: from [10.110.115.160] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 8 Sep 2022
 16:52:10 -0700
Message-ID: <330b5f46-1bd2-5727-b63c-c730fbdda22c@quicinc.com>
Date:   Thu, 8 Sep 2022 16:52:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/4] pinctrl: qcom: spmi-gpio: Fix the GPIO strength
 mapping
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <konrad.dybcio@somainline.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Anirudh Ghayal <quic_aghayal@quicinc.com>
References: <20220907201528.9351-1-quic_amelende@quicinc.com>
 <20220907201528.9351-3-quic_amelende@quicinc.com>
 <2b809e98-85ea-6ad9-e810-106563937ddc@linaro.org>
From:   Anjelique Melendez <quic_amelende@quicinc.com>
In-Reply-To: <2b809e98-85ea-6ad9-e810-106563937ddc@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jqFcEesKsAWjweVhpnPr5B8ZFqIB3Jqh
X-Proofpoint-ORIG-GUID: jqFcEesKsAWjweVhpnPr5B8ZFqIB3Jqh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_13,2022-09-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209080084
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/8/2022 4:14 AM, Krzysztof Kozlowski wrote:
> On 07/09/2022 22:15, Anjelique Melendez wrote:
>> From: Anirudh Ghayal <quic_aghayal@quicinc.com>
>>
>> The SPMI based PMICs have the HIGH and LOW GPIO output
>> strength mappings interchanged, fix them.
>>
>> Keep the mapping same for older SSBI based PMICs.
>>
>> CRs-Fixed: 2246473
> 
> What is this tag about?
Forgot to remove this tag before up streamed. Will remove for next version.
> 
>> Signed-off-by: Anirudh Ghayal <quic_aghayal@quicinc.com>
>> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
>> ---
>>  drivers/pinctrl/qcom/pinctrl-spmi-gpio.c     | 2 +-
>>  drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c     | 4 ++--
>>  include/dt-bindings/pinctrl/qcom,pmic-gpio.h | 9 +++++++--
>>  3 files changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
>> index cf6b6047de8d..fceccf1ec099 100644
>> --- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
>> +++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
>> @@ -525,7 +525,7 @@ static int pmic_gpio_config_set(struct pinctrl_dev *pctldev, unsigned int pin,
>>  			pad->pullup = arg;
>>  			break;
>>  		case PMIC_GPIO_CONF_STRENGTH:
>> -			if (arg > PMIC_GPIO_STRENGTH_LOW)
>> +			if (arg > PMIC_GPIO_STRENGTH_HIGH)
>>  				return -EINVAL;
>>  			pad->strength = arg;
>>  			break;
>> diff --git a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
>> index 1b41adda8129..0f96d130813b 100644
>> --- a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
>> +++ b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
>> @@ -1,7 +1,7 @@
>>  // SPDX-License-Identifier: GPL-2.0-only
>>  /*
>>   * Copyright (c) 2015, Sony Mobile Communications AB.
>> - * Copyright (c) 2013, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2013, 2018 The Linux Foundation. All rights reserved.
>>   */
>>  
>>  #include <linux/module.h>
>> @@ -371,7 +371,7 @@ static int pm8xxx_pin_config_set(struct pinctrl_dev *pctldev,
>>  			banks |= BIT(0);
>>  			break;
>>  		case PM8XXX_QCOM_DRIVE_STRENGH:
>> -			if (arg > PMIC_GPIO_STRENGTH_LOW) {
>> +			if (arg > PM8921_GPIO_STRENGTH_LOW) {
>>  				dev_err(pctrl->dev, "invalid drive strength\n");
>>  				return -EINVAL;
>>  			}
>> diff --git a/include/dt-bindings/pinctrl/qcom,pmic-gpio.h b/include/dt-bindings/pinctrl/qcom,pmic-gpio.h
>> index e5df5ce45a0f..950be952ad3e 100644
>> --- a/include/dt-bindings/pinctrl/qcom,pmic-gpio.h
>> +++ b/include/dt-bindings/pinctrl/qcom,pmic-gpio.h
> 
> You cannot mix bindings with driver. This is an ABI break.
Ack - Will separate into two changes.
>> @@ -12,9 +12,14 @@
>>  #define PMIC_GPIO_PULL_UP_1P5_30	3
>>  
>>  #define PMIC_GPIO_STRENGTH_NO		0
>> -#define PMIC_GPIO_STRENGTH_HIGH		1
>> +#define PMIC_GPIO_STRENGTH_LOW		1
>>  #define PMIC_GPIO_STRENGTH_MED		2
>> -#define PMIC_GPIO_STRENGTH_LOW		3
>> +#define PMIC_GPIO_STRENGTH_HIGH		3
> 
> Didn't you just break all DTSes in the world?
Ack - lol. Next version will include changes to update any DTS
that uses PMIC_GPIO_STRENGTH_ 
> 
> Best regards,
> Krzysztof

Thanks,
Anjelique
