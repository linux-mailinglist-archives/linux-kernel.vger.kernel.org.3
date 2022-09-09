Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322805B2B1E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 02:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiIIAbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 20:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiIIAbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 20:31:45 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2256ED51C8;
        Thu,  8 Sep 2022 17:31:44 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28904cqE008607;
        Fri, 9 Sep 2022 00:31:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=XmVWEIzCNB723ISEUcSXGd8hG0eHhwHmmaZx+2kGF1k=;
 b=UUALUAa+c89HXmK+FhKXjNCBRNq1C8UfXeCdCEuMdra167rKh6EpK0FYkUUYVjpwPyA2
 vR8vtb5jM3vlTxn/gd+wvFpQEdHlmjiNsBdNJ7nDQxAegVFQ1XSMiiaMhXUMZ0vVC+d6
 YLHH5tE57eJJzbU+cjGBNvVnYtxNJjSE5CWQ/BBbqCoK81Hu5fDvobuIHxlbKCrpKmac
 P19Bvay6pBpv5c60ZY7m0DY00W5lQpHH7iIhfDvXYu6fslk9ap0EmYjK/poGm2cZp+gN
 GXnQKRKct6IQdi1Wg7alsV1kVyj+wbpWy5YNrNcW5VFzGKncA1ZT/c1geAsb9yBQeU6+ /g== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jfeuutcap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 00:31:36 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2890QY12027849
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Sep 2022 00:26:34 GMT
Received: from [10.47.206.1] (10.49.16.6) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 8 Sep 2022
 17:26:33 -0700
Message-ID: <4c017ad4-558b-a8d4-bc8a-eebd2d5a35ba@quicinc.com>
Date:   Thu, 8 Sep 2022 17:25:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/4] pinctrl: qcom: spmi-gpio: Fix the GPIO strength
 mapping
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Anjelique Melendez <quic_amelende@quicinc.com>,
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
From:   David Collins <quic_collinsd@quicinc.com>
In-Reply-To: <2b809e98-85ea-6ad9-e810-106563937ddc@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7qGC2BDiu5fGxALdpzm6kwfI6r3ja-Ss
X-Proofpoint-GUID: 7qGC2BDiu5fGxALdpzm6kwfI6r3ja-Ss
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_14,2022-09-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 clxscore=1011 phishscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209080086
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/22 04:14, Krzysztof Kozlowski wrote:
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

This is for internal tracking.  It will be removed in the next version
of this patch series.


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

This could be split into two patches.  However, both would need to make
it into any given build to avoid runtime regressions when
pinctrl-spmi-gpio.c rejects GPIO strength configurations larger than 1.

I suppose that this kind of bi-directional dependency could be avoided
by using one of these checks instead in the driver:

if (arg > 3) {

or

if (arg > max(PMIC_GPIO_STRENGTH_LOW, PMIC_GPIO_STRENGTH_HIGH))

Going this route would only require that the driver patch is picked up
before the DT header patch.



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

Currently, all PMIC GPIO peripherals managed by the pinctrl-spmi-gpio
driver are having their drive strength control register programmed
incorrectly at runtime for the constant name used in DT (i.e.
PMIC_GPIO_STRENGTH_LOW vs PMIC_GPIO_STRENGTH_HIGH).  Changing the values
of those constants as done in this patch fixes that incorrect behavior.

The qcom,drive-strength DT property is taking a raw drive strength
control register value instead of some logical strength abstraction.
I'm not sure of a better way to handle the situation than fixing the
incorrect drive strength constant to register value mapping as defined
in qcom,pmic-gpio.h.

Changing the mapping in qcom,pmic-gpio.h without updating any dtsi files
could cause a problem for very old targets that use SSBI instead of SPMI
for PMIC communication.  However, for there to actually be a problem,
PMIC_GPIO_STRENGTH_LOW or PMIC_GPIO_STRENGTH_HIGH would need to be
specified for the SSBI PMIC.  That would be GPIO devices with compatible
strings: "qcom,pm8018-gpio", "qcom,pm8038-gpio", "qcom,pm8058-gpio",
"qcom,pm8917-gpio", or "qcom,pm8921-gpio".  I could find no instances of
this situation in the kernel source tree.

The PMIC_GPIO_STRENGTH_LOW or PMIC_GPIO_STRENGTH_HIGH usage in dtsi
files for SPMI PMICs does not need to be modified.  The DT header patch
fixes configurations that are currently broken for them.

Note that the drive strength misconfiguration issue doesn't present a
problem for commercial products as this patch has been cherry-picked
downstream for several years.

Take care,
David
