Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A3757FABC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbiGYIAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbiGYIAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:00:08 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D966613CE5;
        Mon, 25 Jul 2022 01:00:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 55B21CE10D4;
        Mon, 25 Jul 2022 08:00:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311B7C341D2;
        Mon, 25 Jul 2022 08:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658736001;
        bh=7HPL7TSph7xHTwSwFr2eiOHKgS3Uzq/+C4Qi1l0Xe+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o7liZPuaHI1qRg0PKIiLRfQuTCCno8X5u0oznAEQuftElgWtko5jHR38a2nm5A5pL
         IDvruIlHGBrHtS4Qocx4CLEo7Bxg6qwmJWabYB+GDZJCCYQceMy4gP30ao6AMYyvke
         23U7AIHk8Rm3FgSdzAB7c9NSgHcNDYOemUxkV8OkrQ2kNagPE8snG/jJwU/OCVgqW5
         AsOwHkdYlz09iv9jcb0OhiHXobP5rYASQq2R+u9E8fyLyZumIeoMIjy1ycfUfAq1f+
         SyP8se2dngo6744xj8uc2bsBw6Tg2r2NChBwGJ1PXs3BKTPfpC7Ssaq7/DQFXDdNmz
         RJ9lnQ0jqIqzA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oFt0e-0000KG-Ec; Mon, 25 Jul 2022 10:00:12 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Yan Xinyu <sdlyyxy@bupt.edu.cn>, linux-staging@lists.linux.dev,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 7/7] USB: serial: usb_wwan: replace DTR/RTS magic numbers with macros
Date:   Mon, 25 Jul 2022 09:58:41 +0200
Message-Id: <20220725075841.1187-8-johan@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220725075841.1187-1-johan@kernel.org>
References: <20220725075841.1187-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yan Xinyu <sdlyyxy@bupt.edu.cn>

The usb_wwan_send_setup function generates DTR/RTS signals in compliance
with CDC ACM standard. This patch changes magic numbers in this function
to equivalent macros.

Signed-off-by: Yan Xinyu <sdlyyxy@bupt.edu.cn>
Link: https://lore.kernel.org/r/20220722085040.704885-1-sdlyyxy@bupt.edu.cn
[ johan: use the new CDC control-line defines ]
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/usb_wwan.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/serial/usb_wwan.c b/drivers/usb/serial/usb_wwan.c
index dab38b63eaf7..6129a6e26f2c 100644
--- a/drivers/usb/serial/usb_wwan.c
+++ b/drivers/usb/serial/usb_wwan.c
@@ -29,6 +29,7 @@
 #include <linux/bitops.h>
 #include <linux/uaccess.h>
 #include <linux/usb.h>
+#include <linux/usb/cdc.h>
 #include <linux/usb/serial.h>
 #include <linux/serial.h>
 #include "usb-wwan.h"
@@ -48,9 +49,9 @@ static int usb_wwan_send_setup(struct usb_serial_port *port)
 	portdata = usb_get_serial_port_data(port);
 
 	if (portdata->dtr_state)
-		val |= 0x01;
+		val |= USB_CDC_CTRL_DTR;
 	if (portdata->rts_state)
-		val |= 0x02;
+		val |= USB_CDC_CTRL_RTS;
 
 	ifnum = serial->interface->cur_altsetting->desc.bInterfaceNumber;
 
@@ -59,8 +60,9 @@ static int usb_wwan_send_setup(struct usb_serial_port *port)
 		return res;
 
 	res = usb_control_msg(serial->dev, usb_sndctrlpipe(serial->dev, 0),
-				0x22, 0x21, val, ifnum, NULL, 0,
-				USB_CTRL_SET_TIMEOUT);
+				USB_CDC_REQ_SET_CONTROL_LINE_STATE,
+				USB_DIR_OUT | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
+				val, ifnum, NULL, 0, USB_CTRL_SET_TIMEOUT);
 
 	usb_autopm_put_interface(port->serial->interface);
 
-- 
2.35.1

