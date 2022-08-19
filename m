Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2418759989F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347978AbiHSJKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 05:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347975AbiHSJKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 05:10:04 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF23F14DC
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 02:10:03 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id a4so2882286qto.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 02:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=2z0FzeFb0sFurgTQB3OFi4LJtDp72dKYIdEv0EoSLB0=;
        b=gOjMhoM+81Tf0KMrOOhrqnacshHYdirV3D7iBKZn5xNxwWUEiQKNnoC/09C3xJeZJD
         OANCu1KLBk5xqH4x7OEge3VSzxyrbCN9enO1YCk6j474gET6/4NeqxEvJmpbJ9yheeuL
         0ib6fzOVcjkiztbJ/xZ4EuDKRtxfdXNpOB80oxyIN+utjsBBZLPFOf+pWvkR2EJaFi2A
         Z2bTvQE24nr7WuhK8KOlRrXrhByMAsTAH+fkg75VLWax38j8opYNYZRK5px31hCMmQdO
         ctB2LQNvyM9g/6iHOdR02kO7epICj9DdrPK9pxVv1PGlVfuTiF/6BTPhwtzPl7hiPKAu
         jdEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=2z0FzeFb0sFurgTQB3OFi4LJtDp72dKYIdEv0EoSLB0=;
        b=hrVmJXmQcD534oukLSb881kmkSJE2Y/LiM7tJxVq0WvUBm3mncqt/AlaLcvPCDXXs0
         9HSqdKr+EvETd3JefqxGrlPVzmtbO2CUe3Yvwy58m5CqvC10eGtuVUBScrrUsc9FB4Sg
         9hFPTHMsP20xQPy6CPN9nWtpywKCuKrKQdgTT9RP3Cu+RBuFYmUxtKsp8NMD6vn7oqyL
         UilM7fPWxjLWdBjYfQun7FLca8Qy3ZpzwNzQYUf2J0Bjh1HPQjFf1aJDenOIGc3tB7xl
         btH7hGT1An+pJIYvP0GsthcuBVoz6QexeIw1OQRXf/FGYP7vF+la64R+2aTNiXhndC8b
         ozww==
X-Gm-Message-State: ACgBeo0UhDXgHBANmezuqn+/mLtkVw68uc0Cuf6cgF7eydLfHFfV/K+T
        g0Zjg1Xr34XcNwjgpm+Au4E=
X-Google-Smtp-Source: AA6agR6AxIlBI3ibgp9VwsAzdSnR0jpMpVkwwL0Z/sWHdrBUOGmGm6JpJeTx6+3bfVrLhyG4Z5VJiA==
X-Received: by 2002:a05:622a:1055:b0:344:9748:493f with SMTP id f21-20020a05622a105500b003449748493fmr3983395qte.190.1660900202518;
        Fri, 19 Aug 2022 02:10:02 -0700 (PDT)
Received: from sophie ([89.46.62.64])
        by smtp.gmail.com with ESMTPSA id r25-20020ae9d619000000b006bb2f555ba4sm3215017qkk.41.2022.08.19.02.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 02:10:02 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v2 1/4] memblock tests: add simulation of physical memory with multiple NUMA nodes
Date:   Fri, 19 Aug 2022 02:05:31 -0700
Message-Id: <0cfb3c69ba6ca9ff55e1fc2528d18d108416ba57.1660897864.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1660897864.git.remckee0@gmail.com>
References: <cover.1660897864.git.remckee0@gmail.com>
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
index 4fd3534ff955..e5117d959d6c 100644
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
@@ -100,6 +104,9 @@ struct region {
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

