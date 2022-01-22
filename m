Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3186496DC3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 20:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbiAVT6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 14:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234869AbiAVT5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 14:57:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB37C061744
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 11:57:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C340260EC0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 19:57:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A58BC340E2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 19:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642881474;
        bh=BuVFNWMU5A+62/ffDCFunnfS3uOzMRX/MohvbzuGFwM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=d3yIDPNY02cUMttxCEg4H7fMqv3RN1MKK9FyV3vNmvqZ0D46rEuW4TpuUzijjpRv1
         5MVsYp3q7jxwWie+HikCaxdNYmW4ENewHX9fRyMFjoGuxM3S4O/aBoKyvkHWsjULam
         KSdgbmhutuXgDrnN70jhSyid/PwOEF4oYhCUTz2QdFSl2t7k1wa9lMbIccQ5+Np463
         nzZR0JQXQYg0xlI0EBd/G6Bmwvctvivc9BqkAM+XFvD9m1qPJ/qrKfwUWzZ/8IMQLf
         e8fni7ooRgq/YDJZsIgZK88eF/n8YzEzid63FyifidQ0LHCXfOBJbl9O8fAXvUsN4Q
         csLn4WXYP5OIw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 14/30] habanalabs: remove power9 workaround for dma support
Date:   Sat, 22 Jan 2022 21:57:15 +0200
Message-Id: <20220122195731.934494-14-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220122195731.934494-1-ogabbay@kernel.org>
References: <20220122195731.934494-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need this workaround anymore.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h |  3 ---
 drivers/misc/habanalabs/common/pci/pci.c    |  5 +----
 drivers/misc/habanalabs/gaudi/gaudi.c       |  9 +--------
 drivers/misc/habanalabs/goya/goya.c         | 11 +----------
 4 files changed, 3 insertions(+), 25 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index b8acfef9577a..6c7a60210416 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2604,8 +2604,6 @@ struct hl_reset_info {
  * @in_debug: whether the device is in a state where the profiling/tracing infrastructure
  *            can be used. This indication is needed because in some ASICs we need to do
  *            specific operations to enable that infrastructure.
- * @power9_64bit_dma_enable: true to enable 64-bit DMA mask support. Relevant
- *                           only to POWER9 machines.
  * @cdev_sysfs_created: were char devices and sysfs nodes created.
  * @stop_on_err: true if engines should stop on error.
  * @supports_sync_stream: is sync stream supported.
@@ -2728,7 +2726,6 @@ struct hl_device {
 	u8				device_cpu_disabled;
 	u8				dma_mask;
 	u8				in_debug;
-	u8				power9_64bit_dma_enable;
 	u8				cdev_sysfs_created;
 	u8				stop_on_err;
 	u8				supports_sync_stream;
diff --git a/drivers/misc/habanalabs/common/pci/pci.c b/drivers/misc/habanalabs/common/pci/pci.c
index 0b5366cc84fd..a6ffa342070c 100644
--- a/drivers/misc/habanalabs/common/pci/pci.c
+++ b/drivers/misc/habanalabs/common/pci/pci.c
@@ -338,10 +338,7 @@ int hl_pci_set_outbound_region(struct hl_device *hdev,
 				lower_32_bits(outbound_region_end_address));
 	rc |= hl_pci_iatu_write(hdev, 0x014, 0);
 
-	if ((hdev->power9_64bit_dma_enable) && (hdev->dma_mask == 64))
-		rc |= hl_pci_iatu_write(hdev, 0x018, 0x08000000);
-	else
-		rc |= hl_pci_iatu_write(hdev, 0x018, 0);
+	rc |= hl_pci_iatu_write(hdev, 0x018, 0);
 
 	rc |= hl_pci_iatu_write(hdev, 0x020,
 				upper_32_bits(outbound_region_end_address));
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index c4e41856ad31..66c90164be6b 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -9008,14 +9008,7 @@ static void gaudi_reset_sob(struct hl_device *hdev, void *data)
 
 static void gaudi_set_dma_mask_from_fw(struct hl_device *hdev)
 {
-	if (RREG32(mmPSOC_GLOBAL_CONF_NON_RST_FLOPS_0) ==
-							HL_POWER9_HOST_MAGIC) {
-		hdev->power9_64bit_dma_enable = 1;
-		hdev->dma_mask = 64;
-	} else {
-		hdev->power9_64bit_dma_enable = 0;
-		hdev->dma_mask = 48;
-	}
+	hdev->dma_mask = 48;
 }
 
 static u64 gaudi_get_device_time(struct hl_device *hdev)
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 916a718dddac..1bd23578cb83 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5554,16 +5554,7 @@ static void goya_reset_sob_group(struct hl_device *hdev, u16 sob_group)
 
 static void goya_set_dma_mask_from_fw(struct hl_device *hdev)
 {
-	if (RREG32(mmPSOC_GLOBAL_CONF_NON_RST_FLOPS_0) ==
-							HL_POWER9_HOST_MAGIC) {
-		dev_dbg(hdev->dev, "Working in 64-bit DMA mode\n");
-		hdev->power9_64bit_dma_enable = 1;
-		hdev->dma_mask = 64;
-	} else {
-		dev_dbg(hdev->dev, "Working in 48-bit DMA mode\n");
-		hdev->power9_64bit_dma_enable = 0;
-		hdev->dma_mask = 48;
-	}
+	hdev->dma_mask = 48;
 }
 
 u64 goya_get_device_time(struct hl_device *hdev)
-- 
2.25.1

