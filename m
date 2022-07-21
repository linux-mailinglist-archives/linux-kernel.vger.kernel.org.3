Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D889C57CED1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 17:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbiGUPYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 11:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiGUPYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 11:24:42 -0400
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C64E77549
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 08:24:40 -0700 (PDT)
X-QQ-mid: bizesmtp79t1658417062tfjqni0v
Received: from bupt-poweredger310.tendawifi.co ( [223.72.68.172])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 21 Jul 2022 23:24:21 +0800 (CST)
X-QQ-SSF: 01400000002000B0V000B00A0000000
X-QQ-FEAT: +ynUkgUhZJmISFXXJgcf6XRptELTs4eaFM5N1f9J+Hjr8cNKPdLcpC0vmUuVp
        v1CpJg8kuQIYl5AsDGlv1oUI3UbRdg0dYslilRdgXj6QV8js4Z9jXU16Q/DZ5LYXA6Pe7FT
        qacxECwoSWF5xwcxzXDcR81S5i+BstsT59kXBsuGOj6j62VeSRO0QNurQZ61gWIP02Z39XR
        /Q4pOaDUcQ9izmbh8y+q8OaU7O/Gq6nmSPHif+AFq4pP4TtABwlBDkrJd3JpWi+KTmDqEjI
        RNdBbMYAhLn8EzrezKZopCd1Un7cqT1eiSZAgUTynSvUYnh40iNuolvLrL2UPHzsKg/5omx
        wXoTHjb92gEuqrerpnRH3gtDp2qY2oWY/B3Y0IPz3w4zS5or8EDSqIy7QIvtw==
X-QQ-GoodBg: 2
From:   sdlyyxy <sdlyyxy@bupt.edu.cn>
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        sdlyyxy <sdlyyxy@bupt.edu.cn>
Subject: [PATCH] USB: serial: usb_wwan: replace DTR/RTS magic numbers with macros
Date:   Thu, 21 Jul 2022 23:23:35 +0800
Message-Id: <20220721152335.629105-1-sdlyyxy@bupt.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:bupt.edu.cn:qybgforeign:qybgforeign10
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usb_wwan_send_setup function generates DTR/RTS signals in compliance
with CDC ACM standard. This patch changes magic numbers in this function
to equivalent macros.

Signed-off-by: sdlyyxy <sdlyyxy@bupt.edu.cn>
---
 drivers/usb/serial/usb_wwan.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/serial/usb_wwan.c b/drivers/usb/serial/usb_wwan.c
index dab38b63eaf7..a6bd6144702d 100644
--- a/drivers/usb/serial/usb_wwan.c
+++ b/drivers/usb/serial/usb_wwan.c
@@ -29,10 +29,14 @@
 #include <linux/bitops.h>
 #include <linux/uaccess.h>
 #include <linux/usb.h>
+#include <linux/usb/cdc.h>
 #include <linux/usb/serial.h>
 #include <linux/serial.h>
 #include "usb-wwan.h"
 
+#define ACM_CTRL_DTR 0x01
+#define ACM_CTRL_RTS 0x02
+
 /*
  * Generate DTR/RTS signals on the port using the SET_CONTROL_LINE_STATE request
  * in CDC ACM.
@@ -48,9 +52,9 @@ static int usb_wwan_send_setup(struct usb_serial_port *port)
 	portdata = usb_get_serial_port_data(port);
 
 	if (portdata->dtr_state)
-		val |= 0x01;
+		val |= ACM_CTRL_DTR;
 	if (portdata->rts_state)
-		val |= 0x02;
+		val |= ACM_CTRL_RTS;
 
 	ifnum = serial->interface->cur_altsetting->desc.bInterfaceNumber;
 
@@ -59,8 +63,9 @@ static int usb_wwan_send_setup(struct usb_serial_port *port)
 		return res;
 
 	res = usb_control_msg(serial->dev, usb_sndctrlpipe(serial->dev, 0),
-				0x22, 0x21, val, ifnum, NULL, 0,
-				USB_CTRL_SET_TIMEOUT);
+				USB_CDC_REQ_SET_CONTROL_LINE_STATE,
+				USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
+				val, ifnum, NULL, 0, USB_CTRL_SET_TIMEOUT);
 
 	usb_autopm_put_interface(port->serial->interface);
 
-- 
2.25.1



