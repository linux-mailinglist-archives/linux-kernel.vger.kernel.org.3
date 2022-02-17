Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8264BAC20
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 22:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343734AbiBQVy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 16:54:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242253AbiBQVy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 16:54:56 -0500
X-Greylist: delayed 44848 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Feb 2022 13:54:41 PST
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [5.144.164.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7501680A4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 13:54:40 -0800 (PST)
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 5D3673F801;
        Thu, 17 Feb 2022 22:54:38 +0100 (CET)
Date:   Thu, 17 Feb 2022 22:54:37 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Rob Clark <robdclark@gmail.com>, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: Re: [PATCH v3 03/13] drm/msm/disp/dpu1: Add support for DSC in
 pingpong block
Message-ID: <20220217215437.gvxmfjgfqzljactz@SoMainline.org>
References: <20211116062256.2417186-1-vkoul@kernel.org>
 <20211116062256.2417186-4-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116062256.2417186-4-vkoul@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-11-16 11:52:46, Vinod Koul wrote:
> In SDM845, DSC can be enabled by writing to pingpong block registers, so
> add support for DSC in hw_pp

Nit: I don't think the ", so add support for DSC in XXX" part in this
and other commit messages add anything.  You've already stated that in
the title, the commit body is just extra justification (and can perhaps
be filled with extra details about the patch contents instead).

> Reviewed-by: Abhinav Kumar <abhinavk@codeaurora.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  .../gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c   | 32 +++++++++++++++++++
>  .../gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h   | 14 ++++++++
>  2 files changed, 46 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
> index 55766c97c4c8..47c6ab6caf95 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
> @@ -28,6 +28,9 @@
>  #define PP_FBC_MODE                     0x034
>  #define PP_FBC_BUDGET_CTL               0x038
>  #define PP_FBC_LOSSY_MODE               0x03C
> +#define PP_DSC_MODE                     0x0a0
> +#define PP_DCE_DATA_IN_SWAP             0x0ac

This enum does not seem used here, is it used in another patch?

> +#define PP_DCE_DATA_OUT_SWAP            0x0c8
>  
>  #define PP_DITHER_EN			0x000
>  #define PP_DITHER_BITDEPTH		0x004
> @@ -245,6 +248,32 @@ static u32 dpu_hw_pp_get_line_count(struct dpu_hw_pingpong *pp)
>  	return line;
>  }
>  
> +static int dpu_hw_pp_dsc_enable(struct dpu_hw_pingpong *pp)
> +{
> +	struct dpu_hw_blk_reg_map *c = &pp->hw;
> +
> +	DPU_REG_WRITE(c, PP_DSC_MODE, 1);
> +	return 0;
> +}
> +
> +static void dpu_hw_pp_dsc_disable(struct dpu_hw_pingpong *pp)
> +{
> +	struct dpu_hw_blk_reg_map *c = &pp->hw;
> +
> +	DPU_REG_WRITE(c, PP_DSC_MODE, 0);
> +}
> +
> +static int dpu_hw_pp_setup_dsc(struct dpu_hw_pingpong *pp)
> +{
> +	struct dpu_hw_blk_reg_map *pp_c = &pp->hw;
> +	int data;
> +
> +	data = DPU_REG_READ(pp_c, PP_DCE_DATA_OUT_SWAP);
> +	data |= BIT(18); /* endian flip */
> +	DPU_REG_WRITE(pp_c, PP_DCE_DATA_OUT_SWAP, data);
> +	return 0;
> +}
> +
>  static void _setup_pingpong_ops(struct dpu_hw_pingpong *c,
>  				unsigned long features)
>  {
> @@ -256,6 +285,9 @@ static void _setup_pingpong_ops(struct dpu_hw_pingpong *c,
>  	c->ops.get_autorefresh = dpu_hw_pp_get_autorefresh_config;
>  	c->ops.poll_timeout_wr_ptr = dpu_hw_pp_poll_timeout_wr_ptr;
>  	c->ops.get_line_count = dpu_hw_pp_get_line_count;
> +	c->ops.setup_dsc = dpu_hw_pp_setup_dsc;
> +	c->ops.enable_dsc = dpu_hw_pp_dsc_enable;
> +	c->ops.disable_dsc = dpu_hw_pp_dsc_disable;
>  
>  	if (test_bit(DPU_PINGPONG_DITHER, &features))
>  		c->ops.setup_dither = dpu_hw_pp_setup_dither;
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h
> index 89d08a715c16..12758468d9ca 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h
> @@ -124,6 +124,20 @@ struct dpu_hw_pingpong_ops {
>  	 */
>  	void (*setup_dither)(struct dpu_hw_pingpong *pp,
>  			struct dpu_hw_dither_cfg *cfg);
> +	/**
> +	 * Enable DSC
> +	 */
> +	int (*enable_dsc)(struct dpu_hw_pingpong *pp);
> +
> +	/**
> +	 * Disable DSC
> +	 */
> +	void (*disable_dsc)(struct dpu_hw_pingpong *pp);

It looks like most other callbacks in dpu1 use an `enable` function with
a boolean, instead of having a separate disable function.  That should
simplify the implementation down to a single ternary-if, too.  Would
that be desired to use here?

- Marijn

> +
> +	/**
> +	 * Setup DSC
> +	 */
> +	int (*setup_dsc)(struct dpu_hw_pingpong *pp);
>  };
>  
>  struct dpu_hw_merge_3d;
> -- 
> 2.31.1
> 
