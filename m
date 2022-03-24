Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606BA4E6126
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 10:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349295AbiCXJfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 05:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349253AbiCXJfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 05:35:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5071D330
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 02:34:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 332F9B82330
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 09:34:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E41D8C340EC;
        Thu, 24 Mar 2022 09:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648114441;
        bh=a/aNVlGmVQlaR1+sqNefgMoMvFW2M4VADYuLrK8krnQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mBSw6/w8vnKsACTDJBLn5TvNwxWnTDhwe604iSp2/W0dCAPCvE/GPnHi+diBZZw3I
         kT6lH69FFJlY836SDMNn+kAF+AXx9bHTDGj+IAg0KKuTbhHAXeA6cce1xRbNFC2ay9
         ud+eGh/1dmlhC9n5ySEt09VFg5Cvik91wrX7T1RBr8saHqMikF8OPHe3ZF4KBAdOa2
         CUwk+hSbb7g0Lc8tKe+QGXqVyZ7ADTjgHFW5Ki9B6X52il3NX/cE8V+Bxn0vEvp/PN
         R7K0ZxM6wLBYlxsE2jJUwHOmlO14Ac8VG5cO7YT5tWIaTE0Z7SA9I1rdQYVbBFrEHr
         HV23Swe1W/Spw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dafna Hirschfeld <dhirschfeld@habana.ai>
Subject: [PATCH 5/7] habanalabs/gaudi: Use correct sram size macro for debugfs
Date:   Thu, 24 Mar 2022 11:33:47 +0200
Message-Id: <20220324093349.3245973-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220324093349.3245973-1-ogabbay@kernel.org>
References: <20220324093349.3245973-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dafna Hirschfeld <dhirschfeld@habana.ai>

We currently allow accessing the whole SRAM bar size with
the macro SRAM_BAR_SIZE, but the actual size of the sram
region is the macro SRAM_SIZE which is only a portion of
the whole bar size. So when accessing the sram through
debugfs, use the macro SRAM_SIZE for the sram size
which is the correct macro.

Signed-off-by: Dafna Hirschfeld <dhirschfeld@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 68c066e39660..2101abf1d092 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -6115,7 +6115,7 @@ static int gaudi_debugfs_read32(struct hl_device *hdev, u64 addr,
 
 		*val = RREG32(addr - CFG_BASE);
 
-	} else if ((addr >= SRAM_BASE_ADDR) && (addr < SRAM_BASE_ADDR + SRAM_BAR_SIZE)) {
+	} else if ((addr >= SRAM_BASE_ADDR) && (addr < SRAM_BASE_ADDR + SRAM_SIZE)) {
 
 		*val = readl(hdev->pcie_bar[SRAM_BAR_ID] + (addr - SRAM_BASE_ADDR));
 
@@ -6158,7 +6158,7 @@ static int gaudi_debugfs_write32(struct hl_device *hdev, u64 addr,
 
 		WREG32(addr - CFG_BASE, val);
 
-	} else if ((addr >= SRAM_BASE_ADDR) && (addr < SRAM_BASE_ADDR + SRAM_BAR_SIZE)) {
+	} else if ((addr >= SRAM_BASE_ADDR) && (addr < SRAM_BASE_ADDR + SRAM_SIZE)) {
 
 		writel(val, hdev->pcie_bar[SRAM_BAR_ID] + (addr - SRAM_BASE_ADDR));
 
@@ -6205,7 +6205,7 @@ static int gaudi_debugfs_read64(struct hl_device *hdev, u64 addr,
 		*val = (((u64) val_h) << 32) | val_l;
 
 	} else if ((addr >= SRAM_BASE_ADDR) &&
-			(addr <= SRAM_BASE_ADDR + SRAM_BAR_SIZE - sizeof(u64))) {
+			(addr <= SRAM_BASE_ADDR + SRAM_SIZE - sizeof(u64))) {
 
 		*val = readq(hdev->pcie_bar[SRAM_BAR_ID] + (addr - SRAM_BASE_ADDR));
 
@@ -6250,7 +6250,7 @@ static int gaudi_debugfs_write64(struct hl_device *hdev, u64 addr,
 		WREG32(addr + sizeof(u32) - CFG_BASE, upper_32_bits(val));
 
 	} else if ((addr >= SRAM_BASE_ADDR) &&
-			(addr <= SRAM_BASE_ADDR + SRAM_BAR_SIZE - sizeof(u64))) {
+			(addr <= SRAM_BASE_ADDR + SRAM_SIZE - sizeof(u64))) {
 
 		writeq(val, hdev->pcie_bar[SRAM_BAR_ID] + (addr - SRAM_BASE_ADDR));
 
-- 
2.25.1

