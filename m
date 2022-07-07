Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8562356AAA5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236413AbiGGS2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236401AbiGGS1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:27:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403EE5A46E;
        Thu,  7 Jul 2022 11:27:40 -0700 (PDT)
Date:   Thu, 07 Jul 2022 18:27:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657218458;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rL5VWE9dGToPA+dFinoTJjCDvFgyGRUrbvC8WBbjt2c=;
        b=xw4f9YdivudpwvdbfLKjwgzenQJLAUWPziMuQcDI6ubOWj5EJRMARVHAqkVHpSfBMBW1z0
        TsbzLLxhfMgCRcXtbwMsBHcdkpKQIHY34csCYy/a2euh1532X6u95PrbBr7wYzS618t/QU
        jKT9Ssx+YvBLqN4V1o5WbZX8I2xSyPDLbEOEDCDsJn/sK+LtrPiDBZWaFFWUk38NvNmYT0
        H868wdeSvEeGMrXbeps4x+ZmHTjy0M6+WZD3fGprWHeiWKVAf0vIWZgXHUnbf7QSrBTieB
        cEEeNR5iLwN/c69UQoerJ/SZnIwKSh7QdbKxmrjhtX9oeyS+mXWMiyjssk7IKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657218458;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rL5VWE9dGToPA+dFinoTJjCDvFgyGRUrbvC8WBbjt2c=;
        b=K0dBfvj8yD/cHPIwN6/26RYVF3+GIFAOd7Y6S4at4PjhlNPGNRA9wiruUa4IlnQHa3GmII
        +z/VjCcboPywEUBA==
From:   "tip-bot2 for Reinette Chatre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] selftests/sgx: Add test for EPCM permission changes
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C2617bf2b2d1e27ca1d0096e1192ae5896baf3f80=2E16521?=
 =?utf-8?q?37848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3C2617bf2b2d1e27ca1d0096e1192ae5896baf3f80=2E165213?=
 =?utf-8?q?7848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165721845769.15455.9507530652543460065.tip-bot2@tip-bot2>
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

Commit-ID:     20404a808593a6812cb485bec16256e702ff94c3
Gitweb:        https://git.kernel.org/tip/20404a808593a6812cb485bec16256e702ff94c3
Author:        Reinette Chatre <reinette.chatre@intel.com>
AuthorDate:    Tue, 10 May 2022 11:08:58 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 07 Jul 2022 10:13:03 -07:00

selftests/sgx: Add test for EPCM permission changes

EPCM permission changes could be made from within (to relax
permissions) or out (to restrict permissions) the enclave. Kernel
support is needed when permissions are restricted to be able to
call the privileged ENCLS[EMODPR] instruction. EPCM permissions
can be relaxed via ENCLU[EMODPE] from within the enclave but the
enclave still depends on the kernel to install PTEs with the needed
permissions.

Add a test that exercises a few of the enclave page permission flows:
1) Test starts with a RW (from enclave and kernel perspective)
   enclave page that is mapped via a RW VMA.
2) Use the SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS ioctl() to restrict
   the enclave (EPCM) page permissions to read-only.
3) Run ENCLU[EACCEPT] from within the enclave to accept the new page
   permissions.
4) Attempt to write to the enclave page from within the enclave - this
   should fail with a page fault on the EPCM permissions since the page
   table entry continues to allow RW access.
5) Restore EPCM permissions to RW by running ENCLU[EMODPE] from within
   the enclave.
6) Attempt to write to the enclave page from within the enclave - this
   should succeed since both EPCM and PTE permissions allow this access.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lkml.kernel.org/r/2617bf2b2d1e27ca1d0096e1192ae5896baf3f80.1652137848.git.reinette.chatre@intel.com
---
 tools/testing/selftests/sgx/defines.h   |  15 ++-
 tools/testing/selftests/sgx/main.c      | 214 +++++++++++++++++++++++-
 tools/testing/selftests/sgx/test_encl.c |  38 ++++-
 3 files changed, 267 insertions(+)

diff --git a/tools/testing/selftests/sgx/defines.h b/tools/testing/selftests/sgx/defines.h
index 02d7757..b638eb9 100644
--- a/tools/testing/selftests/sgx/defines.h
+++ b/tools/testing/selftests/sgx/defines.h
@@ -24,6 +24,8 @@ enum encl_op_type {
 	ENCL_OP_PUT_TO_ADDRESS,
 	ENCL_OP_GET_FROM_ADDRESS,
 	ENCL_OP_NOP,
+	ENCL_OP_EACCEPT,
+	ENCL_OP_EMODPE,
 	ENCL_OP_MAX,
 };
 
@@ -53,4 +55,17 @@ struct encl_op_get_from_addr {
 	uint64_t addr;
 };
 
+struct encl_op_eaccept {
+	struct encl_op_header header;
+	uint64_t epc_addr;
+	uint64_t flags;
+	uint64_t ret;
+};
+
+struct encl_op_emodpe {
+	struct encl_op_header header;
+	uint64_t epc_addr;
+	uint64_t flags;
+};
+
 #endif /* DEFINES_H */
diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index dd74fa4..46eac09 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -25,6 +25,18 @@ static const uint64_t MAGIC = 0x1122334455667788ULL;
 static const uint64_t MAGIC2 = 0x8877665544332211ULL;
 vdso_sgx_enter_enclave_t vdso_sgx_enter_enclave;
 
+/*
+ * Security Information (SECINFO) data structure needed by a few SGX
+ * instructions (eg. ENCLU[EACCEPT] and ENCLU[EMODPE]) holds meta-data
+ * about an enclave page. &enum sgx_secinfo_page_state specifies the
+ * secinfo flags used for page state.
+ */
+enum sgx_secinfo_page_state {
+	SGX_SECINFO_PENDING = (1 << 3),
+	SGX_SECINFO_MODIFIED = (1 << 4),
+	SGX_SECINFO_PR = (1 << 5),
+};
+
 struct vdso_symtab {
 	Elf64_Sym *elf_symtab;
 	const char *elf_symstrtab;
@@ -555,4 +567,206 @@ TEST_F(enclave, pte_permissions)
 	EXPECT_EQ(self->run.exception_addr, 0);
 }
 
+/*
+ * Enclave page permission test.
+ *
+ * Modify and restore enclave page's EPCM (enclave) permissions from
+ * outside enclave (ENCLS[EMODPR] via kernel) as well as from within
+ * enclave (via ENCLU[EMODPE]). Check for page fault if
+ * VMA allows access but EPCM permissions do not.
+ */
+TEST_F(enclave, epcm_permissions)
+{
+	struct sgx_enclave_restrict_permissions restrict_ioc;
+	struct encl_op_get_from_addr get_addr_op;
+	struct encl_op_put_to_addr put_addr_op;
+	struct encl_op_eaccept eaccept_op;
+	struct encl_op_emodpe emodpe_op;
+	unsigned long data_start;
+	int ret, errno_save;
+
+	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
+
+	memset(&self->run, 0, sizeof(self->run));
+	self->run.tcs = self->encl.encl_base;
+
+	/*
+	 * Ensure kernel supports needed ioctl() and system supports needed
+	 * commands.
+	 */
+	memset(&restrict_ioc, 0, sizeof(restrict_ioc));
+
+	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS,
+		    &restrict_ioc);
+	errno_save = ret == -1 ? errno : 0;
+
+	/*
+	 * Invalid parameters were provided during sanity check,
+	 * expect command to fail.
+	 */
+	ASSERT_EQ(ret, -1);
+
+	/* ret == -1 */
+	if (errno_save == ENOTTY)
+		SKIP(return,
+		     "Kernel does not support SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS ioctl()");
+	else if (errno_save == ENODEV)
+		SKIP(return, "System does not support SGX2");
+
+	/*
+	 * Page that will have its permissions changed is the second data
+	 * page in the .data segment. This forms part of the local encl_buffer
+	 * within the enclave.
+	 *
+	 * At start of test @data_start should have EPCM as well as PTE and
+	 * VMA permissions of RW.
+	 */
+
+	data_start = self->encl.encl_base +
+		     encl_get_data_offset(&self->encl) + PAGE_SIZE;
+
+	/*
+	 * Sanity check that page at @data_start is writable before making
+	 * any changes to page permissions.
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
+	 * Read memory that was just written to, confirming that
+	 * page is writable.
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
+	/*
+	 * Change EPCM permissions to read-only. Kernel still considers
+	 * the page writable.
+	 */
+	memset(&restrict_ioc, 0, sizeof(restrict_ioc));
+
+	restrict_ioc.offset = encl_get_data_offset(&self->encl) + PAGE_SIZE;
+	restrict_ioc.length = PAGE_SIZE;
+	restrict_ioc.permissions = SGX_SECINFO_R;
+
+	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS,
+		    &restrict_ioc);
+	errno_save = ret == -1 ? errno : 0;
+
+	EXPECT_EQ(ret, 0);
+	EXPECT_EQ(errno_save, 0);
+	EXPECT_EQ(restrict_ioc.result, 0);
+	EXPECT_EQ(restrict_ioc.count, 4096);
+
+	/*
+	 * EPCM permissions changed from kernel, need to EACCEPT from enclave.
+	 */
+	eaccept_op.epc_addr = data_start;
+	eaccept_op.flags = SGX_SECINFO_R | SGX_SECINFO_REG | SGX_SECINFO_PR;
+	eaccept_op.ret = 0;
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
+	/*
+	 * EPCM permissions of page is now read-only, expect #PF
+	 * on EPCM when attempting to write to page from within enclave.
+	 */
+	put_addr_op.value = MAGIC2;
+
+	EXPECT_EQ(ENCL_CALL(&put_addr_op, &self->run, true), 0);
+
+	EXPECT_EQ(self->run.function, ERESUME);
+	EXPECT_EQ(self->run.exception_vector, 14);
+	EXPECT_EQ(self->run.exception_error_code, 0x8007);
+	EXPECT_EQ(self->run.exception_addr, data_start);
+
+	self->run.exception_vector = 0;
+	self->run.exception_error_code = 0;
+	self->run.exception_addr = 0;
+
+	/*
+	 * Received AEX but cannot return to enclave at same entrypoint,
+	 * need different TCS from where EPCM permission can be made writable
+	 * again.
+	 */
+	self->run.tcs = self->encl.encl_base + PAGE_SIZE;
+
+	/*
+	 * Enter enclave at new TCS to change EPCM permissions to be
+	 * writable again and thus fix the page fault that triggered the
+	 * AEX.
+	 */
+
+	emodpe_op.epc_addr = data_start;
+	emodpe_op.flags = SGX_SECINFO_R | SGX_SECINFO_W;
+	emodpe_op.header.type = ENCL_OP_EMODPE;
+
+	EXPECT_EQ(ENCL_CALL(&emodpe_op, &self->run, true), 0);
+
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.exception_vector, 0);
+	EXPECT_EQ(self->run.exception_error_code, 0);
+	EXPECT_EQ(self->run.exception_addr, 0);
+
+	/*
+	 * Attempt to return to main TCS to resume execution at faulting
+	 * instruction, PTE should continue to allow writing to the page.
+	 */
+	self->run.tcs = self->encl.encl_base;
+
+	/*
+	 * Wrong page permissions that caused original fault has
+	 * now been fixed via EPCM permissions.
+	 * Resume execution in main TCS to re-attempt the memory access.
+	 */
+	self->run.tcs = self->encl.encl_base;
+
+	EXPECT_EQ(vdso_sgx_enter_enclave((unsigned long)&put_addr_op, 0, 0,
+					 ERESUME, 0, 0,
+					 &self->run),
+		  0);
+
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.exception_vector, 0);
+	EXPECT_EQ(self->run.exception_error_code, 0);
+	EXPECT_EQ(self->run.exception_addr, 0);
+
+	get_addr_op.value = 0;
+
+	EXPECT_EQ(ENCL_CALL(&get_addr_op, &self->run, true), 0);
+
+	EXPECT_EQ(get_addr_op.value, MAGIC2);
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.user_data, 0);
+	EXPECT_EQ(self->run.exception_vector, 0);
+	EXPECT_EQ(self->run.exception_error_code, 0);
+	EXPECT_EQ(self->run.exception_addr, 0);
+}
+
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/sgx/test_encl.c b/tools/testing/selftests/sgx/test_encl.c
index 4fca01c..5b6c653 100644
--- a/tools/testing/selftests/sgx/test_encl.c
+++ b/tools/testing/selftests/sgx/test_encl.c
@@ -11,6 +11,42 @@
  */
 static uint8_t encl_buffer[8192] = { 1 };
 
+enum sgx_enclu_function {
+	EACCEPT = 0x5,
+	EMODPE = 0x6,
+};
+
+static void do_encl_emodpe(void *_op)
+{
+	struct sgx_secinfo secinfo __aligned(sizeof(struct sgx_secinfo)) = {0};
+	struct encl_op_emodpe *op = _op;
+
+	secinfo.flags = op->flags;
+
+	asm volatile(".byte 0x0f, 0x01, 0xd7"
+				:
+				: "a" (EMODPE),
+				  "b" (&secinfo),
+				  "c" (op->epc_addr));
+}
+
+static void do_encl_eaccept(void *_op)
+{
+	struct sgx_secinfo secinfo __aligned(sizeof(struct sgx_secinfo)) = {0};
+	struct encl_op_eaccept *op = _op;
+	int rax;
+
+	secinfo.flags = op->flags;
+
+	asm volatile(".byte 0x0f, 0x01, 0xd7"
+				: "=a" (rax)
+				: "a" (EACCEPT),
+				  "b" (&secinfo),
+				  "c" (op->epc_addr));
+
+	op->ret = rax;
+}
+
 static void *memcpy(void *dest, const void *src, size_t n)
 {
 	size_t i;
@@ -62,6 +98,8 @@ void encl_body(void *rdi,  void *rsi)
 		do_encl_op_put_to_addr,
 		do_encl_op_get_from_addr,
 		do_encl_op_nop,
+		do_encl_eaccept,
+		do_encl_emodpe,
 	};
 
 	struct encl_op_header *op = (struct encl_op_header *)rdi;
