Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED554D0272
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 16:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236748AbiCGPIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 10:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243228AbiCGPH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:07:56 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63199026A;
        Mon,  7 Mar 2022 07:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646665622; x=1678201622;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6AQwE+jmfCO74IkfUnD2IOLWGBmz47IqloHLSUaMxLU=;
  b=cx+Yg+bTFB7ymWgycj+3m1rnnidfZhBXHGNocbvs3dlX7uTjhsEVZu7z
   FoWpJnbk2eU3U2Ol4aORsuiu3nfkN1HiR48o7cyUHZ1zpHyyVPmTt6OB/
   b5eMxEFnnKXfWwBqE8UazQ/hF+/arld5fHBS2No5fbk8N9kUTve+8/rI6
   I=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 07 Mar 2022 07:07:02 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 07:07:01 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 7 Mar 2022 07:07:00 -0800
Received: from [10.216.32.253] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Mon, 7 Mar 2022
 07:06:53 -0800
Message-ID: <d73734e8-7ab2-e1bb-540a-3d8252482982@quicinc.com>
Date:   Mon, 7 Mar 2022 20:36:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 0/4] drm/msm: Clear perf counters across context switch
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, <dri-devel@lists.freedesktop.org>
CC:     <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        Emma Anholt <emma@anholt.net>,
        Jonathan Marek <jonathan@marek.ca>,
        open list <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>
References: <20220304005317.776110-1-robdclark@gmail.com>
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
In-Reply-To: <20220304005317.776110-1-robdclark@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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

On 3/4/2022 6:22 AM, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
>
> Some clever folks figured out a way to use performance counters as a
> side-channel[1].  But, other than the special case of using the perf
> counters for system profiling, we can reset the counters across context
> switches to protect against this.
>
> This series introduces a SYSPROF param which a sufficiently privilaged
> userspace (like Mesa's pps-producer, which already must run as root) to
> opt-out, and makes the default behavior to reset counters on context
> switches.
>
> [1] https://dl.acm.org/doi/pdf/10.1145/3503222.3507757
>
> Rob Clark (4):
>    drm/msm: Update generated headers
>    drm/msm: Add SET_PARAM ioctl
>    drm/msm: Add SYSPROF param (v2)
>    drm/msm/a6xx: Zap counters across context switch
>
>   drivers/gpu/drm/msm/adreno/a2xx.xml.h         |  26 +-
>   drivers/gpu/drm/msm/adreno/a2xx_gpu.c         |   1 +
>   drivers/gpu/drm/msm/adreno/a3xx.xml.h         |  30 +-
>   drivers/gpu/drm/msm/adreno/a3xx_gpu.c         |   1 +
>   drivers/gpu/drm/msm/adreno/a4xx.xml.h         | 112 ++-
>   drivers/gpu/drm/msm/adreno/a4xx_gpu.c         |   1 +
>   drivers/gpu/drm/msm/adreno/a5xx.xml.h         |  63 +-
>   drivers/gpu/drm/msm/adreno/a5xx_gpu.c         |   1 +
>   drivers/gpu/drm/msm/adreno/a6xx.xml.h         | 674 +++++++++++-------
>   drivers/gpu/drm/msm/adreno/a6xx_gmu.xml.h     |  26 +-
>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c         |  30 +
>   .../gpu/drm/msm/adreno/adreno_common.xml.h    |  31 +-
>   drivers/gpu/drm/msm/adreno/adreno_gpu.c       |  14 +
>   drivers/gpu/drm/msm/adreno/adreno_gpu.h       |   2 +
>   drivers/gpu/drm/msm/adreno/adreno_pm4.xml.h   |  46 +-
>   drivers/gpu/drm/msm/disp/mdp4/mdp4.xml.h      |  37 +-
>   drivers/gpu/drm/msm/disp/mdp5/mdp5.xml.h      |  37 +-
>   drivers/gpu/drm/msm/disp/mdp_common.xml.h     |  37 +-
>   drivers/gpu/drm/msm/dsi/dsi.xml.h             |  37 +-
>   drivers/gpu/drm/msm/dsi/dsi_phy_10nm.xml.h    |  37 +-
>   drivers/gpu/drm/msm/dsi/dsi_phy_14nm.xml.h    |  37 +-
>   drivers/gpu/drm/msm/dsi/dsi_phy_20nm.xml.h    |  37 +-
>   drivers/gpu/drm/msm/dsi/dsi_phy_28nm.xml.h    |  37 +-
>   .../gpu/drm/msm/dsi/dsi_phy_28nm_8960.xml.h   |  37 +-
>   drivers/gpu/drm/msm/dsi/dsi_phy_5nm.xml.h     | 480 -------------
>   drivers/gpu/drm/msm/dsi/dsi_phy_7nm.xml.h     |  43 +-
>   drivers/gpu/drm/msm/dsi/mmss_cc.xml.h         |  37 +-
>   drivers/gpu/drm/msm/dsi/sfpb.xml.h            |  37 +-
>   drivers/gpu/drm/msm/hdmi/hdmi.xml.h           |  37 +-
>   drivers/gpu/drm/msm/hdmi/qfprom.xml.h         |  37 +-
>   drivers/gpu/drm/msm/msm_drv.c                 |  28 +
>   drivers/gpu/drm/msm/msm_gpu.c                 |   2 +
>   drivers/gpu/drm/msm/msm_gpu.h                 |  29 +
>   drivers/gpu/drm/msm/msm_submitqueue.c         |  39 +
>   include/uapi/drm/msm_drm.h                    |  28 +-
>   35 files changed, 1058 insertions(+), 1130 deletions(-)
>   delete mode 100644 drivers/gpu/drm/msm/dsi/dsi_phy_5nm.xml.h
>

For the whole series except " drm/msm: Update generated headers",

Reviewed-by: Akhil P Oommen <quic_akhilpo@quicinc.com>

-Akhil.

