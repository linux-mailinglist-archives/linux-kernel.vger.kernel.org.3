Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39244F51E8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443092AbiDFC00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237119AbiDEVRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 17:17:19 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A3E64712
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 13:44:42 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 965961F4394D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649191481;
        bh=hnHqVe82u8qaVviIdGxdj26g+pxExrZeoQydAyXfrvg=;
        h=From:To:Cc:Subject:Date:From;
        b=NHkY1rmWoCuA4xS4VgmRf2KGG+j5Y9DuG3A7IHaC34BvUAsKuu+ogRcnJ1o3UE5aV
         KxRWhk31P2PpYh+vqatNl46kzckw7eIdXyi7jSoGjtbgFv29zMNYnnPC0pO3BcYXmH
         kXMBQrnCa+4nugM/VXwcWFBvlnbC+L//Y19MVKHYAybtR1nm7zDHYSDyGwCt06P0Ra
         Ic1yCXMEUriV2eyIsKyy3hEOGLt7ohEvijyYCZ3+13DZz9lX4oD3NBIRwe8mbHgT1b
         t94Y/SobMXTyozKzYejQmmlwLxP4uPJLIBPGLRXotAXVfR5xU5QHA2yC87jEslHZQw
         ITjjHUpoH+G9A==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/24] H.264 Field Decoding Support for Frame-based Decoders
Date:   Tue,  5 Apr 2022 16:44:01 -0400
Message-Id: <20220405204426.259074-1-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until now, only Cedrus (a slice base decoder) supported interlaced
decoding.  In order to support field decoding in our frame-based decoder,
the v4l2-h264 library needed adaptation to produce the appropriate
reference lists.

This patch extends the v4l2-h264 library to produce the larger references
list needed to represent fields separately. Hantro, MTK-VCODEC and RKVDEC
drivers have been adapted to accommodate the larger lists. Though, only
Hantro and RKVDEC actually have HW support for field decoding. So only
these two have been updated to make use of the larger lists. All this work
has been done using the H.264 specification, LibreELEC downstream kernel
patches, Rockchip MPP reference software and Hantro reference software.

For reviewers, the following is the map of all commit. Patches that could
be merge independently of this serie are marked as independent. Note that
the test results do depend on the generic fixes.

01    : Documentation fix (independent)
02-03 : Improving some generic traces (independent)
04    : Minor v4l2-h264 fix (independent)
05-11 : v4l2-h264 field decoding support
12-16 : rkvdec h.264 generic fixes (independent)
17-20 : rkvdec h.264 field decoding support
21-24 : hantro h.264 field decoding support

All this work have been tested using GStreamer mainline implementation
but also with FFMPEG LibreELEC fork using the testing tool fluster
running through the ITU-T H.264 (2016-02) AVCv2 set of bitstream. Before
this patch, the scores were:

Hantro:
  FFMPEG:   88/135
  GSteamer: 90/135
RKVDEC:
  FFMPEG:   73/135
  GSteamer: 77/135

And after these changes:

Hantro:
  FFMPEG:   118/135
  GSteamer: 129/135
RKVDEC:
  FFMPEG:   118/135
  GSteamer: 129/135

Note that a bug in FFMPEG / LibreELEC fork was noticed and fixed with the
following change:

diff --git a/libavcodec/v4l2_request_h264.c b/libavcodec/v4l2_request_h264.c
index 88da8f0a2d..394bae0550 100644
--- a/libavcodec/v4l2_request_h264.c
+++ b/libavcodec/v4l2_request_h264.c
@@ -66,7 +66,7 @@ static void fill_dpb_entry(struct v4l2_h264_dpb_entry *entry, const H264Picture
 {
     entry->reference_ts = ff_v4l2_request_get_capture_timestamp(pic->f);
     entry->pic_num = pic->pic_id;
-    entry->frame_num = pic->frame_num;
+    entry->frame_num = pic->long_ref ? pic->pic_id : pic->frame_num;
     entry->fields = pic->reference & V4L2_H264_FRAME_REF;
     entry->flags = V4L2_H264_DPB_ENTRY_FLAG_VALID;
     if (entry->fields)

Some useful links:

Detailed Hantro Results:     https://gitlab.freedesktop.org/-/snippets/5189
Detailed RKVDEC Results:     https://gitlab.freedesktop.org/-/snippets/5253
ITU-T H.264 (2016-02) AVCv2: https://www.itu.int/net/itu-t/sigdb/spevideo/VideoForm-s.aspx?val=102002641
Fluster:                     https://github.com/fluendo/fluster
GStreamer:                   https://gitlab.freedesktop.org/gstreamer/gstreamer/
FFMPEG Fork:                 https://github.com/jernejsk/FFmpeg/tree/v4l2-request-hwaccel-4.4
Rockchip MPP:                https://github.com/rockchip-linux/mpp

Changes in v3:
- Improved debug message on timestamp miss-match
- Moved H264 SPS validation into rkvdec-h264
- Added more comments around H264 SPS validation
- Also validate at streamon (rkvdec start())
- Applied more Review-by and Fixes tag
- Fixed Signed-off-by chain in Jonas patch

Changes in v2:
- Applied most of Sebastian's suggestion in comments and commit messages.
- Use a bool for dpb_valid and dpb_bottom in rkvdec
- Dropped one wrong typo fix (media: v4l2-mem2mem: Fix typo in trace message)
- Dropped Alex fix (media: rkvdec-h264: Don't hardcode SPS/PPS parameters
  + I will carry this one later, it seems cosmetic

Jonas Karlman (5):
  media: rkvdec: h264: Fix bit depth wrap in pps packet
  media: rkvdec: h264: Validate and use pic width and height in mbs
  media: rkvdec: h264: Fix reference frame_num wrap for second field
  media: rkvdec: Ensure decoded resolution fit coded resolution
  media: hantro: h264: Make dpb entry management more robust

Nicolas Dufresne (18):
  media: doc: Document dual use of H.264 pic_num/frame_num
  media: v4l2-mem2mem: Trace on implicit un-hold
  media: h264: Avoid wrapping long_term_frame_idx
  media: h264: Use v4l2_h264_reference for reflist
  media: h264: Increase reference lists size to 32
  media: h264: Store current picture fields
  media: h264: Store all fields into the unordered list
  media: v4l2: Trace calculated p/b0/b1 initial reflist
  media: h264: Sort p/b reflist using frame_num
  media: v4l2: Reorder field reflist
  media: rkvdec: Stop overclocking the decoder
  media: rkvdec: h264: Fix dpb_valid implementation
  media: rkvdec: Move H264 SPS validation in rkvdec-h264
  media: rkvdec-h264: Add field decoding support
  media: rkvdec: Enable capture buffer holding for H264
  media: hantro: Stop using H.264 parameter pic_num
  media: hantro: Add H.264 field decoding support
  media: hantro: Enable HOLD_CAPTURE_BUF for H.264

Sebastian Fricke (1):
  media: videobuf2-v4l2: Warn on holding buffers without support

 .../media/v4l/ext-ctrls-codec-stateless.rst   |  10 +-
 .../media/common/videobuf2/videobuf2-v4l2.c   |   7 +-
 .../mediatek/vcodec/vdec/vdec_h264_req_if.c   |  17 +-
 drivers/media/v4l2-core/v4l2-h264.c           | 261 ++++++++++++++----
 drivers/media/v4l2-core/v4l2-mem2mem.c        |   1 +
 .../staging/media/hantro/hantro_g1_h264_dec.c |  38 +--
 drivers/staging/media/hantro/hantro_h264.c    | 119 ++++++--
 drivers/staging/media/hantro/hantro_hw.h      |   7 +-
 drivers/staging/media/hantro/hantro_v4l2.c    |  25 ++
 .../media/hantro/rockchip_vpu2_hw_h264_dec.c  |  98 +++----
 drivers/staging/media/rkvdec/rkvdec-h264.c    | 154 ++++++++---
 drivers/staging/media/rkvdec/rkvdec.c         |  35 +--
 drivers/staging/media/rkvdec/rkvdec.h         |   2 +
 include/media/v4l2-h264.h                     |  31 ++-
 14 files changed, 580 insertions(+), 225 deletions(-)

-- 
2.34.1

