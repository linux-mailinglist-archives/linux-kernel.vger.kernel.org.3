Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E443E56AAB0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236391AbiGGS1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236346AbiGGS1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:27:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EF75A462;
        Thu,  7 Jul 2022 11:27:33 -0700 (PDT)
Date:   Thu, 07 Jul 2022 18:27:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657218452;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aMK92xryZLrxe2GIY5Rgg8wkMvOJTnaWaTbE/fUMm7Q=;
        b=Wnoak+mur4XLlbr/HpcQmE3uFcUWqiTKiGbuWEAz1imC6HW1DrlbEyr4gwsdpcWzfp1QPd
        VXt0pmOOQ9feUVWE9Zk3GsBkzLMfW6umG3mCVOuU8Kplr9dlPNQL34/1hEKxm797TMMbcS
        iyoIPToDoviD7T4xNImFkviyV9ty7PLa4XR86nSSG6nilEwW8QLM/w3+hbDnI/ERig07Yq
        w0o/JJX0mrpsVhxX4jlKDyITjc7MTQa29TjMbz5PBwZOMLnarc9RqvafB8Lhhvk0obZiEZ
        h4opmGw5Zrls3aptmF5x1W+h8my2MHA2gLAe9ETrt8Wxl3+gtmmI6sejYRf3CQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657218452;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aMK92xryZLrxe2GIY5Rgg8wkMvOJTnaWaTbE/fUMm7Q=;
        b=s4yeuAGQeHhM2vPZBrmIGPQ9jCWrgKjR8UUN5z+7YOwmIOe9QEHXbUETJOm6WXAgAgDC6c
        kyMysod/UKRWDFAQ==
From:   "tip-bot2 for Reinette Chatre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] selftests/sgx: Test invalid access to removed enclave page
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C189a86c25d6d62da7cfdd08ee97abc1a06fcc179=2E16521?=
 =?utf-8?q?37848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3C189a86c25d6d62da7cfdd08ee97abc1a06fcc179=2E165213?=
 =?utf-8?q?7848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165721845105.15455.9948428762179866379.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     35c7e6dacb038e9311e98901d56bb1abd56f9ae0
Gitweb:        https://git.kernel.org/tip/35c7e6dacb038e9311e98901d56bb1abd56f9ae0
Author:        Reinette Chatre <reinette.chatre@intel.com>
AuthorDate:    Tue, 10 May 2022 11:09:05 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 07 Jul 2022 10:13:04 -07:00

selftests/sgx: Test invalid access to removed enclave page

Removing a page from an initialized enclave involves three steps:
(1) the user requests changing the page type to SGX_PAGE_TYPE_TRIM
via the SGX_IOC_ENCLAVE_MODIFY_TYPES  ioctl(), (2) on success the
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
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lkml.kernel.org/r/189a86c25d6d62da7cfdd08ee97abc1a06fcc179.1652137848.git.reinette.chatre@intel.com
---
 tools/testing/selftests/sgx/main.c | 243 ++++++++++++++++++++++++++++-
 1 file changed, 243 insertions(+)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index 3a82bae..2c69045 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -1547,4 +1547,247 @@ TEST_F(enclave, remove_added_page_no_eaccept)
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
+	struct sgx_enclave_modify_types ioc;
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
+	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_MODIFY_TYPES, &ioc);
+
+	if (ret == -1) {
+		if (errno == ENOTTY)
+			SKIP(return,
+			     "Kernel does not support SGX_IOC_ENCLAVE_MODIFY_TYPES ioctl()");
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
+
+	ioc.offset = encl_get_data_offset(&self->encl) + PAGE_SIZE;
+	ioc.length = PAGE_SIZE;
+	ioc.page_type = SGX_PAGE_TYPE_TRIM;
+
+	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_MODIFY_TYPES, &ioc);
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
+	struct sgx_enclave_modify_types ioc;
+	struct encl_op_eaccept eaccept_op;
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
+	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_MODIFY_TYPES, &ioc);
+
+	if (ret == -1) {
+		if (errno == ENOTTY)
+			SKIP(return,
+			     "Kernel does not support SGX_IOC_ENCLAVE_MODIFY_TYPES ioctl()");
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
+
+	ioc.offset = encl_get_data_offset(&self->encl) + PAGE_SIZE;
+	ioc.length = PAGE_SIZE;
+	ioc.page_type = SGX_PAGE_TYPE_TRIM;
+
+	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_MODIFY_TYPES, &ioc);
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
