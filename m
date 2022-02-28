Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A254C6516
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 09:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbiB1IyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 03:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiB1IyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 03:54:12 -0500
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0C8BA1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 00:53:31 -0800 (PST)
X-QQ-mid: bizesmtp65t1646038403tua3280w
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 28 Feb 2022 16:53:17 +0800 (CST)
X-QQ-SSF: 01400000002000C0F000C00A0000000
X-QQ-FEAT: SD+t2IR+F7O+YhhETfxAYyN2jG/VLDjQ8rddYiB6TdZ9/1JUCMC2Y+I+yAWG3
        Ehx7ULKn/eqJypYXTr2Z8BaJZpmnZuADiefGszrQzSxTuURZd2QQfqwfeoYNplapcj21T7/
        NC19q5RGFmDcGzaz+CTnQtuB8TBdZ2n+htJ+4lWfJ9xBjVmLvphnUQGNgAFwUjGt52iCQ9P
        LyrLeHIiYWCSZfeTXWOXUQiD40lZJM2lIlMkCBJqb1QtwP8H9XpaCK46NY6Ca/CAbFSnS87
        uSyMrb5GQyjCgAWkuiRpYINyNPNZXfXwFPrTa6V0v5Dx/ILuySJ2PMb4zGUen/VQCjeYYmM
        DYLv03a7zCb22x9AJSyr4bL06ppgHR6yoSAAtc5N/wtR6RQvbD1d5PIAoOI1w==
X-QQ-GoodBg: 2
From:   Meng Tang <tangmeng@uniontech.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Meng Tang <tangmeng@uniontech.com>
Subject: [PATCH] Bluetooth: btrtl: Fix incorrect bin loading by MODULE_FIRMWARE
Date:   Mon, 28 Feb 2022 16:53:16 +0800
Message-Id: <20220228085316.26856-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In brctl, there are some problems which are as follows:
1. The bin name of MODULE_FIRMWARE is incorrect or the bin does not
exist.
2. The bin used in ic_id_table have not added MODULE_FIRMWARE
declarations.
3. Sorting confusion.

Thus, modify incorrect bin names and delete some non-existing bin
names, add MODULE_FIRMWARE for bins that used in ic_id_table and
sort by MODULE_FIRMWARE(ctl_bt/*.bin).

Signed-off-by: Meng Tang <tangmeng@uniontech.com>
---
 drivers/bluetooth/btrtl.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index c2030f7e25b4..e34b0a29f230 100644
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
@@ -104,19 +104,12 @@ static const struct id_table ic_id_table[] = {
 	  .fw_name  = "rtl_bt/rtl8723d_fw.bin",
 	  .cfg_name = "rtl_bt/rtl8723d_config" },
 
-	/* 8723DS */
-	{ IC_INFO(RTL_ROM_LMP_8723B, 0xd, 0x8, HCI_UART),
-	  .config_needed = true,
-	  .has_rom_version = true,
-	  .fw_name  = "rtl_bt/rtl8723ds_fw.bin",
-	  .cfg_name = "rtl_bt/rtl8723ds_config" },
-
 	/* 8821A */
 	{ IC_INFO(RTL_ROM_LMP_8821A, 0xa, 0x6, HCI_USB),
 	  .config_needed = false,
 	  .has_rom_version = true,
 	  .fw_name  = "rtl_bt/rtl8821a_fw.bin",
-	  .cfg_name = "rtl_bt/rtl8821a_config" },
+	  .cfg_name = NULL },
 
 	/* 8821C */
 	{ IC_INFO(RTL_ROM_LMP_8821A, 0xc, 0x8, HCI_USB),
@@ -131,7 +124,7 @@ static const struct id_table ic_id_table[] = {
 	  .config_needed = false,
 	  .has_rom_version = true,
 	  .fw_name  = "rtl_bt/rtl8761a_fw.bin",
-	  .cfg_name = "rtl_bt/rtl8761a_config" },
+	  .cfg_name = NULL },
 
 	/* 8761B */
 	{ IC_INFO(RTL_ROM_LMP_8761A, 0xb, 0xa, HCI_UART),
@@ -922,15 +915,23 @@ MODULE_LICENSE("GPL");
 MODULE_FIRMWARE("rtl_bt/rtl8723a_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8723b_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8723b_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8723bs_config-OBDA8723.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8723bs_fw.bin");
-MODULE_FIRMWARE("rtl_bt/rtl8723bs_config.bin");
-MODULE_FIRMWARE("rtl_bt/rtl8723ds_fw.bin");
-MODULE_FIRMWARE("rtl_bt/rtl8723ds_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8723d_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8723d_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8761a_fw.bin");
-MODULE_FIRMWARE("rtl_bt/rtl8761a_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8761b_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8761b_fw.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8761bu_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8761bu_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8821a_fw.bin");
-MODULE_FIRMWARE("rtl_bt/rtl8821a_config.bin");
-MODULE_FIRMWARE("rtl_bt/rtl8822b_fw.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8821c_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8821c_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8822b_config.bin");
-MODULE_FIRMWARE("rtl_bt/rtl8852au_fw.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8822b_fw.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8822cs_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8822cs_fw.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8822cu_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8822cu_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852au_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8852au_fw.bin");
-- 
2.20.1



