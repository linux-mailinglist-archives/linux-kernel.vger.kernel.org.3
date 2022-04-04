Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8547D4F1BED
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381991AbiDDVYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379277AbiDDQv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:51:57 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C657A340C8;
        Mon,  4 Apr 2022 09:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649090999; x=1680626999;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7X1aCi5DDK6Esmu+a7vuR1EYuuv8NMxxyboZYaop/vA=;
  b=Qt1hctxOKJ3/rY6+R/9HowpYFdZ5XRvaJaULBftNQMrs/uGSVV+E2lZt
   H7UY3U2Nu32HemQtKkidAYWgcsR7FOw+uzNdAygGl1j5AXQ+DwLuo8diy
   wN3W5XH87QjADu5XnciEC1g0EOFwqVUyEMnFl/wfTEWuEnjBsArw2/NM9
   EYBjMYcnBkELWmdfK2SYb8dtzwc40nQ5YCLlgDaPNWjqXqfsvEqifEFNj
   cKouE/BOtaQfmZWyra6SEwl9zQJqW/ux53coOht0ZOPmUVdErktu4BZiu
   5Ym5y1GAXK0/hVLoCcq5oq/CTU9Y/MV/25Kqz0Inl/AX+ykPDNkx8h4FD
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="323734057"
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="323734057"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 09:49:51 -0700
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="523105218"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 09:49:50 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 23/30] selftests/sgx: Test two different SGX2 EAUG flows
Date:   Mon,  4 Apr 2022 09:49:31 -0700
Message-Id: <88e32e88efc118dc699a6385fc06ceb0cc768633.1648847675.git.reinette.chatre@intel.com>
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

Enclave pages can be added to an initialized enclave when an address
belonging to the enclave but without a backing page is accessed from
within the enclave.

Accessing memory without a backing enclave page from within an enclave
can be in different ways:
1) Pre-emptively run ENCLU[EACCEPT]. Since the addition of a page
   always needs to be accepted by the enclave via ENCLU[EACCEPT] this
   flow is efficient since the first execution of ENCLU[EACCEPT]
   triggers the addition of the page and when execution returns to the
   same instruction the second execution would be successful as an
   acceptance of the page.

2) A direct read or write. The flow where a direct read or write
   triggers the page addition execution cannot resume from the
   instruction (read/write) that triggered the fault but instead
   the enclave needs to be entered at a different entry point to
   run needed ENCLU[EACCEPT] before execution can return to the
   original entry point and the read/write instruction that faulted.

Add tests for both flows.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since v2:
- Add inline comment to the mmap() call used in both EAUG tests
  to explain why the mmap() is expected to succeed. (Jarkko)

Changes since v1:
- Replace __cpuid() definition and usage with __cpuid_count(). (Reinette)
- Fix accuracy of comments.

 tools/testing/selftests/sgx/main.c | 250 +++++++++++++++++++++++++++++
 1 file changed, 250 insertions(+)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index 59573c1128c8..d52637eb5131 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -86,6 +86,15 @@ static bool vdso_get_symtab(void *addr, struct vdso_symtab *symtab)
 	return true;
 }
 
+static inline int sgx2_supported(void)
+{
+	unsigned int eax, ebx, ecx, edx;
+
+	__cpuid_count(SGX_CPUID, 0x0, eax, ebx, ecx, edx);
+
+	return eax & 0x2;
+}
+
 static unsigned long elf_sym_hash(const char *name)
 {
 	unsigned long h = 0, high;
@@ -847,4 +856,245 @@ TEST_F(enclave, epcm_permissions)
 	EXPECT_EQ(self->run.exception_addr, 0);
 }
 
+/*
+ * Test the addition of pages to an initialized enclave via writing to
+ * a page belonging to the enclave's address space but was not added
+ * during enclave creation.
+ */
+TEST_F(enclave, augment)
+{
+	struct encl_op_get_from_addr get_addr_op;
+	struct encl_op_put_to_addr put_addr_op;
+	struct encl_op_eaccept eaccept_op;
+	size_t total_size = 0;
+	void *addr;
+	int i;
+
+	if (!sgx2_supported())
+		SKIP(return, "SGX2 not supported");
+
+	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
+
+	memset(&self->run, 0, sizeof(self->run));
+	self->run.tcs = self->encl.encl_base;
+
+	for (i = 0; i < self->encl.nr_segments; i++) {
+		struct encl_segment *seg = &self->encl.segment_tbl[i];
+
+		total_size += seg->size;
+	}
+
+	/*
+	 * Actual enclave size is expected to be larger than the loaded
+	 * test enclave since enclave size must be a power of 2 in bytes
+	 * and test_encl does not consume it all.
+	 */
+	EXPECT_LT(total_size + PAGE_SIZE, self->encl.encl_size);
+
+	/*
+	 * Create memory mapping for the page that will be added. New
+	 * memory mapping is for one page right after all existing
+	 * mappings.
+	 * Kernel will allow new mapping using any permissions if it
+	 * falls into the enclave's address range but not backed
+	 * by existing enclave pages.
+	 */
+	addr = mmap((void *)self->encl.encl_base + total_size, PAGE_SIZE,
+		    PROT_READ | PROT_WRITE | PROT_EXEC,
+		    MAP_SHARED | MAP_FIXED, self->encl.fd, 0);
+	EXPECT_NE(addr, MAP_FAILED);
+
+	self->run.exception_vector = 0;
+	self->run.exception_error_code = 0;
+	self->run.exception_addr = 0;
+
+	/*
+	 * Attempt to write to the new page from within enclave.
+	 * Expected to fail since page is not (yet) part of the enclave.
+	 * The first #PF will trigger the addition of the page to the
+	 * enclave, but since the new page needs an EACCEPT from within the
+	 * enclave before it can be used it would not be possible
+	 * to successfully return to the failing instruction. This is the
+	 * cause of the second #PF captured here having the SGX bit set,
+	 * it is from hardware preventing the page from being used.
+	 */
+	put_addr_op.value = MAGIC;
+	put_addr_op.addr = (unsigned long)addr;
+	put_addr_op.header.type = ENCL_OP_PUT_TO_ADDRESS;
+
+	EXPECT_EQ(ENCL_CALL(&put_addr_op, &self->run, true), 0);
+
+	EXPECT_EQ(self->run.function, ERESUME);
+	EXPECT_EQ(self->run.exception_vector, 14);
+	EXPECT_EQ(self->run.exception_addr, (unsigned long)addr);
+
+	if (self->run.exception_error_code == 0x6) {
+		munmap(addr, PAGE_SIZE);
+		SKIP(return, "Kernel does not support adding pages to initialized enclave");
+	}
+
+	EXPECT_EQ(self->run.exception_error_code, 0x8007);
+
+	self->run.exception_vector = 0;
+	self->run.exception_error_code = 0;
+	self->run.exception_addr = 0;
+
+	/* Handle AEX by running EACCEPT from new entry point. */
+	self->run.tcs = self->encl.encl_base + PAGE_SIZE;
+
+	eaccept_op.epc_addr = self->encl.encl_base + total_size;
+	eaccept_op.flags = SGX_SECINFO_R | SGX_SECINFO_W | SGX_SECINFO_REG | SGX_SECINFO_PENDING;
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
+	/* Can now return to main TCS to resume execution. */
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
+	/*
+	 * Read memory from newly added page that was just written to,
+	 * confirming that data previously written (MAGIC) is present.
+	 */
+	get_addr_op.value = 0;
+	get_addr_op.addr = (unsigned long)addr;
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
+	munmap(addr, PAGE_SIZE);
+}
+
+/*
+ * Test for the addition of pages to an initialized enclave via a
+ * pre-emptive run of EACCEPT on page to be added.
+ */
+TEST_F(enclave, augment_via_eaccept)
+{
+	struct encl_op_get_from_addr get_addr_op;
+	struct encl_op_put_to_addr put_addr_op;
+	struct encl_op_eaccept eaccept_op;
+	size_t total_size = 0;
+	void *addr;
+	int i;
+
+	if (!sgx2_supported())
+		SKIP(return, "SGX2 not supported");
+
+	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
+
+	memset(&self->run, 0, sizeof(self->run));
+	self->run.tcs = self->encl.encl_base;
+
+	for (i = 0; i < self->encl.nr_segments; i++) {
+		struct encl_segment *seg = &self->encl.segment_tbl[i];
+
+		total_size += seg->size;
+	}
+
+	/*
+	 * Actual enclave size is expected to be larger than the loaded
+	 * test enclave since enclave size must be a power of 2 in bytes while
+	 * test_encl does not consume it all.
+	 */
+	EXPECT_LT(total_size + PAGE_SIZE, self->encl.encl_size);
+
+	/*
+	 * mmap() a page at end of existing enclave to be used for dynamic
+	 * EPC page.
+	 *
+	 * Kernel will allow new mapping using any permissions if it
+	 * falls into the enclave's address range but not backed
+	 * by existing enclave pages.
+	 */
+
+	addr = mmap((void *)self->encl.encl_base + total_size, PAGE_SIZE,
+		    PROT_READ | PROT_WRITE | PROT_EXEC, MAP_SHARED | MAP_FIXED,
+		    self->encl.fd, 0);
+	EXPECT_NE(addr, MAP_FAILED);
+
+	self->run.exception_vector = 0;
+	self->run.exception_error_code = 0;
+	self->run.exception_addr = 0;
+
+	/*
+	 * Run EACCEPT on new page to trigger the #PF->EAUG->EACCEPT(again
+	 * without a #PF). All should be transparent to userspace.
+	 */
+	eaccept_op.epc_addr = self->encl.encl_base + total_size;
+	eaccept_op.flags = SGX_SECINFO_R | SGX_SECINFO_W | SGX_SECINFO_REG | SGX_SECINFO_PENDING;
+	eaccept_op.ret = 0;
+	eaccept_op.header.type = ENCL_OP_EACCEPT;
+
+	EXPECT_EQ(ENCL_CALL(&eaccept_op, &self->run, true), 0);
+
+	if (self->run.exception_vector == 14 &&
+	    self->run.exception_error_code == 4 &&
+	    self->run.exception_addr == self->encl.encl_base + total_size) {
+		munmap(addr, PAGE_SIZE);
+		SKIP(return, "Kernel does not support adding pages to initialized enclave");
+	}
+
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.exception_vector, 0);
+	EXPECT_EQ(self->run.exception_error_code, 0);
+	EXPECT_EQ(self->run.exception_addr, 0);
+	EXPECT_EQ(eaccept_op.ret, 0);
+
+	/*
+	 * New page should be accessible from within enclave - attempt to
+	 * write to it.
+	 */
+	put_addr_op.value = MAGIC;
+	put_addr_op.addr = (unsigned long)addr;
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
+	 * Read memory from newly added page that was just written to,
+	 * confirming that data previously written (MAGIC) is present.
+	 */
+	get_addr_op.value = 0;
+	get_addr_op.addr = (unsigned long)addr;
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
+	munmap(addr, PAGE_SIZE);
+}
+
 TEST_HARNESS_MAIN
-- 
2.25.1

