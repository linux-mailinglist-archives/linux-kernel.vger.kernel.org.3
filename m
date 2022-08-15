Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67F3592881
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 06:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240370AbiHOEPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 00:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbiHOEPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 00:15:06 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDBB13E3D
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 21:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660536905; x=1692072905;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4tAN31RYYpJnhaGsltGsp329SN2LQE0u8p1NIAAYm9M=;
  b=ZhV6y7t1IlR2Dwwsss1dodkx5I4MK46JKRskNqzHDNQchF4mtpefeQyV
   DGRDh/2zX7KpcgRWP2Sz4aNwErDD98H6w4uHEw/imgdibEv0IvCfqGws4
   bg7hesf7mBGYQOZCtO2d2tczRT4C4++l0/16QITkHtfUw3CAz7e1qrhE3
   OquDbEnxp84OcvibZz4ipyUm0px2wpziXSRIl1lh3SI1P9dzAiDt2dyOi
   eHjg5I3u1PpY9S+cZN7LkpmJLdO0UsU8G5EoN2h5Dc35KjDWwkoRUI+49
   JxWFa6zWE/TKM1NXA7FBapt8UtAXcm89YNJvG7tGakWf0Q1Mej3fokuna
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="271658890"
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="271658890"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 21:15:04 -0700
X-IronPort-AV: E=Sophos;i="5.93,237,1654585200"; 
   d="scan'208";a="934354071"
Received: from dmalka-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.42.26])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 21:15:01 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 385CE104A64; Mon, 15 Aug 2022 07:18:04 +0300 (+03)
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
Subject: [PATCHv6 01/11] x86/mm: Fix CR3_ADDR_MASK
Date:   Mon, 15 Aug 2022 07:17:53 +0300
Message-Id: <20220815041803.17954-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220815041803.17954-1-kirill.shutemov@linux.intel.com>
References: <20220815041803.17954-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
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
Reviewed-by: Alexander Potapenko <glider@google.com>
Tested-by: Alexander Potapenko <glider@google.com>
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

