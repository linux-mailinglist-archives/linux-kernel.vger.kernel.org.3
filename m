Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C38D56AAC8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236447AbiGGS1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236378AbiGGS1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:27:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE885A462;
        Thu,  7 Jul 2022 11:27:35 -0700 (PDT)
Date:   Thu, 07 Jul 2022 18:27:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657218454;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PtbyyYT+Ra7wQjTnjr0N6v3I/RFiE1PeNt3aA1FA7H4=;
        b=kk+TFGAfTgQhFuCJCK2XRi+4wVAVOkgcbH448ccbW8EDIaLYQ89ovGkgq2RIcvcokRCNKL
        k4ljw3RdUChj5eSoxZ7cl4E2n6IedO//rMGfJeoSdFkMgBzVVYoAgX5tQtuNVNUqRoq5ky
        44MW2wqBMe8ZWRMl5vjaohnaNrJqh7QMYDtGg4rX/NQPNXUJ54cNYuYSRYHU0hU9Y8WTBv
        KCwEzQ/qWueqiOwMdeDWAQSy1dqVB3C8W6f1RioBXXzx0ci2BZS8Nx0lWHBc34xyBIWf9Z
        Vpq6V95C7j+vQ80Rc3NDWsjo6xD/0i2sOPrQwifebyGz9Gb5goZhQk7g3Q/5Fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657218454;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PtbyyYT+Ra7wQjTnjr0N6v3I/RFiE1PeNt3aA1FA7H4=;
        b=JDgCuyiIdSmw2qkwkEYKokeUe38mWUEvFWOxF5Ddzj8ejeCAyQEUllERphiMoGHTWnbWb6
        8x8BMEwZsF2oBRBw==
From:   "tip-bot2 for Reinette Chatre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] selftests/sgx: Test complete changing of page type flow
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cd05b48b00338683a94dcaef9f478540fc3d6d5f9=2E16521?=
 =?utf-8?q?37848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3Cd05b48b00338683a94dcaef9f478540fc3d6d5f9=2E165213?=
 =?utf-8?q?7848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165721845290.15455.3282054489492740677.tip-bot2@tip-bot2>
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

Commit-ID:     33c5aac3bf32c3ef120ad6d2eb5c65ab64a5fec4
Gitweb:        https://git.kernel.org/tip/33c5aac3bf32c3ef120ad6d2eb5c65ab64a5fec4
Author:        Reinette Chatre <reinette.chatre@intel.com>
AuthorDate:    Tue, 10 May 2022 11:09:03 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 07 Jul 2022 10:13:04 -07:00

selftests/sgx: Test complete changing of page type flow

Support for changing an enclave page's type enables an initialized
enclave to be expanded with support for more threads by changing the
type of a regular enclave page to that of a Thread Control Structure
(TCS).  Additionally, being able to change a TCS or regular enclave
page's type to be trimmed (SGX_PAGE_TYPE_TRIM) initiates the removal
of the page from the enclave.

Test changing page type to TCS as well as page removal flows
in two phases: In the first phase support for a new thread is
dynamically added to an initialized enclave and in the second phase
the pages associated with the new thread are removed from the enclave.
As an additional sanity check after the second phase the page used as
a TCS page during the first phase is added back as a regular page and
ensured that it can be written to (which is not possible if it was a
TCS page).

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lkml.kernel.org/r/d05b48b00338683a94dcaef9f478540fc3d6d5f9.1652137848.git.reinette.chatre@intel.com
---
 tools/testing/selftests/sgx/load.c |  41 +++-
 tools/testing/selftests/sgx/main.c | 343 ++++++++++++++++++++++++++++-
 tools/testing/selftests/sgx/main.h |   1 +-
 3 files changed, 385 insertions(+)

diff --git a/tools/testing/selftests/sgx/load.c b/tools/testing/selftests/sgx/load.c
index 006b464..94bdeac 100644
--- a/tools/testing/selftests/sgx/load.c
+++ b/tools/testing/selftests/sgx/load.c
@@ -130,6 +130,47 @@ static bool encl_ioc_add_pages(struct encl *encl, struct encl_segment *seg)
 	return true;
 }
 
+/*
+ * Parse the enclave code's symbol table to locate and return address of
+ * the provided symbol
+ */
+uint64_t encl_get_entry(struct encl *encl, const char *symbol)
+{
+	Elf64_Shdr *sections;
+	Elf64_Sym *symtab;
+	Elf64_Ehdr *ehdr;
+	char *sym_names;
+	int num_sym;
+	int i;
+
+	ehdr = encl->bin;
+	sections = encl->bin + ehdr->e_shoff;
+
+	for (i = 0; i < ehdr->e_shnum; i++) {
+		if (sections[i].sh_type == SHT_SYMTAB) {
+			symtab = (Elf64_Sym *)((char *)encl->bin + sections[i].sh_offset);
+			num_sym = sections[i].sh_size / sections[i].sh_entsize;
+			break;
+		}
+	}
+
+	for (i = 0; i < ehdr->e_shnum; i++) {
+		if (sections[i].sh_type == SHT_STRTAB) {
+			sym_names = (char *)encl->bin + sections[i].sh_offset;
+			break;
+		}
+	}
+
+	for (i = 0; i < num_sym; i++) {
+		Elf64_Sym *sym = &symtab[i];
+
+		if (!strcmp(symbol, sym_names + sym->st_name))
+			return (uint64_t)sym->st_value;
+	}
+
+	return 0;
+}
+
 bool encl_load(const char *path, struct encl *encl, unsigned long heap_size)
 {
 	const char device_path[] = "/dev/sgx_enclave";
diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index 79c08e3..8bf4364 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -1090,4 +1090,347 @@ TEST_F(enclave, augment_via_eaccept)
 	munmap(addr, PAGE_SIZE);
 }
 
+/*
+ * SGX2 page type modification test in two phases:
+ * Phase 1:
+ * Create a new TCS, consisting out of three new pages (stack page with regular
+ * page type, SSA page with regular page type, and TCS page with TCS page
+ * type) in an initialized enclave and run a simple workload within it.
+ * Phase 2:
+ * Remove the three pages added in phase 1, add a new regular page at the
+ * same address that previously hosted the TCS page and verify that it can
+ * be modified.
+ */
+TEST_F(enclave, tcs_create)
+{
+	struct encl_op_init_tcs_page init_tcs_page_op;
+	struct sgx_enclave_remove_pages remove_ioc;
+	struct encl_op_get_from_addr get_addr_op;
+	struct sgx_enclave_modify_types modt_ioc;
+	struct encl_op_put_to_addr put_addr_op;
+	struct encl_op_get_from_buf get_buf_op;
+	struct encl_op_put_to_buf put_buf_op;
+	void *addr, *tcs, *stack_end, *ssa;
+	struct encl_op_eaccept eaccept_op;
+	size_t total_size = 0;
+	uint64_t val_64;
+	int errno_save;
+	int ret, i;
+
+	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl,
+				    _metadata));
+
+	memset(&self->run, 0, sizeof(self->run));
+	self->run.tcs = self->encl.encl_base;
+
+	/*
+	 * Hardware (SGX2) and kernel support is needed for this test. Start
+	 * with check that test has a chance of succeeding.
+	 */
+	memset(&modt_ioc, 0, sizeof(modt_ioc));
+	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_MODIFY_TYPES, &modt_ioc);
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
+	 * Add three regular pages via EAUG: one will be the TCS stack, one
+	 * will be the TCS SSA, and one will be the new TCS. The stack and
+	 * SSA will remain as regular pages, the TCS page will need its
+	 * type changed after populated with needed data.
+	 */
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
+	EXPECT_LT(total_size + 3 * PAGE_SIZE, self->encl.encl_size);
+
+	/*
+	 * mmap() three pages at end of existing enclave to be used for the
+	 * three new pages.
+	 */
+	addr = mmap((void *)self->encl.encl_base + total_size, 3 * PAGE_SIZE,
+		    PROT_READ | PROT_WRITE, MAP_SHARED | MAP_FIXED,
+		    self->encl.fd, 0);
+	EXPECT_NE(addr, MAP_FAILED);
+
+	self->run.exception_vector = 0;
+	self->run.exception_error_code = 0;
+	self->run.exception_addr = 0;
+
+	stack_end = (void *)self->encl.encl_base + total_size;
+	tcs = (void *)self->encl.encl_base + total_size + PAGE_SIZE;
+	ssa = (void *)self->encl.encl_base + total_size + 2 * PAGE_SIZE;
+
+	/*
+	 * Run EACCEPT on each new page to trigger the
+	 * EACCEPT->(#PF)->EAUG->EACCEPT(again without a #PF) flow.
+	 */
+
+	eaccept_op.epc_addr = (unsigned long)stack_end;
+	eaccept_op.flags = SGX_SECINFO_R | SGX_SECINFO_W | SGX_SECINFO_REG | SGX_SECINFO_PENDING;
+	eaccept_op.ret = 0;
+	eaccept_op.header.type = ENCL_OP_EACCEPT;
+
+	EXPECT_EQ(ENCL_CALL(&eaccept_op, &self->run, true), 0);
+
+	if (self->run.exception_vector == 14 &&
+	    self->run.exception_error_code == 4 &&
+	    self->run.exception_addr == (unsigned long)stack_end) {
+		munmap(addr, 3 * PAGE_SIZE);
+		SKIP(return, "Kernel does not support adding pages to initialized enclave");
+	}
+
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.exception_vector, 0);
+	EXPECT_EQ(self->run.exception_error_code, 0);
+	EXPECT_EQ(self->run.exception_addr, 0);
+	EXPECT_EQ(eaccept_op.ret, 0);
+
+	eaccept_op.epc_addr = (unsigned long)ssa;
+
+	EXPECT_EQ(ENCL_CALL(&eaccept_op, &self->run, true), 0);
+
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.exception_vector, 0);
+	EXPECT_EQ(self->run.exception_error_code, 0);
+	EXPECT_EQ(self->run.exception_addr, 0);
+	EXPECT_EQ(eaccept_op.ret, 0);
+
+	eaccept_op.epc_addr = (unsigned long)tcs;
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
+	 * Three new pages added to enclave. Now populate the TCS page with
+	 * needed data. This should be done from within enclave. Provide
+	 * the function that will do the actual data population with needed
+	 * data.
+	 */
+
+	/*
+	 * New TCS will use the "encl_dyn_entry" entrypoint that expects
+	 * stack to begin in page before TCS page.
+	 */
+	val_64 = encl_get_entry(&self->encl, "encl_dyn_entry");
+	EXPECT_NE(val_64, 0);
+
+	init_tcs_page_op.tcs_page = (unsigned long)tcs;
+	init_tcs_page_op.ssa = (unsigned long)total_size + 2 * PAGE_SIZE;
+	init_tcs_page_op.entry = val_64;
+	init_tcs_page_op.header.type = ENCL_OP_INIT_TCS_PAGE;
+
+	EXPECT_EQ(ENCL_CALL(&init_tcs_page_op, &self->run, true), 0);
+
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.exception_vector, 0);
+	EXPECT_EQ(self->run.exception_error_code, 0);
+	EXPECT_EQ(self->run.exception_addr, 0);
+
+	/* Change TCS page type to TCS. */
+	memset(&modt_ioc, 0, sizeof(modt_ioc));
+
+	modt_ioc.offset = total_size + PAGE_SIZE;
+	modt_ioc.length = PAGE_SIZE;
+	modt_ioc.page_type = SGX_PAGE_TYPE_TCS;
+
+	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_MODIFY_TYPES, &modt_ioc);
+	errno_save = ret == -1 ? errno : 0;
+
+	EXPECT_EQ(ret, 0);
+	EXPECT_EQ(errno_save, 0);
+	EXPECT_EQ(modt_ioc.result, 0);
+	EXPECT_EQ(modt_ioc.count, 4096);
+
+	/* EACCEPT new TCS page from enclave. */
+	eaccept_op.epc_addr = (unsigned long)tcs;
+	eaccept_op.flags = SGX_SECINFO_TCS | SGX_SECINFO_MODIFIED;
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
+	/* Run workload from new TCS. */
+	self->run.tcs = (unsigned long)tcs;
+
+	/*
+	 * Simple workload to write to data buffer and read value back.
+	 */
+	put_buf_op.header.type = ENCL_OP_PUT_TO_BUFFER;
+	put_buf_op.value = MAGIC;
+
+	EXPECT_EQ(ENCL_CALL(&put_buf_op, &self->run, true), 0);
+
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.exception_vector, 0);
+	EXPECT_EQ(self->run.exception_error_code, 0);
+	EXPECT_EQ(self->run.exception_addr, 0);
+
+	get_buf_op.header.type = ENCL_OP_GET_FROM_BUFFER;
+	get_buf_op.value = 0;
+
+	EXPECT_EQ(ENCL_CALL(&get_buf_op, &self->run, true), 0);
+
+	EXPECT_EQ(get_buf_op.value, MAGIC);
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.exception_vector, 0);
+	EXPECT_EQ(self->run.exception_error_code, 0);
+	EXPECT_EQ(self->run.exception_addr, 0);
+
+	/*
+	 * Phase 2 of test:
+	 * Remove pages associated with new TCS, create a regular page
+	 * where TCS page used to be and verify it can be used as a regular
+	 * page.
+	 */
+
+	/* Start page removal by requesting change of page type to PT_TRIM. */
+	memset(&modt_ioc, 0, sizeof(modt_ioc));
+
+	modt_ioc.offset = total_size;
+	modt_ioc.length = 3 * PAGE_SIZE;
+	modt_ioc.page_type = SGX_PAGE_TYPE_TRIM;
+
+	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_MODIFY_TYPES, &modt_ioc);
+	errno_save = ret == -1 ? errno : 0;
+
+	EXPECT_EQ(ret, 0);
+	EXPECT_EQ(errno_save, 0);
+	EXPECT_EQ(modt_ioc.result, 0);
+	EXPECT_EQ(modt_ioc.count, 3 * PAGE_SIZE);
+
+	/*
+	 * Enter enclave via TCS #1 and approve page removal by sending
+	 * EACCEPT for each of three removed pages.
+	 */
+	self->run.tcs = self->encl.encl_base;
+
+	eaccept_op.epc_addr = (unsigned long)stack_end;
+	eaccept_op.flags = SGX_SECINFO_TRIM | SGX_SECINFO_MODIFIED;
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
+	eaccept_op.epc_addr = (unsigned long)tcs;
+	eaccept_op.ret = 0;
+
+	EXPECT_EQ(ENCL_CALL(&eaccept_op, &self->run, true), 0);
+
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.exception_vector, 0);
+	EXPECT_EQ(self->run.exception_error_code, 0);
+	EXPECT_EQ(self->run.exception_addr, 0);
+	EXPECT_EQ(eaccept_op.ret, 0);
+
+	eaccept_op.epc_addr = (unsigned long)ssa;
+	eaccept_op.ret = 0;
+
+	EXPECT_EQ(ENCL_CALL(&eaccept_op, &self->run, true), 0);
+
+	EXPECT_EEXIT(&self->run);
+	EXPECT_EQ(self->run.exception_vector, 0);
+	EXPECT_EQ(self->run.exception_error_code, 0);
+	EXPECT_EQ(self->run.exception_addr, 0);
+	EXPECT_EQ(eaccept_op.ret, 0);
+
+	/* Send final ioctl() to complete page removal. */
+	memset(&remove_ioc, 0, sizeof(remove_ioc));
+
+	remove_ioc.offset = total_size;
+	remove_ioc.length = 3 * PAGE_SIZE;
+
+	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_REMOVE_PAGES, &remove_ioc);
+	errno_save = ret == -1 ? errno : 0;
+
+	EXPECT_EQ(ret, 0);
+	EXPECT_EQ(errno_save, 0);
+	EXPECT_EQ(remove_ioc.count, 3 * PAGE_SIZE);
+
+	/*
+	 * Enter enclave via TCS #1 and access location where TCS #3 was to
+	 * trigger dynamic add of regular page at that location.
+	 */
+	eaccept_op.epc_addr = (unsigned long)tcs;
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
+	/*
+	 * New page should be accessible from within enclave - write to it.
+	 */
+	put_addr_op.value = MAGIC;
+	put_addr_op.addr = (unsigned long)tcs;
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
+	get_addr_op.addr = (unsigned long)tcs;
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
+	munmap(addr, 3 * PAGE_SIZE);
+}
+
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/sgx/main.h b/tools/testing/selftests/sgx/main.h
index b45c52e..fc585be 100644
--- a/tools/testing/selftests/sgx/main.h
+++ b/tools/testing/selftests/sgx/main.h
@@ -38,6 +38,7 @@ void encl_delete(struct encl *ctx);
 bool encl_load(const char *path, struct encl *encl, unsigned long heap_size);
 bool encl_measure(struct encl *encl);
 bool encl_build(struct encl *encl);
+uint64_t encl_get_entry(struct encl *encl, const char *symbol);
 
 int sgx_enter_enclave(void *rdi, void *rsi, long rdx, u32 function, void *r8, void *r9,
 		      struct sgx_enclave_run *run);
