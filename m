Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4561A56B1AD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 06:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237167AbiGHElR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 00:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236767AbiGHElP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 00:41:15 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B518C3123C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 21:41:14 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id p11so14930567qkg.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 21:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IHH3SerUe7hKO3BcCPKIuExwbHnarbaRnq1Rsg7Fq/w=;
        b=TP503sPZhE1MYj+YbYdKd4ZCL7uxCJlbRd24w4Gupkrbxt6jCTXK9pbWHfM3nSvxcY
         1gPZxS423c5LPoPy+c99VIVAgppBRfPwLVj4V+09zJlL5ceS7y/J+pZIpEwVea5fYgit
         VMe2me75H7Jk4DE2d/hEXoAiDqVt6RHvzGkEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IHH3SerUe7hKO3BcCPKIuExwbHnarbaRnq1Rsg7Fq/w=;
        b=W36yPDkS4H7r6bMKh7CchdJlY8yqAhdqvXUYgTb6A5SFeFXKuYi3SMA3P5C2AAtM5t
         Kctfz4YU2R2DrUEtlzV59Wf1f9GNcXnwIKePHjIInq+wj6AU/rduYrCnNe0OYCpWoALY
         c/u60PJzVWkx6JBuAkvZ9VZiK9v3jFiCmFWRbJePFTM6iEShMjEYncmNtizZbIJXFX+s
         l3Wxjbl65zBgcCRXNA6bSKAlX6pTQNH94tZ0FDDpRvu74F5yl+oklGrbC/8EUW7SkaKZ
         pOvWmXDl5lrtxewoTDYrJk/ZCZSI4r6ykv9CKwe4qBEximIsRdo9U1/hbXE28s6SQisw
         4btQ==
X-Gm-Message-State: AJIora9JQTUTexDtqAuo0eE+/wnYoBVGNDqK3z0v485qIePwjfrTPj7y
        BNnIeookEoXvZeP8qEJkw/SwRgxDl4hiW1eN
X-Google-Smtp-Source: AGRyM1u84bAekyfnbtCL75kXbbCzn+TT7lszNbL/opLarBn0INT91QYWO99FfjQ2wJ0Bxfe5IKJUcA==
X-Received: by 2002:a05:620a:400c:b0:6a6:f8e6:92cc with SMTP id h12-20020a05620a400c00b006a6f8e692ccmr1038424qko.561.1657255273607;
        Thu, 07 Jul 2022 21:41:13 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id g11-20020ac8480b000000b003051ba1f8bcsm26883126qtq.15.2022.07.07.21.41.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 21:41:09 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id g4so36018326ybg.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 21:41:07 -0700 (PDT)
X-Received: by 2002:a25:8286:0:b0:66e:9272:5944 with SMTP id
 r6-20020a258286000000b0066e92725944mr1513134ybk.261.1657255267111; Thu, 07
 Jul 2022 21:41:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220706182657.210650-1-ezequiel@vanguardiasur.com.ar> <20220706182657.210650-7-ezequiel@vanguardiasur.com.ar>
In-Reply-To: <20220706182657.210650-7-ezequiel@vanguardiasur.com.ar>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 8 Jul 2022 13:40:53 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BSDnZ6MyXfcRWNM9f9WF82sjPX3F1ZjYjcOuz3b1fPkw@mail.gmail.com>
Message-ID: <CAAFQd5BSDnZ6MyXfcRWNM9f9WF82sjPX3F1ZjYjcOuz3b1fPkw@mail.gmail.com>
Subject: Re: [PATCH 6/8] rkvdec: Use vb2_find_buffer
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ezequiel,

On Thu, Jul 7, 2022 at 3:27 AM Ezequiel Garcia
<ezequiel@vanguardiasur.com.ar> wrote:
>
> Use the newly introduced vb2_find_buffer API to get a vb2_buffer
> given a buffer timestamp.
>
> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> ---
>  drivers/staging/media/rkvdec/rkvdec-h264.c | 41 ++++++++--------------
>  drivers/staging/media/rkvdec/rkvdec-vp9.c  | 10 +++---
>  2 files changed, 19 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging/media/rkvdec/rkvdec-h264.c
> index 2992fb87cf72..4af5a831bde0 100644
> --- a/drivers/staging/media/rkvdec/rkvdec-h264.c
> +++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
> @@ -109,7 +109,7 @@ struct rkvdec_h264_run {
>         const struct v4l2_ctrl_h264_sps *sps;
>         const struct v4l2_ctrl_h264_pps *pps;
>         const struct v4l2_ctrl_h264_scaling_matrix *scaling_matrix;
> -       int ref_buf_idx[V4L2_H264_NUM_DPB_ENTRIES];
> +       struct vb2_buffer *ref_buf[V4L2_H264_NUM_DPB_ENTRIES];

How do we guarantee that those pointers remain valid through the
lifetime of this structure?

Best regards,
Tomasz

>  };
>
>  struct rkvdec_h264_ctx {
> @@ -742,17 +742,16 @@ static void lookup_ref_buf_idx(struct rkvdec_ctx *ctx,
>                 struct v4l2_m2m_ctx *m2m_ctx = ctx->fh.m2m_ctx;
>                 const struct v4l2_h264_dpb_entry *dpb = run->decode_params->dpb;
>                 struct vb2_queue *cap_q = &m2m_ctx->cap_q_ctx.q;
> -               int buf_idx = -1;
> +               struct vb2_buffer *buf = NULL;
>
>                 if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE) {
> -                       buf_idx = vb2_find_timestamp(cap_q,
> -                                                    dpb[i].reference_ts, 0);
> -                       if (buf_idx < 0)
> +                       buf = vb2_find_buffer(cap_q, dpb[i].reference_ts);
> +                       if (!buf)
>                                 pr_debug("No buffer for reference_ts %llu",
>                                          dpb[i].reference_ts);
>                 }
>
> -               run->ref_buf_idx[i] = buf_idx;
> +               run->ref_buf[i] = buf;
>         }
>  }
>
> @@ -805,7 +804,7 @@ static void assemble_hw_rps(struct rkvdec_ctx *ctx,
>                         if (WARN_ON(ref->index >= ARRAY_SIZE(dec_params->dpb)))
>                                 continue;
>
> -                       dpb_valid = run->ref_buf_idx[ref->index] >= 0;
> +                       dpb_valid = run->ref_buf[ref->index] != NULL;
>                         bottom = ref->fields == V4L2_H264_BOTTOM_FIELD_REF;
>
>                         set_ps_field(hw_rps, DPB_INFO(i, j),
> @@ -881,24 +880,6 @@ static const u32 poc_reg_tbl_bottom_field[16] = {
>         RKVDEC_REG_H264_POC_REFER2(1)
>  };
>
> -static struct vb2_buffer *
> -get_ref_buf(struct rkvdec_ctx *ctx, struct rkvdec_h264_run *run,
> -           unsigned int dpb_idx)
> -{
> -       struct v4l2_m2m_ctx *m2m_ctx = ctx->fh.m2m_ctx;
> -       struct vb2_queue *cap_q = &m2m_ctx->cap_q_ctx.q;
> -       int buf_idx = run->ref_buf_idx[dpb_idx];
> -
> -       /*
> -        * If a DPB entry is unused or invalid, address of current destination
> -        * buffer is returned.
> -        */
> -       if (buf_idx < 0)
> -               return &run->base.bufs.dst->vb2_buf;
> -
> -       return vb2_get_buffer(cap_q, buf_idx);
> -}
> -
>  static void config_registers(struct rkvdec_ctx *ctx,
>                              struct rkvdec_h264_run *run)
>  {
> @@ -971,8 +952,14 @@ static void config_registers(struct rkvdec_ctx *ctx,
>
>         /* config ref pic address & poc */
>         for (i = 0; i < ARRAY_SIZE(dec_params->dpb); i++) {
> -               struct vb2_buffer *vb_buf = get_ref_buf(ctx, run, i);
> -
> +               struct vb2_buffer *vb_buf = run->ref_buf[i];
> +
> +               /*
> +                * If a DPB entry is unused or invalid, address of current destination
> +                * buffer is returned.
> +                */
> +               if (!vb_buf)
> +                       vb_buf = &dst_buf->vb2_buf;
>                 refer_addr = vb2_dma_contig_plane_dma_addr(vb_buf, 0);
>
>                 if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE)
> diff --git a/drivers/staging/media/rkvdec/rkvdec-vp9.c b/drivers/staging/media/rkvdec/rkvdec-vp9.c
> index c2f42e76be10..d8c1c0db15c7 100644
> --- a/drivers/staging/media/rkvdec/rkvdec-vp9.c
> +++ b/drivers/staging/media/rkvdec/rkvdec-vp9.c
> @@ -383,17 +383,17 @@ get_ref_buf(struct rkvdec_ctx *ctx, struct vb2_v4l2_buffer *dst, u64 timestamp)
>  {
>         struct v4l2_m2m_ctx *m2m_ctx = ctx->fh.m2m_ctx;
>         struct vb2_queue *cap_q = &m2m_ctx->cap_q_ctx.q;
> -       int buf_idx;
> +       struct vb2_buffer *buf;
>
>         /*
>          * If a ref is unused or invalid, address of current destination
>          * buffer is returned.
>          */
> -       buf_idx = vb2_find_timestamp(cap_q, timestamp, 0);
> -       if (buf_idx < 0)
> -               return vb2_to_rkvdec_decoded_buf(&dst->vb2_buf);
> +       buf = vb2_find_buffer(cap_q, timestamp);
> +       if (!buf)
> +               buf = &dst->vb2_buf;
>
> -       return vb2_to_rkvdec_decoded_buf(vb2_get_buffer(cap_q, buf_idx));
> +       return vb2_to_rkvdec_decoded_buf(buf);
>  }
>
>  static dma_addr_t get_mv_base_addr(struct rkvdec_decoded_buffer *buf)
> --
> 2.34.3
>
