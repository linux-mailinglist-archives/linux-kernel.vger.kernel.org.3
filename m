Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AE84F1E96
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349111AbiDDWEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379274AbiDDQvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:51:55 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1646E338AA;
        Mon,  4 Apr 2022 09:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649090999; x=1680626999;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RLenEGRyRkGnPHbe+3ya/9vd5y8mNvmWzZIkUE5GP2Q=;
  b=f1FeONCAXxzEiJa96ibH89WK2aQsPFEN83B9PBTKwtG2AHqAtbQoMqSb
   hJYvEYM7FsVX+TmnLaSqQ/mkwQDegJZLkYjKVofPMlnaHFjZ1nzXtay3v
   A+1fnuR4vG1n3mIWe9eE1+vQYw9wkXd4zNyb3W4jXFIQw7QVtXflX/24E
   IGZ4fTCz19oLBmWeCwwVt+etTE93sUDf4vRX4ZcZyHZxE0YqDpJmxDGwn
   vPJ9h4RoFFzXNTNXLFvkFL7HdCfIiiKuS/+RZDkxruu9+4jEQxdmYZuMI
   mUbcXJJ5a+NKQE2dOnboNs3/TPVyE7EiWVy09xS6wd6IjnYn0eOYqqpU9
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="323734056"
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="323734056"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 09:49:51 -0700
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="523105214"
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
Subject: [PATCH V3 22/30] selftests/sgx: Add test for TCS page permission changes
Date:   Mon,  4 Apr 2022 09:49:30 -0700
Message-Id: <e1dd2c5f49043c43f71036d3abcb97fd30eec603.1648847675.git.reinette.chatre@intel.com>
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

Kernel should not allow permission changes on TCS pages. Add test to
confirm this behavior.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V2:
- Update to use new struct name struct sgx_enclave_restrict_perm -> struct
  sgx_enclave_restrict_permissions. (Jarkko)

Changes since V1:
- Adapt test to the kernel interface changes: the ioctl() name change
  and providing entire secinfo as parameter.
- Rewrite error path to reduce line lengths.

 tools/testing/selftests/sgx/main.c | 74 ++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index 0e0bd1c4d702..59573c1128c8 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -121,6 +121,24 @@ static Elf64_Sym *vdso_symtab_get(struct vdso_symtab *symtab, const char *name)
 	return NULL;
 }
 
+/*
+ * Return the offset in the enclave where the TCS segment can be found.
+ * The first RW segment loaded is the TCS.
+ */
+static off_t encl_get_tcs_offset(struct encl *encl)
+{
+	int i;
+
+	for (i = 0; i < encl->nr_segments; i++) {
+		struct encl_segment *seg = &encl->segment_tbl[i];
+
+		if (i == 0 && seg->prot == (PROT_READ | PROT_WRITE))
+			return seg->offset;
+	}
+
+	return -1;
+}
+
 /*
  * Return the offset in the enclave where the data segment can be found.
  * The first RW segment loaded is the TCS, skip that to get info on the
@@ -567,6 +585,62 @@ TEST_F(enclave, pte_permissions)
 	EXPECT_EQ(self->run.exception_addr, 0);
 }
 
+/*
+ * Modifying permissions of TCS page should not be possible.
+ */
+TEST_F(enclave, tcs_permissions)
+{
+	struct sgx_enclave_restrict_permissions ioc;
+	struct sgx_secinfo secinfo;
+	int ret, errno_save;
+
+	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
+
+	memset(&self->run, 0, sizeof(self->run));
+	self->run.tcs = self->encl.encl_base;
+
+	memset(&ioc, 0, sizeof(ioc));
+	memset(&secinfo, 0, sizeof(secinfo));
+
+	/*
+	 * Ensure kernel supports needed ioctl() and system supports needed
+	 * commands.
+	 */
+
+	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS, &ioc);
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
+	 * Attempt to make TCS page read-only. This is not allowed and
+	 * should be prevented by the kernel.
+	 */
+	secinfo.flags = PROT_READ;
+	ioc.offset = encl_get_tcs_offset(&self->encl);
+	ioc.length = PAGE_SIZE;
+	ioc.secinfo = (unsigned long)&secinfo;
+
+	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS, &ioc);
+	errno_save = ret == -1 ? errno : 0;
+
+	EXPECT_EQ(ret, -1);
+	EXPECT_EQ(errno_save, EINVAL);
+	EXPECT_EQ(ioc.result, 0);
+	EXPECT_EQ(ioc.count, 0);
+}
+
 /*
  * Enclave page permission test.
  *
-- 
2.25.1

