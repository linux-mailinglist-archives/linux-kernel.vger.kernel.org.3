Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E194DDA17
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 14:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236491AbiCRNED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 09:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236481AbiCRNEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 09:04:01 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5652D63BC
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 06:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647608562; x=1679144562;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=vsczFr3MgbsN8jGklVyt7JkNJ3ifHP1+yQDJ5SClufU=;
  b=giIBHlvnQ0aQtkl4SUAn9Q5g35R7ar6dVTCMcS7fZHn3vD+LJ/1ESp/P
   WK6Ixy0askZ+8S6vyGzYQ1Sm1L49AuH2OqD7e2pokGqTy+WGUhGmf/VL5
   FBcU2Te0S4PD20VwcwrPJhYo8qUrewnaNDJmeElNp77b6iNtQFhGNp9Eu
   o=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 18 Mar 2022 06:02:41 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 06:02:41 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 18 Mar 2022 06:02:40 -0700
Received: from hu-charante-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 18 Mar 2022 06:02:38 -0700
From:   Charan Teja Kalla <quic_charante@quicinc.com>
To:     <akpm@linux-foundation.org>, <nigupta@nvidia.com>, <vbabka@suse.cz>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>
Subject: [PATCH] mm: compaction: fix compiler warning when CONFIG_COMPACTION=n
Date:   Fri, 18 Mar 2022 18:31:58 +0530
Message-ID: <1647608518-20924-1-git-send-email-quic_charante@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The below warning is reported when CONFIG_COMPACTION=n:

   mm/compaction.c:56:27: warning: 'HPAGE_FRAG_CHECK_INTERVAL_MSEC'
defined but not used [-Wunused-const-variable=]
      56 | static const unsigned int HPAGE_FRAG_CHECK_INTERVAL_MSEC =
500;
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fix it by moving 'HPAGE_FRAG_CHECK_INTERVAL_MSEC' under
CONFIG_COMPACTION defconfig. Also since this is just a 'static const
int' type, use #define for it.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
---
 mm/compaction.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index b4e94cd..4d86d04 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -26,6 +26,11 @@
 #include "internal.h"
 
 #ifdef CONFIG_COMPACTION
+/*
+ * Fragmentation score check interval for proactive compaction purposes.
+ */
+#define HPAGE_FRAG_CHECK_INTERVAL_MSEC	(500)
+
 static inline void count_compact_event(enum vm_event_item item)
 {
 	count_vm_event(item);
@@ -51,11 +56,6 @@ static inline void count_compact_events(enum vm_event_item item, long delta)
 #define pageblock_end_pfn(pfn)		block_end_pfn(pfn, pageblock_order)
 
 /*
- * Fragmentation score check interval for proactive compaction purposes.
- */
-static const unsigned int HPAGE_FRAG_CHECK_INTERVAL_MSEC = 500;
-
-/*
  * Page order with-respect-to which proactive compaction
  * calculates external fragmentation, which is used as
  * the "fragmentation score" of a node/zone.
-- 
2.7.4

