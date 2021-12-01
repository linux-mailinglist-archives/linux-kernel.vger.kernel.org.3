Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1EF46565A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 20:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245268AbhLAT1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 14:27:48 -0500
Received: from mga05.intel.com ([192.55.52.43]:21702 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229655AbhLAT1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 14:27:06 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="322784117"
X-IronPort-AV: E=Sophos;i="5.87,279,1631602800"; 
   d="scan'208";a="322784117"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 11:23:44 -0800
X-IronPort-AV: E=Sophos;i="5.87,279,1631602800"; 
   d="scan'208";a="500380507"
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
Subject: [PATCH 23/25] selftests/sgx: Test reclaiming of untouched page
Date:   Wed,  1 Dec 2021 11:23:21 -0800
Message-Id: <5dfa762816df7aad50303ea6519cdf049b19ffed.1638381245.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1638381245.git.reinette.chatre@intel.com>
References: <cover.1638381245.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removing a page from an initialized enclave involves three steps: (1) the
user requests changing the page type to PT_TRIM via the SGX_IOC_PAGE_MODT
ioctl, (2) on success the ENCLU[EACCEPT] instruction is run from within
the enclave to accept the page removal, (3) the user initiates the actual
removal of the page via the SGX_IOC_PAGE_REMOVE ioctl.

Remove a page that has never been accessed. This means that when the first
ioctl requesting page removal arrives, there will be no page table entry,
yet a valid page table entry needs to exist for the ENCLU[EACCEPT] function
to succeed. In this test it is verified that a page table entry can still
be installed for a page that is in the process of being removed.

Suggested-by: Haitao Huang <haitao.huang@intel.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/sgx/main.c | 58 ++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index 3bee8fa557fd..618f5ff0601b 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -1849,4 +1849,62 @@ TEST_F(enclave, remove_added_page_invalid_access_after_eaccept)
 	EXPECT_EQ(self->run.exception_addr, data_start);
 }
 
+TEST_F(enclave, remove_untouched_page)
+{
+	struct encl_op_eaccept eaccept_op;
+	struct sgx_page_remove remove_ioc;
+	struct sgx_page_modt modt_ioc;
+	unsigned long data_start;
+	int ret, errno_save;
+
+	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
+
+	memset(&self->run, 0, sizeof(self->run));
+	self->run.tcs = self->encl.encl_base;
+
+	data_start = self->encl.encl_base +
+			 encl_get_data_offset(&self->encl) + PAGE_SIZE;
+
+	memset(&modt_ioc, 0, sizeof(modt_ioc));
+
+	modt_ioc.offset = encl_get_data_offset(&self->encl) + PAGE_SIZE;
+	modt_ioc.length = PAGE_SIZE;
+	modt_ioc.type = SGX_PAGE_TYPE_TRIM;
+	ret = ioctl(self->encl.fd, SGX_IOC_PAGE_MODT, &modt_ioc);
+	errno_save = ret == -1 ? errno : 0;
+
+	EXPECT_EQ(ret, 0);
+	EXPECT_EQ(errno_save, 0);
+	EXPECT_EQ(modt_ioc.result, 0);
+	EXPECT_EQ(modt_ioc.count, 4096);
+
+	/*
+	 * Enter enclave via TCS #1 and approve page removal by sending
+	 * EACCEPT for removed page.
+	 */
+
+	eaccept_op.epc_addr = data_start;
+	eaccept_op.flags = SGX_SECINFO_TRIM | SGX_SECINFO_MODIFIED;
+	eaccept_op.ret = 0;
+	eaccept_op.header.type = ENCL_OP_EACCEPT;
+
+	EXPECT_EQ(ENCL_CALL(&eaccept_op, &self->run, true), 0);
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.exception_vector, 0);
+	EXPECT_EQ(self->run.exception_error_code, 0);
+	EXPECT_EQ(self->run.exception_addr, 0);
+	EXPECT_EQ(eaccept_op.ret, 0);
+
+	memset(&remove_ioc, 0, sizeof(remove_ioc));
+
+	remove_ioc.offset = encl_get_data_offset(&self->encl) + PAGE_SIZE;
+	remove_ioc.length = PAGE_SIZE;
+	ret = ioctl(self->encl.fd, SGX_IOC_PAGE_REMOVE, &remove_ioc);
+	errno_save = ret == -1 ? errno : 0;
+
+	EXPECT_EQ(ret, 0);
+	EXPECT_EQ(errno_save, 0);
+	EXPECT_EQ(remove_ioc.count, 4096);
+}
+
 TEST_HARNESS_MAIN
-- 
2.25.1

