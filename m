Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33E94F1EE8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238259AbiDDVzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379261AbiDDQvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:51:50 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B921C2F02A;
        Mon,  4 Apr 2022 09:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649090993; x=1680626993;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZWPEU1oj4JJoBauvs1J6o7QQGEbanEWmmGNZBVN//bw=;
  b=iIc5o9xzEfwnqkNSF9NglwHnwdYEjMj2Ykyaf0Q0ot2XsHRjtM273Oyj
   qwgqo1eu22tMOxb6SC1p1zNxy/fRK8I/23MNpUbqQ+GB9O7lC/uzEdXBx
   yDKZ/A1coWTIXtAMm0e9iNfDl1PG3Qwi6E48z71ENPRvN/B+upO42q/AD
   PoKce3QkoGGzrWZG9BackwaHZAXFTVy0cUj3k5r7JSHZijb1rqDdcRgq7
   iSPPTrWotyiKynrkL2HOkfkBJRp+Y+lLyx21J6ogoWoe5WikISpKagBlY
   JHO5XfllJmqA43+/kfuhb/SMZ9TNrox5dPNS7Hy9B0pDaRZFDE2q71K0+
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="259390778"
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="259390778"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 09:49:51 -0700
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="523105168"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 09:49:50 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 07/30] x86/sgx: Rename sgx_encl_ewb_cpumask() as sgx_encl_cpumask()
Date:   Mon,  4 Apr 2022 09:49:15 -0700
Message-Id: <c42cb6298d69cacd48872f97d11df694074803d8.1648847675.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1648847675.git.reinette.chatre@intel.com>
References: <cover.1648847675.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
No changes since V2

Changes since V1:
- New patch split from original "x86/sgx: Use more generic name for
  enclave cpumask function" (Jarkko).

 arch/x86/kernel/cpu/sgx/encl.c | 6 +++---
 arch/x86/kernel/cpu/sgx/encl.h | 2 +-
 arch/x86/kernel/cpu/sgx/main.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index c6525eba74e8..8de9bebc4d81 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -614,7 +614,7 @@ int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm)
 }
 
 /**
- * sgx_encl_ewb_cpumask() - Query which CPUs might be accessing the enclave
+ * sgx_encl_cpumask() - Query which CPUs might be accessing the enclave
  * @encl: the enclave
  *
  * Some SGX functions require that no cached linear-to-physical address
@@ -639,7 +639,7 @@ int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm)
  * The following flow is used to support SGX functions that require that
  * no cached linear-to-physical address mappings are present:
  * 1) Execute ENCLS[ETRACK] to initiate hardware tracking.
- * 2) Use this function (sgx_encl_ewb_cpumask()) to query which CPUs might be
+ * 2) Use this function (sgx_encl_cpumask()) to query which CPUs might be
  *    accessing the enclave.
  * 3) Send IPI to identified CPUs, kicking them out of the enclave and
  *    thus flushing all locally cached linear-to-physical address mappings.
@@ -656,7 +656,7 @@ int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm)
  *
  * Return: cpumask of CPUs that might be accessing @encl
  */
-const cpumask_t *sgx_encl_ewb_cpumask(struct sgx_encl *encl)
+const cpumask_t *sgx_encl_cpumask(struct sgx_encl *encl)
 {
 	cpumask_t *cpumask = &encl->cpumask;
 	struct sgx_encl_mm *encl_mm;
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index d2acb4debde5..e59c2cbf71e2 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -105,7 +105,7 @@ int sgx_encl_may_map(struct sgx_encl *encl, unsigned long start,
 
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

