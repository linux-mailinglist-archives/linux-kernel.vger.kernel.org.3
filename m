Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8FE56AD45
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 23:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbiGGVLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 17:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiGGVLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 17:11:15 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579151FCEC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 14:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657228274; x=1688764274;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8cWXuoA3a8r8Bn5R5HljIheMcXCj6sEHWX+Ss3Kqdjo=;
  b=j1MDjPgs0YEAhn6pr6CWSI6aYy6TKOOI8kTUs6Gk6FC7vBrIGFZtfUX8
   Z27CGKiXwusRZ0eRXQRl5udE0VMfXRyjFYWnmuZQPxxYm8YK6HgQXxbHx
   YAZexXm0TQaWrM8AfKx1iEPzpQlvlshooYJOASElh1PwUQpJ8o+q6VmLX
   c=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 07 Jul 2022 14:11:14 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 14:11:13 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 7 Jul 2022 14:11:13 -0700
Received: from [10.111.163.64] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 7 Jul 2022
 14:11:10 -0700
Message-ID: <40b6a28c-0237-55d7-2f5d-1c571f27e7d6@quicinc.com>
Date:   Thu, 7 Jul 2022 14:11:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] drm/msm/dsi: Set panel orientation when directly
 connected
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <patches@lists.linux.dev>,
        Sean Paul <sean@poorly.run>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
References: <20220706191442.1150634-1-swboyd@chromium.org>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20220706191442.1150634-1-swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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



On 7/6/2022 12:14 PM, Stephen Boyd wrote:
> Set the panel orientation in drm when the panel is directly connected,
> i.e. we're not using an external bridge. The external bridge case is
> already handled by the panel bridge code, so we only update the path we
> take when the panel is directly connected/internal. This silences a
> warning splat coming from __drm_mode_object_add() on Wormdingler boards.
> 
> Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
> 
> This relies on commit 5e41b01a7808 ("drm/panel: Add an API to allow drm
> to set orientation from panel") which is in drm-misc
> 
>   drivers/gpu/drm/msm/dsi/dsi_manager.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
> index cb84d185d73a..9333f7095acd 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
> @@ -268,6 +268,8 @@ static int msm_dsi_manager_panel_init(struct drm_connector *conn, u8 id)
>   		return PTR_ERR(panel);
>   	}
>   
> +	drm_connector_set_orientation_from_panel(conn, panel);
> +

This should be moved below the !panel check since you are passing panel 
as one of the params.

I looked up the doc and it says that for unknown(default cases) this is 
a no-op so I think this change is fine otherwise.

"It is allowed to call this function with a panel_orientation of 
DRM_MODE_PANEL_ORIENTATION_UNKNOWN, in which case it is a no-op."


>   	if (!panel || !IS_BONDED_DSI())
>   		goto out;
>   
> 
> base-commit: 15b9ca1641f0c3cd74885280331e9172c62a125e
