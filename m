Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F3E5664A2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 10:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbiGEHxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 03:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiGEHxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:53:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C505263C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 00:53:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD5046177D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 07:53:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72393C341C7;
        Tue,  5 Jul 2022 07:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657007619;
        bh=gkKm2zppu02464P8VgiYZvAG4tFQGtshBl6MOA0iWZY=;
        h=From:To:Cc:Subject:Date:From;
        b=T1RGJGrowEXDsxkGEx/o1gWCVvX9F4CVbysqjivMyhu4CPepNAXjzQkWGSFEuhrVf
         oVyz27HpJXPpUWjGg76sYA/emHtGEcSSganmwBoFxtbreojXYpIs1DZPUt7A0mLjJG
         yTsP+4KOnR7OAgG8N4s58gC2RLit0PVpumbm64a2DlA140j1Yz+tCCh8r4TER2Ee2S
         lxvXFqDjZONFqyZA48oD2Z/ajUa67BBm04/Hh0+z73B96khC0MV0JYHEKhTHhov2qK
         ZfoI5kr4Nq3+mBaCWMNB52UV0u/AtbwdNZa8bNrGnJ7DUfKk5kh0QvpkRGwJOXgbnh
         42C6vo3hviP/g==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>
Subject: [PATCH] habanalabs/gaudi2: use DIV_ROUND_UP_SECTOR_T instead of roundup
Date:   Tue,  5 Jul 2022 10:53:34 +0300
Message-Id: <20220705075334.2624692-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

roundup will create an error in 32-bit architectures as we use
64-bit variables.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi2/gaudi2.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index 919e5028f341..29d2d4c3db1f 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -1796,10 +1796,10 @@ static int gaudi2_set_dram_properties(struct hl_device *hdev)
 	prop->hints_dram_reserved_va_range.start_addr = RESERVED_VA_RANGE_FOR_ARC_ON_HBM_START;
 	prop->hints_dram_reserved_va_range.end_addr = RESERVED_VA_RANGE_FOR_ARC_ON_HBM_END;
 
-	/* since DRAM page size differs from dmmu page size we need to allocate
+	/* since DRAM page size differs from DMMU page size we need to allocate
 	 * DRAM memory in units of dram_page size and mapping this memory in
 	 * units of DMMU page size. we overcome this size mismatch using a
-	 * scarmbling routine which takes a DRAM page and converts it to a DMMU
+	 * scrambling routine which takes a DRAM page and converts it to a DMMU
 	 * page.
 	 * We therefore:
 	 * 1. partition the virtual address space to DRAM-page (whole) pages.
@@ -1814,7 +1814,7 @@ static int gaudi2_set_dram_properties(struct hl_device *hdev)
 	 *    the DRAM address MSBs (63:48) are not part of the roundup calculation
 	 */
 	prop->dmmu.start_addr = prop->dram_base_address +
-			roundup(prop->dram_size, prop->dram_page_size);
+			DIV_ROUND_UP_SECTOR_T(prop->dram_size, prop->dram_page_size);
 
 	prop->dmmu.end_addr = prop->dmmu.start_addr + prop->dram_page_size *
 			div_u64((VA_HBM_SPACE_END - prop->dmmu.start_addr), prop->dmmu.page_size);
@@ -2404,7 +2404,7 @@ static int gaudi2_cpucp_info_get(struct hl_device *hdev)
 		/* we can have wither 5 or 6 HBMs. other values are invalid */
 
 		if ((dram_size != ((GAUDI2_HBM_NUM - 1) * SZ_16G)) &&
-					(dram_size != (GAUDI2_HBM_NUM  * SZ_16G))) {
+					(dram_size != (GAUDI2_HBM_NUM * SZ_16G))) {
 			dev_err(hdev->dev,
 				"F/W reported invalid DRAM size %llu. Trying to use default size %llu\n",
 				dram_size, prop->dram_size);
-- 
2.25.1

