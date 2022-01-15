Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9315748F742
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 15:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbiAOOJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 09:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbiAOOJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 09:09:04 -0500
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C28CC06161C
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 06:09:03 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:76d0:2bff:fec8:549])
        by xavier.telenet-ops.be with bizsmtp
        id j28z260070kcUhD0128zzF; Sat, 15 Jan 2022 15:08:59 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1n8jjn-009ufl-58; Sat, 15 Jan 2022 15:08:59 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1n8jjm-00187G-Fv; Sat, 15 Jan 2022 15:08:58 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Jarrett Schultz <jaschultz@microsoft.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] platform/surface: Reinstate platform dependency
Date:   Sat, 15 Jan 2022 15:08:49 +0100
Message-Id: <20220115140849.269479-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Microsoft Surface platform-specific devices are only present on
Microsoft Surface platforms, which are currently limited to arm64 and
x86.  Hence add a dependency on ARM64 || X86, to prevent asking the user
about drivers for these devices when configuring a kernel for an
architecture that does not support Microsoft Surface platforms.

Fixes: 272479928172edf0 ("platform: surface: Propagate ACPI Dependency")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/platform/surface/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/surface/Kconfig b/drivers/platform/surface/Kconfig
index 5f0578e25f718f14..463f1ec5c14e9fa9 100644
--- a/drivers/platform/surface/Kconfig
+++ b/drivers/platform/surface/Kconfig
@@ -5,6 +5,7 @@
 
 menuconfig SURFACE_PLATFORMS
 	bool "Microsoft Surface Platform-Specific Device Drivers"
+	depends on ARM64 || X86 || COMPILE_TEST
 	default y
 	help
 	  Say Y here to get to see options for platform-specific device drivers
-- 
2.25.1

