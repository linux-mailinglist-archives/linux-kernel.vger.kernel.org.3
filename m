Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EC24F1E03
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355334AbiDDVvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379265AbiDDQvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:51:51 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E4031351;
        Mon,  4 Apr 2022 09:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649090994; x=1680626994;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xH8w381o5s9LdRaAo69RH2L/TkEmuKrGS0d+mIcmEIk=;
  b=SYGHptqt6rX4BfHNGQVa/7hZA0VwvMCJNG23xUPOOTimn3gRvSYvLCVY
   ayiVWkpRhbp9NZpwyW+aBO1LghUybsMAA6xCLA9If/p/+E4wQukHuvcL6
   cA7fU0fv5d+fQ5og8T+SLClC7UrRNvC7lSb7PC/VZNgY5pQQE2Ti5cukm
   +98OPZLNqJqbyeyBjNUbUlx36wcOWzrX8Is+3vB4FLt9MfdHq0SngGB1S
   bD8WAraj9zQSTFOC8MF3erpKE2GuIrn4FtuDk8QxEj6Du1wgNj1hlKEfw
   vUCLTz+mrNMZjdK2OxzDiqEgVbQ0aExaKfykVbNk3xqt8cK+Jb9oH3Rbv
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="323734045"
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="323734045"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 09:49:51 -0700
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="523105177"
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
Subject: [PATCH V3 10/30] x86/sgx: Create utility to validate user provided offset and length
Date:   Mon,  4 Apr 2022 09:49:18 -0700
Message-Id: <7ebe0aa8cc6ce11eaf032c3796823bcc08df27fe.1648847675.git.reinette.chatre@intel.com>
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

User provided offset and length is validated when parsing the parameters
of the SGX_IOC_ENCLAVE_ADD_PAGES ioctl(). Extract this validation
into a utility that can be used by the SGX2 ioctl()s that will
also provide these values.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
No changes since V2

Changes since V1:
- New patch

 arch/x86/kernel/cpu/sgx/ioctl.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 83df20e3e633..f487549bccba 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -372,6 +372,26 @@ static int sgx_encl_add_page(struct sgx_encl *encl, unsigned long src,
 	return ret;
 }
 
+/*
+ * Ensure user provided offset and length values are valid for
+ * an enclave.
+ */
+static int sgx_validate_offset_length(struct sgx_encl *encl,
+				      unsigned long offset,
+				      unsigned long length)
+{
+	if (!IS_ALIGNED(offset, PAGE_SIZE))
+		return -EINVAL;
+
+	if (!length || length & (PAGE_SIZE - 1))
+		return -EINVAL;
+
+	if (offset + length - PAGE_SIZE >= encl->size)
+		return -EINVAL;
+
+	return 0;
+}
+
 /**
  * sgx_ioc_enclave_add_pages() - The handler for %SGX_IOC_ENCLAVE_ADD_PAGES
  * @encl:       an enclave pointer
@@ -425,14 +445,10 @@ static long sgx_ioc_enclave_add_pages(struct sgx_encl *encl, void __user *arg)
 	if (copy_from_user(&add_arg, arg, sizeof(add_arg)))
 		return -EFAULT;
 
-	if (!IS_ALIGNED(add_arg.offset, PAGE_SIZE) ||
-	    !IS_ALIGNED(add_arg.src, PAGE_SIZE))
-		return -EINVAL;
-
-	if (!add_arg.length || add_arg.length & (PAGE_SIZE - 1))
+	if (!IS_ALIGNED(add_arg.src, PAGE_SIZE))
 		return -EINVAL;
 
-	if (add_arg.offset + add_arg.length - PAGE_SIZE >= encl->size)
+	if (sgx_validate_offset_length(encl, add_arg.offset, add_arg.length))
 		return -EINVAL;
 
 	if (copy_from_user(&secinfo, (void __user *)add_arg.secinfo,
-- 
2.25.1

