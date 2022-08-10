Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7F258F506
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 01:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbiHJX6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 19:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbiHJX6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 19:58:03 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B82753AA;
        Wed, 10 Aug 2022 16:58:02 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27ANS5tu011894;
        Wed, 10 Aug 2022 23:57:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=iKZo6L4ks80dAbx5RILErWCqMWwJ78yCTiIRsqpNI0w=;
 b=a/qivNS2b8zA43RXF6HBTCF/jVYSzkRkg+d2y7+7tsPJeGGq6anGUv7nsAt2qIsAdisn
 MlHPD8f2HEB7ArCltDIxY5DBxcn4L7V+2bXjwocXQdyDpeiQ47B8fwrUUh42Ei3RVh9G
 K0754OTB2Vb0u7c0L9w6umCQXkGNEvsCm0mJGljnQjyoDL7VGNgbkbz3w5qUq2xz30z7
 /QDfZSSUSgsc8NK9fvWCDqCmveFcchZ3Eqxp+yFE1MojzMy+m0kxjx/4ICrs1qMCELVM
 KGS1/jAQ9SL+Y8lH6ZqEATrAgl6BS6jjqHTYsu/Z+sAv0I4H8HAgfy/dLJOxqLVUuMBM +Q== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3huwr24b0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 23:57:55 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27ANvrtF004901
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 23:57:53 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 10 Aug 2022 16:57:53 -0700
Received: from [10.110.86.199] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 10 Aug
 2022 16:57:51 -0700
Message-ID: <dbda8bce-2890-e5e3-4052-073a52eb06a6@quicinc.com>
Date:   Wed, 10 Aug 2022 16:57:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] drm/msm/dp: check hpd_state before push idle pattern
 at dp_bridge_disable()
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <airlied@linux.ie>, <bjorn.andersson@linaro.org>,
        <daniel@ffwll.ch>, <dianders@chromium.org>,
        <dmitry.baryshkov@linaro.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <vkoul@kernel.org>
CC:     <quic_abhinavk@quicinc.com>, <quic_aravindh@quicinc.com>,
        <quic_sbillaka@quicinc.com>, <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1660159551-13828-1-git-send-email-quic_khsieh@quicinc.com>
 <CAE-0n533SUb3Bg=pR8Fhwo-M5qLWiti4nzLR-rSGVAsrXgEYNQ@mail.gmail.com>
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
In-Reply-To: <CAE-0n533SUb3Bg=pR8Fhwo-M5qLWiti4nzLR-rSGVAsrXgEYNQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: z5McM-bdfMc4yNFQcm4ab-8hgVxndqT7
X-Proofpoint-ORIG-GUID: z5McM-bdfMc4yNFQcm4ab-8hgVxndqT7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_16,2022-08-10_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208100072
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/10/2022 3:22 PM, Stephen Boyd wrote:
> Quoting Kuogee Hsieh (2022-08-10 12:25:51)
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index b36f8b6..678289a 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -1729,10 +1729,20 @@ void dp_bridge_disable(struct drm_bridge *drm_bridge)
>>          struct msm_dp_bridge *dp_bridge = to_dp_bridge(drm_bridge);
>>          struct msm_dp *dp = dp_bridge->dp_display;
>>          struct dp_display_private *dp_display;
>> +       u32 state;
>>
>>          dp_display = container_of(dp, struct dp_display_private, dp_display);
>>
>> +       mutex_lock(&dp_display->event_mutex);
>> +
>> +       state = dp_display->hpd_state;
>> +       if (state != ST_DISCONNECT_PENDING && state != ST_CONNECTED) {
> It's concerning that we have to check this at all. Are we still
> interjecting into the disable path when the cable is disconnected?

yes,

The problem is not from cable disconnected.

There is a corner case that this function is called at drm shutdown 
(drm_release).

At that time, mainlink is not enabled, hence dp_ctrl_push_idle() will 
cause system crash.



>> +               mutex_unlock(&dp_display->event_mutex);
>> +               return;
>> +       }
>> +
>>          dp_ctrl_push_idle(dp_display->ctrl);
>> +       mutex_unlock(&dp_display->event_mutex);
