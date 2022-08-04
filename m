Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E9B58A028
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 20:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239629AbiHDSEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 14:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiHDSEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 14:04:12 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C968D1EC4B
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 11:04:10 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id uj29so796805ejc.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 11:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=zYQ4AmPmJLRVcb+bNCTWwvbd+0C4LlEW8cfgqPE+hSI=;
        b=ePwm60I3RCUYrPqjeEnw6l8QeP/cqoxaEn8va4UTHa9CHjAFsqfxZdW3Kh0RzYAEaP
         k5F3tXevcvoqvH2RDvPGdAdlqO69WAnf2gp7Nj/1AnlEhOnniHeCTCY2OtwMtyI/fURG
         Bd2OYnPF2OLCO9d81/VGf2JdGe+btCxpQqC21W2r/FRo/M+9/k4wnTsJnOTGa7uszYQp
         WuuwVSdTeAbILv4uevIXHd9xb1aFiV/WUnVBvfU/tTkqjVkBmFsqRHA1pLSWaciMLxWL
         W1QyT0NyAtNPuMWlHxRj62ab/wCx7iQ2lATH8Bm+zyGSczyuQeELAYQHm8KJoTaLeLk4
         wi+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=zYQ4AmPmJLRVcb+bNCTWwvbd+0C4LlEW8cfgqPE+hSI=;
        b=oDerPPsgYVj7UIQGerBZcDZYawaUkerpYCXVxMFT65Hk1z3H8Fkmyez9BZtztX3tc/
         K2Tw8bnH7ngymRVKs5UFROx5BvkwCWui0DEI/FEWmTiRW51oGO6eHOJv3BBEXwCZ0JWp
         V6j0WCPOIx6h3aXrO3lJRlqZ9k1tjH6NsCYOrf6r5ELw7wvxAalQwgr9Vzm7znBYVOYD
         MujUCSaemOnyyTKx8YZKbXSDt4Di1projwm2S6ol1BTwi/gljnNxnCP3GFinipo+yQj8
         r34/DFV33yV+xow/IGAluYxMDpPQHepyPqHKQ/Gt5fTP29IqTfxbQYc71Azgyd8z5jWx
         p2fQ==
X-Gm-Message-State: ACgBeo0UfXsNz7i/y+jr63o/cRfLsDNtS4V/jlyPLdf6S3R1fx3VEJf4
        bV+XWpJccqgbIjKJMgi5rXtThsoUh8+1DQ==
X-Google-Smtp-Source: AA6agR4p3/jYBTiz/l3f40m5Sg0bUtmpt+oz0h6mYWULe5xfm36Ya0c+xFUf4qNc2QGBZn7wPU7osQ==
X-Received: by 2002:a17:907:1690:b0:72b:4f11:66c4 with SMTP id hc16-20020a170907169000b0072b4f1166c4mr2216435ejc.562.1659636249291;
        Thu, 04 Aug 2022 11:04:09 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id t22-20020a05640203d600b0043ce5d4d2c3sm979006edw.14.2022.08.04.11.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 11:04:08 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/acrn: Improve ACRN hypercalls
Date:   Thu,  4 Aug 2022 20:03:58 +0200
Message-Id: <20220804180358.32944-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As explained in section 6.47.5.2, "Specifying Registers for Local Variables"
of the GCC info documentation, the correct way to specify register for
input operands when calling Extended 'asm' is to define a local register
variable and associate it with a specified register:

	register unsigned long r8 asm ("r8") = hcall_id;

Use the above approach instead of explicit MOV to R8 at the beginning
of the asm. The relaxed assignment allows compiler to optimize and
shrink drivers/virt/acrn.o for 181 bytes:

   text    data     bss     dec     hex filename
   4284     208       0    4492    118c hsm-new.o
   4465     208       0    4673    1241 hsm-old.o

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/include/asm/acrn.h | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/acrn.h b/arch/x86/include/asm/acrn.h
index e003a01b7c67..601867085b95 100644
--- a/arch/x86/include/asm/acrn.h
+++ b/arch/x86/include/asm/acrn.h
@@ -29,19 +29,16 @@ static inline u32 acrn_cpuid_base(void)
  *   - Hypercall number is passed in R8 register.
  *   - Up to 2 arguments are passed in RDI, RSI.
  *   - Return value will be placed in RAX.
- *
- * Because GCC doesn't support R8 register as direct register constraints, use
- * supported constraint as input with a explicit MOV to R8 in beginning of asm.
  */
 static inline long acrn_hypercall0(unsigned long hcall_id)
 {
 	long result;
 
-	asm volatile("movl %1, %%r8d\n\t"
-		     "vmcall\n\t"
+	register unsigned long r8 asm ("r8") = hcall_id;
+	asm volatile("vmcall"
 		     : "=a" (result)
-		     : "g" (hcall_id)
-		     : "r8", "memory");
+		     : "r" (r8)
+		     : "memory");
 
 	return result;
 }
@@ -51,11 +48,11 @@ static inline long acrn_hypercall1(unsigned long hcall_id,
 {
 	long result;
 
-	asm volatile("movl %1, %%r8d\n\t"
-		     "vmcall\n\t"
+	register unsigned long r8 asm ("r8") = hcall_id;
+	asm volatile("vmcall"
 		     : "=a" (result)
-		     : "g" (hcall_id), "D" (param1)
-		     : "r8", "memory");
+		     : "r" (r8), "D" (param1)
+		     : "memory");
 
 	return result;
 }
@@ -66,11 +63,11 @@ static inline long acrn_hypercall2(unsigned long hcall_id,
 {
 	long result;
 
-	asm volatile("movl %1, %%r8d\n\t"
-		     "vmcall\n\t"
+	register unsigned long r8 asm ("r8") = hcall_id;
+	asm volatile("vmcall"
 		     : "=a" (result)
-		     : "g" (hcall_id), "D" (param1), "S" (param2)
-		     : "r8", "memory");
+		     : "r" (r8), "D" (param1), "S" (param2)
+		     : "memory");
 
 	return result;
 }
-- 
2.37.1

