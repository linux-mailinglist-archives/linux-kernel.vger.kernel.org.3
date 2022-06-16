Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFAAE54E969
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 20:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239381AbiFPSb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 14:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbiFPSbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 14:31:55 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836955370D;
        Thu, 16 Jun 2022 11:31:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CpA2z9H8djXysMNxV04CcVfGzj+7wktf5F9g3uoj7dNQ7/FCxr5OOE3MvlM0jFUC4Jo0zG0YkrzGDEUtBaHwgO9W4mtZn7dR62EnvBkCB/bGZQML6GlRVQ60guLn/m90shIHDwKg4J3nHqNgYzwP14P9c3QqhTDyX4A2a0QWbZngBA5U5+MeWRAY+h6qXKBJ87pzf51DmL8pS2RCzYO5xlDzo1+WnYh6GsiAoKfXr2OqzPtWWHbUTYrdNpwlgL6Ikp649u9BIYHUP5Sa/z0hVwNlchVZpDjK6l5gSc3Sa1clAy49l/ApoTUfy2WzngbZAU88s2cy7f8yLCi2IjwWNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kiAC+ZIOYD1ZY1p5pwDOEMOZlCtsktue3feDinp0/fE=;
 b=irEqWYg7UyvpCQ0HP3Q4WwaJ1OswWDf7srQHG17RPRuQ6CtZGO59ZEgRfhpr4p3trkn8y6D08eUEEaWEqX2kubZXhtehHJT7vYjLVkPQBkJ5HWMoT1NnBoG8YKytEAbGP5UcM2YYos5AKjNuNCST4f2MUWyWsnLbzMOjJTSbeZDkCelbvhvcgieBA7fFsqpjh5vssPbRqxqZlKqnyb7eJHzEeUFiNr0xlGpRnzznJ3Fa5HuE0tV7h6+Qf/6w0c/ZYWAEq06azaeuT4xE0GcKPAMywhWOqJGChOi0T5BwSof3br6oaFRWuXiEm3Vscx0upmkByP5CqvYTbFw+xdy9PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kiAC+ZIOYD1ZY1p5pwDOEMOZlCtsktue3feDinp0/fE=;
 b=tZrJqN84pMMCjGQ95JvvFfNG9z2dJLLq7B5TNyjlAAgEUEdhS5agk0gCs79kx1XglfdhVXm/zfTRSJ1itqq0QBJsYhDgSTDek0TQUZrxiYJ/4Mph/G5LUyg/+DIM+G84inw24Bhg5eSqw7fbPL6dqZvsM39AvvmR44JrIIEZ2OM=
Received: from MW4PR04CA0314.namprd04.prod.outlook.com (2603:10b6:303:82::19)
 by DM4PR12MB5309.namprd12.prod.outlook.com (2603:10b6:5:390::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Thu, 16 Jun
 2022 18:31:52 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::cd) by MW4PR04CA0314.outlook.office365.com
 (2603:10b6:303:82::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14 via Frontend
 Transport; Thu, 16 Jun 2022 18:31:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Thu, 16 Jun 2022 18:31:51 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 16 Jun
 2022 13:31:50 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>, Jiri Kosina <jikos@kernel.org>,
        "Benjamin Tissoires" <benjamin.tissoires@redhat.com>,
        "open list:USB HID/HIDBP DRIVERS [USB KEYBOARDS, MICE, REM..." 
        <linux-usb@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     Richard Gong <richard.gong@amd.com>
Subject: [PATCH v2] HID: usbhid: set mouse as a wakeup resource
Date:   Thu, 16 Jun 2022 13:31:42 -0500
Message-ID: <20220616183142.14472-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2858dd09-1cc9-475a-8bcc-08da4fc67b70
X-MS-TrafficTypeDiagnostic: DM4PR12MB5309:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB53099617617FACC6CF28D258E2AC9@DM4PR12MB5309.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P5NXrCcXjQuSUGCNLmWnIRHiPfTgEB8qHLiA37YEmFGvURRMBxq8uhkRENbIJF4/TGPxMZgnsVHVBVymVBO4qsYyjixbxkOqeeHAH4HplJEJnlXXCM2yfF9ylI73pp+Pm2TOI1NoicbdkJuQp7GKwSCCWW//MAzjnSB+Z51+iQit3bkerQC9oFG34axPbHUE6sFaWjkVw+I1tAcpUrPAlcNBSNXZGa02GjqU4IjzhSYQ/Cn0txzq876urJHg6Bl0wkvMZUAZhLS/13sNhR3mr5Fo9GzwW4yPJYjst3Rb8CoaiOCchEb9Ua8AwQcXhFHy4aReeyiw0sNn25RqQYQgRcZy3l4FP4Vw1mzn4k89yAEyO2r0A3O1hrZyQmXQ2uUwoPJpGj/zXIS1MLuYyDEtvfL//7XSVTXruPFHlCNT8bLBL+ju7QeSZ+X4veTfB99DXt/Cis8XWobXg319cjJvJYKLx06TXrPvihyv1wueuh3mfpsky9l5rkWZwMgOp8d0lAha/PbfJQl0GxEqut+fG9XQi5yd3nBFZmlg5NK2Vsq+GsZwirbb/Od5mJvnQPFmHPkKe0Qx4UG5tv85o4tHkL/ZvNaxXc0lKkOyZmyvhZQUVx7qpPoQklHDykT+HRt6uVTuPCSOQV98VmIsY8kjSukB8RQD1CuUFjFbApkLbIYhF89fh+1ZTTfHnlKXGDdbQ7F5F35cd6l49u63hWDSGO2ZHpXIA7ZO7A75H678dI4SsjVXeahsLvVfY1XkZqu34nHeB2hbiLUpueZT5SaWuAOwUZY5Jn9oA1N4wFNgTyuTx8f6ODmjEAvdh99WJ+EWIgL9iNF5rLM1+NmbNUVi8Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(46966006)(40470700004)(36840700001)(356005)(2616005)(81166007)(1076003)(16526019)(36860700001)(36756003)(110136005)(186003)(83380400001)(316002)(336012)(47076005)(8676002)(8936002)(5660300002)(70206006)(2906002)(82310400005)(6666004)(44832011)(45080400002)(7696005)(4326008)(40460700003)(26005)(508600001)(86362001)(70586007)(966005)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 18:31:51.7563
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2858dd09-1cc9-475a-8bcc-08da4fc67b70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5309
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB HID transport layer doesn't set mice for wakeup by default so users
can not wake system from s2idle using wired USB mouse. However, users can
wake the same system from Modern Standby on Windows with the same wired
USB mouse.

Microsoft documentation indicates that all USB mice and touchpads should
be waking the system from Modern Standby. To align expectations from users
make this behavior the same when the system is configured by the OEM and
the user to use s2idle in Linux.

Link: https://docs.microsoft.com/en-us/windows-hardware/design/device-experiences/modern-standby-wake-sources#input-devices-1
Link: https://lore.kernel.org/linux-usb/20220404214557.3329796-1-richard.gong@amd.com/
Suggested-by: Richard Gong <richard.gong@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
More people keep coming to us confused that they couldn't wake a Linux system
up from sleep using a mouse, so this patch is being revived.

Microsoft documentation doesn't indicate any allowlist for this behavior, and
they actually prescribe it for all USB mice and touchpads.
v1->v2:
 * Resubmit by Mario
 * Update commit message
 * Only activate on systems configured by user and OEM for using s2idle

 drivers/hid/usbhid/hid-core.c | 36 ++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 4490e2f7252a..3a1214ecec49 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -12,6 +12,7 @@
 /*
  */
 
+#include <linux/acpi.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/init.h>
@@ -26,6 +27,7 @@
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <linux/string.h>
+#include <linux/suspend.h>
 
 #include <linux/usb.h>
 
@@ -1176,17 +1178,29 @@ static int usbhid_start(struct hid_device *hid)
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
+#ifdef CONFIG_ACPI
+		/* Setup remote wakeup by default for mice supporting boot
+		 * protocol if the system supports s2idle
+		 */
+		case USB_INTERFACE_PROTOCOL_MOUSE:
+			if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0 &&
+			    pm_suspend_default_s2idle())
+				device_set_wakeup_enable(&dev->dev, 1);
+			break;
+#endif
+		}
 	}
 
 	mutex_unlock(&usbhid->mutex);
-- 
2.34.1

