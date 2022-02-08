Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0003B4ACDA7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343833AbiBHBIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344132AbiBHAqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 19:46:11 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137ABC06109E;
        Mon,  7 Feb 2022 16:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644281171; x=1675817171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q0vphHXpAQ7cBGzaSnch/i7jIsfuQCmDvKVvEhi6WfE=;
  b=DqhAG0o/3gNfJdXRAurh4XCfhf0A1afodJ1xbUNkTk+ZJrfjD7NnGd8l
   I9w5oSzPrVel+bb0ZYhQy0nvJ7NSI+g8ypV7RK33QKb65AblQkP3bUaRt
   XofMGYwVK4HkShJM8alyhwpVz5Kq1WNGa6mIsqXXEPL14DANGOmrD6CEr
   3FmXcrFf2cYJ7EN/EM4jnWzscKsv8BRHqaPURUpH6XzBGCA6KTcTQHEEm
   SQ6CMV+py8stsDx4OMszqB8WORr5mUGFmFNynSZMCTJVdyumwzU0sWApq
   MbjSSauO6ZM5qIwn2OxjYo07EZDHGjhwCdoYi26lEEK3yA48/mzui0IPP
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="232407937"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="232407937"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 16:46:08 -0800
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="499389473"
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
Subject: [PATCH V2 03/32] x86/sgx: Add wrapper for SGX2 EMODT function
Date:   Mon,  7 Feb 2022 16:45:25 -0800
Message-Id: <794af0e3cfe04cf886304b3dd644f9b4787b7125.1644274683.git.reinette.chatre@intel.com>
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

Add a wrapper for the EMODT ENCLS leaf function used to
change the type of an enclave page as maintained in the
SGX hardware's Enclave Page Cache Map (EPCM).

EMODT:
1) Updates the EPCM page type of the enclave page.
2) Sets the MODIFIED bit in the EPCM entry of the enclave page.
   This bit is reset by the enclave by invoking ENCLU leaf
   function EACCEPT or EACCEPTCOPY.

Access from within the enclave to the enclave page is not possible
while the MODIFIED bit is set.

After changing the enclave page type by issuing EMODT the kernel
needs to collaborate with the hardware to ensure that no logical
processor continues to hold a reference to the changed page. This
is required to ensure no required security checks are circumvented
and is required for the enclave's EACCEPT/EACCEPTCOPY to succeed.
Ensuring that no references to the changed page remain is
accomplished with the ETRACK flow.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V1:
- Split original patch ("x86/sgx: Add wrappers for SGX2 functions")
  in three to introduce the SGX2 functions separately (Jarkko).
- Rewrite commit message to include how the EPCM within the hardware
  is changed by the SGX2 function as well as the calling
  conditions (Jarkko).

 arch/x86/kernel/cpu/sgx/encls.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/encls.h b/arch/x86/kernel/cpu/sgx/encls.h
index 2b091912f038..7a1ecf704ec1 100644
--- a/arch/x86/kernel/cpu/sgx/encls.h
+++ b/arch/x86/kernel/cpu/sgx/encls.h
@@ -221,4 +221,10 @@ static inline int __emodpr(struct sgx_secinfo *secinfo, void *addr)
 	return __encls_ret_2(EMODPR, secinfo, addr);
 }
 
+/* Change the type of an EPC page. */
+static inline int __emodt(struct sgx_secinfo *secinfo, void *addr)
+{
+	return __encls_ret_2(EMODT, secinfo, addr);
+}
+
 #endif /* _X86_ENCLS_H */
-- 
2.25.1

