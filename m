Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B866C50A1CB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389164AbiDUOOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389110AbiDUOOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:14:03 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA26F3D1E1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:10:58 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id t4so4756586pgc.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6blxNsELEnRAkwWYLfPIZgUHCJanS2RvmmJ1WGnDFCs=;
        b=J+zVHJDKjdxQ/xxA0WB6tiMqi0tXsnGC5ntOWTzPMeGvL25IG/guLuFwCRPtxytOn3
         hJoqD0p5jmL/GW+F1vFlwd7OhojY67bScTldZKOPSgGi+XP6ywwxTJe4lXFfmqvppNrI
         DaxpAAlzr0MQPrYxRz0wcfqppHHB5g2nzbll69WYxHpM0xZeHPiqEP/lo9AvwL5K31HW
         ICPmB2NSiqTQfOYm4knZzr5Maq5hKCK34rWZnM7iPtE9JZNTU7VrQtsX5nzQEf6iDJDz
         2nm9JfvfSrQ710ujDRt1Oiid3PrKTVNUBJ1+dTDANYk8NpQMEtr/WeK44pbj2hGF9x2f
         /hzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6blxNsELEnRAkwWYLfPIZgUHCJanS2RvmmJ1WGnDFCs=;
        b=A/TXkH4j+tMf5MukPI+RYN4QXDd3W2vUVBaRW7HJfx1puQYpktOWt/mwuefM4tDPwW
         pthlcgq5KsgbQ0ojlf2vjqW4ZrnIGfg/Iz/bRMy0/SPzio/e1uQ1eu5oLxBzQjHbf4F/
         Sm/uCYh3GT+zklLZVmaAprbW9xtq9kWH4DV//VdiQoPqRGt+vSRZib210y0gTXBa2RZC
         HqmuXNKHBjcgG1CnQT0Vpz+joQsNDqTVaqBuoD/5qA3KDHfpBLjnRUMPzqfI6Ff05okI
         ScXh/z9V/m+x6nQwCchVy4QHDeOZ1dGi8us3R5QHAUsOT8TiI5Wg4nmsc9Y/8kDecm05
         Uong==
X-Gm-Message-State: AOAM533Rrrqh+1iBSq6fi5Mrbyxhf08zfmKssfGowl1y+yrwLNSIk6jn
        WB54lWSyxBDIrKtOcIzi7/Vn5mtjzbU=
X-Google-Smtp-Source: ABdhPJw9rGpjUnipO6AtBzqacOXuKQit2v4T7x9aeAOIaknO+8c4uvn5lDYudQWu3IkE5cE1fnJ4bA==
X-Received: by 2002:a65:6657:0:b0:381:1b99:3f04 with SMTP id z23-20020a656657000000b003811b993f04mr23694252pgv.512.1650550258279;
        Thu, 21 Apr 2022 07:10:58 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id k13-20020a056a00134d00b0050a5867dd73sm20428483pfu.157.2022.04.21.07.10.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Apr 2022 07:10:58 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: [PATCH V6 7/8] x86/entry: Remove the branch in sync_regs()
Date:   Thu, 21 Apr 2022 22:10:54 +0800
Message-Id: <20220421141055.316239-8-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220421141055.316239-1-jiangshanlai@gmail.com>
References: <20220421141055.316239-1-jiangshanlai@gmail.com>
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

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

In non-XENPV, the tss.sp0 is always the trampoline stack, and
sync_regs() is called on non-XENPV only since error_entry() is not
called on XENPV, so the stack must be the trampoline stack or one of
the IST stack if it is from user mode or bad iret.

Remove the check in sync_regs() and always copy the pt_regs from the
stack in the cpu entry area to the task stack.

Cc: Juergen Gross <jgross@suse.com>
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 arch/x86/kernel/traps.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 111b18d57a54..e1cb4c009d54 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -845,13 +845,13 @@ DEFINE_IDTENTRY_RAW(exc_int3)
 /*
  * Help handler running on a per-cpu (IST or entry trampoline) stack
  * to switch to the normal thread stack if the interrupted code was in
- * user mode. The actual stack switch is done in entry_64.S
+ * user mode. The actual stack switch is done in entry_64.S.
  */
 asmlinkage __visible noinstr struct pt_regs *sync_regs(struct pt_regs *eregs)
 {
 	struct pt_regs *regs = (struct pt_regs *)this_cpu_read(cpu_current_top_of_stack) - 1;
-	if (regs != eregs)
-		*regs = *eregs;
+
+	*regs = *eregs;
 	return regs;
 }
 
-- 
2.19.1.6.gb485710b

