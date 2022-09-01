Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE0B5A8D81
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 07:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbiIAFqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 01:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbiIAFqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 01:46:35 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16891166CD;
        Wed, 31 Aug 2022 22:46:34 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2814rY4G011867;
        Thu, 1 Sep 2022 05:46:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=sRKo7gVcdBGY7W+F+Mm6xDnO7j85vrVM+3Sm1aNdMBg=;
 b=Rf0RE67szHwXBlQT0+LhnyhYyMUwFeHPls2HtGaU9STboipearH62PI3qOXwcRVs7Rre
 dL9WQacewrEFl8auCdwijbSOicyBFOgHUBYGc7UWYUAXwP742eUN8gsg63Z6AhcaenGY
 smDh9AZYgHxN1G/fUWfWEy6CKvxQVtD33LRwEWiUCPtPH9IQaBQVL4MARfU0vqTYcinN
 HTS7z51rTvkGJEkjczVrNNKp0IIs25O+DBSj+2eJt4ehVUYKfw7+v2SB68tlnwde3Wew
 ZDM9CyDH7xEPpnakqV+L2V1D8zvacm4pWY5ECCbNkYSef+8nNvnbHxrkRqnGJGJvu+QW mg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jabqk1x67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 05:46:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2815kJ7T021064
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Sep 2022 05:46:19 GMT
Received: from [10.216.20.19] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 31 Aug
 2022 22:46:14 -0700
Message-ID: <095d3acb-b04f-3d24-3f00-b8974bdc2648@quicinc.com>
Date:   Thu, 1 Sep 2022 11:16:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 1/2] clk: qcom: gcc-sc7180: Keep the USB GDSC always on
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
CC:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        <linux-clk@vger.kernel.org>,
        "Krishna Kurapati" <quic_kriskura@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20220825182152.v2.1.I45235b7c40997bc2abf813e4722b4dcdd6aecf6b@changeid>
 <20220826024003.qpqtdmdohdmpcskt@baldur>
 <5ff21b1e-3af9-36ef-e13e-fa33f526d0e3@quicinc.com>
 <20220830213533.7C4FCC433C1@smtp.kernel.org>
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
In-Reply-To: <20220830213533.7C4FCC433C1@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mwyw4FGOe0iGPJxgTstQ6Af0hLE5x5Bs
X-Proofpoint-ORIG-GUID: mwyw4FGOe0iGPJxgTstQ6Af0hLE5x5Bs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_03,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209010024
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/31/2022 3:05 AM, Stephen Boyd wrote:
> Quoting Rajendra Nayak (2022-08-29 01:12:02)
>> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
>> index d3244006c661..0fe017ba901b 100644
>> --- a/drivers/clk/qcom/gdsc.c
>> +++ b/drivers/clk/qcom/gdsc.c
>> @@ -368,6 +368,10 @@ static int _gdsc_disable(struct gdsc *sc)
>>           if (sc->pwrsts & PWRSTS_OFF)
>>                   gdsc_clear_mem_on(sc);
>>
>> +       /* If the GDSC supports RET, do not explicitly power it off */
>> +       if (sc->pwrsts & PWRSTS_RET)
>> +               return 0;
>> +
>>           ret = gdsc_toggle_logic(sc, GDSC_OFF);
>>           if (ret)
>>                   return ret;
>>
>>
>> So with that change, we would then not need the ALWAYS_ON flag set for usb gdsc,
>> instead we would update the .pwrsts to PWRSTS_RET_ON instead of PWRSTS_OFF_ON,
>> and that should make both usb wake-ups to work and we can still have the usb_gdsc as
>> a subdomain of CX for performance state voting.
> 
> To clarify, usb_gdsc is not setup as a subdomain of CX so far, right?
> Just that eventually we'll make usb_gdsc a subdomain of CX so that
> dev_pm_opp_set_rate() can target the CX domain instead of the usb one?

Thats right,

> 
>> Does that sounds like a reasonable solution?
> 
> It sounds good to me. What about the existing users of PWRSTS_RET

hmm, I thought no ones been actually using PWRSTS_RET but looks like
there is *one* user on msm8974, I'll need to dig up how this change would
affect it,

> though? If I understand correctly this flag means the domain will never
> be turned off, instead it will hit retention during low power modes.

right,

> 
> While you're crafting this patch can you also document the PWRSTS_*
> defines so that we know what they mean? I can guess that PWRSTS_RET
> means "retention" but I don't know what it really means. I guess it
> means "Deepest power off state is retention of memory cells".

Sure I will update the PWRSTS_RET description. The definition of 'retention'
here I think remains the same, it means memory is retained (if RETAIN_MEM is set)
or memory *and* some part of logic is retained (if both RETAIN_MEM and RETAIN_PERIPH
are set) in Deepest power off state, however there is a disconnected in terms of
'how to enter the retention state' for a given domain.
There is no SW control to enter the retention state and this happens in HW when the
parent domain/rail transitions to low power. Either the parents lowest power state
is also retention (like is the case with sc7180/sc7280 for usb with cx as parent) or the
parent makes sure it hands the domain over to another parent (CX to MX in some cases)
to support retention.




   

