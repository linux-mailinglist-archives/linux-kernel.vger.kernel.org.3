Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743D64D501B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 18:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244512AbiCJRVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 12:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244497AbiCJRVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:21:41 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A5B18E41E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646932840; x=1678468840;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rre21y0NXsE36v+stW7kudjkkUumdSmZPMmPYFQ3UdM=;
  b=UbcETU3GA3VcbyJCdW7xUFDaMb+R4QNWfcHDFMTPK07cJnKKZBDUE/Wx
   RWSVEPWhr4UbaqHsKC5cyR/EQb29/2Hs+JZ1vDkM+fH9RMMKv9LYL6MVU
   6RVpWihYW6HNrnaM35I3S1m6rls4aFyM40UXF+h58UjtKO+VPA3M/aY9+
   7cIyLxyzqW4iwHdmrNdOEf1spzmIvlqgYSnyx5xBs0zApibvbkslOw7CR
   aZmlfW918HFbtJ+n2uOvzmY3WMNOLYpEa1W5on998/26Ixlvtk03yXzCG
   p6kth8D6ziVimt2TPYUlzPROzWXW+rK/EjKXvWyKhQUq1Nm3217BuALm+
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="237484201"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="237484201"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:20:39 -0800
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="633064293"
Received: from gdavids1-mobl.amr.corp.intel.com (HELO localhost) ([10.212.65.108])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:20:39 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V9 06/45] mm/pkeys: Add Kconfig options for PKS
Date:   Thu, 10 Mar 2022 09:19:40 -0800
Message-Id: <20220310172019.850939-7-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310172019.850939-1-ira.weiny@intel.com>
References: <20220310172019.850939-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Consumers wishing to implement additional protections on memory pages
can use PKS.  However, PKS is only available on some architectures.

For this reason PKS code, both in the core and in the consumers, is dead
code without PKS being both available and used.

Add Kconfig options to allow for the elimination of unneeded code by
detecting architecture PKS support (ARCH_HAS_SUPERVISOR_PKEYS) and
requiring an indication of consumer need (ARCH_ENABLE_SUPERVISOR_PKEYS).

In this patch ARCH_ENABLE_SUPERVISOR_PKEYS remains off until the first
kernel consumer sets it.

Cc: "Moger, Babu" <Babu.Moger@amd.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V9
	Dave Hansen
		Don't exclude AMD, cpu supported bits will properly turn
		the feature off.
		Clarify commit message
		Depend on CPU_SUP_INTEL

Changes for V8
	Split this out to a single change patch
---
 arch/x86/Kconfig | 1 +
 mm/Kconfig       | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9f5bd41bf660..459948622a73 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1868,6 +1868,7 @@ config X86_INTEL_MEMORY_PROTECTION_KEYS
 	depends on X86_64 && (CPU_SUP_INTEL || CPU_SUP_AMD)
 	select ARCH_USES_HIGH_VMA_FLAGS
 	select ARCH_HAS_PKEYS
+	select ARCH_HAS_SUPERVISOR_PKEYS
 	help
 	  Memory Protection Keys provides a mechanism for enforcing
 	  page-based protections, but without requiring modification of the
diff --git a/mm/Kconfig b/mm/Kconfig
index 3326ee3903f3..46f2bb15aa4e 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -804,6 +804,10 @@ config ARCH_USES_HIGH_VMA_FLAGS
 	bool
 config ARCH_HAS_PKEYS
 	bool
+config ARCH_HAS_SUPERVISOR_PKEYS
+	bool
+config ARCH_ENABLE_SUPERVISOR_PKEYS
+	bool
 
 config PERCPU_STATS
 	bool "Collect percpu memory statistics"
-- 
2.35.1

