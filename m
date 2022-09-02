Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2975AAD4C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 13:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235295AbiIBLTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 07:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbiIBLTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 07:19:45 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448A59B
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 04:09:44 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id b142so1284689iof.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 04:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=rnQqxt9RdPdB0yUEssxLU4y2HHyz75pTKHB4+46VEDk=;
        b=YKMkFg2wcPO+GodKwxrdiBk5aFGvc4yu22RjgCrVptcEBKO6OgdpYUwKn8VSn7WS3S
         ffZNZuofiRlmNSKy8Hcck8r7/Y9wNBKmAXu0E04iAcB3PTicRO6pT6IenW5tLn9NZ2CZ
         isXEYIaH4L0RE60P0q2N/Yhk/2OQnldSjH3VhjtZ1ZPlYHSaUGEIVWCk0KSzWI7U9cSQ
         ddfLFuAdVc9qdOq+nR6uLx6S/7IVBahR2Q+GBW6rHK8p2v439nzodxdoJ87U3VnsVCQ3
         lm7Yt364E06teOxa6lNvMH90SpIs91MEdBPtGlZMWlidcKFuMZW8/KIlOy4Ak45sFgcH
         AWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=rnQqxt9RdPdB0yUEssxLU4y2HHyz75pTKHB4+46VEDk=;
        b=MrT2EDDp1UrG6VFyCxDvleHUMDh/GtyerQEEd6Oo0Cj5PN5JWO5dC+vrsmjmOb81dE
         4yaYNwqO1h1mvoSFFQ54qlHoRojdLPkXxwupqbyqtKzervLEfnQoNjIv94IavISPNDN8
         TxccBdyXDyEQKoRsLSqXFys7k7j5W7802h6C45oFhC+wW+B8I2Gh+eLmt5UuocrVWPdy
         h3wlfrHURfYKd18WNp46C/JJAqFi3igpw6knujUUrefwR5ZXoVRc68aGwSUJQRRN3ID/
         py/Q43mH9qU5DIqehFt2klHPjly1X8zQphU27Hyv7AfpqTEkXJcamxCJpH6SFvOzk8yo
         S7sQ==
X-Gm-Message-State: ACgBeo0H/2cBNqUcizCJZ96k0hcejqC7wFdgpXKWEPhNhW7WmVGRos3z
        FJVvzQt7cSJQfqGVzpg4YO4NfKp/FCz6ttw+bLNQAg==
X-Google-Smtp-Source: AA6agR4qznCELC8Uk9g2P6txc/sJEZSXNo9TqSMZMSDnKvqiRarJOjhs/bocMU285biwzGnSM19C+Sc/gMDUmmDPcOg=
X-Received: by 2002:a05:6638:3792:b0:346:82f6:a9f4 with SMTP id
 w18-20020a056638379200b0034682f6a9f4mr19375402jal.102.1662116983612; Fri, 02
 Sep 2022 04:09:43 -0700 (PDT)
MIME-Version: 1.0
References: <1662111486-15021-1-git-send-email-quic_kalyant@quicinc.com>
In-Reply-To: <1662111486-15021-1-git-send-email-quic_kalyant@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 2 Sep 2022 14:09:32 +0300
Message-ID: <CAA8EJpqwB9Skq_DVwHERn0Soz=4hHLDiyzyeEteWfb6QbePU4g@mail.gmail.com>
Subject: Re: [v2] drm/msm/disp/dpu1: add support for dspp sub block flush in sc7280
To:     Kalyan Thota <quic_kalyant@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, quic_abhinavk@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Sept 2022 at 12:38, Kalyan Thota <quic_kalyant@quicinc.com> wrote:
>
> Flush mechanism for DSPP blocks has changed in sc7280 family, it
> allows individual sub blocks to be flushed in coordination with
> master flush control.
>
> Representation: master_flush && (PCC_flush | IGC_flush .. etc )
>
> This change adds necessary support for the above design.
>
> Changes in v1:
> - Few nits (Doug, Dmitry)
> - Restrict sub-block flush programming to dpu_hw_ctl file (Dmitry)
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c       |  2 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c |  5 +++-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h |  2 ++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c     | 35 +++++++++++++++++++++++++-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h     | 10 ++++++--
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h    |  7 ++++++
>  6 files changed, 56 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> index 601d687..ab38a52 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -766,7 +766,7 @@ static void _dpu_crtc_setup_cp_blocks(struct drm_crtc *crtc)
>
>                 /* stage config flush mask */
>                 ctl->ops.update_pending_flush_dspp(ctl,
> -                       mixer[i].hw_dspp->idx);
> +                       mixer[i].hw_dspp->idx, DPU_DSPP_SUB_PCC);
>         }
>  }
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> index 27f029f..0eecb2f 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> @@ -65,7 +65,10 @@
>         (PINGPONG_SDM845_MASK | BIT(DPU_PINGPONG_TE2))
>
>  #define CTL_SC7280_MASK \
> -       (BIT(DPU_CTL_ACTIVE_CFG) | BIT(DPU_CTL_FETCH_ACTIVE) | BIT(DPU_CTL_VM_CFG))
> +       (BIT(DPU_CTL_ACTIVE_CFG) | \
> +        BIT(DPU_CTL_FETCH_ACTIVE) | \
> +        BIT(DPU_CTL_VM_CFG) | \
> +        BIT(DPU_CTL_DSPP_SUB_BLOCK_FLUSH))
>
>  #define MERGE_3D_SM8150_MASK (0)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> index 38aa38a..6a0b784 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> @@ -191,6 +191,7 @@ enum {
>   * @DPU_CTL_SPLIT_DISPLAY:     CTL supports video mode split display
>   * @DPU_CTL_FETCH_ACTIVE:      Active CTL for fetch HW (SSPPs)
>   * @DPU_CTL_VM_CFG:            CTL config to support multiple VMs
> + * @DPU_CTL_DSPP_BLOCK_FLUSH: CTL config to support dspp sub-block flush
>   * @DPU_CTL_MAX
>   */
>  enum {
> @@ -198,6 +199,7 @@ enum {
>         DPU_CTL_ACTIVE_CFG,
>         DPU_CTL_FETCH_ACTIVE,
>         DPU_CTL_VM_CFG,
> +       DPU_CTL_DSPP_SUB_BLOCK_FLUSH,
>         DPU_CTL_MAX
>  };
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> index a35ecb6..3b14c30 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> @@ -33,6 +33,7 @@
>  #define   CTL_INTF_FLUSH                0x110
>  #define   CTL_INTF_MASTER               0x134
>  #define   CTL_FETCH_PIPE_ACTIVE         0x0FC
> +#define   CTL_DSPP_n_FLUSH             0x13C

CTL_DSPP_n_FLUSH(n)

>
>  #define CTL_MIXER_BORDER_OUT            BIT(24)
>  #define CTL_FLUSH_MASK_CTL              BIT(17)
> @@ -82,6 +83,31 @@ static int _mixer_stages(const struct dpu_lm_cfg *mixer, int count,
>         return stages;
>  }
>
> +static u32 _set_dspp_sub_block_flush(struct dpu_hw_ctl *ctx,
> +       enum dpu_dspp dspp, enum dpu_dspp_sub_blk dspp_sub_blk)
> +{
> +       uint32_t flushbits = 0, active;
> +
> +       switch (dspp_sub_blk) {
> +       case DPU_DSPP_SUB_IGC:
> +               flushbits = BIT(2);
> +               break;
> +       case DPU_DSPP_SUB_PCC:
> +               flushbits = BIT(4);
> +               break;
> +       case DPU_DSPP_SUB_GC:
> +               flushbits = BIT(5);
> +               break;
> +       default:
> +               return 0;
> +       }
> +
> +       active = DPU_REG_READ(&ctx->hw, CTL_DSPP_n_FLUSH + ((dspp - 1) * 4));
> +       DPU_REG_WRITE(&ctx->hw, CTL_DSPP_n_FLUSH + ((dspp - 1) * 4), active | flushbits);
> +
> +       return BIT(29);
> +}
> +
>  static inline u32 dpu_hw_ctl_get_flush_register(struct dpu_hw_ctl *ctx)
>  {
>         struct dpu_hw_blk_reg_map *c = &ctx->hw;
> @@ -287,8 +313,15 @@ static void dpu_hw_ctl_update_pending_flush_merge_3d_v1(struct dpu_hw_ctl *ctx,
>  }
>
>  static void dpu_hw_ctl_update_pending_flush_dspp(struct dpu_hw_ctl *ctx,
> -       enum dpu_dspp dspp)
> +       enum dpu_dspp dspp, enum dpu_dspp_sub_blk dspp_sub_blk)
>  {
> +
> +       if ((test_bit(DPU_CTL_DSPP_SUB_BLOCK_FLUSH, &ctx->caps->features))) {
> +               ctx->pending_flush_mask |=
> +                       _set_dspp_sub_block_flush(ctx, dspp, dspp_sub_blk);
> +               return;
> +       }

Please  inline _set_dspp_sub_block_flush(), split this if to a
separate function (e.g.
dpu_hw_ctl_update_pending_flush_dspp_subblocks()), and use it instead
of dpu_hw_ctl_update_pending_flush_dspp like it was done before.

> +
>         switch (dspp) {
>         case DSPP_0:
>                 ctx->pending_flush_mask |= BIT(13);
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
> index 96c012e..227f1bd 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
> @@ -149,12 +149,18 @@ struct dpu_hw_ctl_ops {
>
>         /**
>          * OR in the given flushbits to the cached pending_flush_mask
> -        * No effect on hardware
> +        *
> +        * If the hardware supports dspp sub block flush, then sub-block
> +        * flushes are written to the hardware and main dspp flush will
> +        * be cached in the pending_flush_mask.
> +        *
>          * @ctx       : ctl path ctx pointer
>          * @blk       : DSPP block index
> +        * @dspp_sub_blk : DSPP sub-block index
>          */
>         void (*update_pending_flush_dspp)(struct dpu_hw_ctl *ctx,
> -               enum dpu_dspp blk);
> +               enum dpu_dspp blk,  enum dpu_dspp_sub_blk dspp_sub_blk);
> +
>         /**
>          * Write the value of the pending_flush_mask to hardware
>          * @ctx       : ctl path ctx pointer
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> index d3b0ed0..c113d52 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
> @@ -167,6 +167,13 @@ enum dpu_dspp {
>         DSPP_MAX
>  };
>
> +enum dpu_dspp_sub_blk{
> +       DPU_DSPP_SUB_PCC = 1,
> +       DPU_DSPP_SUB_IGC,
> +       DPU_DSPP_SUB_GC,
> +       DPU_DSPP_SUB_MAX
> +};

Can we please use the existing enum DPU_DSPP_foo instead of adding a
new enum for no particular reason?

> +
>  enum dpu_ctl {
>         CTL_0 = 1,
>         CTL_1,
> --
> 2.7.4
>


-- 
With best wishes
Dmitry
