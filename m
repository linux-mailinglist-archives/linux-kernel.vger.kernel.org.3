Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CFF581FAC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 07:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiG0F6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 01:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiG0F63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 01:58:29 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0154B3D5B6;
        Tue, 26 Jul 2022 22:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658901509; x=1690437509;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JFFzAepKe5rumUmhn8PlzZJmssi2RX0UtiJtzayX2is=;
  b=NaIKRtRA0mXE0o7/yVjCTqJ64w/fsnaDQcEzne7kMFEfhZ0hT0tygpDZ
   55FPV0rIeGJ2aPNXQBmGmvOwpgDqSGoLyJmQ9ejBby+Gcm8CHlCmlBuls
   bYNBcRzObgUuoBWUQLVk9WA6Enk+thZR0W1B6yoGAs5hf6f5WfL9EBs9A
   Q=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 26 Jul 2022 22:58:28 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 22:58:28 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 26 Jul 2022 22:58:28 -0700
Received: from [10.50.42.78] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 26 Jul
 2022 22:58:24 -0700
Message-ID: <ecb58953-4758-3dec-b727-6ab6c8039cbf@quicinc.com>
Date:   Wed, 27 Jul 2022 11:28:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V6 5/5] clk: qcom: lpass: Add support for resets &
 external mclk for SC7280
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-soc@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>,
        <robh+dt@kernel.org>, <quic_tdas@quicinc.com>
References: <1658315023-3336-1-git-send-email-quic_c_skakit@quicinc.com>
 <1658315023-3336-6-git-send-email-quic_c_skakit@quicinc.com>
 <20220727013200.90E37C433C1@smtp.kernel.org>
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
In-Reply-To: <20220727013200.90E37C433C1@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/27/2022 7:01 AM, Stephen Boyd wrote:
> Quoting Satya Priya (2022-07-20 04:03:43)
>> From: Taniya Das <quic_tdas@quicinc.com>
>>
>> The clock gating control for TX/RX/WSA core bus clocks would be required
>> to be reset(moved from hardware control) from audio core driver. Thus
>> add the support for the reset clocks.
>>
>> Also add the external mclk to interface external MI2S.
>>
>> Fixes: a9dd26639d05 ("clk: qcom: lpass: Add support for LPASS clock controller for SC7280").
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>> ---
>>   drivers/clk/qcom/lpassaudiocc-sc7280.c | 22 +++++++++++++++++++++-
>>   drivers/clk/qcom/lpasscorecc-sc7280.c  | 33 +++++++++++++++++++++++++++++++++
>>   2 files changed, 54 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/qcom/lpassaudiocc-sc7280.c b/drivers/clk/qcom/lpassaudiocc-sc7280.c
>> index 6067328..063e036 100644
>> --- a/drivers/clk/qcom/lpassaudiocc-sc7280.c
>> +++ b/drivers/clk/qcom/lpassaudiocc-sc7280.c
>> @@ -23,6 +23,7 @@
>>   #include "clk-regmap-mux.h"
>>   #include "common.h"
>>   #include "gdsc.h"
>> +#include "reset.h"
>>   
>>   enum {
>>          P_BI_TCXO,
>> @@ -248,7 +249,7 @@ static struct clk_rcg2 lpass_aon_cc_main_rcg_clk_src = {
>>                  .parent_data = lpass_aon_cc_parent_data_0,
>>                  .num_parents = ARRAY_SIZE(lpass_aon_cc_parent_data_0),
>>                  .flags = CLK_OPS_PARENT_ENABLE,
>> -               .ops = &clk_rcg2_ops,
>> +               .ops = &clk_rcg2_shared_ops,
> This diff isn't mentioned in the commit text at all. Is it intentional?
> If so, please mention why it needs to change.


It is updated to park the RCG at XO after disable as this clock signal 
is used by hardware to turn ON memories in LPASS. I'll mention this in 
the commit text.


