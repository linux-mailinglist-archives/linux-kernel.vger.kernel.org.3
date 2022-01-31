Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCFB4A4766
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 13:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377812AbiAaMlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 07:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377723AbiAaMlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 07:41:23 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C89C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 04:41:23 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id bg23-20020a05600c3c9700b0034bb19dfdc0so2898386wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 04:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=PcKNikI55bDy8w/A2/XpgUqHNUjMqDQm7v+KU8P6jUw=;
        b=ZedAg5IsAwnYYvRJ/slW9PVXqVh6BAZ3kdHrRnBQoYf7wiHTyZKjveOe7YXnVEe5hP
         yPUPut/r2Qk7KWFPFcGNBm2SE5zg5sDltAxYo4G7B4heLVKv2qAHpFm06Wsalcr3zu3g
         3PHmeGOC10U2ZaArFU8ocDjO4TkyMSp3GUOvFHCXS1jGA9emquJCdQ9J0d9feaWzkHzO
         +rwBDjqhqFIRvy0IwvKkqArF1VRsL895WEF5D3dXCM7dDzwSxZ+JVPT7fMz90mXGyPxn
         zpsK4aNQcWyt/1fWq6JVHCzzWsWgox8bjxfUfbIi/ZattNOOq57oLM57K5q1tbAiR2md
         q/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=PcKNikI55bDy8w/A2/XpgUqHNUjMqDQm7v+KU8P6jUw=;
        b=GRiwpJbOY5tzoVfeyaIijeiu3rySQGfUB9uYK9zSYucGnsad4J3LOvuJ6Nq2AFh/iC
         BxUiYy3AYT/ok5Ghw16kYWxdgdaKmpT3Rk4pqKc2HtNza7jW3Dim0Nt+ww6+GSjwQ7pW
         VtKMgXoS5TWlF2WYG7rywtU48n7oePHUBIfu4g1bRYmkht7FwI6K27OgvEiwdCJjvEVR
         wQH3t+61a2jwjHTOecW1cxKUlxGa/++v9K8++qOjUzviDKKKrp3yGQg1r+chzh2aU/Es
         qD8anqu6sa/r/TvnpJAc2OlfdiiTXZH6U1QIUNiZmHott2BkCPBdQv00aXZrNIJy3i4q
         MCeg==
X-Gm-Message-State: AOAM533pBoIJNFh7IFcAPq5LaN0+WFYo9+QKNOEa3egebSD9+6zcD/Y/
        xgvW2QRy78DQWD4/sqaaQy3sGrSI1w==
X-Google-Smtp-Source: ABdhPJxEMVqxK9VFD8U6hh5jEgX20oC9m+6rJ8uxexwyoP/dRPBjb+gbo3+XuJgFltlFVrGro+z8K8VcqA==
X-Received: from keirf-1.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:17ba])
 (user=keirf job=sendgmr) by 2002:a05:6000:16c9:: with SMTP id
 h9mr17519944wrf.272.1643632882051; Mon, 31 Jan 2022 04:41:22 -0800 (PST)
Date:   Mon, 31 Jan 2022 12:40:53 +0000
Message-Id: <20220131124114.3103337-1-keirf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH v2] KVM: arm64: pkvm: Implement CONFIG_DEBUG_LIST at Hyp
From:   Keir Fraser <keirf@google.com>
To:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Cc:     Keir Fraser <keirf@google.com>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Fuad Tabba <tabba@google.com>,
        Kees Cook <keescook@chromium.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Zenghui Yu <yuzenghui@huawei.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the check functions are stubbed out at EL2. Implement
versions suitable for the constrained EL2 environment.

Signed-off-by: Keir Fraser <keirf@google.com>
---
 arch/arm64/kvm/hyp/nvhe/Makefile     |  3 +-
 arch/arm64/kvm/hyp/nvhe/list_debug.c | 54 ++++++++++++++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/stub.c       | 22 ------------
 3 files changed, 56 insertions(+), 23 deletions(-)
 create mode 100644 arch/arm64/kvm/hyp/nvhe/list_debug.c
 delete mode 100644 arch/arm64/kvm/hyp/nvhe/stub.c

diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index 24b2c2425b38..f9fe4dc21b1f 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -13,10 +13,11 @@ lib-objs := clear_page.o copy_page.o memcpy.o memset.o
 lib-objs := $(addprefix ../../../lib/, $(lib-objs))
 
 obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o \
-	 hyp-main.o hyp-smp.o psci-relay.o early_alloc.o stub.o page_alloc.o \
+	 hyp-main.o hyp-smp.o psci-relay.o early_alloc.o page_alloc.o \
 	 cache.o setup.o mm.o mem_protect.o sys_regs.o pkvm.o
 obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
 	 ../fpsimd.o ../hyp-entry.o ../exception.o ../pgtable.o
+obj-$(CONFIG_DEBUG_LIST) += list_debug.o
 obj-y += $(lib-objs)
 
 ##
diff --git a/arch/arm64/kvm/hyp/nvhe/list_debug.c b/arch/arm64/kvm/hyp/nvhe/list_debug.c
new file mode 100644
index 000000000000..d68abd7ea124
--- /dev/null
+++ b/arch/arm64/kvm/hyp/nvhe/list_debug.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 - Google LLC
+ * Author: Keir Fraser <keirf@google.com>
+ */
+
+#include <linux/list.h>
+#include <linux/bug.h>
+
+static inline __must_check bool nvhe_check_data_corruption(bool v)
+{
+	return v;
+}
+
+#define NVHE_CHECK_DATA_CORRUPTION(condition)				 \
+	nvhe_check_data_corruption(({					 \
+		bool corruption = unlikely(condition);			 \
+		if (corruption) {					 \
+			if (IS_ENABLED(CONFIG_BUG_ON_DATA_CORRUPTION)) { \
+				BUG_ON(1);				 \
+			} else						 \
+				WARN_ON(1);				 \
+		}							 \
+		corruption;						 \
+	}))
+
+/* The predicates checked here are taken from lib/list_debug.c. */
+
+bool __list_add_valid(struct list_head *new, struct list_head *prev,
+		      struct list_head *next)
+{
+	if (NVHE_CHECK_DATA_CORRUPTION(next->prev != prev) ||
+	    NVHE_CHECK_DATA_CORRUPTION(prev->next != next) ||
+	    NVHE_CHECK_DATA_CORRUPTION(new == prev || new == next))
+		return false;
+
+	return true;
+}
+
+bool __list_del_entry_valid(struct list_head *entry)
+{
+	struct list_head *prev, *next;
+
+	prev = entry->prev;
+	next = entry->next;
+
+	if (NVHE_CHECK_DATA_CORRUPTION(next == LIST_POISON1) ||
+	    NVHE_CHECK_DATA_CORRUPTION(prev == LIST_POISON2) ||
+	    NVHE_CHECK_DATA_CORRUPTION(prev->next != entry) ||
+	    NVHE_CHECK_DATA_CORRUPTION(next->prev != entry))
+		return false;
+
+	return true;
+}
diff --git a/arch/arm64/kvm/hyp/nvhe/stub.c b/arch/arm64/kvm/hyp/nvhe/stub.c
deleted file mode 100644
index c0aa6bbfd79d..000000000000
--- a/arch/arm64/kvm/hyp/nvhe/stub.c
+++ /dev/null
@@ -1,22 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Stubs for out-of-line function calls caused by re-using kernel
- * infrastructure at EL2.
- *
- * Copyright (C) 2020 - Google LLC
- */
-
-#include <linux/list.h>
-
-#ifdef CONFIG_DEBUG_LIST
-bool __list_add_valid(struct list_head *new, struct list_head *prev,
-		      struct list_head *next)
-{
-		return true;
-}
-
-bool __list_del_entry_valid(struct list_head *entry)
-{
-		return true;
-}
-#endif
-- 
2.35.0.rc2.247.g8bbb082509-goog

