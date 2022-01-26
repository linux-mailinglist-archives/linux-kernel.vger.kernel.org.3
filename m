Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D66549CC29
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 15:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242068AbiAZOTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 09:19:12 -0500
Received: from mga05.intel.com ([192.55.52.43]:24800 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242049AbiAZOTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 09:19:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643206749; x=1674742749;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M5CVTpx1kCF7uGC0Cq1C+XvwMU894qljqfUNz/+mZvA=;
  b=ma8gm5OPCrWL/o2/fiqQMTRI7gwexQnqaXsuUMXPsBYsvcoABbgfME5/
   VfIFq9fUwg7RnL8GRO31BV3gL6NfCikxL5Krc0UcbG3ult7urF1w54MLz
   5Ms5zgadQI25sq2mn3yEbVVBEzSlSURVMT7PKcsDqrlySQtX/Dxvy1ZvR
   F3viKijxBb31RPgF45rIeNesVMKXnDWHRw9jqoQOtM8N2Ra6s0MShyQ/3
   ZpOar3AKZU2cH1pZfCW2Q1ELyQQjg/H/PMe4MAxeVXjja896urpvIvxJs
   8XzLdrezEPmKr1I/tBcY6QNuWpQe7OrGX3FjanbarW/bV3tn6O/BqWdOm
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="332911686"
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="332911686"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 06:19:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="581116025"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 26 Jan 2022 06:19:06 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D254715C; Wed, 26 Jan 2022 16:19:19 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v3 2/3] vsprintf: Fix potential unaligned access
Date:   Wed, 26 Jan 2022 16:19:16 +0200
Message-Id: <20220126141917.75399-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220126141917.75399-1-andriy.shevchenko@linux.intel.com>
References: <20220126141917.75399-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The %p4cc specifier in some cases might get an unaligned pointer.
Due to this we need to make copy to local variable once to avoid
potential crashes on some architectures due to improper access.

Fixes: af612e43de6d ("lib/vsprintf: Add support for printing V4L2 and DRM fourccs")
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
v3: no changes
 lib/vsprintf.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 61528094ec87..4e8f3e9acb99 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -49,6 +49,7 @@
 
 #include <asm/page.h>		/* for PAGE_SIZE */
 #include <asm/byteorder.h>	/* cpu_to_le16 */
+#include <asm/unaligned.h>
 
 #include <linux/string_helpers.h>
 #include "kstrtox.h"
@@ -1762,7 +1763,7 @@ char *fourcc_string(char *buf, char *end, const u32 *fourcc,
 	char output[sizeof("0123 little-endian (0x01234567)")];
 	char *p = output;
 	unsigned int i;
-	u32 val;
+	u32 orig, val;
 
 	if (fmt[1] != 'c' || fmt[2] != 'c')
 		return error_string(buf, end, "(%p4?)", spec);
@@ -1770,21 +1771,22 @@ char *fourcc_string(char *buf, char *end, const u32 *fourcc,
 	if (check_pointer(&buf, end, fourcc, spec))
 		return buf;
 
-	val = *fourcc & ~BIT(31);
+	orig = get_unaligned(fourcc);
+	val = orig & ~BIT(31);
 
-	for (i = 0; i < sizeof(*fourcc); i++) {
+	for (i = 0; i < sizeof(u32); i++) {
 		unsigned char c = val >> (i * 8);
 
 		/* Print non-control ASCII characters as-is, dot otherwise */
 		*p++ = isascii(c) && isprint(c) ? c : '.';
 	}
 
-	strcpy(p, *fourcc & BIT(31) ? " big-endian" : " little-endian");
+	strcpy(p, orig & BIT(31) ? " big-endian" : " little-endian");
 	p += strlen(p);
 
 	*p++ = ' ';
 	*p++ = '(';
-	p = special_hex_number(p, output + sizeof(output) - 2, *fourcc, sizeof(u32));
+	p = special_hex_number(p, output + sizeof(output) - 2, orig, sizeof(u32));
 	*p++ = ')';
 	*p = '\0';
 
-- 
2.34.1

