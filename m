Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C58465663
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 20:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244185AbhLAT2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 14:28:22 -0500
Received: from mga04.intel.com ([192.55.52.120]:46914 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352657AbhLAT1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 14:27:13 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="235267938"
X-IronPort-AV: E=Sophos;i="5.87,279,1631602800"; 
   d="scan'208";a="235267938"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 11:23:44 -0800
X-IronPort-AV: E=Sophos;i="5.87,279,1631602800"; 
   d="scan'208";a="500380510"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 11:23:43 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 24/25] x86/sgx: Free up EPC pages directly to support large page ranges
Date:   Wed,  1 Dec 2021 11:23:22 -0800
Message-Id: <4d3cc24f06ae75d99449f1d505cbff9ba53819a9.1638381245.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1638381245.git.reinette.chatre@intel.com>
References: <cover.1638381245.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The page reclaimer ensures availability of EPC pages across all
enclaves. In support of this it runs independently from the individual
enclaves in order to take locks from the different enclaves as it writes
pages to swap.

When needing to load a page from swap an EPC page needs to be available for
its contents to be loaded into. Loading an existing enclave page from swap
does not reclaim EPC pages directly if none are available, instead the
reclaimer is woken when the available EPC pages are found to be below a
watermark.

When iterating over a large number of pages in an oversubscribed
environment there is a race between the reclaimer woken up and EPC pages
reclaimed fast enough for the page operations to proceed.

Instead of tuning the race between the page operations and the reclaimer
the page operations instead makes sure that there are EPC pages available.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/sgx/ioctl.c | 6 ++++++
 arch/x86/kernel/cpu/sgx/main.c  | 6 ++++++
 arch/x86/kernel/cpu/sgx/sgx.h   | 1 +
 3 files changed, 13 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index d11da6c53b26..fc2737b3c7cc 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -739,6 +739,8 @@ static long sgx_page_modp(struct sgx_encl *encl, struct sgx_page_modp *modp)
 	for (c = 0 ; c < modp->length; c += PAGE_SIZE) {
 		addr = encl->base + modp->offset + c;
 
+		sgx_direct_reclaim();
+
 		mutex_lock(&encl->lock);
 
 		entry = sgx_encl_load_page(encl, addr);
@@ -962,6 +964,8 @@ static long sgx_page_modt(struct sgx_encl *encl, struct sgx_page_modt *modt)
 	for (c = 0 ; c < modt->length; c += PAGE_SIZE) {
 		addr = encl->base + modt->offset + c;
 
+		sgx_direct_reclaim();
+
 		mutex_lock(&encl->lock);
 
 		entry = sgx_encl_load_page(encl, addr);
@@ -1187,6 +1191,8 @@ static long sgx_page_remove(struct sgx_encl *encl,
 	for (c = 0 ; c < params->length; c += PAGE_SIZE) {
 		addr = encl->base + params->offset + c;
 
+		sgx_direct_reclaim();
+
 		mutex_lock(&encl->lock);
 
 		entry = sgx_encl_load_page(encl, addr);
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 887648ce6084..bc3fc57f5f08 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -376,6 +376,12 @@ static bool sgx_should_reclaim(unsigned long watermark)
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
index ca89d625aa74..02af24acaacc 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -85,6 +85,7 @@ static inline void *sgx_get_epc_virt_addr(struct sgx_epc_page *page)
 struct sgx_epc_page *__sgx_alloc_epc_page(void);
 void sgx_free_epc_page(struct sgx_epc_page *page);
 
+void sgx_direct_reclaim(void);
 void sgx_mark_page_reclaimable(struct sgx_epc_page *page);
 int sgx_unmark_page_reclaimable(struct sgx_epc_page *page);
 struct sgx_epc_page *sgx_alloc_epc_page(void *owner, bool reclaim);
-- 
2.25.1

