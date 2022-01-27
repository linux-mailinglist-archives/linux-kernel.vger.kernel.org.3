Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC77449E96A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244969AbiA0R4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:56:05 -0500
Received: from mga12.intel.com ([192.55.52.136]:65458 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244833AbiA0RzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:55:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643306124; x=1674842124;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j+f4pB+zxhX52T3Z+EIdgYytL0v+soefFOtz8ajtICA=;
  b=l9B+LgzeB+CzhyqeewZKg7poc/iX68K4orhbTdiNXRP85yaMH1OWDbl6
   c4qIhdgpUA+Zmde95G5MK5okuggBD6wohCX3ok1xkl5h2YT2JbW9XiMbF
   DK2RdypXFXG3OTTCubl534Dj0CvwzO86LMb/URRGttsSPuZdekcrNjiSr
   iU1ntRlonebua1dt2iWUMo/DW6qA2tjsULs5HwKj4M5gTjLybOt83m/Yz
   h+4MLxo+9b8PhIhz84SIKdEkIABP3sfwXw181ktso0IDYlJ3m+HzcDGF/
   UiVIEHicaJicZb50atGYS1VCkSThf++V1lQeuq1vJCJ5F8LOt8YRL8cc9
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="226899125"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="226899125"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:08 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="674796077"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:08 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 10/44] Documentation/pkeys: Add initial PKS documentation
Date:   Thu, 27 Jan 2022 09:54:31 -0800
Message-Id: <20220127175505.851391-11-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220127175505.851391-1-ira.weiny@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Add initial overview and configuration information about PKS.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 Documentation/core-api/protection-keys.rst | 57 ++++++++++++++++++++--
 1 file changed, 53 insertions(+), 4 deletions(-)

diff --git a/Documentation/core-api/protection-keys.rst b/Documentation/core-api/protection-keys.rst
index 12331db474aa..58670e3ee39e 100644
--- a/Documentation/core-api/protection-keys.rst
+++ b/Documentation/core-api/protection-keys.rst
@@ -12,6 +12,9 @@ PKeys Userspace (PKU) is a feature which is found on Intel's Skylake "Scalable
 Processor" Server CPUs and later.  And it will be available in future
 non-server Intel parts and future AMD processors.
 
+Protection Keys for Supervisor pages (PKS) is available in the SDM since May
+2020.
+
 pkeys work by dedicating 4 previously Reserved bits in each page table entry to
 a "protection key", giving 16 possible keys.
 
@@ -22,13 +25,20 @@ and Write Disable) for each of 16 keys.
 Being a CPU register, PKRU is inherently thread-local, potentially giving each
 thread a different set of protections from every other thread.
 
-There are two instructions (RDPKRU/WRPKRU) for reading and writing to the
-register.  The feature is only available in 64-bit mode, even though there is
+For Userspace (PKU), there are two instructions (RDPKRU/WRPKRU) for reading and
+writing to the register.
+
+For Supervisor (PKS), the register (MSR_IA32_PKRS) is accessible only to the
+kernel through rdmsr and wrmsr.
+
+The feature is only available in 64-bit mode, even though there is
 theoretically space in the PAE PTEs.  These permissions are enforced on data
 access only and have no effect on instruction fetches.
 
-Syscalls
-========
+
+
+Syscalls for user space keys
+============================
 
 There are 3 system calls which directly interact with pkeys::
 
@@ -95,3 +105,42 @@ with a read()::
 The kernel will send a SIGSEGV in both cases, but si_code will be set
 to SEGV_PKERR when violating protection keys versus SEGV_ACCERR when
 the plain mprotect() permissions are violated.
+
+
+Kernel API for PKS support
+==========================
+
+Overview
+--------
+
+Similar to user space pkeys, supervisor pkeys allow additional protections to
+be defined for a supervisor mappings.  Unlike user space pkeys, violations of
+these protections result in a kernel oops.
+
+Supervisor Memory Protection Keys (PKS) is a feature which is found on Intel's
+Sapphire Rapids (and later) "Scalable Processor" Server CPUs.  It will also be
+available in future non-server Intel parts.
+
+Also qemu has support as well: https://www.qemu.org/2021/04/30/qemu-6-0-0/
+
+Kconfig
+-------
+Kernel users intending to use PKS support should depend on
+ARCH_HAS_SUPERVISOR_PKEYS, and select ARCH_ENABLE_SUPERVISOR_PKEYS to turn on
+this support within the core.
+
+
+MSR details
+-----------
+
+It should be noted that the underlying WRMSR(MSR_IA32_PKRS) is not serializing
+but still maintains ordering properties similar to WRPKRU.
+
+Older versions of the SDM on PKRS may be wrong with regard to this
+serialization.  The text should be the same as that of WRPKRU.  From the WRPKRU
+text:
+
+	WRPKRU will never execute transiently. Memory accesses
+	affected by PKRU register will not execute (even transiently)
+	until all prior executions of WRPKRU have completed execution
+	and updated the PKRU register.
-- 
2.31.1

