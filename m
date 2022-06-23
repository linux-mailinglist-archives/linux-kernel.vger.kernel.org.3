Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C3655730B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 08:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiFWGYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 02:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiFWGYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 02:24:45 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7AD1F632
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 23:24:42 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id a17so15336562pls.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 23:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qqsTAghqTcuad0HsznITt9fffgHBbEr55RFNzBL7lOs=;
        b=gWXW1KFmTOn7RA7YtwnUU+JfSn1X7Z7Lq2YUE4Ik4Y9UgSo4zjNU5nMWWmzSaSN9zJ
         EEt7tekxZYwwhhsZBVugmYWHWO0Js8N3mzXOJsjHQa0pO0XYmEuEZQSvp0IkF3j/ijVN
         8POsp0Lus50ymFzxF5wDS6wTDklhtYlJHi+nJZZtfy19VRv0ENwCJiAIgZZMt5uxWLff
         NJLTALbrnpj6x2CiNF7h0vfl3L2O7Gvg+OHV5lEXzXEB9wsVhikUGLpI8zerQlDNXAh4
         uN22Z5qNxGKH0ADGnTH44j0G9BrGqjxbqktqr5/zL5ttxUAms5NZsWtgV1s6wnNIvhNK
         Q1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qqsTAghqTcuad0HsznITt9fffgHBbEr55RFNzBL7lOs=;
        b=PaBOAX+h0nYdP8nRXuaatbCIUTvA44UswTTGTsemfzFo9QntX4RFnourK3WlS2S6vD
         NBFfbxYEaDBn2cG1sbaP9c05aRsEArX7Ld0HWPKZV0JWFyuNWXXoSD3EHc6jJuTCmdMX
         RKVC67etrBIJ07x7AAaAFTaWYT12hwJtJz0MdiuVIFhHzlTla9urcPxM1RkOT2TFjQNy
         Ah4DuuD6svz6/MfRBY4b+g4QQ0UmzWdDPQzEFS2607cE9IqFaAplJLPRdt8ve5bf+Ppc
         XhNYZA/oCDVQ7o3G+psd960Kb7U1OliELTEEZibr/0HGsfCTWgYncShfalZwqBdpw7lL
         iK0g==
X-Gm-Message-State: AJIora9DWnS5uWUt067FsffXSGF/OnkNMIYVeSVZHi4t12PiJxv9ixpk
        lV+hdR1YJsEO4NS4XWlZr4Uyow==
X-Google-Smtp-Source: AGRyM1sSG3iOrty2T6axDbCTVmpM8WFQ2J15pfUCzhLILoXLC5tQuQUI0jkR6MONUinrzLKRdqvInA==
X-Received: by 2002:a17:90b:1e47:b0:1e6:7d04:2f4 with SMTP id pi7-20020a17090b1e4700b001e67d0402f4mr2339936pjb.93.1655965482226;
        Wed, 22 Jun 2022 23:24:42 -0700 (PDT)
Received: from MacBook-Pro.local.net ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id y18-20020a62b512000000b0051e7b6e8b12sm8656807pfe.11.2022.06.22.23.24.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jun 2022 23:24:41 -0700 (PDT)
From:   lizhe.67@bytedance.com
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Cc:     lizefan.x@bytedance.com, lizhe.67@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC] memmap: introduce cmdline parameter "memmap=nn[KMG]$" without start addr
Date:   Thu, 23 Jun 2022 14:24:02 +0800
Message-Id: <20220623062402.12392-1-lizhe.67@bytedance.com>
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
area of memory for another use from kernel. We have to determine
it's start addr and length. In our scenario, we need reserve or
alloc large continous memory like 256M in machine which have
different memory specification at just boot phase for a user land
process. And these memorys will not be freed to system before
system reboot. It is a hard work for us to reserve memory with
same length from machine with different memory specification,
because we have to determine the start addr of the reserved memory
for each type of machine.

This patch introduce a cmdline parameter "memmap=nn[KMG]$" to make
this work easy. It is an extension of "memmap=nn[KMG]$ss[KMG]". We
don't need to input the start addr. Kernel will reserve a suitable
area of memory and we can get the area from /proc/iomem with the
key word "Memmap Alloc". Notice that we need "$" in our cmdline
parameter or it will be confused with memmap=nn[KMG]@ss[KMG].

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 .../admin-guide/kernel-parameters.txt         |  7 ++
 arch/x86/kernel/e820.c                        | 64 ++++++++++++++++++-
 2 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2522b11e593f..b88df1e61d48 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3022,6 +3022,13 @@
 			         memmap=64K$0x18690000
 			         or
 			         memmap=0x10000$0x18690000
+			[KNL, X86] If @ss[KMG] is omitted, kernel will reserve a
+			suitable area of memory for us. We can find the area from
+			/proc/iomem with key word "Memmap Alloc".
+			Example: Exclude memory with size 0x10000
+					 memmap=64K$
+					 or
+					 memmap=0x10000$
 			Some bootloaders may need an escape character before '$',
 			like Grub2, otherwise '$' and the following number
 			will be eaten.
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index f267205f2d5a..241d41ec870f 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -942,8 +942,18 @@ static int __init parse_memmap_one(char *p)
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
+		} else {
+			/* We determine the start and size of the reserved memory */
+			start_at = memparse(p+1, &p);
+			e820__range_add(start_at, mem_size, E820_TYPE_RESERVED);
+		}
 	} else if (*p == '!') {
 		start_at = memparse(p+1, &p);
 		e820__range_add(start_at, mem_size, E820_TYPE_PRAM);
@@ -972,6 +982,40 @@ static int __init parse_memmap_one(char *p)
 	return *p == '\0' ? 0 : -EINVAL;
 }
 
+static int __init setup_memmap_random(char *p)
+{
+	char *oldp;
+	struct resource *res;
+	u64 start_at, mem_size;
+
+	if (!p)
+		return -EINVAL;
+	oldp = p;
+	mem_size = memparse(p, &p);
+	if (p == oldp)
+		return -EINVAL;
+
+	if (*p == '$') {
+		if (*(p+1) != '\0')
+			return 0; /* no need to deal with */
+		start_at = memblock_phys_alloc(mem_size, SMP_CACHE_BYTES);
+		if (start_at == 0)
+			return -ENOMEM;
+		res = memblock_alloc(sizeof(struct resource), SMP_CACHE_BYTES);
+		if (res == NULL) {
+			memblock_phys_free(start_at, mem_size);
+			return -ENOMEM;
+		}
+		res->start = start_at;
+		res->end = start_at + mem_size - 1;
+		res->name = "Memmap Alloc";
+		res->flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
+		res->desc = IORES_DESC_RESERVED;
+		insert_resource(&iomem_resource, res);
+	}
+	return 0;
+}
+
 static int __init parse_memmap_opt(char *str)
 {
 	while (str) {
@@ -988,6 +1032,22 @@ static int __init parse_memmap_opt(char *str)
 }
 early_param("memmap", parse_memmap_opt);
 
+static int __init setup_memmap_opt(char *str)
+{
+	while (str) {
+		char *k = strchr(str, ',');
+
+		if (k)
+			*k++ = 0;
+
+		setup_memmap_random(str);
+		str = k;
+	}
+
+	return 0;
+}
+__setup("memmap=", setup_memmap_opt);
+
 /*
  * Reserve all entries from the bootloader's extensible data nodes list,
  * because if present we are going to use it later on to fetch e820
-- 
2.20.1

