Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E980595AEB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbiHPLzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbiHPLy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:54:57 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62906E2F;
        Tue, 16 Aug 2022 04:33:41 -0700 (PDT)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M6TYM2V3qz67VpW;
        Tue, 16 Aug 2022 19:33:27 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 16 Aug 2022 13:33:39 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 16 Aug 2022 12:33:36 +0100
From:   John Garry <john.garry@huawei.com>
To:     <lenb@kernel.org>, <rafael@kernel.org>, <andy.shevchenko@gmail.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH PoC 1/3] ACPI / PNP: Don't add enumeration_by_parent devices
Date:   Tue, 16 Aug 2022 19:27:22 +0800
Message-ID: <1660649244-146842-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1660649244-146842-1-git-send-email-john.garry@huawei.com>
References: <1660649244-146842-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For ACPI devices with the enumeration_by_parent flag set, we expect the
parent device to enumerate the device after the ACPI scan.

This patch does partially the same for devices which are enumerated as PNP
devices.

We still want PNP scan code to create the per-ACPI device PNP device, but
hold off adding the device to allow the parent to do this optionally.

Flag acpi_device.driver_data is used as temp store as a reference to the
PNP device for the parent.

A note on impact of this change:

For the  hisi_lpc driver, for the UART ACPI node we have a binding like:

 Device (LPC0.CON0) {
    Name (_HID, "HISI1031")
    Name (_CID, "PNP0501")
    Name (LORS, ResourceTemplate() {
      QWordIO (

We have the compat and hid string. The ACPI/PNP code matches the compat
string first, and creates the PNP device. In doing so, the acpi_device
created has physical_node_count member set in acpi_bind_one().

The hisi_lpc driver also creates a platform device serial device for uart,
which is the actual uart which we want to use - see
hisi_lpc_acpi_add_child(). That function does not check
physical_node_count value, but acpi_create_platform_device() does check it.
So if we were to move hisi_lpc_acpi_add_child() across to use
acpi_create_platform_device(), then the change in this patch is required to
not create the PNP binding (so that physical_node_count is not set from
PNP probe).

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/pnp/pnpacpi/core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index 38928ff7472b..b751381b0429 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -272,10 +272,15 @@ static int __init pnpacpi_add_device(struct acpi_device *device)
 	if (!dev->active)
 		pnp_init_resources(dev);
 
-	error = pnp_add_device(dev);
-	if (error) {
-		put_device(&dev->dev);
-		return error;
+
+	if (device->flags.enumeration_by_parent) {
+		device->driver_data = dev;
+	} else {
+		error = pnp_add_device(dev);
+		if (error) {
+			put_device(&dev->dev);
+			return error;
+		}
 	}
 
 	num++;
-- 
2.35.3

