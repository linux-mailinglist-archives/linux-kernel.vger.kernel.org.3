Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A6E58FF2F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 17:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235230AbiHKPUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 11:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234338AbiHKPUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 11:20:16 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6704BAE;
        Thu, 11 Aug 2022 08:20:12 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27BEC72l010395;
        Thu, 11 Aug 2022 15:20:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=mvGqMZ29M6mKHzOFXKXXUE2mOK3ZoxjsZdFT+QWufsw=;
 b=aZXp7OMhq/KBe3oCLz8xmfEw9sFUc2YPHZ2uf36hLpV+4Ix+QGVs6bPyh1T+2m4xKewy
 s08xISwnBbvSbvQKu0W/RgNSeQZ26BNu2tXFIe5u9iqLs7Y4mYKshra27b1EIpwoKO+L
 IBUpEOXjn+iy7yMj10lIO59XIueGX63igi5GJpYJGg7yU/qRI/ncL3tIaeqZYfYh69b+
 0nLLoz17gZ0Qe/MivjwEOj90ZsrcIvy8CyySA5v38JWVLLhh1lEtTLX3R1zBQVVmddTP
 g65M534opCcRc/LdhFr7hhvVnp/DK2AeEeAk6iZlIA+MvfuBIpgHp1z2clXbXwOpq1cz XQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hw3a6r8kj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Aug 2022 15:20:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27BFK4vM023929
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Aug 2022 15:20:04 GMT
Received: from [10.110.2.196] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 11 Aug
 2022 08:20:02 -0700
Message-ID: <1e792f49-febf-43bf-d828-8ecf99cbeba3@quicinc.com>
Date:   Thu, 11 Aug 2022 08:20:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] drm/msm/dp: check hpd_state before push idle pattern
 at dp_bridge_disable()
Content-Language: en-US
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <airlied@linux.ie>, <bjorn.andersson@linaro.org>,
        <daniel@ffwll.ch>, <dianders@chromium.org>,
        <dmitry.baryshkov@linaro.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <vkoul@kernel.org>
CC:     <quic_aravindh@quicinc.com>, <quic_sbillaka@quicinc.com>,
        <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1660159551-13828-1-git-send-email-quic_khsieh@quicinc.com>
 <CAE-0n533SUb3Bg=pR8Fhwo-M5qLWiti4nzLR-rSGVAsrXgEYNQ@mail.gmail.com>
 <dbda8bce-2890-e5e3-4052-073a52eb06a6@quicinc.com>
 <CAE-0n51NyrP8CikcK_3wj4EEsurmmSZ4RY3pLhJJmkY2_8wNZw@mail.gmail.com>
 <0641a116-5b58-4305-bf2d-f53dcb747276@quicinc.com>
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
In-Reply-To: <0641a116-5b58-4305-bf2d-f53dcb747276@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cldeAc-FsMTktDbMm3jShhqS597j0rTl
X-Proofpoint-ORIG-GUID: cldeAc-FsMTktDbMm3jShhqS597j0rTl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-11_11,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208110052
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/10/2022 6:00 PM, Abhinav Kumar wrote:
> Hi Stephen
>
> On 8/10/2022 5:09 PM, Stephen Boyd wrote:
>> Quoting Kuogee Hsieh (2022-08-10 16:57:51)
>>>
>>> On 8/10/2022 3:22 PM, Stephen Boyd wrote:
>>>> Quoting Kuogee Hsieh (2022-08-10 12:25:51)
>>>>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c 
>>>>> b/drivers/gpu/drm/msm/dp/dp_display.c
>>>>> index b36f8b6..678289a 100644
>>>>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>>>>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>>>>> @@ -1729,10 +1729,20 @@ void dp_bridge_disable(struct drm_bridge 
>>>>> *drm_bridge)
>>>>>           struct msm_dp_bridge *dp_bridge = to_dp_bridge(drm_bridge);
>>>>>           struct msm_dp *dp = dp_bridge->dp_display;
>>>>>           struct dp_display_private *dp_display;
>>>>> +       u32 state;
>>>>>
>>>>>           dp_display = container_of(dp, struct dp_display_private, 
>>>>> dp_display);
>>>>>
>>>>> +       mutex_lock(&dp_display->event_mutex);
>>>>> +
>>>>> +       state = dp_display->hpd_state;
>>>>> +       if (state != ST_DISCONNECT_PENDING && state != 
>>>>> ST_CONNECTED) {
>>>> It's concerning that we have to check this at all. Are we still
>>>> interjecting into the disable path when the cable is disconnected?
>>>
>>> yes,
>>>
>>> The problem is not from cable disconnected.
>>>
>>> There is a corner case that this function is called at drm shutdown
>>> (drm_release).
>>>
>>> At that time, mainlink is not enabled, hence dp_ctrl_push_idle() will
>>> cause system crash.
>>
>> The mainlink is only disabled when the cable is disconnected though?
>>
>> Let me put it this way, if we have to check that the state is
>> "connected" or "disconnected pending" in the disable path then there's
>> an issue where this driver is being called in unexpected ways. This
>> driver is fighting the drm core each time there's a state check. We
>> really need to get rid of the state tracking entirely, and make sure
>> that the drm core is calling into the driver at the right time, i.e.
>> bridge disable is only called when the mainlink is enabled, etc.
>
> So if link training failed, we do not send a uevent to usermode and 
> will bail out here:
>
>         rc = dp_ctrl_on_link(dp->ctrl);
>         if (rc) {
>                 DRM_ERROR("failed to complete DP link training\n");
>                 goto end;
>         }
>
> So this commit is not coming from usermode but from the drm_release() 
> path.
>
> Even then, you do have a valid point. DRM framework should not have 
> caused the disable path to happen without an enable.
>
> I went through the stack mentioned in the issue.
>
> Lets see this part of the stack:
>
> dp_ctrl_push_idle+0x40/0x88
>  dp_bridge_disable+0x24/0x30
>  drm_atomic_bridge_chain_disable+0x90/0xbc
>  drm_atomic_helper_commit_modeset_disables+0x198/0x444
>  msm_atomic_commit_tail+0x1d0/0x374
>
> In drm_atomic_helper_commit_modeset_disables(), we call 
> disable_outputs().
>
> AFAICT, this is the only place which has a protection to not call the 
> disable() flow if it was not enabled here:
>
> https://gitlab.freedesktop.org/drm/msm/-/blob/msm-next/drivers/gpu/drm/drm_atomic_helper.c#L1063 
>
>
> But that function is only checking crtc_state->active. Thats set by 
> the usermode:
>
> https://gitlab.freedesktop.org/drm/msm/-/blob/msm-next/drivers/gpu/drm/drm_atomic_uapi.c#L407 
>
>
> Now, if usermode sets that to true and then crashed it can bypass this 
> check and we will crash in the location kuogee is trying to fix.
>
> From the issue mentioned in 
> https://gitlab.freedesktop.org/drm/msm/-/issues/17, the reporter did 
> mention the usermode crashed.
>
> So this is my tentative analysis of whats happening here.
>
> Ideally yes, we should have been protected by the location mentioned 
> above in disable_outputs() but looks to me due to the above hypothesis 
> its getting bypassed.
>
> Thanks
>
> Abhinav
>
>
Ii sound likes that there is a hole either at user space or drm.

But that should not cause dp_bridge_disable() at dp driver to crash.

Therefore it is properly to check hdp_state condition at 
dp_bridge_disable() to prevent it from crashing.


