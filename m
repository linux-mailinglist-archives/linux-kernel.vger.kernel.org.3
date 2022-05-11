Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D008F5229E9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 04:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241275AbiEKC3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 22:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241224AbiEKC3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 22:29:40 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D665C21A959
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 19:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652236179; x=1683772179;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YJmOMZm2CAZNr36cdPGE67zJRph2jZlNrnhMlnzgytk=;
  b=F9YWNSUt2nJCH+gMHCHXhb0elARaQDhs4xEcZKsraSJ2T3qleyJRO1Zo
   FhHYUvZyWWH89mKDbi6RmUUtniw9VkO8cynne1QS/s2rWJlbUF0yjZcHm
   JUVl7rxPPIzlrSg64KNmVZvmzL6gucWHccZwMpWEuOgSFJX7gz/NkrJU1
   mtlKwkoX11r9yJbAipV8VAB9cSKXi8+6tKMVkj2Iy5Ls3cOGGjQjRFuYg
   xU2LOvRcaEUi3a/VgXSVVl4BDSc9/D+0vB0qbXI2xq1eQPj6O3qd27NGl
   GE4idVZGqYQpl5O6htJov6Lc4mxG4YGySYEY4DdeldoXeZAMV9ofC4MJC
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="251610728"
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="251610728"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 19:29:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="895145507"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 10 May 2022 19:29:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 1CC52530; Wed, 11 May 2022 05:28:01 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [RFCv2 01/10] x86/mm: Fix CR3_ADDR_MASK
Date:   Wed, 11 May 2022 05:27:42 +0300
Message-Id: <20220511022751.65540-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
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

