Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189CC4ACDD8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343898AbiBHBJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344120AbiBHAqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 19:46:10 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC29C061355;
        Mon,  7 Feb 2022 16:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644281169; x=1675817169;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/RKQ1XlzkuP7ga1970y/Ps7KzLZ4JZ1dgTODJCtAQjE=;
  b=LDtKrPcLKq7/55mpRECuZEfH2tcwcvvBHbZBcdk+y7XrAMYI0vGoQmCM
   MqhnAEt14CByp4MeQ4HNBJvh4Gwi6n2VclUcW9/xJTXIXoUAbQNxSOCh5
   7I+L1BcvTJAMj+lKpv6E+YK1OVT5j1b5x2quklbG3PHljThAZt3US5NSY
   3zR11EkWvpGC/QwoSepTyFUxElKtrrnCDlZAg+8Ug4Os00cQNHKBVT17j
   2r3Xksl41EMrK39Yyk1YvRe3T90zNqvHSPChHJNakxzgM0L8euuetzqmg
   mk6kzsLeEFoBde9YJCscZn4CL4ez+GAuvXPZFwRdal7EgehHIC8wVQcLy
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="232407935"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="232407935"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 16:46:08 -0800
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="499389471"
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
Subject: [PATCH V2 02/32] x86/sgx: Add wrapper for SGX2 EMODPR function
Date:   Mon,  7 Feb 2022 16:45:24 -0800
Message-Id: <05630d35c1d12400622a868f8ef6ec25f38348af.1644274683.git.reinette.chatre@intel.com>
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

Add a wrapper for the EMODPR ENCLS leaf function used to
restrict enclave page permissions as maintained in the
SGX hardware's Enclave Page Cache Map (EPCM).

EMODPR:
1) Updates the EPCM permissions of an enclave page by treating
   the new permissions as a mask - supplying a value that relaxes
   EPCM permissions has no effect.
2) Sets the PR bit in the EPCM entry of the enclave page to
   indicate that permission restriction is in progress. The bit
   is reset by the enclave by invoking ENCLU leaf function
   EACCEPT or EACCEPTCOPY.

The enclave may access the page throughout the entire process
if conforming to the EPCM permissions for the enclave page.

After performing the permission restriction by issuing EMODPR
the kernel needs to collaborate with the hardware to ensure that
all logical processors sees the new restricted permissions. This
is required for the enclave's EACCEPT/EACCEPTCOPY to succeed and
is accomplished with the ETRACK flow.

Expand enum sgx_return_code with the possible EMODPR return
values.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V1:
- Split original patch ("x86/sgx: Add wrappers for SGX2 functions")
  in three to introduce the SGX2 functions separately (Jarkko).
- Rewrite commit message to include how the EPCM within the hardware
  is changed by the SGX2 function as well as the calling
  conditions (Jarkko).
- Make short description more specific to which permissions (EPCM
  permissions) the function modifies.

 arch/x86/include/asm/sgx.h      | 5 +++++
 arch/x86/kernel/cpu/sgx/encls.h | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
index 3f9334ef67cd..d67810b50a81 100644
--- a/arch/x86/include/asm/sgx.h
+++ b/arch/x86/include/asm/sgx.h
@@ -65,17 +65,22 @@ enum sgx_encls_function {
 
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
index 0e22fa8f77c5..2b091912f038 100644
--- a/arch/x86/kernel/cpu/sgx/encls.h
+++ b/arch/x86/kernel/cpu/sgx/encls.h
@@ -215,4 +215,10 @@ static inline int __ewb(struct sgx_pageinfo *pginfo, void *addr,
 	return __encls_ret_3(EWB, pginfo, addr, va);
 }
 
+/* Restrict the EPCM permissions of an EPC page. */
+static inline int __emodpr(struct sgx_secinfo *secinfo, void *addr)
+{
+	return __encls_ret_2(EMODPR, secinfo, addr);
+}
+
 #endif /* _X86_ENCLS_H */
-- 
2.25.1

