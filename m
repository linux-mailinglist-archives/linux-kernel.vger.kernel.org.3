Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF3F565804
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbiGDN7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbiGDN7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:59:00 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6D4959E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 06:58:53 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id 126so9051681vsq.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 06:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=erdqpZYLja6xDuoUNWXMJOEwQp9qkWbhvYqoJ4co3Os=;
        b=V55waJR1QuKM8kC/rFEuxJwFmNLdmPKax7+zW9/siL7Mj36HUtopitwFYdMlAFbeEs
         rJWfeTLZaAEsZjfihwA9mJ7xH9DS6H9oWLlqTnMtLoS/+23JMDhQ3IeR7ap5oaFtTKxK
         Y+I83AZEsaJ4Ay6DnahMYHrQ3Gb04a7ON/+7oqwxrHjP8z+A6KzcYQNYXByQHkOWPqg2
         FMPJkOHXrsJy7Eom5pARQ4bPJtkhaMhDPV5VhmeydbYuyBO61FHK10EdQ0vYkxE/OsLv
         t0rVB5AnOjfnQIbOlZIGo+FUsNZbVLhmEYJK9HYBt89yoXq1Mt6q8egiAwbnhj3Hep95
         8kTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=erdqpZYLja6xDuoUNWXMJOEwQp9qkWbhvYqoJ4co3Os=;
        b=eaJLsDqtU7DSsljvM3XSL+jBe0W1PMF/NMPykLsAN4H1+l5NrGpv7ZXj8C1matt0SP
         Uby3xfHtgSm87YwlZQjLoKVwoWw8kt1N3iWME19qYcGHAESza3ez9pyn6qS6g6GicIAS
         vAZwgShgMUyh0ZeljzVzSTKtdJMSaIDfQNWGOY0xa8b2GJXuinWrwu92YDQx6ADW4RFw
         KX4NnkISJ7nK4+uEPktCzNpyk/BBc1ChhpIHfE0pN9FlAmIUHn6qXtXkcNd32/+ePo69
         YRYmfwo5WTksNsAwyNF7O09CtsQkTu98h2a0sEq/SvKUnmQBvtJny+lxjjwnbtiO6/g4
         ewXQ==
X-Gm-Message-State: AJIora/dT/24Gfu/97CNkZVSHp2YE0DwRVy5Ql6hHeSRb7kqm0/3xe1n
        yqkoTey/Lma8u9PWR/UImotlYLaBsEpZreZ2Jvc3Bqzud56JLUhh5c9cU7rbcEKyMCAlbE4g1y8
        LUCwOSaCmi9SqYuhOXGHpbsK2/fisCuwJThkfJFJdEtn2lXbuNKi7WOQJeEkf4wLoT2IzD/yrVZ
        CjNOGVsRPyBdkpuAGM/1k=
X-Google-Smtp-Source: AGRyM1uu2u3rbg5Giv2gmMbrQfmLY/m5Z5qJo0bY5VChxGRJJIApXm7e/0jrs7sHJbYJu65GFpqcqw==
X-Received: by 2002:a67:43c4:0:b0:354:49cf:f663 with SMTP id q187-20020a6743c4000000b0035449cff663mr16345113vsa.38.1656943132140;
        Mon, 04 Jul 2022 06:58:52 -0700 (PDT)
Received: from localhost ([181.97.174.128])
        by smtp.gmail.com with ESMTPSA id v16-20020a056102303000b0035609fbb1a9sm3567826vsa.1.2022.07.04.06.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 06:58:51 -0700 (PDT)
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
To:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com, keescook@chromium.org,
        Martin Fernandez <martin.fernandez@eclypsium.com>
Subject: [PATCH v9 1/9] mm/memblock: Tag memblocks with crypto capabilities
Date:   Mon,  4 Jul 2022 10:58:25 -0300
Message-Id: <20220704135833.1496303-2-martin.fernandez@eclypsium.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220704135833.1496303-1-martin.fernandez@eclypsium.com>
References: <20220704135833.1496303-1-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the capability to mark regions of the memory memory_type able of
hardware memory encryption.

Also add the capability to query if all regions of a memory node are
able to do hardware memory encryption to call it when initializing the
nodes. Warn the user if a node has both encryptable and
non-encryptable regions.

Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
---
 include/linux/memblock.h |  5 ++++
 mm/memblock.c            | 62 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 50ad19662a32..00c4f1a20335 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -40,6 +40,7 @@ extern unsigned long long max_possible_pfn;
  * via a driver, and never indicated in the firmware-provided memory map as
  * system RAM. This corresponds to IORESOURCE_SYSRAM_DRIVER_MANAGED in the
  * kernel resource tree.
+ * @MEMBLOCK_CRYPTO_CAPABLE: capable of hardware encryption
  */
 enum memblock_flags {
 	MEMBLOCK_NONE		= 0x0,	/* No special request */
@@ -47,6 +48,7 @@ enum memblock_flags {
 	MEMBLOCK_MIRROR		= 0x2,	/* mirrored region */
 	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
 	MEMBLOCK_DRIVER_MANAGED = 0x8,	/* always detected via a driver */
+	MEMBLOCK_CRYPTO_CAPABLE = 0x10,	/* capable of hardware encryption */
 };
 
 /**
@@ -120,6 +122,9 @@ int memblock_physmem_add(phys_addr_t base, phys_addr_t size);
 void memblock_trim_memory(phys_addr_t align);
 bool memblock_overlaps_region(struct memblock_type *type,
 			      phys_addr_t base, phys_addr_t size);
+bool memblock_node_is_crypto_capable(int nid);
+int memblock_mark_crypto_capable(phys_addr_t base, phys_addr_t size);
+int memblock_clear_crypto_capable(phys_addr_t base, phys_addr_t size);
 int memblock_mark_hotplug(phys_addr_t base, phys_addr_t size);
 int memblock_clear_hotplug(phys_addr_t base, phys_addr_t size);
 int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
diff --git a/mm/memblock.c b/mm/memblock.c
index e4f03a6e8e56..d6399835b155 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -191,6 +191,40 @@ bool __init_memblock memblock_overlaps_region(struct memblock_type *type,
 	return i < type->cnt;
 }
 
+/**
+ * memblock_node_is_crypto_capable - get if whole node is capable
+ * of encryption
+ * @nid: number of node
+ *
+ * Iterate over all memory memblock_type and find if all regions under
+ * node @nid are capable of hardware encryption.
+ *
+ * Return:
+ * true if every region in @nid is capable of encryption, false
+ * otherwise.
+ */
+bool __init_memblock memblock_node_is_crypto_capable(int nid)
+{
+	struct memblock_region *region;
+	int crypto_capables = 0;
+	int not_crypto_capables = 0;
+
+	for_each_mem_region(region) {
+		if (memblock_get_region_node(region) == nid) {
+			if (region->flags & MEMBLOCK_CRYPTO_CAPABLE)
+				crypto_capables++;
+			else
+				not_crypto_capables++;
+		}
+	}
+
+	if (crypto_capables > 0 && not_crypto_capables > 0)
+		pr_warn("Node %d has %d regions that are encryptable and %d regions that aren't",
+			nid, not_crypto_capables, crypto_capables);
+
+	return crypto_capables > 0 && not_crypto_capables == 0;
+}
+
 /**
  * __memblock_find_range_bottom_up - find free area utility in bottom-up
  * @start: start of candidate range
@@ -891,6 +925,34 @@ static int __init_memblock memblock_setclr_flag(phys_addr_t base,
 	return 0;
 }
 
+/**
+ * memblock_mark_crypto_capable - Mark memory regions capable of hardware
+ * encryption with flag MEMBLOCK_CRYPTO_CAPABLE.
+ * @base: the base phys addr of the region
+ * @size: the size of the region
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int __init_memblock memblock_mark_crypto_capable(phys_addr_t base,
+						 phys_addr_t size)
+{
+	return memblock_setclr_flag(base, size, 1, MEMBLOCK_CRYPTO_CAPABLE);
+}
+
+/**
+ * memblock_clear_crypto_capable - Clear flag MEMBLOCK_CRYPTO for a
+ * specified region.
+ * @base: the base phys addr of the region
+ * @size: the size of the region
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int __init_memblock memblock_clear_crypto_capable(phys_addr_t base,
+						  phys_addr_t size)
+{
+	return memblock_setclr_flag(base, size, 0, MEMBLOCK_CRYPTO_CAPABLE);
+}
+
 /**
  * memblock_mark_hotplug - Mark hotpluggable memory with flag MEMBLOCK_HOTPLUG.
  * @base: the base phys addr of the region
-- 
2.30.2

