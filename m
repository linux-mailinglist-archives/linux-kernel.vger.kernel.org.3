Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D8246565B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 20:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245333AbhLAT1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 14:27:52 -0500
Received: from mga04.intel.com ([192.55.52.120]:46904 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245136AbhLAT1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 14:27:06 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="235267929"
X-IronPort-AV: E=Sophos;i="5.87,279,1631602800"; 
   d="scan'208";a="235267929"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 11:23:43 -0800
X-IronPort-AV: E=Sophos;i="5.87,279,1631602800"; 
   d="scan'208";a="500380462"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 11:23:42 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/25] x86/sgx: Keep record of SGX page type
Date:   Wed,  1 Dec 2021 11:23:07 -0800
Message-Id: <f1393ef80c8d1f1bdd3e34baf60c0286f77a8aa1.1638381245.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1638381245.git.reinette.chatre@intel.com>
References: <cover.1638381245.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGX2 functions are not allowed on all page types. For example,
ENCLS[EMODPR] is only allowed on regular SGX enclave pages and
ENCLS[EMODPT] is only allowed on TCS and regular pages. If these
functions are attempted on another type of page the hardware would
trigger a fault.

Keep a record of the SGX page type so that there is more
certainty whether an SGX2 instruction can succeed and faults
can be treated as real failures.

The page type is made to be a property of struct sgx_encl_page
and thus does not cover the VA page type. VA pages are maintained
in separate structures and thus their type can be determined in
a different way. The SGX2 instructions being supported do not
operate on VA pages and this is thus not a scenario needing to
be covered at this time.

With the protection bits consuming 16 bits of the unsigned long
there is room available in the bitfield to include the page type
information without increasing the space consumed by the struct.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/include/asm/sgx.h      | 3 +++
 arch/x86/kernel/cpu/sgx/encl.h  | 1 +
 arch/x86/kernel/cpu/sgx/ioctl.c | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
index ebae2a153c66..8b6cbedada96 100644
--- a/arch/x86/include/asm/sgx.h
+++ b/arch/x86/include/asm/sgx.h
@@ -221,6 +221,9 @@ struct sgx_pageinfo {
  * %SGX_PAGE_TYPE_REG:	a regular page
  * %SGX_PAGE_TYPE_VA:	a VA page
  * %SGX_PAGE_TYPE_TRIM:	a page in trimmed state
+ *
+ * Make sure when making changes to this enum that its values can still fit
+ * in the bitfield within &struct sgx_encl_page
  */
 enum sgx_page_type {
 	SGX_PAGE_TYPE_SECS,
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index 82e21088e68b..cb9f16d457ac 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -29,6 +29,7 @@ struct sgx_encl_page {
 	unsigned long desc;
 	unsigned long vm_max_prot_bits:8;
 	unsigned long vm_run_prot_bits:8;
+	enum sgx_page_type type:16;
 	struct sgx_epc_page *epc_page;
 	struct sgx_encl *encl;
 	struct sgx_va_page *va_page;
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 7e0819a89532..491d2700a54d 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -107,6 +107,7 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
 		set_bit(SGX_ENCL_DEBUG, &encl->flags);
 
 	encl->secs.encl = encl;
+	encl->secs.type = SGX_PAGE_TYPE_SECS;
 	encl->base = secs->base;
 	encl->size = secs->size;
 	encl->attributes = secs->attributes;
@@ -350,6 +351,7 @@ static int sgx_encl_add_page(struct sgx_encl *encl, unsigned long src,
 	 */
 	encl_page->encl = encl;
 	encl_page->epc_page = epc_page;
+	encl_page->type = (secinfo->flags & SGX_SECINFO_PAGE_TYPE_MASK) >> 8;
 	encl->secs_child_cnt++;
 
 	if (flags & SGX_PAGE_MEASURE) {
-- 
2.25.1

