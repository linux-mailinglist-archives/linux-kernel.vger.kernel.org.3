Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D26F573B35
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 18:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237201AbiGMQ1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 12:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234823AbiGMQ1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:27:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED56760FE;
        Wed, 13 Jul 2022 09:27:42 -0700 (PDT)
Received: from localhost (dynamic-002-247-252-243.2.247.pool.telefonica.de [2.247.252.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 08483660191C;
        Wed, 13 Jul 2022 17:27:40 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657729661;
        bh=37KWRs9cBY/HR4LEwsXVzWii+JWAth3eoPuyhoJOaAQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Wyh2UZg4lhqUx3UoyLc2KjpetyP/7icutHVUnugTURdgUO+U2VKwwMaU1iAre/v0A
         GGxuNFR+IXFU5V9i7TQ9LpiD/dxlXInZve+dvqjEB4ZA8kju27ZWgFg2Tdq6s/xyYW
         CpzUNSfnxZk8xCCnoO+0fzVFjbcmTf84reA2+W48ZyFsq006NeW+j2anPD0yGey1TE
         I40ydzgLjOC4DohnjFUh35BCj7CXuaItSp6AQzmjMiVOeHj90zr4BMK+0vku8Ymzqf
         uZ+Ju8E+WHU172GH+8LmZRXIBlLPgDK4VvT9fqL/stB9InkfOLZ/Y2dGpSzvs8PV9C
         66os70VcIKhPg==
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     jernej.skrabec@gmail.com, knaerzche@gmail.com,
        kernel@collabora.com, bob.beckett@collabora.com,
        ezequiel@vanguardiasur.com.ar, mchehab@kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        nicolas.dufresne@collabora.com,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 0/6] RkVDEC HEVC driver
Date:   Wed, 13 Jul 2022 18:24:43 +0200
Message-Id: <20220713162449.133738-1-sebastian.fricke@collabora.com>
X-Mailer: git-send-email 2.25.1
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

Implement the HEVC codec variation for the RkVDEC driver. Currently only
the RK3399 is supported, but it is possible to enable the RK3288 as it
also supports this codec.

Based on top of the media tree @ef7fcbbb9eabbe86d2287484bf366dd1821cc6b8
and the HEVC uABI MR by Benjamin Gaignard.
(https://patchwork.linuxtv.org/project/linux-media/list/?series=8360)

Tested with the GStreamer V4L2 HEVC plugin:
(https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/1079)

Current Fluster score:
`Ran 131/147 tests successfully               in 278.568 secs`
with
`python3 fluster.py run -d GStreamer-H.265-V4L2SL-Gst1.0 -ts JCT-VC-HEVC_V1 -j1`

failed conformance tests:
- DBLK_D_VIXS_2 (Success on Hantro G2)
- DSLICE_A_HHI_5 (Success on Hantro G2)
- EXT_A_ericsson_4 (Success on Hantro G2)
- PICSIZE_A_Bossen_1 (Hardware limitation)
- PICSIZE_B_Bossen_1 (Hardware limitation)
- PICSIZE_C_Bossen_1 (Hardware limitation)
- PICSIZE_D_Bossen_1 (Hardware limitation)
- PPS_A_qualcomm_7 (Success on Hantro G2)
- SAODBLK_A_MainConcept_4 (Success on Hantro G2)
- SAODBLK_B_MainConcept_4 (Success on Hantro G2)
- SLIST_B_Sony_9 (Success on Hantro G2)
- SLIST_D_Sony_9 (Success on Hantro G2)
- TSUNEQBD_A_MAIN10_Technicolor_2 (Success on Hantro G2)
- VPSSPSPPS_A_MainConcept_1 (Success on Hantro G2)
- WPP_D_ericsson_MAIN10_2 (Fail on Hantro G2)
- WPP_D_ericsson_MAIN_2 (Fail on Hantro G2)

Not tested with FFMpeg so far.

Known issues:
- Unable to reliably decode multiple videos concurrently
- The SAODBLK_* tests timeout if the timeout time in fluster is lower than 120
- Currently the uv_virstride is calculated in a manner that is hardcoded
for the two available formats NV12 and NV15. (@config_registers)

Notable design decisions:
- I opted for a bitfield to represent the PPS memory blob as it is the
perfect tool for that job. It describes the memory layout with any
additional required documentation, is easy to read and a native language
tool for that job
- The RPS memory blob is created using a bitmap implementation, which
uses a common Kernel API to avoid reinventing the wheel and to keep the
code clean.
- I deliberatly opted against the macro solution used in H264, which
declares Macros in mid function and declares the fields of the memory
blob as macros as well. And I would be glad to refactor the H264 code if
desired by the maintainer to use common Kernel APIs and native language
elements.
- The giant static array of cabac values is moved to a separate c file,
I did so because a separate .h file would be incorrect as it doesn't
expose anything of any value for any other file than the rkvdec-hevc.c
file. Other options were:
  - Calculating the values instead of storing the results (doesn't seem
  to be worth it)
  - Supply them via firmware (Adding firmware makes the whole software
  way more complicated and the usage of the driver less obvious)

Ignored Checkpatch warnings (as it fits to the current style of the file):
```
WARNING: line length of 162 exceeds 100 columns
#115: FILE: drivers/media/v4l2-core/v4l2-common.c:265:
+               { .format = V4L2_PIX_FMT_NV15,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 5, 5, 0, 0 }, .hdiv = 2, .vdiv = 2,

ERROR: trailing statements should be on next line
#128: FILE: drivers/media/v4l2-core/v4l2-ioctl.c:1305:
+       case V4L2_PIX_FMT_NV15:         descr = "10-bit Y/CbCr 4:2:0 (Packed)"; break;
```

v4l2-compliance test:
```
Total for rkvdec device /dev/video3: 46, Succeeded: 46, Failed: 0, Warnings: 0
```

kselftest module run for the bitmap changes:
```
$ sudo insmod /usr/lib/modules/5.19.0-rc3-finalseries/kernel/lib/test_bitmap.ko
[   71.751716] test_bitmap: parselist: 14: input is '0-2047:128/256' OK, Time: 1750
[   71.751787] test_bitmap: bitmap_print_to_pagebuf: input is '0-32767
[   71.751787] ', Time: 6708
[   71.760373] test_bitmap: set_value: 6/6 tests correct
```

Jonas Karlman (2):
  media: v4l2: Add NV15 pixel format
  media: v4l2-common: Add helpers to calculate bytesperline and
    sizeimage

Sebastian Fricke (4):
  bitops: bitmap helper to set variable length values
  staging: media: rkvdec: Add valid pixel format check
  staging: media: rkvdec: Enable S_CTRL IOCTL
  staging: media: rkvdec: Add HEVC backend

 .../media/v4l/pixfmt-yuv-planar.rst           |   53 +
 drivers/media/v4l2-core/v4l2-common.c         |   79 +-
 drivers/media/v4l2-core/v4l2-ioctl.c          |    1 +
 drivers/staging/media/rkvdec/Makefile         |    2 +-
 drivers/staging/media/rkvdec/TODO             |   22 +-
 .../staging/media/rkvdec/rkvdec-hevc-data.c   | 1844 +++++++++++++++++
 drivers/staging/media/rkvdec/rkvdec-hevc.c    |  859 ++++++++
 drivers/staging/media/rkvdec/rkvdec-regs.h    |    1 +
 drivers/staging/media/rkvdec/rkvdec.c         |  182 +-
 drivers/staging/media/rkvdec/rkvdec.h         |    3 +
 include/linux/bitmap.h                        |   39 +
 include/uapi/linux/videodev2.h                |    1 +
 lib/test_bitmap.c                             |   47 +
 13 files changed, 3066 insertions(+), 67 deletions(-)
 create mode 100644 drivers/staging/media/rkvdec/rkvdec-hevc-data.c
 create mode 100644 drivers/staging/media/rkvdec/rkvdec-hevc.c

-- 
2.25.1

