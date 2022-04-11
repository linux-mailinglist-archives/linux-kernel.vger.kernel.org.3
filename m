Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126A24FBC3B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 14:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346163AbiDKMi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 08:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbiDKMiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:38:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DF2121825
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 05:36:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCF63D6E;
        Mon, 11 Apr 2022 05:36:36 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0669F3F5A1;
        Mon, 11 Apr 2022 05:36:35 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     ogabbay@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [PATCH v2] habanalabs: Stop using iommu_present()
Date:   Mon, 11 Apr 2022 13:36:32 +0100
Message-Id: <bec0fe9659f832715295f9895025ee8fd91847f3.1649680490.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even if an IOMMU might be present for some PCI segment in the system,
that doesn't necessarily mean it provides translation for the device
we care about. Replace iommu_present() with a more appropriate check.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: Rebase on habanalabs-next

 drivers/misc/habanalabs/common/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index 7c4a4d504e4c..a94f01713efd 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -722,7 +722,7 @@ static int hl_access_mem(struct hl_device *hdev, u64 addr, u64 *val,
 	if (found)
 		return 0;
 
-	if (!user_address || iommu_present(&pci_bus_type)) {
+	if (!user_address || device_iommu_mapped(&hdev->pdev->dev)) {
 		rc = -EINVAL;
 		goto err;
 	}
-- 
2.28.0.dirty

