Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB809465A0F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 00:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353895AbhLAX6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 18:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344023AbhLAX6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 18:58:48 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AFEC061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 15:55:26 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id b67so32920899qkg.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 15:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GVZ70Dywr625UyFi302s6LjnjHklxJb/tfvnMbwjLaM=;
        b=jCkXdMKskBUT2OYx7Iaa2BLRafUdDejK8djqWKix9T6swIAuLZxsGqdR4LzM5/sE3G
         JDmzjvBHFhnRgl47r/VjZFASHCgHpTdLo1VGBGxbbWxVmTPdWgGsuRfuzt8akpS21HLg
         OTBZNZBgwEoYUu53vs0qkpJYiVPEorqa7Ri40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GVZ70Dywr625UyFi302s6LjnjHklxJb/tfvnMbwjLaM=;
        b=5FKQsG8oAZrOMJ/6QE5X95XjqHNYWkoiMMIuBdvp3iIYiv2AmCssKxzDgEwUptIIWv
         FYaT2956QM7YT5e4FcX/mfb6mdGnG1WTwcbK688nlLbLFgcF6/TYIqeLRj8VzWIUqMYu
         7EfKjY59uzQ6Qeqj+uaZRiPWUl9kuQ1FeYygxMaV5whaFbMWoauURXG2fY6dJ4YkHMmD
         amTnyFZwtmCS7e73VJtfeIimhxpjhaxMcF75T+DwASVHHFoMI7qFkJR80mTnDTWbFMCk
         bkm6r7hkKWNls17TMf77g5LFQ5tKWyddj8I9DrV+fKKiXY0GpoHbavkI2DmycXrtw9Kr
         GofQ==
X-Gm-Message-State: AOAM531m93i72g8MBU9wtIwJzoROwUzH3aLl/Sz5deEZ16ipEjKFf15Y
        pv/vLVhhQ41B4Y+oGc6FM3BBh58UIfXmTtngdyikcg==
X-Google-Smtp-Source: ABdhPJwDrESPOFAKGV76+3Yd4DHuNO5qwOKr/plQ6gy9TgikmfsgmMo5D/ZY+B7br+XAoX3AcL0s/vToKivqbssMv5Q=
X-Received: by 2002:a37:8805:: with SMTP id k5mr9678214qkd.426.1638402926057;
 Wed, 01 Dec 2021 15:55:26 -0800 (PST)
MIME-Version: 1.0
References: <20211129034201.5767-1-yunfei.dong@mediatek.com> <20211129034201.5767-3-yunfei.dong@mediatek.com>
In-Reply-To: <20211129034201.5767-3-yunfei.dong@mediatek.com>
From:   Steve Cho <stevecho@chromium.org>
Date:   Wed, 1 Dec 2021 15:55:15 -0800
Message-ID: <CAC-pXoPXc=q8KPUcSfY6XZ=sLt71vDZbJV=f4SZx55Gc6VbRQw@mail.gmail.com>
Subject: Re: [PATCH v11, 02/19] media: mtk-vcodec: Align vcodec wake up
 interrupt interface
To:     Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LGTM.

On Sun, Nov 28, 2021 at 7:44 PM Yunfei Dong <yunfei.dong@mediatek.com> wrote:
>
> Vdec and venc can use the same function to wake up interrupt event.
>
> Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>  drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c | 9 +--------
>  drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h     | 8 ++++++++
>  drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c | 8 --------
>  3 files changed, 9 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
> index 59caf2163349..055d50e52720 100644
> --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
> +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
> @@ -31,13 +31,6 @@
>  module_param(mtk_v4l2_dbg_level, int, 0644);
>  module_param(mtk_vcodec_dbg, bool, 0644);
>
> -/* Wake up context wait_queue */
> -static void wake_up_ctx(struct mtk_vcodec_ctx *ctx)
> -{
> -       ctx->int_cond = 1;
> -       wake_up_interruptible(&ctx->queue);
> -}
> -
>  static irqreturn_t mtk_vcodec_dec_irq_handler(int irq, void *priv)
>  {
>         struct mtk_vcodec_dev *dev = priv;
> @@ -69,7 +62,7 @@ static irqreturn_t mtk_vcodec_dec_irq_handler(int irq, void *priv)
>         writel((readl(vdec_misc_addr) & ~VDEC_IRQ_CLR),
>                 dev->reg_base[VDEC_MISC] + VDEC_IRQ_CFG_REG);
>
> -       wake_up_ctx(ctx);
> +       wake_up_ctx(ctx, MTK_INST_IRQ_RECEIVED);

Assuming setting up reason doesn't change functionality.

>
>         mtk_v4l2_debug(3,
>                         "mtk_vcodec_dec_irq_handler :wake up ctx %d, dec_done_status=%x",
> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
> index 581522177308..1d2370608d0d 100644
> --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
> +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
> @@ -473,4 +473,12 @@ static inline struct mtk_vcodec_ctx *ctrl_to_ctx(struct v4l2_ctrl *ctrl)
>         return container_of(ctrl->handler, struct mtk_vcodec_ctx, ctrl_hdl);
>  }
>
> +/* Wake up context wait_queue */
> +static inline void wake_up_ctx(struct mtk_vcodec_ctx *ctx, unsigned int reason)
> +{
> +       ctx->int_cond = 1;
> +       ctx->int_type = reason;
> +       wake_up_interruptible(&ctx->queue);
> +}
> +
>  #endif /* _MTK_VCODEC_DRV_H_ */
> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
> index eed67394cf46..7c3487fb3498 100644
> --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
> +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
> @@ -65,14 +65,6 @@ static const struct mtk_video_fmt mtk_video_formats_capture_vp8[] =  {
>         },
>  };
>
> -/* Wake up context wait_queue */
> -static void wake_up_ctx(struct mtk_vcodec_ctx *ctx, unsigned int reason)
> -{
> -       ctx->int_cond = 1;
> -       ctx->int_type = reason;
> -       wake_up_interruptible(&ctx->queue);
> -}
> -
>  static void clean_irq_status(unsigned int irq_status, void __iomem *addr)
>  {
>         if (irq_status & MTK_VENC_IRQ_STATUS_PAUSE)
> --
> 2.25.1
>
