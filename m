Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81A54EA0E3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343988AbiC1UBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239880AbiC1UBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:01:33 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CF0387B8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 12:59:50 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 84BA11F40A43
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648497589;
        bh=xco3lbW21cyWapa9jNZ90fWA8TJrSosaNbyiTjreIEw=;
        h=From:To:Cc:Subject:Date:From;
        b=E2SGCOlU6Vu2TQrbpD/JmCrK9QfnzGFxJpTx5LS65mKe2tTkuwNlhOp2gpHjQoEFQ
         wu4XgyDXk2lX9f6V9ySek8zxFVZHmDF+WI8nl+m2ea7TIYhvszUt9+1MrUb9rWP7T/
         ZT8rId2aW/3jwPJh/0R0O1guCCqFJZDGv3GRTMTd5YB0MJVj+EPSLy6xrgWBNgkv8G
         etvHpbmLmdH50zzZSz8ghBdYSZmRNI9NggeQJ2mrw3FciBEgmJ1USz3AlnFplQDEEY
         zSsAicMP8JIWRKZnXfqwC2+h1uijDHQLUo6MmL9anXk6bIb3tbOlfmSyxzjogMKaJv
         liS+tyce4NW+w==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org
Subject: [PATCH v1 00/24] H.264 Field Decoding Support for Frame-based Decoders
Date:   Mon, 28 Mar 2022 15:59:12 -0400
Message-Id: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
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

Until now, only Cedrus (a slice base decoder) supported interlaced decoding.
In order to support field decoding in our frame-based decoder, the v4l2-h264
library needed adaptation to produce the appropriate reference lists.

This patch extends the v4l2-h264 library to produce the larger references list
needed to represent fields separately. Hantro, MTK-VCODEC and RKVDEC drivers
have been adapted to accommodate the larger lists. Though, only Hantro and
RKVDEC actually have HW support for field decoding. So only these two
have been updated to make use of the larger lists. All this work has been
done using the H.264 specification, LibreELEC downstream kernel patches,
Rockchip MPP reference software and Hantro reference software.

All this work have been tested using GStreamer mainline implementation but also
with FFMPEG LibreELEC fork using the testing tool fluster running through the
ITU-T H.264 (2016-02) AVCv2 set of bitstream. Before this patch, the scores
were:

Hantro:
  FFMPEG:
  GSteamer:
RKVDEC:
  FFMPEG:
  GSteamer:

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

Alex Bee (1):
  media: rkvdec-h264: Don't hardcode SPS/PPS parameters

Jonas Karlman (5):
  media: rkvdec: h264: Fix reference frame_num wrap for second field
  media: rkvdec: Ensure decoded resolution fit coded resolution
  media: rkvdec: h264: Validate and use pic width and height in mbs
  media: rkvdec: h264: Fix bit depth wrap in pps packet
  media: hantro: h264: Make dpb entry management more robust

Nicolas Dufresne (17):
  media: h264: Increase reference lists size to 32
  media: doc: Document dual use of H.264 pic_num/frame_num
  media: h264: Avoid wrapping long_term_frame_idx
  media: h264: Store current picture fields
  media: h264: Store all fields into the unordered list
  media: v4l2: Trace calculated p/b0/b1 initial reflist
  media: h264: Sort p/b reflist using frame_num
  media: v4l2: Reorder field reflist
  media: v4l2-mem2mem: Fix typo in trace message
  media: v4l2-mem2mem: Trace on implicit un-hold
  media: rkvdec: Stop overclocking the decoder
  media: rkvdec: h264: Fix dpb_valid implementation
  media: rkvdec: Enable capture buffer holding for H264
  media: rkvdec-h264: Add field decoding support
  media: hantro: Enable HOLD_CAPTURE_BUF for H.264
  media: hantro: Stop using H.264 parameter pic_num
  media: hantro: Add H.264 field decoding support

Sebastian Fricke (1):
  media: videobuf2-v4l2: Warn on holding buffers without support

 .../media/v4l/ext-ctrls-codec-stateless.rst   |  10 +-
 .../media/common/videobuf2/videobuf2-v4l2.c   |   7 +-
 drivers/media/v4l2-core/v4l2-h264.c           | 238 +++++++++++++++---
 drivers/media/v4l2-core/v4l2-mem2mem.c        |   3 +-
 drivers/staging/media/hantro/hantro_h264.c    | 119 +++++++--
 drivers/staging/media/hantro/hantro_hw.h      |   7 +-
 drivers/staging/media/hantro/hantro_v4l2.c    |  25 ++
 drivers/staging/media/rkvdec/rkvdec-h264.c    | 104 ++++----
 drivers/staging/media/rkvdec/rkvdec.c         |  22 +-
 drivers/staging/media/rkvdec/rkvdec.h         |   1 +
 include/media/v4l2-h264.h                     |  20 +-
 11 files changed, 431 insertions(+), 125 deletions(-)

base-commit: 51d86122ff02ac2ceef5c0a1cf28f0b5ed580ddd
-- 
2.34.1

