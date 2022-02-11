Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3483E4B2344
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349101AbiBKKgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:36:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349053AbiBKKfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:35:22 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714A6F1D;
        Fri, 11 Feb 2022 02:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644575716; x=1676111716;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=VSQeArOnGdl7FcIKdua2NdAwZTNifoQ+KWawkwDJKbI=;
  b=Ic9/BJZX6iXH/PYtts4WOYLxPs5OyF4rnJMJ8Jk+EJXOWNMaAyn8C2xF
   uzWV6SiRVJ6+wR+YNX6LSiHCJdFLQ5BAfNDjv3BO4FqMfAeJ4i/rzFbo/
   kjH+cZb2trPf6ZlRiXhV5toyFU0LqpvxJ4Zzk40o4A+BQKA604t1uOF+S
   U=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 11 Feb 2022 02:35:16 -0800
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 02:35:15 -0800
Received: from [10.216.7.73] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Fri, 11 Feb
 2022 02:35:10 -0800
Subject: Re: [PATCH V5 4/6] regulator: Add a regulator driver for the PM8008
 PMIC
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Lee Jones <lee.jones@linaro.org>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Das Srinagesh" <gurus@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_jprakash@quicinc.com>
References: <1644331940-18986-1-git-send-email-quic_c_skakit@quicinc.com>
 <1644331940-18986-5-git-send-email-quic_c_skakit@quicinc.com>
 <YgW0ltMKjGZH4NrZ@builder.lan>
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
Message-ID: <653bc533-8dca-cd9c-3ca0-d5628da37f4a@quicinc.com>
Date:   Fri, 11 Feb 2022 16:05:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YgW0ltMKjGZH4NrZ@builder.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
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


On 2/11/2022 6:27 AM, Bjorn Andersson wrote:
> On Tue 08 Feb 08:52 CST 2022, Satya Priya wrote:
>> diff --git a/drivers/regulator/qcom-pm8008-regulator.c b/drivers/regulator/qcom-pm8008-regulator.c
> [..]
>> +static int pm8008_regulator_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	int id = pdev->id % PM8008_NUM_LDOS;
> Why does this driver look completely different from all the other
> Qualcomm regulator drivers that we already have, and why do you register
> one platform_device per regulator?


Based on Mark's suggestions and the discussion happened here [1], I've 
changed the design like this.

[1] 
https://patchwork.kernel.org/project/linux-arm-msm/patch/1637314953-4215-3-git-send-email-quic_c_skakit@quicinc.com/


> The fundamental difference in design makes it hard to maintain and


> you're wasting quite a bit of memory with the unnecessary
> platfrom_device objects.


I'm going to change this. I will add only one cell with .name to match 
with the regulator driver and probe all the regulators using a single 
loop. That way we don't waste lot of memory by registering multiple 
regulator platform devices.


> Regards,
> Bjorn
