Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A544E53980D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 22:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347787AbiEaUez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 16:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347766AbiEaUet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 16:34:49 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3BB99685;
        Tue, 31 May 2022 13:34:48 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id p5-20020a1c2905000000b003970dd5404dso1832302wmp.0;
        Tue, 31 May 2022 13:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oaXYmwjs+IP8DfonFtLZlkC4gcR1bP5BMuLB+hURGTI=;
        b=Uo1QyPMQp8yyfSpNq3/lf50f4g6fet8bZdokB71yNpzIo46V63H3Kq2a5Ud0yvilVH
         Tqu6qpHFTSvRpYdkO2OmrDrZdFxI/+NJ7UFDeye65myT4SIYuQw9fdDzQKcjg/DHSlKQ
         4sGflAEksOAgt7SbEcmFnwHdgY4K4ck+OAUd76E4XSdNPifu4DK2UjXtuqpwDXA4RsE9
         T4p6ZFKiZ7kNnNOvugictDq813xCtokUCSNm60F5l2m0bb2e6Kd+UVdHH+sHyj+Y5HWA
         0/wOxNALIeGPDZ93ETwsT28DZ8P2vg8VHlTzhJ2oC5f91sp4jB8joWRpLDGXyIdA6HKE
         T62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oaXYmwjs+IP8DfonFtLZlkC4gcR1bP5BMuLB+hURGTI=;
        b=TNrQRNGHnb3fOYYMoW8Yg7nXR64TQEn843KIP01naGouUlvGu/y6LZ5wWAVIGn7rP4
         DxWZxScE0m/h7kk352w1nCeEA8QOWkF/N886O6yGP+TLWguJHq+z/dSCtWZNMliJ8xYv
         koDzIuDSTMWYxZ3t5IT4fZTjiUSoLJ5n4LRfwe4RoR1CMUg2yxDZh6qbDaYUTE7e78Zr
         4YqZfYL08h+0irFBvhKDqTKd/Htnwv1qzAUJgsKuJ+u1DWLJNKM93jSWc45PiO7sl1oq
         YlnFMB1a0RptbYSTJgL05q3tBAgcypp22Wh5LZlc+pkOau+OxhSPiWlguGJMI9c14H00
         uXOQ==
X-Gm-Message-State: AOAM532ZAWk2/ixW8uWiAXgS0XnzMZBznKMA2TrPZ8dB4Ljx+j7mzZx9
        PXxu4cv/JYxFdCPYUTKlxLFGjfV6ty1l7uj2OhI=
X-Google-Smtp-Source: ABdhPJxioJPukJE1d1hZFegw9lQmbEjjQn5EFNtdoGSzu/a+qBWwmNy2JHdPps/csufWkTTB/pZ+fRzCLuaCM0EYTD0=
X-Received: by 2002:a05:600c:4f93:b0:399:e654:4481 with SMTP id
 n19-20020a05600c4f9300b00399e6544481mr16363801wmq.164.1654029287263; Tue, 31
 May 2022 13:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <1653896005-25168-1-git-send-email-baihaowen@meizu.com>
In-Reply-To: <1653896005-25168-1-git-send-email-baihaowen@meizu.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 31 May 2022 13:34:48 -0700
Message-ID: <CAF6AEGtsAH6LdE9douMMYEM2hW6_ifcqgM5mxaj43XAr=3uCTw@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dpu: Fix pointer dereferenced before checking
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 12:34 AM Haowen Bai <baihaowen@meizu.com> wrote:
>
> The ctx->hw is dereferencing before null checking, so move
> it after checking.
>
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c
> index bcccce292937..e59680cdd0ce 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c
> @@ -155,11 +155,13 @@ static void dpu_hw_wb_roi(struct dpu_hw_wb *ctx, struct dpu_hw_wb_cfg *wb)
>  static void dpu_hw_wb_setup_qos_lut(struct dpu_hw_wb *ctx,
>                 struct dpu_hw_wb_qos_cfg *cfg)
>  {
> -       struct dpu_hw_blk_reg_map *c = &ctx->hw;
> +       struct dpu_hw_blk_reg_map *c;
>         u32 qos_ctrl = 0;
>
>         if (!ctx || !cfg)
>                 return;
> +
> +       c = &ctx->hw;

tbh, we should just drop both of these null checks.. there is no
codepath that can reach this with potential for either param to be
NULL

BR,
-R

>
>         DPU_REG_WRITE(c, WB_DANGER_LUT, cfg->danger_lut);
>         DPU_REG_WRITE(c, WB_SAFE_LUT, cfg->safe_lut);
> --
> 2.7.4
>
