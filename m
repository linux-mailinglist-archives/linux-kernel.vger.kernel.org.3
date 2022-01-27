Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBAA49EA2D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 19:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239257AbiA0SNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 13:13:08 -0500
Received: from mga02.intel.com ([134.134.136.20]:21234 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245730AbiA0SMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 13:12:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643307144; x=1674843144;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=E06cVMhqPAPIMCSf0L0zsFNmzkakCpFSnGx6c4dp0A4=;
  b=eyPw1wSEGo6U4dRajWZAZU5zytPjpWaY7cNfOB9DyJ9v38GPH8UNMn6X
   9Enr/dG/2a9iRDz/6/7mQgjvFf549Tm5a3fKoBxaNuVxIUffF1AeZm4Pn
   fkzFxOlohYz4/IsGP5mv4+9pgixEdyWVN0wGcO4lZnoUCKe5LSnYLvh9U
   s6I9kAkXvoD8Ht1FaWL5Nqws7y0QI4u1JiuxdOJRZh32/9W1E93NN6Tc6
   sL3y/ukqSEd3Szl8WndThEcTYT6cp0cE+zefL6TTO3oS8ONNI7O1oNpce
   czoV78unyKWm0wd5/B70kdYViFf2YGYGphq5eOH9gEWX3bltn0rhmxI9Z
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="234307403"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="234307403"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 10:12:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="618424130"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Jan 2022 10:12:21 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B95BD167; Thu, 27 Jan 2022 20:12:34 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v4 1/2] vsprintf: Fix potential unaligned access
Date:   Thu, 27 Jan 2022 20:12:32 +0200
Message-Id: <20220127181233.72910-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
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
v4: no changes
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

