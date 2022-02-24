Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3074C2F95
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbiBXP0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236223AbiBXPZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:25:58 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D4722EDCC
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:25:24 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id qk11so5167492ejb.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uv9kZcj+SYuMKmc2v8qVWQoeoD1xbOxuZhUO9LDOn7M=;
        b=bX8bQwwicUGsPVy4Y3mCqGccZPF/GGpbluqz317ey+zLTOQ8c1fHnPI/DfzWOV1UYh
         trfJkNv4XTVJi09MAREd/Uj1wKpzLT7JGQ7Tt+J6DfwVsdakLY+CYarxxiaBsF6EOifX
         G1LBOc3kKYU754bVeI8/3HceRIVewkj+qWX8iAHHYnfMLLVXVWFzlAFTkPcS705ti4HE
         WO4bvtl6dq7IvcNWGhEv6DQnxHq9LLmKzfqxpMcaC+SWiiiMWxkgVVA9U2SE5v97t0FH
         /ZXQPpG8O45IQmob4YkGgegJZnVWJNfRfHwTbLHoNQJfzgLF0l0XizzrW5m8vb7Gi82u
         +AeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Uv9kZcj+SYuMKmc2v8qVWQoeoD1xbOxuZhUO9LDOn7M=;
        b=WJ9mEAkywcg4wAktxrpOhVHUf0Z7mgbl0FNxdA9TeEAb4dsN2aEjWS/2JzxUEv53vk
         F0ldpUfhD2bpFBi+9OLTBs1+zKSx2yFiH8XX5jdBnc03spMBYJd8dCuThuGW2NVDPLWI
         o7fhbO2TyNraRVxQjEIc0lm1llxg6ao/EF7ikaV9rUnuxy8RQwjLanUg6rttWl2ue8Hx
         jj+h4zcNfdgrPImet4G9kA40cbFtxWNP51qLwaecFbnsMJdqe70qnsocbbS90bvX243n
         BLx6CSY2poPq/KCbsh5pb0jQ2osriYmDcfR8UPSX6ArMt72Ii1YEetQIwT187PltO/8Y
         BPLg==
X-Gm-Message-State: AOAM531bCXMpLWW1dVAxc3Y4aGorrxioPk96kNCaR+B+KqNL6zZUhHY7
        zt06cvPgbb2Jd8hNlgCh8TM=
X-Google-Smtp-Source: ABdhPJx2BEkVsAOUtvzhxXAulZFuBAavPEG0SaUBdCmd2wQhOtBfUaEYSeBVOeUXEPdh2WkJ1Gu0yg==
X-Received: by 2002:a17:906:39da:b0:6cf:7f09:a7bc with SMTP id i26-20020a17090639da00b006cf7f09a7bcmr2769072eje.457.1645716322553;
        Thu, 24 Feb 2022 07:25:22 -0800 (PST)
Received: from stitch.. (80.71.140.73.ipv4.parknet.dk. [80.71.140.73])
        by smtp.gmail.com with ESMTPSA id s11sm1509693edt.10.2022.02.24.07.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 07:25:22 -0800 (PST)
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
Subject: [PATCH v3 6/8] riscv: Use asm/insn.h to generate plt entries
Date:   Thu, 24 Feb 2022 16:24:54 +0100
Message-Id: <20220224152456.493365-7-kernel@esmil.dk>
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

This converts kernel/module-sections.c to use asm/insn.h to generate
the instructions in the plt entries.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 arch/riscv/kernel/module-sections.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/arch/riscv/kernel/module-sections.c b/arch/riscv/kernel/module-sections.c
index 39d4ac681c2a..cb73399c3603 100644
--- a/arch/riscv/kernel/module-sections.c
+++ b/arch/riscv/kernel/module-sections.c
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleloader.h>
+#include <asm/insn.h>
 
 struct got_entry {
 	unsigned long symbol_addr;	/* the real variable address */
@@ -61,36 +62,16 @@ struct plt_entry {
 	u32 insn_jr;		/* jr    t1                            */
 };
 
-#define OPC_AUIPC  0x0017
-#define OPC_LD     0x3003
-#define OPC_JALR   0x0067
-#define REG_T0     0x5
-#define REG_T1     0x6
-
 static struct plt_entry emit_plt_entry(unsigned long val,
 				       unsigned long plt,
 				       unsigned long got_plt)
 {
-	/*
-	 * U-Type encoding:
-	 * +------------+----------+----------+
-	 * | imm[31:12] | rd[11:7] | opc[6:0] |
-	 * +------------+----------+----------+
-	 *
-	 * I-Type encoding:
-	 * +------------+------------+--------+----------+----------+
-	 * | imm[31:20] | rs1[19:15] | funct3 | rd[11:7] | opc[6:0] |
-	 * +------------+------------+--------+----------+----------+
-	 *
-	 */
 	unsigned long offset = got_plt - plt;
-	u32 hi20 = (offset + 0x800) & 0xfffff000;
-	u32 lo12 = (offset - hi20);
 
 	return (struct plt_entry) {
-		OPC_AUIPC | (REG_T0 << 7) | hi20,
-		OPC_LD | (lo12 << 20) | (REG_T0 << 15) | (REG_T1 << 7),
-		OPC_JALR | (REG_T1 << 15)
+		RISCV_INSN_AUIPC | RISCV_INSN_RD_T0 | riscv_insn_u_imm(offset + 0x800),
+		RISCV_INSN_LD    | RISCV_INSN_RD_T1 | RISCV_INSN_RS1_T0 | riscv_insn_i_imm(offset),
+		RISCV_INSN_JALR  | RISCV_INSN_RS1_T1,
 	};
 }
 
-- 
2.35.1

