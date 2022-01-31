Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A174A4E47
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 19:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355599AbiAaS2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 13:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356632AbiAaS2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:28:08 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAF5C061755
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:28:05 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id v67so28327608oie.9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U2McVQuv53c33dZYwtuytrfr7zhfRHKf5OwpDdiji0Q=;
        b=jXncjUEe1a2gGcfncdsQNKvZ5vzVDf3n4UUs/6i0J6Jovf2zn5tkf9YNbcUhJRIhg4
         iiP5AXss/MrSWrwT2nrnFSCUKqo4LurylYJQzQBtUTR9mq/aUdlu8wO44IdVDCaCW+6L
         NNlbkLNAO8/ve9RpEP9HFYPbHdeae7zd3RRsmMTaWG1PkZn6hZS9N36KpE42yE+L/UKN
         yQ/jom03GwNzQ2o0lmB0vxoraJkSvOmzNF21tzteuYplOQJot9C6Jn/yGqc7MRnHmTta
         eABYEarwMVl+7m0KRcJ2VcS4VNXOomnltMSl4Kyvtjt5bCCCZT9xPD97gTjLHPmtSJCI
         tnQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=U2McVQuv53c33dZYwtuytrfr7zhfRHKf5OwpDdiji0Q=;
        b=0qfBqtroBIGbrZGhyNeThP5zhfPBBnXdHxfV1oUP4FETCTVICuv8jcmuOU/anXGAPe
         Lf1nprbp1eyBY90BrFMqQviTCOo6jq3Vq2NY52jVBnYDKyOU4kkPa9jd4hAzMAgX8PuX
         UZCEwykjGYVIPQJLlVuPdt2TJ+SoShHcFOjV+WeQy+ux8hfySvgYhMGQe0kZ8IAsmdNu
         uazEZ19QVrASnkIZZoAc4LDG7227N84jBT4W7Hx6SuVT9zlwZZTvo1itroudatfwrNnq
         57ELSMo4tIwwYcYEvaO8JzY4tesnXODso5hBzWZSkqTDXkuRqqOWSE5X/Pbn5huobNDg
         xoTA==
X-Gm-Message-State: AOAM532GpuIxdkcK59y2SF1smcnMaS/tZRcq/h9m/22DeaHS2yT0veB2
        +kKKR5FkL+6dUImzsc895Ak=
X-Google-Smtp-Source: ABdhPJykrjHso1HeIEehNxkQa/Hvgme48EycTjUAdgXHfcYLHtwx65a013NI9+o+UcHqFs6xlO//5w==
X-Received: by 2002:aca:1e1a:: with SMTP id m26mr14036052oic.208.1643653684887;
        Mon, 31 Jan 2022 10:28:04 -0800 (PST)
Received: from stitch.. (80.71.140.73.ipv4.parknet.dk. [80.71.140.73])
        by smtp.gmail.com with ESMTPSA id a26sm16041676oiy.26.2022.01.31.10.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 10:28:04 -0800 (PST)
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
Subject: [PATCH v2 7/7] riscv: Use asm/insn.h for jump labels
Date:   Mon, 31 Jan 2022 19:27:20 +0100
Message-Id: <20220131182720.236065-8-kernel@esmil.dk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220131182720.236065-1-kernel@esmil.dk>
References: <20220131182720.236065-1-kernel@esmil.dk>
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

