Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9E25A71E1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 01:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbiH3Xdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 19:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbiH3XdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 19:33:12 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF72923C7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:32:20 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-33dbe61eed8so190027947b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=nLLyHDlqzsc75HWG24SP3SGpvgxZ9V3UrO9VtB9+qSI=;
        b=en0MzguAxkGbIecpah/2+Xtucf1JeujXbvoM8sjRtirhhrivHvxhOjjc8XjIzzeau8
         iqt1tYXFNwhoWt5JWeB4Qw2qlLDvMb/FnG5C3eS8G491X1vHXz0fHYMZX1mCaWmfqEYE
         agDpOC3DvDklQ/bhO9Poq/QtFeuzNG3cbZCXHMxiTbMs7SG2qxg6Kbqnwl9dno9zUMG2
         5VzNwoxM8xnkUvu34R3iEDgv5EmULHaDWzsDMefk0MmRNFil+hz5Zq7BNEzV9pCGj39X
         e1LMfsrVWFIodkOV3rtExT4NeR8FXBpwSdqVScplR/PL2lzHJurkhJNRjTTB2IFcWpJ3
         EKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=nLLyHDlqzsc75HWG24SP3SGpvgxZ9V3UrO9VtB9+qSI=;
        b=icsqLRdwQDYDqAMcPTD6RQt1QW1rtNNUva1dK2g8lH/f0eVnweJSwwqprSkGPoTYHB
         wSrkI331VTdqNz+JLBCndmf495npxn5YsPNDyz01WLg0WVEcYxV1/mX2a1Z8sfmdXgi/
         gwTIPdZa0QWlbnn807WdgrXZH5oRcflnSBsQF+VUnGUy7LVpEPpy8mqSxRGWOcvVuBt7
         DOHZjZLT1hP6IEzn+wMd4SgpZyfI/aSNJ8EvTUKh7YL2qNOUym719yUMDsuyob6chlDD
         W16fkuQ9DycpU0QSI7kxccEzmSHj88A3YuapLnRGhr1RV+bTM1INOvSV/sDrcrZxh2DH
         g3MQ==
X-Gm-Message-State: ACgBeo1rnDHx0nsgPJ67m9BLMxnVmGsJ0z+Pq6lKLGlwBfm4i2PacnF9
        RBJQ050Of+Apbov7cg9R8dmdVNnOJmm8LFaIEO5DXuph/rH92XenMMYY+2T8qgrGG18zgCLvCQ7
        s8/JznVRepsBNlV1Iraz1oJuIdvE7MbxKmBnxcqchq7nvPEszmr/m7/5nHRGzJWkRH+cG2XLSKo
        F2H7V7QSzcsw==
X-Google-Smtp-Source: AA6agR5h5efzqOVxmYbBIWgxJ1MECNbgPa7xGsG/CYzCNefyQ5w5lz2oa6+rUdM0FZqOdRsfe2EIRX/Bqx3hGl+nnMQ=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:54d9:7143:6a7d:91d])
 (user=samitolvanen job=sendgmr) by 2002:a25:be87:0:b0:67a:7054:c7bc with SMTP
 id i7-20020a25be87000000b0067a7054c7bcmr12511319ybk.601.1661902339549; Tue,
 30 Aug 2022 16:32:19 -0700 (PDT)
Date:   Tue, 30 Aug 2022 16:31:25 -0700
In-Reply-To: <20220830233129.30610-1-samitolvanen@google.com>
Message-Id: <20220830233129.30610-18-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220830233129.30610-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1274; i=samitolvanen@google.com;
 h=from:subject; bh=qCBEQ292K21rpauKv4Q9PKWzetqPm8IIUDXN8zVxiiU=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjDp3OneDI8EsrD6700CYZ72DWnEF3yumMXVukuUYd
 6cc6WzSJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYw6dzgAKCRBMtfaEi7xW7v1gDA
 CrSV1Wwh1iRkXrTLzRUVixDQymyEMNfAV5Asek7kdMhsjE05imH4BPAYNwaeaYeCR/FdZowXX2/dg9
 uEvPso2aCMbdLJGMwK6HCPU0doxBN9bJ1Aghq8QSlLsvALuOYSHp204OxDb0UgUSCEoR6QxsQjww7p
 CkqIcDUIxxhgbZeB9GMuN90ATOpI5Tt/TjewRuGkDuiU2wX05LdVmyaR7uBC86YUkzrjzuNFycLxXE
 NjRh/eHVQPO6JRX5WHJFfMPJe3lTKuueweypQevFID/GR98VcRSjCttni916V11TYs8EbLYPoFNKYq
 jZtDfTIy1xRp4DhVWxfZub7EQi+dScfRbD+lUUzdGEqL/LUxdBDfS1TfIn69wnuD5X7wcDu4gLAcZw
 I2kDiw8qMGqDQd2spFj2dU2XCRZPX7T1HOjUU3U34FxzhEpjzO/hNzpNcB1ZBgTU8btt4TEoN7mMlK
 Y3FIWCZ7I5c0LXttu3a5FcrhHHCxcpdQKHjz89NVuaF0Q=
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v4 17/21] kallsyms: Drop CONFIG_CFI_CLANG workarounds
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

With -fsanitize=kcfi, the compiler no longer renames static
functions with CONFIG_CFI_CLANG + ThinLTO. Drop the code that cleans
up the ThinLTO hash from the function names.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---
 kernel/kallsyms.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 3e7e2c2ad2f7..b27e6ea31f8b 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -159,7 +159,6 @@ static bool cleanup_symbol_name(char *s)
 	 * character in an identifier in C. Suffixes observed:
 	 * - foo.llvm.[0-9a-f]+
 	 * - foo.[0-9a-f]+
-	 * - foo.[0-9a-f]+.cfi_jt
 	 */
 	res = strchr(s, '.');
 	if (res) {
@@ -167,22 +166,6 @@ static bool cleanup_symbol_name(char *s)
 		return true;
 	}
 
-	if (!IS_ENABLED(CONFIG_CFI_CLANG) ||
-	    !IS_ENABLED(CONFIG_LTO_CLANG_THIN) ||
-	    CONFIG_CLANG_VERSION >= 130000)
-		return false;
-
-	/*
-	 * Prior to LLVM 13, the following suffixes were observed when thinLTO
-	 * and CFI are both enabled:
-	 * - foo$[0-9]+
-	 */
-	res = strrchr(s, '$');
-	if (res) {
-		*res = '\0';
-		return true;
-	}
-
 	return false;
 }
 
-- 
2.37.2.672.g94769d06f0-goog

