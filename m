Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC775441A8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 04:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237206AbiFICxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 22:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbiFICwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 22:52:46 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47E41A15D2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 19:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654743165; x=1686279165;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dahg2OqaWWaJXneGpLZ3gIlIowGf6y2fYRmwNLKxzJQ=;
  b=fOSLufrM6fLUHzJYOrkWaUyTzFnr8JH1l4X99in2GxZ1EaI9WgdW1C2y
   eKvAms2gc1uqTDElEKEebEtqfPoHPNSRkz5ALh+nG89wtSOqdZG12gXIP
   ynSOtmQmoAnF90P9WGTakJzk/vVbOhwc6CBBVyKB+sut/KpVau6rnuHKn
   ZOOjd/q+V5OKskPoUd0/o1qZ9jkTIo2y8YnFO4jcbyT1i1OTKqWR5y4po
   9+6fPk3feBrZqhlUdea0JB5ouKD7D/JEDlCyPuIUdWHTVzKSc39+2N712
   QQ323dYRr1HRGzvwwf3QednUZggSm+TXsnbIELwSJgviXrR7YqyEkNwWf
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="363452727"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="363452727"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 19:52:44 -0700
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="683711303"
Received: from smsarifr-mobl.amr.corp.intel.com (HELO skuppusw-desk1.home) ([10.212.139.233])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 19:52:43 -0700
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
Subject: [PATCH v8 3/5] x86/mm: Make tdx_enc_status_changed() vmalloc address compatible
Date:   Wed,  8 Jun 2022 19:52:18 -0700
Message-Id: <20220609025220.2615197-4-sathyanarayanan.kuppuswamy@linux.intel.com>
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

set_memory_*crypted() APIs are used to change encryption or decryption
page attributes for the given address. It also by default support the
conversion for the vmalloc'ed memory address.

In TDX Guest, tdx_enc_status_changed() function is triggered by
set_memory_*crypted() APIs when converting memory from/to shared or
private. Internally this function uses __pa() for physical address
conversion, which breaks the vmalloc address compatibility of the
set_memory_*crypted() APIs.

So add support to fix the vmalloc'ed address compatibility issue.

Acked-by: Wander Lairson Costa <wander@redhat.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/coco/tdx/tdx.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 94542876f26a..445f58547776 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -15,6 +15,7 @@
 #include <asm/idtentry.h>
 #include <asm/irq_regs.h>
 #include <asm/desc.h>
+#include <asm/io.h>
 
 /* TDX module Call Leaf IDs */
 #define TDX_GET_INFO			1
@@ -678,8 +679,14 @@ static bool try_accept_one(phys_addr_t *start, unsigned long len,
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

