Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159C95467F0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 16:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiFJOBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 10:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiFJOAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 10:00:46 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A19295677
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 07:00:43 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id p10so36650265wrg.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 07:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kynesim-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:references:in-reply-to
         :user-agent:mime-version:content-transfer-encoding;
        bh=IPP1I+64i7ooAr7hZW07Xbene7CuoEhu5599AQUWnoM=;
        b=e8ie6pMQ/46sfhP67QvDFIfzZpzdSzDktchsNMnWIouASmbj8uI/TMmTXA0UJPZ/vG
         0kFgBr9eUNuXN+rd2TzSHaXwnmNJRBjWeckW8V3tlHNGNFgojGM/B671mKAIpG5CbI3t
         cNRj86VgQbTN4v/AYsitc3UUu2wx9075kI9Et/mBdxbn/FyH/g3cl09vxGNkWw8pnWdD
         dOONWQ2zelN/AI7sVDTB8VqWFurQLbxYx+eDClGZQ6a5sHqETDy2ptFH7ecIEUOS7UDw
         TUiqH49TjgtTdRqjdYFAhl5tLwsuQHq+s5F7tsX6/8zTbrt8E0q/yrRtoHqxAAhFXFBY
         WJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:references
         :in-reply-to:user-agent:mime-version:content-transfer-encoding;
        bh=IPP1I+64i7ooAr7hZW07Xbene7CuoEhu5599AQUWnoM=;
        b=DnmN9qPyFFStfkbYwffoFKYVDJ9TDVLTb5NRw+39+7RgOBOMUqoTAFBKei/dKTE2Cn
         pxqWAYTgcBURrLvh56tzqQz2YwaOqBWwM7zBMv+PavzTZ153+sXAWDOsyNGjkWfoJDn9
         aDWhNnGUfW6K9PVhOG2Yx2vs71ftvn545d+jaa8z/TWcahbmW9a0lZQEHvJWFi7vxzDH
         bOo71FnCEzZG+kMmOYanpwxb0F4BsruH/yVPe2J1fL0ve9/2JQF20B/d8iGdrhS/HQgl
         NjEQ51l4UYGssrr/kKkWuWXvQ4bGwmc3tV8VxVlWFCLbFno5bww+NqqZ+8rLfYKigtFz
         cU9A==
X-Gm-Message-State: AOAM532ldYt6LVTDr1tmX7PCf29wEBIvX70hu9HFbykfchYGZ73Wophe
        XKdCZZCp4MQZAxjeVhZi7+R83w==
X-Google-Smtp-Source: ABdhPJzRMmtiD0YNu5+s1dJ29kJv8Y40v5i8AmwTOT5ChEMrM4QXS+ua4liOSfQbboxVpfgXvlW1Ag==
X-Received: by 2002:a05:6000:2a8:b0:213:ba0c:fef8 with SMTP id l8-20020a05600002a800b00213ba0cfef8mr39875210wry.485.1654869641656;
        Fri, 10 Jun 2022 07:00:41 -0700 (PDT)
Received: from CTHALPA.outer.uphall.net (cpc1-cmbg20-2-0-cust759.5-4.cable.virginm.net. [86.21.218.248])
        by smtp.gmail.com with ESMTPSA id p190-20020a1c29c7000000b00397402ae674sm3162596wmp.11.2022.06.10.07.00.40
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 10 Jun 2022 07:00:40 -0700 (PDT)
From:   John Cox <jc@kynesim.co.uk>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     mchehab@kernel.org, hverkuil@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, mripard@kernel.org,
        paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        nicolas.dufresne@collabora.com, andrzej.p@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: Re: [PATCH v6 00/17] Move HEVC stateless controls out of staging
Date:   Fri, 10 Jun 2022 15:00:39 +0100
Message-ID: <4fj6ah11kq78o4rns1l0j96rcdsl81u8ba@4ax.com>
References: <20220527143134.3360174-1-benjamin.gaignard@collabora.com>
In-Reply-To: <20220527143134.3360174-1-benjamin.gaignard@collabora.com>
User-Agent: ForteAgent/8.00.32.1272
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>This series aims to make HEVC uapi stable and usable for hardware
>decoder. HEVC uapi is used by 2 mainlined drivers (Cedrus and Hantro)
>and 2 out of the tree drivers (rkvdec and RPI).
>
>version 6:
>- Add short_term_ref_pic_set_size and long_term_ref_pic_set_size
>  in v4l2_ctrl_hevc_decode_params structure.
>- Change slice_pic_order_cnt type to s32 to match with PoC type.
>- Set V4L2_CTRL_FLAG_DYNAMIC_ARRAY flag automatically when using
>  V4L2_CID_STATELESS_HEVC_SLICE_PARAMS control.
>- Add a define for max slices count
>- Stop using Hantro dedicated control.
>
>This version has been tested with these branches:
>- GStreamer: =
https://gitlab.freedesktop.org/benjamin.gaignard1/gstreamer/-/tree/HEVC_a=
ligned_with_kernel_5.15
>- Linux: =
https://gitlab.collabora.com/benjamin.gaignard/for-upstream/-/tree/HEVC_U=
API_V6
>
>With patches to decode 10-bits bitstream and produce P010 frames the =
Fluster score=20
>which was 77/147 before, is now 138/147.
>The 10-bits series will comes after this because of it dependency to
>uAPI change. If you are curious you can find the WIP branch here:
>https://gitlab.collabora.com/benjamin.gaignard/for-upstream/-/commits/WI=
P_HEVC_UAPI_V6
>
>The 9 failing tests are:
>- CONFWIN_A_Sony_1 which contains conformance_window_flag that isn't =
supported=20
>  by the hardware (but visually ok aside a pixel shift).
>- PICSIZE_{A,B,C,D}_Bossen_1 where resolutions are to big for Hantro =
hardware.
>- TSKIP_A_MS_3 is ok when testing alone but fail (corrupted lines on the
>  first frame) when running it after a couple of other tests.
>- VPSSPSPPS_A_MainConcept_1 where there is an issue on gst parser side=20
>  because of VPS/SPS/PPS ordering
>- WPP_D_ericsson_MAIN_2 and WPP_D_ericsson_MAIN10_2 are visually ok but =
some=20
>  difference exist on 5 decoded frames. Some pixels values are no the =
same=20
>  the very end of few lines.
>
>version 6:
>- Stop using Hantro dedicated control and compute the number
>  of bytes to skip inside the driver.
>- Rebased on media_tree/master
>
>version 5:
>- Change __u16 pic_order_cnt[2] into __s32 pic_order_cnt_val in
>  hevc_dpb_entry structure
>- Add defines for SEI pic_struct values (patch 4)
>- Fix numbers of bits computation in cedrus_h265_skip_bits() parameters
>- Fix num_short_term_ref_pic_sets and num_long_term_ref_pics_sps
>  documentation (patch 8)
>- Rebased on v5-18-rc1
>
>GStreamer H265 decoder plugin aligned with HEVC uAPI v5:
>https://gitlab.freedesktop.org/benjamin.gaignard1/gstreamer/-/tree/HEVC_=
aligned_with_kernel_5.15
>
>Version 4:
>- Add num_entry_point_offsets field in  struct =
v4l2_ctrl_hevc_slice_params
>- Fix V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS name
>- Initialize control V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS
>- Fix space/tab issue in kernel-doc
>- Add patch to change data_bit_offset definition
>- Fix hantro-media SPDX license
>- put controls under stateless section in v4l2-ctrls-defs.c
>
>At the end fluster tests results on IMX8MQ is 77/147 for HEVC codec.
>
>Benjamin Gaignard (14):
>  media: uapi: HEVC: Add missing fields in HEVC controls
>  media: uapi: HEVC: Rename HEVC stateless controls with STATELESS
>    prefix
>  media: uapi: HEVC: Change pic_order_cnt definition in
>    v4l2_hevc_dpb_entry
>  media: uapi: HEVC: Add SEI pic struct flags
>  media: uapi: HEVC: Add documentation to uAPI structure
>  media: uapi: HEVC: Define V4L2_CID_STATELESS_HEVC_SLICE_PARAMS as a
>    dynamic array
>  media: uapi: Move parsed HEVC pixel format out of staging
>  media: uapi: Add V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS control
>  media: uapi: Move the HEVC stateless control type out of staging
>  media: controls: Log HEVC stateless control in .std_log
>  media: hantro: Stop using Hantro dedicated control
>  media: uapi: HEVC: fix padding in v4l2 control structures
>  media: uapi: Change data_bit_offset definition
>  media: uapi: move HEVC stateless controls out of staging
>
>Hans Verkuil (3):
>  videodev2.h: add V4L2_CTRL_FLAG_DYNAMIC_ARRAY
>  v4l2-ctrls: add support for dynamically allocated arrays.
>  vivid: add dynamic array test control
>
> .../media/v4l/ext-ctrls-codec-stateless.rst   | 897 ++++++++++++++++++
> .../media/v4l/ext-ctrls-codec.rst             | 780 ---------------
> .../media/v4l/pixfmt-compressed.rst           |   7 +-
> .../media/v4l/vidioc-g-ext-ctrls.rst          |  20 +
> .../media/v4l/vidioc-queryctrl.rst            |   8 +
> .../media/videodev2.h.rst.exceptions          |   5 +
> .../media/test-drivers/vivid/vivid-ctrls.c    |  15 +
> drivers/media/v4l2-core/v4l2-ctrls-api.c      | 103 +-
> drivers/media/v4l2-core/v4l2-ctrls-core.c     | 206 +++-
> drivers/media/v4l2-core/v4l2-ctrls-defs.c     |  38 +-
> drivers/media/v4l2-core/v4l2-ctrls-priv.h     |   3 +-
> drivers/media/v4l2-core/v4l2-ctrls-request.c  |  13 +-
> drivers/staging/media/hantro/hantro_drv.c     |  62 +-
> .../staging/media/hantro/hantro_g2_hevc_dec.c |  69 +-
> drivers/staging/media/hantro/hantro_hevc.c    |  10 +-
> drivers/staging/media/hantro/hantro_hw.h      |   4 +-
> drivers/staging/media/sunxi/cedrus/cedrus.c   |  24 +-
> .../staging/media/sunxi/cedrus/cedrus_dec.c   |  10 +-
> .../staging/media/sunxi/cedrus/cedrus_h265.c  |   6 +-
> include/media/hevc-ctrls.h                    | 250 -----
> include/media/v4l2-ctrls.h                    |  48 +-
> include/uapi/linux/v4l2-controls.h            | 458 +++++++++
> include/uapi/linux/videodev2.h                |  13 +
> 23 files changed, 1830 insertions(+), 1219 deletions(-)
> delete mode 100644 include/media/hevc-ctrls.h

=46or general info, I've ported this patchset to my Raspberry Pi
implementation without issue - so at least in terms of "is this API
adequate for Pi?" the answer is yes.

Many thanks

JC
