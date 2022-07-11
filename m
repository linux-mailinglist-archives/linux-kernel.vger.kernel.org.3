Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BD35708CD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 19:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbiGKRXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 13:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiGKRXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 13:23:09 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599C25A467;
        Mon, 11 Jul 2022 10:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657560187; x=1689096187;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=9Y6rHoNB4HgyDF/8RzDJ5psF166vtx/mMEFKg807sIU=;
  b=Evnzx8ftSgJeK0emhsp8BG0sNmFaFXOhBE747CNkuClxCZQu45PYM0YF
   EaEwzOBVOujpK6qxnkzibBUkoqd1xkQP6/ReCEVv4xwF4gqTOOvFdVqFj
   3k7QgJwPdSaAuC71FmtvtKmCJXGT2LcxQjUcYO4WqFKVH+UAQqZNxohRr
   q/ty7DGl+E8m8lmSwnyF57D9RbvCo8XiF94LIE/F4d5pxcqivk0gQj+DV
   c9fxHiLMOkAdHIBYFG0y26bZJ11UeZixRXt+LlVHovMGPpm3sdSUInmXO
   +Rxn9BWQAPeIb1WZwg2iU8zi9lXjK9ENkkxHve7pXXHoj9bqBZ2jNEOeg
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="267760986"
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="267760986"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 10:23:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="921869742"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by fmsmga005.fm.intel.com with ESMTP; 11 Jul 2022 10:23:06 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     dave.hansen@intel.com, len.brown@intel.com, tony.luck@intel.com,
        rafael.j.wysocki@intel.com, reinette.chatre@intel.com,
        dan.j.williams@intel.com
Cc:     bagasdotme@gmail.com, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-man@vger.kernel.org, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v3 2/2] Documentation/x86: Add the AMX enabling example
Date:   Mon, 11 Jul 2022 10:13:47 -0700
Message-Id: <20220711171347.27309-3-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220711171347.27309-1-chang.seok.bae@intel.com>
References: <20220711171347.27309-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explain steps to enable the dynamic feature with a code example.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Thiago Macieira <thiago.macieira@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v1:
* Update the description without mentioning CPUID & XGETBV (Dave Hansen).

Changes from v2:
* Massage sentences (Bagas Sanjaya).
* Adjust the example with the (future) prctl.h.
---
 Documentation/x86/xstate.rst | 55 ++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/Documentation/x86/xstate.rst b/Documentation/x86/xstate.rst
index 5cec7fb558d6..dbe7ca854d2a 100644
--- a/Documentation/x86/xstate.rst
+++ b/Documentation/x86/xstate.rst
@@ -64,6 +64,61 @@ the handler allocates a larger xstate buffer for the task so the large
 state can be context switched. In the unlikely cases that the allocation
 fails, the kernel sends SIGSEGV.
 
+AMX TILE_DATA enabling example
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Below is the example of how userspace applications enable
+TILE_DATA dynamically:
+
+  1. The application first needs to query the kernel for AMX
+     support::
+
+        #include <asm/prctl.h>
+        #include <sys/syscall.h>
+        #include <stdio.h>
+        #include <unistd.h>
+
+        #ifndef ARCH_GET_XCOMP_SUPP
+        #define ARCH_GET_XCOMP_SUPP  0x1021
+        #endif
+
+        #ifndef ARCH_XCOMP_TILECFG
+        #define ARCH_XCOMP_TILECFG   17
+        #endif
+
+        #ifndef ARCH_XCOMP_TILEDATA
+        #define ARCH_XCOMP_TILEDATA  18
+        #endif
+
+        #define MASK_XCOMP_TILE      ((1 << ARCH_XCOMP_TILECFG) | \
+                                      (1 << ARCH_XCOMP_TILEDATA))
+
+        unsigned long features;
+        long rc;
+
+        ...
+
+        rc = syscall(SYS_arch_prctl, ARCH_GET_XCOMP_SUPP, &features);
+
+        if (!rc && (features & MASK_XCOMP_TILE) == MASK_XCOMP_TILE)
+            printf("AMX is available.\n");
+
+  2. After that, determining support for AMX, an application must
+     explicitly ask permission to use it::
+
+        #ifndef ARCH_REQ_XCOMP_PERM
+        #define ARCH_REQ_XCOMP_PERM  0x1023
+        #endif
+
+        ...
+
+        rc = syscall(SYS_arch_prctl, ARCH_REQ_XCOMP_PERM, ARCH_XCOMP_TILEDATA);
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

