Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319ED465657
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 20:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbhLAT1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 14:27:42 -0500
Received: from mga04.intel.com ([192.55.52.120]:46907 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245137AbhLAT1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 14:27:06 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="235267920"
X-IronPort-AV: E=Sophos;i="5.87,279,1631602800"; 
   d="scan'208";a="235267920"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 11:23:42 -0800
X-IronPort-AV: E=Sophos;i="5.87,279,1631602800"; 
   d="scan'208";a="500380437"
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
Subject: [PATCH 01/25] x86/sgx: Add shortlog descriptions to ENCLS wrappers
Date:   Wed,  1 Dec 2021 11:22:59 -0800
Message-Id: <fd9ab4d760a2ea7a42ab9e60b9e19b8620abe11d.1638381245.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1638381245.git.reinette.chatre@intel.com>
References: <cover.1638381245.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SGX ENCLS instruction uses EAX to specify an SGX function and
may require additional registers, depending on the SGX function.
ENCLS invokes the specified privileged SGX function for managing
and debugging enclaves. Macros are used to wrap the ENCLS
functionality and several wrappers are used to wrap the macros to
make the different SGX functions accessible in the code.

The wrappers of the supported SGX functions are cryptic. Add short
changelog descriptions of each to a comment.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/sgx/encls.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/encls.h b/arch/x86/kernel/cpu/sgx/encls.h
index 9b204843b78d..241b766265d3 100644
--- a/arch/x86/kernel/cpu/sgx/encls.h
+++ b/arch/x86/kernel/cpu/sgx/encls.h
@@ -162,57 +162,68 @@ static inline bool encls_failed(int ret)
 	ret;						\
 	})
 
+/* Create an SECS page in the Enclave Page Cache (EPC) */
 static inline int __ecreate(struct sgx_pageinfo *pginfo, void *secs)
 {
 	return __encls_2(ECREATE, pginfo, secs);
 }
 
+/* Extend uninitialized enclave measurement */
 static inline int __eextend(void *secs, void *addr)
 {
 	return __encls_2(EEXTEND, secs, addr);
 }
 
+/* Add a page to an uninitialized enclave */
 static inline int __eadd(struct sgx_pageinfo *pginfo, void *addr)
 {
 	return __encls_2(EADD, pginfo, addr);
 }
 
+/* Initialize an enclave for execution */
 static inline int __einit(void *sigstruct, void *token, void *secs)
 {
 	return __encls_ret_3(EINIT, sigstruct, secs, token);
 }
 
+/* Remove a page from the Enclave Page Cache (EPC) */
 static inline int __eremove(void *addr)
 {
 	return __encls_ret_1(EREMOVE, addr);
 }
 
+/* Write to a debug enclave */
 static inline int __edbgwr(void *addr, unsigned long *data)
 {
 	return __encls_2(EDGBWR, *data, addr);
 }
 
+/* Read from a debug enclave */
 static inline int __edbgrd(void *addr, unsigned long *data)
 {
 	return __encls_1_1(EDGBRD, *data, addr);
 }
 
+/* Track threads operating inside the enclave */
 static inline int __etrack(void *addr)
 {
 	return __encls_ret_1(ETRACK, addr);
 }
 
+/* Load, verify, and unblock an Enclave Page Cache (EPC) page */
 static inline int __eldu(struct sgx_pageinfo *pginfo, void *addr,
 			 void *va)
 {
 	return __encls_ret_3(ELDU, pginfo, addr, va);
 }
 
+/* Mark an Enclave Page Cache (EPC) page as blocked */
 static inline int __eblock(void *addr)
 {
 	return __encls_ret_1(EBLOCK, addr);
 }
 
+/* Add a Version Array (VA) page to the Enclave Page Cache (EPC) */
 static inline int __epa(void *addr)
 {
 	unsigned long rbx = SGX_PAGE_TYPE_VA;
@@ -220,6 +231,7 @@ static inline int __epa(void *addr)
 	return __encls_2(EPA, rbx, addr);
 }
 
+/* Invalidate an EPC page and write it out to main memory */
 static inline int __ewb(struct sgx_pageinfo *pginfo, void *addr,
 			void *va)
 {
-- 
2.25.1

