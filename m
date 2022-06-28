Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E8B55E3B2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345920AbiF1Mqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345919AbiF1Mqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:46:32 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED24C23BCD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 05:46:30 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id m14so10982346plg.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 05:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=715HAh+gaqfIa4Kb1ioduoLaMYUWMYMaYysEaJLHKcE=;
        b=CelmbGOKMV6GkiEp4VrISq41OvUgSlP818ECLmYKz+GIjFmczsZvD/Kg23EdF+D1rh
         5CVyrJe7KlFcIbLxcmpYp6hRsJZMSsofEiz8xBNLNyie3T5BNFIH4MSifHUb4kZyPeIT
         LsPqPtT3itouJ5QpGLWBcrzUmiqbMXwDN1nhhrYcrcXFfHwHBpVJ+mrqhggtNK19/XNV
         Z0M1/pn5SPbjX4PkBm0Xux8o9k11Amfkm7i2TswLQr8OVE46qWG4nx+lD0rJab7/DDjt
         XdjGNyRLFD3UEp262uHJDwH5wPKcKt4RzXOImiHoshEveHgev+AJQKS19KMhAWIvBHE5
         7TJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=715HAh+gaqfIa4Kb1ioduoLaMYUWMYMaYysEaJLHKcE=;
        b=BcQQjeCP+pLJFlWSfgv/ID59FFR8SCu2Fu3coPGbemy8+joQMjcFj/3ysWhiA4BoCe
         xzRoV6Zdqj5lEk4R8hVF6m+wAWBvv6IyrZ7KvKqIz1K2HhLo0a4TmhhMX366F2kRLaVY
         Yc5Skz1SaqpHQ68FHGFU5ZHojrWP0am2pg4FVOJGJjZgggc9BvHsqqkqCWKtrtdyIto+
         pX4b8pHeCNELuv4eXCWdFG719amLHP2gK+BMjkgPa1Qfgk914D8yCjxnwxsJxmrJ7uPK
         AdBFBCfSVPAvWOw06epHmbtirf8T+FUMqB9m7DX0WMYmiWYXf0hX9TWNnhJWUUJlGyHT
         WOQg==
X-Gm-Message-State: AJIora/11AjMyWIlDLvOME57UIZnok35rABQDWyJatVmPZJ+CtJhSeke
        nw9O6rYd/k6vl7bjzAz6/f9vMA==
X-Google-Smtp-Source: AGRyM1voYmbeQ1MR2tSvuisZXplLREXb9RkvvSLXIe4vLZqkD1GQG3w1pjl/UioIlRG3Q+hyGTRKcA==
X-Received: by 2002:a17:902:ea0d:b0:16a:68f6:f381 with SMTP id s13-20020a170902ea0d00b0016a68f6f381mr3465407plg.145.1656420390387;
        Tue, 28 Jun 2022 05:46:30 -0700 (PDT)
Received: from MacBook-Pro.local.net ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id v187-20020a6261c4000000b005255f5d8f9fsm9400295pfb.112.2022.06.28.05.46.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jun 2022 05:46:30 -0700 (PDT)
From:   lizhe.67@bytedance.com
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Cc:     lizefan.x@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, lizhe.67@bytedance.com
Subject: [RFC v2] memmap: introduce cmdline parameter "memmap=nn[KMG]$" without start addr
Date:   Tue, 28 Jun 2022 20:45:29 +0800
Message-Id: <20220628124529.15431-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Zhe <lizhe.67@bytedance.com>

In current kernel we can use memmap=nn[KMG]$ss[KMG] to reserve an
area of memory for userspace usage through /dev/mem. We have to
determine the start addr and length. In our scenario, we need
reserve or alloc large continuous physical memory at least 256M in
512G's machine, and need reserve more memory in larger machine, at
just boot phase for a userspace program. And these memories will not
be freed to system before system reboot. The userspace program can
use the memory through /dev/mem to store some data. Besides, a
hardware will need the data stored by the userspace program to do
it's job. Why we need continuous memory is that the hardware can
only access memory without mmu. So allocing an area of large
continuous physical memory for userspace is the best way for us.
Considering that we have several types of machine with different
memory specifications, we want an easy way to reserve memory with
only one size parameter.

This patch introduce a cmdline parameter "memmap=nn[KMG]$". It is
an extension of "memmap=nn[KMG]$ss[KMG]". We don't need to input
the start addr. Kernel will reserve a suitable area of memory for
us. We can get the area from /proc/iomem with the key word "Reserved
Random" and access the memory through /dev/mem. Notice that we need
"$" in our cmdline parameter or it will be confused with
memmap=nn[KMG]@ss[KMG].

Changes from v1
(https://lore.kernel.org/lkml/20220623062402.12392-1-lizhe.67@bytedance.com/)
- Rename the region from "Memmap Alloc" to "Reserved Random"
- add "Reserved Random" region into e820 table
- add a new e820_type "E820_TYPE_RESERVED_RANDOM"

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 .../admin-guide/kernel-parameters.txt         |  7 ++++
 arch/x86/include/asm/e820/api.h               |  1 +
 arch/x86/include/asm/e820/types.h             |  7 ++++
 arch/x86/kernel/e820.c                        | 41 +++++++++++++++++--
 arch/x86/kernel/setup.c                       |  1 +
 5 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2522b11e593f..9c1b7ad39523 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3022,6 +3022,13 @@
 			         memmap=64K$0x18690000
 			         or
 			         memmap=0x10000$0x18690000
+			[KNL, X86] If ss[KMG] is omitted, kernel will reserve a
+			suitable area of memory for us. We can find the area from
+			/proc/iomem with key word "Reserved Random".
+			Example: Exclude memory with size 0x10000
+					 memmap=64K$
+					 or
+					 memmap=0x10000$
 			Some bootloaders may need an escape character before '$',
 			like Grub2, otherwise '$' and the following number
 			will be eaten.
diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/api.h
index e8f58ddd06d9..6fd959737396 100644
--- a/arch/x86/include/asm/e820/api.h
+++ b/arch/x86/include/asm/e820/api.h
@@ -30,6 +30,7 @@ extern void e820__memblock_setup(void);
 
 extern void e820__reserve_setup_data(void);
 extern void e820__finish_early_params(void);
+extern void e820__add_reserve_random(void);
 extern void e820__reserve_resources(void);
 extern void e820__reserve_resources_late(void);
 
diff --git a/arch/x86/include/asm/e820/types.h b/arch/x86/include/asm/e820/types.h
index 314f75d886d0..577be1222b94 100644
--- a/arch/x86/include/asm/e820/types.h
+++ b/arch/x86/include/asm/e820/types.h
@@ -15,6 +15,13 @@ enum e820_type {
 	E820_TYPE_UNUSABLE	= 5,
 	E820_TYPE_PMEM		= 7,
 
+	/*
+	 * This type is used for cmdline "memmap=size$" to reserve
+	 * an area of memory that user do not need to input start
+	 * addr.
+	 */
+	E820_TYPE_RESERVED_RANDOM = 8,
+
 	/*
 	 * This is a non-standardized way to represent ADR or
 	 * NVDIMM regions that persist over a reboot.
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index f267205f2d5a..aecb1b6bb3c0 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -64,6 +64,8 @@ struct e820_table *e820_table __refdata			= &e820_table_init;
 struct e820_table *e820_table_kexec __refdata		= &e820_table_kexec_init;
 struct e820_table *e820_table_firmware __refdata	= &e820_table_firmware_init;
 
+static u64 memmap_random_size __initdata;
+
 /* For PCI or other memory-mapped resources */
 unsigned long pci_mem_start = 0xaeedbabe;
 #ifdef CONFIG_PCI
@@ -189,7 +191,8 @@ static void __init e820_print_type(enum e820_type type)
 	switch (type) {
 	case E820_TYPE_RAM:		/* Fall through: */
 	case E820_TYPE_RESERVED_KERN:	pr_cont("usable");			break;
-	case E820_TYPE_RESERVED:	pr_cont("reserved");			break;
+	case E820_TYPE_RESERVED:    /* Fall through: */
+	case E820_TYPE_RESERVED_RANDOM: pr_cont("reserved");            break;
 	case E820_TYPE_SOFT_RESERVED:	pr_cont("soft reserved");		break;
 	case E820_TYPE_ACPI:		pr_cont("ACPI data");			break;
 	case E820_TYPE_NVS:		pr_cont("ACPI NVS");			break;
@@ -942,8 +945,22 @@ static int __init parse_memmap_one(char *p)
 		start_at = memparse(p+1, &p);
 		e820__range_add(start_at, mem_size, E820_TYPE_ACPI);
 	} else if (*p == '$') {
-		start_at = memparse(p+1, &p);
-		e820__range_add(start_at, mem_size, E820_TYPE_RESERVED);
+		if (*(p+1) == '\0') {
+			/*
+			 * In the case we just want to reserve memory with size
+			 * 'mem_size' and don't care where it start, we get '\0'
+			 * here.
+			 */
+			p++;
+			if (IS_ALIGNED(mem_size, PAGE_SIZE))
+				memmap_random_size = mem_size;
+			else
+				pr_err("Reserve Random should input with size aligned to 0x%lx\n",
+						PAGE_SIZE);
+		} else {
+			start_at = memparse(p+1, &p);
+			e820__range_add(start_at, mem_size, E820_TYPE_RESERVED);
+		}
 	} else if (*p == '!') {
 		start_at = memparse(p+1, &p);
 		e820__range_add(start_at, mem_size, E820_TYPE_PRAM);
@@ -1082,6 +1099,7 @@ static const char *__init e820_type_to_string(struct e820_entry *entry)
 	case E820_TYPE_PRAM:		return "Persistent Memory (legacy)";
 	case E820_TYPE_PMEM:		return "Persistent Memory";
 	case E820_TYPE_RESERVED:	return "Reserved";
+	case E820_TYPE_RESERVED_RANDOM: return "Reserved Random";
 	case E820_TYPE_SOFT_RESERVED:	return "Soft Reserved";
 	default:			return "Unknown E820 type";
 	}
@@ -1110,7 +1128,8 @@ static unsigned long __init e820_type_to_iores_desc(struct e820_entry *entry)
 	case E820_TYPE_NVS:		return IORES_DESC_ACPI_NV_STORAGE;
 	case E820_TYPE_PMEM:		return IORES_DESC_PERSISTENT_MEMORY;
 	case E820_TYPE_PRAM:		return IORES_DESC_PERSISTENT_MEMORY_LEGACY;
-	case E820_TYPE_RESERVED:	return IORES_DESC_RESERVED;
+	case E820_TYPE_RESERVED:    /* Fall-through: */
+	case E820_TYPE_RESERVED_RANDOM: return IORES_DESC_RESERVED;
 	case E820_TYPE_SOFT_RESERVED:	return IORES_DESC_SOFT_RESERVED;
 	case E820_TYPE_RESERVED_KERN:	/* Fall-through: */
 	case E820_TYPE_RAM:		/* Fall-through: */
@@ -1131,6 +1150,7 @@ static bool __init do_mark_busy(enum e820_type type, struct resource *res)
 	 */
 	switch (type) {
 	case E820_TYPE_RESERVED:
+	case E820_TYPE_RESERVED_RANDOM:
 	case E820_TYPE_SOFT_RESERVED:
 	case E820_TYPE_PRAM:
 	case E820_TYPE_PMEM:
@@ -1145,6 +1165,19 @@ static bool __init do_mark_busy(enum e820_type type, struct resource *res)
 	}
 }
 
+void __init e820__add_reserve_random(void)
+{
+	if (memmap_random_size) {
+		phys_addr_t start_at =
+			memblock_phys_alloc(memmap_random_size, PAGE_SIZE);
+		if (start_at == 0)
+			pr_err("cannot find suitable location for memmap\n");
+		else
+			e820__range_update(start_at, memmap_random_size,
+				E820_TYPE_RAM, E820_TYPE_RESERVED_RANDOM);
+	}
+}
+
 /*
  * Mark E820 reserved areas as busy for the resource manager:
  */
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index bd6c6fd373ae..5b5ac40fc720 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1223,6 +1223,7 @@ void __init setup_arch(char **cmdline_p)
 
 	x86_init.hyper.guest_late_init();
 
+	e820__add_reserve_random();
 	e820__reserve_resources();
 	e820__register_nosave_regions(max_pfn);
 
-- 
2.20.1

