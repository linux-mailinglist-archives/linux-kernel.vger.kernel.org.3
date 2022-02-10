Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13214B0385
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 03:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbiBJCn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 21:43:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbiBJCny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 21:43:54 -0500
X-Greylist: delayed 674 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 18:43:56 PST
Received: from h2.fbrelay.privateemail.com (h2.fbrelay.privateemail.com [131.153.2.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9612F2409A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 18:43:56 -0800 (PST)
Received: from MTA-06-3.privateemail.com (mta-06-1.privateemail.com [68.65.122.26])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by h1.fbrelay.privateemail.com (Postfix) with ESMTPS id 10F941800A77
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 21:32:42 -0500 (EST)
Received: from mta-06.privateemail.com (localhost [127.0.0.1])
        by mta-06.privateemail.com (Postfix) with ESMTP id BA63018000AD;
        Wed,  9 Feb 2022 21:32:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mebeim.net; s=default;
        t=1644460360; bh=bat2b2vczdAO3gG1eSLsoPHTCx/Y+HGptLuu8z8kW/g=;
        h=From:To:Cc:Subject:Date:From;
        b=ztPswVJK3qLcaydP8DO220wPp+b+Tv86I+fCBCl9BubJ9aY9NfVJaxpegp3/XvoHd
         QWCOFCwfB+VfW6yiuonWij5IznhHkvDhvTLjQVdF/mtzhhlLHVuI/p71jDkrRg8jlC
         KbWS/CgjOBmbcuTAGSQdnGc/1gxREEpH54It6F404FdadAqozuoQ0WdRWS6yNWNSe7
         oLGxFmQsFIsCr4RmLoaWb6nVxvPoCNUIoVIR4Fq56Rp6tml+mK6yiPNUd/mNkHHgBj
         uin3doYw4IBI2jB/KJX2S6EsziGbyfRNsplBnkNgsOf75kCYcB/WAJqO+LpKHwftAk
         fdgFekeW6v26g==
Received: from warhead.local (unknown [10.20.151.143])
        by mta-06.privateemail.com (Postfix) with ESMTPA id 06FC818000A1;
        Wed,  9 Feb 2022 21:32:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mebeim.net; s=default;
        t=1644460360; bh=bat2b2vczdAO3gG1eSLsoPHTCx/Y+HGptLuu8z8kW/g=;
        h=From:To:Cc:Subject:Date:From;
        b=ztPswVJK3qLcaydP8DO220wPp+b+Tv86I+fCBCl9BubJ9aY9NfVJaxpegp3/XvoHd
         QWCOFCwfB+VfW6yiuonWij5IznhHkvDhvTLjQVdF/mtzhhlLHVuI/p71jDkrRg8jlC
         KbWS/CgjOBmbcuTAGSQdnGc/1gxREEpH54It6F404FdadAqozuoQ0WdRWS6yNWNSe7
         oLGxFmQsFIsCr4RmLoaWb6nVxvPoCNUIoVIR4Fq56Rp6tml+mK6yiPNUd/mNkHHgBj
         uin3doYw4IBI2jB/KJX2S6EsziGbyfRNsplBnkNgsOf75kCYcB/WAJqO+LpKHwftAk
         fdgFekeW6v26g==
From:   Marco Bonelli <marco@mebeim.net>
To:     dwmw2@infradead.org
Cc:     Marco Bonelli <marco@mebeim.net>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/vt-d: Add missing "__init" for rmrr_sanity_check()
Date:   Thu, 10 Feb 2022 03:31:41 +0100
Message-Id: <20220210023141.9208-1-marco@mebeim.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rmrr_sanity_check() calls arch_rmrr_sanity_check(), which is marked as
"__init". Add the annotation for rmrr_sanity_check() too. This function is
currently only called from dmar_parse_one_rmrr() which is also "__init".

Signed-off-by: Marco Bonelli <marco@mebeim.net>
---
 drivers/iommu/intel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 92fea3fbbb11..7a308fd8d4b9 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3691,7 +3691,7 @@ static void __init init_iommu_pm_ops(void)
 static inline void init_iommu_pm_ops(void) {}
 #endif	/* CONFIG_PM */
 
-static int rmrr_sanity_check(struct acpi_dmar_reserved_memory *rmrr)
+static int __init rmrr_sanity_check(struct acpi_dmar_reserved_memory *rmrr)
 {
 	if (!IS_ALIGNED(rmrr->base_address, PAGE_SIZE) ||
 	    !IS_ALIGNED(rmrr->end_address + 1, PAGE_SIZE) ||
-- 
2.30.2

