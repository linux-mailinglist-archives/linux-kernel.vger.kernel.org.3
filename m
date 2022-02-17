Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E544BABFD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 22:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343687AbiBQVoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 16:44:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244859AbiBQVoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 16:44:38 -0500
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48193F11A5;
        Thu, 17 Feb 2022 13:44:22 -0800 (PST)
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 1F7943F7D5;
        Thu, 17 Feb 2022 22:44:19 +0100 (CET)
Date:   Thu, 17 Feb 2022 22:44:17 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Rob Clark <robdclark@gmail.com>, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: Re: [REPOST PATCH v4 10/13] drm/msm/disp/dpu1: Add support for DSC
 in topology
Message-ID: <20220217214417.hb6sdx53cs36us6j@SoMainline.org>
References: <20220210103423.271016-1-vkoul@kernel.org>
 <20220210103423.271016-11-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210103423.271016-11-vkoul@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-10 16:04:20, Vinod Koul wrote:
> For DSC to work we typically need a 2,2,1 configuration. This should
> suffice for resolutions up to 4k. For more resolutions like 8k this won't
> work.
> 
> Also, it is better to use 2 LMs and DSC instances as half width results
> in lesser power consumption as compared to single LM, DSC at full width.
> 
> The panel has been tested only with 2,2,1 configuration, so for
> now we blindly create 2,2,1 topology when DSC is enabled
> 
> Co-developed-by: Abhinav Kumar <abhinavk@codeaurora.org>
> Signed-off-by: Abhinav Kumar <abhinavk@codeaurora.org>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 13 +++++++++++++
>  drivers/gpu/drm/msm/msm_drv.h               |  2 ++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 95a7bf362e81..13ccb7b3cce5 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -574,8 +574,21 @@ static struct msm_display_topology dpu_encoder_get_topology(
>  	topology.num_enc = 0;
>  	topology.num_intf = intf_count;
>  
> +	if (dpu_enc->dsc) {
> +		/* In case of Display Stream Compression DSC, we would use
> +		 * 2 encoders, 2 line mixers and 1 interface

LM is a layer mixer, not a line mixer, right?

- Marijn

> +		 * this is power optimal and can drive up to (including) 4k
> +		 * screens
> +		 */
> +		topology.num_enc = 2;
> +		topology.num_dsc = 2;
> +		topology.num_intf = 1;
> +		topology.num_lm = 2;
> +	}
> +
>  	return topology;
>  }
> +
>  static int dpu_encoder_virt_atomic_check(
>  		struct drm_encoder *drm_enc,
>  		struct drm_crtc_state *crtc_state,
> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
> index 6425a42e997c..994d895d1a47 100644
> --- a/drivers/gpu/drm/msm/msm_drv.h
> +++ b/drivers/gpu/drm/msm/msm_drv.h
> @@ -103,12 +103,14 @@ enum msm_event_wait {
>   * @num_enc:      number of compression encoder blocks used
>   * @num_intf:     number of interfaces the panel is mounted on
>   * @num_dspp:     number of dspp blocks used
> + * @num_dsc:      number of Display Stream Compression (DSC) blocks used
>   */
>  struct msm_display_topology {
>  	u32 num_lm;
>  	u32 num_enc;
>  	u32 num_intf;
>  	u32 num_dspp;
> +	u32 num_dsc;
>  };
>  
>  /**
> -- 
> 2.31.1
> 
