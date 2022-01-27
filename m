Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDAEC49E34C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241962AbiA0NXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241782AbiA0NXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:23:01 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484F8C061757
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:22:57 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id n8so5322661lfq.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7K2ZoWo7A3VK2p2YuUqNX5mlstHmQYkZvdeMYQDRBgA=;
        b=DvJ42WZGL6xIU1SJVI32SaW4vRcAdT3+YIjAhClWAeYHr0wzntb9gm+G25e6D+Mr8U
         oNB5s6lrm/QtXOr6x/ieRMbB1Dz3tte5Xm+ZY013YoUl5RquBqcELw0u8Bko4/uv30KE
         Jookr+6Q5ce8zNoDPpQPEVYlv4J4oFC6L6bBovv8MNOlXfDeOxUrk12FDWG9EKsK26dp
         gkMH29Ggmv12iKwEZIQIjbgII4qW5nyCAv2Ds7yFzzATTCXVFyTSdghqb3Z+AuZYbMq6
         AbXtyhywP71xbk2Oet9QPNykRKUMcMjYHFpovkh6H0qEj9Ih1oUmiLG8YIvO5TkQrqLn
         8z9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7K2ZoWo7A3VK2p2YuUqNX5mlstHmQYkZvdeMYQDRBgA=;
        b=iFJRi6D9aWuLSNWaxmTP5qy1YWQajuJsq9VBnpooZfnxQPcMthagMOvm0yf6gu6u52
         eS1JTWKbTaS4CXxwY4n0QGCmZbEGuef4355H+LzXfVJHRWIhnY6XyIzcDh91oyOrjox5
         b8JwrNTMPSmPrxo49VO4uxHu+WpdEghxDByLULJzTd0l+REvBTu+v8s1PGpWupb5t7Zd
         KU0U1fc3dFKxR3TxDC5+VQlHWzU1atfKpTuw8pxe8os461fzGPvH9JhQGu32TzLPM0TZ
         UGNqVxbIkfU0YJWsDkPwv0yYcz0OK+qRuyTi0EAxhIXDEK7xfReghSBEA6bQuSpcL4R2
         kRdA==
X-Gm-Message-State: AOAM533avYLAdWNfSatPjjFBeCIob04pc68P9WD79tgJdA27qXBL4wwt
        Oje9U3Nx+KMSeo5xHwM6+S5fzQvZB7k=
X-Google-Smtp-Source: ABdhPJwIKvJeJYr78aiPnHxXfUNWm4IOcWHHMSgnsZOOuQeVo9MyJQTvMcHuNzRtP+rWvkLnJ+jTKQ==
X-Received: by 2002:a05:6512:1699:: with SMTP id bu25mr2815086lfb.681.1643289775573;
        Thu, 27 Jan 2022 05:22:55 -0800 (PST)
Received: from elysium.toya.net.pl (staticline-31-183-166-172.toya.net.pl. [31.183.166.172])
        by smtp.gmail.com with ESMTPSA id s16sm1306918lfp.197.2022.01.27.05.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 05:22:54 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, mike.rapoport@gmail.com,
        linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH 11/16] memblock tests: Add memblock reset function
Date:   Thu, 27 Jan 2022 14:21:29 +0100
Message-Id: <4ceb25e17a162c7e15c1cbe138019a4be48d3c93.1643206612.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1643206612.git.karolinadrobnik@gmail.com>
References: <cover.1643206612.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memblock simulator needs to be able to reset memblock data structures
between different test cases. Add a function that sets all fields to
their default values.

Add a test checking if memblock is being initialized to expected values.

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 tools/testing/memblock/Makefile          |  4 ++-
 tools/testing/memblock/main.c            |  2 ++
 tools/testing/memblock/tests/basic_api.c | 32 ++++++++++++++++++++++++
 tools/testing/memblock/tests/basic_api.h | 10 ++++++++
 tools/testing/memblock/tests/common.c    | 27 ++++++++++++++++++++
 tools/testing/memblock/tests/common.h    | 15 +++++++++++
 6 files changed, 89 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/memblock/tests/basic_api.c
 create mode 100644 tools/testing/memblock/tests/basic_api.h
 create mode 100644 tools/testing/memblock/tests/common.c
 create mode 100644 tools/testing/memblock/tests/common.h

diff --git a/tools/testing/memblock/Makefile b/tools/testing/memblock/Makefile
index 35105923f235..31c4ef625ede 100644
--- a/tools/testing/memblock/Makefile
+++ b/tools/testing/memblock/Makefile
@@ -5,7 +5,9 @@ CFLAGS += -I. -I../../include -Wall -O2 -fsanitize=address \
 	  -fsanitize=undefined -D CONFIG_PHYS_ADDR_T_64BIT
 LDFLAGS += -fsanitize=address -fsanitize=undefined
 TARGETS = main
-OFILES = main.o memblock.o lib/slab.o mmzone.o slab.o
+TEST_OFILES = tests/basic_api.o tests/common.o
+DEP_OFILES = memblock.o lib/slab.o mmzone.o slab.o
+OFILES = main.o $(DEP_OFILES) $(TEST_OFILES)
 EXTR_SRC = ../../../mm/memblock.c
 
 ifeq ($(BUILD), 32)
diff --git a/tools/testing/memblock/main.c b/tools/testing/memblock/main.c
index 62958da35d0f..da65b0adee91 100644
--- a/tools/testing/memblock/main.c
+++ b/tools/testing/memblock/main.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
+#include "tests/basic_api.h"
 
 int main(int argc, char **argv)
 {
+	memblock_basic_checks();
 	return 0;
 }
diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
new file mode 100644
index 000000000000..7f2597b3dd4d
--- /dev/null
+++ b/tools/testing/memblock/tests/basic_api.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <string.h>
+#include <linux/memblock.h>
+#include "basic_api.h"
+
+#define EXPECTED_MEMBLOCK_REGIONS			128
+
+static int memblock_initialization_check(void)
+{
+	reset_memblock();
+
+	assert(memblock.memory.regions);
+	assert(memblock.memory.cnt == 1);
+	assert(memblock.memory.max == EXPECTED_MEMBLOCK_REGIONS);
+	assert(strcmp(memblock.memory.name, "memory") == 0);
+
+	assert(memblock.reserved.regions);
+	assert(memblock.reserved.cnt == 1);
+	assert(memblock.memory.max == EXPECTED_MEMBLOCK_REGIONS);
+	assert(strcmp(memblock.reserved.name, "reserved") == 0);
+
+	assert(!memblock.bottom_up);
+	assert(memblock.current_limit == MEMBLOCK_ALLOC_ANYWHERE);
+
+	return 0;
+}
+
+int memblock_basic_checks(void)
+{
+	memblock_initialization_check();
+	return 0;
+}
diff --git a/tools/testing/memblock/tests/basic_api.h b/tools/testing/memblock/tests/basic_api.h
new file mode 100644
index 000000000000..1ceecfca1f47
--- /dev/null
+++ b/tools/testing/memblock/tests/basic_api.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _MEMBLOCK_BASIC_H
+#define _MEMBLOCK_BASIC_H
+
+#include <assert.h>
+#include "common.h"
+
+int memblock_basic_checks(void);
+
+#endif
diff --git a/tools/testing/memblock/tests/common.c b/tools/testing/memblock/tests/common.c
new file mode 100644
index 000000000000..03de6eab0c3c
--- /dev/null
+++ b/tools/testing/memblock/tests/common.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include "tests/common.h"
+#include <string.h>
+
+#define INIT_MEMBLOCK_REGIONS			128
+#define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS
+
+void reset_memblock(void)
+{
+	memset(memblock.memory.regions, 0,
+	       memblock.memory.cnt * sizeof(struct memblock_region));
+	memset(memblock.reserved.regions, 0,
+	       memblock.reserved.cnt * sizeof(struct memblock_region));
+
+	memblock.memory.cnt	= 1;
+	memblock.memory.max	= INIT_MEMBLOCK_REGIONS;
+	memblock.memory.name	= "memory";
+	memblock.memory.total_size = 0;
+
+	memblock.reserved.cnt	= 1;
+	memblock.reserved.max	= INIT_MEMBLOCK_RESERVED_REGIONS;
+	memblock.reserved.name	= "reserved";
+	memblock.reserved.total_size = 0;
+
+	memblock.bottom_up	= false;
+	memblock.current_limit	= MEMBLOCK_ALLOC_ANYWHERE;
+}
diff --git a/tools/testing/memblock/tests/common.h b/tools/testing/memblock/tests/common.h
new file mode 100644
index 000000000000..48efc4270ea1
--- /dev/null
+++ b/tools/testing/memblock/tests/common.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _MEMBLOCK_TEST_H
+#define _MEMBLOCK_TEST_H
+
+#include <linux/types.h>
+#include <linux/memblock.h>
+
+struct region {
+	phys_addr_t base;
+	phys_addr_t size;
+};
+
+void reset_memblock(void);
+
+#endif
-- 
2.30.2

