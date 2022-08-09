Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2527C58E23A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 23:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiHIV4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 17:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiHIV4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 17:56:11 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9F658B7F;
        Tue,  9 Aug 2022 14:56:10 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 279Ln5kx027770;
        Tue, 9 Aug 2022 21:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KfXbjISCUdq06jYNuHW3+YFzL7esvOy0QikEIg52o18=;
 b=NG6TTFVaFQF+tH/giE6VlFHG+VKtwL7uigQLmWayHGvQfkAbVxqgKlG4I8b9Ls5r3G6U
 rh5wZV8YZrry3irBG33yw+Ga/3QzTMxQ3yFpyz3K8A1SpIgIIZiDtrpiclh+MMijwJmW
 TxUzskodc4mGkydwWWHDPWIHxF/P8oRvIfsS/OWHr+qwZ3iR/HbI+tUre8UaqkQznpIO
 elUZFvt/8U2qJXQ7un3qM8VD1N3ZE3yKDBFOSFzRj483OqXQ2aEpSJhgwsLz+BGDfu/S
 SQcnMbiGpQ0C3IIQrsKmNhMilsCEdVxdl+t4jko4R0h4vNBfWF98ScOTHPYFFa/PkPvN og== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3huwr208fn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 21:56:03 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 279Lu29a008405
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 9 Aug 2022 21:56:02 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 9 Aug 2022 14:56:01 -0700
Received: from [10.111.167.201] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 9 Aug 2022
 14:55:57 -0700
Message-ID: <f557ccdb-f6b1-dcac-ec96-1b4863534b96@quicinc.com>
Date:   Tue, 9 Aug 2022 14:55:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] drm/msm/dp: check hpd_state before push idle pattern at
 dp_bridge_disable()
Content-Language: en-US
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@linux.ie>,
        <agross@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <bjorn.andersson@linaro.org>
CC:     <quic_aravindh@quicinc.com>, <quic_sbillaka@quicinc.com>,
        <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1660077890-31622-1-git-send-email-quic_khsieh@quicinc.com>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <1660077890-31622-1-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7xNazNkWyAoCs7_QYU5z9gEs4-R40tCL
X-Proofpoint-ORIG-GUID: 7xNazNkWyAoCs7_QYU5z9gEs4-R40tCL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_05,2022-08-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208090080
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/9/2022 1:44 PM, Kuogee Hsieh wrote:
> dp_bridge_disable() is the first step toward tearing down main link.
> Its major function is to start transmitting idle pattern to replace
> video stream. This patch will check hpd_state to make sure main link
> is enabled before commit changes of main link's configuration to
> push idle pattern out to avoid system crashing due to main link clock
> is disabled while access main link registers.
> 
> Fixes: 13ea4799a81b ("drm/msm/dp: remove extra wrappers and public functions");
there should be no ; at the end
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> 
> Reported-by: Leonard Lausen @leezu

We should check the email address of the reporter , this is not right.

> ---
>   drivers/gpu/drm/msm/dp/dp_display.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index b36f8b6..678289a 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1729,10 +1729,20 @@ void dp_bridge_disable(struct drm_bridge *drm_bridge)
>   	struct msm_dp_bridge *dp_bridge = to_dp_bridge(drm_bridge);
>   	struct msm_dp *dp = dp_bridge->dp_display;
>   	struct dp_display_private *dp_display;
> +	u32 state;
>   
>   	dp_display = container_of(dp, struct dp_display_private, dp_display);
>   
> +	mutex_lock(&dp_display->event_mutex);
> +
> +	state = dp_display->hpd_state;
> +	if (state != ST_DISCONNECT_PENDING && state != ST_CONNECTED) {
> +		mutex_unlock(&dp_display->event_mutex);
> +		return;
> +	}
> +
>   	dp_ctrl_push_idle(dp_display->ctrl);
> +	mutex_unlock(&dp_display->event_mutex);
>   }
>   
>   void dp_bridge_post_disable(struct drm_bridge *drm_bridge)
