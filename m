Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20A457E20F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 15:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbiGVNHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 09:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235413AbiGVNHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 09:07:13 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C74221AF;
        Fri, 22 Jul 2022 06:07:07 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26M9diql007493;
        Fri, 22 Jul 2022 15:06:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=rZGMaCGT+QWwhjB97OshVz0J5bXJNoL0frSiaq3759A=;
 b=bRAxQgZr8ERngjOp2I8pX9zdHP1TkBlCntTzq2f5bNmwqLMGmwCDa4vAW523AzGsd+Jd
 UxSR0Onp2YJL639eme7BSRj5/sdy23/fCdQUgpeYWpktef/kAMdMkMwJ+YktIEV5mjJT
 LpMA7mtyeLIKT7mJIohL3oHr5CDUNjw7cUyBKzSb5wdjq75pkqBPL1D8eUZkQrddVegw
 pusCm5YcS18IYQ5ooBGGx5hVzpTl3emLU7rEr1gdUzEpGeahdWnGXoD28/UrDFa3o6Kv
 uSH9pXYd2mxiD3+cOjGwf6oz4+o22X1k/lRZupXENmy8E7qmHhDHvNViqOZ9BTBsIHhH VA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3hf41ry05x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jul 2022 15:06:40 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 58A42100034;
        Fri, 22 Jul 2022 15:06:40 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 53C18228A4F;
        Fri, 22 Jul 2022 15:06:40 +0200 (CEST)
Received: from localhost (10.75.127.51) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Fri, 22 Jul
 2022 15:06:39 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mka@chromium.org>,
        <alexandre.torgue@foss.st.com>
CC:     <arnd@arndb.de>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <amelie.delaunay@foss.st.com>
Subject: [PATCH 2/4] usb: misc: onboard-hub: add support for Microchip USB2514B USB 2.0 hub
Date:   Fri, 22 Jul 2022 15:05:52 +0200
Message-ID: <20220722130554.236925-3-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220722130554.236925-1-fabrice.gasnier@foss.st.com>
References: <20220722130554.236925-1-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-22_04,2022-07-21_02,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Microchip USB2514B USB 2.0 hub to the onboard usb hub
driver. Adopt the generic usb-device compatible ("usbVID,PID") as
discussed with Matthias in [1].
Some STM32MP1 boards have this hub on-board, with a supply that needs to
be enabled for proper operation.

[1] https://lore.kernel.org/lkml/YW9CUabfA0HrtTAq@google.com/

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/usb/misc/onboard_usb_hub.c | 2 ++
 drivers/usb/misc/onboard_usb_hub.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
index 6b9b949d17d30..929a4e724ec12 100644
--- a/drivers/usb/misc/onboard_usb_hub.c
+++ b/drivers/usb/misc/onboard_usb_hub.c
@@ -310,6 +310,7 @@ static struct platform_driver onboard_hub_driver = {
 /************************** USB driver **************************/
 
 #define VENDOR_ID_REALTEK	0x0bda
+#define VENDOR_ID_MICROCHIP	0x0424
 
 /*
  * Returns the onboard_hub platform device that is associated with the USB
@@ -387,6 +388,7 @@ static const struct usb_device_id onboard_hub_id_table[] = {
 	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x5411) }, /* RTS5411 USB 2.1 */
 	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x0414) }, /* RTS5414 USB 3.2 */
 	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x5414) }, /* RTS5414 USB 2.1 */
+	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x2514) }, /* USB2514B USB 2.0 */
 	{}
 };
 MODULE_DEVICE_TABLE(usb, onboard_hub_id_table);
diff --git a/drivers/usb/misc/onboard_usb_hub.h b/drivers/usb/misc/onboard_usb_hub.h
index d3a5b6938582e..43d6af4230dfd 100644
--- a/drivers/usb/misc/onboard_usb_hub.h
+++ b/drivers/usb/misc/onboard_usb_hub.h
@@ -11,6 +11,7 @@ static const struct of_device_id onboard_hub_match[] = {
 	{ .compatible = "usbbda,5411" },
 	{ .compatible = "usbbda,414" },
 	{ .compatible = "usbbda,5414" },
+	{ .compatible = "usb424,2514" },
 	{}
 };
 
-- 
2.25.1

