Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61DB14EFB6B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 22:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345192AbiDAUYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 16:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352484AbiDAUXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 16:23:49 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A70282554
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 13:19:24 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2e689dfe112so35258477b3.20
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 13:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ATcdLAiyB0HmFVQDg4Xl7rvZSmepnr+daM3v/Y+LeMI=;
        b=EoyjCfGV3FCQpOkbXV+W3kTnXGO1Evzvf/ZY38A9M1NFlrIqtx1VS6qnTsGBd7BwjX
         WoMjEr/RMAn4q8VmBMj6mKCCSJYHInMMKdfBk6wZQvwoBizwF+NZ8BoF/h/iCTmyVqoC
         G7HNo6/dYJ2gtGhM3NTwMeNao+r+TProu7GExptuAVxeL/kk3ZIkTTOekXFAtNjuD2NU
         ma1hWOS5qp5Duz30EY9BFcZJwxIWP8vW/FC5lCWqXj8YNzw5RVfVB8q0U357R2cNp4mw
         hIbFGaH0dJMNrmMTAzN7dJIn2fB0mcgwx8f4VQjnqYm/fpUcfe0YQqEExQvrwoLFRu3/
         Rs/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ATcdLAiyB0HmFVQDg4Xl7rvZSmepnr+daM3v/Y+LeMI=;
        b=KgY/+KwWnNtHvxGE3N19bkafrpTIbnY/YLGaYTJZNbvR3/8M5/FUvN+xbSgW5whKGc
         d9TgtqAGWToIrNiNQcM609c4HL1+zgc+JyRRYv1jvKxvMPBVzLNMj9hc0TjkwphpnxMv
         u17IPW3HMt/915jzT9y+Yw0/KiisF0XsGBV/89JiRYE2AbPeQ3BLK6680v9DXjO2e4PX
         1aQM+cSYVw1HOgLXM7glYvDvwN6Af9867gDC7utq+/gsBl6Vd4sJDTZ4TWHLREWHkkJu
         28UgeOG4MUj/mEjrFZ9Uvym0KDLsOh3fQ6hj9hMdf7MeojPGJ7+4JfGSAUD0ee6QEFj/
         +UDg==
X-Gm-Message-State: AOAM530WCoBKO74leZqGxP5Sb/M1d6Gi5EjmhX+OCBT2qNKqKpUq0ile
        i/RuzsxfbKpMbaVRP8ROGSFXK8hPCg4SPUijikM=
X-Google-Smtp-Source: ABdhPJyew2kq+WRmdfIe6euP7IdAfz4Lf1J4a3hpbhDfzorQRebEdIXVNDbDfQueKfPJDVocv/gDvOOrkxzODDApak4=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:ebe8:1acf:913c:f19e])
 (user=samitolvanen job=sendgmr) by 2002:a5b:90a:0:b0:634:15f3:871b with SMTP
 id a10-20020a5b090a000000b0063415f3871bmr10173555ybq.306.1648844363642; Fri,
 01 Apr 2022 13:19:23 -0700 (PDT)
Date:   Fri,  1 Apr 2022 13:19:15 -0700
In-Reply-To: <20220401201916.1487500-1-samitolvanen@google.com>
Message-Id: <20220401201916.1487500-3-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220401201916.1487500-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1056; h=from:subject;
 bh=TxU5yU7eF6HnJJtCowWe9icJOHczcBwSXoiV/s/cDrI=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBiR15CugMAC3++WEpyG4vENztHvLXakUUYXOQsyeYl
 rVPXFE2JAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYkdeQgAKCRBMtfaEi7xW7gliC/
 9FfQ7TZrKMqndhgdzS0eK9T5tspAJnIZpf3oeBTdH1yAeQIwZvHzFf76rSoqV6LrbI+gqMeIdHKr08
 UIVlKWpl6xs1zdEc+NvkBalo7cGuCVrQhcVyGSCHyr4qFrtFKg3hA4cA134xfBCef2dRq4OlcjlxyW
 noFvvInv0CUwZj+cCNYqM5+PjO39zKKvvYF0L6VlWVNn7Fa3UCbymDa6AcmA7O6TO7t+SExVQ1nE8W
 vTxJKJBAKAt1rgs3KjEFPVgalAUFnfhfNCCPeh/SC6LF5++tnbSJCjTFzzpyehcjyrrPscjSrGh7yZ
 pwQxCsuHKH3E7frUwQXCr1167ogQen62ZBUZKyJA3stmJfOtSXlUGXDLPyuNpWNM5SiuQxTE3I9b01
 ptlVlMGTab3Tl/kHLSb2PvyQA2hVbrgske+Vc7c0KZGmn1zs1kS+LUgKIU9z5d0Hu0XyCrg3psuddv
 BDIDadUv7bfb+ZZXkjWwR/kblPiEkSPZWT/MZkK6KiBf0=
X-Mailer: git-send-email 2.35.0
Subject: [PATCH 2/3] linux/compiler-clang.h: define function_nocfi
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

Use __builtin_function_start() to implement the function_nocfi() macro
when CONFIG_CFI_CLANG is selected.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 include/linux/compiler-clang.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index babb1347148c..c84fec767445 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -69,6 +69,16 @@
 #define __nocfi		__attribute__((__no_sanitize__("cfi")))
 #define __cficanonical	__attribute__((__cfi_canonical_jump_table__))
 
+#if defined(CONFIG_CFI_CLANG)
+/*
+ * With CONFIG_CFI_CLANG, the compiler replaces function address
+ * references with the address of the function's CFI jump table
+ * entry. The function_nocfi macro always returns the address of the
+ * actual function instead.
+ */
+#define function_nocfi(x)	__builtin_function_start(x)
+#endif
+
 /*
  * Turn individual warnings and errors on and off locally, depending
  * on version.
-- 
2.35.0

