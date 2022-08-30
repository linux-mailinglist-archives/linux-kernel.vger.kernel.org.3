Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5CA45A71E2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 01:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbiH3Xd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 19:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbiH3Xd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 19:33:28 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2229CA032F
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:32:26 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-340e618b145so122414257b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=lxwsXrI3Mz5fmQ5/zOX86abUuUXDGoEtutr5sfPTzdM=;
        b=ICOfaU59KFOn1u8tj+jNF7yA54b5eS6xOe+IMHATV8lUzWB/2X2Z7ndebW8SuDJbZp
         zZExhr0GX7vlb+myJsY4FJfR80s0uELf0QyRcIe5XQhj9GRlUZuBufvTnZ4HaOz+pmTg
         vdL2ZN5DasdfM+e3GGko29L8VL3IBBrhWSRT/JGEm5aRqwEo0EICXQTYqdYDldYAvxbY
         zspss2WPicINxssrlAuMaj3Ax9CPJPHBxNEmMh5eqte/8VwVdXlsUnYo+zxaeu9trZcF
         4XfnE3V82BgHAMxrXG3UrzKWzoe8+mEiXwyVd+uAnUcEZPy39B6xZ9xV+vlP87uDR5ke
         kJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=lxwsXrI3Mz5fmQ5/zOX86abUuUXDGoEtutr5sfPTzdM=;
        b=vYvO3OlJLoNLdUEWo6/6Nrx+8mlpD4fINYAB976xS99ChGUULPOdR1KLF3bcqwwXjn
         MxY/nSdbIlm/8FsR8E8tmRAccFapMqZz679Puk/mDkKB8wmj3hAU1xkOwvndlJNVW4L2
         jHG4F50zWqvYK37c9XMIqpRk8/5AzOypUjfvMzKr/9I8XCacxOEvhzumxk4JUnewUyuI
         o5JuvcRB66I4UIF4kZs3hJPBJQLaJiYE0A9PM8bXug+iiWDOY7kLXmCa/REUlLKyVPtr
         cMHPvIvox6585RkFrZu+OfuWI+t7zci6liNSUMI51xM4u4F3nmkaIcgv299LgBjPpm6O
         AZkA==
X-Gm-Message-State: ACgBeo0tkKPSXmWvLAOerQrxIDrOPtx3BgjlsJrI0CwZ5tuWeDmG2FR4
        5RhGZTHSaAi4rnZws2WLB7ltz3pBvQB751H50JwpHVNyoHfTapT0foyaZstuSgXZE/4fG0wyavu
        0S7/hjTxay4MG0vRFKf+DC8vE4tVCjGECbY/3/rBNXw8peJLJGM2Hx3Q2UkgCuPAT4NFWEIbD9p
        l7botnxv8N9g==
X-Google-Smtp-Source: AA6agR4fE6Gg8awQx2KS9WtJeU46JESb48vItR61XAln2KMXiSf46hjOiUeXjrEcWkyckSPoadljKPgTp5O6PLcizdU=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:54d9:7143:6a7d:91d])
 (user=samitolvanen job=sendgmr) by 2002:a25:5986:0:b0:694:f850:223f with SMTP
 id n128-20020a255986000000b00694f850223fmr13658199ybb.491.1661902345267; Tue,
 30 Aug 2022 16:32:25 -0700 (PDT)
Date:   Tue, 30 Aug 2022 16:31:27 -0700
In-Reply-To: <20220830233129.30610-1-samitolvanen@google.com>
Message-Id: <20220830233129.30610-20-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220830233129.30610-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1934; i=samitolvanen@google.com;
 h=from:subject; bh=j+dRbdVg7Q78Lk00de2uzEaCRhsdMEDN+wU7yhAtB6I=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjDp3PCTTAdV8Hk1XXJcZvSvg5+O6k1Ozq2feAV3JZ
 bXDWub2JAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYw6dzwAKCRBMtfaEi7xW7uJqC/
 9g0WEa/wq7GPSj/jsZkwP+eo20vbuIdBILQjyKx6g3zSYpJxIRdSTMe/Ft9rn+C6apdUFx310uNdbM
 629LRshuNEW20b98k/SIj+1wQBpmaF3JtY0zXTo91YeKUtGNRxbQqIDLdHbnE8iyAM3byp4uwuIQXi
 62aPeT8h8d1R6FQXR/WCSNJ6FoyOhql2RVeaYgoEmWccYItjnIVyldJJ3ahwyvu+RHqZzqz5Jm4uW3
 Gq8MD/T/GZ5ZLuipErCj1iOaif8sJ1q2jjAQbsvNRcYvv6V600Vz9ABIcvr24nYx5sk2i/u7A6KU9/
 gvrGM0vh9P1e1gyTjGQF2puMGcf1PHLlUosOGkL7cslheQRw6lVU5hdOW8NKEBpfjpYUSY+41+V6zZ
 7ph644d9uMXOQS8kUtyAtiegxWqdCYYCY4EDa/ooM/v+1or9C+V8CFquTZnOFKmbfjbRYgc9b8iUp7
 lfdI5ThNkCnogOoZJn6A5Br9rWg1myT1DLEMipq1Dxs4k=
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v4 19/21] x86: Add types to indirectly called assembly functions
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

With CONFIG_CFI_CLANG, assembly functions indirectly called from C code
must be annotated with type identifiers to pass CFI checking. Add types
to indirectly called functions.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/crypto/blowfish-x86_64-asm_64.S | 5 +++--
 arch/x86/lib/memcpy_64.S                 | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/crypto/blowfish-x86_64-asm_64.S b/arch/x86/crypto/blowfish-x86_64-asm_64.S
index 802d71582689..4a43e072d2d1 100644
--- a/arch/x86/crypto/blowfish-x86_64-asm_64.S
+++ b/arch/x86/crypto/blowfish-x86_64-asm_64.S
@@ -6,6 +6,7 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 
 .file "blowfish-x86_64-asm.S"
 .text
@@ -141,7 +142,7 @@ SYM_FUNC_START(__blowfish_enc_blk)
 	RET;
 SYM_FUNC_END(__blowfish_enc_blk)
 
-SYM_FUNC_START(blowfish_dec_blk)
+SYM_TYPED_FUNC_START(blowfish_dec_blk)
 	/* input:
 	 *	%rdi: ctx
 	 *	%rsi: dst
@@ -332,7 +333,7 @@ SYM_FUNC_START(__blowfish_enc_blk_4way)
 	RET;
 SYM_FUNC_END(__blowfish_enc_blk_4way)
 
-SYM_FUNC_START(blowfish_dec_blk_4way)
+SYM_TYPED_FUNC_START(blowfish_dec_blk_4way)
 	/* input:
 	 *	%rdi: ctx
 	 *	%rsi: dst
diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
index d0d7b9bc6cad..e5d9b299577f 100644
--- a/arch/x86/lib/memcpy_64.S
+++ b/arch/x86/lib/memcpy_64.S
@@ -2,6 +2,7 @@
 /* Copyright 2002 Andi Kleen */
 
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 #include <asm/errno.h>
 #include <asm/cpufeatures.h>
 #include <asm/alternative.h>
@@ -27,7 +28,7 @@
  * Output:
  * rax original destination
  */
-SYM_FUNC_START(__memcpy)
+__SYM_TYPED_FUNC_START(__memcpy, memcpy)
 	ALTERNATIVE_2 "jmp memcpy_orig", "", X86_FEATURE_REP_GOOD, \
 		      "jmp memcpy_erms", X86_FEATURE_ERMS
 
-- 
2.37.2.672.g94769d06f0-goog

