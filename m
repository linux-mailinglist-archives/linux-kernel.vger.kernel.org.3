Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5786B49EA2F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 19:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245158AbiA0SNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 13:13:22 -0500
Received: from mga05.intel.com ([192.55.52.43]:26055 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239660AbiA0SNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 13:13:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643307188; x=1674843188;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n6E3M8UWzBsWEvcVtIyqdtbk4GF+PEKDvGX0JjTgf6I=;
  b=QaZQH3kVV8a56X/o4FReZ9z+J8I6x5yk5KY51f7yPtCsT4WSPVtB54NK
   CSeHUG4rfsGqfIZ7fmwdlN2OIjsWQQ0sR509SfUcuVOxL+sXEawL0sxUa
   9Dwd1SRBYgNMFgzxmcNzz1firnYt+6xl/XJtgodC+EMHwJC4wfOJGTQAJ
   l0BEwImcfcolXpg3BL3d+1A4CgBimKp7JyJVIB06fQGMCFA/TuKxHF/n0
   WeM+Gx8a+qJndCgmqvJD7/gZ4GxEiVy4nxmM3MR5BTuyKKeOtJf9Zv0di
   wNhCfJdPoRTlYCsjTO6DcbLlVvHZnHd0xaD90Gp9RV+6e2MQcNfq6Yl/v
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="333283806"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="333283806"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 10:12:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="674802242"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jan 2022 10:12:21 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C2B7415C; Thu, 27 Jan 2022 20:12:34 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v4 2/2] vsprintf: Move space out of string literals in fourcc_string()
Date:   Thu, 27 Jan 2022 20:12:33 +0200
Message-Id: <20220127181233.72910-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220127181233.72910-1-andriy.shevchenko@linux.intel.com>
References: <20220127181233.72910-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The literals "big-endian" and "little-endian" may be potentially
occurred in other places. Dropping space allows linker to
merge them by using only a single copy.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
v4: dropped stpcpy() use (Kees), replaced "compress" with merge (Nick)
 lib/vsprintf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 4e8f3e9acb99..a1babe5e07d1 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1781,7 +1781,8 @@ char *fourcc_string(char *buf, char *end, const u32 *fourcc,
 		*p++ = isascii(c) && isprint(c) ? c : '.';
 	}
 
-	strcpy(p, orig & BIT(31) ? " big-endian" : " little-endian");
+	*p++ = ' ';
+	strcpy(p, orig & BIT(31) ? "big-endian" : "little-endian");
 	p += strlen(p);
 
 	*p++ = ' ';
-- 
2.34.1

