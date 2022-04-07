Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC3A4F834A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344804AbiDGPb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241617AbiDGPby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:31:54 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAC6B43;
        Thu,  7 Apr 2022 08:29:50 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:4da4:8da5:b6b4:93c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 562451F467AD;
        Thu,  7 Apr 2022 16:29:48 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649345388;
        bh=WlP4lC2XeBVvE2CcANhd4shlUB98Hq/ZFeea2+kFn7Q=;
        h=From:To:Cc:Subject:Date:From;
        b=md/REH82ID6+R5TbFUHrn4yTCbmkjErVwMGkOdqJviR8mXVIIGlippVl7yAsZbBY8
         Ed3s3cDrA0ItLbS98XtaDSSpBIERQ1tShBRlAHk4LWq8ew1XJWloajikmM2zkGWRPX
         3Y8pg82z/2WVWgsKyEUEm23KY3Agyr11KASu8S3BEftqh3rcPdeNozN9u9LPtnUHmg
         MxBR8RaRKzOk4ERjJyj+IXicNpWTKKcIXejh81In7GxHkIFO+F2Btbujna7Ajv2WhV
         RVmzP5+CGk7aiurwCrtsGgVVBXYFh71LQPlZq6NJZgvvLv9dELNbYM8UmgdSJ5SMc0
         +RD4ItK8kBrRw==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     mchehab@kernel.org, hverkuil@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, mripard@kernel.org,
        paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        sebastian.fricke@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v5 00/17] Move HEVC stateless controls out of staging
Date:   Thu,  7 Apr 2022 17:29:23 +0200
Message-Id: <20220407152940.738159-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series aims to make HEVC uapi stable and usable for hardware
decoder. HEVC uapi is used by 2 mainlined drivers (Cedrus and Hantro)
and 2 out of the tree drivers (rkvdec and RPI).

version 5:
- Change __u16 pic_order_cnt[2] into __s32 pic_order_cnt_val in
  hevc_dpb_entry structure
- Add defines for SEI pic_struct values (patch 4)
- Fix numbers of bits computation in cedrus_h265_skip_bits() parameters
- Fix num_short_term_ref_pic_sets and num_long_term_ref_pics_sps
  documentation (patch 8)
- Rebased on v5-18-rc1

GStreamer H265 decoder plugin aligned with HEVC uAPI v5:
https://gitlab.freedesktop.org/benjamin.gaignard1/gstreamer/-/tree/HEVC_aligned_with_kernel_5.15

Version 4:
- Add num_entry_point_offsets field in  struct v4l2_ctrl_hevc_slice_params
- Fix V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS name
- Initialize control V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS
- Fix space/tab issue in kernel-doc
- Add patch to change data_bit_offset definition
- Fix hantro-media SPDX license
- put controls under stateless section in v4l2-ctrls-defs.c

At the end fluster tests results on IMX8MQ is 77/147 for HEVC codec.

Benjamin Gaignard (14):
  media: uapi: HEVC: Add missing fields in HEVC controls
  media: uapi: HEVC: Rename HEVC stateless controls with STATELESS
    prefix
  media: uapi: HEVC: Change pic_order_cnt definition in
    v4l2_hevc_dpb_entry
  media: uapi: HEVC: Add SEI pic struct flags
  media: uapi: HEVC: Add document uAPI structure
  media: uapi: HEVC: Define V4L2_CID_STATELESS_HEVC_SLICE_PARAMS as a
    dynamic array
  media: uapi: Move parsed HEVC pixel format out of staging
  media: uapi: Add V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS control
  media: uapi: Move the HEVC stateless control type out of staging
  media: controls: Log HEVC stateless control in .std_log
  media: uapi: Create a dedicated header for Hantro control
  media: uapi: HEVC: fix padding in v4l2 control structures
  media: uapi: Change data_bit_offset definition
  media: uapi: move HEVC stateless controls out of staging

Hans Verkuil (3):
  videodev2.h: add V4L2_CTRL_FLAG_DYNAMIC_ARRAY
  v4l2-ctrls: add support for dynamically allocated arrays.
  vivid: add dynamic array test control

 .../userspace-api/media/drivers/hantro.rst    |   5 -
 .../media/v4l/ext-ctrls-codec-stateless.rst   | 882 ++++++++++++++++++
 .../media/v4l/ext-ctrls-codec.rst             | 780 ----------------
 .../media/v4l/pixfmt-compressed.rst           |   7 +-
 .../media/v4l/vidioc-g-ext-ctrls.rst          |  20 +
 .../media/v4l/vidioc-queryctrl.rst            |   8 +
 .../media/videodev2.h.rst.exceptions          |   5 +
 .../media/test-drivers/vivid/vivid-ctrls.c    |  15 +
 drivers/media/v4l2-core/v4l2-ctrls-api.c      | 103 +-
 drivers/media/v4l2-core/v4l2-ctrls-core.c     | 198 +++-
 drivers/media/v4l2-core/v4l2-ctrls-defs.c     |  37 +-
 drivers/media/v4l2-core/v4l2-ctrls-priv.h     |   3 +-
 drivers/media/v4l2-core/v4l2-ctrls-request.c  |  13 +-
 drivers/staging/media/hantro/hantro_drv.c     |  27 +-
 .../staging/media/hantro/hantro_g2_hevc_dec.c |   4 +-
 drivers/staging/media/hantro/hantro_hevc.c    |  10 +-
 drivers/staging/media/hantro/hantro_hw.h      |   4 +-
 drivers/staging/media/sunxi/cedrus/cedrus.c   |  24 +-
 .../staging/media/sunxi/cedrus/cedrus_dec.c   |  10 +-
 .../staging/media/sunxi/cedrus/cedrus_h265.c  |   6 +-
 include/media/hevc-ctrls.h                    | 250 -----
 include/media/v4l2-ctrls.h                    |  48 +-
 include/uapi/linux/hantro-media.h             |  19 +
 include/uapi/linux/v4l2-controls.h            | 453 +++++++++
 include/uapi/linux/videodev2.h                |  13 +
 25 files changed, 1767 insertions(+), 1177 deletions(-)
 delete mode 100644 include/media/hevc-ctrls.h
 create mode 100644 include/uapi/linux/hantro-media.h

-- 
2.32.0

