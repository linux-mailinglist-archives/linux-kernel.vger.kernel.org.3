Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE81C5AC252
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 06:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbiIDEVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 00:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbiIDEV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 00:21:29 -0400
Received: from mail-oa1-x42.google.com (mail-oa1-x42.google.com [IPv6:2001:4860:4864:20::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412B74D804
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 21:21:28 -0700 (PDT)
Received: by mail-oa1-x42.google.com with SMTP id 586e51a60fabf-11f11d932a8so14596560fac.3
        for <linux-kernel@vger.kernel.org>; Sat, 03 Sep 2022 21:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=wW5p1q73OkEZN8E3EwbNVJG/rp2qE6vBkOjLbct9Gck=;
        b=fJg/LYOf8ME2lCaH6ZbuaoZqZ0dcWzcZjvzxNOMITKSYdrg2r5+w+YVwNZsykp5jfw
         +mwKcs207+yz6fjoI4oi3cj826srJ+m4jQotF8VY2Pemfwv2WanseK/cnNqTy3okNgjU
         HmIjqU3qlY90PdbSCIHecxB1b63/hoaUaT2cjLRFW7K0dFeBgqpGh9gB+ef3nrt4xWJh
         yZm7frk2BvUfr2AxwgFHlqqNneo6TbZs7Ow1Sb+UwLMOIFYTXyq3iQTBORq7LwwJLxEr
         DV7+iy4XSq1w2psSIVHEd6wH4ymcUXI1N0VF2D+TokAzvFEdQwuj6fssyXT3qUJ07sf7
         Rq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=wW5p1q73OkEZN8E3EwbNVJG/rp2qE6vBkOjLbct9Gck=;
        b=YRPxoXblqEUScJFlHCmGPVodraUsVBLoe1qDstPnffmSAu2iyJhEvVkWw/aT8Eqnjl
         ONmlc+KCMRf4WoMmRUDgyyTXTuYkLhEuwGidK7fDP8x7YBY6lIbRoSQPtniEFm0XZQVc
         b0Vj/iDxt9KTgKZQG3U95j0KFM2OtQde5BExbbtCyfMhEgrzJKrDFmxkLq4w2a9G+yyX
         d2Hr6jdnJf/Nkx1i9s25THrGYK3pQbfglDAZ9UIvJFr1OT7dKVWay5ZozAHdz5ccN5E+
         VopaALzmF6A/VQHaClYtp52yhHhnNnnY30A884YsOpdHZwdpN4k9dJqHTliqA8DmXfOz
         PiMA==
X-Gm-Message-State: ACgBeo3jWF5PXV/bobQPswcpi7yBn+g0Y5Vnzc2pEzE2a+rsMh3DSf1U
        153N+7n9Trtdm/WBjkU+WCU=
X-Google-Smtp-Source: AA6agR4t5k66gduBqA1qPjytKeqEh1n1uRB3Cou7Kfovk1xRThGzhgDl9nBjq1nfNc07HhHPYJ5cdQ==
X-Received: by 2002:aca:1809:0:b0:345:5649:95a2 with SMTP id h9-20020aca1809000000b00345564995a2mr4841351oih.45.1662265287535;
        Sat, 03 Sep 2022 21:21:27 -0700 (PDT)
Received: from sophie (static-198-54-128-109.cust.tzulo.com. [198.54.128.109])
        by smtp.gmail.com with ESMTPSA id i7-20020a056870890700b0010bf07976c9sm3485382oao.41.2022.09.03.21.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Sep 2022 21:21:27 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v4 1/4] memblock tests: add simulation of physical memory with multiple NUMA nodes
Date:   Sat,  3 Sep 2022 23:21:05 -0500
Message-Id: <49b96ce88dece5b394d5dd4332c1572da917b30a.1662264560.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1662264560.git.remckee0@gmail.com>
References: <cover.1662264560.git.remckee0@gmail.com>
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
 tools/testing/memblock/tests/common.c         | 29 +++++++++++++++++++
 tools/testing/memblock/tests/common.h         |  4 ++-
 3 files changed, 33 insertions(+), 2 deletions(-)

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
index eec6901081af..b6110df21b2a 100644
--- a/tools/testing/memblock/tests/common.c
+++ b/tools/testing/memblock/tests/common.c
@@ -72,6 +72,35 @@ void setup_memblock(void)
 	fill_memblock();
 }
 
+/**
+ * setup_numa_memblock:
+ * Set up a memory layout with multiple NUMA nodes in a previously allocated
+ * dummy physical memory.
+ * @nodes: an array containing the denominators of the fractions of MEM_SIZE
+ *         contained in each node (e.g., if nodes[0] = SZ_8, node 0 will
+ *         contain 1/8th of MEM_SIZE)
+ *
+ * The nids will be set to 0 through NUMA_NODES - 1.
+ */
+void setup_numa_memblock(const phys_addr_t nodes[])
+{
+	phys_addr_t base;
+	int flags;
+
+	reset_memblock_regions();
+	base = (phys_addr_t)memory_block.base;
+	flags = (movable_node_is_enabled()) ? MEMBLOCK_NONE : MEMBLOCK_HOTPLUG;
+
+	for (int i = 0; i < NUMA_NODES; i++) {
+		assert(nodes[i] <= MEM_SIZE && nodes[i] > 0);
+		phys_addr_t size = MEM_SIZE / nodes[i];
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
index 78128e109a95..caf01543a315 100644
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
+void setup_numa_memblock(const phys_addr_t nodes[]);
 void dummy_physical_memory_init(void);
 void dummy_physical_memory_cleanup(void);
 void parse_args(int argc, char **argv);
-- 
2.25.1

