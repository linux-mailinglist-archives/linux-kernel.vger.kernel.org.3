Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BB95A45FE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 11:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiH2JX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 05:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiH2JXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 05:23:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4E15AC45
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 02:23:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 237CB60FA6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 09:23:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7053C433D6;
        Mon, 29 Aug 2022 09:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661764982;
        bh=i+TyAJcdH1xZxAk1Jhglvj9cFowqOJEpcp1jx3o52pM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dvWiaJgvo9W5H06bfBC4s3dAnWrSm8Qtv2WR2g/UbpwfRP9VipgyU9Sb8V7ZvgCed
         amDh+c9SBerMcmQjyJ110s4grO/60sqjYmWyk+8OTjv4dyBZmIOgwAl7/Fstscolyt
         1IlJ/vr1rIXgfTgL7+65EwU4a4TybLQ8HHvjBHJ87Ah3PdD2LXX0c4U0CnYp44Sc6a
         j/xSOaT1JDX85N5+HVPm3uyCZaebGuH04NpNQMWquFilc1MLgim0gA14cZFumjhKr+
         neFTsZ+xuciqHm9NMAK+NFhR8HK4XJDr3yGRd66N8BQLXKnI5d4aRHt04JlQRg9QxS
         kRRENNvcJhYqQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 3/7] habanalabs: ignore EEPROM errors during boot
Date:   Mon, 29 Aug 2022 12:22:50 +0300
Message-Id: <20220829092254.930753-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220829092254.930753-1-ogabbay@kernel.org>
References: <20220829092254.930753-1-ogabbay@kernel.org>
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

From: Ofir Bitton <obitton@habana.ai>

EEPROM errors reported by firmware are basically warnings and
should not fail the boot process.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c        | 9 +++++++++
 drivers/misc/habanalabs/include/common/hl_boot_if.h | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 12d0f18c1f6c..4ede4bb03e8e 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -573,6 +573,15 @@ static bool fw_report_boot_dev0(struct hl_device *hdev, u32 err_val,
 		dev_dbg(hdev->dev, "Device status0 %#x\n", sts_val);
 
 	/* All warnings should go here in order not to reach the unknown error validation */
+	if (err_val & CPU_BOOT_ERR0_EEPROM_FAIL) {
+		dev_warn(hdev->dev,
+			"Device boot warning - EEPROM failure detected, default settings applied\n");
+		/* This is a warning so we don't want it to disable the
+		 * device
+		 */
+		err_val &= ~CPU_BOOT_ERR0_EEPROM_FAIL;
+	}
+
 	if (err_val & CPU_BOOT_ERR0_DRAM_SKIPPED) {
 		dev_warn(hdev->dev,
 			"Device boot warning - Skipped DRAM initialization\n");
diff --git a/drivers/misc/habanalabs/include/common/hl_boot_if.h b/drivers/misc/habanalabs/include/common/hl_boot_if.h
index f2f6488de625..2e45be5de4fe 100644
--- a/drivers/misc/habanalabs/include/common/hl_boot_if.h
+++ b/drivers/misc/habanalabs/include/common/hl_boot_if.h
@@ -34,6 +34,7 @@ enum cpu_boot_err {
 	CPU_BOOT_ERR_BINNING_FAIL = 19,
 	CPU_BOOT_ERR_TPM_FAIL = 20,
 	CPU_BOOT_ERR_TMP_THRESH_INIT_FAIL = 21,
+	CPU_BOOT_ERR_EEPROM_FAIL = 22,
 	CPU_BOOT_ERR_ENABLED = 31,
 	CPU_BOOT_ERR_SCND_EN = 63,
 	CPU_BOOT_ERR_LAST = 64 /* we have 2 registers of 32 bits */
@@ -115,6 +116,9 @@ enum cpu_boot_err {
  * CPU_BOOT_ERR0_TMP_THRESH_INIT_FAIL	Failed to set threshold for tmperature
  *					sensor.
  *
+ * CPU_BOOT_ERR_EEPROM_FAIL		Failed reading EEPROM data. Defaults
+ *					are used.
+ *
  * CPU_BOOT_ERR0_ENABLED		Error registers enabled.
  *					This is a main indication that the
  *					running FW populates the error
@@ -139,6 +143,7 @@ enum cpu_boot_err {
 #define CPU_BOOT_ERR0_BINNING_FAIL		(1 << CPU_BOOT_ERR_BINNING_FAIL)
 #define CPU_BOOT_ERR0_TPM_FAIL			(1 << CPU_BOOT_ERR_TPM_FAIL)
 #define CPU_BOOT_ERR0_TMP_THRESH_INIT_FAIL	(1 << CPU_BOOT_ERR_TMP_THRESH_INIT_FAIL)
+#define CPU_BOOT_ERR0_EEPROM_FAIL		(1 << CPU_BOOT_ERR_EEPROM_FAIL)
 #define CPU_BOOT_ERR0_ENABLED			(1 << CPU_BOOT_ERR_ENABLED)
 #define CPU_BOOT_ERR1_ENABLED			(1 << CPU_BOOT_ERR_ENABLED)
 
-- 
2.25.1

