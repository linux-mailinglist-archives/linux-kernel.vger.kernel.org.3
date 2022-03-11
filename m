Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935BD4D5802
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 03:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345584AbiCKCTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 21:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241127AbiCKCTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 21:19:08 -0500
Received: from smtpproxy21.qq.com (smtpbg702.qq.com [203.205.195.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10738C1148
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 18:18:03 -0800 (PST)
X-QQ-mid: bizesmtp69t1646965078ti4250p1
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 11 Mar 2022 10:17:51 +0800 (CST)
X-QQ-SSF: 01400000002000C0H000B00A0000000
X-QQ-FEAT: 0Mv5E39fBgZJWkMX5kM5Y8J2ER76W0t/aUWrYFb8CUB+PVKoLkyYMz1zg3Jme
        GFCmFhH9lUK8E8FxDRQFaYd+5s4MWfMF5UuGCvcOe4DY4nWDyZjllk/XN46sTOKFcGpZIsg
        M7pX58nnsj8AHLPbAmXvVfTFFOwSn/OzJasq9egOA1F+YUlvnSV+ldrAO0TBrbj99DI/uoY
        MibaaDVRuk7Tf8rkdKtDA4iMm6GTC39zUJabTk4pTq9ygt6OkMJ/zoTsZxftHC0fIWjdgcY
        J3KshvbISZK8Cwl7MMzjrA3OnL73k8oqCTTfDRfYrhdbXID9IRRytFbEkB+Eu0zA8EXThQV
        9BaOdlU6s1vQ23s9oVXg7I5ZB4IzB4YHjG2Gu1V
X-QQ-GoodBg: 2
From:   Meng Tang <tangmeng@uniontech.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Meng Tang <tangmeng@uniontech.com>
Subject: [PATCH] Bluetooth: btrtl: btmrvl: Fix firmware filename for rtl chipset
Date:   Fri, 11 Mar 2022 10:17:50 +0800
Message-Id: <20220311021750.24021-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firmware for rtl chipset is as part of the linux-firmware repository
in dir linux-firmware/rtl_bt. Today, the rtl8761a_config,
rtl8821a_config, rtl8723b_config and rtl8723bs_config files are used
in btrtl, but it doesn't actually exist, which causes errors like:

bluetooth: Direct firmware load for rtl_bt/rtl8821a_config.bin
           failed with error -2

According to the files in the rtl_bt directory in the Linux firmware,
fixes the driver to load correct firmware file for rtl.

Signed-off-by: Meng Tang <tangmeng@uniontech.com>
---
 drivers/bluetooth/btrtl.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index c2030f7e25b4..c10e07ad2fa3 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -88,14 +88,14 @@ static const struct id_table ic_id_table[] = {
 	  .config_needed = true,
 	  .has_rom_version = true,
 	  .fw_name  = "rtl_bt/rtl8723bs_fw.bin",
-	  .cfg_name = "rtl_bt/rtl8723bs_config" },
+	  .cfg_name = "rtl_bt/rtl8723bs_config-OBDA8723" },
 
 	/* 8723B */
 	{ IC_INFO(RTL_ROM_LMP_8723B, 0xb, 0x6, HCI_USB),
 	  .config_needed = false,
 	  .has_rom_version = true,
 	  .fw_name  = "rtl_bt/rtl8723b_fw.bin",
-	  .cfg_name = "rtl_bt/rtl8723b_config" },
+	  .cfg_name = NULL },
 
 	/* 8723D */
 	{ IC_INFO(RTL_ROM_LMP_8723B, 0xd, 0x8, HCI_USB),
@@ -116,7 +116,7 @@ static const struct id_table ic_id_table[] = {
 	  .config_needed = false,
 	  .has_rom_version = true,
 	  .fw_name  = "rtl_bt/rtl8821a_fw.bin",
-	  .cfg_name = "rtl_bt/rtl8821a_config" },
+	  .cfg_name = NULL },
 
 	/* 8821C */
 	{ IC_INFO(RTL_ROM_LMP_8821A, 0xc, 0x8, HCI_USB),
@@ -131,7 +131,7 @@ static const struct id_table ic_id_table[] = {
 	  .config_needed = false,
 	  .has_rom_version = true,
 	  .fw_name  = "rtl_bt/rtl8761a_fw.bin",
-	  .cfg_name = "rtl_bt/rtl8761a_config" },
+	  .cfg_name = NULL },
 
 	/* 8761B */
 	{ IC_INFO(RTL_ROM_LMP_8761A, 0xb, 0xa, HCI_UART),
@@ -184,7 +184,7 @@ static const struct id_table ic_id_table[] = {
 	{ IC_INFO(RTL_ROM_LMP_8852A, 0xa, 0xb, HCI_USB),
 	  .config_needed = false,
 	  .has_rom_version = true,
-	  .has_msft_ext = true,
+	  n.has_msft_ext = true,
 	  .fw_name  = "rtl_bt/rtl8852au_fw.bin",
 	  .cfg_name = "rtl_bt/rtl8852au_config" },
 	};
@@ -921,15 +921,12 @@ MODULE_VERSION(VERSION);
 MODULE_LICENSE("GPL");
 MODULE_FIRMWARE("rtl_bt/rtl8723a_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8723b_fw.bin");
-MODULE_FIRMWARE("rtl_bt/rtl8723b_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8723bs_fw.bin");
-MODULE_FIRMWARE("rtl_bt/rtl8723bs_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8723bs_config-OBDA8723.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8723ds_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8723ds_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8761a_fw.bin");
-MODULE_FIRMWARE("rtl_bt/rtl8761a_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8821a_fw.bin");
-MODULE_FIRMWARE("rtl_bt/rtl8821a_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8822b_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8822b_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852au_fw.bin");
-- 
2.20.1



