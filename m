Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998D9574A7F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 12:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238287AbiGNKVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 06:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238284AbiGNKVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 06:21:08 -0400
Received: from smtpproxy21.qq.com (smtpbg703.qq.com [203.205.195.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980E652FF5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 03:21:06 -0700 (PDT)
X-QQ-mid: bizesmtp88t1657794040tri55nzf
Received: from bupt-poweredger310.tendawifi.co ( [223.72.62.230])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 14 Jul 2022 18:20:38 +0800 (CST)
X-QQ-SSF: 01400000002000B0U000B00A0000000
X-QQ-FEAT: ceHWIenCpmAcEGmObNtKCWYmI7KReqwjoh4Um40PllQx1EI97ux5lJTagjUzp
        tItgmTKInP9P/6sanY/2g8JTCvsVxkfjHnclVYVQw//WyzRMMBh5fbB6q1BHSGjcIOmV9Yj
        uiihrghFXDFceqNMR3GYmYKU0ayWmkHW0ZDhmypqy4rBoF79v7hgxucPG3eZiYI0y7JLJZd
        3Q8I1ruNdAERy7yPQKjbKPCq8Y7S31tq8hLOU6Myeo3TYRrnz9W2FQ0CVzZ+eqQx8YwKHg/
        qE5G/fqBJKSpfwEnvadPUCFhl+4SnZzmAe2EHGNBe8MMB4EinKYaQSP8WIn3xA33ML2rBw+
        73gxj31JewVYQ+Vf5las/GetRPooQUgNwuCYSo3rzLnVi3jNqA=
X-QQ-GoodBg: 2
From:   sdlyyxy <sdlyyxy@bupt.edu.cn>
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yan Xinyu <sdlyyxy@bupt.edu.cn>
Subject: [PATCH] USB: serial: option: adding support for OPPO R11 diag port
Date:   Thu, 14 Jul 2022 18:20:37 +0800
Message-Id: <20220714102037.4113889-1-sdlyyxy@bupt.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:bupt.edu.cn:qybgforeign:qybgforeign8
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yan Xinyu <sdlyyxy@bupt.edu.cn>

This patch adds support for OPPO R11 USB diag serial port to option
driver. This phone uses Qualcomm Snapdragon 660 SoC.

usb-devices output:
T:  Bus=03 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#= 10 Spd=480 MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=22d9 ProdID=276c Rev=04.04
S:  Manufacturer=OPPO
S:  Product=SDM660-MTP _SN:09C6BCA7
S:  SerialNumber=beb2c403
C:  #Ifs= 2 Cfg#= 1 Atr=80 MxPwr=500mA
I:  If#=0x0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
I:  If#=0x1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=usbfs

Signed-off-by: Yan Xinyu <sdlyyxy@bupt.edu.cn>
---
 drivers/usb/serial/option.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index de59fa919540..cf65cb84c3ca 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -573,6 +573,10 @@ static void option_instat_callback(struct urb *urb);
 #define WETELECOM_PRODUCT_6802			0x6802
 #define WETELECOM_PRODUCT_WMD300		0x6803
 
+/* OPPO products */
+#define OPPO_VENDOR_ID				0x22d9
+#define OPPO_PRODUCT_R11			0x276c
+
 
 /* Device flags */
 
@@ -2155,6 +2159,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1404, 0xff) },			/* GosunCn GM500 RNDIS */
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1405, 0xff) },			/* GosunCn GM500 MBIM */
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1406, 0xff) },			/* GosunCn GM500 ECM/NCM */
+	{ USB_DEVICE_AND_INTERFACE_INFO(OPPO_VENDOR_ID, OPPO_PRODUCT_R11, 0xff, 0xff, 0x30) },
 	{ } /* Terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, option_ids);
-- 
2.25.1



