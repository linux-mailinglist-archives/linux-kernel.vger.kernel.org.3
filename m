Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584344ACDC1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344249AbiBHBJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344187AbiBHAqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 19:46:14 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA721C06109E;
        Mon,  7 Feb 2022 16:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644281174; x=1675817174;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2dg6loMjsFSUg2XAXybpedRO1g+2h8QfirGVJBzr9kU=;
  b=XQ1wiq2QV/9EodOrPXq8Hpru50sAC+QmbJqMGut+I817LwSdbt4YP/YI
   x53EusNKgOPdirv6wQ/fNbCl1MtB18upazt3Go78mssEiQ2TBxewcftme
   b2zRnCdnxvtQpym8OqMcDCECH/hvM2AjrISsCCwdnrzWS1NPfq6WSAAAy
   t1ERhvx+TXGU3VR45Ti/jC9vIV5N2iU/R2sp7t85Z5fRHy7ZVctr3lS+V
   Bq543q0RJN8is7VmV1AeAX15jgzhnKotEvzY/8C5LCDEuDOxVb+z9NQdj
   Eyw17jVAbuR5ZGoqyN2qpAB2oqIbxX3gWv9JOhUIZBwFq1xen80B1ZzUb
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="232407960"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="232407960"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 16:46:09 -0800
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="499389510"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 16:46:09 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 14/32] x86/sgx: Keep record of SGX page type
Date:   Mon,  7 Feb 2022 16:45:36 -0800
Message-Id: <772dfb5a11a41fe5636d4b9320ccd818e76a7033.1644274683.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1644274683.git.reinette.chatre@intel.com>
References: <cover.1644274683.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGX2 functions are not allowed on all page types. For example,
ENCLS[EMODPR] is only allowed on regular SGX enclave pages and
ENCLS[EMODPT] is only allowed on TCS and regular pages. If these
functions are attempted on another type of page the hardware would
trigger a fault.

Keep a record of the SGX page type so that there is more
certainty whether an SGX2 instruction can succeed and faults
can be treated as real failures.

The page type is a property of struct sgx_encl_page
and thus does not cover the VA page type. VA pages are maintained
in separate structures and their type can be determined in
a different way. The SGX2 instructions needing the page type do not
operate on VA pages and this is thus not a scenario needing to
be covered at this time.

With the protection bits consuming 16 bits of the unsigned long
there is room available in the bitfield to include the page type
information without increasing the space consumed by the struct.

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V1:
- Add Acked-by from Jarkko.

 arch/x86/include/asm/sgx.h      | 3 +++
 arch/x86/kernel/cpu/sgx/encl.h  | 1 +
 arch/x86/kernel/cpu/sgx/ioctl.c | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
index d67810b50a81..eae20fa52b93 100644
--- a/arch/x86/include/asm/sgx.h
+++ b/arch/x86/include/asm/sgx.h
@@ -239,6 +239,9 @@ struct sgx_pageinfo {
  * %SGX_PAGE_TYPE_REG:	a regular page
  * %SGX_PAGE_TYPE_VA:	a VA page
  * %SGX_PAGE_TYPE_TRIM:	a page in trimmed state
+ *
+ * Make sure when making changes to this enum that its values can still fit
+ * in the bitfield within &struct sgx_encl_page
  */
 enum sgx_page_type {
 	SGX_PAGE_TYPE_SECS,
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index 82e21088e68b..cb9f16d457ac 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -29,6 +29,7 @@ struct sgx_encl_page {
 	unsigned long desc;
 	unsigned long vm_max_prot_bits:8;
 	unsigned long vm_run_prot_bits:8;
+	enum sgx_page_type type:16;
 	struct sgx_epc_page *epc_page;
 	struct sgx_encl *encl;
 	struct sgx_va_page *va_page;
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 6e7cc441156b..b8336d5d9029 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -107,6 +107,7 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
 		set_bit(SGX_ENCL_DEBUG, &encl->flags);
 
 	encl->secs.encl = encl;
+	encl->secs.type = SGX_PAGE_TYPE_SECS;
 	encl->base = secs->base;
 	encl->size = secs->size;
 	encl->attributes = secs->attributes;
@@ -350,6 +351,7 @@ static int sgx_encl_add_page(struct sgx_encl *encl, unsigned long src,
 	 */
 	encl_page->encl = encl;
 	encl_page->epc_page = epc_page;
+	encl_page->type = (secinfo->flags & SGX_SECINFO_PAGE_TYPE_MASK) >> 8;
 	encl->secs_child_cnt++;
 
 	if (flags & SGX_PAGE_MEASURE) {
-- 
2.25.1

