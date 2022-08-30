Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F138B5A71DB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 01:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbiH3XdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 19:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbiH3XcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 19:32:08 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6CA7AC18
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:32:04 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3363b1dffa0so191261887b3.23
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=iSKFadVRGufrYpwT+lMSnNGa80NvrDGJYFfJh0K053o=;
        b=aea7f+jGGqYBZvgs3orCadjUsDfEDwReuGVw99oeGDGf7HEC9SsWjsfrc4GKNaD6hP
         nrq5xjB9KkSqASgIkUlxMnTp8Km6owmHFu3fTgFOv6KvP4eM+abfzLH+8I6bLicq5smv
         eDG6ttbs273TD7DuasPZT7cximHiEM3CmgjyhDFTYjOlX3lg0O71IK8vGJeisE537v0G
         /84LNcC/b5N5SGDtXczpJ448nRkwvexxbTXvAda6YuVil3v0IrjmkMJ6/bHjXAJTWE+9
         ykzvYVbqr9U6P1Z3KvlXY+4NvSLMXaotZL4KkDq1MWLWxgRs+Hlhts6BqiiWRh+Dvfl0
         7e/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=iSKFadVRGufrYpwT+lMSnNGa80NvrDGJYFfJh0K053o=;
        b=u3HQCn7O29in/+avEHCRrqPV8YMVxBGVq7q8BD0657XEicUDo/b8OdCmSWQlU3x2PP
         VeUZocjXSvO/7KqKjN3L3Dm/NJiidJX8RflqOg8B161kjr6Q1oVQOGXd0yiEVamjJn8e
         PTBYMiDieAf99AW7Poo+vMCAwWpCRNoLs7ZOKS0u/6AfUy7RFHuhLyN+gm005FkFJ9GJ
         LUZ1fIx/7ApN4W8fBeWpJg8uSy3pFJxa4YpRlEuRRP6Dv/Wt/HgFrFQ/CbPgNIuaiKoM
         ZvJMJO4aSLOP9NRESb3gLOKA+EQ/w+CKblLywbArtUcbhMbGQXngEQvih2ZUxYFFyv9X
         jPTg==
X-Gm-Message-State: ACgBeo3Xy8ACa+fjObwW5eUv602ssuFmqDudBqwmLWQlUE5ndCjtsrr8
        pNB7/9up7mWcBN0GlCH6fmIZoS/B9/i9wPkJ0qo3regse0T7GvWmHUVlyd/pucbmTSu3K9MvDMV
        D/Kfqw0bv5stM+FrgxdqXPb4XXqAj0FJSAXJ/jtbMi52iwAWcSTtI2yU7tyGZSj/lhmUaT1bKkd
        bTPez62lVUUA==
X-Google-Smtp-Source: AA6agR4dNWfY0j6qePqn3prvgFjGMASrL7MLejp/isbrgaHY+xJaMD5dtv41AGsWWLDIY+wLuApFeyxpr9oELA8nW+s=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:54d9:7143:6a7d:91d])
 (user=samitolvanen job=sendgmr) by 2002:a25:3746:0:b0:69b:a100:521f with SMTP
 id e67-20020a253746000000b0069ba100521fmr9841652yba.135.1661902323439; Tue,
 30 Aug 2022 16:32:03 -0700 (PDT)
Date:   Tue, 30 Aug 2022 16:31:19 -0700
In-Reply-To: <20220830233129.30610-1-samitolvanen@google.com>
Message-Id: <20220830233129.30610-12-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220830233129.30610-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=2392; i=samitolvanen@google.com;
 h=from:subject; bh=4fEwVbMTS4PhblTx3hjYUyv158cFLGoiHZdYncXlyvM=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjDp3NGeTaUnU1q2XxWRmRjYKzsHzN1uiEteQxzaGl
 2CA0UxGJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYw6dzQAKCRBMtfaEi7xW7rJdC/
 9UcVy/DfbAoLGh8Ex43l9s3e1xNLlcP/xWCoYq8CUdwrGkU622rRNiEdF+X0NOBHDwK8i7DyRAn0PK
 38Hsd+b1qOoUJlPBVMxl/ymJ3j7zbkQsbJMr5XWRG0N5HmxXjghCylDMKfdDFZ9e3gew1xx1sj24MA
 jxEVQYBIMYZVDIpYDmZgOv1biQKojcsDFIE3lFclQtcPwQLPWap3PVAPVd2oqDMfKGQXNbOaa2Qgio
 doXCrE0dslkp2/yG4QHSM2E2j0fNAKDllqfR6xQcjCU2kr6anScnJ8rolEApP2tMueaLsLoxMwJKbD
 +pf+ycZPrG8GCHpntkBi4jULpc66b3D+JN9ZdgIl7RTqNX2/9XMbns0EOfrhy9gNgoPYd9bhIJpm2k
 1M2frsyMoG+u+4rCsSKGqYfnQJvjamiR5Y6yncD9JRQDvdhecxlWWD/aVLEBel1hFOkANsQfHEESXp
 x6U6Lko1f4miNMWO/ymnQfmQ+cJiFgtDuMnEUqvhkTYsM=
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v4 11/21] arm64: Drop unneeded __nocfi attributes
From:   Sami Tolvanen <samitolvanen@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With -fsanitize=kcfi, CONFIG_CFI_CLANG no longer has issues
with address space confusion in functions that switch to linear
mapping. Now that the indirectly called assembly functions have
type annotations, drop the __nocfi attributes.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/include/asm/mmu_context.h | 2 +-
 arch/arm64/kernel/alternative.c      | 2 +-
 arch/arm64/kernel/cpufeature.c       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index c7ccd82db1d2..bba0e630c8bc 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -147,7 +147,7 @@ static inline void cpu_install_ttbr0(phys_addr_t ttbr0, unsigned long t0sz)
  * Atomically replaces the active TTBR1_EL1 PGD with a new VA-compatible PGD,
  * avoiding the possibility of conflicting TLB entries being allocated.
  */
-static inline void __nocfi cpu_replace_ttbr1(pgd_t *pgdp, pgd_t *idmap)
+static inline void cpu_replace_ttbr1(pgd_t *pgdp, pgd_t *idmap)
 {
 	typedef void (ttbr_replace_func)(phys_addr_t);
 	extern ttbr_replace_func idmap_cpu_replace_ttbr1;
diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index 9bcaa5eacf16..d2c66507398d 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -133,7 +133,7 @@ static void clean_dcache_range_nopatch(u64 start, u64 end)
 	} while (cur += d_size, cur < end);
 }
 
-static void __nocfi __apply_alternatives(struct alt_region *region, bool is_module,
+static void __apply_alternatives(struct alt_region *region, bool is_module,
 				 unsigned long *feature_mask)
 {
 	struct alt_instr *alt;
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index af4de817d712..ca6e5ca7104e 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1685,7 +1685,7 @@ static phys_addr_t kpti_ng_pgd_alloc(int shift)
 	return kpti_ng_temp_alloc;
 }
 
-static void __nocfi
+static void
 kpti_install_ng_mappings(const struct arm64_cpu_capabilities *__unused)
 {
 	typedef void (kpti_remap_fn)(int, int, phys_addr_t, unsigned long);
-- 
2.37.2.672.g94769d06f0-goog

