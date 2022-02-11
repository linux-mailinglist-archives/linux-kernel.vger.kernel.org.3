Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DC94B28CD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 16:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351256AbiBKPLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 10:11:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbiBKPLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 10:11:33 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD80E307;
        Fri, 11 Feb 2022 07:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644592293; x=1676128293;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=UAfT14of1NM3JqsPga/1VFj8mq9Ld+eK2uBRpqiefpY=;
  b=GWkmxsLWsHZqc3PkY4jLNIn5cF+UthaTxR/UUm4QN6xqid0RH3/1DicV
   ClclIH+21bbVaZV6H3kPEzbe5Eff5FzKI+eHY82GhVPgRQconLetHVk0R
   0EP4r5IAoWqiBJ/6STXwGIjfMqoIjdZkCehE7XgVuGtlI4KDiafUmB/sm
   s=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 11 Feb 2022 07:11:32 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 07:11:32 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 11 Feb 2022 07:11:31 -0800
Received: from [10.216.7.73] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Fri, 11 Feb
 2022 07:11:26 -0800
Subject: Re: [PATCH V5 3/6] mfd: pm8008: Add mfd cell struct to register LDOs
To:     Lee Jones <lee.jones@linaro.org>
CC:     Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Das Srinagesh" <gurus@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_collinsd@quicinc.com>,
        <quic_subbaram@quicinc.com>, <quic_jprakash@quicinc.com>
References: <1644331940-18986-1-git-send-email-quic_c_skakit@quicinc.com>
 <1644331940-18986-4-git-send-email-quic_c_skakit@quicinc.com>
 <CAE-0n52B4heY5fcbz71JPOqvMVvmqsXO94V+Z0qTTw_XXextJw@mail.gmail.com>
 <bd5636b0-b975-1084-f285-87e458249b1a@quicinc.com>
 <YgZl/0fC8ruM0f7Y@google.com>
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
Message-ID: <f334c294-6ab8-76ed-872d-155b523d138b@quicinc.com>
Date:   Fri, 11 Feb 2022 20:41:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YgZl/0fC8ruM0f7Y@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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

Hi,


On 2/11/2022 7:04 PM, Lee Jones wrote:
> On Fri, 11 Feb 2022, Satya Priya Kakitapalli (Temp) wrote:
>
>> On 2/10/2022 7:02 AM, Stephen Boyd wrote:
>>> Quoting Satya Priya (2022-02-08 06:52:17)
>>>> diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
>>>> index c472d7f..e8569cc 100644
>>>> --- a/drivers/mfd/qcom-pm8008.c
>>>> +++ b/drivers/mfd/qcom-pm8008.c
>>>> @@ -8,6 +8,7 @@
>>>>    #include <linux/interrupt.h>
>>>>    #include <linux/irq.h>
>>>>    #include <linux/irqdomain.h>
>>>> +#include <linux/mfd/core.h>
>>>>    #include <linux/module.h>
>>>>    #include <linux/of_device.h>
>>>>    #include <linux/of_platform.h>
>>>> @@ -27,6 +28,37 @@
>>>>    #define INT_EN_CLR_OFFSET              0x16
>>>>    #define INT_LATCHED_STS_OFFSET         0x18
>>>>
>>>> +static const struct mfd_cell pm8008_regulator_devs[] = {
>>> Is there some way to not allocate this structure statically forever?
>>
>> I think No.
>>
>> I found that some of the drivers are just using one cell with .name to match
>> with regulator driver and then probing regulators using a loop. I'll do that
>> too.
>>
>> static const struct mfd_cell pm8008_regulator_devs[] = {
>>          {
>>                  .name = "qcom,pm8008-regulators",
>>          },
>>   };
> Please use MFD_CELL_NAME() for these.


Okay.


