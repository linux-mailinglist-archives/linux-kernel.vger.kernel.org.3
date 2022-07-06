Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC605683D9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 11:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbiGFJiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 05:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbiGFJiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:38:14 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EC023179;
        Wed,  6 Jul 2022 02:38:12 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:3a70:988d:42ce:f5cc])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 837F2660196A;
        Wed,  6 Jul 2022 10:38:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657100291;
        bh=5VjEhvjiMI5wKr7jJ7oI0nCsCn+K28PKPUfZONHW650=;
        h=From:To:Cc:Subject:Date:From;
        b=hPGEdR7JWsA/spmt2L+Xswma8+ajeey9FJN/wzWL1RBsg6RO9MrfI1yxTu9GHyNZP
         F/ZF3K/aeN6QySMC6ya9+C61AuVjCO+JoZx9UgMbXGbKuxVF2astrD2FjgGCYJ2Ibw
         NLea3biRntaQ5vpnlmGl1m+dJoM5tyChMaXU8BWnYmjFcdZ+rLkZpZWE7QtO1bh3oH
         vmfJfxpIWCM+ll1iP68Rtc2ArlGPx4n0m7yWmE+za6O6j9ilJr5bALnVbx7nyGu8qu
         /cgzXLzs5F3qR6aBvCnmIZg5GC3ycy3dQn+XEjoN20doI5Y0Wz9SDSw+Eq47DnIN/q
         K+jnau3bAREQA==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     mchehab@kernel.org, hverkuil@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, mripard@kernel.org,
        paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        nicolas.dufresne@collabora.com, andrzej.p@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v11 00/17] Move HEVC stateless controls out of staging
Date:   Wed,  6 Jul 2022 11:37:46 +0200
Message-Id: <20220706093803.158810-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series aims to make HEVC uapi stable and usable for hardware
decoder. HEVC uapi is used by 2 mainlined drivers (Cedrus and Hantro)
and 2 out of the tree drivers (rkvdec and RPI).

version 11:
- Be more verbose about num_entry_point_offsets field usage.
- Fix various typos in "Add documentation to uAPI structure" patch.

version 10:
- Rebased on media_stage/master
- Add Acked-by tag from Nicolas
- Add Tested-by tag from Jernej
- Fix typo in patch 14

This version has been tested with these branches:
- GStreamer: https://gitlab.freedesktop.org/benjamin.gaignard1/gstreamer/-/tree/HEVC_aligned_with_kernel_5.15
- Linux: https://gitlab.collabora.com/benjamin.gaignard/for-upstream/-/tree/HEVC_UAPI_V10

With patches to decode 10-bits bitstream and produce P010 frames the Fluster score 
which was 77/147 before, is now 141/147.
The 10-bits series will comes after this because of it dependency to
uAPI change. If you are curious you can find the WIP branch here:
https://gitlab.collabora.com/benjamin.gaignard/for-upstream/-/commits/WIP_HEVC_UAPI_V10

The 6 failing tests are:
- PICSIZE_{A,B,C,D}_Bossen_1 where resolutions are to big for Hantro hardware.
- WPP_D_ericsson_MAIN_2 and WPP_D_ericsson_MAIN10_2 are visually ok but some 
  difference exist on 5 decoded frames. Some pixels values are no the same 
  the very end of few lines.

version 9:
- Reword some commit message
- Use fls()
- Remove useless padding at the end of hevc structures
- Reword all _minus* field description
- change CVS to codec video sequence
- Fix various typo
- Fix undefined label: v4l2-ctrl-flag-dynamic-array warning
- fix the waring reported by 'scripts/kernel-doc -none
  include/uapi/linux/v4l2-controls.h'

version 8:
- Same than v7 but rebased on media_stage/master

version 7:
- Apply Jernej patches for Cedrus about bit offset definition and
  V4L2_CID_STATELESS_HEVC_SLICE_PARAMS being a dynamic array control.
- Based on media_tree/master

version 6:
- Add short_term_ref_pic_set_size and long_term_ref_pic_set_size
  in v4l2_ctrl_hevc_decode_params structure.
- Change slice_pic_order_cnt type to s32 to match with PoC type.
- Set V4L2_CTRL_FLAG_DYNAMIC_ARRAY flag automatically when using
  V4L2_CID_STATELESS_HEVC_SLICE_PARAMS control.
- Add a define for max slices count
- Stop using Hantro dedicated control.

version 5:
- Change __u16 pic_order_cnt[2] into __s32 pic_order_cnt_val in
  hevc_dpb_entry structure
- Add defines for SEI pic_struct values (patch 4)
- Fix numbers of bits computation in cedrus_h265_skip_bits() parameters
- Fix num_short_term_ref_pic_sets and num_long_term_ref_pics_sps
  documentation (patch 8)
- Rebased on v5-18-rc1

Version 4:
- Add num_entry_point_offsets field in  struct v4l2_ctrl_hevc_slice_params
- Fix V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS name
- Initialize control V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS
- Fix space/tab issue in kernel-doc
- Add patch to change data_bit_offset definition
- Fix hantro-media SPDX license
- put controls under stateless section in v4l2-ctrls-defs.c 
 
Benjamin Gaignard (14):
  media: uapi: HEVC: Add missing fields in HEVC controls
  media: uapi: HEVC: Rename HEVC stateless controls with STATELESS
    prefix
  media: uapi: HEVC: Change pic_order_cnt definition in
    v4l2_hevc_dpb_entry
  media: uapi: HEVC: Add SEI pic struct flags
  media: uapi: HEVC: Add documentation to uAPI structure
  media: uapi: HEVC: Define V4L2_CID_STATELESS_HEVC_SLICE_PARAMS as a
    dynamic array
  media: uapi: Move parsed HEVC pixel format out of staging
  media: uapi: Add V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS control
  media: uapi: Move the HEVC stateless control type out of staging
  media: controls: Log HEVC stateless control in .std_log
  media: hantro: Stop using Hantro dedicated control
  media: uapi: HEVC: fix padding in v4l2 control structures
  media: uapi: Change data_bit_offset definition
  media: uapi: move HEVC stateless controls out of staging

Hans Verkuil (3):
  videodev2.h: add V4L2_CTRL_FLAG_DYNAMIC_ARRAY
  v4l2-ctrls: add support for dynamically allocated arrays.
  vivid: add dynamic array test control

 .../media/v4l/ext-ctrls-codec-stateless.rst   | 901 ++++++++++++++++++
 .../media/v4l/ext-ctrls-codec.rst             | 780 ---------------
 .../media/v4l/pixfmt-compressed.rst           |   7 +-
 .../media/v4l/vidioc-g-ext-ctrls.rst          |  20 +
 .../media/v4l/vidioc-queryctrl.rst            |   8 +
 .../media/videodev2.h.rst.exceptions          |   6 +
 .../media/test-drivers/vivid/vivid-ctrls.c    |  15 +
 drivers/media/v4l2-core/v4l2-ctrls-api.c      | 103 +-
 drivers/media/v4l2-core/v4l2-ctrls-core.c     | 212 ++++-
 drivers/media/v4l2-core/v4l2-ctrls-defs.c     |  38 +-
 drivers/media/v4l2-core/v4l2-ctrls-priv.h     |   3 +-
 drivers/media/v4l2-core/v4l2-ctrls-request.c  |  13 +-
 drivers/staging/media/hantro/hantro_drv.c     |  62 +-
 .../staging/media/hantro/hantro_g2_hevc_dec.c |  44 +-
 drivers/staging/media/hantro/hantro_hevc.c    |  10 +-
 drivers/staging/media/hantro/hantro_hw.h      |   4 +-
 drivers/staging/media/sunxi/cedrus/cedrus.c   |  26 +-
 .../staging/media/sunxi/cedrus/cedrus_dec.c   |  10 +-
 .../staging/media/sunxi/cedrus/cedrus_h265.c  |  23 +-
 .../staging/media/sunxi/cedrus/cedrus_video.c |   1 -
 include/media/hevc-ctrls.h                    | 250 -----
 include/media/v4l2-ctrls.h                    |  48 +-
 include/uapi/linux/v4l2-controls.h            | 459 +++++++++
 include/uapi/linux/videodev2.h                |  13 +
 24 files changed, 1830 insertions(+), 1226 deletions(-)
 delete mode 100644 include/media/hevc-ctrls.h

-- 
2.32.0

