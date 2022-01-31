Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C504A4DF5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 19:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348123AbiAaSXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 13:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348648AbiAaSWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:22:37 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C71C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:22:37 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id r27so6144866oiw.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U2McVQuv53c33dZYwtuytrfr7zhfRHKf5OwpDdiji0Q=;
        b=GrPuCF7g8wuXvMFUhWNN1mhzoghD0PNgEzngwf2WvawQ8neFtZyyWFFWbrsLyvbhN0
         1YLTZW9YmEf5d2WlRFTUJdnmChTV/PIDJd5JRx0YEC94UMjmjp0/5nD+7vFXklO6KAco
         tziDslat9YPXq77Ksu5JtauYUyr8ws1HKtftRCGmK2u+eUDCVSuPG81jrbVMgGBA5Xcj
         +cyDSjShDdJ2Mq7rljU0CX8f1UDknrJW/a7DqHadutRbyD+8xDe/3tCcKAy4a1V51tqq
         sGB/9BvZ8JZagsG2pE2fPv00MPEWXjT48ZAbEPc8Owmp35/GlcEaBsLshIZ7l/bJIj0s
         wOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=U2McVQuv53c33dZYwtuytrfr7zhfRHKf5OwpDdiji0Q=;
        b=8QLZPavJ8zudhhebnzKfuABwY1+YfEPJkxcu56tYzj6aFjLIXtSuwkfJ/+R/oxIrAM
         L5kH7obAyaBp1p8i2bXThxH+J3fIEdNKWJ6FAk1MZMJ9Wqmo7KQLBch4amoyl4i7Mvhi
         r7wS8SifZP76TeMccErEdiNBxrxHPMsYNMmxyw9+zf5BnbNlCsrdZ/0+SlNDfE24e+dS
         0xSKsdhKgZyU+G/CN1EKi5E9NoU2oLNuvJ9ify/AV9WXI4nZ6oQ1Gqvugm3seLqVxpkn
         Y2Hmgha9/0Cgdlqtc/nlggi0MKBvDP27nseCo4v/xVDFl5eC0b+rMKpAnAi6ariTX8AR
         OkFA==
X-Gm-Message-State: AOAM530ypsMBJiFFM3Twp+V99CniRudPJvgByGR3xS7wPdrnZMt3LlDU
        rax9uM1rFheXtFSOhbbo6rY=
X-Google-Smtp-Source: ABdhPJyXQjVGntX1OX0ZlbDOasHZ7YutyxmQFYeM96PygHpy3m+Tr5xZApjL6EcLrg2VuspYptU/SA==
X-Received: by 2002:a05:6808:1644:: with SMTP id az4mr13575526oib.214.1643653357036;
        Mon, 31 Jan 2022 10:22:37 -0800 (PST)
Received: from stitch.. (80.71.140.73.ipv4.parknet.dk. [80.71.140.73])
        by smtp.gmail.com with ESMTPSA id t4sm12986340oie.14.2022.01.31.10.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 10:22:36 -0800 (PST)
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
Subject: [PATCH v1 6/7] riscv: Use asm/insn.h for jump labels
Date:   Mon, 31 Jan 2022 19:21:44 +0100
Message-Id: <20220131182145.236005-7-kernel@esmil.dk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220131182145.236005-1-kernel@esmil.dk>
References: <20220131182145.236005-1-kernel@esmil.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts kernel/jump_label.c to use asm/insn.h to generate the
jump/nop instructions.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 arch/riscv/kernel/jump_label.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/kernel/jump_label.c b/arch/riscv/kernel/jump_label.c
index 20e09056d141..b5b4892c3e9e 100644
--- a/arch/riscv/kernel/jump_label.c
+++ b/arch/riscv/kernel/jump_label.c
@@ -9,11 +9,9 @@
 #include <linux/memory.h>
 #include <linux/mutex.h>
 #include <asm/bug.h>
+#include <asm/insn.h>
 #include <asm/patch.h>
 
-#define RISCV_INSN_NOP 0x00000013U
-#define RISCV_INSN_JAL 0x0000006fU
-
 void arch_jump_label_transform(struct jump_entry *entry,
 			       enum jump_label_type type)
 {
@@ -23,14 +21,10 @@ void arch_jump_label_transform(struct jump_entry *entry,
 	if (type == JUMP_LABEL_JMP) {
 		long offset = jump_entry_target(entry) - jump_entry_code(entry);
 
-		if (WARN_ON(offset & 1 || offset < -524288 || offset >= 524288))
+		if (WARN_ON(!riscv_insn_valid_20bit_offset(offset)))
 			return;
 
-		insn = RISCV_INSN_JAL |
-			(((u32)offset & GENMASK(19, 12)) << (12 - 12)) |
-			(((u32)offset & GENMASK(11, 11)) << (20 - 11)) |
-			(((u32)offset & GENMASK(10,  1)) << (21 -  1)) |
-			(((u32)offset & GENMASK(20, 20)) << (31 - 20));
+		insn = RISCV_INSN_JAL | riscv_insn_j_imm(offset);
 	} else {
 		insn = RISCV_INSN_NOP;
 	}
-- 
2.35.1

