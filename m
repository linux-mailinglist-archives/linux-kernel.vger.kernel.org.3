Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBD749E96C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245142AbiA0R4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:56:12 -0500
Received: from mga12.intel.com ([192.55.52.136]:65467 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244850AbiA0RzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:55:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643306125; x=1674842125;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EcpsWPf8UJbDeP77dQwv3JjYYAgIDS+icWEivpBmEm8=;
  b=MNZn1pn6vEKMhRvNuCB9wi5i2syugC8iPViDiJJbBUM8gIMRA6Rvh7nV
   3ckDhrAWWOj2XfO26sS0UNR3E7L7ZvTeWUsmdYdrciasjgYc9A+PecVSC
   /XqYiGOR7WbjfpvQYYeya8IyxQn0SYCQjcv+AN6aNEgszxKsbsFqkWmW/
   TluwC7TNUkkYjUbqzyeb4sno5jk+/D1PPgMMltD/52WTNFidnzZleG6iI
   WxyrWybgw2QcwtOnk8K0JTY7d2XT6MfK8FZxdagsbQ5WSYLHDT8JrphBi
   vMCbKPQZqHpnGjzBlkMBtqDUMrg4kHbRP1hAyIO3b6ZCWPhv5e4Ylmjp6
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="226899121"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="226899121"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:08 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="674796062"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:08 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 06/44] mm/pkeys: Add Kconfig options for PKS
Date:   Thu, 27 Jan 2022 09:54:27 -0800
Message-Id: <20220127175505.851391-7-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220127175505.851391-1-ira.weiny@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Protection Key Supervisor, PKS, is a feature used by kernel code only.
As such if no kernel users are configured the PKS code is unnecessary
overhead.

Define a Kconfig structure which allows kernel code to detect PKS
support by an architecture and then subsequently enable that support
within the architecture.

ARCH_HAS_SUPERVISOR_PKEYS indicates to kernel consumers that an
architecture supports pkeys.  PKS users can then select
ARCH_ENABLE_SUPERVISOR_PKEYS to turn on the support within the
architecture.

If ARCH_ENABLE_SUPERVISOR_PKEYS is not selected architectures avoid the
PKS overhead.

ARCH_ENABLE_SUPERVISOR_PKEYS remains off until the first kernel use case
sets it.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V8
	Split this out to a single change patch
---
 arch/x86/Kconfig | 1 +
 mm/Kconfig       | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ebe8fc76949a..a30fe85e27ac 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1867,6 +1867,7 @@ config X86_INTEL_MEMORY_PROTECTION_KEYS
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
2.31.1

