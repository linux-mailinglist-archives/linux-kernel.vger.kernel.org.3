Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A994465659
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 20:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352706AbhLAT1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 14:27:46 -0500
Received: from mga05.intel.com ([192.55.52.43]:21705 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245134AbhLAT1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 14:27:06 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="322784118"
X-IronPort-AV: E=Sophos;i="5.87,279,1631602800"; 
   d="scan'208";a="322784118"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 11:23:44 -0800
X-IronPort-AV: E=Sophos;i="5.87,279,1631602800"; 
   d="scan'208";a="500380512"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 11:23:43 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 25/25] selftests/sgx: Page removal stress test
Date:   Wed,  1 Dec 2021 11:23:23 -0800
Message-Id: <a0d326877f202b837e68a935289dc50aede4e9e9.1638381245.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1638381245.git.reinette.chatre@intel.com>
References: <cover.1638381245.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create enclave with additional heap that consumes all physical SGX memory
and then remove it.

Depending on the available SGX memory this test could take a significant
time to run (several minutes) as it (1) creates the enclave, (2)
changes the type of every page to be trimmed, (3) enters the enclave
once per page to run EACCEPT, before (4) the pages are finally removed.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/sgx/main.c | 98 ++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index 618f5ff0601b..c1495eaafe79 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -393,7 +393,105 @@ TEST_F(enclave, unclobbered_vdso_oversubscribed)
 	EXPECT_EQ(get_op.value, MAGIC);
 	EXPECT_EEXIT(&self->run);
 	EXPECT_EQ(self->run.user_data, 0);
+}
+
+TEST_F_TIMEOUT(enclave, unclobbered_vdso_oversubscribed_remove, 900)
+{
+	struct encl_op_get_from_buf get_op;
+	struct encl_op_put_to_buf put_op;
+	struct sgx_page_modt modt_ioc;
+	struct encl_segment *heap;
+	unsigned long total_mem;
+	int ret, errno_save;
+	unsigned long addr;
+	struct encl_op_eaccept eaccept_op;
+	struct sgx_page_remove remove_ioc;
+	unsigned long i;
+
+	/*
+	 * Create enclave with additional heap that is as big as all
+	 * available physical SGX memory.
+	 */
+	total_mem = get_total_epc_mem();
+	ASSERT_NE(total_mem, 0);
+	TH_LOG("Creating an enclave with %lu bytes heap may take a while ...",
+	       total_mem);
+	ASSERT_TRUE(setup_test_encl(total_mem, &self->encl, _metadata));
+
+	memset(&self->run, 0, sizeof(self->run));
+	self->run.tcs = self->encl.encl_base;
+
+	heap = &self->encl.segment_tbl[self->encl.nr_segments - 1];
+
+	put_op.header.type = ENCL_OP_PUT_TO_BUFFER;
+	put_op.value = MAGIC;
+
+	EXPECT_EQ(ENCL_CALL(&put_op, &self->run, false), 0);
+
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.user_data, 0);
+
+	get_op.header.type = ENCL_OP_GET_FROM_BUFFER;
+	get_op.value = 0;
+
+	EXPECT_EQ(ENCL_CALL(&get_op, &self->run, false), 0);
+
+	EXPECT_EQ(get_op.value, MAGIC);
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.user_data, 0);
+
+	/* Trim  entire heap */
+	memset(&modt_ioc, 0, sizeof(modt_ioc));
+
+	modt_ioc.offset = heap->offset;
+	modt_ioc.length = heap->size;
+	modt_ioc.type = SGX_PAGE_TYPE_TRIM;
+
+	TH_LOG("Changing type of %zd bytes to trimmed may take a while ...",
+	       heap->size);
+	ret = ioctl(self->encl.fd, SGX_IOC_PAGE_MODT, &modt_ioc);
+	errno_save = ret == -1 ? errno : 0;
+
+	EXPECT_EQ(ret, 0);
+	EXPECT_EQ(errno_save, 0);
+	EXPECT_EQ(modt_ioc.result, 0);
+	EXPECT_EQ(modt_ioc.count, heap->size);
 
+	/* EACCEPT all removed pages */
+	addr = self->encl.encl_base + heap->offset;
+
+	eaccept_op.flags = SGX_SECINFO_TRIM | SGX_SECINFO_MODIFIED;
+	eaccept_op.header.type = ENCL_OP_EACCEPT;
+
+	TH_LOG("Entering enclave to run EACCEPT for each page of %zd bytes may take a while ...",
+	       heap->size);
+	for (i = 0; i < heap->size; i += 4096) {
+		eaccept_op.epc_addr = addr + i;
+		eaccept_op.ret = 0;
+
+		EXPECT_EQ(ENCL_CALL(&eaccept_op, &self->run, true), 0);
+
+		EXPECT_EEXIT(&self->run);
+		EXPECT_EQ(self->run.exception_vector, 0);
+		EXPECT_EQ(self->run.exception_error_code, 0);
+		EXPECT_EQ(self->run.exception_addr, 0);
+		EXPECT_EQ(eaccept_op.ret, 0);
+	}
+
+	/* Complete page removal */
+	memset(&remove_ioc, 0, sizeof(remove_ioc));
+
+	remove_ioc.offset = heap->offset;
+	remove_ioc.length = heap->size;
+
+	TH_LOG("Removing %zd bytes from enclave may take a while ...",
+	       heap->size);
+	ret = ioctl(self->encl.fd, SGX_IOC_PAGE_REMOVE, &remove_ioc);
+	errno_save = ret == -1 ? errno : 0;
+
+	EXPECT_EQ(ret, 0);
+	EXPECT_EQ(errno_save, 0);
+	EXPECT_EQ(remove_ioc.count, heap->size);
 }
 
 TEST_F(enclave, clobbered_vdso)
-- 
2.25.1

