Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53E7F4759E3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 14:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237501AbhLONrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 08:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbhLONrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 08:47:52 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038C6C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 05:47:52 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id l34-20020a05600c1d2200b00344d34754e4so1937201wms.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 05:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=OiRhOn6hhEzgrwgWwdtGgn/CZg2YKiK3rEUHDdKnpy4=;
        b=dz6MSih8U6A2edXcGzmgJn2xpFVEX0X+AuXvNAs6fZUjF391UFlHyRHFy1SpVnE92h
         6bcCFw+dbJPic8Ypvwz3PFUBNsnqveWqIKjsxaw1c6s+0HeDc9nXBCl1fpneMMPhGJEh
         hGp/6fswZV5s7PcGQdX5SoMdgeXdqRov1TsdORAQ9yHVadGvfr1q+8fSZCO3blq9u0Hp
         BOl4cKbxT7Etdw9CoGzDT8LD0FwWo3pRdN4AxW8Gy0crJ6AXhDt/JPFuH6sUcMODYTUN
         A4fiMN5n7G+KvayTCTTqkbo3Ztrohgv1/Ack1xDCYohAflmSiYjGUfZApx90JKT+aX4e
         GXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=OiRhOn6hhEzgrwgWwdtGgn/CZg2YKiK3rEUHDdKnpy4=;
        b=3J9e4fScz29obapzAS83AVI2gHjSBA0Ei3/JST2PxUsKUbmZaBOknpglYLqo2kiU45
         VjynvT3xUXVYGTzrYpumDLR6HnJzzejskYYBNJ0jG4m2O1Z1HpdMBhgPzERsIr5ZQzLV
         dFTmMRjQaFy5Hpmuyau5NG7HswDztVOqmf6BrrBLNZhSEslYLmg4PHW4GlaKx9ihtXxz
         tfYf428APSzDbkWsh5EATENeK/3U7jafmYBjZVL8JUsckdasZz2mcO7NuIT6NDP9nun7
         C1SdycdR4z+fy6PnPnT3AM7RMVppQzV8Ij9RRPm7t9upuRN1QMe2mTG0CeXIpwAPHjLC
         8TLg==
X-Gm-Message-State: AOAM530pDBgsK7i/WnSTewCf87dKSM101darTJPWuWeosthwzeGc0YqQ
        TTqIcrJpCBzJ3EkUS8cR1/ZzSJQxtw==
X-Google-Smtp-Source: ABdhPJxLc2N+PgyfZwzGx4wdTK3j0eOkYqce+1YFNfeu6XJYmCTIGga/14R9lp7QLNgHtyLFNOn2K/hQlQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f9c2:fca2:6c2e:7e9f])
 (user=elver job=sendgmr) by 2002:a05:600c:4e56:: with SMTP id
 e22mr2873386wmq.39.1639576070516; Wed, 15 Dec 2021 05:47:50 -0800 (PST)
Date:   Wed, 15 Dec 2021 14:46:18 +0100
Message-Id: <20211215134618.3241240-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH -kbuild] Revert "ubsan, kcsan: Don't combine sanitizer with
 kcov on clang"
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit ea91a1d45d19469001a4955583187b0d75915759.

The minimum Clang version is now 11.0, which fixed the UBSAN/KCSAN vs.
KCOV incompatibilities.

Link: https://bugs.llvm.org/show_bug.cgi?id=45831
Signed-off-by: Marco Elver <elver@google.com>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
---
 lib/Kconfig.kcsan | 11 -----------
 lib/Kconfig.ubsan | 12 ------------
 2 files changed, 23 deletions(-)

diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index e0a93ffdef30..b81454b2a0d0 100644
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
index e5372a13511d..31f38e7fe948 100644
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
2.34.1.173.g76aa8bc2d0-goog

