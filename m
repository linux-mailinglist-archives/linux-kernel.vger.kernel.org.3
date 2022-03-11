Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D5C4D58DC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 04:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345988AbiCKD1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 22:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239978AbiCKD1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 22:27:42 -0500
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54052C5D8F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 19:26:36 -0800 (PST)
X-QQ-mid: bizesmtp86t1646969187txwsvgjo
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 11 Mar 2022 11:26:22 +0800 (CST)
X-QQ-SSF: 01400000002000C0H000000A0000000
X-QQ-FEAT: ZKIyA7viXp1GCqUI9+PJYZn7tA3Hn8w4WMZxIqplDpVsQUvz0t7ey0elRafcH
        W/BM7gGWm4CfkpeO/6i4FOrqGxkT3u8AKXnSG2ObsoT1NhbEnHJu4nzhWwRn5He1RItvelt
        txKwL8Pxg0j96ujnaV1U2CEIDq1Et3kv0tkl/LzGRL8xDk70h8j0EUzUob+ABs0+dnr7tFC
        QMPxDgrpiI1QykYb76I+hW91wt32Qn4UCMwKCGzKx3L+7RysWGCi0bcsIN4bbCsr4QYtzss
        rUhzXCrNKMkE8iIJe8m0VoZSkDQ4u7XBJoGZ+gASHkQdGDJTJcdML7XkvJhVv3BIwyQtgdb
        uxp+O7ssrHAyYDR9VtDR5UOO7wa5XWDF8TLPpU2mqBrC7QWjiI=
X-QQ-GoodBg: 1
From:   Meng Tang <tangmeng@uniontech.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Meng Tang <tangmeng@uniontech.com>
Subject: [PATCH] Bluetooth: btrtl: btmrvl: Fix firmware filename for rtl chipset
Date:   Fri, 11 Mar 2022 11:26:20 +0800
Message-Id: <20220311032620.28362-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/bluetooth/btrtl.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index c2030f7e25b4..e3cfe0dff07d 100644
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



