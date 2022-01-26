Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6659849CC2A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 15:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242073AbiAZOTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 09:19:14 -0500
Received: from mga11.intel.com ([192.55.52.93]:35522 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242054AbiAZOTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 09:19:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643206750; x=1674742750;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JQ6FVz6MKQam2G4zqRzGJBSQLaR3TPUafSRO1xcDQjY=;
  b=JLukc2aknxidnJnwb0co7GYb3Aoq3DISMePhSSVvEV6hq3J0nqgUM5dJ
   Yra8fuo64XB88Zo1i8pqMUN4hQZp0k/iBy9K/DD3xz4FqVyW2m/1eJapK
   Bbl8rIFHJdYvvoKtaOZeeysBtBBjHEckCSdT49soHxujXkrHAGmj7WNxg
   uVjt7i5UL01gZmpPciSVjL2tiloro3HSMuWcWihBtC5p9VyDr63tDouRp
   5kHtf29n5TH7eYq/jVYIsNoyHngtnY1utEm+RRA9SRuCmSK3PGMcJks5s
   x6bxyV0v1UQFXnZQSWfjEqddXPPXSloZ63a60hGERwMtlahv4DBu25N6b
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="244157269"
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="244157269"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 06:19:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="477492886"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 26 Jan 2022 06:19:06 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C6557167; Wed, 26 Jan 2022 16:19:19 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kernel test robot <lkp@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v3 1/3] string: Make stpcpy() possible to use
Date:   Wed, 26 Jan 2022 16:19:15 +0200
Message-Id: <20220126141917.75399-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is a good rule to avoid submitting code without users.
Currently the stpcpy() is unusable due to missed declaration.
Any attempts to use it will bring something like:

  error: implicit declaration of function ‘stpcpy’ [-Werror=implicit-function-declaration]

Move declaration to the header and guard it as other string functions.

Fixes: 1e1b6d63d634 ("lib/string.c: implement stpcpy")
Reported-by: kernel test robot <lkp@intel.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: new patch to fix reported issue
 include/linux/string.h | 3 +++
 lib/string.c           | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index b6572aeca2f5..b1aeb3475396 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -31,6 +31,9 @@ size_t strlcpy(char *, const char *, size_t);
 #ifndef __HAVE_ARCH_STRSCPY
 ssize_t strscpy(char *, const char *, size_t);
 #endif
+#ifndef __HAVE_ARCH_STPCPY
+char *stpcpy(char *__restrict__ dest, const char *__restrict__ src);
+#endif
 
 /* Wraps calls to strscpy()/memset(), no arch specific code required */
 ssize_t strscpy_pad(char *dest, const char *src, size_t count);
diff --git a/lib/string.c b/lib/string.c
index 485777c9da83..4ecb8ec1fdd1 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -233,6 +233,7 @@ ssize_t strscpy(char *dest, const char *src, size_t count)
 EXPORT_SYMBOL(strscpy);
 #endif
 
+#ifndef __HAVE_ARCH_STPCPY
 /**
  * stpcpy - copy a string from src to dest returning a pointer to the new end
  *          of dest, including src's %NUL-terminator. May overrun dest.
@@ -248,7 +249,6 @@ EXPORT_SYMBOL(strscpy);
  * not recommended for usage. Instead, its definition is provided in case
  * the compiler lowers other libcalls to stpcpy.
  */
-char *stpcpy(char *__restrict__ dest, const char *__restrict__ src);
 char *stpcpy(char *__restrict__ dest, const char *__restrict__ src)
 {
 	while ((*dest++ = *src++) != '\0')
@@ -256,6 +256,7 @@ char *stpcpy(char *__restrict__ dest, const char *__restrict__ src)
 	return --dest;
 }
 EXPORT_SYMBOL(stpcpy);
+#endif
 
 #ifndef __HAVE_ARCH_STRCAT
 /**
-- 
2.34.1

