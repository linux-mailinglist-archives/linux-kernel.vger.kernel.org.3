Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D0E56AACB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236464AbiGGS2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236390AbiGGS1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:27:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CCA5A475;
        Thu,  7 Jul 2022 11:27:38 -0700 (PDT)
Date:   Thu, 07 Jul 2022 18:27:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657218456;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9KHdrD/iu2aD0aSu7SBTS7VBOYEKqQAP/6+5rqugcpY=;
        b=y26emh1LxYt0W8xPKuwY9Wd1V4uLHAbU+AwGAZVyX3krS1rpM/Xk8cO0oHGO0jTtOFgwZS
        mONxMzzmqD5dGHlCTwbQNBhYTy5lf+6rUDTmh1cIGAGOrpycp4neNUPMGy5fFP5Oq9LLE3
        KSSTdd8IlKTKIUEfxPVDp2IqZFmGc2ZKSHJkcTIQW2jJEQWhU2zsmsSctG2h6JQbybTUEW
        XRiWbQz2bnBfCWE98nHNs4SWfP0ut9dtOKfeVCcqVQ1LgIcKLihfy7fX8hBre0ur/E/74w
        81pZsLInzwomPdFgGcOFUVHtaG7pEbFmR70JW7IJ3c0mB+oK06pdO1nnCRiDCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657218456;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9KHdrD/iu2aD0aSu7SBTS7VBOYEKqQAP/6+5rqugcpY=;
        b=ZHTLsF/yD8JxB1vaj3OXoXpkzncH5JfLghIelqnl/2KChhivtJYA6UogsdZLDAnV/euAYN
        1kTyQEOOVH5jUrDg==
From:   "tip-bot2 for Reinette Chatre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] selftests/sgx: Test two different SGX2 EAUG flows
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C0c321e0e32790ac1de742ce5017a331e6d902ac1=2E16521?=
 =?utf-8?q?37848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3C0c321e0e32790ac1de742ce5017a331e6d902ac1=2E165213?=
 =?utf-8?q?7848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165721845573.15455.17518490793990601105.tip-bot2@tip-bot2>
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

Commit-ID:     67f1f70a23d117628d5cfc78bcdf8eb9d2d04874
Gitweb:        https://git.kernel.org/tip/67f1f70a23d117628d5cfc78bcdf8eb9d2d04874
Author:        Reinette Chatre <reinette.chatre@intel.com>
AuthorDate:    Tue, 10 May 2022 11:09:00 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 07 Jul 2022 10:13:04 -07:00

selftests/sgx: Test two different SGX2 EAUG flows

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
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lkml.kernel.org/r/0c321e0e32790ac1de742ce5017a331e6d902ac1.1652137848.git.reinette.chatre@intel.com
---
 tools/testing/selftests/sgx/main.c | 250 ++++++++++++++++++++++++++++-
 1 file changed, 250 insertions(+)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index 016ae3e..79c08e3 100644
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
@@ -840,4 +849,245 @@ TEST_F(enclave, epcm_permissions)
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
