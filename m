Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727F64C2F94
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbiBXP0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236167AbiBXPZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:25:50 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D7822B955
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:25:20 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id d10so5078433eje.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F5OyyqcGBOYroe/L/tNkoUrlGSaTDcsxizXKN09y7yE=;
        b=Kaew0SH/TCeAiPwYdosspcB1TVRMXC5YKrH07NT6MH1F9SHJMvC24ODuaK0LJk/93z
         D/SLzfgn9VdYpwV34WRYr62vhZCvqz4jdXFSGzvRyj+ZEMvNiRxS8USUXUp3FF9ByLzz
         qjNQ3f6uPY5rMezNzpKZMfbgrN8bBmwSyLEmyC7O05AiWfznUZl05TThgSt+xEEdQhrv
         DuJQm35TJH1TJlir31NOJZ1yNI6C3F2O2TR9tCKkp0dcV9FMyr+fnowbWjF/8VftngSF
         LaaY7VsxpTJsZ7mUevzKqpX2SpVSWH4kJ1lj3RvJpQkVU+EnlF5mIrmFI/povniM0Urj
         KiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=F5OyyqcGBOYroe/L/tNkoUrlGSaTDcsxizXKN09y7yE=;
        b=kJSiSoDkZpk0/eGc6nkQB6hN2SuuVMiskZ3gnf5CJTniDS9BGOFZLVVdKEgh2jRZFH
         OL1s2Ab5CRwt7oOn9VaDTdxleD2V+fq2pWK+wq62xl7VuzR+yV5uw4MHHfPYOXFh/wmN
         nvHcf7M+gJLgugboNbhtcJitCboGQFXnZRiBKv+XV/tQLRvc5egMd1Oa38C1PuBRu3iP
         hNchoeN5NeDhEglDhjOUdFE21G35Gs037IZpkVQyrTB7ub9Gdh7EdZ/CWyKam+RS9cRg
         ifEUObFypxs9yFZo+2UvcqHlEA2dXq5s+RcBzHgDB/gbncn+oC1sPJWAfVgL9mchJkt/
         EZBA==
X-Gm-Message-State: AOAM531atNOZLNl3AMoM/SQnv+NKTuQZioBeD0O/L2sj+4r+b3ZTCWXI
        Lb027xN68MFEaKodzo5a/pM=
X-Google-Smtp-Source: ABdhPJxjOawtmnv3q4ky6UnhfDKTXZ8H/SdiRNzzbQmUMaqQUFmexWJyIZun3SuAUQl6+eDK150nTg==
X-Received: by 2002:a17:906:66cb:b0:6cf:e4f7:9504 with SMTP id k11-20020a17090666cb00b006cfe4f79504mr2735299ejp.142.1645716319481;
        Thu, 24 Feb 2022 07:25:19 -0800 (PST)
Received: from stitch.. (80.71.140.73.ipv4.parknet.dk. [80.71.140.73])
        by smtp.gmail.com with ESMTPSA id s11sm1509693edt.10.2022.02.24.07.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 07:25:19 -0800 (PST)
Sender: Emil Renner Berthing <emil.renner.berthing@gmail.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     linux-riscv@lists.infradead.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Alexandre Ghiti <alex@ghiti.fr>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/8] riscv: Remove unneeded definitions from asm/ftrace.h
Date:   Thu, 24 Feb 2022 16:24:51 +0100
Message-Id: <20220224152456.493365-4-kernel@esmil.dk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220224152456.493365-1-kernel@esmil.dk>
References: <20220224152456.493365-1-kernel@esmil.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macros for generating the auipc + jalr instruction pair is only ever
used in kernel/ftrace.c, so move the definitions there.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 arch/riscv/include/asm/ftrace.h | 35 +--------------------------------
 arch/riscv/kernel/ftrace.c      | 35 +++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 34 deletions(-)

diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index 04dad3380041..585714993749 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -36,41 +36,8 @@ struct dyn_arch_ftrace {
 #endif
 
 #ifdef CONFIG_DYNAMIC_FTRACE
-/*
- * A general call in RISC-V is a pair of insts:
- * 1) auipc: setting high-20 pc-related bits to ra register
- * 2) jalr: setting low-12 offset to ra, jump to ra, and set ra to
- *          return address (original pc + 4)
- *
- * Dynamic ftrace generates probes to call sites, so we must deal with
- * both auipc and jalr at the same time.
- */
-
-#define MCOUNT_ADDR		((unsigned long)MCOUNT_NAME)
-#define JALR_SIGN_MASK		(0x00000800)
-#define JALR_OFFSET_MASK	(0x00000fff)
-#define AUIPC_OFFSET_MASK	(0xfffff000)
-#define AUIPC_PAD		(0x00001000)
-#define JALR_SHIFT		20
-#define JALR_BASIC		(0x000080e7)
-#define AUIPC_BASIC		(0x00000097)
-#define NOP4			(0x00000013)
-
-#define make_call(caller, callee, call)					\
-do {									\
-	call[0] = to_auipc_insn((unsigned int)((unsigned long)callee -	\
-				(unsigned long)caller));		\
-	call[1] = to_jalr_insn((unsigned int)((unsigned long)callee -	\
-			       (unsigned long)caller));			\
-} while (0)
-
-#define to_jalr_insn(offset)						\
-	(((offset & JALR_OFFSET_MASK) << JALR_SHIFT) | JALR_BASIC)
 
-#define to_auipc_insn(offset)						\
-	((offset & JALR_SIGN_MASK) ?					\
-	(((offset & AUIPC_OFFSET_MASK) + AUIPC_PAD) | AUIPC_BASIC) :	\
-	((offset & AUIPC_OFFSET_MASK) | AUIPC_BASIC))
+#define MCOUNT_ADDR	((unsigned long)MCOUNT_NAME)
 
 /*
  * Let auipc+jalr be the basic *mcount unit*, so we make it 8 bytes here.
diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index 4716f4cdc038..2cc15dc45ce0 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -12,6 +12,41 @@
 #include <asm/patch.h>
 
 #ifdef CONFIG_DYNAMIC_FTRACE
+/*
+ * A general call in RISC-V is a pair of insts:
+ * 1) auipc: setting high-20 pc-related bits to ra register
+ * 2) jalr: setting low-12 offset to ra, jump to ra, and set ra to
+ *          return address (original pc + 4)
+ *
+ * Dynamic ftrace generates probes to call sites, so we must deal with
+ * both auipc and jalr at the same time.
+ */
+
+#define JALR_SIGN_MASK		(0x00000800)
+#define JALR_OFFSET_MASK	(0x00000fff)
+#define AUIPC_OFFSET_MASK	(0xfffff000)
+#define AUIPC_PAD		(0x00001000)
+#define JALR_SHIFT		20
+#define JALR_BASIC		(0x000080e7)
+#define AUIPC_BASIC		(0x00000097)
+#define NOP4			(0x00000013)
+
+#define make_call(caller, callee, call)					\
+do {									\
+	call[0] = to_auipc_insn((unsigned int)((unsigned long)callee -	\
+				(unsigned long)caller));		\
+	call[1] = to_jalr_insn((unsigned int)((unsigned long)callee -	\
+			       (unsigned long)caller));			\
+} while (0)
+
+#define to_jalr_insn(offset)						\
+	(((offset & JALR_OFFSET_MASK) << JALR_SHIFT) | JALR_BASIC)
+
+#define to_auipc_insn(offset)						\
+	((offset & JALR_SIGN_MASK) ?					\
+	(((offset & AUIPC_OFFSET_MASK) + AUIPC_PAD) | AUIPC_BASIC) :	\
+	((offset & AUIPC_OFFSET_MASK) | AUIPC_BASIC))
+
 int ftrace_arch_code_modify_prepare(void) __acquires(&text_mutex)
 {
 	mutex_lock(&text_mutex);
-- 
2.35.1

