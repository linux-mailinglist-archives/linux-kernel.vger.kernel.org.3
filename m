Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7F5591EA0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 08:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240155AbiHNGG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 02:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236064AbiHNGGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 02:06:55 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A099A1A83E
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 23:06:53 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id e69so3815095iof.5
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 23:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=9BV+JT1RS/2/MYqZZuZ9l7gp2iMxSyyMljieAYG86aA=;
        b=hl0w8eJQRHA+pvdB89Pl5fKE8tBDO5unKCZF5r1Lz7CMgjgOsH2uR5lhQCRkJM65GF
         lHHrEb/15NW7rQCUbL97hk317mRjL9IROyozoc608CWryvt7XreyRQoeCeP1t51e01K3
         C9CqEvlLA4Wy+H7a7au2R/PmLSHaXtJo1+/AqdZZ4JO3kLRhmEW5MFCCmGbFtweyjVQL
         1fC23+3Idb/Co1zfdEIxNsv64XlAcWb0eA/gNWSdUyRtIeMh5UHCxYXR6AL7Sb8CffuH
         8JKQjg8nTCjdRnCOcCApRaBGQbz5mo89jDNjon5G00VlNfQAT5AgMGsNCD2GA4O1kzQD
         5Kbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=9BV+JT1RS/2/MYqZZuZ9l7gp2iMxSyyMljieAYG86aA=;
        b=e2jvNSSEZb2dvLUSfGj3V9cOSTcXNkn/2B2Alk1gxMCzpwgQySTAQm/TiRcHlBQo9C
         rPMNEt7K6YPaLpYJAhKQ3pXHXEgiupLdkJ/g+yY/TUJ+2TLfQQjisF4bssfV/tE0Ysp8
         2p6FhUKC/wXs6AvC8kKzXBWTfBifUqsZURBwD4qcoM4Kv910BpQg8iCg1YoVPJ6sEIua
         fVwHfClpk0WeUxaJu02vybDgjJJU3U7Hx8g9/o0F7AOJlu+revncmQWDhA0ocE2CX2K8
         wB1MdZIj9OXQm6l04VNYbTKW1yO9qLYVM/k51oV3dybi9b7Rx7fLjkwo7ytLbfVH59UK
         cQjw==
X-Gm-Message-State: ACgBeo0qbG/PG93GwfE2xouEsZsb1GGvJ+TO3qiT+W4JO7KVDkRZlgCx
        lN20UY358PJx6qoEjDkxXqE=
X-Google-Smtp-Source: AA6agR4BlJt6RMS83dyzlyNFbxFOOOcH1bPuMJlZOxm6b+mSIPBO0727x6t48hdu0gSIkkkMO51FbA==
X-Received: by 2002:a5d:8ac8:0:b0:67f:ac0f:6cf6 with SMTP id e8-20020a5d8ac8000000b0067fac0f6cf6mr4261512iot.204.1660457212911;
        Sat, 13 Aug 2022 23:06:52 -0700 (PDT)
Received: from sophie ([68.235.43.126])
        by smtp.gmail.com with ESMTPSA id j6-20020a6bf906000000b00685a7cccd2csm2865093iog.45.2022.08.13.23.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 23:06:52 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH 1/4] memblock tests: add simulation of physical memory with multiple NUMA nodes
Date:   Sun, 14 Aug 2022 01:06:15 -0500
Message-Id: <ab425b889526c7dafc91c7591c9dde21a2b4d67f.1660454970.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1660454970.git.remckee0@gmail.com>
References: <cover.1660454970.git.remckee0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add functions setup_numa_memblock_generic() and setup_numa_memblock()
for setting up a memory layout with multiple NUMA nodes in a previously
allocated dummy physical memory. These functions can be used in place of
setup_memblock() in tests that need to simulate a NUMA system.

setup_numa_memblock_generic():
- allows for setting up a custom memory layout by specifying the amount
  of memory in each node, the number of nodes, and a factor that will be
  used to scale the memory in each node

setup_numa_memblock():
- allows for setting up a default memory layout

Introduce constant MEM_FACTOR, which is used to scale the default memory
layout based on MEM_SIZE.

Set CONFIG_NODES_SHIFT to 4 when building with NUMA=1 to allow for up to
16 NUMA nodes.

Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 .../testing/memblock/scripts/Makefile.include |  2 +-
 tools/testing/memblock/tests/common.c         | 38 +++++++++++++++++++
 tools/testing/memblock/tests/common.h         |  9 ++++-
 3 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/tools/testing/memblock/scripts/Makefile.include b/tools/testing/memblock/scripts/Makefile.include
index aa6d82d56a23..998281723590 100644
--- a/tools/testing/memblock/scripts/Makefile.include
+++ b/tools/testing/memblock/scripts/Makefile.include
@@ -3,7 +3,7 @@
 
 # Simulate CONFIG_NUMA=y
 ifeq ($(NUMA), 1)
-	CFLAGS += -D CONFIG_NUMA
+	CFLAGS += -D CONFIG_NUMA -D CONFIG_NODES_SHIFT=4
 endif
 
 # Use 32 bit physical addresses.
diff --git a/tools/testing/memblock/tests/common.c b/tools/testing/memblock/tests/common.c
index 0ca26fe12c38..179b9b4a8fc8 100644
--- a/tools/testing/memblock/tests/common.c
+++ b/tools/testing/memblock/tests/common.c
@@ -34,6 +34,10 @@ static const char * const help_opts[] = {
 
 static int verbose;
 
+static const phys_addr_t node_sizes[] = {
+	SZ_4K, SZ_1K, SZ_2K, SZ_2K, SZ_1K, SZ_1K, SZ_4K, SZ_1K
+};
+
 /* sets global variable returned by movable_node_is_enabled() stub */
 bool movable_node_enabled;
 
@@ -72,6 +76,40 @@ void setup_memblock(void)
 	fill_memblock();
 }
 
+/**
+ * setup_numa_memblock_generic:
+ * Set up a memory layout with multiple NUMA nodes in a previously allocated
+ * dummy physical memory.
+ * @nodes: an array containing the amount of memory in each node
+ * @node_cnt: the size of @nodes
+ * @factor: a factor that will be used to scale the memory in each node
+ *
+ * The nids will be set to 0 through node_cnt - 1.
+ */
+void setup_numa_memblock_generic(const phys_addr_t nodes[],
+				 int node_cnt, int factor)
+{
+	phys_addr_t base;
+	int flags;
+
+	reset_memblock_regions();
+	base = (phys_addr_t)memory_block.base;
+	flags = (movable_node_is_enabled()) ? MEMBLOCK_NONE : MEMBLOCK_HOTPLUG;
+
+	for (int i = 0; i < node_cnt; i++) {
+		phys_addr_t size = factor * nodes[i];
+
+		memblock_add_node(base, size, i, flags);
+		base += size;
+	}
+	fill_memblock();
+}
+
+void setup_numa_memblock(void)
+{
+	setup_numa_memblock_generic(node_sizes, NUMA_NODES, MEM_FACTOR);
+}
+
 void dummy_physical_memory_init(void)
 {
 	memory_block.base = malloc(MEM_SIZE);
diff --git a/tools/testing/memblock/tests/common.h b/tools/testing/memblock/tests/common.h
index a0594f1e4fe3..abd77beff06c 100644
--- a/tools/testing/memblock/tests/common.h
+++ b/tools/testing/memblock/tests/common.h
@@ -10,7 +10,11 @@
 #include <linux/printk.h>
 #include <../selftests/kselftest.h>
 
-#define MEM_SIZE SZ_16K
+#define MEM_SIZE		SZ_16K
+#define NUMA_NODES		8
+
+/* used to resize values that need to scale with MEM_SIZE */
+#define MEM_FACTOR		(MEM_SIZE / SZ_16K)
 
 enum test_flags {
 	TEST_ZEROED = 0x0,
@@ -101,6 +105,9 @@ void reset_memblock_regions(void);
 void reset_memblock_attributes(void);
 void fill_memblock(void);
 void setup_memblock(void);
+void setup_numa_memblock_generic(const phys_addr_t nodes[],
+				 int node_cnt, int factor);
+void setup_numa_memblock(void);
 void dummy_physical_memory_init(void);
 void dummy_physical_memory_cleanup(void);
 void parse_args(int argc, char **argv);
-- 
2.25.1

