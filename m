Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5845B2DB5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 06:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiIIErp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 00:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiIIEre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 00:47:34 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D288C115CD5
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 21:47:31 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id s14so724037plr.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 21:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=BgevpXCXyJRdHIavWwf0+sCtJ11OZoQmWFH5Zljj9zk=;
        b=e52TqdnsTZ29PNbWzDy1byVkFEAN2+wryaW0zj8qb6JBaKCnDi3Rkee5B5kd5pRT2W
         aDvzdm+TL6vcW2RHpdLKUiEn/cTT9jUdgJUhlJO3eeBZi6C64i3XOXaE3ZegoJR5pL5x
         VjI3MX0Mez+7h3rbkY1YKquOlER0qFe1FPDuHupwtRTh+egxL8SIcohRex/QurMlS1Et
         CD3U5KpM26plk1XVeXipFm6JMmv+xxr965gy36DmWKB2G+AyOxC4sqWFbi808I8RoPn2
         k6pRms5oY69rj06VFz1MwtlTFRxVfe7/kaGdztzol0JYjFOCtv62uMFaJ3ViHoofdYCI
         DLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=BgevpXCXyJRdHIavWwf0+sCtJ11OZoQmWFH5Zljj9zk=;
        b=FXZwiBAxywa+rk8YksR/F7/F3FrsUjg87ZoGDWi+FNeSDAPBp+WAG5OKMBR2e66XW6
         fZ8qr1ESNwqhDoHiCNE3W7tz8bSC5HWEPFEOGrcDSWwXFgv/I99GNBp4lR/jWE6hWu+v
         gnoj9lP2sOLsQYATaUVbSPQ4N9rTWpEsTXwZ7AAaKz57NRa4UxVU/RG+CYvne9Mz2Tw4
         Vvt/ernev6Pt9WSq3bQK3VJBmrXf+WlUDyx24/BT4vXkKNDEdocNxxiVvCS8NQoT5TVv
         8X9RBSe4uq8iUV1nD5Xu0qBr6p/6ya53Enabk3wbmQcUGEdpPdLXlElbb75LThpv0/Mb
         zRKg==
X-Gm-Message-State: ACgBeo2sLyOvtRPAKEL8nKwarV8j86walKZcJFrKqFusvSQsqFr6Taum
        L8ArMjSacAMGvGUbfx5fkHg=
X-Google-Smtp-Source: AA6agR7O8Tn/2Xmm79PQwyuwJkxhmBYzy4MCkEDP4P8NrwazRLvhzQ+pwu1HZkNVYH7QoqWhiVl8Kw==
X-Received: by 2002:a17:902:d4c4:b0:170:9fdb:4a2a with SMTP id o4-20020a170902d4c400b001709fdb4a2amr11488677plg.137.1662698851059;
        Thu, 08 Sep 2022 21:47:31 -0700 (PDT)
Received: from sophie ([89.46.114.153])
        by smtp.gmail.com with ESMTPSA id e11-20020a170902784b00b00176c891c893sm387556pln.131.2022.09.08.21.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 21:47:30 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v5 1/4] memblock tests: add simulation of physical memory with multiple NUMA nodes
Date:   Thu,  8 Sep 2022 23:46:42 -0500
Message-Id: <5ac0e2f8d6b6cb985e2d6f308edeec2b699ecbea.1662698159.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1662698159.git.remckee0@gmail.com>
References: <cover.1662698159.git.remckee0@gmail.com>
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

Add function setup_numa_memblock() for setting up a memory layout with
multiple NUMA nodes in a previously allocated dummy physical memory.
This function can be used in place of setup_memblock() in tests that need
to simulate a NUMA system.

setup_numa_memblock():
- allows for setting up a memory layout by specifying the fraction of
  MEM_SIZE in each node

Set CONFIG_NODES_SHIFT to 4 when building with NUMA=1 to allow for up to
16 NUMA nodes.

Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 .../testing/memblock/scripts/Makefile.include |  2 +-
 tools/testing/memblock/tests/common.c         | 31 +++++++++++++++++++
 tools/testing/memblock/tests/common.h         |  4 ++-
 3 files changed, 35 insertions(+), 2 deletions(-)

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
index eec6901081af..9d9ad7df298b 100644
--- a/tools/testing/memblock/tests/common.c
+++ b/tools/testing/memblock/tests/common.c
@@ -9,6 +9,7 @@
 #define INIT_MEMBLOCK_RESERVED_REGIONS		INIT_MEMBLOCK_REGIONS
 #define PREFIXES_MAX				15
 #define DELIM					": "
+#define BASIS					10000
 
 static struct test_memory memory_block;
 static const char __maybe_unused *prefixes[PREFIXES_MAX];
@@ -72,6 +73,36 @@ void setup_memblock(void)
 	fill_memblock();
 }
 
+/**
+ * setup_numa_memblock:
+ * Set up a memory layout with multiple NUMA nodes in a previously allocated
+ * dummy physical memory.
+ * @node_fracs: an array representing the fraction of MEM_SIZE contained in
+ *              each node in basis point units (one hundredth of 1% or 1/10000).
+ *              For example, if node 0 should contain 1/8 of MEM_SIZE,
+ *              node_fracs[0] = 1250.
+ *
+ * The nids will be set to 0 through NUMA_NODES - 1.
+ */
+void setup_numa_memblock(const int node_fracs[])
+{
+	phys_addr_t base;
+	int flags;
+
+	reset_memblock_regions();
+	base = (phys_addr_t)memory_block.base;
+	flags = (movable_node_is_enabled()) ? MEMBLOCK_NONE : MEMBLOCK_HOTPLUG;
+
+	for (int i = 0; i < NUMA_NODES; i++) {
+		assert(node_fracs[i] <= BASIS && node_fracs[i] > 0);
+		phys_addr_t size = MEM_SIZE * node_fracs[i] / BASIS;
+
+		memblock_add_node(base, size, i, flags);
+		base += size;
+	}
+	fill_memblock();
+}
+
 void dummy_physical_memory_init(void)
 {
 	memory_block.base = malloc(MEM_SIZE);
diff --git a/tools/testing/memblock/tests/common.h b/tools/testing/memblock/tests/common.h
index 78128e109a95..f87ca5b3638e 100644
--- a/tools/testing/memblock/tests/common.h
+++ b/tools/testing/memblock/tests/common.h
@@ -10,7 +10,8 @@
 #include <linux/printk.h>
 #include <../selftests/kselftest.h>
 
-#define MEM_SIZE SZ_16K
+#define MEM_SIZE		SZ_16K
+#define NUMA_NODES		8
 
 enum test_flags {
 	/* No special request. */
@@ -102,6 +103,7 @@ struct region {
 void reset_memblock_regions(void);
 void reset_memblock_attributes(void);
 void setup_memblock(void);
+void setup_numa_memblock(const int node_fracs[]);
 void dummy_physical_memory_init(void);
 void dummy_physical_memory_cleanup(void);
 void parse_args(int argc, char **argv);
-- 
2.25.1

