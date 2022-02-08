Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6EE44ACDC2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345416AbiBHBLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344225AbiBHAqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 19:46:18 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C982C043180;
        Mon,  7 Feb 2022 16:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644281177; x=1675817177;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/rJMW2flOWfkg1MprTvQqgBi1ZLUHOzTS97piUEK1S4=;
  b=M6VIg3+UHMXOdquaW6IsO1g0pB0KJ/IW+dct/SX/mIlTr8LMBOZ8xDXB
   vP0uPk3S7IAmGuBY2sYdJUBCUBANJPVa5dllSJbooh/6dDDI7R1lrbjEP
   lj65w8ytpa1FzsMpAffTxOtL7yDnUvuXgvJnn9TM6VhAgqpX4ulHMQ+2H
   52Cm1DH8wgNoON8DA8qiqSwuuZ+FHfnGtKU9YoiyiIzosBwzG1Io/KjYc
   ei/Eqq3TsY/aog40rzIjl2pzKJDCxeuQeJGeOshOnuIPzWOhPyYUbmvv+
   5nLCTL6OqxtClBoSKZdg2WjbIc5bPVVeOAE/64cnDpS9LMCHsmQNXJmDc
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="232407996"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="232407996"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 16:46:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="499389563"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 16:46:09 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 31/32] x86/sgx: Free up EPC pages directly to support large page ranges
Date:   Mon,  7 Feb 2022 16:45:53 -0800
Message-Id: <5abcc02a9b6c7bf5fbfb301c3311ff755965d861.1644274683.git.reinette.chatre@intel.com>
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

The page reclaimer ensures availability of EPC pages across all
enclaves. In support of this it runs independently from the
individual enclaves in order to take locks from the different
enclaves as it writes pages to swap.

When needing to load a page from swap an EPC page needs to be
available for its contents to be loaded into. Loading an existing
enclave page from swap does not reclaim EPC pages directly if
none are available, instead the reclaimer is woken when the
available EPC pages are found to be below a watermark.

When iterating over a large number of pages in an oversubscribed
environment there is a race between the reclaimer woken up and
EPC pages reclaimed fast enough for the page operations to proceed.

Ensure there are EPC pages available before attempting to load
a page that may potentially be pulled from swap into an available
EPC page.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since v1:
- Reword commit message.

 arch/x86/kernel/cpu/sgx/ioctl.c | 6 ++++++
 arch/x86/kernel/cpu/sgx/main.c  | 6 ++++++
 arch/x86/kernel/cpu/sgx/sgx.h   | 1 +
 3 files changed, 13 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 0ffb07095a80..d8c3c07badb3 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -962,6 +962,8 @@ static long sgx_enclave_restrict_perm(struct sgx_encl *encl,
 	for (c = 0 ; c < modp->length; c += PAGE_SIZE) {
 		addr = encl->base + modp->offset + c;
 
+		sgx_direct_reclaim();
+
 		mutex_lock(&encl->lock);
 
 		entry = sgx_encl_load_page(encl, addr);
@@ -1156,6 +1158,8 @@ static long sgx_enclave_modt(struct sgx_encl *encl,
 	for (c = 0 ; c < modt->length; c += PAGE_SIZE) {
 		addr = encl->base + modt->offset + c;
 
+		sgx_direct_reclaim();
+
 		mutex_lock(&encl->lock);
 
 		entry = sgx_encl_load_page(encl, addr);
@@ -1354,6 +1358,8 @@ static long sgx_encl_remove_pages(struct sgx_encl *encl,
 	for (c = 0 ; c < params->length; c += PAGE_SIZE) {
 		addr = encl->base + params->offset + c;
 
+		sgx_direct_reclaim();
+
 		mutex_lock(&encl->lock);
 
 		entry = sgx_encl_load_page(encl, addr);
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 6e2cb7564080..545da16bb3ea 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -370,6 +370,12 @@ static bool sgx_should_reclaim(unsigned long watermark)
 	       !list_empty(&sgx_active_page_list);
 }
 
+void sgx_direct_reclaim(void)
+{
+	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
+		sgx_reclaim_pages();
+}
+
 static int ksgxd(void *p)
 {
 	set_freezable();
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index b30cee4de903..85cbf103b0dd 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -86,6 +86,7 @@ static inline void *sgx_get_epc_virt_addr(struct sgx_epc_page *page)
 struct sgx_epc_page *__sgx_alloc_epc_page(void);
 void sgx_free_epc_page(struct sgx_epc_page *page);
 
+void sgx_direct_reclaim(void);
 void sgx_mark_page_reclaimable(struct sgx_epc_page *page);
 int sgx_unmark_page_reclaimable(struct sgx_epc_page *page);
 struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim);
-- 
2.25.1

