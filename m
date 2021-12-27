Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2F247FAB6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 08:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235446AbhL0HMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 02:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhL0HMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 02:12:34 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A543C06173E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 23:12:34 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id p14so10859978plf.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 23:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5NO1al33KK9AHVngYVbDZ//RPzqF3GCVIYpihpM+V6E=;
        b=nbcXBPQ/7er1rZWmEfpq0TF/KSxhRx0TV39wk5WBswwtHGHRf13BjvS4oPacEr2phQ
         GIJJy0KN5yms6XcELwEfT95jAlJN7EB7BY+C6lw6M5lJdZeOXtIG2OmMEIY3KnwigNDC
         veTXyaLZUBkBlsHd+/DsjCiRoAdZZcCPGBV6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5NO1al33KK9AHVngYVbDZ//RPzqF3GCVIYpihpM+V6E=;
        b=XKpzYGWk8nVyROwnB0fBlQ+gVYNsyadXOxXeXIJmkj/WaNfuANkQwaUC6VK00sVmlT
         4IHIyHmiKBArwx1DKdYlmgesY8eEt/7MVftGUsgud3ocdew1v/gPVvbTwG/339rdWVL5
         Dv+AQ5k91hBGvsWx0aVemwmoTHXwhKWlvabcyO9kY4c+aUYxrkDo7a7iIftN8nUBnG9c
         cE89j5YMOqmjLvcXN7fMU+lSNVaEuKT6l5U7qr50/fh9HFLIkkdjbP1wfh9djTbGamji
         GIdN8SSCybGMynB7D0GHq51eAn49ckktGOVIx6+HzElQcjEwvW65xv/ONzBTZv9D+4w9
         +4Hw==
X-Gm-Message-State: AOAM53179hEUz24nD45H3QgU7Kkf2/+3Op9/+a9xpTvFFZdSGMyTFnrk
        2rdl+HrbgzqiJZt5VswgV+vepcqDQ46knQ==
X-Google-Smtp-Source: ABdhPJx+DkoXBogux8OH/JKsOfaOVgKo1yIWVijZsmVrKcS84J4XOvd+zGO2fx4FCLndqXtQ/aX8fg==
X-Received: by 2002:a17:902:8d8c:b0:149:4497:faab with SMTP id v12-20020a1709028d8c00b001494497faabmr16208712plo.161.1640589153994;
        Sun, 26 Dec 2021 23:12:33 -0800 (PST)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com. [209.85.210.177])
        by smtp.gmail.com with ESMTPSA id e35sm13361254pgm.92.2021.12.26.23.12.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Dec 2021 23:12:33 -0800 (PST)
Received: by mail-pf1-f177.google.com with SMTP id 8so13002286pfo.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 23:12:33 -0800 (PST)
X-Received: by 2002:a05:6102:e89:: with SMTP id l9mr4547183vst.80.1640588810744;
 Sun, 26 Dec 2021 23:06:50 -0800 (PST)
MIME-Version: 1.0
References: <20211117130635.11633-1-dafna.hirschfeld@collabora.com> <20211117130635.11633-8-dafna.hirschfeld@collabora.com>
In-Reply-To: <20211117130635.11633-8-dafna.hirschfeld@collabora.com>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Mon, 27 Dec 2021 16:06:39 +0900
X-Gmail-Original-Message-ID: <CAPBb6MX8Yq5eoumOUxK+OmSEu6cQE8nqfABtHTz+UdAsRfXtvQ@mail.gmail.com>
Message-ID: <CAPBb6MX8Yq5eoumOUxK+OmSEu6cQE8nqfABtHTz+UdAsRfXtvQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] meida: mtk-vcodec: remove unused func parameter
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
> The prarameter bs_size to function vpu_enc_encode
> is not used. Remove it.
>
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>

Indeed, it's an output parameter of the calling functions and has no
business being passed to vpu_enc_encode.

With the typo in the headline fixed,

Reviewed-by: Alexandre Courbot <acourbot@chromium.org>


> ---
>  drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c | 9 +++------
>  drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c  | 3 +--
>  drivers/media/platform/mtk-vcodec/venc_vpu_if.c       | 1 -
>  drivers/media/platform/mtk-vcodec/venc_vpu_if.h       | 1 -
>  4 files changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c b/drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c
> index b6a4f2074fa5..bf03888a824f 100644
> --- a/drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c
> +++ b/drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c
> @@ -367,8 +367,7 @@ static int h264_encode_sps(struct venc_h264_inst *inst,
>
>         mtk_vcodec_debug_enter(inst);
>
> -       ret = vpu_enc_encode(&inst->vpu_inst, H264_BS_MODE_SPS, NULL,
> -                            bs_buf, bs_size, NULL);
> +       ret = vpu_enc_encode(&inst->vpu_inst, H264_BS_MODE_SPS, NULL, bs_buf, NULL);
>         if (ret)
>                 return ret;
>
> @@ -394,8 +393,7 @@ static int h264_encode_pps(struct venc_h264_inst *inst,
>
>         mtk_vcodec_debug_enter(inst);
>
> -       ret = vpu_enc_encode(&inst->vpu_inst, H264_BS_MODE_PPS, NULL,
> -                            bs_buf, bs_size, NULL);
> +       ret = vpu_enc_encode(&inst->vpu_inst, H264_BS_MODE_PPS, NULL, bs_buf, NULL);
>         if (ret)
>                 return ret;
>
> @@ -451,8 +449,7 @@ static int h264_encode_frame(struct venc_h264_inst *inst,
>         mtk_vcodec_debug(inst, "frm_count = %d,skip_frm_count =%d,frm_type=%d.\n",
>                          frame_info.frm_count, frame_info.skip_frm_count,
>                          frame_info.frm_type);
> -       ret = vpu_enc_encode(&inst->vpu_inst, H264_BS_MODE_FRAME, frm_buf,
> -                            bs_buf, bs_size, &frame_info);
> +       ret = vpu_enc_encode(&inst->vpu_inst, H264_BS_MODE_FRAME, frm_buf, bs_buf, &frame_info);
>         if (ret)
>                 return ret;
>
> diff --git a/drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c b/drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c
> index 8267a9c4fd25..6b66957d5192 100644
> --- a/drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c
> +++ b/drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c
> @@ -302,8 +302,7 @@ static int vp8_enc_encode_frame(struct venc_vp8_inst *inst,
>
>         mtk_vcodec_debug(inst, "->frm_cnt=%d", inst->frm_cnt);
>
> -       ret = vpu_enc_encode(&inst->vpu_inst, 0, frm_buf, bs_buf, bs_size,
> -                            NULL);
> +       ret = vpu_enc_encode(&inst->vpu_inst, 0, frm_buf, bs_buf, NULL);
>         if (ret)
>                 return ret;
>
> diff --git a/drivers/media/platform/mtk-vcodec/venc_vpu_if.c b/drivers/media/platform/mtk-vcodec/venc_vpu_if.c
> index be6d8790a41e..e7899d8a3e4e 100644
> --- a/drivers/media/platform/mtk-vcodec/venc_vpu_if.c
> +++ b/drivers/media/platform/mtk-vcodec/venc_vpu_if.c
> @@ -225,7 +225,6 @@ int vpu_enc_set_param(struct venc_vpu_inst *vpu,
>  int vpu_enc_encode(struct venc_vpu_inst *vpu, unsigned int bs_mode,
>                    struct venc_frm_buf *frm_buf,
>                    struct mtk_vcodec_mem *bs_buf,
> -                  unsigned int *bs_size,
>                    struct venc_frame_info *frame_info)
>  {
>         const bool is_ext = MTK_ENC_CTX_IS_EXT(vpu->ctx);
> diff --git a/drivers/media/platform/mtk-vcodec/venc_vpu_if.h b/drivers/media/platform/mtk-vcodec/venc_vpu_if.h
> index f9be9cab7ff7..f83bc1b3f2bf 100644
> --- a/drivers/media/platform/mtk-vcodec/venc_vpu_if.h
> +++ b/drivers/media/platform/mtk-vcodec/venc_vpu_if.h
> @@ -45,7 +45,6 @@ int vpu_enc_set_param(struct venc_vpu_inst *vpu,
>  int vpu_enc_encode(struct venc_vpu_inst *vpu, unsigned int bs_mode,
>                    struct venc_frm_buf *frm_buf,
>                    struct mtk_vcodec_mem *bs_buf,
> -                  unsigned int *bs_size,
>                    struct venc_frame_info *frame_info);
>  int vpu_enc_deinit(struct venc_vpu_inst *vpu);
>
> --
> 2.17.1
>
