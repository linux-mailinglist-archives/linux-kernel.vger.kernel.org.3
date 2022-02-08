Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543284ACDAF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242271AbiBHBJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344146AbiBHAqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 19:46:12 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923FAC043180;
        Mon,  7 Feb 2022 16:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644281171; x=1675817171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DUQT7lI+0rw2ZoYCPItT9ZLNjMuzptc/VA6Q6/bUMr0=;
  b=HMZlT6aBD0B5BJrHgAFOgzGhnN2KRSRKQ1jiuLh2rUmEgffx7vdxc84l
   J3rMF9agilwVZ9bUE8Ye8Sp7gnrMLf+Vkx0y4pSdQ4zhi5+mQUL51pLXl
   xnMY0X+QoI7k1h1y6oSgYqlCEZTC0E3KhFa9UiQdP+2CIHBV1Xl0CqSmK
   DTX5udYAaOPIxOjjM7EykdNURVwJZcjG7Q+ePVS7jYrxwDttkpY4tvWwB
   ATMXytcMXLKKjg9fpJzJuLRfHCTJXKObxymKBMloalpfEgaATKPKJlZX6
   dOxdEFT9lEfE04a9yTLrtIocE1nAo5y7i6PXsvJXlvwSnGlZTb3qMZW7n
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="249050723"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="249050723"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 16:46:09 -0800
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="499389548"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 16:46:09 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 26/32] selftests/sgx: Introduce TCS initialization enclave operation
Date:   Mon,  7 Feb 2022 16:45:48 -0800
Message-Id: <6b6ddf76e1dbb448ce016fd6c6b65beebbf2afc2.1644274683.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1644274683.git.reinette.chatre@intel.com>
References: <cover.1644274683.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Thread Control Structure (TCS) contains meta-data used by the
hardware to save and restore thread specific information when
entering/exiting the enclave. A TCS can be added to an initialized
enclave by first adding a new regular enclave page, initializing the
content of the new page from within the enclave, and then changing that
page's type to a TCS.

Support the initialization of a TCS from within the enclave.
The variable information needed that should be provided from outside
the enclave is the address of the TCS, address of the State Save Area
(SSA), and the entry point that the thread should use to enter the
enclave. With this information provided all needed fields of a TCS
can be initialized.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
No changes since V1.

 tools/testing/selftests/sgx/defines.h   |  8 +++++++
 tools/testing/selftests/sgx/test_encl.c | 30 +++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/tools/testing/selftests/sgx/defines.h b/tools/testing/selftests/sgx/defines.h
index b638eb98c80c..d8587c971941 100644
--- a/tools/testing/selftests/sgx/defines.h
+++ b/tools/testing/selftests/sgx/defines.h
@@ -26,6 +26,7 @@ enum encl_op_type {
 	ENCL_OP_NOP,
 	ENCL_OP_EACCEPT,
 	ENCL_OP_EMODPE,
+	ENCL_OP_INIT_TCS_PAGE,
 	ENCL_OP_MAX,
 };
 
@@ -68,4 +69,11 @@ struct encl_op_emodpe {
 	uint64_t flags;
 };
 
+struct encl_op_init_tcs_page {
+	struct encl_op_header header;
+	uint64_t tcs_page;
+	uint64_t ssa;
+	uint64_t entry;
+};
+
 #endif /* DEFINES_H */
diff --git a/tools/testing/selftests/sgx/test_encl.c b/tools/testing/selftests/sgx/test_encl.c
index 5b6c65331527..c0d6397295e3 100644
--- a/tools/testing/selftests/sgx/test_encl.c
+++ b/tools/testing/selftests/sgx/test_encl.c
@@ -57,6 +57,35 @@ static void *memcpy(void *dest, const void *src, size_t n)
 	return dest;
 }
 
+static void *memset(void *dest, int c, size_t n)
+{
+	size_t i;
+
+	for (i = 0; i < n; i++)
+		((char *)dest)[i] = c;
+
+	return dest;
+}
+
+static void do_encl_init_tcs_page(void *_op)
+{
+	struct encl_op_init_tcs_page *op = _op;
+	void *tcs = (void *)op->tcs_page;
+	uint32_t val_32;
+
+	memset(tcs, 0, 16);			/* STATE and FLAGS */
+	memcpy(tcs + 16, &op->ssa, 8);		/* OSSA */
+	memset(tcs + 24, 0, 4);			/* CSSA */
+	val_32 = 1;
+	memcpy(tcs + 28, &val_32, 4);		/* NSSA */
+	memcpy(tcs + 32, &op->entry, 8);	/* OENTRY */
+	memset(tcs + 40, 0, 24);		/* AEP, OFSBASE, OGSBASE */
+	val_32 = 0xFFFFFFFF;
+	memcpy(tcs + 64, &val_32, 4);		/* FSLIMIT */
+	memcpy(tcs + 68, &val_32, 4);		/* GSLIMIT */
+	memset(tcs + 72, 0, 4024);		/* Reserved */
+}
+
 static void do_encl_op_put_to_buf(void *op)
 {
 	struct encl_op_put_to_buf *op2 = op;
@@ -100,6 +129,7 @@ void encl_body(void *rdi,  void *rsi)
 		do_encl_op_nop,
 		do_encl_eaccept,
 		do_encl_emodpe,
+		do_encl_init_tcs_page,
 	};
 
 	struct encl_op_header *op = (struct encl_op_header *)rdi;
-- 
2.25.1

