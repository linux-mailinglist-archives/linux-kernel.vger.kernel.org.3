Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961FB562917
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 04:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbiGACeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 22:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbiGACdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 22:33:41 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7530B61D5B;
        Thu, 30 Jun 2022 19:33:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izqvq9cHhJjEDHs3SWrxpv7vwXXRNwqN+rLTrwwZxuDouYpwYXJOMWOA2fjvIKWSohfRfZ1p9PfHSVjHAwOFdgVge/41MKvx7sRSjRsiPpc5Wux0SzNfnQV8Nxnjuujn4SBFy9G6OkE1FV7qVrT2vKGdLyRwJ6Ykxu9qeMNLYm1BrnvAPuahJaQfyTr9bXCIx+9PzeOaK+gbLw3S3wQ0vKF7hCvUCdQfIwfW1Wtb+3qlroEGiJp8IAPZTMUU4elPLS4YJnNFBW7KGcWK8iIPbbeCYXS/FY7CXBYObssqKmWGZaRXWCJg8Lffc+HqQBbg2P02yf1e9Sd96yu7/624IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ds5u4rRkCsRMI2FUO2XS3EpFLNvC4Pj9U42rUkxWM/k=;
 b=fkQbySNm45E5zxUrItbsQV4xdkGngb4y+fIOQrDACGooBeboe40jXV70breTp5B0rYZs5uEidl+zJBd1Wy+wKbGq52eHCwb++7hKleLR0ppW5Jl8Ixn2P0+H+UgPWLGX+faZ1kKylPZBDW6BzDvqofG5WXFk4zm62PD3NtL9wvt3u9yhvZFa9Qg35+3sJA4f16/YWXj4/40t8ovypWKP+tYjQF0omVxgvwEW0AqjkC/j7KmbRQ2nMp/1+qRUXpaxYkpA6128O8K33o0Ai2r7xK17vAUGzefnyvLwIYI4q6IcXodGMQYaRK/gKY0M2LC8PospZ9ZcVqbLMfmFmNL4NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ds5u4rRkCsRMI2FUO2XS3EpFLNvC4Pj9U42rUkxWM/k=;
 b=n7hZv++FMBIu0EAndacMX23CPmveYB69trHdKdBpcLnVLk8R0Zc4yg2hkGQOf7eVUFeF0LCcRiVIl9wYaT+xPaErOuJ1SomZUD7V5PY2FbPlgO1TGylcHivASA78kld1QyPuyb5MwQLTZe0/6eG15JDUUBepY82xFjt8qxmj3xo=
Received: from BN9PR03CA0237.namprd03.prod.outlook.com (2603:10b6:408:f8::32)
 by SJ0PR12MB5422.namprd12.prod.outlook.com (2603:10b6:a03:3ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Fri, 1 Jul
 2022 02:33:36 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::e6) by BN9PR03CA0237.outlook.office365.com
 (2603:10b6:408:f8::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Fri, 1 Jul 2022 02:33:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Fri, 1 Jul 2022 02:33:36 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 21:33:35 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>, Jiri Kosina <jikos@kernel.org>,
        "Benjamin Tissoires" <benjamin.tissoires@redhat.com>
CC:     <linux-pm@vger.kernel.org>, Richard Gong <richard.gong@amd.com>,
        <linux-usb@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 10/10] HID: usbhid: Set USB mice as s2idle wakeup resources
Date:   Thu, 30 Jun 2022 21:33:28 -0500
Message-ID: <20220701023328.2783-10-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220701023328.2783-1-mario.limonciello@amd.com>
References: <20220701023328.2783-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7172b8b2-510d-4aed-9d1a-08da5b0a199e
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5422:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wBthxZMrcknrwZ8V48kPMITVyjClYaWzR5pCmM6C8rizbZ6gARP3+vvGWc/V4bLIetv1nD5cax4y5bwyfQceWGckD4LFdpk8sEbU2f/YYIIEEgLujuumreJrAgedaTJzUj+zi+ownsDs7pBXx5KqN2Tz2N+baHVo40Kqpncw0flC+n1ehCtwfbLeIjU8mpnj6ETPP33S4tRWKiSFwHhFp6qtnLDWVL7ntr2XsYKtbFJ4m5jW5MwysFTBN0gzdXd9doy2YItAwd0QgWr3QI+V9SYp1nw795AYm1NmNbuVpdrrI3vNyZvJoU9GRYQe9j1Z/2N/14/epCIiVL8YXixKuRoumSz4I8lr/2vOLyoBCuM4J00JZC9Gmf/IxbiFueopneSf5HODj0nbpbdHaw3fNDWMISQ6iZLiXBJWCkgaseRwvkwsIIbVBVmuMf5kqGF6RwSqsUMCodNI9gbwBQ+MNFnxPSkhWkQ5n+/d2cesIOeHQAvI+HA1LpQ7qYjpGItsWx1cEyNpQ0F64qkxYWRavaiP3UK/LUwXgZaFwG5ZQKxe0uSzBRGkmDeeystkGMIltskR1Z3jGU/ujK4/vemWm9Q5i76jw76Z9MtxHsRMBMR217Ym39Z5sFZ6bRYwRUYAn9w6ipAUi8kG2wow1k5ANt/nsUFSn+uZ+1b0aWAzXwr+wF+OH9+aEmKhPVpRG35bkV5ZLAZyb3yuUSwqDJE+Tp+JllJ5ZMr2RxxuDyh3wxkPjiTV+Y4LczkngYvIOq+hMp7nN3p3umAEDadtRlWtHAcJ6kBLz1ANSPFhLH8Xe3S0XVckKEbKQWwS5NfF5IXYuHyVg0SZSGUDYYhYYORgrEqnXxeY/PsyOLo1lY1J76UEuZYpmJZbE25eCbu+LaMTqyq4TTywc1USPTnKiS+UGHkCCexasWw+V5tMOeHAwcg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(396003)(346002)(376002)(40470700004)(46966006)(36840700001)(110136005)(478600001)(45080400002)(70586007)(966005)(86362001)(36756003)(81166007)(7696005)(6666004)(41300700001)(336012)(426003)(47076005)(54906003)(26005)(316002)(8676002)(70206006)(4326008)(2616005)(186003)(16526019)(1076003)(82310400005)(2906002)(40460700003)(40480700001)(44832011)(5660300002)(8936002)(83380400001)(356005)(82740400003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 02:33:36.3191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7172b8b2-510d-4aed-9d1a-08da5b0a199e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5422
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB HID transport layer doesn't configure mice for wakeup by default.
Thus users can not wake system from s2idle via USB mouse. However, users
can wake the same system from Modern Standby on Windows with the same USB
mouse.

Microsoft documentation indicates that all USB mice and touchpads should
be waking the system from Modern Standby.

Many people who have used Windows on a PC that supports Modern Standby
have an expectation that s2idle wakeup sources should behave the same in
Linux. For example if your PC is configured "dual-boot" and is used docked
it's very common to wakeup by using a USB mouse connected to your dock in
Windows. Switching to Linux this is not enabled by default and you'll
need to manually turn it on or use a different wakeup source than you did
for Windows.

Changes for wakeups have been made in other subsystems such as the PS/2
keyboard driver which align how wakeup sources in Linux and Modern Standby
in Windows behave. To align expectations from users on USB mice, make this
behavior the same when the system is configured both by the OEM and the
user to use s2idle in Linux.

This means that at a minimum supported mice will be able to wakeup by
clicking a button. If the USB mouse is powered over the s2idle cycle (such
as a wireless mouse with a battery) it's also possible that moving it
may wake up the system.  This is HW dependent behavior.

If the user sets the system to use S3 instead of s2idle, or the OEM ships
the system defaulting to S3, this behavior will not be turned on by
default.

Users who have a modern laptop that supports s2idle and use s2idle but
prefer the previous Linux kernel behavior can turn this off via a udev
rule.

Link: https://docs.microsoft.com/en-us/windows-hardware/design/device-experiences/modern-standby-wake-sources#input-devices-1
Link: https://lore.kernel.org/linux-usb/20220404214557.3329796-1-richard.gong@amd.com/
Suggested-by: Richard Gong <richard.gong@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
More people keep coming to us confused that they couldn't wake a Linux system
up from sleep using a mouse, so this patch is being revived.

Microsoft documentation doesn't indicate any allowlist for this behavior, and
they actually prescribe it for all USB mice and touchpads.

changes from v2->v3:
 * Use `pm_suspend_preferred_s2idle`
 * Drop now unnecessary acpi.h header inclusion
 * Update commit message
 * Adjust comments from v2 per thread

changes from v1->v2:
 * Resubmit by Mario
 * Update commit message
 * Only activate on systems configured by user and OEM for using s2idle
---
 drivers/hid/usbhid/hid-core.c | 37 ++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 4490e2f7252a..d08511f00d3b 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -26,6 +26,7 @@
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <linux/string.h>
+#include <linux/suspend.h>
 
 #include <linux/usb.h>
 
@@ -1176,17 +1177,31 @@ static int usbhid_start(struct hid_device *hid)
 		usb_autopm_put_interface(usbhid->intf);
 	}
 
-	/* Some keyboards don't work until their LEDs have been set.
-	 * Since BIOSes do set the LEDs, it must be safe for any device
-	 * that supports the keyboard boot protocol.
-	 * In addition, enable remote wakeup by default for all keyboard
-	 * devices supporting the boot protocol.
-	 */
-	if (interface->desc.bInterfaceSubClass == USB_INTERFACE_SUBCLASS_BOOT &&
-			interface->desc.bInterfaceProtocol ==
-				USB_INTERFACE_PROTOCOL_KEYBOARD) {
-		usbhid_set_leds(hid);
-		device_set_wakeup_enable(&dev->dev, 1);
+	if (interface->desc.bInterfaceSubClass == USB_INTERFACE_SUBCLASS_BOOT) {
+		switch (interface->desc.bInterfaceProtocol) {
+		/* Some keyboards don't work until their LEDs have been set.
+		 * Since BIOSes do set the LEDs, it must be safe for any device
+		 * that supports the keyboard boot protocol.
+		 * In addition, enable remote wakeup by default for all keyboard
+		 * devices supporting the boot protocol.
+		 */
+		case USB_INTERFACE_PROTOCOL_KEYBOARD:
+			usbhid_set_leds(hid);
+			device_set_wakeup_enable(&dev->dev, 1);
+			break;
+		/*
+		 * Windows configures USB mice to be a wakeup source from Modern
+		 * Standby, and users have expectations that s2idle wakeup sources
+		 * behave the same.  Thus setup remote wakeup by default for mice
+		 * supporting boot protocol if the system supports s2idle and the user
+		 * has not disabled it on the kernel command line.
+		 */
+		case USB_INTERFACE_PROTOCOL_MOUSE:
+			if (pm_suspend_preferred_s2idle() &&
+			    pm_suspend_default_s2idle())
+				device_set_wakeup_enable(&dev->dev, 1);
+			break;
+		}
 	}
 
 	mutex_unlock(&usbhid->mutex);
-- 
2.34.1

