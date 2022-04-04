Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FEC4F1D14
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382459AbiDDVaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379267AbiDDQvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:51:51 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4B62DAA1;
        Mon,  4 Apr 2022 09:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649090994; x=1680626994;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4ED03ebku1o8iobIzAgP7riBruf7KThgs/0tqOMzplc=;
  b=Z+7tP+IRbi7bDrVj+FB2hdro/eKa13RRR2tVdT20HXoAM4dAyRG0Tp2A
   QKmIu/MXUO6fjOobRj55oyFfVAwa/dZvOdnV3YXQkLyHeThxTWWi4SSMs
   Wv0a1NT9x25+5ag2U6mySvTc23Wfc20Ms41D5Z8O2vI6MSGeIvneZ/afK
   +v98YwhX1H9KUL/vL67I+9odNz2SmvV9FCkUJYG/qL4XuxnV81ZPvEAC8
   Z6a9b/okvYTODxOFiz4jmJWyltT6rilgAeiKGVSwz27WOsFeEZ/zZTEDg
   OYfb2pkucor8UCjXlHnBK7IFOAaoK4Gt4zavbkJU7mwcfhKxPEiCrwBLK
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="259390792"
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="259390792"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 09:49:51 -0700
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="523105240"
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
Subject: [PATCH V3 30/30] selftests/sgx: Page removal stress test
Date:   Mon,  4 Apr 2022 09:49:38 -0700
Message-Id: <5df85109e6b88787ddf31ac42762c9d1dcc0c3e1.1648847675.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1648847675.git.reinette.chatre@intel.com>
References: <cover.1648847675.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create enclave with additional heap that consumes all physical SGX
memory and then remove it.

Depending on the available SGX memory this test could take a
significant time to run (several minutes) as it (1) creates the
enclave, (2) changes the type of every page to be trimmed,
(3) enters the enclave once per page to run EACCEPT, before
(4) the pages are finally removed.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V2:
- Rename struct sgx_enclave_modt -> struct sgx_enclave_modify_type

Changes since V1:
- Exit test completely on first failure of EACCEPT of a removed page. Since
  this is an oversubscribed test the number of pages on which this is
  attempted can be significant and in case of failure the per-page
  error logging would overwhelm the system.
- Update test to call renamed ioctl() (SGX_IOC_PAGE_MODT ->
  SGX_IOC_ENCLAVE_MODIFY_TYPE) and provide secinfo as parameter (Jarkko).
- Fixup definitions to be reverse xmas tree.
- Update test to reflect page removal ioctl() and struct name change:
  SGX_IOC_PAGE_REMOVE->SGX_IOC_ENCLAVE_REMOVE_PAGES,
  struct sgx_page_remove -> struct sgx_enclave_remove_pages (Jarkko).
- Ensure test is skipped when SGX2 not supported by kernel.
- Cleanup comments.

 tools/testing/selftests/sgx/main.c | 122 +++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index 82cc2283be03..535f6cd72eb1 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -378,7 +378,129 @@ TEST_F(enclave, unclobbered_vdso_oversubscribed)
 	EXPECT_EQ(get_op.value, MAGIC);
 	EXPECT_EEXIT(&self->run);
 	EXPECT_EQ(self->run.user_data, 0);
+}
+
+TEST_F_TIMEOUT(enclave, unclobbered_vdso_oversubscribed_remove, 900)
+{
+	struct sgx_enclave_remove_pages remove_ioc;
+	struct sgx_enclave_modify_type modt_ioc;
+	struct encl_op_get_from_buf get_op;
+	struct encl_op_eaccept eaccept_op;
+	struct encl_op_put_to_buf put_op;
+	struct sgx_secinfo secinfo;
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
+	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_MODIFY_TYPE, &modt_ioc);
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
+
+	/* Trim entire heap. */
+	memset(&modt_ioc, 0, sizeof(modt_ioc));
+	memset(&secinfo, 0, sizeof(secinfo));
+
+	secinfo.flags = SGX_PAGE_TYPE_TRIM << 8;
+	modt_ioc.offset = heap->offset;
+	modt_ioc.length = heap->size;
+	modt_ioc.secinfo = (unsigned long)&secinfo;
+
+	TH_LOG("Changing type of %zd bytes to trimmed may take a while ...",
+	       heap->size);
+	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_MODIFY_TYPE, &modt_ioc);
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
-- 
2.25.1

