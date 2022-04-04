Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22B24F1EFB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344266AbiDDWED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379280AbiDDQv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:51:58 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E233614C;
        Mon,  4 Apr 2022 09:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649091002; x=1680627002;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zMStoctvIXS731FS95jXFMrV7zUA076B2o1n0dI0HHY=;
  b=anP5NmP9zwl8eDDw3y8FAlxDSBV/zBEYff77mQoCupK2Ac4+31tD4aVi
   3PDpaIT0C3iuTrrtYIuks6ch1kHAmGZyb60usLFwY6VydYjOggyFK/aLk
   ETEFwiTJIfhZOgpEValxDTW9VdtJgzA1akZDxEszVpAg0mMb/uXimiImY
   o/xRUeA/fiB6NKKHC7vA7Be99Cj5o5Cz+SxtcJgRzcYQefZAFv+NcimSh
   YlvI/Nyye/8gylEjl7PqUNMJP3ksdfvAg+n2BDfi3+HA6zD0ZO8mKeqro
   l/YUEaWddjfeg+v3AF3286/cU9h2xE+GLmTKYxXfeJfex09C8durU7uQl
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="323734061"
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="323734061"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 09:49:51 -0700
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="523105235"
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
Subject: [PATCH V3 28/30] selftests/sgx: Test invalid access to removed enclave page
Date:   Mon,  4 Apr 2022 09:49:36 -0700
Message-Id: <d76ef5541fba90a9100ece0876a150845af5186f.1648847675.git.reinette.chatre@intel.com>
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

Removing a page from an initialized enclave involves three steps:
(1) the user requests changing the page type to SGX_PAGE_TYPE_TRIM
via the SGX_IOC_ENCLAVE_MODIFY_TYPE  ioctl(), (2) on success the
ENCLU[EACCEPT] instruction is run from within the enclave to accept
the page removal, (3) the user initiates the actual removal of the
page via the SGX_IOC_ENCLAVE_REMOVE_PAGES ioctl().

Test two possible invalid accesses during the page removal flow:
* Test the behavior when a request to remove the page by changing its
  type to SGX_PAGE_TYPE_TRIM completes successfully but instead of
  executing ENCLU[EACCEPT] from within the enclave the enclave attempts
  to read from the page. Even though the page is accessible from the
  page table entries its type is SGX_PAGE_TYPE_TRIM and thus not
  accessible according to SGX. The expected behavior is a page fault
  with the SGX flag set in the error code.
* Test the behavior when the page type is changed successfully and
  ENCLU[EACCEPT] was run from within the enclave. The final ioctl(),
  SGX_IOC_ENCLAVE_REMOVE_PAGES, is omitted and replaced with an
  attempt to access the page. Even though the page is accessible
  from the page table entries its type is SGX_PAGE_TYPE_TRIM and
  thus not accessible according to SGX.  The expected behavior is
  a page fault with the SGX flag set in the error code.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V2:
- Rename struct sgx_enclave_modt -> struct sgx_enclave_modify_type

Changes since V1:
- Update to support ioctl() name change (SGX_IOC_PAGE_MODT ->
  SGX_IOC_ENCLAVE_MODIFY_TYPE) and provide secinfo as parameter instead
  of just page type (Jarkko).
- Use ioctl() instead of ioctl (Dave).

 tools/testing/selftests/sgx/main.c | 247 +++++++++++++++++++++++++++++
 1 file changed, 247 insertions(+)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index f6a8e2dd4a23..f9f8e3697fa6 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -1560,4 +1560,251 @@ TEST_F(enclave, remove_added_page_no_eaccept)
 	EXPECT_EQ(remove_ioc.count, 0);
 }
 
+/*
+ * Request enclave page removal but instead of correctly following with
+ * EACCEPT a read attempt to page is made from within the enclave.
+ */
+TEST_F(enclave, remove_added_page_invalid_access)
+{
+	struct encl_op_get_from_addr get_addr_op;
+	struct encl_op_put_to_addr put_addr_op;
+	struct sgx_enclave_modify_type ioc;
+	struct sgx_secinfo secinfo;
+	unsigned long data_start;
+	int ret, errno_save;
+
+	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
+
+	memset(&self->run, 0, sizeof(self->run));
+	self->run.tcs = self->encl.encl_base;
+
+	/*
+	 * Hardware (SGX2) and kernel support is needed for this test. Start
+	 * with check that test has a chance of succeeding.
+	 */
+	memset(&ioc, 0, sizeof(ioc));
+	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_MODIFY_TYPE, &ioc);
+
+	if (ret == -1) {
+		if (errno == ENOTTY)
+			SKIP(return, "Kernel does not support SGX_IOC_ENCLAVE_MODIFY_TYPE ioctl()");
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
+	 * Page that will be removed is the second data page in the .data
+	 * segment. This forms part of the local encl_buffer within the
+	 * enclave.
+	 */
+	data_start = self->encl.encl_base +
+		     encl_get_data_offset(&self->encl) + PAGE_SIZE;
+
+	/*
+	 * Sanity check that page at @data_start is writable before
+	 * removing it.
+	 *
+	 * Start by writing MAGIC to test page.
+	 */
+	put_addr_op.value = MAGIC;
+	put_addr_op.addr = data_start;
+	put_addr_op.header.type = ENCL_OP_PUT_TO_ADDRESS;
+
+	EXPECT_EQ(ENCL_CALL(&put_addr_op, &self->run, true), 0);
+
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.exception_vector, 0);
+	EXPECT_EQ(self->run.exception_error_code, 0);
+	EXPECT_EQ(self->run.exception_addr, 0);
+
+	/*
+	 * Read memory that was just written to, confirming that data
+	 * previously written (MAGIC) is present.
+	 */
+	get_addr_op.value = 0;
+	get_addr_op.addr = data_start;
+	get_addr_op.header.type = ENCL_OP_GET_FROM_ADDRESS;
+
+	EXPECT_EQ(ENCL_CALL(&get_addr_op, &self->run, true), 0);
+
+	EXPECT_EQ(get_addr_op.value, MAGIC);
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.exception_vector, 0);
+	EXPECT_EQ(self->run.exception_error_code, 0);
+	EXPECT_EQ(self->run.exception_addr, 0);
+
+	/* Start page removal by requesting change of page type to PT_TRIM. */
+	memset(&ioc, 0, sizeof(ioc));
+	memset(&secinfo, 0, sizeof(secinfo));
+
+	secinfo.flags = SGX_PAGE_TYPE_TRIM << 8;
+	ioc.offset = encl_get_data_offset(&self->encl) + PAGE_SIZE;
+	ioc.length = PAGE_SIZE;
+	ioc.secinfo = (unsigned long)&secinfo;
+
+	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_MODIFY_TYPE, &ioc);
+	errno_save = ret == -1 ? errno : 0;
+
+	EXPECT_EQ(ret, 0);
+	EXPECT_EQ(errno_save, 0);
+	EXPECT_EQ(ioc.result, 0);
+	EXPECT_EQ(ioc.count, 4096);
+
+	/*
+	 * Read from page that was just removed.
+	 */
+	get_addr_op.value = 0;
+
+	EXPECT_EQ(ENCL_CALL(&get_addr_op, &self->run, true), 0);
+
+	/*
+	 * From kernel perspective the page is present but according to SGX the
+	 * page should not be accessible so a #PF with SGX bit set is
+	 * expected.
+	 */
+
+	EXPECT_EQ(self->run.function, ERESUME);
+	EXPECT_EQ(self->run.exception_vector, 14);
+	EXPECT_EQ(self->run.exception_error_code, 0x8005);
+	EXPECT_EQ(self->run.exception_addr, data_start);
+}
+
+/*
+ * Request enclave page removal and correctly follow with
+ * EACCEPT but do not follow with removal ioctl() but instead a read attempt
+ * to removed page is made from within the enclave.
+ */
+TEST_F(enclave, remove_added_page_invalid_access_after_eaccept)
+{
+	struct encl_op_get_from_addr get_addr_op;
+	struct encl_op_put_to_addr put_addr_op;
+	struct sgx_enclave_modify_type ioc;
+	struct encl_op_eaccept eaccept_op;
+	struct sgx_secinfo secinfo;
+	unsigned long data_start;
+	int ret, errno_save;
+
+	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
+
+	memset(&self->run, 0, sizeof(self->run));
+	self->run.tcs = self->encl.encl_base;
+
+	/*
+	 * Hardware (SGX2) and kernel support is needed for this test. Start
+	 * with check that test has a chance of succeeding.
+	 */
+	memset(&ioc, 0, sizeof(ioc));
+	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_MODIFY_TYPE, &ioc);
+
+	if (ret == -1) {
+		if (errno == ENOTTY)
+			SKIP(return, "Kernel does not support SGX_IOC_ENCLAVE_MODIFY_TYPE ioctl()");
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
+	 * Page that will be removed is the second data page in the .data
+	 * segment. This forms part of the local encl_buffer within the
+	 * enclave.
+	 */
+	data_start = self->encl.encl_base +
+		     encl_get_data_offset(&self->encl) + PAGE_SIZE;
+
+	/*
+	 * Sanity check that page at @data_start is writable before
+	 * removing it.
+	 *
+	 * Start by writing MAGIC to test page.
+	 */
+	put_addr_op.value = MAGIC;
+	put_addr_op.addr = data_start;
+	put_addr_op.header.type = ENCL_OP_PUT_TO_ADDRESS;
+
+	EXPECT_EQ(ENCL_CALL(&put_addr_op, &self->run, true), 0);
+
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.exception_vector, 0);
+	EXPECT_EQ(self->run.exception_error_code, 0);
+	EXPECT_EQ(self->run.exception_addr, 0);
+
+	/*
+	 * Read memory that was just written to, confirming that data
+	 * previously written (MAGIC) is present.
+	 */
+	get_addr_op.value = 0;
+	get_addr_op.addr = data_start;
+	get_addr_op.header.type = ENCL_OP_GET_FROM_ADDRESS;
+
+	EXPECT_EQ(ENCL_CALL(&get_addr_op, &self->run, true), 0);
+
+	EXPECT_EQ(get_addr_op.value, MAGIC);
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.exception_vector, 0);
+	EXPECT_EQ(self->run.exception_error_code, 0);
+	EXPECT_EQ(self->run.exception_addr, 0);
+
+	/* Start page removal by requesting change of page type to PT_TRIM. */
+	memset(&ioc, 0, sizeof(ioc));
+	memset(&secinfo, 0, sizeof(secinfo));
+
+	secinfo.flags = SGX_PAGE_TYPE_TRIM << 8;
+	ioc.offset = encl_get_data_offset(&self->encl) + PAGE_SIZE;
+	ioc.length = PAGE_SIZE;
+	ioc.secinfo = (unsigned long)&secinfo;
+
+	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_MODIFY_TYPE, &ioc);
+	errno_save = ret == -1 ? errno : 0;
+
+	EXPECT_EQ(ret, 0);
+	EXPECT_EQ(errno_save, 0);
+	EXPECT_EQ(ioc.result, 0);
+	EXPECT_EQ(ioc.count, 4096);
+
+	eaccept_op.epc_addr = (unsigned long)data_start;
+	eaccept_op.ret = 0;
+	eaccept_op.flags = SGX_SECINFO_TRIM | SGX_SECINFO_MODIFIED;
+	eaccept_op.header.type = ENCL_OP_EACCEPT;
+
+	EXPECT_EQ(ENCL_CALL(&eaccept_op, &self->run, true), 0);
+
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.exception_vector, 0);
+	EXPECT_EQ(self->run.exception_error_code, 0);
+	EXPECT_EQ(self->run.exception_addr, 0);
+	EXPECT_EQ(eaccept_op.ret, 0);
+
+	/* Skip ioctl() to remove page. */
+
+	/*
+	 * Read from page that was just removed.
+	 */
+	get_addr_op.value = 0;
+
+	EXPECT_EQ(ENCL_CALL(&get_addr_op, &self->run, true), 0);
+
+	/*
+	 * From kernel perspective the page is present but according to SGX the
+	 * page should not be accessible so a #PF with SGX bit set is
+	 * expected.
+	 */
+
+	EXPECT_EQ(self->run.function, ERESUME);
+	EXPECT_EQ(self->run.exception_vector, 14);
+	EXPECT_EQ(self->run.exception_error_code, 0x8005);
+	EXPECT_EQ(self->run.exception_addr, data_start);
+}
+
 TEST_HARNESS_MAIN
-- 
2.25.1

