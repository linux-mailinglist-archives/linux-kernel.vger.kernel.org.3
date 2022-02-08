Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677484ACDCA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344304AbiBHBKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344167AbiBHAqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 19:46:13 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BD4C043181;
        Mon,  7 Feb 2022 16:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644281173; x=1675817173;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4pne+ayhjnJWt5smkTKHuGgktR3NEWDf9VPdg8XN5WU=;
  b=UTh/f4aa0+8LMV9rS5tjP7KZTPcWFhcVncR2/Q3hQ9Qli9VOaB7HoAlD
   PRsRMnQjXPaasaP5xyfaywHL4m52zLnCQenkodGFqq6QvneObxlOULhsn
   j6YF6v+Qf0KVeGqOIrJaQudIpijImaduh5vqkHz07cyLm5f6OYdvTVrph
   wzIffpjYB92uPsmxIaDDEr2qsb6+e0xproP2mFuWuzmgqnUrcBDG0M0BA
   3JpdMDiVPeY59hzvU1uH+LFPPsk2MAaabnHyPjEoAV2gRUo7j7tacw9yl
   hLbxeVSe+WvOyA1FQ2ummY/2okrRH+8XpZOTALG6wtYgQXQRLfmx+1UNw
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="232407953"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="232407953"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 16:46:09 -0800
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="499389496"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 16:46:08 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 10/32] x86/sgx: Rename sgx_encl_ewb_cpumask() as sgx_encl_cpumask()
Date:   Mon,  7 Feb 2022 16:45:32 -0800
Message-Id: <75e4c7f20e0baad5798e17d83515a632d88014c3.1644274683.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1644274683.git.reinette.chatre@intel.com>
References: <cover.1644274683.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sgx_encl_ewb_cpumask() is no longer unique to the reclaimer where it
is used during the EWB ENCLS leaf function when EPC pages are written
out to main memory and sgx_encl_ewb_cpumask() is used to learn which
CPUs might have executed the enclave to ensure that TLBs are cleared.

Upcoming SGX2 enabling will use sgx_encl_ewb_cpumask() during the
EMODPR and EMODT ENCLS leaf functions that make changes to enclave
pages. The function is needed for the same reason it is used now: to
learn which CPUs might have executed the enclave to ensure that TLBs
no longer point to the changed pages.

Rename sgx_encl_ewb_cpumask() to sgx_encl_cpumask() to reflect the
broader usage.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V1:
- New patch split from original "x86/sgx: Use more generic name for
  enclave cpumask function" (Jarkko).

 arch/x86/kernel/cpu/sgx/encl.c | 6 +++---
 arch/x86/kernel/cpu/sgx/encl.h | 2 +-
 arch/x86/kernel/cpu/sgx/main.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 687166769ca8..6f5d01121766 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -598,7 +598,7 @@ int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm)
 }
 
 /**
- * sgx_encl_ewb_cpumask() - Query which CPUs might be accessing the enclave
+ * sgx_encl_cpumask() - Query which CPUs might be accessing the enclave
  * @encl: the enclave
  *
  * Some SGX functions require that no cached linear-to-physical address
@@ -623,7 +623,7 @@ int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm)
  * The following flow is used to support SGX functions that require that
  * no cached linear-to-physical address mappings are present:
  * 1) Execute ENCLS[ETRACK] to initiate hardware tracking.
- * 2) Use this function (sgx_encl_ewb_cpumask()) to query which CPUs might be
+ * 2) Use this function (sgx_encl_cpumask()) to query which CPUs might be
  *    accessing the enclave.
  * 3) Send IPI to identified CPUs, kicking them out of the enclave and
  *    thus flushing all locally cached linear-to-physical address mappings.
@@ -640,7 +640,7 @@ int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm)
  *
  * Return: cpumask of CPUs that might be accessing @encl
  */
-const cpumask_t *sgx_encl_ewb_cpumask(struct sgx_encl *encl)
+const cpumask_t *sgx_encl_cpumask(struct sgx_encl *encl)
 {
 	cpumask_t *cpumask = &encl->cpumask;
 	struct sgx_encl_mm *encl_mm;
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index 44431da21757..becb68503baa 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -106,7 +106,7 @@ int sgx_encl_may_map(struct sgx_encl *encl, unsigned long start,
 
 void sgx_encl_release(struct kref *ref);
 int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm);
-const cpumask_t *sgx_encl_ewb_cpumask(struct sgx_encl *encl);
+const cpumask_t *sgx_encl_cpumask(struct sgx_encl *encl);
 int sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_index,
 			 struct sgx_backing *backing);
 void sgx_encl_put_backing(struct sgx_backing *backing, bool do_write);
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 2de85f459492..fa33922879bf 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -249,7 +249,7 @@ static void sgx_encl_ewb(struct sgx_epc_page *epc_page,
 			 * miss cpus that entered the enclave between
 			 * generating the mask and incrementing epoch.
 			 */
-			on_each_cpu_mask(sgx_encl_ewb_cpumask(encl),
+			on_each_cpu_mask(sgx_encl_cpumask(encl),
 					 sgx_ipi_cb, NULL, 1);
 			ret = __sgx_encl_ewb(epc_page, va_slot, backing);
 		}
-- 
2.25.1

