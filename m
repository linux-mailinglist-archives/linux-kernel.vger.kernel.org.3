Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F3B547042
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 01:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348133AbiFJXcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 19:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbiFJXcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 19:32:19 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB47289731;
        Fri, 10 Jun 2022 16:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654903938; x=1686439938;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=w/FOh0Rryq87K89eHJ8OClXAVl0+b6TmG4Pvq3oySnw=;
  b=jGzHwKuHLVBrYNWojn+WYa8NwDU7561BCuHqa3dIF8RN0FR7vOZai1Vh
   JSO/49WAp5clKYZlGVP0BsBM1lPRDO3FDX1oSFTN+CKsdvrJ0NKBuA0e/
   fNUuZVRIApUjnbZbuwG8kh0k1WmyKzrstP3qA7OSJwgR+I0iaHVDP1XMB
   c=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 10 Jun 2022 16:32:17 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 16:32:17 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 10 Jun 2022 16:32:16 -0700
Received: from [10.38.242.187] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 10 Jun
 2022 16:32:13 -0700
Message-ID: <92f47c6f-779c-d651-b4c0-6eade1a2653a@quicinc.com>
Date:   Fri, 10 Jun 2022 16:32:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] drm/msm/dsi: Use single function for reset
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, <dri-devel@lists.freedesktop.org>
CC:     <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Vinod Koul <vkoul@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jonathan Marek <jonathan@marek.ca>,
        <linux-arm-msm@vger.kernel.org>, <freedreno@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
References: <20220610220259.220622-1-luca@z3ntu.xyz>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20220610220259.220622-1-luca@z3ntu.xyz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/10/2022 3:02 PM, Luca Weiss wrote:
> From: Vladimir Lypak <vladimir.lypak@gmail.com>
> 
> There is currently two function for performing reset: dsi_sw_reset and
> dsi_sw_reset_restore. Only difference betwean those is that latter one
betwean --> between
> assumes that DSI controller is enabled. In contrary former one assumes
> that controller is disabled and executed during power-on. However this
> assumtion is not true mobile devices which have boot splash set up by
> boot-loader.
> 
> This patch removes dsi_sw_reset_restore and makes dsi_sw_reset disable
> DSI controller during reset sequence if it's enabled.
> 
> Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>

Otherwise, looks good to me,

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>   drivers/gpu/drm/msm/dsi/dsi_host.c | 48 +++++++++++++-----------------
>   1 file changed, 21 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index a95d5df52653..bab2634ebd11 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -1080,12 +1080,32 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>   
>   static void dsi_sw_reset(struct msm_dsi_host *msm_host)
>   {
> +	u32 ctrl;
> +
> +	ctrl = dsi_read(msm_host, REG_DSI_CTRL);
> +
> +	if (ctrl & DSI_CTRL_ENABLE) {
> +		dsi_write(msm_host, REG_DSI_CTRL, ctrl & ~DSI_CTRL_ENABLE);
> +		/*
> +		 * dsi controller need to be disabled before
> +		 * clocks turned on
> +		 */
> +		wmb();
> +	}
> +
>   	dsi_write(msm_host, REG_DSI_CLK_CTRL, DSI_CLK_CTRL_ENABLE_CLKS);
>   	wmb(); /* clocks need to be enabled before reset */
>   
> +	/* dsi controller can only be reset while clocks are running */
>   	dsi_write(msm_host, REG_DSI_RESET, 1);
>   	msleep(DSI_RESET_TOGGLE_DELAY_MS); /* make sure reset happen */
>   	dsi_write(msm_host, REG_DSI_RESET, 0);
> +	wmb(); /* controller out of reset */
> +
> +	if (ctrl & DSI_CTRL_ENABLE) {
> +		dsi_write(msm_host, REG_DSI_CTRL, ctrl);
> +		wmb();	/* make sure dsi controller enabled again */
> +	}
>   }
>   
>   static void dsi_op_mode_config(struct msm_dsi_host *msm_host,
> @@ -1478,32 +1498,6 @@ static int dsi_cmds2buf_tx(struct msm_dsi_host *msm_host,
>   	return len;
>   }
>   
> -static void dsi_sw_reset_restore(struct msm_dsi_host *msm_host)
> -{
> -	u32 data0, data1;
> -
> -	data0 = dsi_read(msm_host, REG_DSI_CTRL);
> -	data1 = data0;
> -	data1 &= ~DSI_CTRL_ENABLE;
> -	dsi_write(msm_host, REG_DSI_CTRL, data1);
> -	/*
> -	 * dsi controller need to be disabled before
> -	 * clocks turned on
> -	 */
> -	wmb();
> -
> -	dsi_write(msm_host, REG_DSI_CLK_CTRL, DSI_CLK_CTRL_ENABLE_CLKS);
> -	wmb();	/* make sure clocks enabled */
> -
> -	/* dsi controller can only be reset while clocks are running */
> -	dsi_write(msm_host, REG_DSI_RESET, 1);
> -	msleep(DSI_RESET_TOGGLE_DELAY_MS); /* make sure reset happen */
> -	dsi_write(msm_host, REG_DSI_RESET, 0);
> -	wmb();	/* controller out of reset */
> -	dsi_write(msm_host, REG_DSI_CTRL, data0);
> -	wmb();	/* make sure dsi controller enabled again */
> -}
> -
>   static void dsi_hpd_worker(struct work_struct *work)
>   {
>   	struct msm_dsi_host *msm_host =
> @@ -1520,7 +1514,7 @@ static void dsi_err_worker(struct work_struct *work)
>   
>   	pr_err_ratelimited("%s: status=%x\n", __func__, status);
>   	if (status & DSI_ERR_STATE_MDP_FIFO_UNDERFLOW)
> -		dsi_sw_reset_restore(msm_host);
> +		dsi_sw_reset(msm_host);
>   
>   	/* It is safe to clear here because error irq is disabled. */
>   	msm_host->err_work_state = 0;
