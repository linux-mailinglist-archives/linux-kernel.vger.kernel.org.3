Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE17A4982A2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240125AbiAXOmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 09:42:53 -0500
Received: from mga03.intel.com ([134.134.136.65]:65226 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239990AbiAXOmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:42:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643035369; x=1674571369;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8H9PEjUZH+4YEQ6DxIij1dmTxSBMZcnykW8dfALIzVo=;
  b=aTRd61SZAqSBSt2znRmPuHKVSlCI9WB2q24LbmPFiniRgMFekmWJVlh7
   MNBeyzcmcokLU8kPhXoAtzjPIhs9a7PhvLq/7omo8ggpUPIXCoJp/MKsL
   97IPoq5r/Kh+0bnNb6pM4nyDWrGxPpnJ/WF5RpqIDmdf3T9+QzBXNr9J1
   xoySxPG4Egw0O/qpml6yJalPFyUWluGRezlVRG+qUQ+Igetq2XVLr03Y4
   RVGwnUg/QJ1Nd3Bd5hsgNkIUFiiBULy9HXrNGQ4Z2PAvsIxwP0lL23aQ6
   T7eh5HM9WPuWwqtMs90S+0SOfhqmh8zjF3ipafQSU+/308CXv/FFutXPE
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="246003683"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="246003683"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 06:42:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="596805620"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 24 Jan 2022 06:42:47 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 99FCF178; Mon, 24 Jan 2022 16:43:00 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v2 2/2] vsprintf: Move space out of string literals in fourcc_string()
Date:   Mon, 24 Jan 2022 16:42:58 +0200
Message-Id: <20220124144258.34120-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124144258.34120-1-andriy.shevchenko@linux.intel.com>
References: <20220124144258.34120-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The literals "big-endian" and "little-endian" may be potentially
occurred in other places. Dropping space allows linker to
"compress" them by using only a single copy.

Rasmus suggested, while at it, replacing strcpy() + strlen() by
p = stpcpy(), which is done here as well.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
v2: added Sakari's tag, replaced APIs as mentioned in the commit (Rasmus)
 lib/vsprintf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 4e8f3e9acb99..e2a1d89f1a5c 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1781,8 +1781,8 @@ char *fourcc_string(char *buf, char *end, const u32 *fourcc,
 		*p++ = isascii(c) && isprint(c) ? c : '.';
 	}
 
-	strcpy(p, orig & BIT(31) ? " big-endian" : " little-endian");
-	p += strlen(p);
+	*p++ = ' ';
+	p = stpcpy(p, orig & BIT(31) ? "big-endian" : "little-endian");
 
 	*p++ = ' ';
 	*p++ = '(';
-- 
2.34.1

