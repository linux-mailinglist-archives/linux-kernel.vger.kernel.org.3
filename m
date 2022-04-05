Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711CC4F4ED4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1835135AbiDFAWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443714AbiDEPkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:40:11 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DFB184B7F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:58:18 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id b18so11058971qtk.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 06:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Zo1koAQLSqT+JlliAq41n9EK+T7UuDXU3++Yy/OL90=;
        b=pYOq3UGJ9TuIXdMMMK/F/k3jSEPQuAMk+I1l80ZkCtTU38iwbrbYh/MmB6ZwhRGL46
         7ZF/j58tDSvOPdcKV47hG6AbEPYz91zXGhTpCa2J8xpZ/juYLcNWpAKAlTfFhqDYI/ng
         tfCpikouSwxh9W4Q3CBrXgepftQ89pHlQ9VH8GnTvWJPjfI855qfNk2HAo0md0SjLMNO
         yZoymPDDM/IIOizehI3PWyG0QjrKc19XUDE3yPjkc28DIFrfEi1r30qlb6T1aqd/oQTM
         +PBLdeYs8i7R6+WZSzhPaHlAA9oAZx5z4by2ZDiCwd/V1jv7s89BtY1K3X9IGRu/XK6+
         3rfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Zo1koAQLSqT+JlliAq41n9EK+T7UuDXU3++Yy/OL90=;
        b=XI5dU3/bBBU7zxHe+1dEEHQwSZMug1hm7I3nnXeo2EHbdAiJpdcjvgDJWu+N1sZJHT
         eGqYWMC6+NlpjW1k9giWhSHPj817AurVPZD8DfQInxxK89GAVbyeqmdNe4AC9ZixnVQp
         N58H8ywrKD1JyE3vgU0MriK4utOUbamJSsN2Dk8sFjQR5ayW4tu69+xHEa4lcCJ0SwBx
         00knEoEaJJcLlVqPJJKbfWeUxb2slKxPAU94+FKpjI0kw0aBKCrgvuQHA8IL1Aa9oF5F
         0VcqWgI9UOKLnz7Zn/qPE6y9v7sGASI3+sRsbRkgfHIkO5t8ZVKN3xfP+68fC2jCZ7l8
         un0Q==
X-Gm-Message-State: AOAM533KdKJtap4qOjR5f3on+fG21M+Mbrc6iQw9HdaRdX/QsBtFlwZr
        2qumRxohl6l34uS+cvmxe95gI8X5/YbxTMXsUz9KTw==
X-Google-Smtp-Source: ABdhPJz/N9m3G+9VZYfO3dFBtZYE5Y4RILMfHESwLIPYnr2rLZvWX9Vt+wYFpiNptzVDvlPI4eFmvvGPXv4BsWAZL2E=
X-Received: by 2002:ac8:7dd1:0:b0:2e0:6fe1:189b with SMTP id
 c17-20020ac87dd1000000b002e06fe1189bmr3138136qte.629.1649167097585; Tue, 05
 Apr 2022 06:58:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220404163436.956875-1-vkoul@kernel.org> <20220404163436.956875-15-vkoul@kernel.org>
In-Reply-To: <20220404163436.956875-15-vkoul@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 5 Apr 2022 16:58:06 +0300
Message-ID: <CAA8EJpr5CwJ1_aKQ3Crqbjy8-=igazdWvN4VeZtp0fT85nXE6w@mail.gmail.com>
Subject: Re: [PATCH v6 14/14] drm/msm/dsi: Add support for DSC configuration
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Rob Clark <robdclark@gmail.com>, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
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

On Mon, 4 Apr 2022 at 19:35, Vinod Koul <vkoul@kernel.org> wrote:
>
> When DSC is enabled, we need to configure DSI registers accordingly and
> configure the respective stream compression registers.
>
> Add support to calculate the register setting based on DSC params and
> timing information and configure these registers.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 98 +++++++++++++++++++++++++++++-
>  1 file changed, 97 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index eb0be34add45..f3ed6c40b9e1 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -912,6 +912,65 @@ static void dsi_ctrl_config(struct msm_dsi_host *msm_host, bool enable,
>                 dsi_write(msm_host, REG_DSI_CPHY_MODE_CTRL, BIT(0));
>  }
>
> +static void dsi_update_dsc_timing(struct msm_dsi_host *msm_host, bool is_cmd_mode, u32 hdisplay)
> +{
> +       struct msm_display_dsc_config *dsc = msm_host->dsc;
> +       u32 reg, intf_width, reg_ctrl, reg_ctrl2;
> +       u32 slice_per_intf, total_bytes_per_intf;
> +       u32 pkt_per_line;
> +       u32 bytes_in_slice;
> +       u32 eol_byte_num;
> +
> +       /* first calculate dsc parameters and then program
> +        * compress mode registers
> +        */
> +       intf_width = hdisplay;
> +       slice_per_intf = DIV_ROUND_UP(intf_width, dsc->drm->slice_width);
> +
> +       /* If slice_per_pkt is greater than slice_per_intf
> +        * then default to 1. This can happen during partial
> +        * update.
> +        */
> +       if (slice_per_intf > dsc->drm->slice_count)
> +               dsc->drm->slice_count = 1;
> +
> +       slice_per_intf = DIV_ROUND_UP(hdisplay, dsc->drm->slice_width);
> +       bytes_in_slice = DIV_ROUND_UP(dsc->drm->slice_width * dsc->drm->bits_per_pixel, 8);
> +
> +       dsc->drm->slice_chunk_size = bytes_in_slice;
> +
> +       total_bytes_per_intf = bytes_in_slice * slice_per_intf;
> +
> +       eol_byte_num = total_bytes_per_intf % 3;
> +       pkt_per_line = slice_per_intf / dsc->drm->slice_count;
> +
> +       if (is_cmd_mode) /* packet data type */
> +               reg = DSI_COMMAND_COMPRESSION_MODE_CTRL_STREAM0_DATATYPE(MIPI_DSI_DCS_LONG_WRITE);
> +       else
> +               reg = DSI_VIDEO_COMPRESSION_MODE_CTRL_DATATYPE(MIPI_DSI_COMPRESSED_PIXEL_STREAM);
> +
> +       /* DSI_VIDEO_COMPRESSION_MODE & DSI_COMMAND_COMPRESSION_MODE
> +        * registers have similar offsets, so for below common code use
> +        * DSI_VIDEO_COMPRESSION_MODE_XXXX for setting bits
> +        */
> +       reg |= DSI_VIDEO_COMPRESSION_MODE_CTRL_PKT_PER_LINE(pkt_per_line >> 1);
> +       reg |= DSI_VIDEO_COMPRESSION_MODE_CTRL_EOL_BYTE_NUM(eol_byte_num);
> +       reg |= DSI_VIDEO_COMPRESSION_MODE_CTRL_EN;
> +
> +       if (is_cmd_mode) {
> +               reg_ctrl = dsi_read(msm_host, REG_DSI_COMMAND_COMPRESSION_MODE_CTRL);
> +               reg_ctrl2 = dsi_read(msm_host, REG_DSI_COMMAND_COMPRESSION_MODE_CTRL2);
> +
> +               reg_ctrl |= reg;
> +               reg_ctrl2 |= DSI_COMMAND_COMPRESSION_MODE_CTRL2_STREAM0_SLICE_WIDTH(bytes_in_slice);
> +
> +               dsi_write(msm_host, REG_DSI_COMMAND_COMPRESSION_MODE_CTRL, reg);
> +               dsi_write(msm_host, REG_DSI_COMMAND_COMPRESSION_MODE_CTRL2, reg_ctrl2);
> +       } else {
> +               dsi_write(msm_host, REG_DSI_VIDEO_COMPRESSION_MODE_CTRL, reg);
> +       }
> +}
> +
>  static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>  {
>         struct drm_display_mode *mode = msm_host->mode;
> @@ -944,7 +1003,38 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>                 hdisplay /= 2;
>         }
>
> +       if (msm_host->dsc) {
> +               struct msm_display_dsc_config *dsc = msm_host->dsc;
> +
> +               /* update dsc params with timing params */
> +               if (!dsc || !mode->hdisplay || !mode->vdisplay) {
> +                       pr_err("DSI: invalid input: pic_width: %d pic_height: %d\n",
> +                              mode->hdisplay, mode->vdisplay);
> +                       return;
> +               }
> +
> +               dsc->drm->pic_width = mode->hdisplay;
> +               dsc->drm->pic_height = mode->vdisplay;
> +               DBG("Mode %dx%d\n", dsc->drm->pic_width, dsc->drm->pic_height);
> +
> +               /* we do the calculations for dsc parameters here so that
> +                * panel can use these parameters
> +                */
> +               dsi_populate_dsc_params(dsc);
> +
> +               /* Divide the display by 3 but keep back/font porch and
> +                * pulse width same
> +                */
> +               h_total -= hdisplay;
> +               hdisplay /= 3;
> +               h_total += hdisplay;
> +               ha_end = ha_start + hdisplay;
> +       }
> +
>         if (msm_host->mode_flags & MIPI_DSI_MODE_VIDEO) {
> +               if (msm_host->dsc)
> +                       dsi_update_dsc_timing(msm_host, false, mode->hdisplay);
> +
>                 dsi_write(msm_host, REG_DSI_ACTIVE_H,
>                         DSI_ACTIVE_H_START(ha_start) |
>                         DSI_ACTIVE_H_END(ha_end));
> @@ -963,8 +1053,14 @@ static void dsi_timing_setup(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
>                         DSI_ACTIVE_VSYNC_VPOS_START(vs_start) |
>                         DSI_ACTIVE_VSYNC_VPOS_END(vs_end));
>         } else {                /* command mode */
> +               if (msm_host->dsc)
> +                       dsi_update_dsc_timing(msm_host, true, mode->hdisplay);
> +
>                 /* image data and 1 byte write_memory_start cmd */
> -               wc = hdisplay * dsi_get_bpp(msm_host->format) / 8 + 1;
> +               if (!msm_host->dsc)
> +                       wc = hdisplay * dsi_get_bpp(msm_host->format) / 8 + 1;
> +               else
> +                       wc = mode->hdisplay / 2 + 1;
>
>                 dsi_write(msm_host, REG_DSI_CMD_MDP_STREAM0_CTRL,
>                         DSI_CMD_MDP_STREAM0_CTRL_WORD_COUNT(wc) |
> --
> 2.34.1
>


-- 
With best wishes
Dmitry
