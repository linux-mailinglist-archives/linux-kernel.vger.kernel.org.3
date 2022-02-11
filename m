Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED834B2837
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 15:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244963AbiBKOsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 09:48:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235874AbiBKOsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 09:48:23 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E034FE;
        Fri, 11 Feb 2022 06:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644590901; x=1676126901;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=LeB8V2BK2eGUygILietSQ0lBWhPLWz2Zfy8r2Lh8pkU=;
  b=uU2a3HNMXyuGQXzPvcumwvZVWB/tRa+KyQvn+U5ekhA8V4BmZK+VpduS
   UEWpWqPCL2gVSd006KaNoCXlqW6wgTl3xC6exQgC4Y4/bY24js3Se+qTQ
   O3UEYXXU+sYWjX+wXJbdS8RoBXnJbyT+wco3JjQ6+eKmVTGRkvOHHfLRQ
   g=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 11 Feb 2022 06:48:21 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 06:48:20 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 11 Feb 2022 06:48:20 -0800
Received: from [10.216.7.73] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Fri, 11 Feb
 2022 06:48:14 -0800
Subject: Re: [PATCH V5 4/6] regulator: Add a regulator driver for the PM8008
 PMIC
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@canonical.com>
CC:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Das Srinagesh <gurus@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_jprakash@quicinc.com>
References: <1644331940-18986-1-git-send-email-quic_c_skakit@quicinc.com>
 <1644331940-18986-5-git-send-email-quic_c_skakit@quicinc.com>
 <828ffa4e-d098-071f-1b5f-3bf414c0ed80@gmail.com>
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
Message-ID: <654f9808-9787-cbbb-8f27-219aeea4024d@quicinc.com>
Date:   Fri, 11 Feb 2022 20:18:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <828ffa4e-d098-071f-1b5f-3bf414c0ed80@gmail.com>
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

Hi Matti,


Thanks for reviewing the patches!


On 2/11/2022 4:31 PM, Matti Vaittinen wrote:
> Hi Satya,
>
> It's always nice to see new PMIC drivers :) I just one question after 
> reading your patch - please ignore it if it has already been discussed 
> before - for some reason this version was caught by my filters where 
> the previous versions didn't. It means I do not know the full history.
> On 2/8/22 16:52, Satya Priya wrote:
>> Qualcomm Technologies, Inc. PM8008 is an I2C controlled PMIC
>> containing 7 LDO regulators.  Add a PM8008 regulator driver to
>> support PMIC regulator management via the regulator framework.
>>
>> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
>> ---
>
> snip
>
>> +
>> +static int pm8008_regulator_of_parse(struct device_node *node,
>> +            const struct regulator_desc *desc,
>> +            struct regulator_config *config)
>> +{
>> +    struct pm8008_regulator *pm8008_reg = config->driver_data;
>> +    int rc;
>> +    unsigned int reg;
>> +
>> +    /* get slew rate */
>> +    rc = regmap_bulk_read(pm8008_reg->regmap,
>> +            LDO_STEPPER_CTL_REG(pm8008_reg->base), &reg, 1);
>> +    if (rc < 0) {
>> +        dev_err(pm8008_reg->dev,
>> +            "%s: failed to read step rate configuration rc=%d\n",
>> +            pm8008_reg->rdesc.name, rc);
>> +        return rc;
>> +    }
>> +    reg &= STEP_RATE_MASK;
>> +    pm8008_reg->step_rate = DEFAULT_VOLTAGE_STEPPER_RATE >> reg;
>> +
>> +    return 0;
>> +}
>
> I wonder why this is done in the of_parse_cb? Could this perhaps be 
> done directly in probe - I don't think this is actually parsing the 
> device_node properties, right?
>

Right, I will move this part to probe. In the previous version there was 
some code here which did the DT parsing, now that I removed all that, I 
should move this to probe.


Thanks,

Satya Priya


> Overall this looks pretty nice to me.
>
> Best Regards
>     -- Matti
>
