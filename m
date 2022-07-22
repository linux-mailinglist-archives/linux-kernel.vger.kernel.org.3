Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB3D57DCE3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 10:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbiGVIwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 04:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235137AbiGVIwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 04:52:24 -0400
Received: from smtpbg501.qq.com (smtpbg501.qq.com [203.205.250.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43239B9C1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 01:51:39 -0700 (PDT)
X-QQ-mid: bizesmtp77t1658479880tvwfy0qv
Received: from bupt-poweredger310.tendawifi.co ( [223.72.68.172])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 22 Jul 2022 16:51:19 +0800 (CST)
X-QQ-SSF: 01400000002000B0V000B00A0000000
X-QQ-FEAT: R3vftN8GVq+7+a8rsE5Vq0K470afRMomw7k6aHZzPiSoUvyVrZmCHCdzV0xCv
        p0ZmVEi6GF60uG4nh2g9hGI9iFdwT30Gs9GNkEgblQDov8iAlzb8OLBZo4qjN9VKnvrat35
        suLSiYTPG4w2R4mNW6h9I5I9WFOU3LzGb34AQE8zDJRxlsF8cUFYj1kbxvgsTRBixYuECSk
        A4q0ZvE66OJFnQdaFxURLXL6ohoBdTtLsR5cz2vp0AqZ/BwW0kinbSEt/Xuc9ni5Ly8CQuz
        rUQM7UI9SLmsGZABTryLaQNd97l0jvCu9lU2BrFAVQuBrJB6msX0APlMJAs8TPmHqbef2QC
        PW+C/9ADbdTkM3ZVp6fbAHbcxF4Urt3JTxOQ0I5Bww5f8ngGpnMTLxF6wQ5CjH86JqOFmZm
        tnalZMBgkZA=
X-QQ-GoodBg: 2
From:   Yan Xinyu <sdlyyxy@bupt.edu.cn>
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yan Xinyu <sdlyyxy@bupt.edu.cn>
Subject: [PATCH v3] USB: serial: usb_wwan: replace DTR/RTS magic numbers with macros
Date:   Fri, 22 Jul 2022 16:50:40 +0800
Message-Id: <20220722085040.704885-1-sdlyyxy@bupt.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:bupt.edu.cn:qybgforeign:qybgforeign10
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_NONE,T_SPF_HELO_TEMPERROR autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usb_wwan_send_setup function generates DTR/RTS signals in compliance
with CDC ACM standard. This patch changes magic numbers in this function
to equivalent macros.

Signed-off-by: Yan Xinyu <sdlyyxy@bupt.edu.cn>
---
v1->v2:
 * Fix Signed-off-by name.
v2->v3:
 * Use already defined ACM_CTRL_DTR and ACM_CTRL_RTS in drivers/usb/class/cdc-acm.h
---
 drivers/usb/serial/usb_wwan.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/serial/usb_wwan.c b/drivers/usb/serial/usb_wwan.c
index dab38b63eaf7..5c8303bd3676 100644
--- a/drivers/usb/serial/usb_wwan.c
+++ b/drivers/usb/serial/usb_wwan.c
@@ -29,8 +29,10 @@
 #include <linux/bitops.h>
 #include <linux/uaccess.h>
 #include <linux/usb.h>
+#include <linux/usb/cdc.h>
 #include <linux/usb/serial.h>
 #include <linux/serial.h>
+#include "../class/cdc-acm.h"
 #include "usb-wwan.h"
 
 /*
@@ -48,9 +50,9 @@ static int usb_wwan_send_setup(struct usb_serial_port *port)
 	portdata = usb_get_serial_port_data(port);
 
 	if (portdata->dtr_state)
-		val |= 0x01;
+		val |= ACM_CTRL_DTR;
 	if (portdata->rts_state)
-		val |= 0x02;
+		val |= ACM_CTRL_RTS;
 
 	ifnum = serial->interface->cur_altsetting->desc.bInterfaceNumber;
 
@@ -59,8 +61,9 @@ static int usb_wwan_send_setup(struct usb_serial_port *port)
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



