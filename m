Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B073F467890
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 14:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352498AbhLCNlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 08:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381136AbhLCNlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 08:41:51 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5B0C06174A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 05:38:27 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 77-20020a1c0450000000b0033123de3425so4941263wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 05:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XKWNlK6eqjb2it0WQV9hI/kmA0UJJKcU6ddC1EoDvZA=;
        b=HTAt8exYA2oGWdUvyaIulWi5ZrRu1EP1zOo6h5d9RTG5YftvuG3b2lj6JMbaPob9Y3
         CG3VP1AS2aVWNtGmqgX+E2dJjL8e122T5NqzVpCrZkFfGKMonaLd+UTmI7vy1xD1fdtu
         TAXRX1UqRSrrwqiViqF8NVyx2LHRZMSmHOuRr9ZGt9z8uCHlBPMx19vMSX8DTulR09mZ
         DiOxG63p2Klg6emq/gaoEvMMugh9EG/ki+M79OexpJkfjP5xV94nTMN9SWXRwqVudRu7
         rlP7DpXlmgkubv9dluoD8edmXOqWTei6e5CTY/sKF3P9qZ54fGERnXjN91KfNbpBHPhS
         v/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XKWNlK6eqjb2it0WQV9hI/kmA0UJJKcU6ddC1EoDvZA=;
        b=YrpAQQswopY0iUECWGuDctDZoo9krg7e4HXDXnckvKUjEyQATq1nLPJEILSMzN3em8
         qp6ah11+OOd5x4jID20faBZjGMyRGDu0M/RlpDI4YN2FdfV1asgpNMDF8iq8KPu0v2gv
         /SnW5LRAWqdXUBy4jaWWpWTgiw7n8JEbEaFSut4l2bTBJse9a7XQHxjuj7d60ojgBrMY
         44q0ruiEZZPkdX6zzYSuIIvCRG70owKUL5REcY9X80+G3TPlOU7IaHpAeFxGsAuXeB9A
         x38QfqnpVpUq23y/jaGJ52jl2nvxNBxETk89qyqSuGwSrRKBaNbu7RaDdzliJjYDq5Up
         pM0Q==
X-Gm-Message-State: AOAM531MhiXoYbeeNgPLISJCZqwBHm/EbqaEh0rX+XnWse4wwuY/oz96
        3hKUtbODco4BdHviafHf/6nomw==
X-Google-Smtp-Source: ABdhPJzluDmTysh0GugLGjeBq1MHPEpecFu9Be6OBqJA5ain2+YgtDJeklqeQZTz2qRvcDpIxpJx6g==
X-Received: by 2002:a05:600c:3486:: with SMTP id a6mr14948178wmq.32.1638538705645;
        Fri, 03 Dec 2021 05:38:25 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:cb5f:d3e:205e:c7c4])
        by smtp.gmail.com with ESMTPSA id m34sm5459401wms.25.2021.12.03.05.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 05:38:24 -0800 (PST)
Date:   Fri, 3 Dec 2021 14:38:17 +0100
From:   Marco Elver <elver@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Tom Stellard <tstellar@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>, cki-project@redhat.com,
        kernelci@groups.io, llvm@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        glider@google.com
Subject: Re: [PATCH RFC 0/6] Bump minimum supported version of LLVM to 11.0.0
Message-ID: <YaodyZzu0MTCJcvO@elver.google.com>
References: <20211129165803.470795-1-nathan@kernel.org>
 <202112011140.DA93B3E@keescook>
 <CAK7LNASW2F3SxgR6ydMaW7-ZumsxDv2QQTDqVxqJA1JWN3r4FA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASW2F3SxgR6ydMaW7-ZumsxDv2QQTDqVxqJA1JWN3r4FA@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 05:26PM +0900, Masahiro Yamada wrote:
> On Thu, Dec 2, 2021 at 4:41 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Mon, Nov 29, 2021 at 09:57:57AM -0700, Nathan Chancellor wrote:
> > > This patch series raises the minimum supported version of LLVM to
> > > 11.0.0.
[...]
> Only positive feedback so far.
> 
> All applied to linux-kbuild.

Some of the "dynamic" checks for compiler support unfortunately aren't
as easily grepable -- as far as I can tell, we can also include the
below, which would save us 2 cc-option invocations for all clang builds.

And just in case:

Acked-by: Marco Elver <elver@google.com>

for the rest as well.

Thanks,
-- Marco

------ >8 ------

From: Marco Elver <elver@google.com>
Date: Fri, 3 Dec 2021 14:18:44 +0100
Subject: [PATCH] Revert "ubsan, kcsan: Don't combine sanitizer with kcov on
 clang"

This reverts commit ea91a1d45d19469001a4955583187b0d75915759.

The minimum Clang version is now 11.0, which fixed the UBSAN/KCSAN vs.
KCOV incompatibilities.

Link: https://bugs.llvm.org/show_bug.cgi?id=45831
Signed-off-by: Marco Elver <elver@google.com>
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
2.34.0.384.gca35af8252-goog

