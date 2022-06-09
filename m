Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C345441A9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 04:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237245AbiFICxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 22:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235386AbiFICwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 22:52:46 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A261A0AE8
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 19:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654743165; x=1686279165;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ny11z9SDPfU2CZX/uJUyQoe3EreatqpxriX0H6ikW8E=;
  b=RaAEhOda1UrJMP8SmniSwPXIyiYedaKon98ICR1kGBxvX0qyjdN9qmAC
   rJkAKv3T+l0Plx9a3mHNlCyyyJ68bgZsSdtb5OJ97WfuXSQ1rsrr5AorC
   ZGGp+ai+0b089Mb4rFVmYG4u0cQG8TQMrdUdQn0hXydgKHuGps7/11OZe
   UkbhKhvSawcICQy+QrS2HjEp5RJytc+s5SzgUnOJso+YkW6T2fLiacXvR
   sTP9b/GZHU3H7z/SZtY8TUA7GLt5v0L7N1jr8PnFno6nKUC1QmX6HyQMs
   NU0Q+Hz+Kv2ZHmjlJqJFVszX+HD+oCUB7dcklwqiMSuNKcFR1PuasDg+v
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="363452732"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="363452732"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 19:52:45 -0700
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="683711311"
Received: from smsarifr-mobl.amr.corp.intel.com (HELO skuppusw-desk1.home) ([10.212.139.233])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 19:52:44 -0700
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
Subject: [PATCH v8 4/5] x86/mm: Add noalias variants of set_memory_*crypted() functions
Date:   Wed,  8 Jun 2022 19:52:19 -0700
Message-Id: <20220609025220.2615197-5-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set_memory_*crypted() functions are used to modify the "shared" page
attribute of the given memory. Using these APIs will modify the page
attributes of the aliased mappings (which also includes the direct
mapping).

But such aliased mappings modification is not desirable in use cases
like TDX guest, where the requirement is to create the shared mapping
without touching the direct map. It is used when allocating VMM shared
buffers using alloc_pages()/vmap()/set_memory_*crypted() API
combinations.

So to support such use cases, add support for noalias variants of
set_memory_*crypted() functions.

Acked-by: Wander Lairson Costa <wander@redhat.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/include/asm/set_memory.h |  2 ++
 arch/x86/mm/pat/set_memory.c      | 26 ++++++++++++++++++++------
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index b45c4d27fd46..a79d59692494 100644
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
index 1abd5438f126..ad6c8ece737d 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2021,7 +2021,8 @@ int set_memory_global(unsigned long addr, int numpages)
  * __set_memory_enc_pgtable() is used for the hypervisors that get
  * informed about "encryption" status via page tables.
  */
-static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
+static int __set_memory_enc_pgtable(unsigned long addr, int numpages,
+		bool enc, int checkalias)
 {
 	pgprot_t empty = __pgprot(0);
 	struct cpa_data cpa;
@@ -2049,7 +2050,7 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 	/* Notify hypervisor that we are about to set/clr encryption attribute. */
 	x86_platform.guest.enc_status_change_prepare(addr, numpages, enc);
 
-	ret = __change_page_attr_set_clr(&cpa, 1);
+	ret = __change_page_attr_set_clr(&cpa, checkalias);
 
 	/*
 	 * After changing the encryption attribute, we need to flush TLBs again
@@ -2069,29 +2070,42 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
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

