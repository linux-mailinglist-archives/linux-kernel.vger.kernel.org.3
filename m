Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE684F1DE8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238868AbiDDVpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379254AbiDDQvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:51:48 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7082CC89;
        Mon,  4 Apr 2022 09:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649090991; x=1680626991;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IJ18KFcJREttG/DQft6OGwRLrrnlqhfaLHHGr5bKWmA=;
  b=L+N6w165ze1JxFhWJZplB23EelTCOWl3+utnMi1WQPdTlVrBuxOnW/Hw
   Kg1w+NUJik60AiixSMeil29/9mSd88cnbmLxXY1Uv6ldwHXfMDlOepM7D
   Q8Wt1nnW5cxK0POReA8hQScdFwW8MofWK0gefgJG92kvj4JlPD6KV/DLw
   KUn6xYulisVfBdc+54/Ed+GAY6R8/6K7GCTiXuqey5C51F4PpT1Zo2YVe
   ZpZKbORMKrImgZu6ELkFeG8Y4ISHLCuQ6iNTfmjLgNxkRfnSlZeHMICDh
   bt/doK/BB2K5qoQvdE+zdz511fffsRQLzQwPRxgntC7W9EurdB0xsc0i5
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="259390764"
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="259390764"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 09:49:50 -0700
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="523105150"
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
Subject: [PATCH V3 01/30] x86/sgx: Add short descriptions to ENCLS wrappers
Date:   Mon,  4 Apr 2022 09:49:09 -0700
Message-Id: <5f8eaad96d85f78b80da47c2b851d6d8af9fc878.1648847675.git.reinette.chatre@intel.com>
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

The SGX ENCLS instruction uses EAX to specify an SGX function and
may require additional registers, depending on the SGX function.
ENCLS invokes the specified privileged SGX function for managing
and debugging enclaves. Macros are used to wrap the ENCLS
functionality and several wrappers are used to wrap the macros to
make the different SGX functions accessible in the code.

The wrappers of the supported SGX functions are cryptic. Add short
descriptions of each as a comment.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
No changes since V2

Changes since V1:
- Fix commit message and subject to not refer to descriptions as
"changelog descriptions" or "shortlog descriptions" (Jarkko).
- Improve all descriptions with guidance from Jarkko.

 arch/x86/kernel/cpu/sgx/encls.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/encls.h b/arch/x86/kernel/cpu/sgx/encls.h
index fa04a73daf9c..0e22fa8f77c5 100644
--- a/arch/x86/kernel/cpu/sgx/encls.h
+++ b/arch/x86/kernel/cpu/sgx/encls.h
@@ -136,57 +136,71 @@ static inline bool encls_failed(int ret)
 	ret;						\
 	})
 
+/* Initialize an EPC page into an SGX Enclave Control Structure (SECS) page. */
 static inline int __ecreate(struct sgx_pageinfo *pginfo, void *secs)
 {
 	return __encls_2(ECREATE, pginfo, secs);
 }
 
+/* Hash a 256 byte region of an enclave page to SECS:MRENCLAVE. */
 static inline int __eextend(void *secs, void *addr)
 {
 	return __encls_2(EEXTEND, secs, addr);
 }
 
+/*
+ * Associate an EPC page to an enclave either as a REG or TCS page
+ * populated with the provided data.
+ */
 static inline int __eadd(struct sgx_pageinfo *pginfo, void *addr)
 {
 	return __encls_2(EADD, pginfo, addr);
 }
 
+/* Finalize enclave build, initialize enclave for user code execution. */
 static inline int __einit(void *sigstruct, void *token, void *secs)
 {
 	return __encls_ret_3(EINIT, sigstruct, secs, token);
 }
 
+/* Disassociate EPC page from its enclave and mark it as unused. */
 static inline int __eremove(void *addr)
 {
 	return __encls_ret_1(EREMOVE, addr);
 }
 
+/* Copy data to an EPC page belonging to a debug enclave. */
 static inline int __edbgwr(void *addr, unsigned long *data)
 {
 	return __encls_2(EDGBWR, *data, addr);
 }
 
+/* Copy data from an EPC page belonging to a debug enclave. */
 static inline int __edbgrd(void *addr, unsigned long *data)
 {
 	return __encls_1_1(EDGBRD, *data, addr);
 }
 
+/* Track that software has completed the required TLB address clears. */
 static inline int __etrack(void *addr)
 {
 	return __encls_ret_1(ETRACK, addr);
 }
 
+/* Load, verify, and unblock an EPC page. */
 static inline int __eldu(struct sgx_pageinfo *pginfo, void *addr,
 			 void *va)
 {
 	return __encls_ret_3(ELDU, pginfo, addr, va);
 }
 
+/* Make EPC page inaccessible to enclave, ready to be written to memory. */
 static inline int __eblock(void *addr)
 {
 	return __encls_ret_1(EBLOCK, addr);
 }
 
+/* Initialize an EPC page into a Version Array (VA) page. */
 static inline int __epa(void *addr)
 {
 	unsigned long rbx = SGX_PAGE_TYPE_VA;
@@ -194,6 +208,7 @@ static inline int __epa(void *addr)
 	return __encls_2(EPA, rbx, addr);
 }
 
+/* Invalidate an EPC page and write it out to main memory. */
 static inline int __ewb(struct sgx_pageinfo *pginfo, void *addr,
 			void *va)
 {
-- 
2.25.1

