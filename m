Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4DCC46947B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 11:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241950AbhLFK65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 05:58:57 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:46064
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241946AbhLFK64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 05:58:56 -0500
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EEAEA3F1F0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 10:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638788126;
        bh=fBYZyvFhkAhfEVEwW97Oqj/gTwgmisupm0BTu4ieBtI=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=XDfI6ZcYKA8ytpfCdmWETMwRWyj1FAMxdFe4gT155h3KZPsSRZSQKdb+REQmPxFGJ
         S9RRlFE3Uv2y5cOQL3ViSa8XxhVE+jOesn4/Iju0VdDTR3m3BVRzKlj2+1HDHfUQ68
         sCjtLxIPibh3XTuTcGOm7DIYF+Y3YfwFefd+34VuUn5YfzZx0sWYSqdUrtAovRsRQh
         CD0vZzvILebS4SOU/kEB+3q63haVhgVOThxoFm6VotMOTfpAKEWE6dySdST3Lp0HIi
         sM0J8YRd5Q1QcWX2m3USyKbJwGqqABN7cyA6i27P7aBkjWDH6FM2oKdummLHtGhcnf
         RlxknOfzLCHbw==
Received: by mail-wm1-f69.google.com with SMTP id ay17-20020a05600c1e1100b0033f27b76819so5899192wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 02:55:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fBYZyvFhkAhfEVEwW97Oqj/gTwgmisupm0BTu4ieBtI=;
        b=KqNbCqc42xhYMQcgqP/IRnLG5Xqm7sAg6IXc69e1eAs7we0yvQxRsrK7kUcCGmUBJW
         m5xmsrsGofPsi/7SqCQHJwn2Jz4hLLr5Rw6T5dprX4z6Ufinc2WPamfaBfIpWQO0O/7h
         rDQrtIZO3Ow0aUR9KFsIUH24EObTIBP7QqJW5Yj0zpz3y0L6mVzN3tJWfI5R0aQn93EQ
         tS6F96KELmWQoIupMEU6PbCjC/cgNi0DWVKBAcK18MBVnKElyMwlNCibnJda6s5CmP8v
         PQJ33G5TouLP7cxyZlQtRWizWPSXrmfR6XT2dMIu//n51VZa/Tau47agovhe1DmHgiu0
         kUlw==
X-Gm-Message-State: AOAM530P/8j2j/xuyQDJd6XakOMsP5gUm38SYyvgtkQtIZRoZJDRFux/
        s6TZabEw+h3hCk4nyCwSe0x+4lBGra0dF7UXcEcHgBE31teuyASKgp5CLOICYAYdeDD7zVKSFKr
        XMB3bvVtckQAdNwf8bcJC+4LYSdBwLfKED1n44D6chQ==
X-Received: by 2002:a05:600c:4104:: with SMTP id j4mr37911663wmi.178.1638788126595;
        Mon, 06 Dec 2021 02:55:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxvEyew/HP7ohYaIhZylrYW6SxTUjeNuu3G9AULmOWcX//NDYQ3KYHU+hoCCRnPDfXU/eCCXg==
X-Received: by 2002:a05:600c:4104:: with SMTP id j4mr37911644wmi.178.1638788126387;
        Mon, 06 Dec 2021 02:55:26 -0800 (PST)
Received: from localhost.localdomain (lfbn-lyo-1-470-249.w2-7.abo.wanadoo.fr. [2.7.60.249])
        by smtp.gmail.com with ESMTPSA id o4sm12657395wry.80.2021.12.06.02.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 02:55:26 -0800 (PST)
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        Atish Patra <Atish.Patra@rivosinc.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        panqinglin2020@iscas.ac.cn, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org,
        linux-arch@vger.kernel.org
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH v3 08/13] riscv: Use pgtable_l4_enabled to output mmu_type in cpuinfo
Date:   Mon,  6 Dec 2021 11:46:52 +0100
Message-Id: <20211206104657.433304-9-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211206104657.433304-1-alexandre.ghiti@canonical.com>
References: <20211206104657.433304-1-alexandre.ghiti@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the mmu type is determined at runtime using SATP
characteristic, use the global variable pgtable_l4_enabled to output
mmu type of the processor through /proc/cpuinfo instead of relying on
device tree infos.

Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/kernel/cpu.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 6d59e6906fdd..dea9b1c31889 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -7,6 +7,7 @@
 #include <linux/seq_file.h>
 #include <linux/of.h>
 #include <asm/smp.h>
+#include <asm/pgtable.h>
 
 /*
  * Returns the hart ID of the given device tree node, or -ENODEV if the node
@@ -70,18 +71,19 @@ static void print_isa(struct seq_file *f, const char *isa)
 	seq_puts(f, "\n");
 }
 
-static void print_mmu(struct seq_file *f, const char *mmu_type)
+static void print_mmu(struct seq_file *f)
 {
+	char sv_type[16];
+
 #if defined(CONFIG_32BIT)
-	if (strcmp(mmu_type, "riscv,sv32") != 0)
-		return;
+	strncpy(sv_type, "sv32", 5);
 #elif defined(CONFIG_64BIT)
-	if (strcmp(mmu_type, "riscv,sv39") != 0 &&
-	    strcmp(mmu_type, "riscv,sv48") != 0)
-		return;
+	if (pgtable_l4_enabled)
+		strncpy(sv_type, "sv48", 5);
+	else
+		strncpy(sv_type, "sv39", 5);
 #endif
-
-	seq_printf(f, "mmu\t\t: %s\n", mmu_type+6);
+	seq_printf(f, "mmu\t\t: %s\n", sv_type);
 }
 
 static void *c_start(struct seq_file *m, loff_t *pos)
@@ -106,14 +108,13 @@ static int c_show(struct seq_file *m, void *v)
 {
 	unsigned long cpu_id = (unsigned long)v - 1;
 	struct device_node *node = of_get_cpu_node(cpu_id, NULL);
-	const char *compat, *isa, *mmu;
+	const char *compat, *isa;
 
 	seq_printf(m, "processor\t: %lu\n", cpu_id);
 	seq_printf(m, "hart\t\t: %lu\n", cpuid_to_hartid_map(cpu_id));
 	if (!of_property_read_string(node, "riscv,isa", &isa))
 		print_isa(m, isa);
-	if (!of_property_read_string(node, "mmu-type", &mmu))
-		print_mmu(m, mmu);
+	print_mmu(m);
 	if (!of_property_read_string(node, "compatible", &compat)
 	    && strcmp(compat, "riscv"))
 		seq_printf(m, "uarch\t\t: %s\n", compat);
-- 
2.32.0

