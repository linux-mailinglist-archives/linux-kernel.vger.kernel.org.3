Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC3256B1D2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 06:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237223AbiGHEr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 00:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237210AbiGHErX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 00:47:23 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C873E023
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 21:47:22 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id v6so14976764qkh.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 21:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Ih4uyKjXNRK2+O+XI6blNNhZM/IgSk7Uel9KFwQu5E=;
        b=b0ZddOV/wKmYfAX5xRnmoZkL0d8bYZJRspOUzYxGlKP4AoSE2NP108KTWj+EPK8YPv
         ksJxTr3hn84QYpDP+F68jMWaF4HIqJhpSigOFYTc+avE9tmIETue9j2gHdKqsYEiF9le
         Sn622V5IW06fOGT0S66Uwbc5C/YfSVfixxJBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Ih4uyKjXNRK2+O+XI6blNNhZM/IgSk7Uel9KFwQu5E=;
        b=7oEZIoI4vJRLGWhBh8XQzSvZAS/YbrEkheRd7Rw887g29h4RD2uPPSbm5tC9tnhKzq
         NAz9AE0wB4SRV4xRDjzjIM8p5KVwd0sBfQP/6KDw0j3WbTo24AP2MiU8vAPXav+ZQay2
         HHvnQT+2LCAawu8wrl22xG5cdVgvdONs2trb5n57z4Pc0GYN0Y0wWfVu780SYjV+Y99b
         ebL9H5GFxay8UL4l293hAMTmXk1U+Qab62TWJJkw0eGaCeYBzkgtOYwL8gMIwAVYv9dm
         i4KseSLnVL5IHUkqc82JMocNcXc6pd4VBWiQR2MemFU4a9GaK1nhSEKOr8Z0Fnbm0Y6M
         Nk3w==
X-Gm-Message-State: AJIora//GVaoVj61MSBES3jI8YqlxwQEZfNVXxjxqlgMJoywO963/aA6
        3l9DZni5TJc68rVjbOLChdYYTkzJtfppuidr
X-Google-Smtp-Source: AGRyM1toqlxoc6VlKyoH5YUDqM3fyz0A21ROlAvjiZC694YpXCHSbaGzzutfGVfRdXlmy5UMpJP/lA==
X-Received: by 2002:a05:620a:801a:b0:6ae:fe00:34f7 with SMTP id ee26-20020a05620a801a00b006aefe0034f7mr1021340qkb.79.1657255641318;
        Thu, 07 Jul 2022 21:47:21 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id bl10-20020a05620a1a8a00b006a67eb4610fsm34336785qkb.116.2022.07.07.21.47.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 21:47:20 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id g4so36033413ybg.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 21:47:20 -0700 (PDT)
X-Received: by 2002:a25:858e:0:b0:66e:4898:63e2 with SMTP id
 x14-20020a25858e000000b0066e489863e2mr1750974ybk.296.1657255639791; Thu, 07
 Jul 2022 21:47:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220706182657.210650-1-ezequiel@vanguardiasur.com.ar>
In-Reply-To: <20220706182657.210650-1-ezequiel@vanguardiasur.com.ar>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Fri, 8 Jul 2022 13:47:06 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Ap=oY8nf8d=o3p1D8avkmxPXvJz5X5SAaAS3M-pTC7_Q@mail.gmail.com>
Message-ID: <CAAFQd5Ap=oY8nf8d=o3p1D8avkmxPXvJz5X5SAaAS3M-pTC7_Q@mail.gmail.com>
Subject: Re: [PATCH 0/8] videobuf2: Replace vb2_find_timestamp() with vb2_find_buffer()
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
> All users of vb2_find_timestamp() combine it with vb2_get_buffer()
> to retrieve a videobuf2 buffer, given a u64 timestamp.
>
> Therefore, this series removes vb2_find_timestamp() and instead
> introduces a vb2_find_buffer, which is more suitable, making
> videobuf2 API slightly cleaner.
>
> Ezequiel Garcia (8):
>   videobuf2: Introduce vb2_find_buffer()
>   mediatek: vcodec: Use vb2_find_buffer
>   tegra-vde: Use vb2_find_buffer
>   vicodec: Use vb2_find_buffer
>   hantro: Use vb2_find_buffer
>   rkvdec: Use vb2_find_buffer
>   cedrus: Use vb2_find_buffer
>   videobuf2: Remove vb2_find_timestamp()
>
>  .../media/common/videobuf2/videobuf2-v4l2.c   | 12 ++---
>  .../vcodec/vdec/vdec_h264_req_common.c        |  7 ++-
>  .../mediatek/vcodec/vdec/vdec_vp8_req_if.c    |  7 ++-
>  .../vcodec/vdec/vdec_vp9_req_lat_if.c         |  8 +--
>  .../media/platform/nvidia/tegra-vde/h264.c    |  9 ++--
>  .../media/test-drivers/vicodec/vicodec-core.c |  8 +--
>  drivers/staging/media/hantro/hantro_drv.c     |  6 +--
>  .../staging/media/hantro/hantro_g2_vp9_dec.c  | 10 ++--
>  drivers/staging/media/rkvdec/rkvdec-h264.c    | 41 ++++++---------
>  drivers/staging/media/rkvdec/rkvdec-vp9.c     | 10 ++--
>  drivers/staging/media/sunxi/cedrus/cedrus.h   | 13 +----
>  .../staging/media/sunxi/cedrus/cedrus_h264.c  | 16 +++---
>  .../staging/media/sunxi/cedrus/cedrus_h265.c  | 16 +++---
>  .../staging/media/sunxi/cedrus/cedrus_mpeg2.c | 36 ++++++-------
>  .../staging/media/sunxi/cedrus/cedrus_vp8.c   | 50 ++++++-------------
>  include/media/videobuf2-v4l2.h                | 12 ++---
>  16 files changed, 100 insertions(+), 161 deletions(-)
>
> --
> 2.34.3
>

Thanks for the series! I think it's a nice cleanup indeed, but please
see a few comments in my replies to individual patches.

Best regards,
Tomasz
