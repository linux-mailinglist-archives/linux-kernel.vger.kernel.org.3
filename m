Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61924FB6FB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344218AbiDKJLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235850AbiDKJKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:10:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5365327FE9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 02:08:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3B8260B28
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 09:08:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63613C385A4;
        Mon, 11 Apr 2022 09:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649668099;
        bh=PjAaPAS1kqnduWEYvYhiRAFq9XQRFpqrkGMMGfA0Yvc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aNdBXn+FNS2SydWNOKwwoT2TEz2C+YF9QXrXG4fp90CAA4r1a6VArMqDko2aC3YMy
         xG5idyWZwcOBQFqKxsEWxanYSmnxusYBwOLOIjdBvfN6D0VdZdjP38NfKdDV9KmU3b
         HymzZaYgXQg92U1Bse8Mqc8Rgkd+zIedAvLuM3P/RI6fm/08czSoxljCwKw9eYY1f3
         sWh4V2kCNE88sajqBmlN1cD5FBLvn5PH+JjfDd9HP9wTU4qS7RM9FhzSECtjZiToei
         OMlCLJELO2yt6JJ/0cjdTGKqyx7hYL6KHrzp6iUwBYg2YuwJUyW6wzELrdc0tCWVTc
         N8vLTf0qajYHQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Moti Haimovski <mhaimovski@habana.ai>
Subject: [PATCH 7/7] habanalabs: support debugfs Byte access to device DRAM
Date:   Mon, 11 Apr 2022 12:08:05 +0300
Message-Id: <20220411090805.1617112-7-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220411090805.1617112-1-ogabbay@kernel.org>
References: <20220411090805.1617112-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moti Haimovski <mhaimovski@habana.ai>

The habanalabs HW requires memory resources to be used by its
internal hardware structures. These structures are allocated and
initialized by the driver. We would like to use the device HBM for
that purpose. This memory is io-remapped and accessed using the
writel()/writeb()/writew() commands.
Since some of the HW structures are one byte in size we need to
add support for the  writeb() and readb() functions in the driver.

Signed-off-by: Moti Haimovski <mhaimovski@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/debugfs.c    |  3 +++
 drivers/misc/habanalabs/common/device.c     | 12 ++++++++++++
 drivers/misc/habanalabs/common/habanalabs.h |  2 ++
 3 files changed, 17 insertions(+)

diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index ffa613af6b0d..7c4a4d504e4c 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -688,6 +688,9 @@ static void hl_access_host_mem(struct hl_device *hdev, u64 addr, u64 *val,
 	case DEBUGFS_WRITE64:
 		*(u64 *) phys_to_virt(addr - offset) = *val;
 		break;
+	default:
+		dev_err(hdev->dev, "hostmem access-type %d id not supported\n", acc_type);
+		break;
 	}
 }
 
diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 0f4f7e538b61..9d2978e43e51 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -53,6 +53,14 @@ static int hl_access_sram_dram_region(struct hl_device *hdev, u64 addr, u64 *val
 	}
 
 	switch (acc_type) {
+	case DEBUGFS_READ8:
+		*val = readb(hdev->pcie_bar[region->bar_id] +
+			addr - region->region_base + region->offset_in_bar);
+		break;
+	case DEBUGFS_WRITE8:
+		writeb(*val, hdev->pcie_bar[region->bar_id] +
+			addr - region->region_base + region->offset_in_bar);
+		break;
 	case DEBUGFS_READ32:
 		*val = readl(hdev->pcie_bar[region->bar_id] +
 			addr - region->region_base + region->offset_in_bar);
@@ -148,7 +156,11 @@ int hl_access_cfg_region(struct hl_device *hdev, u64 addr, u64 *val,
 		WREG32(addr - cfg_region->region_base, lower_32_bits(*val));
 		WREG32(addr + sizeof(u32) - cfg_region->region_base, upper_32_bits(*val));
 		break;
+	default:
+		dev_err(hdev->dev, "access type %d is not supported\n", acc_type);
+		return -EOPNOTSUPP;
 	}
+
 	return 0;
 }
 
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 5f7e584d0f33..a8e6118c0fc7 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1100,6 +1100,8 @@ enum div_select_defs {
 };
 
 enum debugfs_access_type {
+	DEBUGFS_READ8,
+	DEBUGFS_WRITE8,
 	DEBUGFS_READ32,
 	DEBUGFS_WRITE32,
 	DEBUGFS_READ64,
-- 
2.25.1

