Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665DF5A78C2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbiHaIRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiHaIRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:17:06 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5C9C650F;
        Wed, 31 Aug 2022 01:17:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4EOWw8MYIDBcCuNyFqvSHzPARdQ91J7QqmsdN2sYc1qsRHwof838UojuC/79njuO5Mh3BRhnqRyMdaHJheqX28NlYv9wci0vSD5ZnvEftWnIUezb4bwOTueWS3OVqi68CctSwdG2Ir02zZYGWAbSOV9yvZBFR/pNlcxKZKEEGPDBpI2DXQ/9fVsXM+iHN3fDOJ1WRXISYJpSdlSSIpFxPp/dhk+t0jvyAKOoU7ulg78ISfE1Si2uivxr+gfS0zoimHTbztFQcqGMFT8tknbVJQdBCJRLr5LuagU8xctX9jyiTbjSLS4nbc+7WAoa/UEjgD7UxBSIWk1q0RrHsyMhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cVB4yDHDaygl1aA4bRinjSuYPXrxKGhj/7fWwwTUHW4=;
 b=RZYhSNONxEXWSQN70w0CgYctXB0V/B1ziTu9W6iPLchPNOJOJxoWxKMK8BJgMHD1yWQhDF6lCQwvy7LhfjVamCrka10twamXvFpV0VNUYC88Yi4i8hqg+YWuH39fnLJ+QoKSvmzWYYE/YIQWYk05zKMkYm7d3c8oXO7ZXvGgvdFPDfEJ+d3nXhpB5yQBZh29gzE784Rwk6ycv5PmWKZq3I7viaEy8AfS22AKhwOjwuD5BQiW3l4PIye49mWtm0z9X1if5R5+T0LNzSTdueLskqGTaHG0YC1rG/+AyzeJqmtpkNMdH2OU5l9wHNx6q8zJuADD64HOjlnterhO8LN1sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVB4yDHDaygl1aA4bRinjSuYPXrxKGhj/7fWwwTUHW4=;
 b=l65D6olE0YogOPgMOOgDWZGVbbkzHEPMHG/nTFIqbHNdTjNXw0SmJOW6PuWPo3rkRIeVV8kO/MkqQlkROMP2RjJDOl5Lz6PAlu2uIqNeTpHUc5P5Z4psUrHUYphpHgeMxzF5rTc3wmkR55xi+Box0ayNQqQsRfw5ufE3OzKDipE=
Received: from MW4PR04CA0245.namprd04.prod.outlook.com (2603:10b6:303:88::10)
 by SA1PR12MB7344.namprd12.prod.outlook.com (2603:10b6:806:2b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 08:16:58 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::ee) by MW4PR04CA0245.outlook.office365.com
 (2603:10b6:303:88::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Wed, 31 Aug 2022 08:16:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Wed, 31 Aug 2022 08:16:58 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 31 Aug
 2022 03:16:55 -0500
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
Subject: [PATCH 07/15] cxl/acpi: Check RCH's PCIe Host Bridge ACPI ID
Date:   Wed, 31 Aug 2022 10:15:55 +0200
Message-ID: <20220831081603.3415-8-rrichter@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 372dad74-62e0-4231-b773-08da8b292c8a
X-MS-TrafficTypeDiagnostic: SA1PR12MB7344:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4uQPGTioVanKdMprnd8Sbej2+YeNydzIfkQ/82eTV0AhogQVYS12jRkEarpiFfhrqau621tI1zW97Dj4xFGbgHEUdBCZdM6Ywt7qc8C008jjlpy14cgJjUGstDy82P43cEZ2eyJne67lu0CWpGkuOlkqHV1rJxSpPWqdGAUmxe1hECjZnwpmuIPOM4DLcNKb/Du7lnttOrJ4l4Q0IMtILng+9wYd6P+1I453GDSVSqD3VttSy4RJzlHtjexo7cjDbKzGWW50RDFXWNzu8Q3t8wcUquOcIjXJLifld77l4S3LfhzqgHDAHVh433zEn2O184aRGNsoEkUn2yc6N+ZOdeU1aB/FUTF1AbgaalhAZy3ITh8K2+7TfeTRqrAEJbR4cEWeBHJfQ7J/ns7HsZr+egkYSxwZbptiU/Xc7+OtAivHEtuGXa0nrgj3VXnTPUzxmzQfCDUjbQymTheXuqAI+nsaFXy78u0e4ZTG3YejvCtAFcdFEUx9eDILNL0nlfyFg121B0NGnJTcujPq5qIu3qsGyGIfJQZfbrEFT3hGf624BH45hhTyQ4Z72EiIH/gxuh7kUsyk/O+zd8UtiYUgzGSliGcM/M3M1iyqGa9cADqmCWzSka0/fHEHklFy4x4Ap92cq2FmVsxS6Zu0oA9Th3GumGyjho7zKY4Ak0vBmsrhNkIZIU2iv8bFeeEZn6rs+tvy7Litfo3v5yCCXyTG2R9kyN7xBInGpUwjzz0Gn31dCICKUCDLjMVo582s88UP7SBLOFhdqHBA8vmc4jb32YXZMMhuROBPswZ29U4B4fk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(346002)(39860400002)(136003)(46966006)(36840700001)(40470700004)(41300700001)(478600001)(316002)(82310400005)(110136005)(54906003)(82740400003)(36860700001)(40460700003)(2616005)(356005)(26005)(16526019)(336012)(1076003)(426003)(81166007)(47076005)(7416002)(186003)(36756003)(40480700001)(4326008)(2906002)(8936002)(5660300002)(8676002)(70586007)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 08:16:58.1836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 372dad74-62e0-4231-b773-08da8b292c8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7344
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An RCH is a root bridge and has "PNP0A08" or "ACPI0016" ACPI ID set.
Check this.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/acpi.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index a19e3154dd44..ffdf439adb87 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -312,9 +312,16 @@ static int add_root_nvdimm_bridge(struct device *match, void *data)
 	return 1;
 }
 
+static const struct acpi_device_id cxl_host_ids[] = {
+	{ "ACPI0016", 0 },
+	{ "PNP0A08", 0 },
+	{ },
+};
+
 struct pci_host_bridge *cxl_find_next_rch(struct pci_host_bridge *host)
 {
 	struct pci_bus *bus = host ? host->bus : NULL;
+	struct acpi_device *adev;
 
 	while ((bus = pci_find_next_bus(bus)) != NULL) {
 		host = bus ? to_pci_host_bridge(bus->bridge) : NULL;
@@ -323,6 +330,19 @@ struct pci_host_bridge *cxl_find_next_rch(struct pci_host_bridge *host)
 
 		dev_dbg(&host->dev, "PCI bridge found\n");
 
+		/* Must be a root bridge */
+		if (host->bus->parent)
+			continue;
+
+		dev_dbg(&host->dev, "PCI bridge is root bridge\n");
+
+		adev = ACPI_COMPANION(&host->dev);
+		if (acpi_match_device_ids(adev, cxl_host_ids))
+			continue;
+
+		dev_dbg(&host->dev, "PCI ACPI host found: %s\n",
+			acpi_dev_name(adev));
+
 		return host;
 	}
 
-- 
2.30.2

