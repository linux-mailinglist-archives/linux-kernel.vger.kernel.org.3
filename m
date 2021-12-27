Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51CC247FAB2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 08:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235438AbhL0HGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 02:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235430AbhL0HGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 02:06:38 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9629FC06173E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 23:06:38 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id p37so25305742uae.8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 23:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mn5z8Yw7iLT0GibyNVJxOywmkk9xNTM1BsrsY50wxA0=;
        b=Fmu3inELwWGRoc+/d047G0g91Zv/JR90W9NOSw/paEwBvKsD/seV2kd6KMhmQMyjEP
         VxxFHzhHRq85jeUM+nCTmXkBEnRGxQJodRABLc7BfGzPji+Jo1iD+h8ZKO8Esce8q2XT
         3W8yFRUP3uzfuiVQK6DTrBiiFl5jnApeNlSf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mn5z8Yw7iLT0GibyNVJxOywmkk9xNTM1BsrsY50wxA0=;
        b=bHr+zeFrEpQFwyBxeCU7X5aLtBc4NvY/9yliSiof6MeIpcNUKol5s18sTW/ywv4Yby
         DZbYdvobD3ZQFdDCwZVXLeb1csgzGCbpsxfQIIeousBY82EKn2tC31ciHPq4sQjB3ocC
         AlSXmJNQnpdY5amTJc7R9h470qH4mswrrnNBXk0T1qb/MR8Co+PiEcl8e/zr6w4ErxRZ
         zgzkW7IlLRNEG7pt+wRCUZUeHsmfYXwdkVv7cp8FV0WQ97TmyGULB/XkUz6hF2DJEGk0
         7usfB4Ygk+/DaDNGbcsz2nfPxeQGuGCjwHY9E0AtziZ+KTUswPlgb/eJ106B833Spl1X
         XEXg==
X-Gm-Message-State: AOAM531BQUpcJ8PLbPBkTVTs7sypF7sJ+IOpMDghx/z684Lm7KxSPPYn
        YgbxK7G9NCDyTmJFeTciWl7EtrCrxotkLA==
X-Google-Smtp-Source: ABdhPJzizVFGusNRloY5DaLnDMCeKgA7SYpu8cfu5DuQZkTFdJ7Xh1Qq+yYGq0x1tgDEyzXsM4X81Q==
X-Received: by 2002:a67:e20c:: with SMTP id g12mr4253785vsa.20.1640588797465;
        Sun, 26 Dec 2021 23:06:37 -0800 (PST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id r202sm2860141vkf.28.2021.12.26.23.06.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Dec 2021 23:06:37 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id i5so10507670uaq.10
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 23:06:36 -0800 (PST)
X-Received: by 2002:a05:6102:2368:: with SMTP id o8mr4126408vsa.47.1640588796568;
 Sun, 26 Dec 2021 23:06:36 -0800 (PST)
MIME-Version: 1.0
References: <20211117130635.11633-1-dafna.hirschfeld@collabora.com> <20211117130635.11633-7-dafna.hirschfeld@collabora.com>
In-Reply-To: <20211117130635.11633-7-dafna.hirschfeld@collabora.com>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Mon, 27 Dec 2021 16:06:25 +0900
X-Gmail-Original-Message-ID: <CAPBb6MXqwWDhCVrdvdUZ3U6P8-CJXo22mkQ_wrQ3_LLGacOvvg@mail.gmail.com>
Message-ID: <CAPBb6MXqwWDhCVrdvdUZ3U6P8-CJXo22mkQ_wrQ3_LLGacOvvg@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] media: mtk-vcodec: don't check return val of mtk_venc_get_q_data
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        kernel@collabora.com, Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        courbot@chromium.org, Dafna Hirschfeld <dafna3@gmail.com>,
        eizan@chromium.org, houlong.wei@mediatek.com,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Irui Wang <irui.wang@mediatek.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        =?UTF-8?B?TWFvZ3VhbmcgTWVuZyAo5a2f5q+b5bm/KQ==?= 
        <maoguang.meng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        minghsiu.tsai@mediatek.com, Tomasz Figa <tfiga@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 10:07 PM Dafna Hirschfeld
<dafna.hirschfeld@collabora.com> wrote:
>
> The function mtk_venc_get_q_data always returns a reference
> so there is no need to check if the return value is null.
> In addition move the q_data initialization to the declaration
>
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>

Reviewed-by: Alexandre Courbot <acourbot@chromium.org>


> ---
>  .../platform/mtk-vcodec/mtk_vcodec_enc.c      | 39 ++++---------------
>  1 file changed, 7 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
> index be28f2401839..5caaeb4773ca 100644
> --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
> +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
> @@ -399,7 +399,7 @@ static int vidioc_venc_s_fmt_cap(struct file *file, void *priv,
>         struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
>         const struct mtk_vcodec_enc_pdata *pdata = ctx->dev->venc_pdata;
>         struct vb2_queue *vq;
> -       struct mtk_q_data *q_data;
> +       struct mtk_q_data *q_data = mtk_venc_get_q_data(ctx, f->type);
>         int i, ret;
>         const struct mtk_video_fmt *fmt;
>
> @@ -414,12 +414,6 @@ static int vidioc_venc_s_fmt_cap(struct file *file, void *priv,
>                 return -EBUSY;
>         }
>
> -       q_data = mtk_venc_get_q_data(ctx, f->type);
> -       if (!q_data) {
> -               mtk_v4l2_err("fail to get q data");
> -               return -EINVAL;
> -       }
> -
>         fmt = mtk_venc_find_format(f->fmt.pix.pixelformat, pdata);
>         if (!fmt) {
>                 fmt = &ctx->dev->venc_pdata->capture_formats[0];
> @@ -460,7 +454,7 @@ static int vidioc_venc_s_fmt_out(struct file *file, void *priv,
>         struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
>         const struct mtk_vcodec_enc_pdata *pdata = ctx->dev->venc_pdata;
>         struct vb2_queue *vq;
> -       struct mtk_q_data *q_data;
> +       struct mtk_q_data *q_data = mtk_venc_get_q_data(ctx, f->type);
>         int ret, i;
>         const struct mtk_video_fmt *fmt;
>
> @@ -475,12 +469,6 @@ static int vidioc_venc_s_fmt_out(struct file *file, void *priv,
>                 return -EBUSY;
>         }
>
> -       q_data = mtk_venc_get_q_data(ctx, f->type);
> -       if (!q_data) {
> -               mtk_v4l2_err("fail to get q data");
> -               return -EINVAL;
> -       }
> -
>         fmt = mtk_venc_find_format(f->fmt.pix.pixelformat, pdata);
>         if (!fmt) {
>                 fmt = &ctx->dev->venc_pdata->output_formats[0];
> @@ -520,14 +508,13 @@ static int vidioc_venc_g_fmt(struct file *file, void *priv,
>         struct v4l2_pix_format_mplane *pix = &f->fmt.pix_mp;
>         struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
>         struct vb2_queue *vq;
> -       struct mtk_q_data *q_data;
> +       struct mtk_q_data *q_data = mtk_venc_get_q_data(ctx, f->type);
>         int i;
>
>         vq = v4l2_m2m_get_vq(ctx->m2m_ctx, f->type);
>         if (!vq)
>                 return -EINVAL;
>
> -       q_data = mtk_venc_get_q_data(ctx, f->type);
>
>         pix->width = q_data->coded_width;
>         pix->height = q_data->coded_height;
> @@ -596,15 +583,11 @@ static int vidioc_venc_g_selection(struct file *file, void *priv,
>                                      struct v4l2_selection *s)
>  {
>         struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
> -       struct mtk_q_data *q_data;
> +       struct mtk_q_data *q_data = mtk_venc_get_q_data(ctx, s->type);
>
>         if (s->type != V4L2_BUF_TYPE_VIDEO_OUTPUT)
>                 return -EINVAL;
>
> -       q_data = mtk_venc_get_q_data(ctx, s->type);
> -       if (!q_data)
> -               return -EINVAL;
> -
>         switch (s->target) {
>         case V4L2_SEL_TGT_CROP_DEFAULT:
>         case V4L2_SEL_TGT_CROP_BOUNDS:
> @@ -630,15 +613,11 @@ static int vidioc_venc_s_selection(struct file *file, void *priv,
>                                      struct v4l2_selection *s)
>  {
>         struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
> -       struct mtk_q_data *q_data;
> +       struct mtk_q_data *q_data = mtk_venc_get_q_data(ctx, s->type);
>
>         if (s->type != V4L2_BUF_TYPE_VIDEO_OUTPUT)
>                 return -EINVAL;
>
> -       q_data = mtk_venc_get_q_data(ctx, s->type);
> -       if (!q_data)
> -               return -EINVAL;
> -
>         switch (s->target) {
>         case V4L2_SEL_TGT_CROP:
>                 /* Only support crop from (0,0) */
> @@ -805,11 +784,9 @@ static int vb2ops_venc_queue_setup(struct vb2_queue *vq,
>                                    struct device *alloc_devs[])
>  {
>         struct mtk_vcodec_ctx *ctx = vb2_get_drv_priv(vq);
> -       struct mtk_q_data *q_data;
> +       struct mtk_q_data *q_data = mtk_venc_get_q_data(ctx, vq->type);
>         unsigned int i;
>
> -       q_data = mtk_venc_get_q_data(ctx, vq->type);
> -
>         if (q_data == NULL)
>                 return -EINVAL;
>
> @@ -829,11 +806,9 @@ static int vb2ops_venc_queue_setup(struct vb2_queue *vq,
>  static int vb2ops_venc_buf_prepare(struct vb2_buffer *vb)
>  {
>         struct mtk_vcodec_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
> -       struct mtk_q_data *q_data;
> +       struct mtk_q_data *q_data = mtk_venc_get_q_data(ctx, vb->vb2_queue->type);
>         int i;
>
> -       q_data = mtk_venc_get_q_data(ctx, vb->vb2_queue->type);
> -
>         for (i = 0; i < q_data->fmt->num_planes; i++) {
>                 if (vb2_plane_size(vb, i) < q_data->sizeimage[i]) {
>                         mtk_v4l2_err("data will not fit into plane %d (%lu < %d)",
> --
> 2.17.1
>
