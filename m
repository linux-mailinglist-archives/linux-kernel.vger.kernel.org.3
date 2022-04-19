Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A40850762C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356161AbiDSRNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355641AbiDSRJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:09:56 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3F6B1F4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650388029; x=1681924029;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RA7/CbrBlg0DZuKNvFbLv2IQL4yMBEmR7JWu0KLcJzo=;
  b=UfSiJkZ64IjGUuG6vxwdTG9OJqiU8x/tNmOqJd0fZLnK0Bbl2johUYcB
   lXvwK8mkcTrtJnCspcE5vwqH6nNSxyHAhXr2Zc1zq/uS2wCKZttaGUC52
   JszlbGGNf+D4iHPLG7GyeTa5a1NYO91SbZNX+0Wh6+qg5/i41uByXYG6w
   qetDkzOK/HTRxzTdK7LC57OrNyDvoc8IcX2vAzT4CGhhC9X2B21FOiQee
   D7xrFLSgREy5/L2tdkGeYK1zplic3woI23Kyuq8WgTTMjnu3dST8INnt3
   8EdEoRmffAL5AiwKlZx4wDFaOtkWL/NnZ7rbSOby2LwugMko+oz03jF1f
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="261420760"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="261420760"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:06:57 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="657714516"
Received: from ajacosta-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.11.4])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:06:56 -0700
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V10 08/44] Documentation/pkeys: Add initial PKS documentation
Date:   Tue, 19 Apr 2022 10:06:13 -0700
Message-Id: <20220419170649.1022246-9-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419170649.1022246-1-ira.weiny@intel.com>
References: <20220419170649.1022246-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Add initial overview and configuration information about PKS.

Cc: "Moger, Babu" <Babu.Moger@amd.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V9
	Feedback from Dave Hansen
		Remove overview and move relevant text to the main pkey
		overview which covers both user ans kernel keys.
		Add an example of using Kconfig
		Move MSR details to later patches
---
 Documentation/core-api/protection-keys.rst | 43 ++++++++++++++++++++--
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/Documentation/core-api/protection-keys.rst b/Documentation/core-api/protection-keys.rst
index bf28ac0401f3..13eedb0119e1 100644
--- a/Documentation/core-api/protection-keys.rst
+++ b/Documentation/core-api/protection-keys.rst
@@ -13,6 +13,11 @@ Pkeys Userspace (PKU) is a feature which can be found on:
         * Intel client CPUs, Tiger Lake (11th Gen Core) and later
         * Future AMD CPUs
 
+Protection Keys Supervisor (PKS) is a feature which can be found on:
+        * Sapphire Rapids (and later) "Scalable Processor" Server CPUs
+        * Future non-server Intel parts.
+        * qemu: https://www.qemu.org/2021/04/30/qemu-6-0-0/
+
 Pkeys work by dedicating 4 previously Reserved bits in each page table entry to
 a "protection key", giving 16 possible keys.
 
@@ -23,13 +28,20 @@ and Write Disable) for each of 16 keys.
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
 
@@ -96,3 +108,26 @@ with a read()::
 The kernel will send a SIGSEGV in both cases, but si_code will be set
 to SEGV_PKERR when violating protection keys versus SEGV_ACCERR when
 the plain mprotect() permissions are violated.
+
+
+Kernel API for PKS support
+==========================
+
+Kconfig
+-------
+
+Kernel users intending to use PKS support should depend on
+ARCH_HAS_SUPERVISOR_PKEYS, and select ARCH_ENABLE_SUPERVISOR_PKEYS to turn on
+this support within the core.  For example:
+
+.. code-block:: c
+
+        config MY_NEW_FEATURE
+                depends on ARCH_HAS_SUPERVISOR_PKEYS
+                select ARCH_ENABLE_SUPERVISOR_PKEYS
+
+This will make "MY_NEW_FEATURE" unavailable unless the architecture sets
+ARCH_HAS_SUPERVISOR_PKEYS.  It also makes it possible for multiple independent
+features to "select ARCH_ENABLE_SUPERVISOR_PKEYS".  If no features enable PKS
+by selecting ARCH_ENABLE_SUPERVISOR_PKEYS, PKS support will not be compiled
+into the kernel.
-- 
2.35.1

