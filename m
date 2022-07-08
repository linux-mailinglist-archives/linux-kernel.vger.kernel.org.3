Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B2656B8D2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 13:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238116AbiGHLrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 07:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238114AbiGHLrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 07:47:39 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811D5951E5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 04:47:38 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id c13so26794789qtq.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 04:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UzvQM908Jy3z5GL48S8s+55sngOGG+1Pc7lf5lQnBIE=;
        b=B+WLrHnUpf4IwJX0fM9iKELpWbwiEZR2q0T5c2SjIkdDYwj3/DfXAuz2d5VXl7DOJ+
         NY1rQM7C7zHA6ARDY6KjkfeLOT3TypcJeCRHuWLA67ZHd5a0tiIhzx44Hv06GQrMRvRA
         uv5dcJ2TvsdyocWpeIsb0jEPDx5ggXg+Bkg9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UzvQM908Jy3z5GL48S8s+55sngOGG+1Pc7lf5lQnBIE=;
        b=BOG1zml1myzj6rezKx4DTagVZyQcs3j9QXrqVpbXERlKEtIj1OL32jJ4+GzbcYX+I0
         5UJIM5hjK79aDSiB7l08TQOYg1faVrVUI+7ItkQOYVbnX4QN/CjN5J0uJF7tReUlVQeP
         mG61uzWHY2PBVJrctNiIlWh9cKcund0U02SNt40F0enRWR6GPdwssRlL6uP1RxdSlncQ
         256JLCyGQ7iUj7ivgV8gKJTL0PTKv/PwlW3nGEdR8siIkxAzlK9QjL5Scd9gs0sdr3YT
         zyItD1BshjEeC1EpzR5GODiReoWBymTlALWoa28IQTazX/AfM/77kQY9y1DZNkN79wXs
         kpxw==
X-Gm-Message-State: AJIora8LQvr+V3Y4RehFh7zTfqtWhgFfTyIuINQFo/WL4PJIcktDivst
        UA7FtQNFSfsntk7lANhMXZHw4va4BTSqTw==
X-Google-Smtp-Source: AGRyM1tOENfroXdH+IreCC2ZpiPCfzqHv/8ew1t7YlJdoemzrr+x3+VVMD72iz9aVFlQneDKoe4TxA==
X-Received: by 2002:a05:622a:7:b0:31b:74bd:1597 with SMTP id x7-20020a05622a000700b0031b74bd1597mr2364798qtw.677.1657280857401;
        Fri, 08 Jul 2022 04:47:37 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id l12-20020a37f90c000000b006b14fb1ba18sm21132623qkj.35.2022.07.08.04.47.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 04:47:36 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id y195so6147924yby.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 04:47:36 -0700 (PDT)
X-Received: by 2002:a25:1583:0:b0:668:e74a:995f with SMTP id
 125-20020a251583000000b00668e74a995fmr3183243ybv.1.1657280855797; Fri, 08 Jul
 2022 04:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220706182657.210650-1-ezequiel@vanguardiasur.com.ar> <CAAFQd5Ap=oY8nf8d=o3p1D8avkmxPXvJz5X5SAaAS3M-pTC7_Q@mail.gmail.com>
In-Reply-To: <CAAFQd5Ap=oY8nf8d=o3p1D8avkmxPXvJz5X5SAaAS3M-pTC7_Q@mail.gmail.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 8 Jul 2022 20:47:25 +0900
X-Gmail-Original-Message-ID: <CAAFQd5C--1RFVxBvLWXZqOp3sh+fxiOobDrht_7ejRHSBHfdHg@mail.gmail.com>
Message-ID: <CAAFQd5C--1RFVxBvLWXZqOp3sh+fxiOobDrht_7ejRHSBHfdHg@mail.gmail.com>
Subject: Re: [PATCH 0/8] videobuf2: Replace vb2_find_timestamp() with vb2_find_buffer()
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

On Fri, Jul 8, 2022 at 1:47 PM Tomasz Figa <tfiga@chromium.org> wrote:
>
> Hi Ezequiel,
>
> On Thu, Jul 7, 2022 at 3:27 AM Ezequiel Garcia
> <ezequiel@vanguardiasur.com.ar> wrote:
> >
> > All users of vb2_find_timestamp() combine it with vb2_get_buffer()
> > to retrieve a videobuf2 buffer, given a u64 timestamp.
> >
> > Therefore, this series removes vb2_find_timestamp() and instead
> > introduces a vb2_find_buffer, which is more suitable, making
> > videobuf2 API slightly cleaner.
> >
> > Ezequiel Garcia (8):
> >   videobuf2: Introduce vb2_find_buffer()
> >   mediatek: vcodec: Use vb2_find_buffer
> >   tegra-vde: Use vb2_find_buffer
> >   vicodec: Use vb2_find_buffer
> >   hantro: Use vb2_find_buffer
> >   rkvdec: Use vb2_find_buffer
> >   cedrus: Use vb2_find_buffer
> >   videobuf2: Remove vb2_find_timestamp()
> >
> >  .../media/common/videobuf2/videobuf2-v4l2.c   | 12 ++---
> >  .../vcodec/vdec/vdec_h264_req_common.c        |  7 ++-
> >  .../mediatek/vcodec/vdec/vdec_vp8_req_if.c    |  7 ++-
> >  .../vcodec/vdec/vdec_vp9_req_lat_if.c         |  8 +--
> >  .../media/platform/nvidia/tegra-vde/h264.c    |  9 ++--
> >  .../media/test-drivers/vicodec/vicodec-core.c |  8 +--
> >  drivers/staging/media/hantro/hantro_drv.c     |  6 +--
> >  .../staging/media/hantro/hantro_g2_vp9_dec.c  | 10 ++--
> >  drivers/staging/media/rkvdec/rkvdec-h264.c    | 41 ++++++---------
> >  drivers/staging/media/rkvdec/rkvdec-vp9.c     | 10 ++--
> >  drivers/staging/media/sunxi/cedrus/cedrus.h   | 13 +----
> >  .../staging/media/sunxi/cedrus/cedrus_h264.c  | 16 +++---
> >  .../staging/media/sunxi/cedrus/cedrus_h265.c  | 16 +++---
> >  .../staging/media/sunxi/cedrus/cedrus_mpeg2.c | 36 ++++++-------
> >  .../staging/media/sunxi/cedrus/cedrus_vp8.c   | 50 ++++++-------------
> >  include/media/videobuf2-v4l2.h                | 12 ++---
> >  16 files changed, 100 insertions(+), 161 deletions(-)
> >
> > --
> > 2.34.3
> >
>
> Thanks for the series! I think it's a nice cleanup indeed, but please
> see a few comments in my replies to individual patches.

As we clarified my concern in one of the patches and the other one was
purely stylistic, feel free to just add my

Acked-by: Tomasz Figa <tfiga@chromium.org>

to the entire series. The stylistic one can be ignored if there is no
other change needed.

Best regards,
Tomasz
