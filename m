Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7541E5A083A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 06:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbiHYEzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 00:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiHYEzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 00:55:46 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC08760EA;
        Wed, 24 Aug 2022 21:55:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5sw2KAd3w5H+MVocY4AA7Nn1ve++2GPnEG1VoNbdJIw6ix1P1CbK+OcCLBycYb5AXWfOD/TfAOI+UyiRMnGdRCANPzxEZN4RCbgB/JEEC9h0ZGpPZX+CF0gew+vA8C31avSNwvcRsSOg08k1BewNhbILnOZc4DFW1l+3T4NL9QtpXQBgT2/274tSBaJqvW9LApbPKkPpe9Sj+LVI3VH97dW1YRLwe808x+abtcBIfOWWoaGb3QLaZ0hiPp0OnDWd55fR195EM55OUfaJHF6Wk0XZ0JhqqZKRyjjIzEscx5CCs5C6+KSG5IeMbUJuZT+gWIXXSl9dzyC11vLV9nh3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbK6iAyKQClxRYXTRFm332mtoj5HcFNrycmAFhEQexQ=;
 b=R7qIB02Mx+QM4tMq1Q7AWnOlY0xiVCZPyHJLvrDVWJMOimPG61KqY197mdO6/KU+oVxppa60SbB/CX2yKvZtjD1e0SbvJ7sdh89U6OjCiwPevW7DbOvyYhcEd6pIM7Uj3XbpHaRfoxVIJBH9cBvUY5vMVWSu3UO5Wanvdbwl1PmHAFNvUnGVOHmMfWfI4xJkGKK1DBWLM/pmTLIXIEjXQMK3kdm5xx/XLF6Bk/nUNff23CfUD0MfsuOZkK3OqgvHdhSLBPAjKYuHgysM2Yxvb2l1VQ9r7B3QgeTxQHpt0/p3fq7hX3+DmJJWMr65LeqQ3ENCmhiATvPUNWeptn56Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pbK6iAyKQClxRYXTRFm332mtoj5HcFNrycmAFhEQexQ=;
 b=xANcXo1G4egj96tsP1hQRL0b83V40zw5kIfbeK7jqM10gRCA7WUM+IyjbPAscHa3nOc3aBlLlklUvyOy1AA9D2dDy8YMJfKvOoS+TU0UJeR0kRh+jXBzUs3mlWF48bsCJdfrJMpDM6jdVC1MK1LLks6pp8gu+XrdLUE/OVy410o=
Received: from BN9P223CA0010.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::15)
 by DM6PR12MB4057.namprd12.prod.outlook.com (2603:10b6:5:213::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.20; Thu, 25 Aug
 2022 04:55:41 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::d3) by BN9P223CA0010.outlook.office365.com
 (2603:10b6:408:10b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14 via Frontend
 Transport; Thu, 25 Aug 2022 04:55:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Thu, 25 Aug 2022 04:55:41 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 24 Aug
 2022 23:54:56 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>, Jiri Kosina <jikos@kernel.org>,
        "Benjamin Tissoires" <benjamin.tissoires@redhat.com>
CC:     Richard Gong <richard.gong@amd.com>, <linux-usb@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4] HID: usbhid: Set USB mice as s2idle wakeup resources
Date:   Wed, 24 Aug 2022 23:55:17 -0500
Message-ID: <20220825045517.16791-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68ecc191-31fd-482c-2f26-08da86560fce
X-MS-TrafficTypeDiagnostic: DM6PR12MB4057:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CvKhv+HdWN6S2m0rQ5QBNHWc23PXytKH6eo6oB18RbC5P9ClxS2tpE726vYRlxORMRKuka1/W19smzExW60Q4+Ngttc2Pp/yiyUG5f55TwtsaPHdTUmwoqWW/cC45MpuAp2ZqFQZa7mZNHg9TqawB9Tjdkr4AlUNHpfSOl5HekkBQojLNxZx+LI7zqrQFW9IRtKx/eI/Wl8Qjj1yx1HFJrErs71Ka/3KjRdmi6ETc1TJ61dfwLnU3XP14kn4YoLql9sRCt/NKetjlnDhdgVplX/w0AMuBbWwSWlZ60kES8A0yJfxBI14fNsUACt+3HwANYNV84bSoKDKGY46+CSDZl7Hrtr25q6GsY1jXwP/dhHcOficpsSK2ytj+KnvY8v2RLobQ7hlwYCVtcCsWrjriZZ/QEN/1xY7kIQIE+Z6/QZpzQeXfdCQ/PYWjQaW/Gp4u4PGHzwLV+ONERpsLLL8FXIo3hdnAvfl1kjj9dwkNxPPOD7X+CJSmof1UlIRNSqwkL+Kt1G0pS37FCQRZMfxiCfS3O43A/HTJ9jBMAsFiVsAwGLrOvGfI1sNYZAdMrUzrLFDE2fceaviCuSWbR9g5V6277JuRDmHdPE0tqid6ZY0Pn/5Z1oNu+DSg0A0fHkuVLKKOuwK56Kxc7lDqEuNfcUa7Kc9Edzw5MGuXrhqjl56D0EDfXFrZCnwKOwU84cueNaxqrVNueA3Kr0tTyGEfSWUMzIPElOUqhD2uDHBjC8MjZmmazAAE9b6u6R/2JZgyGMOScD4mqepJ3DuPwYq9NhCeuv1sVuGMtYNzgkQtZiQw+6QNGqINokvm9lMUak9zT2j32b5cZcyRJNaAsNh4nmYKfrEeCN5Y8yeytGbfy3aFbHZKWklMrOu4/Kj3P8V
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(39860400002)(396003)(376002)(46966006)(36840700001)(40470700004)(966005)(70586007)(1076003)(110136005)(8676002)(70206006)(4326008)(45080400002)(316002)(186003)(6666004)(478600001)(54906003)(41300700001)(44832011)(5660300002)(2906002)(426003)(83380400001)(7696005)(47076005)(2616005)(26005)(36756003)(336012)(16526019)(86362001)(356005)(36860700001)(40460700003)(40480700001)(81166007)(8936002)(82310400005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 04:55:41.6201
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ecc191-31fd-482c-2f26-08da86560fce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4057
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
behavior the same when the system is configured to default to s2idle.
This normally happens when the FADT indicates low power idle support or the
system doesn't support S3.

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

changes from v3->v4:
 * Drop all changes related to pm_suspend_preferred_s2idle.
   The direction from Rafael has been that drivers should NOT
   use acpi_gbl.FADT to make policy decisions.
 * Instead only examine pm_suspend_default_s2idle() for policy decision.

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
 drivers/hid/usbhid/hid-core.c | 36 ++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 4490e2f7252a..19aa186a7e0e 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -26,6 +26,7 @@
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <linux/string.h>
+#include <linux/suspend.h>
 
 #include <linux/usb.h>
 
@@ -1176,17 +1177,30 @@ static int usbhid_start(struct hid_device *hid)
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
+			if (pm_suspend_default_s2idle())
+				device_set_wakeup_enable(&dev->dev, 1);
+			break;
+		}
 	}
 
 	mutex_unlock(&usbhid->mutex);
-- 
2.34.1

