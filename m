Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B0556C05F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239164AbiGHSVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 14:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238834AbiGHSVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 14:21:13 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D46564FF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 11:21:10 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by laurent.telenet-ops.be with bizsmtp
        id siM7270094C55Sk01iM7mo; Fri, 08 Jul 2022 20:21:08 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o9sbC-002fGb-Lh; Fri, 08 Jul 2022 20:21:06 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o9sbC-00BtJ3-7L; Fri, 08 Jul 2022 20:21:06 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v3 00/10] drm: Add support for low-color frame buffer formats
Date:   Fri,  8 Jul 2022 20:20:45 +0200
Message-Id: <cover.1657294931.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

A long outstanding issue with the DRM subsystem has been the lack of
support for low-color displays, as used typically on older desktop
systems, and on small embedded displays.

This patch series adds support for color-indexed frame buffer formats
with 2, 4, and 16 colors.  It has been tested on ARAnyM using a
work-in-progress Atari DRM driver supporting 2, 4, 16, 256, and 65536
colors, with text console operation, fbtest, and modetest.

Overview:
  - Patch 1 introduces a helper, to be used by later patches in the
    series,
  - Patch 2 introduces a flag to indicate color-indexed formats,
  - Patches 3 and 4 correct calculations of bits per pixel for sub-byte
    pixel formats,
  - Patches 5 and 6 introduce the new C[124] formats,
  - Patch 7 fixes an untested code path,
  - Patch 8 documents the use of "red" for light-on-dark displays,
  - Patches 9 and 10 add more fourcc codes for light-on-dark and
    dark-on-light frame buffer formats, which may be useful for e.g. the
    ssd130x and repaper drivers.

Changes compared to v2[1]:
  - Add Reviewed-by,
  - Document fill order,
  - Fix FB_VISUAL_TRUECOLOR,
  - Replace light-on-dark/dark-on-light by direct/inverse relationship
    between channel value and brightness.

Changes compared to v1[2]:
  - Reshuffle patches,
  - New patch "[PATCH v2 02/10] drm/fourcc: Add
    drm_format_info.is_color_indexed flag",
  - Improve pixel descriptions,
  - Require depth to match bpp in drm_mode_legacy_fb_format(),
  - Set .is_color_indexed flag.
  - Use drm_format_info_bpp() helper instead of deprecated .depth field
    or format-dependent calculations,
  - Use new .is_color_indexed field instead of checking against a list
    of formats,
  - Add Acked-by,
  - Replace FIXME by TODO comment,
  - New patch "[PATCH v2 08/10] [RFC] drm/fourcc: Document that
    single-channel "red" can be any color",
  - Add rationale for adding new formats,
  - Add D[248] for completeness.

Notes:
  - This is the first patch series in a series of 3:
      - To make high-color modes work on big-endian, you also need [3],
      - To make mode selection on the command line work for Atari video
	modes, you need [4].
  - There is also a related series of 3 patch series for modetest:
      - Using modetest with low-color formats (C[124]) requires [5],
      - Using modetest with high-color formats (RG16, XR24) requires
	[6],
      - Using modetest with video mode names containing dashes requires
	[7].
  - As this was used on emulated hardware only, and I do not have Atari
    hardware, I do not have performance figures to compare with fbdev.
    I hope to do proper measuring with an Amiga DRM driver, eventually.
  - While the Atari DRM driver is not fit for submission yet, you can
    find it at [8], if you are adventurous.

Thanks for your comments!

[1] "[PATCH v2 00/10] drm: Add support for low-color frame buffer
    formats"
    https://lore.kernel.org/r/cover.1646683502.git.geert@linux-m68k.org/
[2] "[PATCH 0/8] drm: Add support for low-color frame buffer formats"
    https://lore.kernel.org/r/20220215165226.2738568-1-geert@linux-m68k.org/
[3] "[PATCH 0/3] drm: Endianness fixes"
    https://lore.kernel.org/r/cover.1657300532.git.geert@linux-m68k.org
[4] "[PATCH 0/5] drm/modes: Command line mode selection fixes and
    improvements"
    https://lore.kernel.org/r/cover.1657301107.git.geert@linux-m68k.org
[5] "[PATCH libdrm v2 00/10] Add support for low-color frame buffer
    formats"
    https://lore.kernel.org/r/cover.1657302034.git.geert@linux-m68k.org
[6] "[PATCH libdrm v2 00/10] Big-endian fixes"
    https://lore.kernel.org/r/cover.1657302103.git.geert@linux-m68k.org
[7] "[PATCH libdrm] modetest: Add support for named modes containing
    dashes"
[8] https://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git/log/?h=atari-drm-wip

Geert Uytterhoeven (10):
  drm/fourcc: Add drm_format_info_bpp() helper
  drm/fourcc: Add drm_format_info.is_color_indexed flag
  drm/client: Use actual bpp when allocating frame buffers
  drm/framebuffer: Use actual bpp for DRM_IOCTL_MODE_GETFB
  drm/fourcc: Add DRM_FORMAT_C[124]
  drm/fb-helper: Add support for DRM_FORMAT_C[124]
  drm/gem-fb-helper: Use actual bpp for size calculations
  drm/fourcc: Clarify the meaning of single-channel "red"
  [RFC] drm/fourcc: Add DRM_FORMAT_R[124]
  [RFC] drm/fourcc: Add DRM_FORMAT_D[1248]

 drivers/gpu/drm/drm_client.c                 |   4 +-
 drivers/gpu/drm/drm_fb_helper.c              | 101 ++++++++++++++-----
 drivers/gpu/drm/drm_fourcc.c                 |  55 +++++++++-
 drivers/gpu/drm/drm_framebuffer.c            |   2 +-
 drivers/gpu/drm/drm_gem_framebuffer_helper.c |  12 +--
 include/drm/drm_fourcc.h                     |   4 +
 include/uapi/drm/drm_fourcc.h                |  32 +++++-
 7 files changed, 167 insertions(+), 43 deletions(-)

-- 
2.25.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
