Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71FB94BD729
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 08:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346136AbiBUH0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 02:26:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346110AbiBUH0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 02:26:30 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285F3B0;
        Sun, 20 Feb 2022 23:26:08 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id y11so7999168pfi.11;
        Sun, 20 Feb 2022 23:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=bkCqs2b2H2dbk6pk5GKRvRdfG404QkRLu+NCe72oqto=;
        b=SY+7fp8hEsisrEIiqYYZaPtgHO+RXhflWCe1xFUUGZPGBCJZ8EuC7vmo+Z1/QqCGtE
         9wxelAn0herEfdMlcnyZ+L2MCkNX8PLUqQtdXtBHSYQ9/nvauRI59a6EYQRYYhVuavXO
         EczBvHO5esMQKFRB0fB12UuvDgLzxTjCfIl6ZiR5f/o/5sH9/ZaPt7XBW2GldwiJEO/T
         +tIUtegO5ttnc9hwTcqbeIjym3NF3rCeqMc+qXOfQie0IkzEHSAgf/mttYIx7DQn6mQU
         kMLoL7e5CxkZgSxVGTaxWef9A6N/HdOWqUbTpOKnOCxLsFv/Ol5AjCXOHNwr4QKSDH/f
         z8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=bkCqs2b2H2dbk6pk5GKRvRdfG404QkRLu+NCe72oqto=;
        b=SFf5a1PdjYx9POvze4wXDbxEX/XqRqyMCoTxVwBLNLCkPSZ/dC6vTsyjNGARlH2P0E
         J1gm9oz716WT7ZehrwZEQSb5IV3Fnz1jX/shYacoSc1SxAotpXH2r7AQUO4iBtt6rnry
         5fpDNbpKbrRR8S+aqd1Gs0XXsjaRogO9URnvXr1EEVfQAhacf8SXylIG2lGe+7qTyoF4
         LZbIpkYo3fn0mPf+G80I7XMXpLMEevmIn6/ApligPRgjo567ZRGl1+QqKjUltEnE3KXi
         6BcV4gGbzh0KpZp7SnJ7CnxwIacX6jeFzEfefmDDlu4kTITDs38seDtgLnFSdfI7lmsU
         FoFQ==
X-Gm-Message-State: AOAM533YoZnbvGygFRgoiG1YkXz4dFrrv+30PC1AFmqT5z4Kq4+LM9/L
        8RFPOf49CgCELeyHG+FHihE=
X-Google-Smtp-Source: ABdhPJySlyMTa9Zk1mAKbfojoZ+BW0m8XOcGEpmRt1hCjSkYxsw9XmRQ0YUz+98cW41+dqFbGpZUfg==
X-Received: by 2002:a63:fd48:0:b0:373:7925:b6e0 with SMTP id m8-20020a63fd48000000b003737925b6e0mr15322610pgj.314.1645428367655;
        Sun, 20 Feb 2022 23:26:07 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id q21sm11558094pfu.188.2022.02.20.23.26.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Feb 2022 23:26:07 -0800 (PST)
From:   Edwin Chiu <edwinchiu0505tw@gmail.com>
To:     edwin.chiu@sunplus.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org
Cc:     Edwin Chiu <edwinchiu0505tw@gmail.com>
Subject: [PATCH v5] cpuidle: sunplus: Create cpuidle driver for sunplus sp7021
Date:   Mon, 21 Feb 2022 15:26:18 +0800
Message-Id: <1628e048220f066204b8ac27f3cedf7f3cc02963.1645427180.git.edwinchiu0505tw@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1645427180.git.edwinchiu0505tw@gmail.com>
References: <cover.1645427180.git.edwinchiu0505tw@gmail.com>
In-Reply-To: <cover.1645427180.git.edwinchiu0505tw@gmail.com>
References: <cover.1645427180.git.edwinchiu0505tw@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create cpuidle driver for sunplus sp7021 chip

Signed-off-by: Edwin Chiu <edwinchiu0505tw@gmail.com>
---
Changes in v3
 - Rearrangement #include sequence
 - Change remark style to /*~*/
 - Align author email address to same as sob
 - Optimal code
Changes in v4
 - According Rob Herringrobh's comment
   There is no need for this binding.
   Just wanting a different driver is not a reason
   for a duplicate schema.
   So remove yaml file and submit driver again.
Changes in v5
 - According Krzysztof's comment
   You either use appropriate compatible in DT
   or add your compatible to cpuidle-arm.
   Even if this did not work, then the solution is to
   use common parts, not to duplicate entire driver.
   According Sudeep's comment
   In short NACK for any dedicated driver for this platform,
   use the generic cpuidle-arm driver with appropriate platform hooks
   Create cpuidle-sunplus.c in arch/arm/mach-sunplus/
   for hook generic cpuidle-arm driver

 MAINTAINERS                                   |  6 ++
 arch/arm/mach-sunplus/cpuidle-sunplus.c       | 88 +++++++++++++++++
 include/linux/platform_data/cpuidle-sunplus.h | 12 ++++
 3 files changed, 106 insertions(+)
 create mode 100644 arch/arm/mach-sunplus/cpuidle-sunplus.c
 create mode 100644 include/linux/platform_data/cpuidle-sunplus.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e0dca8f..5c96428 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18252,6 +18252,12 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/dlink/sundance.c
 
+SUNPLUS CPUIDLE DRIVER
+M:	Edwin Chiu <edwinchiu0505tw@gmail.com>
+S:	Maintained
+F:	arch/arm/mach-sunplus/cpuidle-sunplus.c
+F:	include/linux/platform_data/cpuidle-sunplus.h
+
 SUPERH
 M:	Yoshinori Sato <ysato@users.sourceforge.jp>
 M:	Rich Felker <dalias@libc.org>
diff --git a/arch/arm/mach-sunplus/cpuidle-sunplus.c b/arch/arm/mach-sunplus/cpuidle-sunplus.c
new file mode 100644
index 0000000..e9d9738
--- /dev/null
+++ b/arch/arm/mach-sunplus/cpuidle-sunplus.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SP7021 cpu idle Driver.
+ * Copyright (C) Sunplus Tech / Tibbo Tech.
+ */
+#define pr_fmt(fmt) "CPUidle arm: " fmt
+
+#include <linux/cpuidle.h>
+#include <linux/of_device.h>
+#include <linux/platform_data/cpuidle-sunplus.h>
+
+#include <asm/cpuidle.h>
+
+typedef int (*idle_fn)(void);
+
+static DEFINE_PER_CPU(idle_fn*, sp7021_idle_ops);
+
+static int sp7021_cpuidle_enter(unsigned long index)
+{
+	return __this_cpu_read(sp7021_idle_ops)[index]();
+}
+static int sp7021_cpu_spc(void)
+{
+	cpu_v7_do_idle();   /* idle to WFI */
+	return 0;
+}
+static const struct of_device_id sp7021_idle_state_match[] = {
+	{ .compatible = "arm,idle-state", .data = sp7021_cpu_spc },
+	{ },
+};
+static int sp7021_cpuidle_init(struct device_node *cpu_node, int cpu)
+{
+	const struct of_device_id *match_id;
+	struct device_node *state_node;
+	int i;
+	int state_count = 1;
+	idle_fn idle_fns[CPUIDLE_STATE_MAX];
+	idle_fn *fns;
+
+	for (i = 0; ; i++) {
+		state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
+		if (!state_node)
+			break;
+
+		if (!of_device_is_available(state_node))
+			continue;
+
+		if (i == CPUIDLE_STATE_MAX) {
+			pr_warn("%s: cpuidle states reached max possible\n",
+					__func__);
+			break;
+		}
+
+		match_id = of_match_node(sp7021_idle_state_match, state_node);
+		if (!match_id)
+			return -ENODEV;
+
+		idle_fns[state_count] = match_id->data;
+
+		state_count++;
+	}
+
+	if (state_count == 1)
+		goto check_sp;
+
+	fns = devm_kcalloc(get_cpu_device(cpu), state_count, sizeof(*fns),
+			GFP_KERNEL);
+	if (!fns)
+		return -ENOMEM;
+
+	for (i = 1; i < state_count; i++)
+		fns[i] = idle_fns[i];
+
+	per_cpu(sp7021_idle_ops, cpu) = fns;
+
+check_sp:
+	return 0;
+}
+static const struct cpuidle_ops sp7021_cpuidle_ops __initconst = {
+	.suspend = sp7021_cpuidle_enter,
+	.init = sp7021_cpuidle_init,
+};
+CPUIDLE_METHOD_OF_DECLARE(sc_smp, "sunplus,sc-smp", &sp7021_cpuidle_ops);
+
+MODULE_AUTHOR("Edwin Chiu <edwinchiu0505tw@gmail.com>");
+MODULE_DESCRIPTION("Sunplus sp7021 cpuidle driver");
+MODULE_LICENSE("GPL");
+
diff --git a/include/linux/platform_data/cpuidle-sunplus.h b/include/linux/platform_data/cpuidle-sunplus.h
new file mode 100644
index 0000000..12e98e5
--- /dev/null
+++ b/include/linux/platform_data/cpuidle-sunplus.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * SP7021 cpu idle Driver.
+ * Copyright (C) Sunplus Tech / Tibbo Tech.
+ */
+
+#ifndef __CPUIDLE_SP7021_H
+#define __CPUIDLE_SP7021_H
+
+extern int cpu_v7_do_idle(void);
+
+#endif
-- 
2.7.4

