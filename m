Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4FF5A34EC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 07:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbiH0FxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 01:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiH0FxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 01:53:15 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4933BB2759
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 22:53:14 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id pm13so3383676pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 22:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=3vruw+02EGohl42JHnb+fQiaZ/J0kK4j56/PwARaSrI=;
        b=XDY4JN0TIQ6PZiqGlGCb8faE581BDPjXvnf//IEDm2giRScDsLN5tWyFRb3Zfkwo3A
         +3fSaZ7XLaA6ILMIe587iiyXphzGzBEHCs79EnCCyA7zUfQ2aai+H76tQCO+aPbYlhKC
         lHHuFuGTKIowEaXqIErCxihk7rm8+m4VVbOlrXfUkAOIiz30xSNVO89S/q3DxNDZNT7s
         Qmv79zCIkq3cOA6zUV9VB+yE0ZwKp7gSJHMjzZQKXxnTQfjHicgd2Raxxodz80Mm/TJ4
         gwsou8eXbff9t8MCodfipaKxhM77DmM6Ok2Cfq+sHQ25+upFVY81wj9zWQuinpVZwYmT
         4/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=3vruw+02EGohl42JHnb+fQiaZ/J0kK4j56/PwARaSrI=;
        b=S19IBpoz2Kei20lAdPtZu9qWXglGr5IX0aYLV1H5uMhfobfJm4Q2nMwvbEV7T3j1i/
         ulrlpOPc9daphk69DLTl5u74geoiZZZeyORaN7M8GC1DPX8lA2HHbne8P6DG155FwTuu
         04Q2qxUzCTMv9oQbhLDrN5aOF8q9g5bX9DLIkNqDOnjT0ZBY+8ixb7kp+lMMdEqOVHI3
         h2uhnwFqkEWpKx9eyNiXAvxhtWmFN8LVglolYB1Z6zLKDEVjdpJxpCWNRnksZfm0KDCd
         sekPzdgzrImagfPW773SIYzXMinj8ivg2OpkVNDNsEXVbe544J1sjruNCfQCwxLRmwCR
         B1eQ==
X-Gm-Message-State: ACgBeo2hRk70Grsi4Dpp/OWmjHROJrOutkxBae4IOC9PJ6mZf4wUCwWA
        XZ+f87cpfT0Quo8ZJHowMIg=
X-Google-Smtp-Source: AA6agR7IkPeo3iHneHscPJnpE5D/O/PB/E2II2/9eKWUySXs9hbJpFZCHifQkTsC8G6hlWbp/irm0A==
X-Received: by 2002:a17:903:244c:b0:171:55cf:a930 with SMTP id l12-20020a170903244c00b0017155cfa930mr6889557pls.35.1661579593650;
        Fri, 26 Aug 2022 22:53:13 -0700 (PDT)
Received: from sophie ([89.46.114.37])
        by smtp.gmail.com with ESMTPSA id p125-20020a62d083000000b00537e40747b0sm944012pfg.42.2022.08.26.22.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 22:53:13 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v3 1/4] memblock tests: add simulation of physical memory with multiple NUMA nodes
Date:   Sat, 27 Aug 2022 00:52:59 -0500
Message-Id: <25b727327d365a435cc1c56c10fb96cd71b6898a.1661578435.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1661578435.git.remckee0@gmail.com>
References: <cover.1661578435.git.remckee0@gmail.com>
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
index eec6901081af..15d8767dc70c 100644
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
index 78128e109a95..2a17453107dc 100644
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
 	/* No special request. */
@@ -102,6 +106,9 @@ struct region {
 void reset_memblock_regions(void);
 void reset_memblock_attributes(void);
 void setup_memblock(void);
+void setup_numa_memblock_generic(const phys_addr_t nodes[],
+				 int node_cnt, int factor);
+void setup_numa_memblock(void);
 void dummy_physical_memory_init(void);
 void dummy_physical_memory_cleanup(void);
 void parse_args(int argc, char **argv);
-- 
2.25.1

