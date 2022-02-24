Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC71D4C214D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 02:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiBXBoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 20:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiBXBoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 20:44:19 -0500
Received: from out199-11.us.a.mail.aliyun.com (out199-11.us.a.mail.aliyun.com [47.90.199.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87889FBF16
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 17:43:49 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V5LKxlS_1645667025;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V5LKxlS_1645667025)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 24 Feb 2022 09:43:45 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] mm/rmap: Fix argument list that the kdoc format and script verified.
Date:   Thu, 24 Feb 2022 09:43:44 +0800
Message-Id: <20220224014344.99537-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The warnings were found by running scripts/kernel-doc, which is
caused by using 'make W=1'.

mm/rmap.c:1684: warning: Function parameter or member 'folio' not
described in 'try_to_unmap'
mm/rmap.c:1684: warning: Excess function parameter 'page' description in
'try_to_unmap'
mm/rmap.c:2086: warning: Function parameter or member 'folio' not
described in 'folio_make_device_exclusive'
mm/rmap.c:2086: warning: expecting prototype for
page_make_device_exclusive(). Prototype was for
folio_make_device_exclusive() instead

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 mm/rmap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index d27d79ec11b7..ebcf17d8ac1c 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1671,7 +1671,7 @@ static int page_not_mapped(struct folio *folio)
 
 /**
  * try_to_unmap - try to remove all page table mappings to a page
- * @page: the page to get unmapped
+ * @folio: The folio we're currently operating on.
  * @flags: action and flags
  *
  * Tries to remove all the page table entries which are mapping this
@@ -2068,8 +2068,8 @@ static bool page_make_device_exclusive_one(struct folio *folio,
 }
 
 /**
- * page_make_device_exclusive - mark the page exclusively owned by a device
- * @page: the page to replace page table entries for
+ * folio_make_device_exclusive - mark the page exclusively owned by a device
+ * @folio: The folio we're currently operating on.
  * @mm: the mm_struct where the page is expected to be mapped
  * @address: address where the page is expected to be mapped
  * @owner: passed to MMU_NOTIFY_EXCLUSIVE range notifier callbacks
-- 
2.20.1.7.g153144c

