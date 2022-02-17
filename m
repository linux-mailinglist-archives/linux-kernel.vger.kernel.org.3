Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982D84BAC79
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 23:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343792AbiBQWUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 17:20:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244857AbiBQWUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 17:20:44 -0500
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [5.144.164.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B37B166E01
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 14:20:27 -0800 (PST)
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 7C0EA3F810;
        Thu, 17 Feb 2022 23:20:25 +0100 (CET)
Date:   Thu, 17 Feb 2022 23:20:24 +0100
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
Subject: Re: [REPOST PATCH v4 06/13] drm/msm/disp/dpu1: Add DSC support in
 hw_ctl
Message-ID: <20220217222024.mf4cmgtpvvg3bftm@SoMainline.org>
References: <20220210103423.271016-1-vkoul@kernel.org>
 <20220210103423.271016-7-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210103423.271016-7-vkoul@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-10 16:04:16, Vinod Koul wrote:
> Later gens of hardware have DSC bits moved to hw_ctl, so configure these
> bits so that DSC would work there as well
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c | 11 ++++++++++-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h |  2 ++
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> index 02da9ecf71f1..49659165cea8 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> @@ -25,6 +25,8 @@
>  #define   CTL_MERGE_3D_ACTIVE           0x0E4
>  #define   CTL_INTF_ACTIVE               0x0F4
>  #define   CTL_MERGE_3D_FLUSH            0x100
> +#define   CTL_DSC_ACTIVE                0x0E8
> +#define   CTL_DSC_FLUSH                0x104
>  #define   CTL_INTF_FLUSH                0x110
>  #define   CTL_INTF_MASTER               0x134
>  #define   CTL_FETCH_PIPE_ACTIVE         0x0FC
> @@ -34,6 +36,7 @@
>  
>  #define DPU_REG_RESET_TIMEOUT_US        2000
>  #define  MERGE_3D_IDX   23
> +#define  DSC_IDX        22

This define does not seem used in any of these patches.  Is that
intended?

>  #define  INTF_IDX       31
>  #define CTL_INVALID_BIT                 0xffff
>  #define CTL_DEFAULT_GROUP_ID		0xf
> @@ -121,7 +124,6 @@ static u32 dpu_hw_ctl_get_pending_flush(struct dpu_hw_ctl *ctx)
>  
>  static inline void dpu_hw_ctl_trigger_flush_v1(struct dpu_hw_ctl *ctx)
>  {
> -
>  	if (ctx->pending_flush_mask & BIT(MERGE_3D_IDX))
>  		DPU_REG_WRITE(&ctx->hw, CTL_MERGE_3D_FLUSH,
>  				ctx->pending_merge_3d_flush_mask);
> @@ -506,6 +508,9 @@ static void dpu_hw_ctl_intf_cfg_v1(struct dpu_hw_ctl *ctx,
>  	if ((test_bit(DPU_CTL_VM_CFG, &ctx->caps->features)))
>  		mode_sel = CTL_DEFAULT_GROUP_ID  << 28;
>  
> +	if (cfg->dsc)
> +		DPU_REG_WRITE(&ctx->hw, CTL_DSC_FLUSH, cfg->dsc);
> +
>  	if (cfg->intf_mode_sel == DPU_CTL_MODE_SEL_CMD)
>  		mode_sel |= BIT(17);
>  
> @@ -517,6 +522,10 @@ static void dpu_hw_ctl_intf_cfg_v1(struct dpu_hw_ctl *ctx,
>  	if (cfg->merge_3d)
>  		DPU_REG_WRITE(c, CTL_MERGE_3D_ACTIVE,
>  			      BIT(cfg->merge_3d - MERGE_3D_0));
> +	if (cfg->dsc) {
> +		DPU_REG_WRITE(&ctx->hw, CTL_FLUSH, cfg->dsc);

Perhaps this should have been `DSC_IDX`, as the index to flush is set in
the CTL_DSC_FLUSH register already?  Should this go through
pending_flush_mask machinery?

> +		DPU_REG_WRITE(c, CTL_DSC_ACTIVE, cfg->dsc);
> +	}
>  }
>  
>  static void dpu_hw_ctl_intf_cfg(struct dpu_hw_ctl *ctx,
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
> index 806c171e5df2..9847c9c46d6f 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
> @@ -40,6 +40,7 @@ struct dpu_hw_stage_cfg {
>   * @merge_3d:              3d merge block used
>   * @intf_mode_sel:         Interface mode, cmd / vid
>   * @stream_sel:            Stream selection for multi-stream interfaces
> + * @dsc:                   DSC BIT masks

Bit masks of what?  Enabled DSCs?  A more verbose doc-comment is desired
here, matching the rest of the fields :) - something like "DSC block(s)
used" similar to merge_3d?  Or copy the docs from `dsc_mask`, which is
the value that is written into this field.

- Marijn

>   */
>  struct dpu_hw_intf_cfg {
>  	enum dpu_intf intf;
> @@ -47,6 +48,7 @@ struct dpu_hw_intf_cfg {
>  	enum dpu_merge_3d merge_3d;
>  	enum dpu_ctl_mode_sel intf_mode_sel;
>  	int stream_sel;
> +	unsigned int dsc;
>  };
>  
>  /**
> -- 
> 2.31.1
> 
