Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64FF756BEC7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239373AbiGHSV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 14:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239201AbiGHSVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 14:21:32 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20068048A
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 11:21:30 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by xavier.telenet-ops.be with bizsmtp
        id siMU270024C55Sk01iMU6C; Fri, 08 Jul 2022 20:21:30 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o9sbX-002fJc-Ez; Fri, 08 Jul 2022 20:21:27 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o9sbW-00BtNQ-Kk; Fri, 08 Jul 2022 20:21:26 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 0/3] drm: Endianness fixes
Date:   Fri,  8 Jul 2022 20:21:06 +0200
Message-Id: <cover.1657300532.git.geert@linux-m68k.org>
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

This patch series contains several endianness fixes for the DRM
subsystem.

This has been tested on ARAnyM using a work-in-progress Atari DRM
driver, which supports (a.o.) big-endian RGB565 (more info and related
patches can be found in [1]).

Thanks for your comments!

[1] "[PATCH v3 00/10] drm: Add support for low-color frame buffer formats"
    https://lore.kernel.org/r/cover.1657294931.git.geert@linux-m68k.org

Geert Uytterhoeven (3):
  drm/fourcc: Add missing big-endian XRGB1555 and RGB565 formats
  drm/format-helper: Fix endianness in drm_fb_*_to_*() conversion
    helpers
  drm/gud: Fix endianness in gud_xrgb8888_to_color() helper

 drivers/gpu/drm/drm_format_helper.c | 80 +++++++++++++++++------------
 drivers/gpu/drm/drm_fourcc.c        |  4 ++
 drivers/gpu/drm/gud/gud_pipe.c      | 14 ++---
 3 files changed, 58 insertions(+), 40 deletions(-)

-- 
2.25.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
