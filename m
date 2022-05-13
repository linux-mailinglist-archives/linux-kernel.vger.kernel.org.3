Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657AB526B31
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 22:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384328AbiEMUYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 16:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384163AbiEMUWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 16:22:42 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D518B1654B7
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:22:18 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id o7-20020a17090a0a0700b001d93c491131so6680005pjo.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 13:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=f+v85zCmompJWMzZo0Lo44MXyCG4blaViTEubU7Q5pk=;
        b=MESMouEFY2G4SFqcafmefQWoFCP7ps3QB1tZ46af/jtYe6cn5zcxOwxTwft4N8E1NQ
         +UuIHuj5VEcDhbnPdN1c0OsP0m7BBsr8MIip1QKYnYg6zeoMy088Pl9eVtEl5uK0saGo
         XtR42j6pIymFijnyo6XcDzAed95J3W7UJ8IviGf6zqWy//NvXfkBj+GJVwnuCt9lcOFH
         Z4nLVMl3mKjxxgvlkFCBZewyyE5+nMu5wsw21EWC3AA96x/4tIfvIZsY75Roh12akrho
         avQ626Wx3RZtmrx/IEAGQSI1UB2H2FZgt4JgCTLLjEpfu6Qdx7RMgQixkMV7q4jIt2ca
         yN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=f+v85zCmompJWMzZo0Lo44MXyCG4blaViTEubU7Q5pk=;
        b=2iMiZ14QobL71K1BOQqdcfSxiJn5OeHgtNcqh+h9vKmo/Q0XTPbAqUnrtjG3WBCdMC
         bjL7EJPKlXhdnsCJBITf0tOJy9W355B4Y0hltK8uJNtEhjCoLo/AHYpIzd8spTc7mr1i
         QuwHndpFrAcMtNOShZarfxBMextiUxNOgxWAMXf8JlNARSXhHMt5fhIdXZy9PxyJmiyR
         PWEjkC1+BOUAhhj2DuynZomxsUGZX324GKKZMofcYv6AYstHgT6tXGd6KD69wSAz/Bhu
         vvVfDk2W3JukKX6OKawUwh4bLwVq0KLlivKR/5jG8rhzr+l2nUouCMfj6kGhRrJfCGuQ
         bR5g==
X-Gm-Message-State: AOAM530/nlEKu5FdWHyJA8fd0JCLlI+BkEVvKkU2BR04NOFU2AjOPz4Z
        rabfrduUohBxNJqv4bQNzFAlL9yxNBvKuQ+zOmXTlVMFqQdfdC9IsnSYr22cEd929o9T4tNchVK
        I6alykGaA87Ztas0nuwk2gMSd7mqw+Cpnkb8pvOOzxS22iLclVbTZFFb1rzDaOuU/+NRyD4TRju
        fMcZt8K5lZrw==
X-Google-Smtp-Source: ABdhPJwfcFjFJSZbXy4dFXWlYx0UTPoVmJGQDFAqlwZxMLFtphKEHH2VS3sWnVMuhcTFKwv+pj6ccI88tY8WuVvcx7E=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e0:c17e:c2dc:13eb])
 (user=samitolvanen job=sendgmr) by 2002:aa7:88d1:0:b0:510:3ee2:3f25 with SMTP
 id k17-20020aa788d1000000b005103ee23f25mr6048858pff.41.1652473338024; Fri, 13
 May 2022 13:22:18 -0700 (PDT)
Date:   Fri, 13 May 2022 13:21:45 -0700
In-Reply-To: <20220513202159.1550547-1-samitolvanen@google.com>
Message-Id: <20220513202159.1550547-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=2369; h=from:subject;
 bh=TboG0ryIg4JgbMTsV2OXgx0SX/UFOnu1UldMJxVt8Po=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBifr3j4WY4BkbqYI6dC/ZfJbPOV8T4fFdqndEpsBM/
 hV5fbI2JAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYn694wAKCRBMtfaEi7xW7gMxC/
 4pxFRx4HmL+KUme/ZjGLLUnoT9FbQCcyon3/8qR0GI2jddZNW3zIDnAihW+p9AayVGcFBw/cucqeD6
 aXfUmw4i5Efc8tn7VJtIfgwBMJEeT97CO0koKO1cJfqhLgyPXQDEp5x3qbmJIPEvXkFbMwd9T0no37
 HPRxilpeC2rxuO4N07WfXvHHMyvz873twQyminhgkImNDn8LWrzNZD2TYLXYTmCSbYCFGu5tXSDEhw
 ZHK28QweaPZFMYbk0wN8AvV4LKrTN0/LJoOuYP485lixfm/DeCd/25TzV57VDBt4ZfW/VlEHh4RkgX
 cFHax638u12jlXDQHJK2SS7MLmlojw27IhKgnEszme11T0yFry4yEqhhcfa1m4PMtHA6DBWFAZjYwA
 CCw/0R+hbTncTA8X3SMH0fWDvX+13ZsaiGA+rH7eLAG+M6F+T6JF6K+96BK3G6xvoablbMV270wlb8
 +GZCYAV3P1rotvaWrcFV5saGNcr9RR12T6hfVDEQ+LtAA=
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [RFC PATCH v2 07/21] cfi: Add type helper macros
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

With CONFIG_CFI_CLANG, assembly functions called indirectly
from C code must be annotated with type identifiers to pass CFI
checking. The compiler emits a __kcfi_typeid_<function> symbol for
each address-taken function declaration in C, which contains the
expected type identifier. Add typed versions of SYM_FUNC_START and
SYM_FUNC_START_ALIAS, which emit the type identifier before the
function.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 include/linux/cfi_types.h | 57 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 include/linux/cfi_types.h

diff --git a/include/linux/cfi_types.h b/include/linux/cfi_types.h
new file mode 100644
index 000000000000..dd16e755a197
--- /dev/null
+++ b/include/linux/cfi_types.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Clang Control Flow Integrity (CFI) type definitions.
+ */
+#ifndef _LINUX_CFI_TYPES_H
+#define _LINUX_CFI_TYPES_H
+
+#ifdef CONFIG_CFI_CLANG
+#include <linux/linkage.h>
+
+#ifdef __ASSEMBLY__
+/*
+ * Use the __kcfi_typeid_<function> type identifier symbol to
+ * annotate indirectly called assembly functions. The compiler emits
+ * these symbols for all address-taken function declarations in C
+ * code.
+ */
+#ifndef __CFI_TYPE
+#define __CFI_TYPE(name)				\
+	.4byte __kcfi_typeid_##name
+#endif
+
+#define SYM_TYPED_ENTRY(name, fname, linkage, align...)	\
+	linkage(name) ASM_NL				\
+	align ASM_NL					\
+	__CFI_TYPE(fname) ASM_NL			\
+	name:
+
+#define __SYM_TYPED_FUNC_START_ALIAS(name, fname) \
+	SYM_TYPED_ENTRY(name, fname, SYM_L_GLOBAL, SYM_A_ALIGN)
+
+#define __SYM_TYPED_FUNC_START(name, fname) \
+	SYM_TYPED_ENTRY(name, fname, SYM_L_GLOBAL, SYM_A_ALIGN)
+
+#endif /* __ASSEMBLY__ */
+
+#else /* CONFIG_CFI_CLANG */
+
+#ifdef __ASSEMBLY__
+#define __SYM_TYPED_FUNC_START_ALIAS(name, fname) \
+	SYM_FUNC_START_ALIAS(name)
+
+#define __SYM_TYPED_FUNC_START(name, fname) \
+	SYM_FUNC_START(name)
+#endif /* __ASSEMBLY__ */
+
+#endif /* CONFIG_CFI_CLANG */
+
+#ifdef __ASSEMBLY__
+#define SYM_TYPED_FUNC_START_ALIAS(name) \
+	__SYM_TYPED_FUNC_START_ALIAS(name, name)
+
+#define SYM_TYPED_FUNC_START(name) \
+	__SYM_TYPED_FUNC_START(name, name)
+#endif /* __ASSEMBLY__ */
+
+#endif /* _LINUX_CFI_TYPES_H */
-- 
2.36.0.550.gb090851708-goog

