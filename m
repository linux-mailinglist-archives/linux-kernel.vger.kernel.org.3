Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFCBE47A403
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 04:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237398AbhLTDzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 22:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237386AbhLTDzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 22:55:43 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4792CC061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 19:55:43 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1639972539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tzCC7G3AvTtV93R5cgNiYn7nyFLLOPMwI0XOWaNVU+s=;
        b=k/4fttIrV3lU1fNBAxHdXblUTuE0l7/jGV5UfOz2+tUs+ogiIwrkr+FYrHsCCHglqFYM3R
        jWBW+8AenTpl/fUi8fegDo5S9ZHPxL81mUUZSbFYrhZ7yASrmuOo4e9O0Gc+FIND0vuHzm
        eDs3vyiLbgWmAoTSC/1rZVzRrPj1L7o=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     keescook@chromium.org, samitolvanen@google.com, ojeda@kernel.org,
        masahiroy@kernel.org, elver@google.com
Cc:     linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] init: fix the wrong __setup_param() definition
Date:   Mon, 20 Dec 2021 11:54:48 +0800
Message-Id: <20211220035448.12054-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The parameters in __setup_param() should be four rather than three when
MODULE isn't definited.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 include/linux/init.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/init.h b/include/linux/init.h
index d82b4b2e1d25..62a77850f10e 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -355,7 +355,7 @@ void __init parse_early_options(char *cmdline);
 
 #else /* MODULE */
 
-#define __setup_param(str, unique_id, fn)	/* nothing */
+#define __setup_param(str, unique_id, fn, early)/* nothing */
 #define __setup(str, func) 			/* nothing */
 #endif
 
-- 
2.32.0

