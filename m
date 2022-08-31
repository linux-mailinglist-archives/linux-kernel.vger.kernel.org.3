Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366BF5A78CD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbiHaISz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbiHaIRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:17:51 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E75EC6B6F;
        Wed, 31 Aug 2022 01:17:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kzds1h/SkOy5tZe7Ju2O/1g5p87vERiQnbwAjy+WSZF0/yAwzrOcIrxNTR7VnpnxWeDL1oXghKaTHgzRF3dkHJcIO7AHE34jd4AxmYTmdpxaI45gdkJpkxccUAQUjvkFxAgonrWoPATANpnqpGAqG9l4X0IObmJP0GdQEaWecZg7f1bdjtR+6/N5MAA3sRtH/99d2K2QJG+HSi/wAW/Tvz4mmHKMopwzGtYihq/YnJnwC2vW7B4QAJl8BGbfVdb2lWP5ASWW9XCab+sRkvYeV/t4HFM8d2s/HCtTsvagnmOKrvp4DyZvHjaStuCBUrmxgB4MF8Z35+lRvFQlHXkWjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tD11eTB7Seon+9xLVhsmgPup6swLgTbyewqtaoOHko=;
 b=ARTvR0WEkSjfgvAux3Grh6Iw6Qa1VRpl/Ax+vJ6qpeNYwq4A6dV4yfbVSEAzfuGIWrR47/x+VsPgj6HeodZczp/0072IaXxgj+SNgSPE5NLaZ6HwATaXjn5f2nGMutkLqf4BlqTrvFQ2+s4z4zbfs+g6bDmS3DNOyJ2DG2Well4/c6Os1/aHOF7KdvyM9HPEYtun0zveykdbCrg0L6huSivWmtb9kqjBSBTG2XncwuypI1qGP0En4L3U/CEy7e1QE8qcClAowbaOKD760xQG1bn6k3y5yMgTeZQlWMpN/I2BH1uuvP28uUp4mJs2jBpeB5E5hJCJiIDB8ABwCyQSmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tD11eTB7Seon+9xLVhsmgPup6swLgTbyewqtaoOHko=;
 b=T336QQElAfh6AskhY0rfDZqBdGLYNVx3YiMpHVC9qMF4xSAK1qAdcd6f/JKqG57PG6j3Pbx/ivuD8bQp4zaK/s/7DMSW5EKHZG4c8Qn0RTzz7b4OJeOe3c9iLnbjX98shpfGuRPGyFwIkb/YQcJMs5V8qMcv3DP1Q/lDWvXgHK0=
Received: from MW4PR03CA0065.namprd03.prod.outlook.com (2603:10b6:303:b6::10)
 by MN2PR12MB4334.namprd12.prod.outlook.com (2603:10b6:208:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 08:17:17 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::c5) by MW4PR03CA0065.outlook.office365.com
 (2603:10b6:303:b6::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Wed, 31 Aug 2022 08:17:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Wed, 31 Aug 2022 08:17:16 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 31 Aug
 2022 03:17:13 -0500
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
Subject: [PATCH 14/15] cxl/acpi: Enumerate ports in RCD mode to enable RCHs and RCDs
Date:   Wed, 31 Aug 2022 10:16:02 +0200
Message-ID: <20220831081603.3415-15-rrichter@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3bb18cbd-c17b-41c4-3d13-08da8b29377f
X-MS-TrafficTypeDiagnostic: MN2PR12MB4334:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T8IZVY5j7IvAZ5OtvnEgBLWS7AtGGMplMlUfR+aDDntg8SmRq4BSpwDQzXZYIqN3OOUPXG+6nxB4khU7SqCKNhL19SrxaSLPFDnxWa5lb0d2FVa1eM7q4r+vnuCpp221XJqvAXfQh7le+ubdnomHs+rNmUQJ4SfhsRCJtGoWR09DIxd5MHvMZBeYNs2PbdrsZUKxH4wQp25R6+teJ5jc3/lNphH410CyReKi9VTS2HGOGOJg6XYDmZHc9ZvEKR5+BfqSFCn0Xv+fcDGh9DbtblkK9GQalGVea9OCeOC2080zf7Sr8bjhtcCU8SMk6qq0GTmFcP3ZSSU+j0wk5BBzWnU8/6sxl6+3Mm78s3UuVX5Vc4PjMpOcpiC1TQFG7S3wIEnEfmy1MJUd9K69tFcVVtkasTFCxYeeiQ4YkbHctzFD/MDDNcjxb3iBb45u9R4pD59LPXDOQs+jngO10wgjMGl+q87/m8zG33vKeSjzgSm7SNcII9R3OMmPUE5vqONcPkXvpkJIO5XlIo7oBntUH6rOEL1qq8fAw0GfoZrnBmXFAQpFnRcYSsi1+r1s2QkCBW4CLDhL3J1+p4R6CRAkJrYjbLlrwOlUwmZ3NJH4+/D3+R5i4FMDIOyfLI80c3CoHlGczWeZDcASPtf5v1NADw6W9Qr4y9Av/DpXLdAX4bFYcCzWeECpewlr4tx+wpKSgydLwJkum9+By0/wAdy238mTwLEdwbE0QJHtlvlUfWcWj0oTnokDb/JB2Zat0fF+feZWNvVmqjKBciu0etKQmXOi+Zd5X8uwAZ90sBNOT/C53eYouQXJvHpvMFP9nRcJ
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(39860400002)(396003)(346002)(46966006)(36840700001)(40470700004)(8676002)(478600001)(26005)(4326008)(8936002)(186003)(41300700001)(336012)(7416002)(5660300002)(40460700003)(47076005)(16526019)(426003)(1076003)(6666004)(2616005)(82740400003)(70586007)(2906002)(70206006)(316002)(54906003)(82310400005)(110136005)(81166007)(356005)(36860700001)(40480700001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 08:17:16.5477
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb18cbd-c17b-41c4-3d13-08da8b29377f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4334
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do the plumbing of ports to enable RCD/RCH pairs.

Do this by enumerating all necessary ports an endpoint needs to
connect to. This includes:

 1) A CXL root port with dport links to the RCHs. The port links to
    the CXL root platform device for RCH mode.

 2) RCH ports with dport links to its endpoints. Port connects to the
    pci host bridge device.

 3) CXL device endpoint connected to the RCH.

The port creation for the endpoint (3) is already implemented and
works in RCD mode too. Thus, it is not scope of this patch. Only the
endpoints must be registered at the host bridge port.

Implement this by introducing the function cxl_enumerate_rch_ports().
It registers a CXL host at the CXL root device, creates the host's
port and registers the existing CXL memory device endpoint at it. The
port of the CXL root device is created with the first CXL host being
registered.

Once enumerated, CXL restricted hosts show up in sysfs with CXL
devices connected as endpoints to it.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/acpi.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 88bbd2bb61fc..56b2d222afcc 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -471,13 +471,52 @@ static int cxl_setup_component_reg(struct device *parent,
 	return 0;
 }
 
+static int cxl_enumerate_rch_ports(struct device *root_dev,
+				   struct cxl_port *cxl_root,
+				   struct pci_host_bridge *host,
+				   resource_size_t component_reg_phys,
+				   int port_id)
+{
+	struct cxl_dport *dport;
+	struct cxl_port *port;
+	struct pci_dev *pdev;
+
+	dport = devm_cxl_add_dport(cxl_root, &host->dev, port_id,
+				   component_reg_phys);
+	if (IS_ERR(dport))
+		return PTR_ERR(dport);
+
+	port = devm_cxl_add_port(root_dev, &host->dev,
+				 component_reg_phys, dport);
+	if (IS_ERR(port))
+		return PTR_ERR(port);
+
+	pdev = pci_get_slot(host->bus, PCI_DEVFN(0, 0));
+	if (!pdev)
+		return -ENXIO;
+
+	/* Note: The endpoint provides the component reg base. */
+	dport = devm_cxl_add_dport(port, &pdev->dev, 0,
+				   CXL_RESOURCE_NONE);
+
+	pci_dev_put(pdev);
+
+	if (IS_ERR(dport))
+		return PTR_ERR(dport);
+
+	return 0;
+}
+
 static int __init cxl_restricted_host_probe(struct platform_device *pdev)
 {
+	struct device *root_dev = &pdev->dev;
 	struct pci_host_bridge *host = NULL;
 	struct acpi_device *adev;
+	struct cxl_port *cxl_root = NULL;
 	unsigned long long uid = ~0;
 	resource_size_t rcrb;
 	resource_size_t component_reg_phys;
+	int port_id = 0;
 	int rc;
 
 	while ((host = cxl_find_next_rch(host)) != NULL) {
@@ -497,11 +536,30 @@ static int __init cxl_restricted_host_probe(struct platform_device *pdev)
 
 		dev_dbg(&host->dev, "RCRB found: 0x%08llx\n", (u64)rcrb);
 
+		/*
+		 * For CXL 1.1 hosts we create a root device other
+		 * than the ACPI0017 device to hold the devm data and
+		 * the uport ref.
+		 */
+		if (!cxl_root) {
+			cxl_root = devm_cxl_add_port(root_dev, root_dev,
+						     CXL_RESOURCE_NONE, NULL);
+			if (IS_ERR(cxl_root)) {
+				rc = PTR_ERR(cxl_root);
+				goto fail;
+			}
+		}
+
 		component_reg_phys = cxl_get_component_reg_phys(rcrb);
 		rc = cxl_setup_component_reg(&host->dev, component_reg_phys);
 		if (rc)
 			goto fail;
 
+		rc = cxl_enumerate_rch_ports(root_dev, cxl_root, host,
+					     component_reg_phys, port_id++);
+		if (rc)
+			goto fail;
+
 		dev_info(&host->dev, "host supports CXL\n");
 	}
 
-- 
2.30.2

