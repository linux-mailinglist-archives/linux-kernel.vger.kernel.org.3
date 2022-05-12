Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E365257B0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 00:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245292AbiELWUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 18:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359111AbiELWUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 18:20:10 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D1A2802F8
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 15:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652394009; x=1683930009;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZX9rczUcpcP69GtQzgymUOW71yf2YPyb1EbDJ5FEJsw=;
  b=FkVw+C1oVvykyO03E6sngUBNTvrSL7PXoU/8H/lE2W+SSfcpEwqz7WID
   a/oaSZga3bLwlUZ8O6n8gboVwCe0y1moldJgAOz5AmhQckzu5iC6grDIV
   c4YgEpyJ4xSi+O/mvTgkOe5sGZ7c3CI/BGh2MmLHo7sWCQ83qT4rMGLUv
   M8tgS+SjQo/LO7IDhTzpThEjhrrtC2ehla21A65ffJS+e2VaNF0XY5B4O
   Jyr46wBCZTiQqammAjA+7Eq5MApsY1RquiAWBmMV9VguaAYFHX1FUIXs2
   dQqS2RASPoyUf5EZQQFekI7sXqi6NRrUf69kaGkMyA85WOYDC902AgnrF
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="257694998"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="257694998"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 15:20:08 -0700
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="594904485"
Received: from skothapa-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.209.67.107])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 15:20:07 -0700
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
Subject: [PATCH v6 3/5] x86/mm: Make tdx_enc_status_changed() vmalloc address compatible
Date:   Thu, 12 May 2022 15:19:50 -0700
Message-Id: <20220512221952.3647598-4-sathyanarayanan.kuppuswamy@linux.intel.com>
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

set_memory_*crypted() APIs are used to change encryption or decryption
page attributes for the given address. It also supports conversion for
the vmalloc'ed memory.

In TDX Guest, tdx_enc_status_changed() function is triggered by
set_memory_*crypted() APIs when converting memory from/to shared or
private. Internally this function uses __pa() for physical address
conversion, which breaks the vmalloc address compatibility of the
set_memory_*crypted() API.

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

