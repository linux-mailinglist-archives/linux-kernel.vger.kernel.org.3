Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37534D5061
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 18:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244537AbiCJRWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 12:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238575AbiCJRVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:21:54 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF7618E41E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646932846; x=1678468846;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RA7/CbrBlg0DZuKNvFbLv2IQL4yMBEmR7JWu0KLcJzo=;
  b=UoTpnjyt/vVMvcPEYQcai7W74VO4IHUVQqoS7xo17qxbZqvCxpJauu3s
   pYcsbG/KrwpysBKNNLdPXpgAj17B5Ws/FKOTlZwCbfQDAKFhM3/XBYBTr
   O37ww7ODoRvPpvW4Vfru7/YjS7DA3B4PQvRQeJzcMudc2299XAiQIaH6u
   nERkiNCq/Jd5qUN4OWF4Fm4Xr6cO7A0EMOvYZX9Q2RG7mNz2mbsLGtFHT
   tZ8NHPTA9MORONghG6SwfS/2B5TDsdhOdPwXLte0vgwgmfEC0MoNBlBPZ
   kzYMfqTJ9WWGproO9MrKuJbFoQWZ0cgTCEYk7y5ODdYl8vHMKKynkPoL/
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="341741171"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="341741171"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:20:46 -0800
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="514071144"
Received: from gdavids1-mobl.amr.corp.intel.com (HELO localhost) ([10.212.65.108])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:20:45 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V9 09/45] Documentation/pkeys: Add initial PKS documentation
Date:   Thu, 10 Mar 2022 09:19:43 -0800
Message-Id: <20220310172019.850939-10-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310172019.850939-1-ira.weiny@intel.com>
References: <20220310172019.850939-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

