Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A674C6EE0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236958AbiB1OJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiB1OJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:09:26 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB28352B15;
        Mon, 28 Feb 2022 06:08:47 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:82d4:230a:70ff:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 6EEE31F43A52;
        Mon, 28 Feb 2022 14:08:45 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646057326;
        bh=WTuPMuME//gRX6TZ6aBYg+Ro0UbizW8dVX80/GWcuRs=;
        h=From:To:Cc:Subject:Date:From;
        b=eiptqc56qthYKXkKPy/Yw6DLYhnKhfT6aD6sovHQepxTrdeLyzHzZ7HWjuGGnEXRW
         sodMwMiMv0M5hTz+UcUJ/Tp7cYXnSIZ4vc5aV0V9PKXSDTPW6fNlSdNobF8zPd6k5C
         Mbh+/9uIpgjOZaYGCA9zGR79n06XEvqFjOa8beORic71KXz++guWbGsbve5NchFdSX
         +djOFdFP1afM0iCzxGXmdWDV3F6EHeWjHhwkZhDlwB1DNdqvGUDaXRGYU9GHwpHtN3
         5U434Tk/2PGNSSoNJMozF6BmPPvw0epoY0N+Jg5GNHs/oPCVFtUgnsmdeBg+Qfz8y4
         RZA8ZdO6eBtzA==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, jonas@kwiboo.se, nicolas@ndufresne.ca
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com, knaerzche@gmail.com, jc@kynesim.co.uk,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v4 00/15] Move HEVC stateless controls out of staging
Date:   Mon, 28 Feb 2022 15:08:23 +0100
Message-Id: <20220228140838.622021-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series aims to make HEVC uapi stable and usable for hardware
decoder. HEVC uapi is used by 2 mainlined drivers (Cedrus and Hantro)
and 2 out of the tree drivers (rkvdec and RPI).

After the remarks done on version 2, I have completely reworked to patches 
split so changelogs are meaningless. I have also drop "RFC" from the
titles.

Version 4:
- Add num_entry_point_offsets field in  struct v4l2_ctrl_hevc_slice_params
- Fix V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS name
- Initialize control V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS
- Fix space/tab issue in kernel-doc
- Add patch to change data_bit_offset definition
- Fix hantro-media SPDX license
- put controls under stateless section in v4l2-ctrls-defs.c

At the end fluster tests results on IMX8MQ is 77/147 for HEVC codec.

Benjamin


Benjamin Gaignard (12):
  media: uapi: HEVC: Add missing fields in HEVC controls
  media: uapi: HEVC: Rename HEVC stateless controls with STATELESS
    prefix
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
 .../media/v4l/ext-ctrls-codec-stateless.rst   | 833 ++++++++++++++++++
 .../media/v4l/ext-ctrls-codec.rst             | 780 ----------------
 .../media/v4l/pixfmt-compressed.rst           |   7 +-
 .../media/v4l/vidioc-g-ext-ctrls.rst          |  20 +
 .../media/v4l/vidioc-queryctrl.rst            |   8 +
 .../media/videodev2.h.rst.exceptions          |   5 +
 .../media/test-drivers/vivid/vivid-ctrls.c    |  15 +
 drivers/media/v4l2-core/v4l2-ctrls-api.c      | 103 ++-
 drivers/media/v4l2-core/v4l2-ctrls-core.c     | 198 ++++-
 drivers/media/v4l2-core/v4l2-ctrls-defs.c     |  37 +-
 drivers/media/v4l2-core/v4l2-ctrls-priv.h     |   3 +-
 drivers/media/v4l2-core/v4l2-ctrls-request.c  |  13 +-
 drivers/staging/media/hantro/hantro_drv.c     |  27 +-
 drivers/staging/media/hantro/hantro_hevc.c    |   8 +-
 drivers/staging/media/sunxi/cedrus/cedrus.c   |  24 +-
 .../staging/media/sunxi/cedrus/cedrus_dec.c   |  10 +-
 .../staging/media/sunxi/cedrus/cedrus_h265.c  |   2 +-
 include/media/hevc-ctrls.h                    | 250 ------
 include/media/v4l2-ctrls.h                    |  48 +-
 include/uapi/linux/hantro-media.h             |  19 +
 include/uapi/linux/v4l2-controls.h            | 439 +++++++++
 include/uapi/linux/videodev2.h                |  13 +
 23 files changed, 1697 insertions(+), 1170 deletions(-)
 delete mode 100644 include/media/hevc-ctrls.h
 create mode 100644 include/uapi/linux/hantro-media.h

-- 
2.32.0

