Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C2152280F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 02:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234466AbiEKABe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 20:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238927AbiEKABb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 20:01:31 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83114819A0;
        Tue, 10 May 2022 17:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652227287; x=1683763287;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7RHRssae2FRX5psk74Xv8tmjt+FT1A3nY8e9aWoktGc=;
  b=mVhIvLU3WHMvsiHzsfV1gMRgrt9ZhOUhh5H66ZEsIxwdMB6+xyH7tyf9
   Dz/mAVs79mOOG4kqAWs0bhQ3Xs2/1Hxyv+6ujPbfpl4eGmcGaY4c+dRIH
   +PhnJIW+3EPl2TfJllTOVU9Mh60952V/2Ow+VI8DtxEQD3xpKu07Y2nen
   U=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 10 May 2022 17:01:27 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 17:01:28 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 10 May 2022 17:00:56 -0700
Received: from [10.38.241.82] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 10 May
 2022 17:00:52 -0700
Message-ID: <228732a3-47d4-c97c-a016-a14013dc13d8@quicinc.com>
Date:   Tue, 10 May 2022 17:00:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2] drm/probe-helper: Default to 640x480 if no EDID
Content-Language: en-US
To:     Douglas Anderson <dianders@chromium.org>,
        <dri-devel@lists.freedesktop.org>
CC:     <robdclark@gmail.com>, <swboyd@chromium.org>,
        <quic_aravindh@quicinc.com>, <ville.syrjala@linux.intel.com>,
        <tzimmermann@suse.de>, <linux-arm-msm@vger.kernel.org>,
        <jani.nikula@linux.intel.com>, <quic_sbillaka@quicinc.com>,
        <dmitry.baryshkov@linaro.org>, <freedreno@lists.freedesktop.org>,
        <quic_khsieh@quicinc.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220510135101.v2.1.I31ec454f8d4ffce51a7708a8092f8a6f9c929092@changeid>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20220510135101.v2.1.I31ec454f8d4ffce51a7708a8092f8a6f9c929092@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/10/2022 1:51 PM, Douglas Anderson wrote:
> If we're unable to read the EDID for a display because it's corrupt /
> bogus / invalid then we'll add a set of standard modes for the
> display. When userspace looks at these modes it doesn't really have a
> good concept for which mode to pick and it'll likely pick the highest
> resolution one by default. That's probably not ideal because the modes
> were purely guesses on the part of the Linux kernel.
> 
> Let's instead set 640x480 as the "preferred" mode when we have no EDID.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
> Note that this is the second of two related and similar-sounding but
> different patches. See also ("drm/probe-helper: For DP, add 640x480 if
> all other modes are bad") [1]. I'm hoping to land _both_ of the
> patches since they address different issues. This patch addresses the
> case of a corrupt EDID and having 640x480 be the default in the
> "guessed" modes. The other patch handles the case where the EDID
> _isn't_ corrupt but all the modes listed can't be made with the
> existing situations. The two patches can land in either order.
> 
> Also note that I didn't carry any Tested-by / Reviewed-by tags since
> the patch is now quite different.
> 
> [1] https://lore.kernel.org/r/20220510131309.v2.2.I4ac7f55aa446699f8c200a23c10463256f6f439f@changeid
> 
> Changes in v2:
> - Don't modify drm_add_modes_noedid() 'cause that'll break others
> - Set 640x480 as preferred in drm_helper_probe_single_connector_modes()
> 
>   drivers/gpu/drm/drm_probe_helper.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
> index 682359512996..1fbb9a8c315c 100644
> --- a/drivers/gpu/drm/drm_probe_helper.c
> +++ b/drivers/gpu/drm/drm_probe_helper.c
> @@ -516,8 +516,17 @@ int drm_helper_probe_single_connector_modes(struct drm_connector *connector,
>   		count = drm_add_override_edid_modes(connector);
>   
>   	if (count == 0 && (connector->status == connector_status_connected ||
> -			   connector->status == connector_status_unknown))
> +			   connector->status == connector_status_unknown)) {
>   		count = drm_add_modes_noedid(connector, 1024, 768);
> +
> +		/*
> +		 * Give userspace a hint that we don't have a lot of confidence
> +		 * in these modes (we totally guessed) by marking 640x480 as
> +		 * preferred. This is low clock rate and incredibly common as
> +		 * a failsafe mode.
> +		 */
> +		drm_set_preferred_mode(connector, 640, 480);
> +	}
>   	count += drm_helper_probe_add_cmdline_mode(connector);
>   	if (count == 0)
>   		goto prune;
