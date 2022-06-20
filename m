Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43845524DF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 21:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237198AbiFTT4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 15:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiFTT4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 15:56:35 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63681CFD0;
        Mon, 20 Jun 2022 12:56:34 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id q15so6362632wmj.2;
        Mon, 20 Jun 2022 12:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8JXpksGN8on+hs1kw2vF/ANqrZgfrCyZJ79yotiZS7o=;
        b=Jxj0yKO8OaskheKCkkfQI5jMOBb26izi/IghJ+NTGUFIzOOsB0CmFD4RPNwUNtaLof
         /C3hAXGVclJM0vR6lh8CDHU4GMMT9xyh7RiksMHIaBii/MzeZK68bgHz+LcafyrE+gMc
         mMfCsWH9mQASrfIFkwr05Wrot/6BG81EdYq7EXv40E5YmGAMSUXSS3w0ZBtBKg6LYTZ3
         HtU+cy5glXehl52TcQI/z1P1oNg9rBXNQ87Dxw7DoGIEGaj2SKzjVcwdP+nKFoP63sGx
         0f4eyLLsx9Sux8ZhyLxge2I8edbegqFVWISeEpE8uHp9q2Ea9hY+homqRtUzV/v2T3mA
         gwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8JXpksGN8on+hs1kw2vF/ANqrZgfrCyZJ79yotiZS7o=;
        b=0WsX1I1ni6kGGmT9RPQIQf9HUTMp1+KoDu6MTR2zyioa/ppNgPylZpno66g23t6zqS
         2DNzfgtVsi+mzaveAjK6VrFnTvp7yOuHmDeOH8eKhATPEVc5gCM+USZcDqNm/NWv4b+r
         RAxW9A13Y75HOD0HP7ofQtcC3PaA7GW98TtIvw8ccFrvaa5Xpyse5pw+POwk2e8rWPSW
         zn7kYLvwIoHUEvlrMBczQkMS+c8cZEuk51l+CPmKJd/koqcstpPddOco5y9k9nNZqcbM
         /mXGlNcYuLCfjTA8U6O5sFGPI1k8Ci4g+qpCFkqTXYbpAw3DJFSTcScinM6oAP/Dgh6g
         i9gQ==
X-Gm-Message-State: AJIora8U6PQF+rb4tl8zMXN4yjcPte6ejoGGG0fb5vKTC2KparCXu0yk
        VSSwyrNaXH/o2h6pNtEyI4HS6GiiCfL1IA==
X-Google-Smtp-Source: AGRyM1tt9bsEk8NgI/kpR3VLu38LafWZxQsfbYJmfVaV9kJuFMh9wfpKKuSUoIKnZ9fjpDuLI2I8ZQ==
X-Received: by 2002:a1c:7206:0:b0:39c:4d16:683f with SMTP id n6-20020a1c7206000000b0039c4d16683fmr25813689wmc.197.1655754993183;
        Mon, 20 Jun 2022 12:56:33 -0700 (PDT)
Received: from jernej-laptop.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id t9-20020adfe109000000b0021018642ff8sm14293461wrz.76.2022.06.20.12.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 12:56:32 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     mchehab@kernel.org, hverkuil@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, mripard@kernel.org,
        paul.kocialkowski@bootlin.com, wens@csie.org, samuel@sholland.org,
        nicolas.dufresne@collabora.com, andrzej.p@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: Re: [PATCH v9 00/17] Move HEVC stateless controls out of staging
Date:   Mon, 20 Jun 2022 21:56:30 +0200
Message-ID: <5830902.lOV4Wx5bFT@jernej-laptop>
In-Reply-To: <20220617083545.133920-1-benjamin.gaignard@collabora.com>
References: <20220617083545.133920-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 17. junij 2022 ob 10:35:28 CEST je Benjamin Gaignard napisal(a):
> This series aims to make HEVC uapi stable and usable for hardware
> decoder. HEVC uapi is used by 2 mainlined drivers (Cedrus and Hantro)
> and 2 out of the tree drivers (rkvdec and RPI).

Whole series is:
Tested-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> 
> version 9:
> - Reword some commit message
> - Use fls()
> - Remove useless padding at the end of hevc structures
> - Reword all _minus* field description
> - change CVS to codec video sequence
> - Fix various typo
> - Fix undefined label: v4l2-ctrl-flag-dynamic-array warning
> - fix the waring reported by 'scripts/kernel-doc -none
>   include/uapi/linux/v4l2-controls.h'
> 
> This version has been tested with these branches:
> - GStreamer:
> https://gitlab.freedesktop.org/benjamin.gaignard1/gstreamer/-/tree/HEVC_ali
> gned_with_kernel_5.15 - Linux:
> https://gitlab.collabora.com/benjamin.gaignard/for-upstream/-/tree/HEVC_UAP
> I_V9
> 
> With patches to decode 10-bits bitstream and produce P010 frames the Fluster
> score which was 77/147 before, is now 141/147.
> The 10-bits series will comes after this because of it dependency to
> uAPI change. If you are curious you can find the WIP branch here:
> https://gitlab.collabora.com/benjamin.gaignard/for-upstream/-/commits/WIP_HE
> VC_UAPI_V9
> 
> The 6 failing tests are:
> - PICSIZE_{A,B,C,D}_Bossen_1 where resolutions are to big for Hantro
> hardware. - WPP_D_ericsson_MAIN_2 and WPP_D_ericsson_MAIN10_2 are visually
> ok but some difference exist on 5 decoded frames. Some pixels values are no
> the same the very end of few lines.
> 
> version 8:
> - Same than v7 but rebased on media_stage/master
> 
> version 7:
> - Apply Jernej patches for Cedrus about bit offset definition and
>   V4L2_CID_STATELESS_HEVC_SLICE_PARAMS being a dynamic array control.
> - Based on media_tree/master
> 
> version 6:
> - Add short_term_ref_pic_set_size and long_term_ref_pic_set_size
>   in v4l2_ctrl_hevc_decode_params structure.
> - Change slice_pic_order_cnt type to s32 to match with PoC type.
> - Set V4L2_CTRL_FLAG_DYNAMIC_ARRAY flag automatically when using
>   V4L2_CID_STATELESS_HEVC_SLICE_PARAMS control.
> - Add a define for max slices count
> - Stop using Hantro dedicated control.
> 
> version 5:
> - Change __u16 pic_order_cnt[2] into __s32 pic_order_cnt_val in
>   hevc_dpb_entry structure
> - Add defines for SEI pic_struct values (patch 4)
> - Fix numbers of bits computation in cedrus_h265_skip_bits() parameters
> - Fix num_short_term_ref_pic_sets and num_long_term_ref_pics_sps
>   documentation (patch 8)
> - Rebased on v5-18-rc1
> 
> Version 4:
> - Add num_entry_point_offsets field in  struct v4l2_ctrl_hevc_slice_params
> - Fix V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS name
> - Initialize control V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS
> - Fix space/tab issue in kernel-doc
> - Add patch to change data_bit_offset definition
> - Fix hantro-media SPDX license
> - put controls under stateless section in v4l2-ctrls-defs.c
> 
> Benjamin Gaignard (14):
>   media: uapi: HEVC: Add missing fields in HEVC controls
>   media: uapi: HEVC: Rename HEVC stateless controls with STATELESS
>     prefix
>   media: uapi: HEVC: Change pic_order_cnt definition in
>     v4l2_hevc_dpb_entry
>   media: uapi: HEVC: Add SEI pic struct flags
>   media: uapi: HEVC: Add documentation to uAPI structure
>   media: uapi: HEVC: Define V4L2_CID_STATELESS_HEVC_SLICE_PARAMS as a
>     dynamic array
>   media: uapi: Move parsed HEVC pixel format out of staging
>   media: uapi: Add V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS control
>   media: uapi: Move the HEVC stateless control type out of staging
>   media: controls: Log HEVC stateless control in .std_log
>   media: hantro: Stop using Hantro dedicated control
>   media: uapi: HEVC: fix padding in v4l2 control structures
>   media: uapi: Change data_bit_offset definition
>   media: uapi: move HEVC stateless controls out of staging
> 
> Hans Verkuil (3):
>   videodev2.h: add V4L2_CTRL_FLAG_DYNAMIC_ARRAY
>   v4l2-ctrls: add support for dynamically allocated arrays.
>   vivid: add dynamic array test control
> 
>  .../media/v4l/ext-ctrls-codec-stateless.rst   | 897 ++++++++++++++++++
>  .../media/v4l/ext-ctrls-codec.rst             | 780 ---------------
>  .../media/v4l/pixfmt-compressed.rst           |   7 +-
>  .../media/v4l/vidioc-g-ext-ctrls.rst          |  20 +
>  .../media/v4l/vidioc-queryctrl.rst            |   8 +
>  .../media/videodev2.h.rst.exceptions          |   6 +
>  .../media/test-drivers/vivid/vivid-ctrls.c    |  15 +
>  drivers/media/v4l2-core/v4l2-ctrls-api.c      | 103 +-
>  drivers/media/v4l2-core/v4l2-ctrls-core.c     | 212 ++++-
>  drivers/media/v4l2-core/v4l2-ctrls-defs.c     |  38 +-
>  drivers/media/v4l2-core/v4l2-ctrls-priv.h     |   3 +-
>  drivers/media/v4l2-core/v4l2-ctrls-request.c  |  13 +-
>  drivers/staging/media/hantro/hantro_drv.c     |  62 +-
>  .../staging/media/hantro/hantro_g2_hevc_dec.c |  44 +-
>  drivers/staging/media/hantro/hantro_hevc.c    |  10 +-
>  drivers/staging/media/hantro/hantro_hw.h      |   4 +-
>  drivers/staging/media/sunxi/cedrus/cedrus.c   |  26 +-
>  .../staging/media/sunxi/cedrus/cedrus_dec.c   |  10 +-
>  .../staging/media/sunxi/cedrus/cedrus_h265.c  |  23 +-
>  .../staging/media/sunxi/cedrus/cedrus_video.c |   1 -
>  include/media/hevc-ctrls.h                    | 250 -----
>  include/media/v4l2-ctrls.h                    |  48 +-
>  include/uapi/linux/v4l2-controls.h            | 459 +++++++++
>  include/uapi/linux/videodev2.h                |  13 +
>  24 files changed, 1826 insertions(+), 1226 deletions(-)
>  delete mode 100644 include/media/hevc-ctrls.h




