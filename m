Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F244AB27F
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 22:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244514AbiBFV4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 16:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiBFV4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 16:56:44 -0500
X-Greylist: delayed 456 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 13:56:37 PST
Received: from mail.cock.li (unknown [37.120.193.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5100EC06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 13:56:37 -0800 (PST)
From:   sp1rit@national.shitposting.agency
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=national.shitposting.agency; s=mail; t=1644184131;
        bh=AFyXmb3Qmo+O1oT3L0ERbzAp+sekOtF9ZDbLiFnEncY=;
        h=From:To:Cc:Subject:Date:From;
        b=HK6lsGpFjZvdUVWnvkR9WypH1a57nFlzmHGfHxW5XMbk9KMqg72I2qodk8hBiWBiK
         dyTmNUSof9pPK2xmIbqvptu/m2LbYHzOm1nAfi0vpnm8OzKbgYMDAZS15CxT6SLxdB
         5hKuQ1DvyCclzlS+IzjILZ6hI4gEZ8sDvzUO1mcj39PvXLlLZBF/mutaq900vukzOm
         +5I1tfC0SaLOeOfCcmD3dnVZWJyaxodjn6q1G9KCPb3SU0ZT8X4GMGAZrtgqwDXbsU
         gqRVrnxwaxOVnqG0U7EGZmDO7yZ9YtkZ9B37moJEx+DxKZqxfPIJUmq5ozWcpRS7Yv
         j1kKJXJzwUwtg==
To:     linux-kernel@vger.kernel.org
Cc:     jdelvare@suse.com,
        =?UTF-8?q?Florian=20=22sp1rit=22=E2=80=8B?= <sp1rit@disroot.org>
Subject: [PATCH RESEND] firmware/dmi: Allow overriding vendor provided DMIIDs
Date:   Sun,  6 Feb 2022 22:43:46 +0100
Message-Id: <20220206214345.31214-1-sp1rit@national.shitposting.agency>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian "sp1rit"​ <sp1rit@disroot.org>

Resend, because the my first attempt bounced, as disroot.org is
appearently "liked source for email" :/. Let's hope that it works
this time (and sorry for sending the same mail twice Jean Delvare).


Various device vendors do not properly fill out the SMBIOS/DMI
information in the bios firmware of their devices. This leads to
issues, like finding "System manufacturer System Product Name" under
"Hardware Information" in GNOME Settings, which made it's way there
(over a few dbus detours) from DMIIDs provided from the kernel.

This patch intoduces a handful kernel parameters that allow
overriding these values with user defined ones, similar to changing
values in HKLM\HARDWARE\DESCRPTION\System\Bios or
$WINDIR/system32/OEMINFO.ini on Microsoft Windows.

The alternative would either be patching the vendor provided bios
CAP file, which seems quite dangerous and might not even work if
the update has to be signed. Or introducing some kind of
configuration file to systemd-hostnamed to allow the overriding of
the values from userspace. However that might work for this usecase,
but most software will not use hostnamed, since simply reading a
file is a lot simpler that having to rely on dbus to query system
information.

Please note that I've never written kernel code before, so please
forgive any mistakes I might have done :).

Signed-off-by: Florian "sp1rit"​ <sp1rit@disroot.org>
---
 .../admin-guide/kernel-parameters.rst         |  1 +
 .../admin-guide/kernel-parameters.txt         |  9 +++++
 drivers/firmware/dmi-id.c                     | 35 +++++++++++++++++--
 3 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
index 01ba293a2..7f1cb5029 100644
--- a/Documentation/admin-guide/kernel-parameters.rst
+++ b/Documentation/admin-guide/kernel-parameters.rst
@@ -104,6 +104,7 @@ parameter is applicable::
 	AX25	Appropriate AX.25 support is enabled.
 	CLK	Common clock infrastructure is enabled.
 	CMA	Contiguous Memory Area support is enabled.
+	DMIID	Exporting DMI identification is enabled.
 	DRM	Direct Rendering Management support is enabled.
 	DYNAMIC_DEBUG Build in debug messages and enable them at runtime
 	EDD	BIOS Enhanced Disk Drive Services (EDD) is enabled
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f5a27f067..f52a8592f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1044,6 +1044,15 @@
 			pass the driver to filter for as the parameter.
 			The filter can be disabled or changed to another
 			driver later using sysfs.
+	
+	dmi_<name>=<value>	[DMIID]
+			Used to override SMBIOS/DMI system identification
+			information provided by your device vendor that is
+			exposed to userspace through /sys/class/dmi/id/.
+			<name> hereby represents the name of the id being
+			exposed (i.e. product_name, chassis_vendor or
+			sys_vendor) and <value> being the string replacing
+			the vendor provided value.
 
 	driver_async_probe=  [KNL]
 			List of driver names to be probed asynchronously.
diff --git a/drivers/firmware/dmi-id.c b/drivers/firmware/dmi-id.c
index 940ddf916..14ffde244 100644
--- a/drivers/firmware/dmi-id.c
+++ b/drivers/firmware/dmi-id.c
@@ -12,6 +12,31 @@
 #include <linux/device.h>
 #include <linux/slab.h>
 
+static char* dmi_override[DMI_STRING_MAX] = { NULL };
+
+core_param(dmi_bios_vendor, dmi_override[DMI_BIOS_VENDOR], charp, 0440);
+core_param(dmi_bios_version, dmi_override[DMI_BIOS_VERSION], charp, 0440);
+core_param(dmi_bios_date, dmi_override[DMI_BIOS_DATE], charp, 0440);
+core_param(dmi_sys_vendor, dmi_override[DMI_SYS_VENDOR], charp, 0440);
+core_param(dmi_bios_release, dmi_override[DMI_BIOS_RELEASE], charp, 0440);
+core_param(dmi_ec_firmware_release, dmi_override[DMI_EC_FIRMWARE_RELEASE], charp, 0440);
+core_param(dmi_product_name, dmi_override[DMI_PRODUCT_NAME], charp, 0440);
+core_param(dmi_product_version, dmi_override[DMI_PRODUCT_VERSION], charp, 0440);
+core_param(dmi_product_serial, dmi_override[DMI_PRODUCT_SERIAL], charp, 0440);
+core_param(dmi_product_uuid, dmi_override[DMI_PRODUCT_UUID], charp, 0440);
+core_param(dmi_product_sku, dmi_override[DMI_PRODUCT_SKU], charp, 0440);
+core_param(dmi_product_family, dmi_override[DMI_PRODUCT_FAMILY], charp, 0440);
+core_param(dmi_board_vendor, dmi_override[DMI_BOARD_VENDOR], charp, 0440);
+core_param(dmi_board_name, dmi_override[DMI_BOARD_NAME], charp, 0440);
+core_param(dmi_board_version, dmi_override[DMI_BOARD_VERSION], charp, 0440);
+core_param(dmi_board_serial, dmi_override[DMI_BOARD_SERIAL], charp, 0440);
+core_param(dmi_board_asset_tag, dmi_override[DMI_BOARD_ASSET_TAG], charp, 0440);
+core_param(dmi_chassis_vendor, dmi_override[DMI_CHASSIS_VENDOR], charp, 0440);
+core_param(dmi_chassis_type, dmi_override[DMI_CHASSIS_TYPE], charp, 0440);
+core_param(dmi_chassis_version, dmi_override[DMI_CHASSIS_VERSION], charp, 0440);
+core_param(dmi_chassis_serial, dmi_override[DMI_CHASSIS_SERIAL], charp, 0440);
+core_param(dmi_chassis_asset_tag, dmi_override[DMI_CHASSIS_ASSET_TAG], charp, 0440);
+
 struct dmi_device_attribute{
 	struct device_attribute dev_attr;
 	int field;
@@ -23,9 +48,15 @@ static ssize_t sys_dmi_field_show(struct device *dev,
 				  struct device_attribute *attr,
 				  char *page)
 {
-	int field = to_dmi_dev_attr(attr)->field;
+	const char* value;
 	ssize_t len;
-	len = scnprintf(page, PAGE_SIZE, "%s\n", dmi_get_system_info(field));
+
+	int field = to_dmi_dev_attr(attr)->field;
+	if (dmi_override[field])
+		value = dmi_override[field];
+	else
+		value = dmi_get_system_info(field);
+	len = scnprintf(page, PAGE_SIZE, "%s\n", value);
 	page[len-1] = '\n';
 	return len;
 }
-- 
2.35.1

