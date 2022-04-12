Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47714FCE48
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 06:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346891AbiDLEy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 00:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbiDLEyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 00:54:55 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6E02A714;
        Mon, 11 Apr 2022 21:52:38 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id be5so9766457plb.13;
        Mon, 11 Apr 2022 21:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mPGV6fM/KyM77XwIPORSPkiAHUCvrpH9Wf2QNAPZZLY=;
        b=hJo7epnbWvijYzjtrb+zZiOV7jTIUAK1esu2Q5ogSFJumehlNN5QKWkknrtEINBBbi
         hvm8OlhMpaqCLe6Glf0jWfzTyx/cZ8C4zVSN8mC6MQWBEbl0xTumXLZsgF69ygnsRzuD
         xrhh275i+O9JrKipKvgUd3+ioZH+i30cFE9LgqhkNdUv3EJBFXc/QujBksWi6QOQGy+F
         PX8Nyw3iDMaeNMnL2QjjQgjMugBkdjd1lvqyoeGweIFjutpFgSsXZcwgg5u791ESO3vN
         oyjanf1yJp0YhWLWoSC/yXpqKwEC4Z7JGJwoU5E98drW1auzs8Q8WobN4ho+r8NbTHFK
         kj5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mPGV6fM/KyM77XwIPORSPkiAHUCvrpH9Wf2QNAPZZLY=;
        b=QtPFgJmKJ/k/wqI77M4h7TgPXpQLGG590vjvYsPjn8eCR8OEZ84RK18GR1zjCGIiK8
         bZdGlSkAXLuQNZKFuQep4C1UZliTWEu+2a1P47ACrE9KcN44f7tjE5JTccf0EHFgS8FF
         h6Ynl8aNWnz7vL7etKU+vlXULaO4L4o64SxGu76tFoIwvWVY7Wp83VigxVT9ji1uUy7c
         HpygIEDnN/ftAtOtVyX01pU7PoMk1nS8+/Wc1U9lx3IL249Jo9ChhXvVSXSJ0XKEfwnw
         fva44axsBOlZDRU8CB2Izk7E3gLMHhHNJN27/S7yPMpWArkAAU+4q4qK3s485KmICl3N
         S+7w==
X-Gm-Message-State: AOAM533llz0Do8w3w9p4J1ZP4nzvg2fjfRk96vnmPVoRM027e7C0Vr2R
        s1n/ALLF21JIERfeCea9Vbr2iVwNyqejgC3RPB4q1A==
X-Google-Smtp-Source: ABdhPJysGDycFGNQUOSiWJWktiL9BdJcpY+32UaMSp1PlFIdbCgIUYYcgPFgzuRc+vMoCeeUZFUYFw==
X-Received: by 2002:a17:90a:8595:b0:1bf:4592:a819 with SMTP id m21-20020a17090a859500b001bf4592a819mr2880237pjn.183.1649739158249;
        Mon, 11 Apr 2022 21:52:38 -0700 (PDT)
Received: from localhost.localdomain ([101.86.206.159])
        by smtp.gmail.com with ESMTPSA id s24-20020a17090a441800b001ca9b5724a6sm1070995pjg.36.2022.04.11.21.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 21:52:38 -0700 (PDT)
From:   Patrick Wang <patrick.wang.shcn@gmail.com>
To:     robh+dt@kernel.org, frowand.list@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        patrick.wang.shcn@gmail.com
Subject: [PATCH] of: fdt: do not reserve memory below MIN_MEMBLOCK_ADDR
Date:   Tue, 12 Apr 2022 12:52:28 +0800
Message-Id: <20220412045228.35306-1-patrick.wang.shcn@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Dt reserve memory without base checking, which will trigger an oops in
kmemleak when the base address is below MIN_MEMBLOCK_ADDR:

# echo scan > /sys/kernel/debug/kmemleak
[   54.888353] Unable to handle kernel paging request at virtual address ff5fffffffe00000
[   54.888932] Oops [#1]
[   54.889102] Modules linked in:
[   54.889326] CPU: 2 PID: 134 Comm: bash Not tainted 5.18.0-rc1-next-20220407 #33
[   54.889620] Hardware name: riscv-virtio,qemu (DT)
[   54.889901] epc : scan_block+0x74/0x15c
[   54.890215]  ra : scan_block+0x72/0x15c
[   54.890390] epc : ffffffff801e5806 ra : ffffffff801e5804 sp : ff200000104abc30
[   54.890607]  gp : ffffffff815cd4e8 tp : ff60000004cfa340 t0 : 0000000000000200
[   54.890835]  t1 : 00aaaaaac23954cc t2 : 00000000000003ff s0 : ff200000104abc90
[   54.891024]  s1 : ffffffff81b0ff28 a0 : 0000000000000000 a1 : ff5fffffffe01000
[   54.891201]  a2 : ffffffff81b0ff28 a3 : 0000000000000002 a4 : 0000000000000001
[   54.891377]  a5 : 0000000000000000 a6 : ff200000104abd7c a7 : 0000000000000005
[   54.891552]  s2 : ff5fffffffe00ff9 s3 : ffffffff815cd998 s4 : ffffffff815d0e90
[   54.891727]  s5 : ffffffff81b0ff28 s6 : 0000000000000020 s7 : ffffffff815d0eb0
[   54.891903]  s8 : ffffffffffffffff s9 : ff5fffffffe00000 s10: ff5fffffffe01000
[   54.892078]  s11: 0000000000000022 t3 : 00ffffffaa17db4c t4 : 000000000000000f
[   54.892271]  t5 : 0000000000000001 t6 : 0000000000000000
[   54.892408] status: 0000000000000100 badaddr: ff5fffffffe00000 cause: 000000000000000d
[   54.892643] [<ffffffff801e5a1c>] scan_gray_list+0x12e/0x1a6
[   54.892824] [<ffffffff801e5d3e>] kmemleak_scan+0x2aa/0x57e
[   54.892961] [<ffffffff801e633c>] kmemleak_write+0x32a/0x40c
[   54.893096] [<ffffffff803915ac>] full_proxy_write+0x56/0x82
[   54.893235] [<ffffffff801ef456>] vfs_write+0xa6/0x2a6
[   54.893362] [<ffffffff801ef880>] ksys_write+0x6c/0xe2
[   54.893487] [<ffffffff801ef918>] sys_write+0x22/0x2a
[   54.893609] [<ffffffff8000397c>] ret_from_syscall+0x0/0x2
[   54.894183] ---[ end trace 0000000000000000 ]---

Add base checking and ignore the range lower than MIN_MEMBLOCK_ADDR.

Signed-off-by: Patrick Wang <patrick.wang.shcn@gmail.com>
---
 drivers/of/fdt.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index ec315b060..296c4ab8e 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -33,6 +33,13 @@
 
 #include "of_private.h"
 
+#ifndef MIN_MEMBLOCK_ADDR
+#define MIN_MEMBLOCK_ADDR	__pa(PAGE_OFFSET)
+#endif
+#ifndef MAX_MEMBLOCK_ADDR
+#define MAX_MEMBLOCK_ADDR	((phys_addr_t)~0)
+#endif
+
 /*
  * of_fdt_limit_memory - limit the number of regions in the /memory node
  * @limit: maximum entries
@@ -480,6 +487,19 @@ static u32 of_fdt_crc32;
 static int __init early_init_dt_reserve_memory_arch(phys_addr_t base,
 					phys_addr_t size, bool nomap)
 {
+	const u64 phys_offset = MIN_MEMBLOCK_ADDR;
+
+	if (base < phys_offset) {
+		pr_warn("Ignoring reserved memory range 0x%llx - 0x%llx\n",
+			base, phys_offset);
+		size = (phys_offset - base) < size ?
+			size - (phys_offset - base) : 0;
+		base = phys_offset;
+
+		if (!size)
+			return -EFAULT;
+	}
+
 	if (nomap) {
 		/*
 		 * If the memory is already reserved (by another region), we
@@ -1198,13 +1218,6 @@ int __init early_init_dt_scan_chosen(char *cmdline)
 	return 0;
 }
 
-#ifndef MIN_MEMBLOCK_ADDR
-#define MIN_MEMBLOCK_ADDR	__pa(PAGE_OFFSET)
-#endif
-#ifndef MAX_MEMBLOCK_ADDR
-#define MAX_MEMBLOCK_ADDR	((phys_addr_t)~0)
-#endif
-
 void __init __weak early_init_dt_add_memory_arch(u64 base, u64 size)
 {
 	const u64 phys_offset = MIN_MEMBLOCK_ADDR;
-- 
2.25.1

