Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570924B7780
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241987AbiBOQxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:53:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241902AbiBOQwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:52:47 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691A89ADB5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:52:33 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:7534:e0be:5adf:2691])
        by albert.telenet-ops.be with bizsmtp
        id vUsV2600718GbK106UsVLq; Tue, 15 Feb 2022 17:52:31 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nK140-000tUj-RY; Tue, 15 Feb 2022 17:52:28 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nK13z-00BURL-Tk; Tue, 15 Feb 2022 17:52:27 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 0/8] drm: Add support for low-color frame buffer formats
Date:   Tue, 15 Feb 2022 17:52:18 +0100
Message-Id: <20220215165226.2738568-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

A long outstanding issue with the DRM subsystem has been the lack of
support for low-color displays, as used typically on older desktop
systems and small embedded displays.

This patch series adds support for color-indexed frame buffer formats
with 2, 4, and 16 colors.  It has been tested on ARAnyM using a
work-in-progress Atari DRM driver, with text console operation and
fbtest.

Overview:
  - Patches 1 and 2 give a working system, albeit with a too large pitch
    (line length),
  - Patches 3 and 4 reduce memory consumption by correcting the pitch
    in case bpp < 8,
  - Patches 5 and 6 are untested, but may become useful with DRM
    userspace,
  - Patches 7 and 8 add more fourcc codes for grayscale and monochrome
    frame buffer formats, which may be useful for e.g. the ssd130x and
    repaper drivers.

Notes:
  - I haven't looked yet into making modetest draw a correct image.
  - As this was used on emulated hardware only, and I do not have Atari
    hardware, I do not have performance figures to compare with fbdev.
    I hope to do proper measuring with an Amiga DRM driver, eventually.

Thanks for your comments!

Geert Uytterhoeven (8):
  drm/fourcc: Add DRM_FORMAT_C[124]
  drm/fb-helper: Add support for DRM_FORMAT_C[124]
  drm/fourcc: Add drm_format_info_bpp() helper
  drm/client: Use actual bpp when allocating frame buffers
  drm/framebuffer: Use actual bpp for DRM_IOCTL_MODE_GETFB
  drm/gem-fb-helper: Use actual bpp for size calculations
  drm/fourcc: Add DRM_FORMAT_R[124]
  drm/fourcc: Add DRM_FORMAT_D1

 drivers/gpu/drm/drm_client.c                 |   4 +-
 drivers/gpu/drm/drm_fb_helper.c              | 120 ++++++++++++++-----
 drivers/gpu/drm/drm_fourcc.c                 |  45 +++++++
 drivers/gpu/drm/drm_framebuffer.c            |   2 +-
 drivers/gpu/drm/drm_gem_framebuffer_helper.c |  12 +-
 include/drm/drm_fourcc.h                     |   1 +
 include/uapi/drm/drm_fourcc.h                |  15 +++
 7 files changed, 160 insertions(+), 39 deletions(-)

-- 
2.25.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
