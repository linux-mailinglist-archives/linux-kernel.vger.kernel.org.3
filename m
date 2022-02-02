Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F0C4A6F82
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 12:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343816AbiBBLE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 06:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343793AbiBBLEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 06:04:06 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6446CC061751
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 03:04:04 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id u6so39787675lfm.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 03:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N4kQ7fCJQ83r9kjg6pIOnmCnBUnFX1leJDY6JkaRj+I=;
        b=VCWp1/CXErfDv2Si1Pb/0PNFj0BpYEAaoZj/+jKibP0b5cXP2y1E/YqFS0UBPQVp1g
         VECS2+1yJsPv5eJX3WlFnzEV7abFllvb16b0DSENlnUItUUIN0XJWqlPUaV3zF/TLAVQ
         BHoIuOxr9ytZrBiPPrSTozaI2/URo9Smr5x3zqP4E8JHHuHDH1r3G9sUKR7xsUqiKw+i
         XAVBxTjbyF4kN2F3SQVxTuLCvisSBXXop5VhHA6BPEAZg/G9d10GdacFF9+Ux3DgWEBu
         gvrJi/6VSZ8w0LXRHCssuKYCvLsA1NuVCC0a7UwN1BbeXf+MzZYh8oL/ZEio03Dtc3iH
         x1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N4kQ7fCJQ83r9kjg6pIOnmCnBUnFX1leJDY6JkaRj+I=;
        b=pFGTuBecy0djROA5EE7Q80IWh9Xb1/yqpcv3NC1CJMfFAH3LacT479lB+IGwHm3MQe
         Rglfa9M/KGvi9i6goL+5Q7NjwvM2ipN9KBCQlD/wshN1c4xiXYUCLCZn3RvnhzIlYRtD
         pv6GSYZU7kg1f8PWifS10jOnInOoMhlHBal/CUEu/ERgR/hxauAc6/GrTZN+w8Z6hr8z
         ejo9cy+S2ZpbFq4aBgKkK/5oSGjUvR3wk0JzcQE39H6YzEqqCl1Ngl3tJm2Vg5aLTxZx
         KbGW1lQ8oBhqoqNXac53ZAVxBoY8fBsJqU1Pp2F2O0xGCCMQNBlSleNXfm3cUVBvmKGP
         Euow==
X-Gm-Message-State: AOAM530XvD+NKa4+yf8jsvHDPW1AehYZkPG5zWvrGA3hmGHrMza/ZB7p
        0kwH03+VPxeaGPyNE6TRrVw=
X-Google-Smtp-Source: ABdhPJyCsJagbftgFxK2KvEqWWcPAQVBWfOi40WcO5VfiKDerxcwIHDP/STqsOYl6D6jHgRCJGdr5A==
X-Received: by 2002:a05:6512:31d3:: with SMTP id j19mr24517829lfe.112.1643799842782;
        Wed, 02 Feb 2022 03:04:02 -0800 (PST)
Received: from localhost.localdomain (staticline-31-183-164-222.toya.net.pl. [31.183.164.222])
        by smtp.gmail.com with ESMTPSA id r14sm4503937lfr.129.2022.02.02.03.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 03:04:02 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, rppt@kernel.org,
        linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH v2 11/16] memblock tests: Add memblock reset function
Date:   Wed,  2 Feb 2022 12:03:10 +0100
Message-Id: <8c185aa7e0dd68c2c7e937c9a06c90ae413e240f.1643796665.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1643796665.git.karolinadrobnik@gmail.com>
References: <cover.1643796665.git.karolinadrobnik@gmail.com>
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
index e43ed9de9bcf..29715327a2d3 100644
--- a/tools/testing/memblock/Makefile
+++ b/tools/testing/memblock/Makefile
@@ -6,7 +6,9 @@ CFLAGS += -I. -I../../include -Wall -O2 -fsanitize=address \
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

