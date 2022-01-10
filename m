Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8680C48A122
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 21:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244042AbiAJUur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 15:50:47 -0500
Received: from mga12.intel.com ([192.55.52.136]:62917 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241078AbiAJUup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 15:50:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641847845; x=1673383845;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vFbd1hQxV5gFoIL2FlW7o/5VjonebDsHKha8zvZEqG4=;
  b=CgY+HNNTbUMf9dktMo+xYp6CAbUkSzVZ+YKao8EqNKNJUD9esuL+G/h8
   RyFCp7LmAZXXmHw0C69aTij5J2gbU//3E/owUv4efZ/S4Rg9bheM96TXM
   Zhpidcgx4hLaNnHHNZCnlHzktW8HnG3dn9Pm8pv238QV7MBri+dTmkt2E
   1QdaeYgP3275M1/v4SM+nPiKDg+0UtXfJZFQTJma7dvyDgImQ7QnqxSUM
   BlZ79weqEDpe/tDBe03Mq3ePGcJaSkCLFSHMQ/N2MocdtcSPQsOkXkmZ5
   29x9epiy5v+mZf6iQLiA7LQV1CNv+KMBG1K1Q2Z2cU9MreRxDGJHPBA+m
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="223302381"
X-IronPort-AV: E=Sophos;i="5.88,278,1635231600"; 
   d="scan'208";a="223302381"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 12:50:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,278,1635231600"; 
   d="scan'208";a="690712793"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 10 Jan 2022 12:50:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id F05C2120; Mon, 10 Jan 2022 22:50:52 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v1 1/1] vsprintf: Fix potential unaligned access
Date:   Mon, 10 Jan 2022 22:50:49 +0200
Message-Id: <20220110205049.11696-1-andriy.shevchenko@linux.intel.com>
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
---
 lib/vsprintf.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index c130dcaca5e2..b02f01366acb 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -49,6 +49,7 @@
 
 #include <asm/page.h>		/* for PAGE_SIZE */
 #include <asm/byteorder.h>	/* cpu_to_le16 */
+#include <asm/unaligned.h>
 
 #include <linux/string_helpers.h>
 #include "kstrtox.h"
@@ -1761,7 +1762,7 @@ char *fourcc_string(char *buf, char *end, const u32 *fourcc,
 	char output[sizeof("0123 little-endian (0x01234567)")];
 	char *p = output;
 	unsigned int i;
-	u32 val;
+	u32 orig, val;
 
 	if (fmt[1] != 'c' || fmt[2] != 'c')
 		return error_string(buf, end, "(%p4?)", spec);
@@ -1769,21 +1770,22 @@ char *fourcc_string(char *buf, char *end, const u32 *fourcc,
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

