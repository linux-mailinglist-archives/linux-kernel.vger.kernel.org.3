Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAEFD5A58B7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 03:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiH3BBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 21:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiH3BBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 21:01:35 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC69A0245
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 18:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661821291; x=1693357291;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q72u8o9NplBRndRYgPTxCNaKqaPHER7MLnoX2dvImDc=;
  b=cm19ydCL3g0Ub6snt8PWzdR3JjQLNiY1XRVvPIDt90k709GEG/Fd4WBa
   iVt0IZK2X57IU/DgfRGOSPYI9leWwvyzayb31kT8huZdWJ4Z07uQTiAUn
   DA79L3sA17Iv7JGCFKpoyPY27d2dFKRcxi6QgMouuCx30vjzQNN71/pxw
   QnayhvP4p4Domyl5HJZierI1qQ9sordklyhxF8coXGh6llta2+8B45i8w
   Gch+X5Iq9UcyhodB+ArMfJvxQlLdZ0/ZO0DIuYpd3KEDhFEsfRdyB/t+a
   kZVwD8huJ6CVehkwNxgm26VwKqAXbH7HjgNjhKbMf4vvDDZmSPD0PLywV
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="282015865"
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="282015865"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 18:01:30 -0700
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="787305212"
Received: from fpalamon-mobl.amr.corp.intel.com (HELO box.shutemov.name) ([10.252.54.23])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 18:01:27 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 6425A1040C2; Tue, 30 Aug 2022 04:01:24 +0300 (+03)
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
Subject: [PATCHv8 01/11] x86/mm: Fix CR3_ADDR_MASK
Date:   Tue, 30 Aug 2022 04:00:54 +0300
Message-Id: <20220830010104.1282-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220830010104.1282-1-kirill.shutemov@linux.intel.com>
References: <20220830010104.1282-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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

