Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B21F462686
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbhK2Wxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236063AbhK2Wwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:52:34 -0500
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E072C04CBCE
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 10:57:31 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:b10e:a86f:2421:ba14])
        by andre.telenet-ops.be with bizsmtp
        id QJxH2600B2Ybsp301JxHns; Mon, 29 Nov 2021 19:57:17 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mrlq1-001JNP-0G; Mon, 29 Nov 2021 19:57:17 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mrlq0-00CEJ9-JQ; Mon, 29 Nov 2021 19:57:16 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] MIPS: TXx9: Let MACH_TX49XX select BOOT_ELF32
Date:   Mon, 29 Nov 2021 19:57:14 +0100
Message-Id: <de47b857667a73d205b20d419f4aebaa2a885484.1638210176.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some bootloaders (e.g. VxWorks 5.5 System Boot) on TX49 systems do not
support loading 64-bit kernel images.  Work around this by selecting
BOOT_ELF32, to support running both 32-bit ("vmlinux" with
CONFIG_32BIT=y) and 64-bit ("vmlinux.32" with CONFIG_64BIT=y) Linux
kernels on TX49 devices with such a boot loader.

Suggested-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Tested on RBTX4927, running a Debian jessie 32-bit mipsel nfsroot userland, and
some 32-bit and 64-bit test binaries.
---
 arch/mips/txx9/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/txx9/Kconfig b/arch/mips/txx9/Kconfig
index 85c4c121c71f72d9..00f6fc446abeefe8 100644
--- a/arch/mips/txx9/Kconfig
+++ b/arch/mips/txx9/Kconfig
@@ -6,6 +6,7 @@ config MACH_TX39XX
 
 config MACH_TX49XX
 	bool
+	select BOOT_ELF32
 	select MACH_TXX9
 	select CEVT_R4K
 	select CSRC_R4K
-- 
2.25.1

