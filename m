Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91B45140C7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 05:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235255AbiD2DIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 23:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235031AbiD2DId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 23:08:33 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D4485655;
        Thu, 28 Apr 2022 20:05:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdW+HMKtYqHNXEtsOn3tLb2rCG4Z+lI0gqHg9u5NZc/CzBHH6g+LtC0bVD/kXnAAo1TnRmO2NDyLkXbultnWtn0KaRZ9P2dZmsXFBmw36nGR3eDpNK7smIIFyequ8IbbyapV18zIhxjlchLwxFCC783xkiQWgTEUqljYqyfNOiv61N5XcXfchvPRrKeC15sQDjpcRV9HKlcADpRw5Dbuzv2EOYz3xedbbrcA7Lup+QGlWjD1oifhMjJ+3H2F19BxyDFW6+yPnt3R4kHbCmOnBC+ON8Swz1OOBJA+JDfJOSbjRGF7MDyc0rbPYphkOmgYb1kksNMgGCQ66hMP5q9ZJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x79hoz/UFpABXRhK/fZdE/qSKoEbChoC3QRITuGeMMw=;
 b=ny7Yemi2rkX4+Uj6gFarJVhAqvG5PFs19zZ1xr0sS7/gaUwiwH9Ghxch9K1t0FWtD+gOqoh24KSAvIThg96SB81XuC30rifvFzE4wcpImxPSPRekBoBhdHNiGj1ffkrxWVnZbxU+xv4TJoI+TkQYPMKzTIKJD/kKxGflTrIM63K7fbfYsifiK56ikhxOY/IMr3Wc7XanO7U0V1joN78gdTUCIlTjxAatIKYOzAyJdsxYG14C6cyAc+6J8oe+BH3VF59hetUsAjgaC4IIn+KBy2h+9PqFODFOXSlmHIcuYfbG8ELwffERadagBPUn+Ee0CHpKd2hgJ0jM7SNNT7QTVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x79hoz/UFpABXRhK/fZdE/qSKoEbChoC3QRITuGeMMw=;
 b=GEXCCAClWmeTPCSc5h5YN3o+8UhMHJTcZBgLCP5UBx+gJeWniHgHZ83QFNPNy5wzdXvHGaMmmvMCNni4n+KZv5ufKUL8aEfIaNFZx63MSSdRZM5nr6g7j0jmxZFKRUS+gib41+GLzbgf+gmDXUgbsnV5kCdnjoWz/FF3EmMnfCg=
Received: from BN8PR12CA0029.namprd12.prod.outlook.com (2603:10b6:408:60::42)
 by SJ1PR12MB6098.namprd12.prod.outlook.com (2603:10b6:a03:45f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 29 Apr
 2022 03:05:13 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::92) by BN8PR12CA0029.outlook.office365.com
 (2603:10b6:408:60::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Fri, 29 Apr 2022 03:05:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 03:05:13 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 22:05:11 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Pearson <markpearson@lenovo.com>
CC:     Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Mark Gross <mgross@linux.intel.com>,
        "open list:THINKPAD ACPI EXTRAS DRIVER" 
        <ibm-acpi-devel@lists.sourceforge.net>,
        "open list:THINKPAD ACPI EXTRAS DRIVER" 
        <platform-driver-x86@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/2] platform/x86: thinkpad_acpi: Add a s2idle resume quirk for a number of laptops
Date:   Thu, 28 Apr 2022 22:05:01 -0500
Message-ID: <20220429030501.1909-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220429030501.1909-1-mario.limonciello@amd.com>
References: <20220429030501.1909-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9da0ddac-cbf9-4370-da61-08da298d146a
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6098:EE_
X-Microsoft-Antispam-PRVS: <SJ1PR12MB6098F1653A1B0702DF655279E2FC9@SJ1PR12MB6098.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5j60/9k44JpmDJYWRFOljjTaqiXuqCWPREg+bV4d7QBLYS+A7VxLJIFBBGw93G8Sk0IBegRsBE+wLTCEa5O1sOLdUCOuCj98rL2fzc7IRfYyNP5zJf4Hsd7AGptzv14Nts+lwtrv9DU4TT1OBlJLJhS3rLOin9g3Rj36sssGZ7nO3WyJNxej86EStxfsjS3vOPzhJgyQohK0HoAsYERlqhbNqkrC6uxsI+wlEA8zsTBUkUfhbagrzybYqR6wXxqj4iXg2R/uqvFNLRfaVcJp9HdVn5ZsFnE6+MBhQBuhYk2BsbUS8aVRtL3fH3tR6UmbBS2DOKBIE/uCRSMrgN2rrSZEsGsHXyJzcdPNcvZB2oW3KvUxX5Qu0Rp5J4JNIzM8bsX2Tx9VLz59aDgCikXJS33Kdmsp6fVE00ZnJ+AjD/RGL+DQZ/nbvnqGF95xewPVpRAhmXH/16KZ8WX3AB6KwybppgTfhymBw75KOuO/H/FR34avAYLd0ifb7Q73abky45Wb/0MMzzpQn61mRmvKjPKxvajATZZ6Nj1YHJES8mHhAgCjfh/ESPRJ/r/L2j0tJtE1mvSmKlSsIltD7NgBW7JRYnRthM4MrdrnhsUeqZhQnkc97JPfukeOQ/q/zh5+3/YAxPCO18dWW223K8WDMF1yJKXSQyC4j4ugU4221n4itMuntry9aIqvv/iB8NtM1L4Sk4SK52UJL+fXTTDaLA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(70206006)(83380400001)(508600001)(186003)(4326008)(16526019)(36860700001)(2616005)(40460700003)(8676002)(70586007)(82310400005)(7696005)(966005)(86362001)(336012)(426003)(47076005)(44832011)(5660300002)(316002)(36756003)(6666004)(81166007)(26005)(1076003)(54906003)(356005)(110136005)(8936002)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 03:05:13.5239
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da0ddac-cbf9-4370-da61-08da298d146a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6098
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lenovo laptops that contain NVME SSDs across a variety of generations have
trouble resuming from suspend to idle when the IOMMU translation layer is
active for the NVME storage device.

This generally manifests as a large resume delay or page faults. These
delays and page faults occur as a result of a Lenovo BIOS specific SMI
that runs during the D3->D0 transition on NVME devices.

This SMI occurs because of a flag that is set during resume by Lenovo
firmware:

```
OperationRegion (PM80, SystemMemory, 0xFED80380, 0x10)
Field (PM80, AnyAcc, NoLock, Preserve)
{
	SI3R,   1
}

Method (_ON, 0, NotSerialized)  // _ON_: Power On
{
	TPST (0x60D0)
	If ((DAS3 == 0x00))
	{
		If (SI3R)
		{
			TPST (0x60E0)
			M020 (NBRI, 0x00, 0x00, 0x04, (NCMD | 0x06))
			M020 (NBRI, 0x00, 0x00, 0x10, NBAR)
			APMC = HDSI /* \HDSI */
			SLPS = 0x01
			SI3R = 0x00
			TPST (0x60E1)
		}
		D0NV = 0x01
	}
}
```

Create a quirk that will run early in the resume process to prevent this
SMI from running. As any of these machines are fixed, they can be peeled
back from this quirk or narrowed down to individual firmware versions.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1910
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1689
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/thinkpad_acpi.c | 108 ++++++++++++++++++++++++++-
 1 file changed, 107 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index f49f59130c3c..9161f356fcdd 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -312,12 +312,17 @@ struct ibm_init_struct {
 /* DMI Quirks */
 struct quirk_entry {
 	bool btusb_bug;
+	u32 s2idle_bug_mmio;
 };
 
 struct quirk_entry quirk_btusb_bug = {
 	.btusb_bug = true,
 };
 
+struct quirk_entry quirk_s2idle_bug = {
+	.s2idle_bug_mmio = 0xfed80380,
+};
+
 static struct {
 	u32 bluetooth:1;
 	u32 hotkey:1;
@@ -4419,9 +4424,101 @@ static const struct dmi_system_id fwbug_list[] __initconst = {
 			DMI_MATCH(DMI_BOARD_NAME, "20MV"),
 		},
 	},
+	{
+		.ident = "L14 Gen2 AMD",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "20X5"),
+		}
+	},
+	{
+		.ident = "T14s Gen2 AMD",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "20XF"),
+		}
+	},
+	{
+		.ident = "X13 Gen2 AMD",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "20XH"),
+		}
+	},
+	{
+		.ident = "T14 Gen2 AMD",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "20XK"),
+		}
+	},
+	{
+		.ident = "T14 Gen1 AMD",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "20UD"),
+		}
+	},
+	{
+		.ident = "P14s Gen1 AMD",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "20Y1"),
+		}
+	},
+	{
+		.ident = "P14s Gen2 AMD",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21A0"),
+		}
+	},
 	{}
 };
 
+/*
+ * Lenovo laptops from a variety of generations run a SMI handler during the D3->D0
+ * transition that occurs specifically when exiting suspend to idle which can cause
+ * large delays during resume when the IOMMU translation layer is enabled (the default
+ * behavior) for NVME devices:
+ *
+ * To avoid this firmware problem, skip the SMI handler on these machines before the
+ * D0 transition occurs.
+ */
+static void thinkpad_acpi_amd_s2idle_restore(void)
+{
+	struct resource *res;
+	void __iomem *addr;
+	u8 val;
+
+	res = request_mem_region_muxed(tp_features.quirks->s2idle_bug_mmio, 1,
+					"thinkpad_acpi_pm80");
+	if (!res)
+		return;
+
+	addr = ioremap(tp_features.quirks->s2idle_bug_mmio, 1);
+	if (!addr)
+		goto cleanup_resource;
+
+	val = ioread8(addr);
+	iowrite8(val & ~BIT(0), addr);
+
+	iounmap(addr);
+cleanup_resource:
+	release_resource(res);
+}
+
+static struct acpi_s2idle_dev_ops thinkpad_acpi_s2idle_dev_ops = {
+	.restore = thinkpad_acpi_amd_s2idle_restore,
+};
+
 static const struct pci_device_id fwbug_cards_ids[] __initconst = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x24F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x24FD) },
@@ -11473,6 +11570,8 @@ static void thinkpad_acpi_module_exit(void)
 
 	tpacpi_lifecycle = TPACPI_LIFE_EXITING;
 
+	if (tp_features.quirks && tp_features.quirks->s2idle_bug_mmio)
+		acpi_unregister_lps0_dev(&thinkpad_acpi_s2idle_dev_ops);
 	if (tpacpi_hwmon)
 		hwmon_device_unregister(tpacpi_hwmon);
 	if (tp_features.sensors_pdrv_registered)
@@ -11643,8 +11742,15 @@ static int __init thinkpad_acpi_module_init(void)
 	}
 
 	dmi_id = dmi_first_match(fwbug_list);
-	if (dmi_id)
+	if (dmi_id) {
 		tp_features.quirks = dmi_id->driver_data;
+		if (tp_features.quirks->s2idle_bug_mmio) {
+			if (!acpi_register_lps0_dev(&thinkpad_acpi_s2idle_dev_ops))
+				pr_info("Using s2idle quirk to avoid %s platform firmware bug\n",
+					dmi_id->ident ? dmi_id->ident : "");
+		}
+	}
+
 	return ret;
 }
 
-- 
2.34.1

