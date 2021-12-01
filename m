Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8780A465650
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 20:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245251AbhLAT1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 14:27:09 -0500
Received: from mga05.intel.com ([192.55.52.43]:21702 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244564AbhLAT1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 14:27:05 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="322784104"
X-IronPort-AV: E=Sophos;i="5.87,279,1631602800"; 
   d="scan'208";a="322784104"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 11:23:43 -0800
X-IronPort-AV: E=Sophos;i="5.87,279,1631602800"; 
   d="scan'208";a="500380470"
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
Subject: [PATCH 12/25] selftests/sgx: Add test for TCS page permission changes
Date:   Wed,  1 Dec 2021 11:23:10 -0800
Message-Id: <b8e24d27fbd791c00339397c0aea1c2ef282f2a0.1638381245.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1638381245.git.reinette.chatre@intel.com>
References: <cover.1638381245.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel should not allow permission changes on TCS pages. Add test to
confirm this behavior.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/sgx/main.c | 70 ++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index dbd071ba03fe..c7c50d05e246 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -120,6 +120,24 @@ static Elf64_Sym *vdso_symtab_get(struct vdso_symtab *symtab, const char *name)
 	return NULL;
 }
 
+/*
+ * Return the offset in the enclave where the TCS segment can be found.
+ * The first RW segment loaded is the TCS.
+ */
+static off_t encl_get_tcs_offset(struct encl *encl)
+{
+	int i;
+
+	for (i = 0; i < encl->nr_segments; i++) {
+		struct encl_segment *seg = &encl->segment_tbl[i];
+
+		if (i == 0 && seg->prot == (PROT_READ | PROT_WRITE))
+			return seg->offset;
+	}
+
+	return -1;
+}
+
 /*
  * Return the offset in the enclave where the data segment can be found.
  * The first RW segment loaded is the TCS, skip that to get info on the
@@ -567,6 +585,58 @@ TEST_F(enclave, pte_permissions)
 	EXPECT_EQ(self->run.exception_addr, 0);
 }
 
+/*
+ * Modifying permissions of TCS page should not be possible.
+ */
+TEST_F(enclave, tcs_permissions)
+{
+	struct sgx_page_modp ioc;
+	int ret, errno_save;
+
+	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
+
+	memset(&self->run, 0, sizeof(self->run));
+	self->run.tcs = self->encl.encl_base;
+
+	memset(&ioc, 0, sizeof(ioc));
+
+	/*
+	 * Ensure kernel supports needed ioctl and system supports needed
+	 * commands.
+	 */
+
+	ret = ioctl(self->encl.fd, SGX_IOC_PAGE_MODP, &ioc);
+
+	if (ret == -1) {
+		if (errno == ENOTTY)
+			SKIP(return, "Kernel does not support test SGX_IOC_PAGE_MODP ioctl");
+		else if (errno == ENODEV)
+			SKIP(return, "System does not support SGX2");
+	}
+
+	/*
+	 * Invalid parameters were provided during sanity check,
+	 * expect command to fail.
+	 */
+	EXPECT_EQ(ret, -1);
+
+	/*
+	 * Attempt to make TCS page read-only. This is not allowed and
+	 * should be prevented by OS.
+	 */
+	ioc.offset = encl_get_tcs_offset(&self->encl);
+	ioc.length = PAGE_SIZE;
+	ioc.prot = PROT_READ;
+
+	ret = ioctl(self->encl.fd, SGX_IOC_PAGE_MODP, &ioc);
+	errno_save = ret == -1 ? errno : 0;
+
+	EXPECT_EQ(ret, -1);
+	EXPECT_EQ(errno_save, EINVAL);
+	EXPECT_EQ(ioc.result, 0);
+	EXPECT_EQ(ioc.count, 0);
+}
+
 /*
  * Enclave page permission test.
  *
-- 
2.25.1

