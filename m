Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA014EE23C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 22:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241118AbiCaUEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 16:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234861AbiCaUEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 16:04:00 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EA72325F8;
        Thu, 31 Mar 2022 13:02:11 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 2B2571F4724B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648756930;
        bh=f7M8fiQpp7G7dSyGbvK8ZUz4HWa9F/akMkcG6p9grY8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=bVZSwdnscpsw+wN3YRwuZOo84ywB7CcBcS6TJMmU/Tf8v2YT8bFSBwzTxdWib/Bhr
         eoBF8rTzT43SmDfnsMIApeb7z+KRnl+c9us7Yc3plsLAI4l4nkeKpdRi6bzbIfTFqA
         f3lRhTRWah01g/I7IcEJ1id8//jIGEYGgzJJQLjma3YRIGj212I5ZoZs1NUbTSRipq
         z71uIHRFI/B9g+azaoTo9EPM2b73WbE/bJWIk8+NXtuPe49jecWJQwbcM2NXtsgCeq
         l5wRB4v12PFIC2JBZV+z/Xd3V80WJIE2GF+D1sOCmLXpSFAlHhmRDCDlVXr54NE8Yk
         DWUF0vo3+lDzw==
Message-ID: <16d0c5c4178b9c91f843e57472e1f0212d7364e5.camel@collabora.com>
Subject: [PATCH v2 00/23] H.264 Field Decoding Support for Frame-based
 Decoders
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kernel@collabora.com,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 31 Mar 2022 16:02:01 -0400
In-Reply-To: <20220331193726.289559-2-nicolas.dufresne@collabora.com>
References: <20220331193726.289559-1-nicolas.dufresne@collabora.com>
         <20220331193726.289559-2-nicolas.dufresne@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0 (3.44.0-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(re-sending as the cover letter didn't make it for me)

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
12-15 : rkvdec h.264 generic fixes (independent)
16-19 : rkvdec h.264 field decoding support
20-23 : hantro h.264 field decoding support

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

diff --git a/libavcodec/v4l2_request_h264.c b/libavcodec/v4l2_request_h264.=
c
index 88da8f0a2d..394bae0550 100644
--- a/libavcodec/v4l2_request_h264.c
+++ b/libavcodec/v4l2_request_h264.c
@@ -66,7 +66,7 @@ static void fill_dpb_entry(struct v4l2_h264_dpb_entry *en=
try,
const H264Picture
 {
     entry->reference_ts =3D ff_v4l2_request_get_capture_timestamp(pic->f);
     entry->pic_num =3D pic->pic_id;
-    entry->frame_num =3D pic->frame_num;
+    entry->frame_num =3D pic->long_ref ? pic->pic_id : pic->frame_num;
     entry->fields =3D pic->reference & V4L2_H264_FRAME_REF;
     entry->flags =3D V4L2_H264_DPB_ENTRY_FLAG_VALID;
     if (entry->fields)

Some useful links:

Detailed Hantro Results:     https://gitlab.freedesktop.org/-/snippets/5189
Detailed RKVDEC Results:     https://gitlab.freedesktop.org/-/snippets/5253
ITU-T H.264 (2016-02) AVCv2:
https://www.itu.int/net/itu-t/sigdb/spevideo/VideoForm-s.aspx?val=3D1020026=
41
Fluster:                     https://github.com/fluendo/fluster
GStreamer:                   https://gitlab.freedesktop.org/gstreamer/gstre=
amer/
FFMPEG Fork:               =20
https://github.com/jernejsk/FFmpeg/tree/v4l2-request-hwaccel-4.4
Rockchip MPP:                https://github.com/rockchip-linux/mpp

Changes in v2:
- Applied most of Sebastian's suggestion in comments and commit messages.
- Use a bool for dpb_valid and dpb_bottom in rkvdec
- Dropped one wrong typo fix (media: v4l2-mem2mem: Fix typo in trace messag=
e)
- Dropped Alex fix (media: rkvdec-h264: Don't hardcode SPS/PPS parameters
  + I will carry this one later, it seems cosmetic

Jonas Karlman (5):
  media: rkvdec: h264: Fix bit depth wrap in pps packet
  media: rkvdec: h264: Validate and use pic width and height in mbs
  media: rkvdec: h264: Fix reference frame_num wrap for second field
  media: rkvdec: Ensure decoded resolution fit coded resolution
  media: hantro: h264: Make dpb entry management more robust

Nicolas Dufresne (17):
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
  media: rkvdec: Enable capture buffer holding for H264
  media: rkvdec-h264: Add field decoding support
  media: hantro: Enable HOLD_CAPTURE_BUF for H.264
  media: hantro: Stop using H.264 parameter pic_num
  media: hantro: Add H.264 field decoding support

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
 drivers/staging/media/rkvdec/rkvdec-h264.c    |  91 +++---
 drivers/staging/media/rkvdec/rkvdec.c         |  22 +-
 drivers/staging/media/rkvdec/rkvdec.h         |   1 +
 include/media/v4l2-h264.h                     |  31 ++-
 14 files changed, 520 insertions(+), 208 deletions(-)

--
2.34.1


