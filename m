Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB5204810A4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 08:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239103AbhL2H1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 02:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239094AbhL2H1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 02:27:24 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE10DC06173E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 23:27:23 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id f18-20020a17090aa79200b001ad9cb23022so19171956pjq.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 23:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eZSNki/251fDYLWVkOPn8gWn57CxzUzo65fAsecZzSY=;
        b=C2b0u1tClTPmdQioW+rxkZ+V7pqKZXRaISlUmt8iCW927RhgQrOFUcbd6meMPzDYNJ
         vx/XLkZIkznWTkZgvAJ0ypkuBP40ipDUo3JMy4vf3JbUxpYhuOGGxI3JuXXye7pCnNXn
         OHFvXOdT2LXYXBGWmxRgIZgz0RV/Sdkl5FYD5J82qNlhU2jZNlaB03hEd6b34lmLCcpQ
         YED6khoDbdY0+qbd/rqXiy3pREdcFpr0WizTcRnrPvPmpwUgw5+wkuXI7xO9d6X8xnTE
         021Ucv5pypqtaIcTorUmLe52PUYDNHSXbPkhRRZ6tIZ/1Yr4jRcacTFc0vZ6xiGpSehi
         KHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eZSNki/251fDYLWVkOPn8gWn57CxzUzo65fAsecZzSY=;
        b=kWA+hjJ3ZEGOM0S0hArCFM6w7XLhrHGcCEl0Sg4tabbD8l9dYqcIB8/KvImc1lytou
         Qwwm6YSU/KUplr7rlm7bcpGQyP7RGHYeZDRHLhsrH4iLk/g+e4nZrKRU+l0qF6ZCOuKc
         uKP6myQ7uUCakXDt2aHpTUJ0JZIXtQxzIdOpDg26ckTSiH8U4+MYwl79gcB1/bq+i+9v
         a2hXtAGSznffGuywPvN6VkIhbHTll+DitJMUZau0jRHBcUJjP6gcCOvJKvEPRGq6XjrL
         avZNVLJv87MjUB69c6WS61pDHJVCtQem2TLXl5E43xdeA4PajDfNASHJQwcmyqKWRPca
         wSSg==
X-Gm-Message-State: AOAM5316LY99qAv5e/2v/DHugc9xAgH3U44qt4lIkxtGfrSRV6PYmkFZ
        zPqdqh2YoZXqSUfEklkYgIsKkKornk8WusXVQPRIWg==
X-Google-Smtp-Source: ABdhPJwdorV9rKsCXwNUTFsMyMCJcCadilIxzOqhyG+k64txb8IQphCdPdY79KAgaFh5MoE1tQRj+5vGer2dfAH87+8=
X-Received: by 2002:a17:902:b591:b0:149:66d6:7589 with SMTP id
 a17-20020a170902b59100b0014966d67589mr19576058pls.24.1640762843190; Tue, 28
 Dec 2021 23:27:23 -0800 (PST)
MIME-Version: 1.0
References: <20211228094146.20505-1-yunfei.dong@mediatek.com>
 <20211228094146.20505-4-yunfei.dong@mediatek.com> <Ycvz4UrmbngVzIv2@google.com>
 <8102ba18b3fdcc19e6b9f53c7a635ffc084c825b.camel@mediatek.com>
In-Reply-To: <8102ba18b3fdcc19e6b9f53c7a635ffc084c825b.camel@mediatek.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Wed, 29 Dec 2021 15:27:11 +0800
Message-ID: <CA+Px+wU2aU_t2F2XOsjf5vRUikQPaftRa9062CCCNwRJK-WA3w@mail.gmail.com>
Subject: Re: [PATCH v2, 03/12] media: mtk-vcodec: get capture queue buffer
 size from scp
To:     "yunfei.dong@mediatek.com" <Yunfei.Dong@mediatek.com>
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
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021 at 2:52 PM yunfei.dong@mediatek.com
<yunfei.dong@mediatek.com> wrote:
> On Wed, 2021-12-29 at 13:36 +0800, Tzung-Bi Shih wrote:
> > On Tue, Dec 28, 2021 at 05:41:37PM +0800, Yunfei Dong wrote:
> > > From: Yunfei Dong <yunfei.dong@mediatek.corp-partner.google.com>
> >
> > [...]
> > > diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
> > > b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
> > > index 130ecef2e766..87891ebd7246 100644
> > > --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
> > > +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
> > > @@ -466,6 +466,8 @@ static int vidioc_vdec_s_fmt(struct file *file,
> > > void *priv,
> > >                     }
> > >                     ctx->state = MTK_STATE_INIT;
> > >             }
> > > +   } else {
> > > +           ctx->capture_fourcc = fmt->fourcc;
> > >     }
> > >
> > >     /*
> > > diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
> > > b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
> > > index a23a7646437c..95e07cf2cd3e 100644
> > > --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
> > > +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
> > > @@ -277,6 +277,7 @@ struct vdec_pic_info {
> > >   *              to be used with encoder and stateful decoder.
> > >   * @is_flushing: set to true if flushing is in progress.
> > >   * @current_codec: current set input codec, in V4L2 pixel format
> > > + * @capture_fourcc: capture queue type in V4L2 pixel format
> > >   *
> > >   * @colorspace: enum v4l2_colorspace; supplemental to pixelformat
> > >   * @ycbcr_enc: enum v4l2_ycbcr_encoding, Y'CbCr encoding
> > > @@ -322,6 +323,7 @@ struct mtk_vcodec_ctx {
> > >     bool is_flushing;
> > >
> > >     u32 current_codec;
> > > +   u32 capture_fourcc;
> >
> > What is the purpose of capture_fourcc?  It is not used.
> >
> Need to calculate each plane size according to capture fourcc type from
> scp. The plane size of MM21 is different with MT21C. And the capture
> fourcc type of different codec maybe different.

Purpose of capture_fourcc in the context is not obvious and looks
irrelevant to the patch.  Could it move to somewhere patch that makes
more sense?

> > > +/**
> > > + * struct vdec_ap_ipi_get_param - for AP_IPIMSG_SET_PARAM
> > > + * @msg_id : AP_IPIMSG_DEC_START
> > > + * @inst_id     : instance ID. Used if the ABI version >= 2.
> > > + * @data   : picture information
> > > + * @param_type     : get param type
> > > + * @codec_type     : Codec fourcc
> > > + */
> > > +struct vdec_ap_ipi_get_param {
> > > +   uint32_t msg_id;
> > > +   uint32_t inst_id;
> > > +   uint32_t data[4];
> > > +   uint32_t param_type;
> > > +   uint32_t codec_type;
> > > +};
> >
> > Are AP_IPIMSG_SET_PARAM and AP_IPIMSG_DEC_START typos?
> >
> It's getting message from scp side. It's looks much better to add one
> new path from ap to scp.

Pardon me, I failed to understand it.  I thought the struct could be
for AP_IPIMSG_DEC_GET_PARAM.

> > > +/**
> > > + * struct vdec_vpu_ipi_init_ack - for VPU_IPIMSG_DEC_INIT_ACK
> > > + * @msg_id : VPU_IPIMSG_DEC_INIT_ACK
> > > + * @status : VPU exeuction result
> > > + * @ap_inst_addr   : AP vcodec_vpu_inst instance address
> > > + * @data     : picture information from SCP.
> > > + * @param_type     : get param type
> > > + */
> > > +struct vdec_vpu_ipi_get_param_ack {
> > > +   uint32_t msg_id;
> > > +   int32_t status;
> > > +   uint64_t ap_inst_addr;
> > > +   uint32_t data[4];
> > > +   uint32_t param_type;
> > > +   uint32_t reserved;
> > > +};
> >
> > Same here: is VPU_IPIMSG_DEC_INIT_ACK a typo?
> >
> It's getting message from scp side. It's looks much better to add one new path from ap to scp.

Same here: I thought it was for VPU_IPIMSG_DEC_GET_PARAM_ACK.

> > > diff --git a/drivers/media/platform/mtk-vcodec/vdec_vpu_if.h
> > > b/drivers/media/platform/mtk-vcodec/vdec_vpu_if.h
> > > index 4cb3c7f5a3ad..963f8d4877b7 100644
> > > --- a/drivers/media/platform/mtk-vcodec/vdec_vpu_if.h
> > > +++ b/drivers/media/platform/mtk-vcodec/vdec_vpu_if.h
> > > @@ -28,6 +28,8 @@ struct mtk_vcodec_ctx;
> > >   * @wq          : wait queue to wait VPU message ack
> > >   * @handler     : ipi handler for each decoder
> > >   * @codec_type     : use codec type to separate different codecs
> > > + * @capture_type    : used capture type to separate different
> > > capture format
> > > + * @fb_sz  : frame buffer size of each plane
> > >   */
> > >  struct vdec_vpu_inst {
> > >     int id;
> > > @@ -42,6 +44,8 @@ struct vdec_vpu_inst {
> > >     wait_queue_head_t wq;
> > >     mtk_vcodec_ipi_handler handler;
> > >     unsigned int codec_type;
> > > +   unsigned int capture_type;
> > > +   unsigned int fb_sz[2];
> > >  };
> >
> > capture_type is not used in the patch.
> >
> Capture type will be used in scp to get capture plane size according to
> capture buffer type.

Pardon me, I failed to understand it.  I may misunderstand, however,
it doesn't look like a shared memory structure between AP and SCP.

At least to me, capture_type is not used in the patch.  It could be
better to move it to somewhere patch that makes more sense.

> > Does fb_sz take effect in later patches?
>
> Don't have effect to later patches.

Is the fb_sz used somewhere "later"?  The patch gets fb_sz from SCP,
however, fb_sz is never used in some control or configuration paths.
