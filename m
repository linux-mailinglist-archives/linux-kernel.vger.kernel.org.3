Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95BB4B1A3A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 01:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346203AbiBKAO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 19:14:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346196AbiBKAO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 19:14:26 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B8E272E;
        Thu, 10 Feb 2022 16:14:25 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id w20so3266365plq.12;
        Thu, 10 Feb 2022 16:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9fDAF8X8Fc16BM/UGlkxTgN+MKXCULAYOKP8eqzMERk=;
        b=dBIv+vQgH8sLnxQcKrIIiMMmHs2a93SjcNMIG0txbKJAxMwZShzuAIGy+6osS/9eYh
         3quuI2z1PaGEcJ4vJ/Q06qdYJ6nur0HMtKfgZJKgW7Hvgl782TVmTF0uzewIvKL8vlNM
         imw1QH16+a4mH9J63KyEayApZhtzrt6GbDvCtHKMBrA2J2Q/ux5AnLSF6TfJgNw1A4Bn
         0fyIe/EAQfpr0VhavoJFwZoVHexxT6w3vcXBCKWkUE93DunAAHU+mErcEhQaGshSAixx
         Qak7LtHPk2HQdcvG86KTiz1e7e4LhSyo9RH28WOEDI+4wQDtmZ1OmNl83fTo4GknVThk
         RhAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9fDAF8X8Fc16BM/UGlkxTgN+MKXCULAYOKP8eqzMERk=;
        b=3sWy8QLiRzhU4AIZ6RvxpFs0xAoi/aRnsziZ079BLkDgcMqzt/+vH9ohszgog579sz
         rANmUJxFApPtoivxHdDRuaAGNPct8o+EyAU4yv6fzIlAYVHNI3NbOaDGUes5yYo0QEvs
         VhB+iKbZWS61Ly61CG/D8QgF5JMqEGykYM/m5J+5XRmrpMlBzL6OpIAWf4alWBgbMkQy
         K12tqhg2txKocRlRv9KS4xbh8zN8lh6xt3j/kRpHs4CRrTX3uHhv+340mrMjos17wKd2
         7IW8vG/cU3ISvtGu14/ZO3mT45pdBrIlkNXwVjI2E0yHKXyV9b+TDdhHopJimASKfwhy
         Q6Hg==
X-Gm-Message-State: AOAM530z6DbinQbZbkCXDZmiBqMf51nvnOczS9uSbsLQgnRiyOJKjPFx
        7cd1axA0XHAu/CCOpUVpB7p3YSybHD8L4448m6c=
X-Google-Smtp-Source: ABdhPJyTW1FzA/TJ0begPk8qu38cqR9Y8WG85GOzhLikIoWO5rSMey4rPwSgG3ZC8JXPYfcazfkUtQ==
X-Received: by 2002:a17:90b:1d84:: with SMTP id pf4mr5403535pjb.106.1644538465112;
        Thu, 10 Feb 2022 16:14:25 -0800 (PST)
Received: from guoguo-omen.lan ([240e:379:96b:fc59:8af:1020:18bc:afc2])
        by smtp.gmail.com with ESMTPSA id h6sm25553351pfc.96.2022.02.10.16.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 16:14:24 -0800 (PST)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-mips@vger.kernel.org
Cc:     Chuanhong Guo <gch981213@gmail.com>,
        Rui Salvaterra <rsalvaterra@gmail.com>,
        Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: ralink: mt7621: do memory detection on KSEG1
Date:   Fri, 11 Feb 2022 08:13:44 +0800
Message-Id: <20220211001345.3429572-1-gch981213@gmail.com>
X-Mailer: git-send-email 2.34.1
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

It's reported that current memory detection code occasionally detects
larger memory under some bootloaders.
Current memory detection code tests whether address space wraps around
on KSEG0, which is unreliable because it's cached.

Rewrite memory size detection to perform the same test on KSEG1 instead.
While at it, this patch also does the following two things:
1. use a fixed pattern instead of a random function pointer as the magic
   value.
2. add an additional memory write and a second comparison as part of the
   test to prevent possible smaller memory detection result due to
   leftover values in memory.

Fixes: 139c949f7f0a MIPS: ("ralink: mt7621: add memory detection support")
Reported-by: Rui Salvaterra <rsalvaterra@gmail.com>
Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
 arch/mips/ralink/mt7621.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/arch/mips/ralink/mt7621.c b/arch/mips/ralink/mt7621.c
index d6efffd4dd20..12c8808e0dea 100644
--- a/arch/mips/ralink/mt7621.c
+++ b/arch/mips/ralink/mt7621.c
@@ -22,7 +22,9 @@
 
 #include "common.h"
 
-static void *detect_magic __initdata = detect_memory_region;
+#define MT7621_MEM_TEST_PATTERN         0xaa5555aa
+
+static u32 detect_magic __initdata;
 
 int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
 {
@@ -58,24 +60,32 @@ phys_addr_t mips_cpc_default_phys_base(void)
 	panic("Cannot detect cpc address");
 }
 
+static bool __init mt7621_addr_wraparound_test(phys_addr_t size)
+{
+	void *dm = (void *)KSEG1ADDR(&detect_magic);
+
+	if (CPHYSADDR(dm + size) >= MT7621_LOWMEM_MAX_SIZE)
+		return true;
+	__raw_writel(MT7621_MEM_TEST_PATTERN, dm);
+	if (__raw_readl(dm) != __raw_readl(dm + size))
+		return false;
+	__raw_writel(!MT7621_MEM_TEST_PATTERN, dm);
+	return __raw_readl(dm) == __raw_readl(dm + size);
+}
+
 static void __init mt7621_memory_detect(void)
 {
-	void *dm = &detect_magic;
 	phys_addr_t size;
 
-	for (size = 32 * SZ_1M; size < 256 * SZ_1M; size <<= 1) {
-		if (!__builtin_memcmp(dm, dm + size, sizeof(detect_magic)))
-			break;
+	for (size = 32 * SZ_1M; size <= 256 * SZ_1M; size <<= 1) {
+		if (mt7621_addr_wraparound_test(size)) {
+			memblock_add(MT7621_LOWMEM_BASE, size);
+			return;
+		}
 	}
 
-	if ((size == 256 * SZ_1M) &&
-	    (CPHYSADDR(dm + size) < MT7621_LOWMEM_MAX_SIZE) &&
-	    __builtin_memcmp(dm, dm + size, sizeof(detect_magic))) {
-		memblock_add(MT7621_LOWMEM_BASE, MT7621_LOWMEM_MAX_SIZE);
-		memblock_add(MT7621_HIGHMEM_BASE, MT7621_HIGHMEM_SIZE);
-	} else {
-		memblock_add(MT7621_LOWMEM_BASE, size);
-	}
+	memblock_add(MT7621_LOWMEM_BASE, MT7621_LOWMEM_MAX_SIZE);
+	memblock_add(MT7621_HIGHMEM_BASE, MT7621_HIGHMEM_SIZE);
 }
 
 void __init ralink_of_remap(void)
-- 
2.34.1

