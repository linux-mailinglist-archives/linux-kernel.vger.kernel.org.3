Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1C24D99F9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 12:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347835AbiCOLIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 07:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347718AbiCOLIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 07:08:35 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CF94C787
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 04:07:21 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:1dc0:e57f:6975:ecb9])
        by michel.telenet-ops.be with bizsmtp
        id 6b7H2700C3jtd4z06b7H5P; Tue, 15 Mar 2022 12:07:19 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nU51I-004XNr-Pu; Tue, 15 Mar 2022 12:07:16 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nU51I-002dQx-8l; Tue, 15 Mar 2022 12:07:16 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 0/5] drm: Fix monochrome conversion for sdd130x
Date:   Tue, 15 Mar 2022 12:07:02 +0100
Message-Id: <20220315110707.628166-1-geert@linux-m68k.org>
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

This patch series contains fixes and improvements for the XRGB888 to
monochrome conversion in the DRM core, and for its users.

This has been tested on an Adafruit FeatherWing 128x32 OLED, connected
to an OrangeCrab ECP5 FPGA board running a 64 MHz VexRiscv RISC-V
softcore, using a text console with 7x14 and 8x8 fonts.

Thanks for your comments!

Geert Uytterhoeven (5):
  drm/format-helper: Rename drm_fb_xrgb8888_to_mono_reversed()
  drm/format-helper: Fix XRGB888 to monochrome conversion
  drm: ssd130x: Fix rectangle updates
  drm: ssd130x: Reduce temporary buffer sizes
  drm/repaper: Reduce temporary buffer size in repaper_fb_dirty()

 drivers/gpu/drm/drm_format_helper.c | 74 +++++++++++------------------
 drivers/gpu/drm/solomon/ssd130x.c   | 24 +++++++---
 drivers/gpu/drm/tiny/repaper.c      |  4 +-
 include/drm/drm_format_helper.h     |  5 +-
 4 files changed, 48 insertions(+), 59 deletions(-)

-- 
2.25.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
