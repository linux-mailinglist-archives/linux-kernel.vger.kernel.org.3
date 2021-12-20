Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE8147B3F6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 20:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbhLTTvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 14:51:41 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:10056 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231869AbhLTTvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 14:51:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640029900; x=1671565900;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SWkrRsfh5wkH/U4hnyc7GU2xLX7B1JNAMj60e3Mc2UA=;
  b=ZEc+aK0tAh/uSmowd9kDCXtmMn/YVX0u33QWU3MDlGrDSFyxGP7HJTv8
   rs8uuFCHB+EYIYDk9JR2H4kQW5kM+7Ivc6ZkBhB+cVPBLatje/3bxs7gS
   mMkMSdokIsQxbDRCT+MltWhSKhu3go8Qn8MuLrElFMyApwPNjghw09ezu
   4=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 20 Dec 2021 11:51:39 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 11:51:38 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 20 Dec 2021 11:51:38 -0800
Received: from [10.111.163.90] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 20 Dec
 2021 11:51:36 -0800
Message-ID: <f9521a5f-13cd-a379-3502-5590fd9c331c@quicinc.com>
Date:   Mon, 20 Dec 2021 11:51:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2] drm/msm/dp: Only create debugfs for PRIMARY minor
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20211217002026.2304973-1-bjorn.andersson@linaro.org>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20211217002026.2304973-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/16/2021 4:20 PM, Bjorn Andersson wrote:
> dpu_kms_debugfs_init() is invoked for each minor being registered. Most
> of the files created are unrelated to the minor, so there's no reason to
> present them per minor.
> The exception to this is the DisplayPort code, which ends up invoking
> dp_debug_get() for each minor, each time associate the allocated object
> with dp->debug.
> 
> As such dp_debug will create debugfs files in both the PRIMARY and the
> RENDER minor's debugfs directory, but only the last reference will be
> remembered.
> 
> The only use of this reference today is in the cleanup path in
> dp_display_deinit_sub_modules() and the dp_debug_private object does
> outlive the debugfs entries in either case, so there doesn't seem to be
> any adverse effects of this, but per the code the current behavior is
> unexpected, so change it to only create debugfs files for the PRIMARY
> minor.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v1:
> - Moved the check up from msm_dp_debugfs_init() to dpu_kms_debugfs_init()
> 
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> index 2ee70072a1b4..a54f7d373f14 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -193,6 +193,10 @@ static int dpu_kms_debugfs_init(struct msm_kms *kms, struct drm_minor *minor)
>   	if (!p)
>   		return -EINVAL;
>   
> +	/* Only create one set of debugfs per DP instance */
I would change this to DPU now instead of DP, but apart from that,

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> +	if (minor->type != DRM_MINOR_PRIMARY)
> +		return 0;
> +
>   	dev = dpu_kms->dev;
>   	priv = dev->dev_private;
>   
