Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A7A54701A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 01:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351035AbiFJXhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 19:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350992AbiFJXga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 19:36:30 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A2A29752D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 16:36:00 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-30c14765d55so5979347b3.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 16:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/YdoENWx/mAwIlav84XtzEM8pJp/ZShtiRERHwv8fgk=;
        b=oDVWPxm862LO41p5JQli72cL6SC3b8g0Trkuno7CCXFvcBjRxpXttKaI/pVSanC/Zl
         Vje4UGYZ39eBOwzo//aMXyNSEWxAdIsd1P0ZTOgqDoI1wod69+tNn1dzVJNB1Ulr8ImW
         scaT2s3l2QriiH4QWW05s8qCU1Amf9b1a4kUP8O73C2Ww55Bi05flppgfkva/QUCzPnm
         XEc6tpJQzpBgkiA+RbTJLVWbhLyu9Rp9sJlbSwJqOfE8hx6Z7Q357nFfHBjtH/1aBAVU
         vqiHQWv6nRu/E2+ZeBLDLh4K2Wxqql+k0neKAZAOZJbjQ2wkknvI39xE1fnHVVuSCaT5
         mMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/YdoENWx/mAwIlav84XtzEM8pJp/ZShtiRERHwv8fgk=;
        b=uiL8qwIPSzW/dxlYKKGKamSF7nSihfyeJ1o3IomDWt91ZPVe0Veaob4se+lbER5rm2
         gyKhVHEEHtz6ll1EQmKvdrq0muIQMrncjcK4tP2MxPQw8/83aNwK1fWaMYPo4xNJPPZ5
         +cdKpCG6/4Q/FkZU3nE20eV+V1oCzJSk8IgY/Hd8mu0/fmZ9SW3RHvx25WstqMK9Ru0O
         A8DPhLrXnkRFqFfA1/2+eEJ1pT7i1KL59kyG/RdaIVrd/X09wpl/OFPoKcNXyyfr+PE7
         pPuNb4qrA5hCfDL/WmdNXiAMDfh03yiot82Ckfe97Tj/cwPYV19aJ6JmlKHWutx0nHOY
         cXSg==
X-Gm-Message-State: AOAM530rL49ZK8OjtZ8sqSrS7Ck/Y/c8zughyHfzwuJGBiSrw0ji47Xd
        2RYEyI390OJojTrk0M6wxbX6VPR73V2vjVFx6/Jm9Roi+PSUgI0FB4lPKgvSDs5KWu0nRnSrsOz
        iEHFTPAWK5uyPNb0JBjogSxFotrtMhgqMsY7ZUEKt23nrTZyl8HWSzS/3jY1oELw/WNAXsnO0Kn
        ydbSjSH0NSQQ==
X-Google-Smtp-Source: ABdhPJwEb7zWbrSyMsHOqlXSAsGrBX3LLXlDk5EbuAiIe6Ma4s8JgFljIZZK1OIRXbt6vvnW+6MZxtlKUU6AP06ljoc=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f464:6db6:3d47:ed14])
 (user=samitolvanen job=sendgmr) by 2002:a25:cb0e:0:b0:663:dc85:b07f with SMTP
 id b14-20020a25cb0e000000b00663dc85b07fmr21155170ybg.267.1654904159638; Fri,
 10 Jun 2022 16:35:59 -0700 (PDT)
Date:   Fri, 10 Jun 2022 16:35:11 -0700
In-Reply-To: <20220610233513.1798771-1-samitolvanen@google.com>
Message-Id: <20220610233513.1798771-19-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220610233513.1798771-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1934; h=from:subject;
 bh=c5fielqFYGYpvsKedyilc/H2Rr+1afjZ3wdMFUGQUCc=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBio9Uv0/7/lO/mnIbFUgWSTs7dx39dQhfjXjGdMwcr
 RtG0qa+JAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYqPVLwAKCRBMtfaEi7xW7gELC/
 44se8OEED7KHWmOg7kDWnbI0YjEa91XqAWcQPsSxThOl3wAQ+rAffK0THfILdMD6dkBgSBFpXTAApK
 t7Y288tyNG52SNBAQ1ZojqnPYABcqVapktuafJehAy+4dWnWQF5fJ5mr+OhqF2UQGlPBcLCkeic9Co
 a9ch7dW02t9qBoM5ibEjhg5/eAvsKCqTgfq2KoSgOqSfcVDWR7I96kD8gdggX+t4laYAEGwnWi6U1o
 TJqzhBuL6wQkvQKh1eIIMIhs64WqdcpKTslcYYGr3zmeIHcrRLqpTwaq1j+P1Z+L+8cfdshksjinj2
 ymXZnhbliJRm977/Yfz42UQqApQfFzcNbBCCHJ/w61KvC2piZoLWn8wW54wrVn0A6MLDb71hJ83Vbc
 4KX8y245LL9weyZHxmVHAn5sHims+Ewn1cNC6C1lndZQrRn+LfXrSEdYdUqOQofoinW/Q4ouN8C/UN
 5juOkNkQLy1RKp9knBH+fAn7C95Nlx+TFJbZHYwT1ank0=
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [RFC PATCH v3 18/20] x86: Add types to indirectly called assembly functions
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
        autolearn=unavailable autolearn_force=no version=3.4.6
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
2.36.1.476.g0c4daa206d-goog

