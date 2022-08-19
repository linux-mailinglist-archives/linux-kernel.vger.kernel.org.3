Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729E5599D8B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 16:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349556AbiHSOZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 10:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349437AbiHSOZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 10:25:30 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2844E3408;
        Fri, 19 Aug 2022 07:25:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XoeCnETxMHiDor9FS/gUMaOx6kFwTup9aP8hlXikIIhtWSJ98DJe4mR52RTFHXa+gbjT9vyAGSfz7t1/n9BR0r5NyDdSH3uZOUwgxuHcbdfN54+BvJPiGfGzdV9KexKlWnpX1SFLijRpGtmkGxGX+L8vM+1dwycJYyUrnKu3quAwN9G0X7ekzF1nRWfrIB1kGdj0mMVYjdzGqQS99IpvQn/XauIA8qhBA21OYQDhrRu2iupvi1DDHsV8rxqBRVB9yn3skT3KcrvyZN4KKjfq0hXmHfMjRmxtb8bhPIJwouBQWwucfk/BcTbqccxDyABWz7bj3ji9IttAjGh4Mx9zNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ooLROBHiS6KoHewByiEnTleKMdarIbLcRyBNTCcHaHg=;
 b=WxGN610tZFlsyOP1HGKEnXvgkMeTj5iYBhAv6wtvoNapVm9rvlJcgzqy0Rts0gVgoN/O6TFLUzEwSp/IZDO8G9i6NyeAo2DFDKE+8gRxdWVxJkNc8axlx06+DRqLu3kLQMmAMP1z0Mi8pGqYN2sC63W0noFbeQceMI3t80E/NCDDxlw3K6zavwFB/HAjK/fdPVGqioIfsKEvJXDbeTGOxcL22wANxhOEOsfFYtSaL0ftNWT3OSXZ1wkTUHABQOh81MQYTbi+3bSk6Ea+cCa0UW8f0tvFZWXzPtBkp5SP4lnnKra3KJvjmjt85zck8fANqnyrC3a7ATgmAYA+yxzkqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ooLROBHiS6KoHewByiEnTleKMdarIbLcRyBNTCcHaHg=;
 b=aTlnszmwdyMo25sNYmfSFL21PrHvaLi9yOYeky4h89PzRnNTKWQ/SPbEEeyaikbZGUmiqSz477axySMCr27WQzET6zC/9XCQ0TRYKl604GuuG/xDdULcq978iFFIh/1PvnHqoNULzeCKE9kso91q+xGhNPZRPs2saamu0g2LTJQ=
Received: from BN0PR04CA0202.namprd04.prod.outlook.com (2603:10b6:408:e9::27)
 by DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Fri, 19 Aug
 2022 14:25:25 +0000
Received: from BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::77) by BN0PR04CA0202.outlook.office365.com
 (2603:10b6:408:e9::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16 via Frontend
 Transport; Fri, 19 Aug 2022 14:25:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT105.mail.protection.outlook.com (10.13.176.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.7 via Frontend Transport; Fri, 19 Aug 2022 14:25:25 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 19 Aug
 2022 09:25:24 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <rafael@kernel.org>, Len Brown <lenb@kernel.org>
CC:     <kherbst@redhat.com>, <nouveau@lists.freedesktop.org>,
        <hdegoede@redhat.com>, <ddadap@nvidia.com>,
        <kai.heng.feng@canonical.com>, <Dell.Client.Kernel@dell.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [RFC 2/2] ACPI: OSI: Deprecate some abused _OSI strings
Date:   Fri, 19 Aug 2022 09:25:19 -0500
Message-ID: <20220819142519.5684-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220819142519.5684-1-mario.limonciello@amd.com>
References: <20220819142519.5684-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: facf9baa-81dc-406d-d222-08da81eea858
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t4kjWwnDYL8sT3B1/fw6Ajt1hdkLzdqHeZxZRwoqlnKO16kmebzp7Np4BVCLId+4coSg3JivihZhul0wiVA8QKUiVJhoqCfxdCzM8PHbzuj5kiyl4K3COxhEWdv5vTgsVZ3YdFccZHSahSbB0Uo4le/3kWdFlHh2Ohesrb0RFP/Vvx8dcYTFaIIVaqrs9A0PXs5gCTa85oDrh0AKVxYxeFrL0Ld3aF0A5wnf3jeG2Bj2cHiEC8+1X71qyCjGSnHyZwMyLLKxqRaVye6zhU/Tkshu1rPT5eZh2b+a5qXLMquRKfdbRAY2AnIOhi/pxkzv3AaG0fTjjo/B6dBWYMITrqTMi/QlZGpNIhBfDJajNq+DOC6pw+xKZkffTPxjYrycyyzE0b4PwnSPr4+CggOcqPk70dHqm+vjM2HFGS5egPHjAARrcPzpmlMNbh2zGccbIjVvNoCKjKgBwx4SVMcfgAuVbiYrfWJWfp2L1AHgyVdSiU2qOVZucqiUZSYwh78PFJQe30Q8gnPQB2MoakESJvNXBjocw0a/Dkw0FSsieu57k/kvS2KR0wTaYklopHuzOilfSNbl6fJ35dCfegdpe9miScMh9duW2L9KqTwVFTV+PVj2NUqS272HkIGmtsVsTpwqYno0vvzvx+xU+768aRiJ0UULtmpbEEluPnFroE6Q/KsXRNgsWPVjFX5viFsKS40IxHDGP1RweH7CHxpEjY9Zp3psAQDIt6aC1428nopw7jAPyduGQT891t5Pj/n3vUkyqZMRhIGbv1D8NkIMySjN+Xp/8fnQ/v+ZzfWq7LkNsuzUURGfL2YmlOArmVTN
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(136003)(346002)(39860400002)(46966006)(40470700004)(36840700001)(7416002)(70206006)(4326008)(44832011)(110136005)(54906003)(316002)(5660300002)(8936002)(36756003)(2906002)(82310400005)(478600001)(8676002)(41300700001)(7696005)(6666004)(40480700001)(26005)(2616005)(81166007)(356005)(82740400003)(86362001)(83380400001)(70586007)(1076003)(40460700003)(36860700001)(336012)(186003)(426003)(47076005)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 14:25:25.2158
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: facf9baa-81dc-406d-d222-08da81eea858
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4123
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux-Lenovo-NV-HDMI-Audio and Linux-HPI-Hybrid-Graphics have
been seen in the wild being abused by other vendors.  If these use
cases are still needed for modern laptops, they should be done via
kernel drivers instead.

As we can't have nice things, mark these strings to only be applied
to laptops from 2022 or earlier.  This should avoid breaking any
older laptops.  In the future if the kernel drivers need to call
Linux-only ASL for any reason, it could be a custom _DSM used only
for Linux or something similar. This approach allows kernel developers
to control whether to stop calling the ASL when the deficiency by
the kernel is resolved.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/firmware-guide/acpi/osi.rst | 24 ++++++++++-------------
 drivers/acpi/osi.c                        | 22 +++++++++++++++------
 2 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/Documentation/firmware-guide/acpi/osi.rst b/Documentation/firmware-guide/acpi/osi.rst
index 05869c0045d7..392b982741fe 100644
--- a/Documentation/firmware-guide/acpi/osi.rst
+++ b/Documentation/firmware-guide/acpi/osi.rst
@@ -41,26 +41,22 @@ But it is likely that they will all eventually be added.
 What should an OEM do if they want to support Linux and Windows
 using the same BIOS image?  Often they need to do something different
 for Linux to deal with how Linux is different from Windows.
-Here the BIOS should ask exactly what it wants to know:
 
+In this case, the OEM should create custom ASL to be executed by the
+Linux kernel and changes to Linux kernel drivers to execute this custom
+ASL.  The easiest way to accomplish this is to introduce a device specific
+method (_DSM) that is called from the Linux kernel.
+
+In the past the kernel used to support something like:
 _OSI("Linux-OEM-my_interface_name")
 where 'OEM' is needed if this is an OEM-specific hook,
 and 'my_interface_name' describes the hook, which could be a
 quirk, a bug, or a bug-fix.
 
-In addition, the OEM should send a patch to upstream Linux
-via the linux-acpi@vger.kernel.org mailing list.  When that patch
-is checked into Linux, the OS will answer "YES" when the BIOS
-on the OEM's system uses _OSI to ask if the interface is supported
-by the OS.  Linux distributors can back-port that patch for Linux
-pre-installs, and it will be included by all distributions that
-re-base to upstream.  If the distribution can not update the kernel binary,
-they can also add an acpi_osi=Linux-OEM-my_interface_name
-cmdline parameter to the boot loader, as needed.
-
-If the string refers to a feature where the upstream kernel
-eventually grows support, a patch should be sent to remove
-the string when that support is added to the kernel.
+However this was discovered to be abused by other BIOS vendors to change
+completely unrelated code on completely unrelated systems.  As such it's
+been deprecated and any old hooks will not be activated on systems from
+2023 or later.
 
 That was easy.  Read on, to find out how to do it wrong.
 
diff --git a/drivers/acpi/osi.c b/drivers/acpi/osi.c
index c2f6b2f553d9..18c339c3f277 100644
--- a/drivers/acpi/osi.c
+++ b/drivers/acpi/osi.c
@@ -25,6 +25,7 @@
 struct acpi_osi_entry {
 	char string[OSI_STRING_LENGTH_MAX];
 	bool enable;
+	unsigned int max_bios_year;
 };
 
 static struct acpi_osi_config {
@@ -40,25 +41,29 @@ static struct acpi_osi_config {
 static struct acpi_osi_config osi_config;
 static struct acpi_osi_entry
 osi_setup_entries[OSI_STRING_ENTRIES_MAX] __initdata = {
-	{"Module Device", true},
-	{"Processor Device", true},
-	{"3.0 _SCP Extensions", true},
-	{"Processor Aggregator Device", true},
+	{"Module Device", true, 0},
+	{"Processor Device", true, 0},
+	{"3.0 _SCP Extensions", true, 0},
+	{"Processor Aggregator Device", true, 0},
 	/*
 	 * Linux-Lenovo-NV-HDMI-Audio is used by BIOS to power on NVidia's HDMI
 	 * audio device which is turned off for power-saving in Windows OS.
 	 * This power management feature observed on some Lenovo Thinkpad
 	 * systems which will not be able to output audio via HDMI without
 	 * a BIOS workaround.
+	 *
+	 * This _OSI string is only applied to systems from 2022 or earlier.
 	 */
-	{"Linux-Lenovo-NV-HDMI-Audio", true},
+	{"Linux-Lenovo-NV-HDMI-Audio", true, 2022},
 	/*
 	 * Linux-HPI-Hybrid-Graphics is used by BIOS to enable dGPU to
 	 * output video directly to external monitors on HP Inc. mobile
 	 * workstations as Nvidia and AMD VGA drivers provide limited
 	 * hybrid graphics supports.
+	 *
+	 * This _OSI string is only applied to systems from 2022 or earlier.
 	 */
-	{"Linux-HPI-Hybrid-Graphics", true},
+	{"Linux-HPI-Hybrid-Graphics", true, 2022},
 };
 
 static u32 acpi_osi_handler(acpi_string interface, u32 supported)
@@ -122,9 +127,11 @@ void __init acpi_osi_setup(char *str)
 		osi = &osi_setup_entries[i];
 		if (!strcmp(osi->string, str)) {
 			osi->enable = enable;
+			osi->max_bios_year = 0;
 			break;
 		} else if (osi->string[0] == '\0') {
 			osi->enable = enable;
+			osi->max_bios_year = 0;
 			strncpy(osi->string, str, OSI_STRING_LENGTH_MAX);
 			break;
 		}
@@ -225,6 +232,9 @@ static void __init acpi_osi_setup_late(void)
 		str = osi->string;
 		if (*str == '\0')
 			break;
+		if (osi->max_bios_year &&
+		    dmi_get_bios_year() > osi->max_bios_year)
+			continue;
 		if (osi->enable) {
 			status = acpi_install_interface(str);
 			if (ACPI_SUCCESS(status))
-- 
2.34.1

