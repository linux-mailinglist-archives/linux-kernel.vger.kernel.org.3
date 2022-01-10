Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB0B48A13B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 21:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343666AbiAJU4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 15:56:09 -0500
Received: from mga07.intel.com ([134.134.136.100]:29353 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343685AbiAJU4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 15:56:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641848165; x=1673384165;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SqhJ+SZERdroY6qv3PTyHVdt5EDUrruSkNGX4vaD1tE=;
  b=fU+3cykcIKa1+zMg9JjiDI/rVK6Pp90ZV5fPVMnkHaLKHWPhHTYkZb59
   moOKk0khr/kFSZ47Vx0no7cCwBsXt/EDTOrUO0NCKlRPR5+BTN+LyL8fh
   SZAlJ787enOw6xbSQm8gRbmVdBXgRdaITvI+YJP+BmsFS/JI1w4SOi17m
   82nRDsq3vehfkowkk2Uesw+klDeW34UTXL+kyc6aGZAeuLW9WVU7EgOiR
   fR1os6NptqISHCf/zAB1bshOoDDhd9uaVLSK70ugmAk6A4QcetIEnVnKR
   20QWQ0b/6wF+0wd7ac9WNn8rdouXqnbGe7NzdYyeBD3cM9zg5PI4yHuJM
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="306674365"
X-IronPort-AV: E=Sophos;i="5.88,278,1635231600"; 
   d="scan'208";a="306674365"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 12:55:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,278,1635231600"; 
   d="scan'208";a="612974620"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Jan 2022 12:55:49 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0279F120; Mon, 10 Jan 2022 22:56:00 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v1 1/1] vsprintf: Move space out of string literals in fourcc_string()
Date:   Mon, 10 Jan 2022 22:55:58 +0200
Message-Id: <20220110205558.11876-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The literals "big-endian" and "little-endian" may be potentially
occurred in other places. Dropping space allows compiler to
"compress" them by using only a single copy.

Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Depends on the
https://lore.kernel.org/lkml/20220110205049.11696-1-andriy.shevchenko@linux.intel.com/T/#u
but not to be critical or fix-like.

 lib/vsprintf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index b02f01366acb..5818856d5626 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1780,7 +1780,8 @@ char *fourcc_string(char *buf, char *end, const u32 *fourcc,
 		*p++ = isascii(c) && isprint(c) ? c : '.';
 	}
 
-	strcpy(p, orig & BIT(31) ? " big-endian" : " little-endian");
+	*p++ = ' ';
+	strcpy(p, orig & BIT(31) ? "big-endian" : "little-endian");
 	p += strlen(p);
 
 	*p++ = ' ';
-- 
2.34.1

