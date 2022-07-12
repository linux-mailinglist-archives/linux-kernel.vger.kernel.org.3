Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A1E5729B4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 01:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbiGLXN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 19:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiGLXN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 19:13:26 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07B39B9C7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 16:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657667605; x=1689203605;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eoYteC6GODz7y0R2zobgy/O4IaLSlJbZw9u65ssKePw=;
  b=O6MYWYvADvSqz1DVZ2k0XYf1GOD8mr3xKn18W+6iLwyHsjOzk4++6HTI
   Dv+K0VSiQCdD2nbsXnR4oWu62aMQoa8QU/nXLSDPm5IxohS98t4kTckwQ
   0DWhbtX4B1pAZwbPiMTx/ncC7Kx+6wF50K9Nwen6a6eqGUSV6EpEZXCYu
   GSx3df15Tb/11v+ad0L/qNnvUnaqzL5lO7CdRrmQWQtYxXuH38OQZdoWO
   0LSc/vi0SG9zXB1xkxoBViZyV4goApSxKtz+RYyDGdjMFW0fUXQT9Gbwb
   TLEOosjiF+ssa6Hu7KxPXm0S9JkZrfFbzCEAZKZl94xnaHShr1IIa/7QF
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="283818833"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="283818833"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 16:13:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="599542507"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 12 Jul 2022 16:13:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id B877BD9; Wed, 13 Jul 2022 02:13:29 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv5 01/13] x86/mm: Fix CR3_ADDR_MASK
Date:   Wed, 13 Jul 2022 02:13:16 +0300
Message-Id: <20220712231328.5294-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220712231328.5294-1-kirill.shutemov@linux.intel.com>
References: <20220712231328.5294-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mask must not include bits above physical address mask. These bits
are reserved and can be used for other things. Bits 61 and 62 are used
for Linear Address Masking.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/include/asm/processor-flags.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/processor-flags.h b/arch/x86/include/asm/processor-flags.h
index 02c2cbda4a74..a7f3d9100adb 100644
--- a/arch/x86/include/asm/processor-flags.h
+++ b/arch/x86/include/asm/processor-flags.h
@@ -35,7 +35,7 @@
  */
 #ifdef CONFIG_X86_64
 /* Mask off the address space ID and SME encryption bits. */
-#define CR3_ADDR_MASK	__sme_clr(0x7FFFFFFFFFFFF000ull)
+#define CR3_ADDR_MASK	__sme_clr(PHYSICAL_PAGE_MASK)
 #define CR3_PCID_MASK	0xFFFull
 #define CR3_NOFLUSH	BIT_ULL(63)
 
-- 
2.35.1

