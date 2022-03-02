Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57414C9CB6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 05:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239545AbiCBEqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 23:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239576AbiCBEp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 23:45:58 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEB1B12CC
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 20:45:12 -0800 (PST)
Received: (Authenticated sender: ash@heyquark.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7DA90100005;
        Wed,  2 Mar 2022 04:45:03 +0000 (UTC)
From:   Ash Logan <ash@heyquark.com>
To:     paulus@samba.org, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        robh+dt@kernel.org, benh@kernel.crashing.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        j.ne@posteo.net, Roberto Van Eeden <rw-r-r-0644@protonmail.com>,
        Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Subject: [PATCH 10/12] powerpc: wiiu: platform support
Date:   Wed,  2 Mar 2022 15:44:04 +1100
Message-Id: <20220302044406.63401-11-ash@heyquark.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220302044406.63401-1-ash@heyquark.com>
References: <20220302044406.63401-1-ash@heyquark.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add platform support for the Nintendo Wii U console.

Signed-off-by: Ash Logan <ash@heyquark.com>
Co-developed-by: Roberto Van Eeden <rw-r-r-0644@protonmail.com>
Signed-off-by: Roberto Van Eeden <rw-r-r-0644@protonmail.com>
Co-developed-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
---
 arch/powerpc/platforms/wiiu/Makefile |  2 +-
 arch/powerpc/platforms/wiiu/setup.c  | 67 ++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/platforms/wiiu/setup.c

diff --git a/arch/powerpc/platforms/wiiu/Makefile b/arch/powerpc/platforms/wiiu/Makefile
index fa16c60261e6..abcb7a1beebf 100644
--- a/arch/powerpc/platforms/wiiu/Makefile
+++ b/arch/powerpc/platforms/wiiu/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-$(CONFIG_WIIU) += espresso-pic.o latte-pic.o
+obj-$(CONFIG_WIIU) += setup.o espresso-pic.o latte-pic.o
 obj-$(CONFIG_LATTEIPC_UDBG) += udbg_latteipc.o
diff --git a/arch/powerpc/platforms/wiiu/setup.c b/arch/powerpc/platforms/wiiu/setup.c
new file mode 100644
index 000000000000..279fa899a296
--- /dev/null
+++ b/arch/powerpc/platforms/wiiu/setup.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Nintendo Wii U board-specific support
+ *
+ * Copyright (C) 2022 The linux-wiiu Team
+ */
+#define DRV_MODULE_NAME "wiiu"
+#define pr_fmt(fmt) DRV_MODULE_NAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/of_platform.h>
+
+#include <asm/machdep.h>
+#include <asm/udbg.h>
+
+#include "espresso-pic.h"
+#include "latte-pic.h"
+#include "udbg_latteipc.h"
+
+static int __init wiiu_probe(void)
+{
+	if (!of_machine_is_compatible("nintendo,wiiu"))
+		return 0;
+
+	latteipc_udbg_init();
+
+	return 1;
+}
+
+static void __noreturn wiiu_halt(void)
+{
+	for (;;)
+		cpu_relax();
+}
+
+static void __init wiiu_init_irq(void)
+{
+	espresso_pic_init();
+	latte_pic_init();
+}
+
+static const struct of_device_id wiiu_of_bus[] = {
+	{
+		.compatible = "nintendo,latte",
+	},
+	{},
+};
+
+static int __init wiiu_device_probe(void)
+{
+	if (!machine_is(wiiu))
+		return 0;
+
+	of_platform_populate(NULL, wiiu_of_bus, NULL, NULL);
+	return 0;
+}
+device_initcall(wiiu_device_probe);
+
+define_machine(wiiu) {
+	.name = "wiiu",
+	.probe = wiiu_probe,
+	.halt = wiiu_halt,
+	.progress = udbg_progress,
+	.calibrate_decr = generic_calibrate_decr,
+	.init_IRQ = wiiu_init_irq,
+	.get_irq = espresso_pic_get_irq,
+};
-- 
2.35.1

