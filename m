Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068AC49F7AE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 11:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347932AbiA1K4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 05:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242852AbiA1K4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 05:56:49 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77AAC06173B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 02:56:48 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id w7-20020adfbac7000000b001d6f75e4faeso2134688wrg.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 02:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=hOuzpWzwLqePrG7KzMy6POmcapEVAbM5YRYunKpotWo=;
        b=fhKHd24To3BSoahiJrP4xlDXKpCv3i4ceobI3bbA37VyEE3jRp+O4mYy3/TpA/jZUB
         78s9JcvafHZk3Nv+QJ6aCkxV9DZmzWwQgza39CikAKbFpAJH0gRfvxzJxrMR/iUme2H3
         jBo52tynN+ZI9p0SCpL3h18OjUIbSbtNRMJGh80vv2vTRQiN+lFaGOP/UvUEWZe+EzBd
         qo4vUcf5tsb7t+H7W+pSujNUVMXKA/ziuTBUv4540NXCHFMarAxcrf7im8cjNoxjH+Eq
         XhJqmEV3hYNuBw30oMLQ+eJLGDpd3lfJyo0cx764C6KNLR1EY9entQi/H9+gyre8f59f
         GQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=hOuzpWzwLqePrG7KzMy6POmcapEVAbM5YRYunKpotWo=;
        b=CrZcOB8+AuETp7+DP3nTrs9Hmgbk4rs4OvmQtG7e1CPeKq6BDo4H4/SoQWGek1hJLA
         SDwwRTkhBR80iNtiBLz/FF26FSvy22oWsMg94Dmu/VAou4B9zr0p3DBWIpCPQjJxVFCp
         m1Y/M6raTAoQPcMzwVGKrMfamb5Ilx2IjaSmJjfK5fuA+FOmRY58Wya7Tkmfx7qW/7Yf
         04TaKAHw0Wnn7KnK/+cpLNYqSETu/CchUcOXaYfS4TQgcxUGSczqMZqt9ym1p9r0B4vx
         kSo540x6Hs8//DZjHF03Z8E7635a/ewtdoQxKgWr8R1m98urKtakSp53OUoCX87SKBPt
         ZLCw==
X-Gm-Message-State: AOAM530+4w1TV4c2tuOi4YRVktCEGs+kbN/98ms5j1oyrHOA5HPqvvEd
        meu2G+vNWBIsMLV4YH6cUtGmysrLEw==
X-Google-Smtp-Source: ABdhPJzZhi7RO2wuFmy6tcbCdw7/usEDleeyJpfpVLQrgRK/raZHfrPpldl5/HboAaShtwFxDIU0Zk2/tQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f088:5245:7f91:d730])
 (user=elver job=sendgmr) by 2002:a1c:a544:: with SMTP id o65mr15295285wme.160.1643367407413;
 Fri, 28 Jan 2022 02:56:47 -0800 (PST)
Date:   Fri, 28 Jan 2022 11:56:31 +0100
Message-Id: <20220128105631.509772-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH] Revert "ubsan, kcsan: Don't combine sanitizer with kcov on clang"
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit ea91a1d45d19469001a4955583187b0d75915759.

Since df05c0e9496c ("Documentation: Raise the minimum supported version
of LLVM to 11.0.0") the minimum Clang version is now 11.0, which fixed
the UBSAN/KCSAN vs. KCOV incompatibilities.

Link: https://bugs.llvm.org/show_bug.cgi?id=45831
Link: https://lkml.kernel.org/r/YaodyZzu0MTCJcvO@elver.google.com
Signed-off-by: Marco Elver <elver@google.com>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
---
 lib/Kconfig.kcsan | 11 -----------
 lib/Kconfig.ubsan | 12 ------------
 2 files changed, 23 deletions(-)

diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index 63b70b8c5551..de022445fbba 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -10,21 +10,10 @@ config HAVE_KCSAN_COMPILER
 	  For the list of compilers that support KCSAN, please see
 	  <file:Documentation/dev-tools/kcsan.rst>.
 
-config KCSAN_KCOV_BROKEN
-	def_bool KCOV && CC_HAS_SANCOV_TRACE_PC
-	depends on CC_IS_CLANG
-	depends on !$(cc-option,-Werror=unused-command-line-argument -fsanitize=thread -fsanitize-coverage=trace-pc)
-	help
-	  Some versions of clang support either KCSAN and KCOV but not the
-	  combination of the two.
-	  See https://bugs.llvm.org/show_bug.cgi?id=45831 for the status
-	  in newer releases.
-
 menuconfig KCSAN
 	bool "KCSAN: dynamic data race detector"
 	depends on HAVE_ARCH_KCSAN && HAVE_KCSAN_COMPILER
 	depends on DEBUG_KERNEL && !KASAN
-	depends on !KCSAN_KCOV_BROKEN
 	select STACKTRACE
 	help
 	  The Kernel Concurrency Sanitizer (KCSAN) is a dynamic
diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index 236c5cefc4cc..f3c57ed51838 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -27,16 +27,6 @@ config UBSAN_TRAP
 	  the system. For some system builders this is an acceptable
 	  trade-off.
 
-config UBSAN_KCOV_BROKEN
-	def_bool KCOV && CC_HAS_SANCOV_TRACE_PC
-	depends on CC_IS_CLANG
-	depends on !$(cc-option,-Werror=unused-command-line-argument -fsanitize=bounds -fsanitize-coverage=trace-pc)
-	help
-	  Some versions of clang support either UBSAN or KCOV but not the
-	  combination of the two.
-	  See https://bugs.llvm.org/show_bug.cgi?id=45831 for the status
-	  in newer releases.
-
 config CC_HAS_UBSAN_BOUNDS
 	def_bool $(cc-option,-fsanitize=bounds)
 
@@ -46,7 +36,6 @@ config CC_HAS_UBSAN_ARRAY_BOUNDS
 config UBSAN_BOUNDS
 	bool "Perform array index bounds checking"
 	default UBSAN
-	depends on !UBSAN_KCOV_BROKEN
 	depends on CC_HAS_UBSAN_ARRAY_BOUNDS || CC_HAS_UBSAN_BOUNDS
 	help
 	  This option enables detection of directly indexed out of bounds
@@ -72,7 +61,6 @@ config UBSAN_ARRAY_BOUNDS
 config UBSAN_LOCAL_BOUNDS
 	bool "Perform array local bounds checking"
 	depends on UBSAN_TRAP
-	depends on !UBSAN_KCOV_BROKEN
 	depends on $(cc-option,-fsanitize=local-bounds)
 	help
 	  This option enables -fsanitize=local-bounds which traps when an
-- 
2.35.0.rc0.227.g00780c9af4-goog

