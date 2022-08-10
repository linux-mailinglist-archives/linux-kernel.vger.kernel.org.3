Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BB358E584
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 05:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiHJDbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 23:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiHJDbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 23:31:11 -0400
Received: from mail-m974.mail.163.com (mail-m974.mail.163.com [123.126.97.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6CB88647D5;
        Tue,  9 Aug 2022 20:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=hutXp
        zbz3ycXiFVFW359iTdKNjzIv+tMrHdsrJdOXBw=; b=Wx2HCOZkO4WzqPP+VuMnf
        6PtowGyBWWHdtM++5+BdHp48hco31IXljf3xQzhKdJQFfT+oDyEMlZ0Wf8FGT6/J
        89PIRGeXDSWWnALU4nOy/+xzAlRpIOAafXzR+AqEmlV6k8NPHyZqv9+gJ2oNhFlW
        loFt8jtR5Jt2HRoDT/dbHc=
Received: from localhost.localdomain (unknown [112.97.63.65])
        by smtp4 (Coremail) with SMTP id HNxpCgB34tJvJvNiL3QhUQ--.1365S2;
        Wed, 10 Aug 2022 11:30:57 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] USB: serial: option: add support for Cinterion MV32-WA/WB RmNet mode
Date:   Wed, 10 Aug 2022 11:30:50 +0800
Message-Id: <20220810033050.3117-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgB34tJvJvNiL3QhUQ--.1365S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWF4Uuw4rCF1UtFyxJr1UKFg_yoW5XF1xpF
        WYyFW3ZFWUXwsxXF1DtFn3ZF95uwsrK3yI93ZrAanIvFyxArnFg34Ut3yxZF12gw1SgrsF
        vrs8K34UGa98J37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zKXdrbUUUUU=
X-Originating-IP: [112.97.63.65]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiGRFZZFyPd3BYawAAsS
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We added PIDs for MV32-WA/WB MBIM mode before, now we need to add
support for RmNet mode.

Test evidence as below:
T:  Bus=03 Lev=01 Prnt=01 Port=02 Cnt=03 Dev#=  3 Spd=480 MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=1e2d ProdID=00f3 Rev=05.04
S:  Manufacturer=Cinterion
S:  Product=Cinterion PID 0x00F3 USB Mobile Broadband
S:  SerialNumber=d7b4be8d
C:  #Ifs= 4 Cfg#= 1 Atr=a0 MxPwr=500mA
I:  If#=0x0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=50 Driver=qmi_wwan
I:  If#=0x1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
I:  If#=0x2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
I:  If#=0x3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option

T:  Bus=03 Lev=01 Prnt=01 Port=02 Cnt=03 Dev#= 10 Spd=480 MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=1e2d ProdID=00f4 Rev=05.04
S:  Manufacturer=Cinterion
S:  Product=Cinterion PID 0x00F4 USB Mobile Broadband
S:  SerialNumber=d095087d
C:  #Ifs= 4 Cfg#= 1 Atr=a0 MxPwr=500mA
I:  If#=0x0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=50 Driver=qmi_wwan
I:  If#=0x1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
I:  If#=0x2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
I:  If#=0x3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/usb/serial/option.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index de59fa919540..63af8b48831a 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -438,6 +438,8 @@ static void option_instat_callback(struct urb *urb);
 #define CINTERION_PRODUCT_MV31_2_RMNET		0x00b9
 #define CINTERION_PRODUCT_MV32_WA		0x00f1
 #define CINTERION_PRODUCT_MV32_WB		0x00f2
+#define CINTERION_PRODUCT_MV32_WA_RMNET		0x00f3
+#define CINTERION_PRODUCT_MV32_WB_RMNET		0x00f4
 
 /* Olivetti products */
 #define OLIVETTI_VENDOR_ID			0x0b3c
@@ -1995,6 +1997,10 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(3)},
 	{ USB_DEVICE_INTERFACE_CLASS(CINTERION_VENDOR_ID, CINTERION_PRODUCT_MV32_WB, 0xff),
 	  .driver_info = RSVD(3)},
+	{ USB_DEVICE_INTERFACE_CLASS(CINTERION_VENDOR_ID, CINTERION_PRODUCT_MV32_WA_RMNET, 0xff),
+	  .driver_info = RSVD(0)},
+	{ USB_DEVICE_INTERFACE_CLASS(CINTERION_VENDOR_ID, CINTERION_PRODUCT_MV32_WB_RMNET, 0xff),
+	  .driver_info = RSVD(0)},
 	{ USB_DEVICE(OLIVETTI_VENDOR_ID, OLIVETTI_PRODUCT_OLICARD100),
 	  .driver_info = RSVD(4) },
 	{ USB_DEVICE(OLIVETTI_VENDOR_ID, OLIVETTI_PRODUCT_OLICARD120),
-- 
2.25.1

