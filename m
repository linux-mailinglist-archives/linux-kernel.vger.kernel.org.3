Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70297575796
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 00:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbiGNWZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 18:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbiGNWZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 18:25:19 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EFC71BCD;
        Thu, 14 Jul 2022 15:25:18 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y9so3073795pff.12;
        Thu, 14 Jul 2022 15:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aTK/b0TZUnjxfiXeLcvVZOBgrnSM2TtxUMit8G0GiSg=;
        b=oXYl1Qz3/VkWuxcnuGS27g3Iu7/8VlpA/kOSL6MjrQcKCWf0qXB0ioPA9LXniO/p34
         5vogGLlDyEnMLLq6+H0u89OmTzNGJeDQbiA7UF8o53p9ptUlQNyyolSzIfX0dj6S/xq2
         AcrsGoCB0/DFwhczh7EFAuPg/HKllUvV5SrU6nUAf2EzZwbPGUlDA9Idl+wyuzdlaqGK
         VaEh8yDDy/plPrstQs9ru9gXSJJo1N1oTuQyfhnPVBR88mbWTgtu4YmKgWkZLwq8HKeL
         6Gd60vobSX4tEHTrYaTTMYgDu2UYUyVlsBmA/LO1GM3P9wsGqyys1RWzcu4bJUmwmZGw
         GWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aTK/b0TZUnjxfiXeLcvVZOBgrnSM2TtxUMit8G0GiSg=;
        b=KfWM4sPVM8LFl6Ic95spUGG1XRgo642VJK1oCoyw0QAMjlibH5tRDFJ1hPG2A4DwY5
         asTuZfHrKG9PwHGt7NzcpiT3YyoRfK/HFvqekqg6/CtHlTlqaxuF1utttjIrRPXWd45p
         LuLfpexUy+VNA+VQMGEfddhb0Xx3jVwXGuDhCcoNNqfrwAijesWZDGTAlE5saIg+FTws
         7r/dItc1fQwlhl7jNZWx3YlqNZnp9+1v97Zt2+hHnAqmD4pTJ40cUOWYUJijyEbEGsA+
         rYc9rhoMV94iPuMlcs5mVbVneVeF5Z57I86JNt4g3Pv0qtQ8f389rTzvPMwNA/lJBU1K
         puHQ==
X-Gm-Message-State: AJIora9OVzatJW87O25PnM/xL6QwktvB/YplKTBNKwm3Q7hE7FDFeMXx
        KlqVb8hDUCSf9o14pEaIiKCJLU8b9hY=
X-Google-Smtp-Source: AGRyM1vckNO4CUGve+xKik7rJa4yNPY5J3qV5IEI/L5fti6W+LPNDORSzJ+9a9+e4TX/k0Q1IuDx4w==
X-Received: by 2002:a05:6a00:1a0e:b0:52a:cef3:b4a1 with SMTP id g14-20020a056a001a0e00b0052acef3b4a1mr10240441pfv.23.1657837517650;
        Thu, 14 Jul 2022 15:25:17 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id k6-20020aa79986000000b00528c22038f5sm2326613pfh.14.2022.07.14.15.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 15:25:17 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@vger.kernel.org
Cc:     fancer.lancer@gmail.com, gerg@kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] MIPS: Fixed __debug_virt_addr_valid()
Date:   Thu, 14 Jul 2022 15:25:12 -0700
Message-Id: <20220714222514.1570617-1-f.fainelli@gmail.com>
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

It is permissible for kernel code to call virt_to_phys() against virtual
addresses that are in KSEG0 or KSEG1 and we need to be dealing with both
types. Rewrite the test condition to ensure that the kernel virtual
addresses are above PAGE_OFFSET which they must be, and below KSEG2
where the non-linear mapping starts.

For EVA, there is not much that we can do given the linear address range
that is offered, so just return any virtual address as being valid.

Finally, when HIGHMEM is not enabled, all virtual addresses are assumed
to be valid as well.

Fixes: dfad83cb7193 ("MIPS: Add support for CONFIG_DEBUG_VIRTUAL")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v2:

- handle lack of HIGHMEM and EVA

 arch/mips/mm/physaddr.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/mips/mm/physaddr.c b/arch/mips/mm/physaddr.c
index a1ced5e44951..f9b8c85e9843 100644
--- a/arch/mips/mm/physaddr.c
+++ b/arch/mips/mm/physaddr.c
@@ -5,6 +5,7 @@
 #include <linux/mmdebug.h>
 #include <linux/mm.h>
 
+#include <asm/addrspace.h>
 #include <asm/sections.h>
 #include <asm/io.h>
 #include <asm/page.h>
@@ -12,15 +13,6 @@
 
 static inline bool __debug_virt_addr_valid(unsigned long x)
 {
-	/* high_memory does not get immediately defined, and there
-	 * are early callers of __pa() against PAGE_OFFSET
-	 */
-	if (!high_memory && x >= PAGE_OFFSET)
-		return true;
-
-	if (high_memory && x >= PAGE_OFFSET && x < (unsigned long)high_memory)
-		return true;
-
 	/*
 	 * MAX_DMA_ADDRESS is a virtual address that may not correspond to an
 	 * actual physical address. Enough code relies on
@@ -30,7 +22,9 @@ static inline bool __debug_virt_addr_valid(unsigned long x)
 	if (x == MAX_DMA_ADDRESS)
 		return true;
 
-	return false;
+	return x >= PAGE_OFFSET && (KSEGX(x) < KSEG2 ||
+	       IS_ENABLED(CONFIG_EVA) ||
+	       !IS_ENABLED(CONFIG_HIGHMEM));
 }
 
 phys_addr_t __virt_to_phys(volatile const void *x)
-- 
2.25.1

