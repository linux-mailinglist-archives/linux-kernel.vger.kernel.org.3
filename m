Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3774A4DF3
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 19:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349936AbiAaSWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 13:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348123AbiAaSWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:22:34 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD58C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:22:33 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id d18-20020a9d51d2000000b005a09728a8c2so13821144oth.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uv9kZcj+SYuMKmc2v8qVWQoeoD1xbOxuZhUO9LDOn7M=;
        b=iElq6TWfe6FNOYAB6SZde3+Kjyd36wOCujz4wGdkh8f0ib8i/VM4zSOvU5JoAwfW4o
         zkN1JFwopjcF3PEtY4QhzcFUEYgWaOP0ysi3BUVTSK1l5XghFPpcIwCmaBVcGNYgWIEM
         EKoMCN4Esh15vtBOBrM4RxsNzWNbnW3QG71jsAL0aMY4vMukdFYR8H+PrWlAYWiD8sdz
         5fHGzfBqElGUsvpzUxdcmp4CrF0chVrPB5CeyJbGVNX0lx1bDQrY46Svkl7FnErsURbY
         B8hmCZMlsGEYmuI2b8Tw2YROFPQvqjkTzcs6KqptFRoIKgsSxsw8m7xWtpHdFDcnuBDb
         RzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Uv9kZcj+SYuMKmc2v8qVWQoeoD1xbOxuZhUO9LDOn7M=;
        b=JDHEMLYcfhFlGYv6ygYtsK9c8cF2uHqD3NCbYKS9ce/Boqhyxs211qC4KcJ9SSuadH
         BIbSYej1MPXd89XPIi5D/fkf5MyTx8U3opGM96OxcScMxRXDKuLtUjTFI0lT2boDpgf+
         4VDCwZzIe5ryqh+p0ik8RJ+w9Y1KrVaK44ycUq+Moat3kPkeIcFvK8eCv2wf92xZOrj2
         yl3crT3fsImjMsibx4LKtCDYQd8YUNMrCcoCJykNvyJ7yQuCDRul2qri3YxH/zJXHw7x
         wzyMYx4lvbBCaFfyKZgzFOVr/6EyLFOOZpwoE/9MWzb0xmE4JV8y+Mf6r3Z1JBvDyKsu
         LRyA==
X-Gm-Message-State: AOAM530K/67mjF1UDzBPkVLnOETS4K6L4eqRXSs2PGw4OxQkH/rZgeO/
        wp7fKFpyN5Y+19bKhXIhujE=
X-Google-Smtp-Source: ABdhPJxqEnmembk8ZumxKkHqD6FTwsFFWHtaMX3BJpB/i4c3c3jD4OzuDZo4IZTHWs/KTnXiZk0oHg==
X-Received: by 2002:a9d:12d7:: with SMTP id g81mr12118683otg.82.1643653353310;
        Mon, 31 Jan 2022 10:22:33 -0800 (PST)
Received: from stitch.. (80.71.140.73.ipv4.parknet.dk. [80.71.140.73])
        by smtp.gmail.com with ESMTPSA id t4sm12986340oie.14.2022.01.31.10.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 10:22:33 -0800 (PST)
Sender: Emil Renner Berthing <emil.renner.berthing@gmail.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     linux-riscv@lists.infradead.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/7] riscv: Use asm/insn.h to generate plt entries
Date:   Mon, 31 Jan 2022 19:21:43 +0100
Message-Id: <20220131182145.236005-6-kernel@esmil.dk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220131182145.236005-1-kernel@esmil.dk>
References: <20220131182145.236005-1-kernel@esmil.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

