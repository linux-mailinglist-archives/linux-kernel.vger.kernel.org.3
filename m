Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2647256AA8C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236350AbiGGS1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236280AbiGGS1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:27:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFAC5A2DF;
        Thu,  7 Jul 2022 11:27:32 -0700 (PDT)
Date:   Thu, 07 Jul 2022 18:27:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657218450;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KRrklH186pvtyUQdvvgjeSVG8UKAFuWxGa6LZ9XEJ/Y=;
        b=MeQ1V5LDh48UH4SX2kTQzvzWivI+zuXx1RJg8rPYxWa1/kjCJGho7/tIQcXtKRItec8b6N
        m3RSALgXyuQwNCeWyBHceNC7RIH+8qutRHZier96RxJR+kLLKP1730rp4in6Unex1ZgJcP
        FWI337C6rqaqQJgQTt/8CxBfGh/blizGeeLrM6AGbzb1xlMDZzHDtST9ApJTmM1ot80i3W
        0Xi7CwNYF1reWrNjDUGpJhvBHISdTAfgACLLOrAI/UdmN7XX2Ixy0w4ny1I6MDF6GBsMs4
        OZcGZzxvTM8G+h6ZpyUu1PvTKDm5ztAUw3WqF303s8gR3TjXWKr6hXaaCz33yQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657218450;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KRrklH186pvtyUQdvvgjeSVG8UKAFuWxGa6LZ9XEJ/Y=;
        b=w6nXhHM7dzpPeAJX/DdkFkhMu+eW/j3ML5DyqxM8G9ZaNEwplSjA3ikFKEwDJYzPkWxYLp
        8Xj2jvv0HVWov6DA==
From:   "tip-bot2 for Reinette Chatre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] selftests/sgx: Page removal stress test
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Ce7c6aa2ab30cb1c41e52b776958409c06970d168=2E16521?=
 =?utf-8?q?37848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3Ce7c6aa2ab30cb1c41e52b776958409c06970d168=2E165213?=
 =?utf-8?q?7848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165721844896.15455.10297364114051095446.tip-bot2@tip-bot2>
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

Commit-ID:     6507cce561b43b071999502103804e3dc1478e60
Gitweb:        https://git.kernel.org/tip/6507cce561b43b071999502103804e3dc1478e60
Author:        Reinette Chatre <reinette.chatre@intel.com>
AuthorDate:    Tue, 10 May 2022 11:09:07 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 07 Jul 2022 10:13:05 -07:00

selftests/sgx: Page removal stress test

Create enclave with additional heap that consumes all physical SGX
memory and then remove it.

Depending on the available SGX memory this test could take a
significant time to run (several minutes) as it (1) creates the
enclave, (2) changes the type of every page to be trimmed,
(3) enters the enclave once per page to run EACCEPT, before
(4) the pages are finally removed.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lkml.kernel.org/r/e7c6aa2ab30cb1c41e52b776958409c06970d168.1652137848.git.reinette.chatre@intel.com
---
 tools/testing/selftests/sgx/main.c | 120 ++++++++++++++++++++++++++++-
 1 file changed, 120 insertions(+)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index ba16671..9820b38 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -378,7 +378,127 @@ TEST_F(enclave, unclobbered_vdso_oversubscribed)
 	EXPECT_EQ(get_op.value, MAGIC);
 	EXPECT_EEXIT(&self->run);
 	EXPECT_EQ(self->run.user_data, 0);
+}
+
+TEST_F_TIMEOUT(enclave, unclobbered_vdso_oversubscribed_remove, 900)
+{
+	struct sgx_enclave_remove_pages remove_ioc;
+	struct sgx_enclave_modify_types modt_ioc;
+	struct encl_op_get_from_buf get_op;
+	struct encl_op_eaccept eaccept_op;
+	struct encl_op_put_to_buf put_op;
+	struct encl_segment *heap;
+	unsigned long total_mem;
+	int ret, errno_save;
+	unsigned long addr;
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
+	/* SGX2 is supported by kernel and hardware, test can proceed. */
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
 
+	/* Trim entire heap. */
+	memset(&modt_ioc, 0, sizeof(modt_ioc));
+
+	modt_ioc.offset = heap->offset;
+	modt_ioc.length = heap->size;
+	modt_ioc.page_type = SGX_PAGE_TYPE_TRIM;
+
+	TH_LOG("Changing type of %zd bytes to trimmed may take a while ...",
+	       heap->size);
+	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_MODIFY_TYPES, &modt_ioc);
+	errno_save = ret == -1 ? errno : 0;
+
+	EXPECT_EQ(ret, 0);
+	EXPECT_EQ(errno_save, 0);
+	EXPECT_EQ(modt_ioc.result, 0);
+	EXPECT_EQ(modt_ioc.count, heap->size);
+
+	/* EACCEPT all removed pages. */
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
+		EXPECT_EQ(self->run.exception_vector, 0);
+		EXPECT_EQ(self->run.exception_error_code, 0);
+		EXPECT_EQ(self->run.exception_addr, 0);
+		ASSERT_EQ(eaccept_op.ret, 0);
+		ASSERT_EQ(self->run.function, EEXIT);
+	}
+
+	/* Complete page removal. */
+	memset(&remove_ioc, 0, sizeof(remove_ioc));
+
+	remove_ioc.offset = heap->offset;
+	remove_ioc.length = heap->size;
+
+	TH_LOG("Removing %zd bytes from enclave may take a while ...",
+	       heap->size);
+	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_REMOVE_PAGES, &remove_ioc);
+	errno_save = ret == -1 ? errno : 0;
+
+	EXPECT_EQ(ret, 0);
+	EXPECT_EQ(errno_save, 0);
+	EXPECT_EQ(remove_ioc.count, heap->size);
 }
 
 TEST_F(enclave, clobbered_vdso)
