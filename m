Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4324D91EE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 02:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344007AbiCOBEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 21:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344111AbiCOBEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 21:04:02 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01998630B;
        Mon, 14 Mar 2022 18:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647306171; x=1678842171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Tj2I3escwpqO37YCAmvWnobN+FzpJ6eNFMd9Lxv7zvQ=;
  b=DaIGWecACI42vLD0RPPFJXlgOf6d1PQiSjdfj9yEinKDavCEYlApx8hx
   /A6cUbprCHjbc0eA/0vfRk378HD0Qt7eV7NxETBiO+sU6PCp8b1DI54NF
   aOh0qsArneaSonu0B5Gl+ww/AYr0KIKQMdbMZGPcXbiSUOpz71YF8/m0c
   rNZv/maEyUXYW5zgsb7qEFt4/6xfueTseDIq80+h9zCzIFj/GsEqj+EBh
   mOAUadbw72eLLK/NtFANLVgdLGsDOJx3wI7a3Lt3aWVentnls9YjSk+aW
   AR3ghejspcHZwbl/S5+gMg26ztANmd5+CDR5pEZW7zxbjkgLh0Ah7h6V3
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="255912374"
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="255912374"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 18:02:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="515669364"
Received: from cathy-vostro-3670.bj.intel.com ([10.238.156.128])
  by orsmga006.jf.intel.com with ESMTP; 14 Mar 2022 18:02:49 -0700
From:   Cathy Zhang <cathy.zhang@intel.com>
To:     linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, ashok.raj@intel.com, cathy.zhang@intel.com
Subject: [RFC PATCH v2 08/10] x86/sgx: Implement ENCLS[EUPDATESVN]
Date:   Tue, 15 Mar 2022 09:02:58 +0800
Message-Id: <20220315010300.10199-9-cathy.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220315010300.10199-1-cathy.zhang@intel.com>
References: <20220315010300.10199-1-cathy.zhang@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SGX attestation architecture assumes a compromise of all running
enclaves and cryptographic assets (like internal SGX encryption keys)
whenever a microcode update affects SGX. To mitigate the impact of
this presumed compromise, a new supervisor SGX instruction:
ENCLS[EUPDATESVN], is introduced to update SGX microcode version and
generate new cryptographic assets in runtime after SGX microcode
update.

EUPDATESVN requires that SGX memory to be marked as "unused" before
it will succeed. This ensures that no compromised enclave can survive
the process and provides an opportunity to generate new cryptographic
assets.

Signed-off-by: Cathy Zhang <cathy.zhang@intel.com>

---
Changes since v1:
 - Print message for each return code to notify userspace the
   ENCLS[EUPDATESVN] execution status.
---
 arch/x86/include/asm/sgx.h      | 33 +++++++++++----------
 arch/x86/kernel/cpu/sgx/encls.h |  6 ++++
 arch/x86/kernel/cpu/sgx/main.c  | 52 +++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
index 6aa36c1be426..d5942d0848ec 100644
--- a/arch/x86/include/asm/sgx.h
+++ b/arch/x86/include/asm/sgx.h
@@ -26,23 +26,26 @@
 #define SGX_CPUID_EPC_SECTION	0x1
 /* The bitmask for the EPC section type. */
 #define SGX_CPUID_EPC_MASK	GENMASK(3, 0)
+/* EUPDATESVN presence indication */
+#define SGX_CPUID_EUPDATESVN	BIT(10)
 
 enum sgx_encls_function {
-	ECREATE	= 0x00,
-	EADD	= 0x01,
-	EINIT	= 0x02,
-	EREMOVE	= 0x03,
-	EDGBRD	= 0x04,
-	EDGBWR	= 0x05,
-	EEXTEND	= 0x06,
-	ELDU	= 0x08,
-	EBLOCK	= 0x09,
-	EPA	= 0x0A,
-	EWB	= 0x0B,
-	ETRACK	= 0x0C,
-	EAUG	= 0x0D,
-	EMODPR	= 0x0E,
-	EMODT	= 0x0F,
+	ECREATE		= 0x00,
+	EADD		= 0x01,
+	EINIT		= 0x02,
+	EREMOVE		= 0x03,
+	EDGBRD		= 0x04,
+	EDGBWR		= 0x05,
+	EEXTEND		= 0x06,
+	ELDU		= 0x08,
+	EBLOCK		= 0x09,
+	EPA		= 0x0A,
+	EWB		= 0x0B,
+	ETRACK		= 0x0C,
+	EAUG		= 0x0D,
+	EMODPR		= 0x0E,
+	EMODT		= 0x0F,
+	EUPDATESVN	= 0x18,
 };
 
 /**
diff --git a/arch/x86/kernel/cpu/sgx/encls.h b/arch/x86/kernel/cpu/sgx/encls.h
index 3f1797ec2445..b0aa110e7560 100644
--- a/arch/x86/kernel/cpu/sgx/encls.h
+++ b/arch/x86/kernel/cpu/sgx/encls.h
@@ -243,4 +243,10 @@ static inline int __eaug(struct sgx_pageinfo *pginfo, void *addr)
 	return __encls_2(EAUG, pginfo, addr);
 }
 
+/* Update CPUSVN at runtime. */
+static inline int __eupdatesvn(void)
+{
+	return __encls_ret_1(EUPDATESVN, "");
+}
+
 #endif /* _X86_ENCLS_H */
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index f3dd3757ef9f..123818fa2386 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -1328,3 +1328,55 @@ void sgx_zap_abort(void)
 	sgx_zap_abort_wait = true;
 	wake_up(&sgx_zap_waitq);
 }
+
+/**
+ * sgx_updatesvn() - Issue ENCLS[EUPDATESVN]
+ * If EPC is ready, this instruction will update CPUSVN to the currently
+ * loaded microcode update SVN and generate new cryptographic assets.
+ *
+ * Return:
+ * 0:				CPUSVN is update successfully.
+ * %SGX_LOCKFAIL:		An instruction concurrency rule was violated.
+ * %SGX_INSUFFICIENT_ENTROPY:	Insufficient entropy in RNG.
+ * %SGX_EPC_NOT_READY:		EPC is not ready for SVN update.
+ * %SGX_NO_UPDATE:		EUPDATESVN was successful, but CPUSVN was not
+ *				updated because current SVN was not newer than
+ *				CPUSVN.
+ */
+static int sgx_updatesvn(void)
+{
+	int ret;
+	int retry = 10;
+
+	do {
+		ret = __eupdatesvn();
+		if (ret != SGX_INSUFFICIENT_ENTROPY)
+			break;
+
+	} while (--retry);
+
+	switch (ret) {
+	case 0:
+		pr_info("EUPDATESVN was successful!\n");
+		break;
+	case SGX_NO_UPDATE:
+		pr_info("EUPDATESVN was successful, but CPUSVN was not updated, "
+			"because current SVN was not newer than CPUSVN.\n");
+		break;
+	case SGX_EPC_NOT_READY:
+		pr_info("EPC is not ready for SVN update.");
+		break;
+	case SGX_INSUFFICIENT_ENTROPY:
+		pr_info("CPUSVN update is failed due to Insufficient entropy in RNG, "
+			"please try it later.\n");
+		break;
+	case SGX_EPC_PAGE_CONFLICT:
+		pr_info("CPUSVN update is failed due to concurrency violation, please "
+			"stop running any other ENCLS leaf and try it later.\n");
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
-- 
2.17.1

