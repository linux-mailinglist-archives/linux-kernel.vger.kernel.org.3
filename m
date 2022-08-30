Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6855A71D2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 01:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbiH3Xb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 19:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbiH3Xbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 19:31:40 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DE972EDA
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:31:38 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 184-20020a2507c1000000b00696056767cfso880693ybh.22
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=V3t6t7JIbAvSA8Tk+dwJ0EP+zKfoVcWxCLBhZzDbf1s=;
        b=BJZRO63b+6qTZ95mYkmggV5gs8KD4EmwXqxKHDYQCmIwLDm3YgniZ/250yz/gIN1o1
         UDhgouP28HoSfLMlxUzyUrie3RqWCd1jAJOvkD9cnYfXcC653F8P+perCbezg0NqrJNk
         fMkszVMmG821mLizP9xbJci3/UVQzvsFSAjQusVLzxh/dfx2EtyYJL4EkRKZB8oJo5BX
         YIgzdRMqwTd/pdX/aPujuGXBfS+1cow9p06p/eOjzy5gj+RcIfTa6TkVDGBQaIaT8OMp
         TFBlAR0jRBgRhyDixp6R7SlS1vciR3OouPWVAX03TeXSLEtbzJZVJS5goMVzv3JfQDBu
         ZFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=V3t6t7JIbAvSA8Tk+dwJ0EP+zKfoVcWxCLBhZzDbf1s=;
        b=kKk+Q7pSRShfD5d10GqsYitqlEaD1ZI/rB5sg4JB8DXvyMNIButrAUvY2mGV680DwK
         WhmchNh8A3Fxq+8oDtKSLfK+0zHbJb8jWN4h7aEE7u+P9vCh30gDoUibcFF+fBGDlvTU
         4g7KK57lJD1YSC0nclnGxfs7gKRZmFVmr9sets3M7hqnYlGs76I8WRNPzVQaqk7YWMz6
         /ficidG0KTkTnimGzxL/EZN3+EUV0ulWLVB+Rvrmg9hSOCm109e+T31Q2CBiXbZ6ATst
         Ywj8I4tvsKP7ClrslVhLfz14im0gnFwpoCmdKctwoy8Y0JtdbgqJHnIkjWFWswlLLs4X
         +a7g==
X-Gm-Message-State: ACgBeo3DTDceHTeThmsPfc+uSghTI3x1kLXqO/Zi61GiSVggB8J5I7Lz
        dnLUPJ06M+OJMs+QfG94b80L41wkLTKVp1PAwK0B8Vutc7kQcPvKuQLqwOCfN9r0o8SqCNwfZou
        yGGhkFjF+oItdkOU7JFJ+W2M3UCTZmYJ6boufaVcq+0OZXUsezPOCdTccc2OUL3Mrq6RyeGGDve
        LUVeIQ8Ilqag==
X-Google-Smtp-Source: AA6agR6LXRk/vsm3io9GudAaANlg3qlqmbPfZYO/5+9wavftY3qTlNqavlUs2mptfr8JHyP3G7J0i2tYgLtM61K8Nyw=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:54d9:7143:6a7d:91d])
 (user=samitolvanen job=sendgmr) by 2002:a5b:3ca:0:b0:676:e468:2879 with SMTP
 id t10-20020a5b03ca000000b00676e4682879mr14158623ybp.239.1661902298407; Tue,
 30 Aug 2022 16:31:38 -0700 (PDT)
Date:   Tue, 30 Aug 2022 16:31:10 -0700
In-Reply-To: <20220830233129.30610-1-samitolvanen@google.com>
Message-Id: <20220830233129.30610-3-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220830233129.30610-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=815; i=samitolvanen@google.com;
 h=from:subject; bh=ZsdbFV1rDPVMEEnz8gpkcJ4SEVi2nPPUZtGW8C9VlOE=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjDp3LuiRNOIXF6iWJdViGqd3zv5mS4LojAiJ+2zw1
 RBe4TiiJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYw6dywAKCRBMtfaEi7xW7hbdC/
 9dH+eF9FLRfbAZmIKkZfKGLDEV4GpzyFt3DC0T+XPYawpv8d4hIHcmWOewSokNp8/RlQxEqhucG9Zn
 axIaqhwCi2QhLKvRZcwmhKgvB25LWwrp6pMh94YrnGXvlD4ZGovDQk7afANRYpvaJuBWvNDjJMfcM9
 IMHPn/dIoby0cmKnGFT9OKty5s0M6RvrxxqzZZEVxwms885iZiHHnH1gSB2c5RlKNgSxrpvfzr6gB5
 VgzIUn3LcrpQ9eYEcaYRquZJotPXSZwdymKNF+l7zsSqZZzMkyXcLEY8JSPcDyhYBdFlHyA9oq+hqf
 FOCm74Um/Gr8A1LV7ognHe7JEPGjOh7sx3AJcXUtyPCn7FtdZU2V/f+thDRCL7FfgnF9UDZs0DMpqq
 PT0C1GB58hHVS0/Y/twOGM7f//NBSc140Y0yOTXRWtQuwHvAzfA6mSE55KlboU2m6pMC8JKeSW7PsL
 +uWT5s6GcBEfGDclqFu6GC1EpRCfJ/6w0iOUYXTCADGSE=
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v4 02/21] scripts/kallsyms: Ignore __kcfi_typeid_
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

The compiler generates __kcfi_typeid_ symbols for annotating assembly
functions with type information. These are constants that can be
referenced in assembly code and are resolved by the linker. Ignore
them in kallsyms.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 scripts/kallsyms.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index f18e6dfc68c5..ccdf0c897f31 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -119,6 +119,7 @@ static bool is_ignored_symbol(const char *name, char type)
 		"__ThumbV7PILongThunk_",
 		"__LA25Thunk_",		/* mips lld */
 		"__microLA25Thunk_",
+		"__kcfi_typeid_",	/* CFI type identifiers */
 		NULL
 	};
 
-- 
2.37.2.672.g94769d06f0-goog

