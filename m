Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A325884D1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 01:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbiHBXma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 19:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiHBXm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 19:42:28 -0400
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B2751A2F
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 16:42:26 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="83820010"
X-IronPort-AV: E=Sophos;i="5.93,212,1654527600"; 
   d="scan'208";a="83820010"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP; 03 Aug 2022 08:42:24 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 3F3CBDAFD2
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 08:42:23 +0900 (JST)
Received: from oym-om1.fujitsu.com (oym-om1.o.css.fujitsu.com [10.85.58.161])
        by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 6652327571
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 08:42:22 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om1.fujitsu.com (Postfix) with ESMTP id 2E26F4008A7C3;
        Wed,  3 Aug 2022 08:42:22 +0900 (JST)
From:   Shuuichirou Ishii <ishii.shuuichir@fujitsu.com>
To:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        thunder.leizhen@huawei.com, jgg@ziepe.ca, tglx@linutronix.de,
        chenxiang66@hisilicon.com, christophe.jaillet@wanadoo.fr,
        john.garry@huawei.com, baolu.lu@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     ishii.shuuichir@fujitsu.com
Subject: [PATCH] iommu/arm-smmu-v3: fixed check process for disable_bypass module parameter
Date:   Wed,  3 Aug 2022 08:42:07 +0900
Message-Id: <20220802234207.1994093-1-ishii.shuuichir@fujitsu.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current process does not enable the bypass setting regardless of
the value of the disable_bypass module parameter when ACPI is enabled,
so the value of the disable_bypass module parameter has been corrected
so that it is handled correctly.

Signed-off-by: Shuuichirou Ishii <ishii.shuuichir@fujitsu.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 88817a3376ef..256d7b2a83a7 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3396,7 +3396,7 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 		enables &= ~(CR0_EVTQEN | CR0_PRIQEN);
 
 	/* Enable the SMMU interface, or ensure bypass */
-	if (!bypass || disable_bypass) {
+	if (!bypass && disable_bypass) {
 		enables |= CR0_SMMUEN;
 	} else {
 		ret = arm_smmu_update_gbpa(smmu, 0, GBPA_ABORT);
-- 
2.27.0

