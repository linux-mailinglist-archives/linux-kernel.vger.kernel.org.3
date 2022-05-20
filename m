Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2B652EEC3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346067AbiETPJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244681AbiETPJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:09:41 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADF08B0A4;
        Fri, 20 May 2022 08:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653059380; x=1684595380;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=P2WilbSU+L9bjk1wqlq1ZZlucavYPq5P1Ib9UN6A/h8=;
  b=kwm3ZlXpmFUSQ2CyWWh7RZojfkz0WRxeF0x7NmY2CCP9N32VOFVNWlZQ
   MF4KtyHIunxqGtgxPrETlZPwdFEGJ54nWabyDlWwWLKH7S7g6vtIv5aJ7
   043JAtNK055OFJn+s0pGV4QqPOwuftLswECpKorbUcsNP4bxRbSWE/Ll4
   o=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 20 May 2022 08:09:40 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 08:09:39 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 20 May 2022 08:09:39 -0700
Received: from [10.110.100.160] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 20 May
 2022 08:09:37 -0700
Message-ID: <609bb4fc-1503-81ef-6fd8-dbb862c4ef80@quicinc.com>
Date:   Fri, 20 May 2022 08:09:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v6 1/3] phy: qcom-edp: add regulator_set_load to edp phy
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <airlied@linux.ie>, <bjorn.andersson@linaro.org>,
        <daniel@ffwll.ch>, <dianders@chromium.org>,
        <dmitry.baryshkov@linaro.org>, <dri-devel@lists.freedesktop.org>,
        <robdclark@gmail.com>, <sean@poorly.run>, <vkoul@kernel.org>
CC:     <quic_abhinavk@quicinc.com>, <quic_aravindh@quicinc.com>,
        <quic_sbillaka@quicinc.com>, <freedreno@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1653001902-26910-1-git-send-email-quic_khsieh@quicinc.com>
 <1653001902-26910-2-git-send-email-quic_khsieh@quicinc.com>
 <CAE-0n52yT6S4TLpc2e2-kkbMB2Fu2PcZskG-ZFLo7y1YVTyazQ@mail.gmail.com>
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
In-Reply-To: <CAE-0n52yT6S4TLpc2e2-kkbMB2Fu2PcZskG-ZFLo7y1YVTyazQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/19/2022 5:19 PM, Stephen Boyd wrote:
> Quoting Kuogee Hsieh (2022-05-19 16:11:40)
>> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
>> index cacd32f..78b7306 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
>> @@ -87,14 +87,19 @@ struct qcom_edp {
>>
>>          struct clk_bulk_data clks[2];
>>          struct regulator_bulk_data supplies[2];
>> +       int enable_load[2];
>>   };
>>
>>   static int qcom_edp_phy_init(struct phy *phy)
>>   {
>>          struct qcom_edp *edp = phy_get_drvdata(phy);
>>          int ret;
>> +       int i;
>>
>> -       ret = regulator_bulk_enable(ARRAY_SIZE(edp->supplies), edp->supplies);
>> +       for (i = 0; i < 2; i++)
> Use ARRAY_SIZE(edp->supplies)?
>
>> +               regulator_set_load(edp->supplies[i].consumer, edp->enable_load[i]);
>> +
>> +       ret = regulator_bulk_enable(2, edp->supplies);
> Why is ARRAY_SIZE() usage removed?


remove it base on Dmitry's comment.

I will restore it back to use ARRY_SIZE


>
>>          if (ret)
>>                  return ret;
>>
