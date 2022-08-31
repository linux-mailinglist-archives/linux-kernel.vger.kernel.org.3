Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C375A78C7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiHaISA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbiHaIR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:17:28 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF53C59D0;
        Wed, 31 Aug 2022 01:17:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMXmgGwtgBAdc7bjvQNfZKi3M0p9gc89ekzfuiYkY1zYFgwBxLllJjK6cS25Ph95V0FgujFPs/VJMH33RuzEd9hUVl3hm0wjR442/epUGF5WcL7lZAQPlgnkHAbP6PqPBJRBrJ4O1O/REUSVMo1bCYnxKsszEvTvj76+eO0HoplTg4txUd0iE5n8vagYFRb6sNgLjwbhx03CLOpAA+AlmXounpzLYj+xVkqYil6gAAVz+a7Q9kcDE0AijFxEjROnkhxWsIOYt9hcdH71goDyBI8uo/ippL4EV9QRr17GdQFii7f5NCMjgcclyd73lKSNVzVZkojKa77XGvii60Pz5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PoviwZVPNLcYTYalH4CFjJxP5kWwzC64jvAekJwioO4=;
 b=V5MK7x9vBptoYoVRI/mKe0eXyfLGzlhGJjH8JwiVhDpLWHyVzj8zced24M7rVNQawzMaTo0mnjz17N4g+dl024GgxXh/uWrTa61bBPG07Ot/7g1zYLO8sdMDxhFLB1LRHdNQQ+aMsdaTdXOKOcut2FaS5llAhnumjm0tXEN7vQDlXu1xI6fCmZSV73oVZmLeQOGdqDU0KHxo0LBWEW/jPHpSEualApBnTv3PM4lOl7Lw2wa4NVM3XsiLsGFa4x6mFK2QseTHipAo61jcUGpjTjbUvTZVWbJUH+7nM2chP2lgvqX2InDg/z1xH4r0Q8u2YT1KNoCnU9zrk8X7HCAIUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PoviwZVPNLcYTYalH4CFjJxP5kWwzC64jvAekJwioO4=;
 b=UBmjm6ieSYKedlqPg5cSxXasIYnSEuGm42819a7xb06nyphm92ikNAHIWDpu9tBbvXRL2tzcg56NUuTE0rHKm+JbWqfMJDAgt/CSYHcbgVrXn8qyKe1VMM19fcS8zC3f91WK15/0NurmGb60QTZjsElOpumQZuPTp5A+oPsnQoI=
Received: from MW4PR04CA0250.namprd04.prod.outlook.com (2603:10b6:303:88::15)
 by BL1PR12MB5350.namprd12.prod.outlook.com (2603:10b6:208:31d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 31 Aug
 2022 08:17:01 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::3a) by MW4PR04CA0250.outlook.office365.com
 (2603:10b6:303:88::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Wed, 31 Aug 2022 08:17:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Wed, 31 Aug 2022 08:17:00 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 31 Aug
 2022 03:16:57 -0500
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
Subject: [PATCH 08/15] cxl/acpi: Check RCH's CXL DVSEC capabilities
Date:   Wed, 31 Aug 2022 10:15:56 +0200
Message-ID: <20220831081603.3415-9-rrichter@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: f7b1bb8d-d717-4eed-8d69-08da8b292deb
X-MS-TrafficTypeDiagnostic: BL1PR12MB5350:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n914PJTb7HvsA+vcqP9NOjf7f/ObOKmyhSJF1FXMDA0AIvg8V9wKEsAOdONATKZuJoTX3HiV9kT8p70pUU9HfbBsTf/FdPnunj7c4n5C1vqJSmuPeK5VSrMQ0Bo8YPTsdRDxY6UFmiXsBo7x87z/6aTzGqoDVLfLHmdqBrZMJXio+ag1j56E8Eew2KIbX3KxMmqa6lrnZH70U4pEZYOi7LzH2RXu/ZuiAUhwEnb1Qvufz0py2swDg9djCPo5XyyFjn+EKP1gqVKw4HGbHWpknB4FXEfb60Lsc998YU/OvN9cn50alkJEvOZf2jS+AhWwQ2Q140x81ODf4znMN+K5JMMH94PSu0S4twSRIC+Du9hKXLD2M32VzKK45rj8olRV5wHP03sHgP48tjfLqIxTlB0VpT0oT3I2fFUZ6x861/DaBWopyh3unickKHE6mevdbbAty70GVpGcxyJn+vuLZ+yweBlYnPeth8km4b8Vmwun34kBUB4umZDEP8GBd4uUHBgePiaAmwNOWhPS7/OQ8KKZ9acKwo0vC/KSNS0hHndFyQ8AN1goGEoDRLCPZDmF0yXW1kDlLpkKVVVomFq/ItkYp4lFR3iti+GnuPxG+gxrfv1Cn+2PE+LOJxBv8ivv6373kApg4t1c+uNg6D5Eqn3MjBNhETGLZEO51yX2BvAZgFkWKhzePgIXfUbvnpz0M+G3t8Z+yCmRbNmKmsevawe+YQVCcXJ8NvuHkO9d+aa08MHXPyBvVeyWUpYkDvIH8J6UqNpDNy7Vpz0uIBLDoXY4PHlONcuL29G+OkfKnu5ve6bCq9TjI/kQSeUXj2WV
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(396003)(376002)(36840700001)(40470700004)(46966006)(356005)(70586007)(316002)(110136005)(4326008)(8676002)(70206006)(5660300002)(36756003)(8936002)(54906003)(478600001)(41300700001)(7416002)(81166007)(2616005)(26005)(82740400003)(47076005)(82310400005)(2906002)(36860700001)(1076003)(336012)(426003)(16526019)(40460700003)(40480700001)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 08:17:00.4959
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b1bb8d-d717-4eed-8d69-08da8b292deb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5350
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An RCH has an RCiEP connected to it with CXL DVSEC capabilities
present and the CXL PCIe DVSEC included. Check this.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/acpi.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index ffdf439adb87..f9cdf23a91a8 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -322,6 +322,8 @@ struct pci_host_bridge *cxl_find_next_rch(struct pci_host_bridge *host)
 {
 	struct pci_bus *bus = host ? host->bus : NULL;
 	struct acpi_device *adev;
+	struct pci_dev *pdev;
+	bool is_restricted_host;
 
 	while ((bus = pci_find_next_bus(bus)) != NULL) {
 		host = bus ? to_pci_host_bridge(bus->bridge) : NULL;
@@ -343,6 +345,20 @@ struct pci_host_bridge *cxl_find_next_rch(struct pci_host_bridge *host)
 		dev_dbg(&host->dev, "PCI ACPI host found: %s\n",
 			acpi_dev_name(adev));
 
+		/* Check CXL DVSEC of dev 0 func 0 */
+		pdev = pci_get_slot(bus, PCI_DEVFN(0, 0));
+		is_restricted_host = pdev
+			&& (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END)
+			&& pci_find_dvsec_capability(pdev,
+						PCI_DVSEC_VENDOR_ID_CXL,
+						CXL_DVSEC_PCIE_DEVICE);
+		pci_dev_put(pdev);
+
+		if (!is_restricted_host)
+			continue;
+
+		dev_dbg(&host->dev, "CXL restricted host found\n");
+
 		return host;
 	}
 
@@ -354,6 +370,7 @@ static int __init cxl_restricted_host_probe(struct platform_device *pdev)
 	struct pci_host_bridge *host = NULL;
 
 	while ((host = cxl_find_next_rch(host)) != NULL) {
+		dev_info(&host->dev, "host supports CXL\n");
 	}
 
 	return 0;
-- 
2.30.2

