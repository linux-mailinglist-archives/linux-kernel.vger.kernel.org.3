Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80FC64ACDDF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237189AbiBHBJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344148AbiBHAqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 19:46:12 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AC4C043188;
        Mon,  7 Feb 2022 16:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644281171; x=1675817171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n2tussXbA+nZyavb3jVmHg8ajqL6ns6El7v3FjGaYE0=;
  b=NHd3R7iRcnnTWhcU9jv0jcVprRurgO1oE2TL9DPbhF0Hv9uz7iGU4TYy
   aelg3NT4kM/zbNXbxWQiGjLsFLMnyj2IuJgTTqY5qHJj3sFtFz8XQIL8B
   DH9dp9/lpKsqmcA0VDKJpF8SDq/RfQ8xy9QfnFka/hP+4wBmS/ZlngHYS
   xCsa3Am6K1ViMKoYrDiBY/ox3wNucKvj08TsAb8E3nNJvQGI2CNDzvVAv
   VCgpspePg2V3TrtPNQjyVI/Q7Bp/wo/nVtsNT8tjsDmKSBUUeqZEQa88I
   uX9XyKGyjNzWq94kWmf7Ryq4RZi7AE9npkACj8aOfpN9rQjmz9P+B/PT+
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="232407940"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="232407940"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 16:46:08 -0800
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="499389477"
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
Subject: [PATCH V2 04/32] x86/sgx: Add wrapper for SGX2 EAUG function
Date:   Mon,  7 Feb 2022 16:45:26 -0800
Message-Id: <e4ff83aa58317a71de5ed02545d739671bb2f418.1644274683.git.reinette.chatre@intel.com>
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

Add a wrapper for the EAUG ENCLS leaf function used to
add a page to an initialized enclave.

EAUG:
1) Stores all properties of the new enclave page in the SGX
   hardware's Enclave Page Cache Map (EPCM).
2) Sets the PENDING bit in the EPCM entry of the enclave page.
   This bit is cleared by the enclave by invoking ENCLU leaf
   function EACCEPT or EACCEPTCOPY.

Access from within the enclave to the new enclave page is not
possible until the PENDING bit is cleared.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V1:
- Split original patch ("x86/sgx: Add wrappers for SGX2 functions")
  in three to introduce the SGX2 functions separately (Jarkko).
- Rewrite commit message to include how the EPCM within the hardware
  is changed by the SGX2 function as well as any calling
  conditions (Jarkko).

 arch/x86/kernel/cpu/sgx/encls.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/encls.h b/arch/x86/kernel/cpu/sgx/encls.h
index 7a1ecf704ec1..99004b02e2ed 100644
--- a/arch/x86/kernel/cpu/sgx/encls.h
+++ b/arch/x86/kernel/cpu/sgx/encls.h
@@ -227,4 +227,10 @@ static inline int __emodt(struct sgx_secinfo *secinfo, void *addr)
 	return __encls_ret_2(EMODT, secinfo, addr);
 }
 
+/* Zero a page of EPC memory and add it to an initialized enclave. */
+static inline int __eaug(struct sgx_pageinfo *pginfo, void *addr)
+{
+	return __encls_2(EAUG, pginfo, addr);
+}
+
 #endif /* _X86_ENCLS_H */
-- 
2.25.1

