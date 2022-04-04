Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABE34F1D98
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383640AbiDDVdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379278AbiDDQv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:51:57 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD1B340DE;
        Mon,  4 Apr 2022 09:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649091000; x=1680627000;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gfjfHxX0p+HFa0uHshx5i4jpIGNdzFklRpR0pKy++Zs=;
  b=jSrPJoCOx65TE1F3N/ZVpMWir3jjS6sPRBDMK5vSXRPTLn+xstqmMCF7
   I14l/N49JGRFj7xR1wURIa+qYNAThMZG7vQ14R2AmVtYYW+sgwM3VPlj1
   r3NT7KjzZRotFZBfNjwOXeNsji/a1ISctljH0YLBW/RFfLIWdXo9PXK0k
   m+531YJNzbJvMvUnTfbJS4RziXYqq9+W83MumZ2Pf6qx0kPfhmklIaBbf
   i0U77kAste3oTnonYBlISbL+fULQV+sSpXIb6LrFY1wtq5Bhf3RYC/Jzy
   1wMiFMJ+J3nox6rRT5ZSPBGygcOVPxnRtnFzGNLUReowm6QeHTf/9thZS
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="323734058"
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="323734058"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 09:49:51 -0700
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="523105223"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 09:49:51 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 25/30] selftests/sgx: Introduce TCS initialization enclave operation
Date:   Mon,  4 Apr 2022 09:49:33 -0700
Message-Id: <50dbbe8b53c42d4909f2f4884f63972bfb7bb9a6.1648847675.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1648847675.git.reinette.chatre@intel.com>
References: <cover.1648847675.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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
No changes since V2

No changes since V1

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

