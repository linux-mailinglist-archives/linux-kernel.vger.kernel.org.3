Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659E44ABEEB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 14:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347699AbiBGNND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 08:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448276AbiBGNKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 08:10:14 -0500
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F86C043188
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 05:10:13 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:8923:c5e0:fe66:f22f])
        by laurent.telenet-ops.be with bizsmtp
        id sDAB2600F2zxJMx01DABvF; Mon, 07 Feb 2022 14:10:11 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nH3mU-0004SC-OS; Mon, 07 Feb 2022 14:10:10 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nH3mU-009F6e-7W; Mon, 07 Feb 2022 14:10:10 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: defconfig: Update defconfigs for v5.17-rc3
Date:   Mon,  7 Feb 2022 14:10:08 +0100
Message-Id: <20220207131008.2202977-1-geert@linux-m68k.org>
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

  - Enable the new option for legacy fbcon hardware acceleration code on
    all platforms that have a frame buffer device that can make use of
    this.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
The following drivers set
FBINFO_HWACCEL_(COPYAREA|FILLRECT|IMAGEBLIT|ROTATE|XPAN|YPAN|YWRAP):
  - FB_AMIGA,
  - FB_ATY (not enabled in atari_defconfig, hence ignored),
  - FB_CIRRUS,
  - FB_68328 (nommu, hence ignored).

The following drivers implement hardware acceleration, but do not set
any of the FBINFO_HWACCEL_* flags:
  - FB_APOLLO,
  - FB_HP300.
Probably they should be updated to set the appropriate flags?
---
 arch/m68k/configs/amiga_defconfig  | 1 +
 arch/m68k/configs/apollo_defconfig | 1 +
 arch/m68k/configs/hp300_defconfig  | 1 +
 arch/m68k/configs/multi_defconfig  | 1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index eb930b9633602aff..49f301c57df5fb06 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -432,6 +432,7 @@ CONFIG_FB_AMIGA_ECS=y
 CONFIG_FB_AMIGA_AGA=y
 CONFIG_FB_FM2=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION=y
 CONFIG_LOGO=y
 CONFIG_SOUND=m
 CONFIG_DMASOUND_PAULA=m
diff --git a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apollo_defconfig
index 5acd495c83ceb756..405997b614472b80 100644
--- a/arch/m68k/configs/apollo_defconfig
+++ b/arch/m68k/configs/apollo_defconfig
@@ -390,6 +390,7 @@ CONFIG_PTP_1588_CLOCK=m
 # CONFIG_HWMON is not set
 CONFIG_FB=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION=y
 CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_VGA16 is not set
 # CONFIG_LOGO_LINUX_CLUT224 is not set
diff --git a/arch/m68k/configs/hp300_defconfig b/arch/m68k/configs/hp300_defconfig
index 89dd800e7ad24354..048d9b114eb43489 100644
--- a/arch/m68k/configs/hp300_defconfig
+++ b/arch/m68k/configs/hp300_defconfig
@@ -392,6 +392,7 @@ CONFIG_PTP_1588_CLOCK=m
 # CONFIG_HWMON is not set
 CONFIG_FB=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION=y
 CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_MONO is not set
 # CONFIG_LOGO_LINUX_VGA16 is not set
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index 00757de800b62c90..7df61e743591a028 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -494,6 +494,7 @@ CONFIG_FB_ATARI=y
 CONFIG_FB_VALKYRIE=y
 CONFIG_FB_MAC=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION=y
 CONFIG_LOGO=y
 CONFIG_SOUND=m
 CONFIG_DMASOUND_ATARI=m
-- 
2.25.1

