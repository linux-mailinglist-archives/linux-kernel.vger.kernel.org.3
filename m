Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD9859C9A1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 22:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbiHVUJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 16:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbiHVUJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 16:09:06 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767345141E
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661198945; x=1692734945;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d7Gle5OSsrdUa5bkReBAsKwZ6ONZP3Cp0kZ76kvnrJA=;
  b=G8N+UqvmW+pwG66URQ0cLQQWr5w++43r5ut0rcAKvHHachwluM5PMEkO
   WNogHl75N7BPaxhvs/I2nE5SxXTlcOn/4fVRlm98bAUyefoa0GFlfPPJd
   gXhRrXRmBwGHx3KArYBiPvHKhvIZgSh0nN4AzlViujdjMPLp4SGDaXKQn
   UBDxCjaML2zKvr3k8srWsGNLeEa+IyEWaWWpiE4GMHls7eb/byq7cHNkQ
   JzpjLGVCgcJMHPERaMuW/sNVd8VARoQm7SYEH6Ig38D9Th1pUlbbqYVQF
   R6Tay7MV0ytw2UWl69fVfmLM4wcvN3ycJat1j8rhfEbWR8uLJEkNpAdFi
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="276539356"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="276539356"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 13:09:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="698414219"
Received: from otc-wp-03.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.79])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Aug 2022 13:09:03 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>
Cc:     Raj Ashok <ashok.raj@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "Borislav Petkov" <bp@alien8.de>, "Ingo Molnar" <mingo@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 1/2] x86: mm: Allow PTI helpers to be used outside x86/mm
Date:   Mon, 22 Aug 2022 13:12:12 -0700
Message-Id: <20220822201213.352289-2-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220822201213.352289-1-jacob.jun.pan@linux.intel.com>
References: <20220822201213.352289-1-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the support of shared virtual addressing(SVA), x86 IOMMUs also
need to get access to user PGD when sharing user mappings.

This patch makes sure the PTI helper function to retrieve user PGD
is available regardless the state of CONFIG_PAGE_TABLE_ISOLATION.
So far, such need is x86 only.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 arch/x86/include/asm/pgtable.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 44e2d6f1dbaa..42f55281e232 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1227,6 +1227,11 @@ static inline p4d_t *user_to_kernel_p4dp(p4d_t *p4dp)
 {
 	return ptr_clear_bit(p4dp, PTI_PGTABLE_SWITCH_BIT);
 }
+#else
+static inline pgd_t *kernel_to_user_pgdp(pgd_t *pgdp)
+{
+	return pgdp;
+}
 #endif /* CONFIG_PAGE_TABLE_ISOLATION */
 
 /*
-- 
2.25.1

