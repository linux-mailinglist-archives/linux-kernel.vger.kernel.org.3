Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666A74D570D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 02:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345247AbiCKA7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 19:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344877AbiCKA7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 19:59:44 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181C712D09E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 16:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646960322; x=1678496322;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9ygcwAbQ0NfIqlDdywkiojUz0KGKAHWj5E1qd9qQFb4=;
  b=YvpOoRUaQd+xITTeGZ5DoGlkBCKTaEOtXccDm6nK2eUykLCki+xZwb+z
   wxBqnIJqXB5sxZCYNBEf0JKcwsNS1n83vYsA/k7ZBcYFeU2ZcUYY5tqjw
   qDCnMXfiNjl6XQEq7jWpjZWaF8AUyoPR7sBvbaTjL+8nz/zqQM1wjOev1
   NSa7UL+trZPxn1B5GRSGLKhpLl5aiCYKB9V1WxSvYuW6OwsQY2QGAzQZl
   5O7KuZwwMkvwxL9hLOIBNm8uW8AcvwxmgKjSDs+w0/DePQ5/vOMzM1yWe
   XUOJ/tFSIxyBMeyTRSPnFqY1py12JIh5PzsXKbQQ7xsjbjND/uY5MJvOo
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="255405867"
X-IronPort-AV: E=Sophos;i="5.90,172,1643702400"; 
   d="scan'208";a="255405867"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 16:57:59 -0800
X-IronPort-AV: E=Sophos;i="5.90,172,1643702400"; 
   d="scan'208";a="554989246"
Received: from gdavids1-mobl.amr.corp.intel.com (HELO localhost) ([10.212.65.108])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 16:57:49 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] x86/pkeys: Standardize on u8 for pkey type
Date:   Thu, 10 Mar 2022 16:57:42 -0800
Message-Id: <20220311005742.1060992-6-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220311005742.1060992-1-ira.weiny@intel.com>
References: <20220311005742.1060992-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The number of pkeys supported on x86 and powerpc are much smaller than a
u16 value can hold.  It is desirable to standardize on the type for
pkeys.  powerpc currently supports the most pkeys at 32.  u8 is plenty
large for that.

Standardize on the pkey types by changing u16 to u8.

To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 arch/x86/include/asm/pgtable.h | 4 ++--
 arch/x86/include/asm/pkru.h    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 8a9432fb3802..cb89f1224d8a 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1357,7 +1357,7 @@ static inline pmd_t pmd_swp_clear_uffd_wp(pmd_t pmd)
 }
 #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_WP */
 
-static inline u16 pte_flags_pkey(unsigned long pte_flags)
+static inline u8 pte_flags_pkey(unsigned long pte_flags)
 {
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
 	/* ifdef to avoid doing 59-bit shift on 32-bit values */
@@ -1367,7 +1367,7 @@ static inline u16 pte_flags_pkey(unsigned long pte_flags)
 #endif
 }
 
-static inline bool __pkru_allows_pkey(u16 pkey, bool write)
+static inline bool __pkru_allows_pkey(u8 pkey, bool write)
 {
 	u32 pkru = read_pkru();
 
diff --git a/arch/x86/include/asm/pkru.h b/arch/x86/include/asm/pkru.h
index 74f0a2d34ffd..06d088f06229 100644
--- a/arch/x86/include/asm/pkru.h
+++ b/arch/x86/include/asm/pkru.h
@@ -16,13 +16,13 @@ extern u32 init_pkru_value;
 #define pkru_get_init_value()	0
 #endif
 
-static inline bool __pkru_allows_read(u32 pkru, u16 pkey)
+static inline bool __pkru_allows_read(u32 pkru, u8 pkey)
 {
 	int pkru_pkey_bits = pkey * PKRU_BITS_PER_PKEY;
 	return !(pkru & (PKRU_AD_BIT << pkru_pkey_bits));
 }
 
-static inline bool __pkru_allows_write(u32 pkru, u16 pkey)
+static inline bool __pkru_allows_write(u32 pkru, u8 pkey)
 {
 	int pkru_pkey_bits = pkey * PKRU_BITS_PER_PKEY;
 	/*
-- 
2.35.1

