Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECB95321DF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 06:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbiEXEGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 00:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234143AbiEXEGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 00:06:03 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801CA100C
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 21:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653365162; x=1684901162;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=axd6CIMkKKwgPL8PgFH1WkIgbrXV7y44ZdJBhgbW0e0=;
  b=S6tLWdDYGDPswjrq3xgDFgd7FnpDUXCWbhdlYAB9nmdFI8ndf2VE0llc
   KiJ57gGhB3lJL91qyA0poFM7IjtAE+3cSBEH02QnVtlnOGVO8RggRPsmK
   Cu1DeuhS98YsvYvLc6UUAYGKwjg6J1XXwiP9tPKdQBShnKZR57mz/SuBY
   rX0xwZIVSTLcEtiN7H0nA7WGK5IE8Ux7b6O+Hhlg5VRrSopQuoL9SPSz6
   szZ5i/FOCyfXv3PoVNj9+A/nkHp/iaNj6pnKJ0Hc5kkwoO4YQ8jQfRAKk
   Q+21lRH/E78q6JEv8Od8bjJGU6abQGRaODmoLm1pEepJmg6Xjej1lUTbC
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="336479188"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="336479188"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 21:05:56 -0700
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="526242039"
Received: from jwosulli-mobl1.ger.corp.intel.com (HELO skuppusw-desk1.home) ([10.212.165.122])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 21:05:55 -0700
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
Subject: [PATCH v7 3/5] x86/mm: Make tdx_enc_status_changed() vmalloc address compatible
Date:   Mon, 23 May 2022 21:05:15 -0700
Message-Id: <20220524040517.703581-4-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220524040517.703581-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20220524040517.703581-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set_memory_*crypted() APIs are used to change encryption or decryption
page attributes for the given address. It also by default support the
conversion for the vmalloc'ed memory address.

In TDX Guest, tdx_enc_status_changed() function is triggered by
set_memory_*crypted() APIs when converting memory from/to shared or
private. Internally this function uses __pa() for physical address
conversion, which breaks the vmalloc address compatibility of the
set_memory_*crypted() APIs.

So add support to fix the vmalloc'ed address compatibility issue.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/coco/tdx/tdx.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index b49211994864..37d58675ccf1 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -15,6 +15,7 @@
 #include <asm/idtentry.h>
 #include <asm/irq_regs.h>
 #include <asm/desc.h>
+#include <asm/io.h>
 
 /* TDX module Call Leaf IDs */
 #define TDX_GET_INFO			1
@@ -680,8 +681,14 @@ static bool try_accept_one(phys_addr_t *start, unsigned long len,
  */
 static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
 {
-	phys_addr_t start = __pa(vaddr);
-	phys_addr_t end   = __pa(vaddr + numpages * PAGE_SIZE);
+	phys_addr_t start, end;
+
+	if (is_vmalloc_addr((void *)vaddr))
+		start = vmalloc_to_pfn((void *) vaddr) << PAGE_SHIFT;
+	else
+		start = __pa(vaddr);
+
+	end = start + numpages * PAGE_SIZE;
 
 	if (!enc) {
 		/* Set the shared (decrypted) bits: */
-- 
2.25.1

