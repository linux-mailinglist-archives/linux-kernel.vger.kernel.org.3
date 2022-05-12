Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1505257B3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 00:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359158AbiELWU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 18:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359116AbiELWUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 18:20:10 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A793280E06
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 15:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652394010; x=1683930010;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o1V4B1vYijYcC+JeCBsMbjrh6n4qeE+NBMgzu3VHSZo=;
  b=W+t1JyzCZS1rzFm8p3myi4dwR9XlRKc70+HbOeGGhoZ56tpJvi/fD8fU
   7Ib7roafxtMZ9SB7drnbHhbgPDtTkx3LVUeauD3LuwHBjnuc4QH8W/1j/
   XV72Yf6QIFly6j0m4+vtc548D5/7ClL1ibq6i0Yb5iDJ/s51oYXUmyiFg
   Pnpm5Ws29vhnafbe4PBFopvwdEz65HOhm/rVKcLLbctUKEsMn9c1ogqQI
   fww8ghRffsW4nkWWIFSuHpSKANek/ioI6IHqjQpNG6KAM5BtZ9F1YZ/pc
   7QWroU/fV2lnxUkAFZLgEqg5ykH6SN7LE8MnFbqfP0mRAj/7aC3dFrIhY
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="257695001"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="257695001"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 15:20:08 -0700
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="594904494"
Received: from skothapa-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.209.67.107])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 15:20:08 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/5] x86/mm: Add noalias variants of set_memory_*crypted() functions
Date:   Thu, 12 May 2022 15:19:51 -0700
Message-Id: <20220512221952.3647598-5-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220512221952.3647598-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20220512221952.3647598-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In TDX guest, when creating a shared buffer for the VMM access, to
avoid breaking the direct mapping, vmap() can be used to remap the
memory and use it to create the shared mapping.

Currently, both set_memory_encrypted() and set_memory_decrypted()
functions modify the page attributes of aliased mappings (which also
includes the direct mapping). So handle the use case like mentioned
above, create noalias variants of set_memory_*crypted() functions.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/include/asm/set_memory.h |  2 ++
 arch/x86/mm/pat/set_memory.c      | 26 ++++++++++++++++++++------
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index 78ca53512486..0e5fc2b818be 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -46,7 +46,9 @@ int set_memory_wb(unsigned long addr, int numpages);
 int set_memory_np(unsigned long addr, int numpages);
 int set_memory_4k(unsigned long addr, int numpages);
 int set_memory_encrypted(unsigned long addr, int numpages);
+int set_memory_encrypted_noalias(unsigned long addr, int numpages);
 int set_memory_decrypted(unsigned long addr, int numpages);
+int set_memory_decrypted_noalias(unsigned long addr, int numpages);
 int set_memory_np_noalias(unsigned long addr, int numpages);
 int set_memory_nonglobal(unsigned long addr, int numpages);
 int set_memory_global(unsigned long addr, int numpages);
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index abf5ed76e4b7..ef54178855a1 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1987,7 +1987,8 @@ int set_memory_global(unsigned long addr, int numpages)
  * __set_memory_enc_pgtable() is used for the hypervisors that get
  * informed about "encryption" status via page tables.
  */
-static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
+static int __set_memory_enc_pgtable(unsigned long addr, int numpages,
+		bool enc, int checkalias)
 {
 	pgprot_t empty = __pgprot(0);
 	struct cpa_data cpa;
@@ -2015,7 +2016,7 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 	/* Notify hypervisor that we are about to set/clr encryption attribute. */
 	x86_platform.guest.enc_status_change_prepare(addr, numpages, enc);
 
-	ret = __change_page_attr_set_clr(&cpa, 1);
+	ret = __change_page_attr_set_clr(&cpa, checkalias);
 
 	/*
 	 * After changing the encryption attribute, we need to flush TLBs again
@@ -2035,29 +2036,42 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 	return ret;
 }
 
-static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
+static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc,
+		int checkalias)
 {
 	if (hv_is_isolation_supported())
 		return hv_set_mem_host_visibility(addr, numpages, !enc);
 
 	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
-		return __set_memory_enc_pgtable(addr, numpages, enc);
+		return __set_memory_enc_pgtable(addr, numpages, enc, checkalias);
 
 	return 0;
 }
 
 int set_memory_encrypted(unsigned long addr, int numpages)
 {
-	return __set_memory_enc_dec(addr, numpages, true);
+	return __set_memory_enc_dec(addr, numpages, true, 1);
 }
 EXPORT_SYMBOL_GPL(set_memory_encrypted);
 
 int set_memory_decrypted(unsigned long addr, int numpages)
 {
-	return __set_memory_enc_dec(addr, numpages, false);
+	return __set_memory_enc_dec(addr, numpages, false, 1);
 }
 EXPORT_SYMBOL_GPL(set_memory_decrypted);
 
+int set_memory_encrypted_noalias(unsigned long addr, int numpages)
+{
+	return __set_memory_enc_dec(addr, numpages, true, 0);
+}
+EXPORT_SYMBOL_GPL(set_memory_encrypted_noalias);
+
+int set_memory_decrypted_noalias(unsigned long addr, int numpages)
+{
+	return __set_memory_enc_dec(addr, numpages, false, 0);
+}
+EXPORT_SYMBOL_GPL(set_memory_decrypted_noalias);
+
 int set_pages_uc(struct page *page, int numpages)
 {
 	unsigned long addr = (unsigned long)page_address(page);
-- 
2.25.1

