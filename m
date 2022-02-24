Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27EDA4C2F93
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236307AbiBXP0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236236AbiBXPZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:25:58 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA8522A291
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:25:24 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id hw13so5088006ejc.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U2McVQuv53c33dZYwtuytrfr7zhfRHKf5OwpDdiji0Q=;
        b=FeLVTuzc9wPFQH0ho6dLgoj+hWeW+fYvqEve7lVWA6cpLUDwNU3G4myXMgVZX8wV11
         OFiFwl9VXdVCJxputF6RNS9sOj5Rz0iwt+Ccsi4YLAt5xJOMf3Oct4BF7CtYgp07Hx0Z
         Px1K1NlBlRUjfC2Mf9oijmdM3U+adJmgDX0+emytZDFkGZ7pQQk7dbvzutjnDBh65znN
         5b/Qx/uM1lZm3wLRbuoCuqBXesw3IYGN3LBVCpCJDO4LdcN3Ao+RmXaZry2BPOuGUATy
         jXxmFYAm06C186UwdZme7YcBfIHiZRSc2jmnWWkU7kTp7vht4qvOi5IS+Hrk8gT0PR2u
         rRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=U2McVQuv53c33dZYwtuytrfr7zhfRHKf5OwpDdiji0Q=;
        b=59CK9i67e5WiEkrzmez3LZCls/EsD0n0/upvoxWgGaCKXgbakjeyk4YizyrqEvcnV9
         A9vtDgVynvm0TAkfi93lYo7jwrP/uWjkJYkHSXBhoKmR+kEvmeLHU7/u/i5Xc31perx6
         Uvv2kFak0eUyjSxLWzHSRGQiGvsD2CKky/fT5yOv4ZeAoU1QuhTTXpg+T3OkTko5zfiP
         3w5BnV8yO5o2mpLtkzXtZd+b6gBtwvNzoDSXtAohH+Q10nYGexUnNZLZX4NRo/NDYUgc
         amsqv3RzhGa3i0Suu29JmFgRBYcEmSl2p5jBx3Smdadbs8druoMLG3aukSDipBzZAYIC
         b4tg==
X-Gm-Message-State: AOAM533xVhHzCGfQM7ZA/XjKPcmYyxkNv9CCdWVOYCSaZu7n9BUub9RB
        pmS5RYQT/TNC3t1npHQKx0Q=
X-Google-Smtp-Source: ABdhPJzmtg5/x9WY3qCGLphHaryu+r7YthG+HP7Rm2wRL6NLXkgnTbKEoS4nS1g0S/n8hO2ecRMJzA==
X-Received: by 2002:a17:906:65d5:b0:6ba:3133:dfb9 with SMTP id z21-20020a17090665d500b006ba3133dfb9mr2818930ejn.56.1645716323553;
        Thu, 24 Feb 2022 07:25:23 -0800 (PST)
Received: from stitch.. (80.71.140.73.ipv4.parknet.dk. [80.71.140.73])
        by smtp.gmail.com with ESMTPSA id s11sm1509693edt.10.2022.02.24.07.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 07:25:23 -0800 (PST)
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
Subject: [PATCH v3 7/8] riscv: Use asm/insn.h for jump labels
Date:   Thu, 24 Feb 2022 16:24:55 +0100
Message-Id: <20220224152456.493365-8-kernel@esmil.dk>
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

