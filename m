Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422B4509C81
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387767AbiDUJpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382102AbiDUJpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:45:33 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88AF245AD;
        Thu, 21 Apr 2022 02:42:44 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id mp16-20020a17090b191000b001cb5efbcab6so7262057pjb.4;
        Thu, 21 Apr 2022 02:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uWPvWJM0Emxp2Wx6FKroXe98tqd593DJ1aphfz514/M=;
        b=Z93YuQXEhlwck4000PqWf35F2YNJVn7kJ3VHLVT5RF3ybfnWBBnpwh2CnGLKVSgveo
         t96dppHHcudvpjQ0D8XKvt+iuUG/IvOxxuk/VXyv2skslF8GDdFnvYd0AUxdMyl26NhY
         tdR1gm5X8/GJhzXbcuJQ/My2s1hqhzcjVDI+NJv9mkcMMNSnqAhqn1bjRZAhkRGhE3yT
         ws+6YkcLINNQ7JhmTS+0R4kZ4pUZMm/BqIdvQkI4ntaHPkON2hstQEQkg9ext6lqDRsJ
         2wNIBzdSLbUAb3Uh/MCmfPNkDy2JXTYUlynoEMMyYNtpmfuEvmupE+pJK1rcUY1kEw+h
         JyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uWPvWJM0Emxp2Wx6FKroXe98tqd593DJ1aphfz514/M=;
        b=K9SYCdnt+hImkfjMa04nswBdQ6a8B+G6DOMoos/z7ImLPdrM6JlwXBUc02ShItQfbM
         SzDAT3hFWYemuDcwU9HbgvphP0b/53nelgI8CaQXoA6Dut5YHgvL/rJQYhh3nOZWoKoH
         T6IOBn3C3WRQRo2hnDzNKhlawnibm3GP2rQCvGSEBYHAvYbaJ1qMa1lM9wF4zAvqT6BN
         JVZRKA2LT0d994AXOPtSrc+/K6gua4YBCHRn6+PwtdOPYO0itf0W8D6pzdAQkqCOa3yI
         iZMXGgduhH+pitrL6PDwfDaXwnHBkf6rdFy7Z1a/19l0oS7nhSOoB92ak0eVS4NLT61g
         lBig==
X-Gm-Message-State: AOAM531K3vpSNTsKB2ddk8wg0JEdEvesxWdPpOgl+7s5eWldHHgKmDgm
        6vVSx28WNU/zwfQ51Wt1wVE=
X-Google-Smtp-Source: ABdhPJw1yOX/giV9vJeKrw94T6dmHSrFlXl04qkd05ZxxOMhE5d3VzmyoAAzgl6hWB60ZTLCu1nX6Q==
X-Received: by 2002:a17:90a:fac:b0:1ca:5eb8:f3b2 with SMTP id 41-20020a17090a0fac00b001ca5eb8f3b2mr9426180pjz.37.1650534164234;
        Thu, 21 Apr 2022 02:42:44 -0700 (PDT)
Received: from localhost ([166.111.139.106])
        by smtp.gmail.com with ESMTPSA id l15-20020a62be0f000000b005059cc9cc34sm23268723pff.92.2022.04.21.02.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 02:42:43 -0700 (PDT)
From:   Zixuan Fu <r33s3n6@gmail.com>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        baijiaju1990@gmail.com, Zixuan Fu <r33s3n6@gmail.com>,
        TOTE Robot <oslab@tsinghua.edu.cn>
Subject: [PATCH] drivers: usb: host: fix NULL pointer dereferences triggered by unhandled errors in xhci_create_rhub_port_array()
Date:   Thu, 21 Apr 2022 17:42:36 +0800
Message-Id: <20220421094236.1052170-1-r33s3n6@gmail.com>
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

Here is the log when this bug occurred in our fault-injection testing:

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

