Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB505A44B4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 10:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiH2IMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 04:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiH2IMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 04:12:31 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6164DB44;
        Mon, 29 Aug 2022 01:12:29 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27T7Kcb4014864;
        Mon, 29 Aug 2022 08:12:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=rCGefT0iakgCy9h1CkWjMARQbxfbwXQAnAbhkNyxldY=;
 b=IOQTb9GAnEk2+L/bRdmhnPm8pO+DnccZ929bF4RDQiqLcLtOKdwBRYwcezFiSCs2W/Gk
 uvyowuofZgEmn4pLjBPa3nxcrlidiu+ZYZvSCN5U0oOmOJvOJl7wChgGlapYPeF3jmnk
 4wFuIbjOcgLCvwNG1UAFhtxka9Tnk/TdcAvpA+/hGoKPJa1hEDkcXCB7hhyib0q/ciHv
 VLhPbAsfbyxE/bJh4Kg6W1dQ1Qhqwck2K9Otr+XjYLuC5Rfxb2yyA5oCNK7Gev3US9Is
 wLXvzoGyJ94EBGnGt4Vsh4vRP35HmCO9LaXqUN3fsw7q4vbC/3VMHfnTEGDUzC+Uu2Fn qw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j7a7ymkuu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 08:12:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27T8CJtl018796
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 08:12:19 GMT
Received: from [10.79.136.17] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 29 Aug
 2022 01:12:14 -0700
Message-ID: <5ff21b1e-3af9-36ef-e13e-fa33f526d0e3@quicinc.com>
Date:   Mon, 29 Aug 2022 13:42:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 1/2] clk: qcom: gcc-sc7180: Keep the USB GDSC always on
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
CC:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        <linux-clk@vger.kernel.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Douglas Anderson" <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20220825182152.v2.1.I45235b7c40997bc2abf813e4722b4dcdd6aecf6b@changeid>
 <20220826024003.qpqtdmdohdmpcskt@baldur>
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
In-Reply-To: <20220826024003.qpqtdmdohdmpcskt@baldur>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: v8V2nX2IKlQtRGg1kjfk78fM8O5JEf2f
X-Proofpoint-GUID: v8V2nX2IKlQtRGg1kjfk78fM8O5JEf2f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_03,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 clxscore=1011 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208290040
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/26/2022 8:10 AM, Bjorn Andersson wrote:
> On Thu, Aug 25, 2022 at 06:21:58PM -0700, Matthias Kaehlcke wrote:
>> When the GDSC is disabled during system suspend USB is broken on
>> sc7180 when the system resumes. Mark the GDSC as always on to
>> make sure USB still works after system suspend.
>>
>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> 
> Rajendra, where you able to find some time to look into take the GDSC
> into retention state? Do you suggest that I merge these two patches for
> now?
> 

Hi Bjorn, based on my experiments to support retention on sc7280 these are
some of my findings

On Platforms which support CX retention (for example sc7180/sc7280) instead of
CX PowerCollapse (PC), We can leave the GDSC turned ON. When CX transitions to RET state
the GDSC goes into retention too (some controller state is retained) and USB wakeups work.

On platforms which support CX PC, just leaving the GDSC
turned ON will not help since the GDSC will also transition to OFF state
when we enter CX PC, hence wake-ups from USB won't work.
For such platforms we need to make sure gdsc_force_mem_on() is called
and cxcs (* @cxcs: offsets of branch registers to toggle mem/periph bits in)
are populated correctly, while leaving the GDSC turned ON.
This will make sure usb gdsc transitions from being powered by CX to MX
when CX hits PC and we still get USB wakeups to work.
So in short we could do the same thing that this patch does on those
platforms too with additionally populating the right cxcs entries and it
should just work fine.

Now the problem that I see with this approach is not with getting USB wakeups
to work in suspend, but with supporting performance state voting when
USB is active.
The last conclusion we had on that [1] was to model usb_gdsc as a subdomain of CX,
so if we do that and we model usb_gdsc as something that supports ALWAYS_ON,
we would _never_ drop the CX vote and prevent CX from going down (either to ret
or pc)

The only way I think we can solve both the USB wakeups and performance state
needs (with usb_gdsc as a subdomain of CX) is if we can model a RET state for gdsc
which sets the mem/periph bits while leaving the GDSC ON (Today the RET state sets
the mem/periph bits but turns the GDSC OFF)

That would mean a change in gdsc.c like this
---

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index d3244006c661..0fe017ba901b 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -368,6 +368,10 @@ static int _gdsc_disable(struct gdsc *sc)
         if (sc->pwrsts & PWRSTS_OFF)
                 gdsc_clear_mem_on(sc);

+       /* If the GDSC supports RET, do not explicitly power it off */
+       if (sc->pwrsts & PWRSTS_RET)
+               return 0;
+
         ret = gdsc_toggle_logic(sc, GDSC_OFF);
         if (ret)
                 return ret;


So with that change, we would then not need the ALWAYS_ON flag set for usb gdsc,
instead we would update the .pwrsts to PWRSTS_RET_ON instead of PWRSTS_OFF_ON,
and that should make both usb wake-ups to work and we can still have the usb_gdsc as
a subdomain of CX for performance state voting.
Does that sounds like a reasonable solution?

Thanks,
Rajendra

[1] https://patchwork.kernel.org/project/linux-arm-msm/patch/1630346073-7099-2-git-send-email-sanm@codeaurora.org/

> Thanks,
> Bjorn
> 
>> ---
>> I'm not entirely sure that this is the correct solution. What makes
>> me doubt is that only msm8953 sets ALWAYS_ON for the USB GDSC. Is USB
>> broken after suspend on all the other QC platforms?
>>
>> Changes in v2:
>> - set the flags of the GDSC not of the GDSC power domain
>> - updated commit message
>>
>>   drivers/clk/qcom/gcc-sc7180.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/clk/qcom/gcc-sc7180.c b/drivers/clk/qcom/gcc-sc7180.c
>> index c2ea09945c47..c0d7509a782e 100644
>> --- a/drivers/clk/qcom/gcc-sc7180.c
>> +++ b/drivers/clk/qcom/gcc-sc7180.c
>> @@ -2225,6 +2225,7 @@ static struct gdsc usb30_prim_gdsc = {
>>   		.name = "usb30_prim_gdsc",
>>   	},
>>   	.pwrsts = PWRSTS_OFF_ON,
>> +	.flags = ALWAYS_ON,
>>   };
>>   
>>   static struct gdsc hlos1_vote_mmnoc_mmu_tbu_hf0_gdsc = {
>> -- 
>> 2.37.2.672.g94769d06f0-goog
>>
