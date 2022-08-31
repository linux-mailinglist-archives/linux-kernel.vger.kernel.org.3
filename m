Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666BB5A78C0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiHaIR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbiHaIRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:17:00 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9644B2CD6;
        Wed, 31 Aug 2022 01:16:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Czu1EQ1+nscdc7n33PnaIE+vXViSFlJNnm1FYsVCB63WANBYLPl5mOL1M3vOUYs3BeaD47Ob9OQtook1UCa0wx1hprfYrKD8qt48hFtsvOChYMUl1dP4ClI07Ho8phVgRRSH3FpF7ajVpA3KbZEGtVVUg6p+tXq8k2+paVFLleSHGGJrwobSiIu+bFx94w0msb4dGj28PW+hVyyVPzF4GwDAvK8s5ggGuVu+bIquCiqgBx0xIFCCi8Zg1Z1OQWFhkYCVyTdjFPUFSy562p1wsNUFW1esiKl6tQKeUEP6s3WOp6qiPGa6tPu8w0hentJh28bGLJG6grXQKUCQkhGldA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1B5VY1HjhZEMKCLCZO4n9Eaju7hECBVd6zhD+PuvTk8=;
 b=Esa3v2s0o1JxKHLTZl0ImAImQRZbPe3CPJK7IRegJlJHuYSHU69FnlfDmTNY1umJ0Vt18sqJ3Y1nUA4v/4gIFpeup4JMWJb8svkRoC+nSvi54lVXijbpk8XuS7RA7ZrL58gmUZLyhcq7UeEpdUWUfo+rJXDLNiBGIMAljdJ5up3z7YtsYPsVK/bmhTVCft7djZreYKSS4pVXRU+PX80LQ2hkzvBieEZNTCSX91tI5O3Cay6pRSGimJRUqfZrv9AZJP7IqJtNttkanTscyVSitMKh8IFl5zsrnLMgdhH3mozAjiijcxaX3/s4PxN5BWad5cghhWYRpxZMgIjBqjbfsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1B5VY1HjhZEMKCLCZO4n9Eaju7hECBVd6zhD+PuvTk8=;
 b=YiXGS4N1+vVidP7WZow96lsbJvzPc/KYnhz/TwUQS7y6hN4ygtg4qQ6PTSpOtnh+61COsjnWkhr72Tv4YiG4JTdBSZp1I1l5nys5rTX+E7zI8BQ3L7xnoEAS6ODplL3tyGbfBtkIG8ZgHeH2vJi602QDZxQnGpDvj1nPqkS2Src=
Received: from MW4PR03CA0282.namprd03.prod.outlook.com (2603:10b6:303:b5::17)
 by DM4PR12MB6350.namprd12.prod.outlook.com (2603:10b6:8:a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 08:16:53 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::f1) by MW4PR03CA0282.outlook.office365.com
 (2603:10b6:303:b5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Wed, 31 Aug 2022 08:16:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Wed, 31 Aug 2022 08:16:52 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 31 Aug
 2022 03:16:49 -0500
From:   Robert Richter <rrichter@amd.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Robert Richter <rrichter@amd.com>
Subject: [PATCH 05/15] cxl/acpi: Add probe function to detect restricted CXL hosts in RCD mode
Date:   Wed, 31 Aug 2022 10:15:53 +0200
Message-ID: <20220831081603.3415-6-rrichter@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220831081603.3415-1-rrichter@amd.com>
References: <20220831081603.3415-1-rrichter@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bbf119f-4c6c-4346-5d31-08da8b29293b
X-MS-TrafficTypeDiagnostic: DM4PR12MB6350:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: niPQiPFAfZmeTmSG3hKN98exB5bUg8gnFXAb7lRh3g12ANbifBSIPalS1qqpP/RLH6uIIwNhLAeukn617tMazDs/bDSYjoeBO27EiZsS3eCAbFj8YIrsS/42tv+wsQLV6t7l4VEKqdT+CHKVlr/Za6KJsxEDQ5Zma2K+vf0Tr2N59DQvyZ8COwwCggpLsXmsThcA6ArSA0s8Ic+M3EYALn4QY3Bxsi1/YdCaqeAhp+fYeeconuFJdneNF0JbRxV6ObzkMo/AoluN8o0oeiOoZGGTdkaiGLGTvgarU21BLD1t808OCAnPgzPqRnp5qapusAHqzBbhvlLomC4eQO4Ht/x4IY1Zfl8LIMJtuXdFwcD8/X5Mr09/3Yp4gEf9AeOrWuFhwy9yAtznFn3weVAb8Gy/B8eiSSidDeFq8q81yXEZJMNZiORNvxdhlD/a7dLpNLlLkQqJ5d3XuXhwWU9fLu1kgrwtbI0eqb0um6yaiqIgmmX6zVK8ZTkOS1kxz41sDDDTHzt4X5UsiAz5c6urtcNydwBbNZH420f8M2XqWh+sKa0AHi/2Tds/jP+bfhhJjGtA40amieB2/TzTSYCm81WSkZyZbtYHwji9DpPwmllP6EamDZp9RdTCkVjZwZKsI52+pAE/FJzjh2GrCENIZKqRtVHgb328BUzYBfKLKM6qhCMb9IABgf7+KmzbQXFjvtQkpu/8NKNjZXrv5kv7c100DF3IEj18VDLAoiiGGrgeJ3ZCEz9ijyEqw62ZMAoki5FfRmdjFW+JpfZXaMFHh/0AZsdr7wVxKeIXXXnByaqokzXVn/Zt/JqhIX9RNTSS
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(346002)(396003)(136003)(40470700004)(36840700001)(46966006)(336012)(36756003)(2616005)(16526019)(2906002)(8676002)(4326008)(26005)(41300700001)(6666004)(47076005)(83380400001)(1076003)(426003)(186003)(7416002)(36860700001)(5660300002)(40480700001)(54906003)(316002)(81166007)(478600001)(8936002)(82310400005)(356005)(70206006)(70586007)(110136005)(40460700003)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 08:16:52.6304
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bbf119f-4c6c-4346-5d31-08da8b29293b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6350
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Restricted CXL device (RCD) mode (formerly CXL 1.1) uses a different
enumeration scheme other than CXL VH (formerly CXL 2.0). In RCD mode a
host/device (RCH-RCD) pair shows up as a legal PCIe hierarchy with an
ACPI host bridge ("PNP0A08" or "ACPI0016" HID) and RCiEP connected to
it with a description of the CXL device.

Add function cxl_restricted_host_probe() to probe RCD enumerated
devices. The function implements a loop that detects all CXL capable
ACPI PCI root bridges in the system (RCD mode only). The iterator
function cxl_find_next_rch() is introduced to walk through all of the
CXL hosts. The loop will then enable all CXL devices connected to the
host. For now, only implement an empty loop with an iterator that
returns all pci host bridges in the system.

The probe function is triggered by adding an own root device for RCHs.
This is different to CXL VH where an ACPI "ACPI0017" root device
exists. Its detection starts the CXL host detection. In RCD mode such
a device does not necessarily exists, so solve this by creating a
plain platform device that is not an ACPI device and is root only for
RCHs.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/acpi.c | 71 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 31e104f0210f..a19e3154dd44 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -312,6 +312,33 @@ static int add_root_nvdimm_bridge(struct device *match, void *data)
 	return 1;
 }
 
+struct pci_host_bridge *cxl_find_next_rch(struct pci_host_bridge *host)
+{
+	struct pci_bus *bus = host ? host->bus : NULL;
+
+	while ((bus = pci_find_next_bus(bus)) != NULL) {
+		host = bus ? to_pci_host_bridge(bus->bridge) : NULL;
+		if (!host)
+			continue;
+
+		dev_dbg(&host->dev, "PCI bridge found\n");
+
+		return host;
+	}
+
+	return NULL;
+}
+
+static int __init cxl_restricted_host_probe(struct platform_device *pdev)
+{
+	struct pci_host_bridge *host = NULL;
+
+	while ((host = cxl_find_next_rch(host)) != NULL) {
+	}
+
+	return 0;
+}
+
 static struct lock_class_key cxl_root_key;
 
 static void cxl_acpi_lock_reset_class(void *dev)
@@ -445,6 +472,13 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 	struct acpi_device *adev = ACPI_COMPANION(host);
 	struct cxl_cfmws_context ctx;
 
+	/*
+	 * For RCH (CXL 1.1 hosts) the probe is triggered by a plain
+	 * platform dev which does not have an acpi companion.
+	 */
+	if (!adev)
+		return cxl_restricted_host_probe(pdev);
+
 	device_lock_set_class(&pdev->dev, &cxl_root_key);
 	rc = devm_add_action_or_reset(&pdev->dev, cxl_acpi_lock_reset_class,
 				      &pdev->dev);
@@ -518,6 +552,7 @@ MODULE_DEVICE_TABLE(acpi, cxl_acpi_ids);
 
 static const struct platform_device_id cxl_test_ids[] = {
 	{ "cxl_acpi" },
+	{ "cxl_root" },
 	{ },
 };
 MODULE_DEVICE_TABLE(platform, cxl_test_ids);
@@ -531,7 +566,41 @@ static struct platform_driver cxl_acpi_driver = {
 	.id_table = cxl_test_ids,
 };
 
-module_platform_driver(cxl_acpi_driver);
+static void cxl_acpi_device_release(struct device *dev) { }
+
+static struct platform_device cxl_acpi_device = {
+	.name = "cxl_root",
+	.id = PLATFORM_DEVID_NONE,
+	.dev = {
+		.release = cxl_acpi_device_release,
+	}
+};
+
+static int __init cxl_host_init(void)
+{
+	int rc;
+
+	/* Kick off restricted host (CXL 1.1) detection */
+	rc = platform_device_register(&cxl_acpi_device);
+	if (rc) {
+		platform_device_put(&cxl_acpi_device);
+		return rc;
+	}
+	rc = platform_driver_register(&cxl_acpi_driver);
+	if (rc)
+		platform_device_unregister(&cxl_acpi_device);
+	return rc;
+}
+
+static void __exit cxl_host_exit(void)
+{
+	platform_driver_unregister(&cxl_acpi_driver);
+	platform_device_unregister(&cxl_acpi_device);
+}
+
+module_init(cxl_host_init);
+module_exit(cxl_host_exit);
+
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(CXL);
 MODULE_IMPORT_NS(ACPI);
-- 
2.30.2

