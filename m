Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2734C6FEA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237350AbiB1OsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237375AbiB1Or7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:47:59 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D006480207
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:47:19 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id u11so17739452lju.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 06:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wVolMfpuoGDt9XCP+363s8gQ0xUicGtJcmsMqdqFw1w=;
        b=j0Qo309S6hgbmP3ipd/KV2J3R+BIUQFYoZ83AhxK88SCE+HmSRf4w08bt+aPlfdW7/
         uYLKmxXKTnSHV2INU3FvleBLvn9tb+GlIssYTgokngxJDd2JXGjI9oPzusCc9XqQwn3T
         1Skv19AWT9gSL3FGuNmFXqZCaCslOyIhvdM8AaqcamrkDzBDMf4UyydzdofNjjdP+3ZZ
         kMOA6VbHJHB/DQQNRpMzLdtHu3zQlv7QrrtgQU5QJT0mTdkNZQ2p5fs2qd44GFsYTDa7
         w6fDM6AJ0RY+JxY6nALgJt4J/snff05XTeZZM8fi0Ca5cH90HXknkANA8zFhKwK5A7EX
         BoqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wVolMfpuoGDt9XCP+363s8gQ0xUicGtJcmsMqdqFw1w=;
        b=X6klU5/6e2BzJvjkfVhdd4oc9+HYfsxmArd3D19IOqo4zSG+Mg4NGvyGh9tKiC32sG
         ePL+oMkFMbCWSNP6xZxmbQzo/emHTHNNvZ6DAwndneXXBFvzia25rKaqrWj80DvrF4cv
         EE+fsEqa4sxufeXNlg/V/sLDfXqoIUW6OdFG0SjpMkKKn9D+TAr01RjbY5tntc0EqDY1
         1UceHv8wigKNVuMN+6q3pxk1T7xgIgiRY4cTJ9hkZINiNSsb7oUNKqd0t+c4P9FLhof/
         6NbqgVJWFAt39RFKAwNj3Dwhu0j5OtR+vx69htTXzt9w0wQShGMwl6UXEZiAl7K8jlzT
         JS7w==
X-Gm-Message-State: AOAM533AUDxb9f301HgFDTlwZUNY1sL79lcp4dy2VAaZS26PgzSqTTpb
        VBqR/6F9ecetIco+GO5YHCg=
X-Google-Smtp-Source: ABdhPJypZNl0cy1qm5rfj/e4qV8VLCzwXi5IXSlKHc3dq3Zof8peeKvCKbrtelr5Rod7+SKSnVyJqQ==
X-Received: by 2002:a2e:bb8f:0:b0:244:c93b:3dff with SMTP id y15-20020a2ebb8f000000b00244c93b3dffmr14167825lje.226.1646059638221;
        Mon, 28 Feb 2022 06:47:18 -0800 (PST)
Received: from elysium.toya.net.pl (staticline-31-183-165-244.toya.net.pl. [31.183.165.244])
        by smtp.gmail.com with ESMTPSA id r14-20020ac252ae000000b00443f3cbc03asm993996lfm.6.2022.02.28.06.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 06:47:17 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     linux-mm@kvack.org
Cc:     rppt@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH 2/9] memblock tests: Add simulation of physical memory
Date:   Mon, 28 Feb 2022 15:46:44 +0100
Message-Id: <dce115503c74a6936c44694b00014658a1bb6522.1646055639.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1646055639.git.karolinadrobnik@gmail.com>
References: <cover.1646055639.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocation functions that return virtual addresses (with an exception
of _raw variant) clear the allocated memory after reserving it. This
requires valid memory ranges in memblock.memory.

Introduce memory_block variable to store memory that can be registered
with memblock data structure. Move assert.h and size.h includes to common.h
to share them between the test files.

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 tools/testing/memblock/tests/basic_api.c |  1 -
 tools/testing/memblock/tests/basic_api.h |  1 -
 tools/testing/memblock/tests/common.c    | 19 +++++++++++++++++++
 tools/testing/memblock/tests/common.h    | 18 ++++++++++++++++++
 4 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/tools/testing/memblock/tests/basic_api.c b/tools/testing/memblock/tests/basic_api.c
index d5035a3dcce8..fbc1ce160303 100644
--- a/tools/testing/memblock/tests/basic_api.c
+++ b/tools/testing/memblock/tests/basic_api.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 #include <string.h>
 #include <linux/memblock.h>
-#include <linux/sizes.h>
 #include "basic_api.h"
 
 #define EXPECTED_MEMBLOCK_REGIONS			128
diff --git a/tools/testing/memblock/tests/basic_api.h b/tools/testing/memblock/tests/basic_api.h
index 1ceecfca1f47..1873faa54754 100644
--- a/tools/testing/memblock/tests/basic_api.h
+++ b/tools/testing/memblock/tests/basic_api.h
@@ -2,7 +2,6 @@
 #ifndef _MEMBLOCK_BASIC_H
 #define _MEMBLOCK_BASIC_H
 
-#include <assert.h>
 #include "common.h"
 
 int memblock_basic_checks(void);
diff --git a/tools/testing/memblock/tests/common.c b/tools/testing/memblock/tests/common.c
index dd7e87c589fe..62d3191f7c9a 100644
--- a/tools/testing/memblock/tests/common.c
+++ b/tools/testing/memblock/tests/common.c
@@ -5,6 +5,8 @@
 #define INIT_MEMBLOCK_REGIONS			128
 #define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS
 
+static struct test_memory memory_block;
+
 void reset_memblock_regions(void)
 {
 	memset(memblock.memory.regions, 0,
@@ -27,3 +29,20 @@ void reset_memblock_attributes(void)
 	memblock.bottom_up	= false;
 	memblock.current_limit	= MEMBLOCK_ALLOC_ANYWHERE;
 }
+
+void setup_memblock(void)
+{
+	reset_memblock_regions();
+	memblock_add((phys_addr_t)memory_block.base, MEM_SIZE);
+}
+
+void dummy_physical_memory_init(void)
+{
+	memory_block.base = malloc(MEM_SIZE);
+	assert(memory_block.base);
+}
+
+void dummy_physical_memory_cleanup(void)
+{
+	free(memory_block.base);
+}
diff --git a/tools/testing/memblock/tests/common.h b/tools/testing/memblock/tests/common.h
index b864c64fb60f..619054d03219 100644
--- a/tools/testing/memblock/tests/common.h
+++ b/tools/testing/memblock/tests/common.h
@@ -2,8 +2,23 @@
 #ifndef _MEMBLOCK_TEST_H
 #define _MEMBLOCK_TEST_H
 
+#include <stdlib.h>
+#include <assert.h>
 #include <linux/types.h>
 #include <linux/memblock.h>
+#include <linux/sizes.h>
+
+#define MEM_SIZE SZ_16K
+
+/*
+ * Available memory registered with memblock needs to be valid for allocs
+ * test to run. This is a convenience wrapper for memory allocated in
+ * dummy_physical_memory_init() that is later registered with memblock
+ * in setup_memblock().
+ */
+struct test_memory {
+	void *base;
+};
 
 struct region {
 	phys_addr_t base;
@@ -12,5 +27,8 @@ struct region {
 
 void reset_memblock_regions(void);
 void reset_memblock_attributes(void);
+void setup_memblock(void);
+void dummy_physical_memory_init(void);
+void dummy_physical_memory_cleanup(void);
 
 #endif
-- 
2.30.2

