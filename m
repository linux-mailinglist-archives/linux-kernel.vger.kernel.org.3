Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01311465651
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 20:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352650AbhLAT1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 14:27:13 -0500
Received: from mga04.intel.com ([192.55.52.120]:46904 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243784AbhLAT1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 14:27:05 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="235267921"
X-IronPort-AV: E=Sophos;i="5.87,279,1631602800"; 
   d="scan'208";a="235267921"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 11:23:42 -0800
X-IronPort-AV: E=Sophos;i="5.87,279,1631602800"; 
   d="scan'208";a="500380440"
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
Subject: [PATCH 02/25] x86/sgx: Add wrappers for SGX2 functions
Date:   Wed,  1 Dec 2021 11:23:00 -0800
Message-Id: <50ad5005c451f41951327853fb450ba302eadb40.1638381245.git.reinette.chatre@intel.com>
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
and debugging enclaves. Several macros are used to wrap the ENCLS
functionality.

Add ENCLS wrappers for the SGX2 EMODPR, EMODT, and EAUG functions
that can make changes to pages of an initialized SGX enclave. The
EMODPR function is used to restrict enclave page permissions
as maintained within the enclave (Enclave Page Cache Map (EPCM)
permissions). The EMODT function is used to change the type of an
enclave page. The EAUG function is used to dynamically add enclave
pages to an initialized enclave.

EMODPR and EMODT accepts two parameters and can fault as well as return
an SGX error code. EAUG also accepts two parameters but does not return
an SGX error code. Use existing macros for all new functions.

Expand enum sgx_return_code with the possible EMODPR and EMODT
return codes.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/include/asm/sgx.h      |  5 +++++
 arch/x86/kernel/cpu/sgx/encls.h | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
index 05f3e21f01a7..ebae2a153c66 100644
--- a/arch/x86/include/asm/sgx.h
+++ b/arch/x86/include/asm/sgx.h
@@ -47,17 +47,22 @@ enum sgx_encls_function {
 
 /**
  * enum sgx_return_code - The return code type for ENCLS, ENCLU and ENCLV
+ * %SGX_EPC_PAGE_CONFLICT:	Page is being written by other ENCLS function.
  * %SGX_NOT_TRACKED:		Previous ETRACK's shootdown sequence has not
  *				been completed yet.
  * %SGX_CHILD_PRESENT		SECS has child pages present in the EPC.
  * %SGX_INVALID_EINITTOKEN:	EINITTOKEN is invalid and enclave signer's
  *				public key does not match IA32_SGXLEPUBKEYHASH.
+ * %SGX_PAGE_NOT_MODIFIABLE:	The EPC page cannot be modified because it
+ *				is in the PENDING or MODIFIED state.
  * %SGX_UNMASKED_EVENT:		An unmasked event, e.g. INTR, was received
  */
 enum sgx_return_code {
+	SGX_EPC_PAGE_CONFLICT		= 7,
 	SGX_NOT_TRACKED			= 11,
 	SGX_CHILD_PRESENT		= 13,
 	SGX_INVALID_EINITTOKEN		= 16,
+	SGX_PAGE_NOT_MODIFIABLE		= 20,
 	SGX_UNMASKED_EVENT		= 128,
 };
 
diff --git a/arch/x86/kernel/cpu/sgx/encls.h b/arch/x86/kernel/cpu/sgx/encls.h
index 241b766265d3..243c30301ddb 100644
--- a/arch/x86/kernel/cpu/sgx/encls.h
+++ b/arch/x86/kernel/cpu/sgx/encls.h
@@ -238,4 +238,22 @@ static inline int __ewb(struct sgx_pageinfo *pginfo, void *addr,
 	return __encls_ret_3(EWB, pginfo, addr, va);
 }
 
+/* Restrict the permissions of an Enclave Page Cache (EPC) page */
+static inline int __emodpr(struct sgx_secinfo *secinfo, void *addr)
+{
+	return __encls_ret_2(EMODPR, secinfo, addr);
+}
+
+/* Change the type of an Enclave Page Cache (EPC) page */
+static inline int __emodt(struct sgx_secinfo *secinfo, void *addr)
+{
+	return __encls_ret_2(EMODT, secinfo, addr);
+}
+
+/* Add a page to an initialized enclave */
+static inline int __eaug(struct sgx_pageinfo *pginfo, void *addr)
+{
+	return __encls_2(EAUG, pginfo, addr);
+}
+
 #endif /* _X86_ENCLS_H */
-- 
2.25.1

