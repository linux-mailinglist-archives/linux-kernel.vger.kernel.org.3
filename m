Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D09D482896
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 22:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbiAAV6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 16:58:25 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:48678 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbiAAV6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 16:58:25 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 739EA614E2CD;
        Sat,  1 Jan 2022 22:58:23 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id VqnfkIwBPEAg; Sat,  1 Jan 2022 22:58:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0279B614E2EE;
        Sat,  1 Jan 2022 22:58:23 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id c039Ef3NOiFE; Sat,  1 Jan 2022 22:58:22 +0100 (CET)
Received: from blindfold.corp.sigma-star.at (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id B2820614E2DB;
        Sat,  1 Jan 2022 22:58:22 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     linux-um@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, johannes.berg@intel.com,
        anton.ivanov@cambridgegreys.com,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH 1/4] um: Run console exit code also upon kernel panic
Date:   Sat,  1 Jan 2022 22:58:07 +0100
Message-Id: <20220101215810.13260-2-richard@nod.at>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220101215810.13260-1-richard@nod.at>
References: <20220101215810.13260-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure that UML's console exit handler run also when the kernel
crashes.
That way settings and resources can get restored.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/drivers/stdio_console.c      |  4 ++--
 arch/um/include/shared/uml_console.h | 11 +++++++++++
 arch/um/kernel/um_arch.c             |  8 +++++---
 3 files changed, 18 insertions(+), 5 deletions(-)
 create mode 100644 arch/um/include/shared/uml_console.h

diff --git a/arch/um/drivers/stdio_console.c b/arch/um/drivers/stdio_cons=
ole.c
index e8b762f4d8c2..06612c3b6240 100644
--- a/arch/um/drivers/stdio_console.c
+++ b/arch/um/drivers/stdio_console.c
@@ -180,13 +180,13 @@ static int stdio_init(void)
 }
 late_initcall(stdio_init);
=20
-static void console_exit(void)
+void uml_console_exit(void)
 {
 	if (!con_init_done)
 		return;
 	close_lines(vts, ARRAY_SIZE(vts));
 }
-__uml_exitcall(console_exit);
+__uml_exitcall(uml_console_exit);
=20
 static int console_chan_setup(char *str)
 {
diff --git a/arch/um/include/shared/uml_console.h b/arch/um/include/share=
d/uml_console.h
new file mode 100644
index 000000000000..aa8d02fe5e90
--- /dev/null
+++ b/arch/um/include/shared/uml_console.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022 Richard Weinberger <richard@nod.at>
+ */
+
+#ifndef UML_CONSOLE_H
+#define UML_CONSOLE_H
+
+extern void uml_console_exit(void);
+
+#endif /* UML_CONSOLE_H */
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index abceeabe29b9..0bdae61929ef 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -17,17 +17,18 @@
 #include <linux/kmsg_dump.h>
 #include <linux/suspend.h>
=20
-#include <asm/processor.h>
+#include <arch.h>
+#include <as-layout.h>
 #include <asm/cpufeature.h>
+#include <asm/processor.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
-#include <as-layout.h>
-#include <arch.h>
 #include <init.h>
 #include <kern.h>
 #include <kern_util.h>
 #include <mem_user.h>
 #include <os.h>
+#include <uml_console.h>
=20
 #include "um_arch.h"
=20
@@ -245,6 +246,7 @@ static int panic_exit(struct notifier_block *self, un=
signed long unused1,
 	bust_spinlocks(1);
 	bust_spinlocks(0);
 	uml_exitcode =3D 1;
+	uml_console_exit();
 	os_dump_core();
 	return 0;
 }
--=20
2.26.2

