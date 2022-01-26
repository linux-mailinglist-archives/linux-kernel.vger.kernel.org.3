Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5517649CC27
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 15:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242056AbiAZOTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 09:19:10 -0500
Received: from mga05.intel.com ([192.55.52.43]:24800 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235570AbiAZOTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 09:19:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643206749; x=1674742749;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IMYFtQz9rkY/3tjpaVw7Apkf5zFNR7UXirlLlWW0FOM=;
  b=JgqLl8f3JNontWOhpVwx7uJGyxgKMCBiDtv3wxkhgv/uldXyA1jJfqlP
   DHa+4822gpkMI6SJqDcRScmCLgbKRncmeGxtYXzDm0Y3ZMJUAhwI7nHCh
   PisoZgO7c6wAWsJMgelTJv9ZWkKoD2TiTar9I9T86pJhcZfcBXa0tWrbQ
   cZ9j3aCbxdIc7chcSE/2FJH9EEyz5KOG0qbkGr6DNwgz2tSgP0eS3ClMI
   4L9uLLET+7R2ezsY6+9iHe0L1sX/pRJk+VWd50nvvFcQL/7b8DTBADnMN
   wB7/QudRgWSia8mt5g4fscGHVygRm5TPlJd5OgD+Rtv+bAj9hjKWuui2k
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="332911687"
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="332911687"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 06:19:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="581116026"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 26 Jan 2022 06:19:06 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DE4625E4; Wed, 26 Jan 2022 16:19:19 +0200 (EET)
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
Subject: [PATCH v3 3/3] vsprintf: Move space out of string literals in fourcc_string()
Date:   Wed, 26 Jan 2022 16:19:17 +0200
Message-Id: <20220126141917.75399-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220126141917.75399-1-andriy.shevchenko@linux.intel.com>
References: <20220126141917.75399-1-andriy.shevchenko@linux.intel.com>
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
v3: no changes
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

