Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05D14CD14C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 10:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbiCDJiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239377AbiCDJiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:38:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484681AC296;
        Fri,  4 Mar 2022 01:36:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C19B06197F;
        Fri,  4 Mar 2022 09:36:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA714C340E9;
        Fri,  4 Mar 2022 09:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646386609;
        bh=GIXXvHUCjsNwfokUE4YhJH42Rc0GvtvU/kUuFqoC1JU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ta7ivz106BJGA+gQ8JvbWucWxO0Qp7UOccO63ppI72sxKNAeFj05Yhi0o6g/PmClN
         3EX/V9WLW45ZNbj7uT7bKKEOITH4VtOHkoquh/vHHs8azxEVBfYXilv9Fye6OGFUBA
         Jq0RFuIhZhosrRzRHSSxbyVZAuZcr/yYbWq7Z7PHgIrvSVyicRajbAV2nWp9KAViG6
         3Sy9M9NCK1cty+pDtVAsVgFDiWvYKAQBdMdqB/TXUQE8n06psZhjsis3MIWJbPMFBb
         pFlHKsyY09UOaJ50wS8M9HBgpfFR7FM7TqLpmZUeRltSn3GeJPgtPMW1K3JNSfcNTs
         txD/A54yikRrQ==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [RFC PATCH v2.1 13/30] x86/sgx: Keep record of SGX page type
Date:   Fri,  4 Mar 2022 11:35:07 +0200
Message-Id: <20220304093524.397485-13-jarkko@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304093524.397485-1-jarkko@kernel.org>
References: <20220304093524.397485-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Reinette Chatre <reinette.chatre@intel.com>

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
 arch/x86/include/asm/sgx.h      | 3 +++
 arch/x86/kernel/cpu/sgx/encl.h  | 3 ++-
 arch/x86/kernel/cpu/sgx/ioctl.c | 2 ++
 3 files changed, 7 insertions(+), 1 deletion(-)

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
index e760991762e4..94ccea8fbbf2 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -27,7 +27,8 @@
 
 struct sgx_encl_page {
 	unsigned long desc;
-	unsigned long vm_max_prot_bits;
+	u32 vm_max_prot_bits;
+	enum sgx_page_type type:32;
 	struct sgx_epc_page *epc_page;
 	struct sgx_encl *encl;
 	struct sgx_va_page *va_page;
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index f487549bccba..0c211af8e948 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -107,6 +107,7 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
 		set_bit(SGX_ENCL_DEBUG, &encl->flags);
 
 	encl->secs.encl = encl;
+	encl->secs.type = SGX_PAGE_TYPE_SECS;
 	encl->base = secs->base;
 	encl->size = secs->size;
 	encl->attributes = secs->attributes;
@@ -344,6 +345,7 @@ static int sgx_encl_add_page(struct sgx_encl *encl, unsigned long src,
 	 */
 	encl_page->encl = encl;
 	encl_page->epc_page = epc_page;
+	encl_page->type = (secinfo->flags & SGX_SECINFO_PAGE_TYPE_MASK) >> 8;
 	encl->secs_child_cnt++;
 
 	if (flags & SGX_PAGE_MEASURE) {
-- 
2.35.1

