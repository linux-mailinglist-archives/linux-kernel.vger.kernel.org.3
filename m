Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C60949FE24
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350132AbiA1QgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350097AbiA1QgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:36:08 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B127FC061747
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 08:36:07 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id u15so11956038wrt.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 08:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qh9ZukSBrcmzrIqovMOzTJ9hbhpz7rlhT3FvWLuMjno=;
        b=iXbzw95Y1DQRW+hjAI8IYGj5KLHaChdb2BKM1Ql3yXLewljYBMWZEMQtbYK0W58h7X
         qLuRbE750QpId6mVndzHhbzGAxV8GoucgoEuctffCF1sbCc4qCBbIIZqHBNV7dJzIFgd
         wMnFHdzft2GDCyfO78zvXdK9CM+nZ40BQMc1hAs++jtetAYfYSjQ54ghtomCDKWWQYiO
         Vfbmvbvjj2kGTN269t5V19mvcKin4WIbnoqw+1b/BPz/GDYfT1IipPMJuEVLsFzrE2Ad
         gjFRdLapEWNnjoIm+Z81bfetOHDnaMqAankUSYpPN9nJGtx5hPcXAQjKkD9TPvYRQZKt
         0n6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qh9ZukSBrcmzrIqovMOzTJ9hbhpz7rlhT3FvWLuMjno=;
        b=FOBoHoSoNYeTvNaYZI2ZY9ks87vVYcwulixJeVpfBx4OI58l3rMCDzhnITRhB/G1S7
         Jt/oGM0hyGy6pNfjYyzhoUcX/tkf6UlziFH+kleHNGqxcmM7v23xcFnrfJFuNVKZwORm
         1ZvR+EcmOHoAF7HE8PM73Bt+DoFrXBwF1wmO8T+9DF3FlBs88K/wZXdZ11Ao4uGXwflX
         FUX7VU7+qT8c8bDG/On2x7Oa49zP+MeXLg1B1mMYL77rjAP+mPhHX8/7ugytKzFjXn52
         iivnX9rdWdvnLDBsOxdrH7RlXhL6HEB9NxURG3oj7EhPvxdB40vb53/t7vLj14mbY+19
         J2CA==
X-Gm-Message-State: AOAM53095SNVm6V84Bd7aJ+wSaFv786Mw3iWSKpC8W4PXcqHSWS4HdYR
        LpPVK0JzJtFEzJ+I9O0ZJ0J1rXvdopjH4w==
X-Google-Smtp-Source: ABdhPJwMZoA7mdRtx2e6Wt/qHVleYsrCePnVZ4AsVaXByy1PPO0iDI0HZlWi4bC7mCGyE4SK2z8WsQ==
X-Received: by 2002:a5d:48c5:: with SMTP id p5mr7778841wrs.566.1643387766198;
        Fri, 28 Jan 2022 08:36:06 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:f39:b962:8b8e:9851])
        by smtp.gmail.com with ESMTPSA id m6sm5734745wrw.54.2022.01.28.08.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 08:36:05 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rjw@rjwysocki.net
Cc:     heiko@sntech.de, robh@kernel.org, lukasz.luba@arm.com,
        arnd@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES)
Subject: [PATCH v8 1/5] powercap/drivers/dtpm: Convert the init table section to a simple array
Date:   Fri, 28 Jan 2022 17:35:33 +0100
Message-Id: <20220128163537.212248-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220128163537.212248-1-daniel.lezcano@linaro.org>
References: <20220128163537.212248-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The init table section is freed after the system booted. However the
next changes will make per module the DTPM description, so the table
won't be accessible when the module is loaded.

In order to fix that, we should move the table to the data section
where there are very few entries and that makes strange to add it
there.

The main goal of the table was to keep self-encapsulated code and we
can keep it almost as it by using an array instead.

Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/dtpm.c           |  2 ++
 drivers/powercap/dtpm_cpu.c       |  5 ++++-
 drivers/powercap/dtpm_subsys.h    | 18 ++++++++++++++++++
 include/asm-generic/vmlinux.lds.h | 11 -----------
 include/linux/dtpm.h              | 24 +++---------------------
 5 files changed, 27 insertions(+), 33 deletions(-)
 create mode 100644 drivers/powercap/dtpm_subsys.h

diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
index 8cb45f2d3d78..0e5c93443c70 100644
--- a/drivers/powercap/dtpm.c
+++ b/drivers/powercap/dtpm.c
@@ -24,6 +24,8 @@
 #include <linux/slab.h>
 #include <linux/mutex.h>
 
+#include "dtpm_subsys.h"
+
 #define DTPM_POWER_LIMIT_FLAG 0
 
 static const char *constraint_name[] = {
diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index b740866b228d..5763e0ce2af5 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -269,4 +269,7 @@ static int __init dtpm_cpu_init(void)
 	return 0;
 }
 
-DTPM_DECLARE(dtpm_cpu, dtpm_cpu_init);
+struct dtpm_subsys_ops dtpm_cpu_ops = {
+	.name = KBUILD_MODNAME,
+	.init = dtpm_cpu_init,
+};
diff --git a/drivers/powercap/dtpm_subsys.h b/drivers/powercap/dtpm_subsys.h
new file mode 100644
index 000000000000..2a3a2055f60e
--- /dev/null
+++ b/drivers/powercap/dtpm_subsys.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2022 Linaro Ltd
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ */
+#ifndef ___DTPM_SUBSYS_H__
+#define ___DTPM_SUBSYS_H__
+
+extern struct dtpm_subsys_ops dtpm_cpu_ops;
+
+struct dtpm_subsys_ops *dtpm_subsys[] = {
+#ifdef CONFIG_DTPM_CPU
+	&dtpm_cpu_ops,
+#endif
+};
+
+#endif
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 42f3866bca69..2a10db2f0bc5 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -321,16 +321,6 @@
 #define THERMAL_TABLE(name)
 #endif
 
-#ifdef CONFIG_DTPM
-#define DTPM_TABLE()							\
-	. = ALIGN(8);							\
-	__dtpm_table = .;						\
-	KEEP(*(__dtpm_table))						\
-	__dtpm_table_end = .;
-#else
-#define DTPM_TABLE()
-#endif
-
 #define KERNEL_DTB()							\
 	STRUCT_ALIGN();							\
 	__dtb_start = .;						\
@@ -723,7 +713,6 @@
 	ACPI_PROBE_TABLE(irqchip)					\
 	ACPI_PROBE_TABLE(timer)						\
 	THERMAL_TABLE(governor)						\
-	DTPM_TABLE()							\
 	EARLYCON_TABLE()						\
 	LSM_TABLE()							\
 	EARLY_LSM_TABLE()						\
diff --git a/include/linux/dtpm.h b/include/linux/dtpm.h
index d37e5d06a357..506048158a50 100644
--- a/include/linux/dtpm.h
+++ b/include/linux/dtpm.h
@@ -32,29 +32,11 @@ struct dtpm_ops {
 	void (*release)(struct dtpm *);
 };
 
-typedef int (*dtpm_init_t)(void);
-
-struct dtpm_descr {
-	dtpm_init_t init;
+struct dtpm_subsys_ops {
+	const char *name;
+	int (*init)(void);
 };
 
-/* Init section thermal table */
-extern struct dtpm_descr __dtpm_table[];
-extern struct dtpm_descr __dtpm_table_end[];
-
-#define DTPM_TABLE_ENTRY(name, __init)				\
-	static struct dtpm_descr __dtpm_table_entry_##name	\
-	__used __section("__dtpm_table") = {			\
-		.init = __init,					\
-	}
-
-#define DTPM_DECLARE(name, init)	DTPM_TABLE_ENTRY(name, init)
-
-#define for_each_dtpm_table(__dtpm)	\
-	for (__dtpm = __dtpm_table;	\
-	     __dtpm < __dtpm_table_end;	\
-	     __dtpm++)
-
 static inline struct dtpm *to_dtpm(struct powercap_zone *zone)
 {
 	return container_of(zone, struct dtpm, zone);
-- 
2.25.1

