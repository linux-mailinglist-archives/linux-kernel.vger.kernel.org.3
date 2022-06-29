Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AA3560C80
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 00:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiF2Wvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 18:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiF2Wvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 18:51:48 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81BD1CB07;
        Wed, 29 Jun 2022 15:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656543107; x=1688079107;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=pPUlqKZCesuVnLqny3F3F4siQYTkDVZUwF5WOXqskQw=;
  b=WMA3xoHkj8nC5etQKVy7SsSFxdf8emIIM+n47ikaY7T5SX8ubK0TjjaT
   edOlj3Cvj/Pkyur00oFNea3PpKlvQiYYWtpMfEpWdTb2V2shFwNmOL9lm
   66/8hAU5g4ZlvkIVaOfphfLKzZ9Lyk8MxRCk8SUSg6u/FPH9ttSmXp3ZT
   YD95Rd20Hy/QkE7NyTX13sydzo0ob5KJANoNrKnZb8Nq2yiuv+gXNAPQW
   /zst6IPbLaBVXYNRVB6ynTse9NwjdXRiKpZDfkZg1vlN9/wSnqpj0ByTB
   i3wdYHxmWVb+UPIw8lFBoZyuVfg9SgxEL1ZuBMGQ1YzuW7DL38YRBgJHg
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="343871875"
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; 
   d="scan'208";a="343871875"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 15:51:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; 
   d="scan'208";a="917795907"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by fmsmga005.fm.intel.com with ESMTP; 29 Jun 2022 15:51:46 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     dave.hansen@intel.com, len.brown@intel.com, tony.luck@intel.com,
        rafael.j.wysocki@intel.com, reinette.chatre@intel.com,
        dan.j.williams@intel.com
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-man@vger.kernel.org, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v2 1/1] Documentation/x86: Add the AMX enabling example
Date:   Wed, 29 Jun 2022 15:42:35 -0700
Message-Id: <20220629224235.20589-2-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220629224235.20589-1-chang.seok.bae@intel.com>
References: <20220629224235.20589-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explain steps to enable the dynamic feature with a code example.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Thiago Macieira <thiago.macieira@intel.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v1:
* Update the description without mentioning CPUID & XGETBV (Dave Hansen).
---
 Documentation/x86/xstate.rst | 42 ++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/x86/xstate.rst b/Documentation/x86/xstate.rst
index 5cec7fb558d6..c439901419fb 100644
--- a/Documentation/x86/xstate.rst
+++ b/Documentation/x86/xstate.rst
@@ -64,6 +64,48 @@ the handler allocates a larger xstate buffer for the task so the large
 state can be context switched. In the unlikely cases that the allocation
 fails, the kernel sends SIGSEGV.
 
+AMX TILE_DATA enabling example
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The following steps dynamically enable TILE_DATA:
+
+  1. An application first needs to determine the feature support::
+
+        #include <asm/prctl.h>
+        #include <sys/syscall.h>
+        #include <stdio.h>
+        #include <unistd.h>
+
+        #define ARCH_GET_XCOMP_SUPP  0x1021
+
+        #define XFEATURE_XTILECFG    17
+        #define XFEATURE_XTILEDATA   18
+        #define XFEATURE_MASK_XTILE ((1 << XFEATURE_XTILECFG) | (1 << XFEATURE_XTILEDATA))
+
+        unsigned long features;
+        long rc;
+
+        ...
+
+        rc = syscall(SYS_arch_prctl, ARCH_GET_XCOMP_SUPP, &features);
+
+        if (!rc && (features & XFEATURE_MASK_XTILE) == XFEATURE_MASK_XTILE)
+            printf("AMX is available.\n");
+
+  2. After determining support for AMX, an application must explicitly ask
+     permission to use it::
+
+        #define ARCH_REQ_XCOMP_PERM  0x1023
+
+        ...
+
+        rc = syscall(SYS_arch_prctl, ARCH_REQ_XCOMP_PERM, XFEATURE_XTILEDATA);
+
+        if (!rc)
+            printf("AMX is ready for use.\n");
+
+Note this example does not include the sigaltstack preparation.
+
 Dynamic features in signal frames
 ---------------------------------
 
-- 
2.17.1

