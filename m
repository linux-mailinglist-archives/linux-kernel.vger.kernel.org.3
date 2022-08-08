Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C3158CAE4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 16:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243536AbiHHO5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 10:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243428AbiHHO5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 10:57:36 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7434211C26
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 07:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659970654; x=1691506654;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RqWLLHXdKq7i3jEZDCWPo2WblS5wC3PZ6h5tyOrVLyQ=;
  b=UiuO/XnqNLMdIWjXlxmA9GKV+SM1/jLVckdm2zMs+eNM7LVsO4iDnGqH
   LN6JZ10mtS/MkIamTkzRID1yOOV0QnWBNVBCEBJ4Ck49TO/4Ro0DBPu1A
   ZPoQGnyK1EZhqW1DFJg2wYsibL+8QWh1f+23NXmtg/xT42NAIJK+9busm
   iJPAp2eCqD6P4nLk8jmEbuh6p08hD2qdFfyGTDwJp0Hfl87RFklgR7QSr
   m67nsXyM+Ru4dKNm8/Nrh6FOzcEq/2pguv0St1cDEJalta6mwSZvb7Igy
   gaTVQ81eI/pBWqPRJzwrwRwor8r+8RjLlSurvBr5k7HL9k7+TSigNSYwn
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="270996886"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="270996886"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 07:57:34 -0700
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="663980492"
Received: from ziqianlu-desk2.sh.intel.com ([10.238.2.76])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 07:57:32 -0700
From:   Aaron Lu <aaron.lu@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [RFC PATCH 1/4] x86/mm/cpa: restore global bit when page is present
Date:   Mon,  8 Aug 2022 22:56:46 +0800
Message-Id: <20220808145649.2261258-2-aaron.lu@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808145649.2261258-1-aaron.lu@intel.com>
References: <20220808145649.2261258-1-aaron.lu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For configs that don't have PTI enabled or cpus that don't need
meltdown mitigation, current kernel can lose GLOBAL bit after a page
goes through a cycle of present -> not present -> present.

It happened like this(__vunmap() does this in vm_remove_mappings()):
original page protection: 0x8000000000000163 (NX/G/D/A/RW/P)
set_memory_np(page, 1):   0x8000000000000062 (NX/D/A/RW) lose G and P
set_memory_p(pagem 1):    0x8000000000000063 (NX/D/A/RW/P) restored P

In the end, this page's protection no longer has Global bit set and this
would create problem for this merge small mapping feature.

For this reason, restore Global bit for systems that do not have PTI
enabled if page is present.

(pgprot_clear_protnone_bits() deserves a better name if this patch is
acceptible but first, I would like to get some feedback if this is the
right way to solve this so I didn't bother with the name yet)

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 arch/x86/mm/pat/set_memory.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 1abd5438f126..33657a54670a 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -758,6 +758,8 @@ static pgprot_t pgprot_clear_protnone_bits(pgprot_t prot)
 	 */
 	if (!(pgprot_val(prot) & _PAGE_PRESENT))
 		pgprot_val(prot) &= ~_PAGE_GLOBAL;
+	else
+		pgprot_val(prot) |= _PAGE_GLOBAL & __default_kernel_pte_mask;
 
 	return prot;
 }
-- 
2.37.1

