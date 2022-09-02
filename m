Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0A55AB8D0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 21:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbiIBTTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 15:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiIBTTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 15:19:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90E313FAA
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 12:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=7B1bP43T4TsN5mlzm3oT0pIi9mydxUrRr+WAWif2/Tg=; b=kCjFamQWgE4xGjauY+7NsB6Tam
        2E4FeiVBeS1UnBM1lG/dVDUE2sgGSuAnk38ZK/gy0kNeZn1GrAl0srflSErQWI0cEFGJu2n+XHuE2
        DO/FNBUSNxGb2u3kfUgKB9uLw+DMOIFeGARZu6ufWuRcMdQ5/cxXkHORA8daZNNDwewOVaHwWUHmm
        +OLcyE5qKA40VekSSuXqZAO/CSDLU3IEQpxFX3krSV7uaj/N2QHCxshsQQtTXESz9ZITMOho8eGIQ
        qnAtfFFS8MKlJuTzGpxPW51x9RwWJ0+bGu3NhkweKeDMgP7S27LMLqwR0eQ90pSJIfM8RtztY5TAc
        93v6Jk4w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oUCCQ-007HeG-KI; Fri, 02 Sep 2022 19:19:30 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Yury Norov <yury.norov@gmail.com>
Subject: [PATCH] tools: Fix compilation after gfp_types.h split
Date:   Fri,  2 Sep 2022 20:19:23 +0100
Message-Id: <20220902191923.1735933-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When gfp_types.h was split from gfp.h, it broke the radix test suite.
Fix the test suite by using gfp_types.h in the tools gfp.h header.

Reported-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Fixes: cb5a065b4ea9 (headers/deps: mm: Split <linux/gfp_types.h> out of <linux/gfp.h>)
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 tools/include/linux/gfp.h       | 21 +--------------------
 tools/include/linux/gfp_types.h |  1 +
 2 files changed, 2 insertions(+), 20 deletions(-)
 create mode 100644 tools/include/linux/gfp_types.h

diff --git a/tools/include/linux/gfp.h b/tools/include/linux/gfp.h
index b238dbc9eb85..6a10ff5f5be9 100644
--- a/tools/include/linux/gfp.h
+++ b/tools/include/linux/gfp.h
@@ -3,26 +3,7 @@
 #define _TOOLS_INCLUDE_LINUX_GFP_H
 
 #include <linux/types.h>
-
-#define __GFP_BITS_SHIFT 26
-#define __GFP_BITS_MASK ((gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
-
-#define __GFP_HIGH		0x20u
-#define __GFP_IO		0x40u
-#define __GFP_FS		0x80u
-#define __GFP_NOWARN		0x200u
-#define __GFP_ZERO		0x8000u
-#define __GFP_ATOMIC		0x80000u
-#define __GFP_ACCOUNT		0x100000u
-#define __GFP_DIRECT_RECLAIM	0x400000u
-#define __GFP_KSWAPD_RECLAIM	0x2000000u
-
-#define __GFP_RECLAIM	(__GFP_DIRECT_RECLAIM | __GFP_KSWAPD_RECLAIM)
-
-#define GFP_ZONEMASK	0x0fu
-#define GFP_ATOMIC	(__GFP_HIGH | __GFP_ATOMIC | __GFP_KSWAPD_RECLAIM)
-#define GFP_KERNEL	(__GFP_RECLAIM | __GFP_IO | __GFP_FS)
-#define GFP_NOWAIT	(__GFP_KSWAPD_RECLAIM)
+#include <linux/gfp_types.h>
 
 static inline bool gfpflags_allow_blocking(const gfp_t gfp_flags)
 {
diff --git a/tools/include/linux/gfp_types.h b/tools/include/linux/gfp_types.h
new file mode 100644
index 000000000000..5f9f1ed190a0
--- /dev/null
+++ b/tools/include/linux/gfp_types.h
@@ -0,0 +1 @@
+#include "../../../include/linux/gfp_types.h"
-- 
2.35.1

