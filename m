Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9393248903C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 07:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239052AbiAJGfx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Jan 2022 01:35:53 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:51113 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239038AbiAJGfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 01:35:47 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-674-wqWs10RDN0iqQO3K92HJVQ-1; Mon, 10 Jan 2022 01:35:42 -0500
X-MC-Unique: wqWs10RDN0iqQO3K92HJVQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F73C81CCB4;
        Mon, 10 Jan 2022 06:35:41 +0000 (UTC)
Received: from bzdocha.local (unknown [10.43.2.81])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C3E85E4A3;
        Mon, 10 Jan 2022 06:35:22 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] platform/x86: x86-android-tablets: Fix the buttons on CZC P10T tablet
Date:   Mon, 10 Jan 2022 07:35:12 +0100
Message-Id: <20220110063512.273252-1-lkundrak@v3.sk>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lkundrak@v3.sk
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: v3.sk
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This switches the P10T tablet to "Android" mode, where the Home button
sends a single sancode instead of a Windows-specific key combination and
the other button doesn't disable the Wi-Fi.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
This applies on top of v5.16-rc8-792-gf3a343366741, commit
f3a3433667418e ("platform/x86: x86-android-tablets: Workaround Lenovo
Yoga Tablet 2 1050 poweroff hang) from
<https://github.com/jwrdegoede/linux-sunxi>.

 drivers/platform/x86/x86-android-tablets.c | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/platform/x86/x86-android-tablets.c b/drivers/platform/x86/x86-android-tablets.c
index 9333bbec33e9..c3d0714b588a 100644
--- a/drivers/platform/x86/x86-android-tablets.c
+++ b/drivers/platform/x86/x86-android-tablets.c
@@ -776,6 +776,39 @@ static const struct x86_dev_info xiaomi_mipad2_info __initconst = {
 	.i2c_client_count = ARRAY_SIZE(xiaomi_mipad2_i2c_clients),
 };
 
+#define CZC_EC_EXTRA_PORT	0x68
+#define CZC_EC_ANDROID_KEYS	0x63
+
+static int __init x86_czc_p10t_init(void)
+{
+	/*
+	 * The device boots up in "Windows 7" mode, when the home button sends a
+	 * Windows specific key sequence (Left Meta + D) and the second button
+	 * sends an unknown one while also toggling the Radio Kill Switch.
+	 * This is a surprising behavior when the second button is labeled "Back".
+	 *
+	 * The vendor-supplied Android-x86 build switches the device to a "Android"
+	 * mode by writing value 0x63 to the I/O port 0x68. This just seems to just
+	 * set bit 6 on address 0x96 in the EC region; switching the bit directly
+	 * seems to achieve the same result. It uses a "p10t_switcher" to do the
+	 * job. It doesn't seem to be able to do anything else, and no other use
+	 * of the port 0x68 is known.
+	 *
+	 * In the Android mode, the home button sends just a single scancode,
+	 * which can be handled in Linux userspace more reasonably and the back
+	 * button only sends a scancode without toggling the kill switch.
+	 * The scancode can then be mapped either to Back or RF Kill functionality
+	 * in userspace, depending on how the button is labeled on that particular
+	 * model.
+	 */
+	outb(CZC_EC_ANDROID_KEYS, CZC_EC_EXTRA_PORT);
+	return 0;
+}
+
+static const struct x86_dev_info czc_p10t __initconst = {
+	.init = x86_czc_p10t_init,
+};
+
 static const struct dmi_system_id x86_android_tablet_ids[] __initconst = {
 	{
 		/* Asus MeMO Pad 7 ME176C */
@@ -803,6 +836,24 @@ static const struct dmi_system_id x86_android_tablet_ids[] __initconst = {
 		},
 		.driver_data = (void *)&chuwi_hi8_info,
 	},
+	{
+		/* CZC P10T */
+		.ident = "CZC ODEON TPC-10 (\"P10T\")",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "CZC"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ODEON*TPC-10"),
+		},
+		.driver_data = (void *)&czc_p10t,
+	},
+	{
+		/* A variant of CZC P10T */
+		.ident = "ViewSonic ViewPad 10",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ViewSonic"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "VPAD10"),
+		},
+		.driver_data = (void *)&czc_p10t,
+	},
 	{
 		/* Lenovo Yoga Tablet 1050F/L */
 		.matches = {
-- 
2.34.1

