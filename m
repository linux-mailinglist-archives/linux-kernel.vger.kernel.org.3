Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90BE53CDC8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 19:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344240AbiFCRKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 13:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbiFCRKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 13:10:21 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98247B842
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 10:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654276218; x=1685812218;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oWgzYikdcznM4neHgtRepOWEdSTD4JfGjPhc69T4sPU=;
  b=A4xGb90u8psiqSkfjR7DMji68wE/NZjK0ELNuNR2+KNhCcst7EPpu3eS
   qxKzVf5Nf3I34I0lX6onrLA7j1Brj5rc8QEa5+OSAL/+vkaNzDZ88DE7z
   IMm04OaduV0vnvy1e7Qwb+PG1ahqyxaPFEaariMMyjGPG3JzE2l8rw80Q
   cb1T17iCYbZyRykgtxFXyx2oHo8fMJY6DQPeTn38bFMuBSHoJbKVdwv8E
   xS32o84nqXss8u2F1NtP6A0BzAgT+jowIA8a4w9q3TlUYQutUuHQe0nOw
   Rhf9q3z8ADIl39TyuM8FwLCAjwciawFj3i/528LB30NyDRwB+9kWkfyC3
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10367"; a="275101841"
X-IronPort-AV: E=Sophos;i="5.91,275,1647327600"; 
   d="scan'208";a="275101841"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 10:10:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,275,1647327600"; 
   d="scan'208";a="578111122"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 03 Jun 2022 10:10:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A5D52F8; Fri,  3 Jun 2022 20:10:17 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] rbtree: Replace kernel.h with the necessary inclusions
Date:   Fri,  3 Jun 2022 20:10:12 +0300
Message-Id: <20220603171012.48880-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kernel.h is used in the headers it adds a lot into dependency hell,
especially when there are circular dependencies are involved.

Replace kernel.h inclusion with the list of what is really being used.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/rbtree.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rbtree.h b/include/linux/rbtree.h
index 235047d7a1b5..f7edca369eda 100644
--- a/include/linux/rbtree.h
+++ b/include/linux/rbtree.h
@@ -17,9 +17,9 @@
 #ifndef	_LINUX_RBTREE_H
 #define	_LINUX_RBTREE_H
 
+#include <linux/container_of.h>
 #include <linux/rbtree_types.h>
 
-#include <linux/kernel.h>
 #include <linux/stddef.h>
 #include <linux/rcupdate.h>
 
-- 
2.35.1

