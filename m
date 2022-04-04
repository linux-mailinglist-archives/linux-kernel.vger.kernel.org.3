Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163014F1D91
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383253AbiDDVdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379256AbiDDQvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:51:49 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CBF2E086;
        Mon,  4 Apr 2022 09:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649090992; x=1680626992;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7soraypShUzq59PRY96Ss2w9MzztKJRkAjurCflHILo=;
  b=erKfRQM3ULdd7ZRjZxK2CnmQkvgmgeV3PRhAqXIPNwiMkC9YcvNHS/nY
   dqR/G+TzOcVsjFGmM3mWDXp3lFo2RAtcjuDTQB/tmHcOpZO9DumgLUf6n
   J0FS4hpz0LawYEI7kxcFd9WnFsAEJ+jBZaQSBDkva/gS7S67yZWlmhVY/
   Bof1j0xxJzSQBYWVjTHt6tHicXNjIr6XSUhMzfvJw8BdLf/C3iUEhm+ng
   GTpHK4Zd6LLt/oQOEArHL7l3/P0zA3oYLDkIGJKbF67JhryOLnYiR4K9t
   DsTbzojjKsFkqo358i4tWH8ruu/sxQgzmzEuP6fDE5vfHPDavmEbeaD7f
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="259390770"
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="259390770"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 09:49:50 -0700
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="523105156"
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
Subject: [PATCH V3 03/30] x86/sgx: Add wrapper for SGX2 EMODT function
Date:   Mon,  4 Apr 2022 09:49:11 -0700
Message-Id: <b99fcb7d39062dab80c612b32db4a4894c66ed39.1648847675.git.reinette.chatre@intel.com>
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
No changes since V2

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

