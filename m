Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1AE050A0F7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 15:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381398AbiDUNmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 09:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbiDUNmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:42:07 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E031B36E37;
        Thu, 21 Apr 2022 06:39:17 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id b7so4901950plh.2;
        Thu, 21 Apr 2022 06:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4R456a2EKx3/Cjhoycmuudv2QP7/h6tZBuPXNUpi9fk=;
        b=aY6zKoJKeP9CN9vhlxFk2pWZrfR1jzOeVJ1arkhqsuE3RRLxQm16iBaWX8DJVnMABM
         3/1QoQWIu1D1b1coWR6N3xwQHJPD/i5ZVgAmhvjHXmYg0xA6EUv5BNv4h+5MFiehNm5A
         8TIcoDKBgYLJ9U35xmwu9M5U6EbaY8fu31HAhvSO4wkqD1R4NmBOUv0k8udHIifxAVI0
         P0MJs4YqDUXYh6WkkAzktPp5XSKoojxRYcolydFfI3HsGrghxK3UQ58WnKE1Jq8grug3
         DTETxoSXIXcCK2ehpFpRvECCiMuXKvsNotoicrVOM/HfJs/otkb7FrYJJdUtbgxf/+3g
         Zo7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4R456a2EKx3/Cjhoycmuudv2QP7/h6tZBuPXNUpi9fk=;
        b=JjvZ2Ak6ToptgejxNf1tQ18JXOuszmG+kqxeRRTx3aFZu1jqXRMDpScn9+8g/QnQYI
         I1Iy3ISvikPkpR26StF/VIweTBI8v0Nu9uimAiJNbCvdKqE3eFTyRsE0yqroOj+lhJq1
         zRHFs/yCG9F0cX7D22nQ0iwjw2gylOx1s6gnzR1ESxvmt7QQCMEc6FJgkMG35a/U9C0A
         X4n5HhN8LrmxTLcItHOPiSnLKxuxi6lPJwnamvirrdXdKFEKK7UzPUtFYWld5iGXvVSS
         wNCmDfaO0exzPEz8E50G9hxxQ5gl/wBZFOHvgbTGxLWRrwxVUHcMUYX2J2IqdUzAZbNH
         PFrA==
X-Gm-Message-State: AOAM530oRfENmMAX4psCgehRpJFz63fwg14pZ4NB2qk5TjJeOrAW9Qez
        fKJ1VFcCTEFNsy97TO4ykDE=
X-Google-Smtp-Source: ABdhPJzPpQ85QGBwdNYl9etr95TwZtPTx+MNyKe7AJV1BfwZeiO1aUHsvfyomdkNEC1hoOk2xONEXw==
X-Received: by 2002:a17:903:11c7:b0:154:b936:d1d4 with SMTP id q7-20020a17090311c700b00154b936d1d4mr25980651plh.78.1650548357372;
        Thu, 21 Apr 2022 06:39:17 -0700 (PDT)
Received: from localhost ([166.111.139.106])
        by smtp.gmail.com with ESMTPSA id o12-20020a17090aac0c00b001cd4989ff41sm2646989pjq.8.2022.04.21.06.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 06:39:16 -0700 (PDT)
From:   Zixuan Fu <r33s3n6@gmail.com>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        baijiaju1990@gmail.com, Zixuan Fu <r33s3n6@gmail.com>,
        TOTE Robot <oslab@tsinghua.edu.cn>
Subject: [PATCH v2] drivers: usb: host: fix NULL pointer dereferences triggered by unhandled errors in xhci_create_rhub_port_array()
Date:   Thu, 21 Apr 2022 21:39:02 +0800
Message-Id: <20220421133902.1132063-1-r33s3n6@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In xhci_create_rhub_port_array(), when rhub->num_ports is zero, 
rhub->ports would not be set; when kcalloc_node() fails, rhub->ports
would be set to NULL. In these two cases, xhci_create_rhub_port_array()
just returns void, and thus its callers are unaware of the error.

Then rhub->ports is dereferenced in xhci_usb3_hub_descriptor() or 
xhci_usb2_hub_descriptor().

To fix the bug, xhci_setup_port_arrays() should return an integer to 
indicate a possible error, and its callers should handle the error.

In the driver, xhci_create_rhub_port_array() is only used in 
xhci_setup_port_arrays(), and only xhci_mem_init() calls
xhci_setup_port_arrays() and does all cleanup work when it fails.
Specifically, xhci_mem_init() calls xhci_mem_cleanup(), which eventually
calls kfree(xhci->usb2_rhub.ports) and kfree(xhci->usb3_rhub.ports). For
this reason, when xhci_create_rhub_port_array() fails, 
xhci_setup_port_arrays() should return the error code directly, without
freeing the memory allocated in this function.

The error log in our fault-injection testing is shown as follows:

[   24.001309] BUG: kernel NULL pointer dereference, address: 0000000000000000
...
[   24.003992] RIP: 0010:xhci_hub_control+0x3f5/0x60d0 [xhci_hcd]
...
[   24.009803] Call Trace:
[   24.010014]  <TASK>
[   24.011310]  usb_hcd_submit_urb+0x1233/0x1fd0
[   24.017071]  usb_start_wait_urb+0x115/0x310
[   24.017641]  usb_control_msg+0x28a/0x450
[   24.019046]  hub_probe+0xb16/0x2320
[   24.019757]  usb_probe_interface+0x4f1/0x930
[   24.019765]  really_probe+0x33d/0x970
[   24.019768]  __driver_probe_device+0x157/0x210
[   24.019772]  driver_probe_device+0x4f/0x340
[   24.019775]  __device_attach_driver+0x2ee/0x3a0
...

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Zixuan Fu <r33s3n6@gmail.com>
---
v2:
* Explain the reason why xhci_setup_port_arrays() returns without freeing the memory in error handling code.
  Thank Greg KH for helpful advice.
---
 drivers/usb/host/xhci-mem.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index bbb27ee2c6a3..024515346c39 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -2235,7 +2235,7 @@ static void xhci_add_in_port(struct xhci_hcd *xhci, unsigned int num_ports,
 	/* FIXME: Should we disable ports not in the Extended Capabilities? */
 }
 
-static void xhci_create_rhub_port_array(struct xhci_hcd *xhci,
+static int xhci_create_rhub_port_array(struct xhci_hcd *xhci,
 					struct xhci_hub *rhub, gfp_t flags)
 {
 	int port_index = 0;
@@ -2243,11 +2243,11 @@ static void xhci_create_rhub_port_array(struct xhci_hcd *xhci,
 	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
 
 	if (!rhub->num_ports)
-		return;
+		return -EINVAL;
 	rhub->ports = kcalloc_node(rhub->num_ports, sizeof(*rhub->ports),
 			flags, dev_to_node(dev));
 	if (!rhub->ports)
-		return;
+		return -ENOMEM;
 
 	for (i = 0; i < HCS_MAX_PORTS(xhci->hcs_params1); i++) {
 		if (xhci->hw_ports[i].rhub != rhub ||
@@ -2259,6 +2259,7 @@ static void xhci_create_rhub_port_array(struct xhci_hcd *xhci,
 		if (port_index == rhub->num_ports)
 			break;
 	}
+	return 0;
 }
 
 /*
@@ -2277,6 +2278,7 @@ static int xhci_setup_port_arrays(struct xhci_hcd *xhci, gfp_t flags)
 	int cap_count = 0;
 	u32 cap_start;
 	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
+	int ret;
 
 	num_ports = HCS_MAX_PORTS(xhci->hcs_params1);
 	xhci->hw_ports = kcalloc_node(num_ports, sizeof(*xhci->hw_ports),
@@ -2367,8 +2369,13 @@ static int xhci_setup_port_arrays(struct xhci_hcd *xhci, gfp_t flags)
 	 * Not sure how the USB core will handle a hub with no ports...
 	 */
 
-	xhci_create_rhub_port_array(xhci, &xhci->usb2_rhub, flags);
-	xhci_create_rhub_port_array(xhci, &xhci->usb3_rhub, flags);
+	ret = xhci_create_rhub_port_array(xhci, &xhci->usb2_rhub, flags);
+	if (ret)
+		return ret;
+
+	ret = xhci_create_rhub_port_array(xhci, &xhci->usb3_rhub, flags);
+	if (ret)
+		return ret;
 
 	return 0;
 }
-- 
2.25.1

