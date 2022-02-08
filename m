Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201914ACDC6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235477AbiBHBJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344145AbiBHAqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 19:46:12 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB19C061355;
        Mon,  7 Feb 2022 16:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644281171; x=1675817171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k4hx/Ud/sdDS2pZSrHiW08bbdXJjTQrEHO82BjFrkss=;
  b=LZj5GX0t2jw0f61o3wgXTsjSHc173A4WccB2vvQg2M0SEsTztiPForKq
   8MAliPBaSkyuNv8qV1R/xvSdpQ/sRKvKbfa1TYcqxxw43sMygboXtVKz/
   0ksVBFULZ9dVn8G/iAqx1vUiQW6FCRKnXVc7NFAev5CxswYXtJLNUmshi
   LLlaTxN4ejICKG6MiY1UypYFwW7uYUKTXpmMOuAY19EBWJIqg5jiiPbyX
   ULBQV8/WiyHTrJBbX6ux4ZnBuchayL7DJeCHnT4r/ZoTv3NabUXa8MWvF
   fTYKNPjrxlnkbOWIjorwm3ZoZkFLcf748UJXgjGjF7iFXzkhZ4o6vtipg
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="232407931"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="232407931"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 16:46:08 -0800
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="499389468"
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
Subject: [PATCH V2 01/32] x86/sgx: Add short descriptions to ENCLS wrappers
Date:   Mon,  7 Feb 2022 16:45:23 -0800
Message-Id: <8a76d614dab425c81fc40fd3f7cc5c8649fdaf7a.1644274683.git.reinette.chatre@intel.com>
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

