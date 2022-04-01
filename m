Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1684EFB6F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 22:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352462AbiDAUYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 16:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352516AbiDAUXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 16:23:49 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6D62742AB
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 13:19:26 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2d2d45c0df7so35844337b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 13:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0tGuel8F0TPZ4i19LuuPjmtXqje2ywWglhe/oIdo5VQ=;
        b=DvT1jTf5TrMmdo+R/peAXWEcfaqI0CTKicq9NuxiQwsvogqT0Q7+PBVGIhAGw7TCNy
         XA1nEIo1hupZyhsJi7y7q+P4m0gAF8th3hcbD65r/heuupKFyJDtGA12HtiIjbdav1ey
         sVWYyVhWomxLYHu+i7sugSFeoTNYJEOmyG5m6bTQ6seZzFdlEpk1qzvgrstj0l0TVQFF
         tN9WCc0YVeZxkyot8V/nyOPv5ANKSaRz7nai4h+sm6dg0N6lPkfTE3H3tlzoPg1I9Rpn
         uWDSC6HUsm6sS1p7G+wlB+eFzpwqTg/wqs6qP7IZwULuwoda474t5/bUAv5m+YSl1wVs
         lrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0tGuel8F0TPZ4i19LuuPjmtXqje2ywWglhe/oIdo5VQ=;
        b=gBtCiMoWP9e2IayKTtnwWrfsyQ9MrTW/k1vTqJ9Fqpo7IMfdyv2Ir0l24T1h1idns2
         5AruebnAkQFRPWBD16SztlVS6XySTAag4OnNzLX2IUizSOpxeiDvvlsQbfamZXC+S6Sq
         ksOwPmXbCSgeO83XrfkyhEaETnzmvJErTzYH7ceqDRf7mR+U6fKFtNOaEe5KJIwU/cFI
         3EfuZFqdfS1Sj/L8ea/OL8TNhKslK6oU6SklyW8aRux7ZSul+b766S9hkbdCVHiDWWl1
         DT4nwuhBiIpqFryzsno/qWjc81k5u8ta/wHimVUPnLw60cJMUDohOubZlPJLtqvTIXAq
         ROIA==
X-Gm-Message-State: AOAM533W925r0jc+K8owm1it8p16ThO1qh6Pz8C6J2RyrPtbJ1pQ6McU
        Dru5TX31QXZE/oQeGuzTemOeKpMFYbd7a4ffj4E=
X-Google-Smtp-Source: ABdhPJyczPJlHMZJ5SsOuDzCQ5Zx+moZV8jK12RncbXJNK4fa4a+uQlY5m3JXXqTHzfRGUCmkCBHysLhBLexKAAxzfU=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:ebe8:1acf:913c:f19e])
 (user=samitolvanen job=sendgmr) by 2002:a05:6902:1546:b0:63b:7960:ca83 with
 SMTP id r6-20020a056902154600b0063b7960ca83mr10524407ybu.52.1648844366067;
 Fri, 01 Apr 2022 13:19:26 -0700 (PDT)
Date:   Fri,  1 Apr 2022 13:19:16 -0700
In-Reply-To: <20220401201916.1487500-1-samitolvanen@google.com>
Message-Id: <20220401201916.1487500-4-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220401201916.1487500-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1278; h=from:subject;
 bh=NtSOtkaS5YpGAma/5363kop1E6xEpoqT3+yVgUVR148=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBiR15Duaw2orP2Ch7LgRIVD7zbYKWzx4lyqqoSUycA
 4hFov6yJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYkdeQwAKCRBMtfaEi7xW7kgxC/
 94YUjQ86qg2QNFo0zOZpLNhNoZrYE9N6UoYuptrK2s5ExRrYLkKkCJoTnZNYg0eD7UR34ThbeM4glC
 bbR7KAIpU4pqZdu44ILdIuLEloNjk8r8i73R/bhhkGEL3DIwo/9qH0kSgPuP7DEN+IKySjZ97vyS1z
 NyepXAChV+OV4sD49Id45jxlRHS5iSZdqpYbxBAulqyymOJq33VhikVIpQkJYEwNqyXhNVoLm42hc8
 Oxo6tsOZhVOPg3XajU/BUx3V/Em7l2Nn31FA/kc0g58a4tBA6JdFV2WjVKUysyRkoL6X0PthHKB09I
 wrp0dKq+MSBAbBfCz/OSVubvE9y0n1Lk+HjUqw8GoGvbbETpcUKMLIzlGucOC6W1bvqy+50alyII+c
 T84eYNyRKv1EoVYra6OF4ul6fnhwOsGJ54+HHdXF81AiQD3jDyKVI/0ZiOYm8KYfa1FSKYzdmfoIby
 tfiURTStJhv2wmBp9Mpjwe7Qbno/3uqLiRsfcLEBiWiPQ=
X-Mailer: git-send-email 2.35.0
Subject: [PATCH 3/3] arm64: Drop the inline assembly implementation of function_nocfi
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Sami Tolvanen <samitolvanen@google.com>
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

Drop the inline assembly version of function_nocfi() now that
CONFIG_CFI_CLANG depends on __builtin_function_start(), which allows
this macro to be implemented more cleanly and in a way that works also
with static initializers.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/include/asm/compiler.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/arm64/include/asm/compiler.h b/arch/arm64/include/asm/compiler.h
index dc3ea4080e2e..6fb2e6bcc392 100644
--- a/arch/arm64/include/asm/compiler.h
+++ b/arch/arm64/include/asm/compiler.h
@@ -23,20 +23,4 @@
 #define __builtin_return_address(val)					\
 	(void *)(ptrauth_clear_pac((unsigned long)__builtin_return_address(val)))
 
-#ifdef CONFIG_CFI_CLANG
-/*
- * With CONFIG_CFI_CLANG, the compiler replaces function address
- * references with the address of the function's CFI jump table
- * entry. The function_nocfi macro always returns the address of the
- * actual function instead.
- */
-#define function_nocfi(x) ({						\
-	void *addr;							\
-	asm("adrp %0, " __stringify(x) "\n\t"				\
-	    "add  %0, %0, :lo12:" __stringify(x)			\
-	    : "=r" (addr));						\
-	addr;								\
-})
-#endif
-
 #endif /* __ASM_COMPILER_H */
-- 
2.35.0

