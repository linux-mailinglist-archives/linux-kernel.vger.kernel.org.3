Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409415A78CB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiHaISU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbiHaIRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:17:46 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FDFC6B6D;
        Wed, 31 Aug 2022 01:17:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=etrKwr49L9l5gwhkYQtweUz99Z6a0sRYNLA0+teNXVsqAmU6FqzhfRwthlCBAso+J7fpcvnJoOMIu2RfDzCXUDqEZKohqg0PKTFbTbmuqdxBfo7kxozg4KKwB0tCKkvYRavJzqL2sr0hQ31VXXO46U25S4lsvq8ZKW+v+4eN+NPq93rBwgUjYgpocr39t8CMyizjBSINj1Vp8AAckI5Y0hShY+vWT7mPgpcE8UNK7TAAuspsEFaFujmegaiTuGth6SeCVbsBiZaErlQAyazHgGEZu0Hm7laLRF3DPTSsTGNhNLac2BCsqm7iXb5w3gzSPuO83oNQh3DfirB36mDoYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SsnhNCKPTAHYFFnSjZCo3SPpqvwq1VPCUKkE9GXII/Q=;
 b=jzZKnPTx/b0Iw5uScEWUIhZe2tOu8Fu9UQvm63yXmNRzcPlHg8cVM4YRQF5OGS+41c2wXmyiI/Fzc6+c4Dbp7KzFW43/P0LjToDMDChP81kx1yXEhuoUKmwlDrjNM+5d8aDkAB/vqMdePikN4+9esDZKgnnhTPnMeMJVz8fGcl7dKEjS2glvr29vxUFivTmsJSi98OlxRKQcfl7hCp8DG4jMSM4jt44j0abB8yugNbP3/lwfy6o+u8zJHe1XLj9CWHSq5kUqH0IopgLbKPNmu6NqSCP2xIMF0bzP7dSgss/kLtSIcS7b4Fu4K10vW4u5rwQwjwGkoE8miLiOraWYlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsnhNCKPTAHYFFnSjZCo3SPpqvwq1VPCUKkE9GXII/Q=;
 b=uJea5qe2l3jCJFTSAcASgNgTJyuQIHBD7OBTVl4L7WKq8gyaF9PiA1qkJoKbHIXE+Teb3UoA1PkkmE/a6LXUKRCdO87ctZNeEdocwxHztkMLqnxATN43o9t0pBZUSf4uJ2C7PDlBrWayRu5TzWf+8sKOMssaiK973PmAr9SoXzg=
Received: from MW4PR03CA0207.namprd03.prod.outlook.com (2603:10b6:303:b8::32)
 by SN7PR12MB7346.namprd12.prod.outlook.com (2603:10b6:806:299::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 08:17:11 +0000
Received: from CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::57) by MW4PR03CA0207.outlook.office365.com
 (2603:10b6:303:b8::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Wed, 31 Aug 2022 08:17:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT109.mail.protection.outlook.com (10.13.174.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Wed, 31 Aug 2022 08:17:11 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 31 Aug
 2022 03:17:08 -0500
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
Subject: [PATCH 12/15] cxl/acpi: Skip devm_cxl_port_enumerate_dports() when in RCD mode
Date:   Wed, 31 Aug 2022 10:16:00 +0200
Message-ID: <20220831081603.3415-13-rrichter@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 911d3b03-8eff-41b8-81dd-08da8b293469
X-MS-TrafficTypeDiagnostic: SN7PR12MB7346:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BC3V7m72CdyCnqmdNBN+5WDI6W+WfoljQDczVc9mKdR76gCWCmfrCre1EETUQ6B8bFOJXpIvtt0eFxQdPq+aDlvVPqRd1TO9pnmQgRqgJ2M6+rCrNsgYlmymD0B6UpR2hRmWFdRzckfePu4qljPWFsApLwHzDQ10+hHIfDWWqe/s08XstNR/4u0YJcXSJsojCPTJVHmegM+eeTdBh1FdGJXZelnJN/CyFTJdFOeqx69r3BiGfY8K26Tc3UZd8uEuNSlsqmgB9y/ZQ+g3JrhjqOunysMjiIzu4ngOSDAwFHOpBHwu3/KlFEhQvyIqD18UPVERYChpK8NaVHAIpikiAxEKOKqMkF6g4YEYAMjDtjqucUz5MhSAlmHN2KMtGwEpeMP/pBCsf3JVroGYK+HUlszKJDet4EcAGxerw+ArNfOV0xUrohNl9/ynNI5pCwPpz744p9VCIj1DACxw151c9bJOZHkBDJIGRMYV2asr++BRoTyzzHQRL96opZhSxaQDmZV6TTbeqi50QsjSqiMX5A59X3HBqNESwwAI9e/Hgg+GLDZlSikMj/mI8Yy/OqTYYAW1VyQtFGhOhOE4o9IXlBKtvQM0TITyAjqrq8xpNVO2mEArx2w9sSnVnazEVW/ajBF6x6dkjIp+QaQNcVAjMj9JTF+QDYjBamSlFXBujMROyDUA41VBlXRH6FZGmWNJk2uw9Dvlcxq3+UYvxruuq6akyRA8QFjsG+GdMD0Syi2M4XMw5UQ6nAEiAEIGHYPJxJCEIq00SmGaqwM0a7QABEEkXZKV6ppRkBrD/YybdF3OzQEhA/SQ6XdWwQbwCpst
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(39860400002)(346002)(136003)(40470700004)(36840700001)(46966006)(478600001)(6666004)(41300700001)(40480700001)(36756003)(316002)(26005)(82310400005)(54906003)(110136005)(356005)(81166007)(426003)(1076003)(47076005)(16526019)(186003)(2616005)(336012)(83380400001)(2906002)(5660300002)(8936002)(4326008)(8676002)(7416002)(70206006)(70586007)(36860700001)(40460700003)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 08:17:11.3721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 911d3b03-8eff-41b8-81dd-08da8b293469
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7346
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RCD mode has a different enumeration scheme other than in CXL VH mode.
An RCD is directly connected to an RCH without downstream and upstream
ports showing up in between in the PCI hierarchy. Skip dport
enumeration for RCHs. Upstream and downstream ports of RCH and RCD
will be setup separately in a later patch.

Introduce the function is_rch_uport() to detect an RCH port. For RCHs
the parent root port is not the "ACPI0017" device and instead does not
have a fw node connected to it.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/pci.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 0dbbe8d39b07..86ed112eb262 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -65,6 +65,15 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
 	return 0;
 }
 
+/*
+ * A parent of an RCH (CXL 1.1 host) is a plain platform device while
+ * a 2.0 host links to the ACPI0017 root device.
+ */
+static inline bool is_rch_uport(struct cxl_port *port)
+{
+	return is_cxl_port(&port->dev) && !port->dev.parent->fwnode;
+}
+
 /**
  * devm_cxl_port_enumerate_dports - enumerate downstream ports of the upstream port
  * @port: cxl_port whose ->uport is the upstream of dports to be enumerated
@@ -74,10 +83,19 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
  */
 int devm_cxl_port_enumerate_dports(struct cxl_port *port)
 {
-	struct pci_bus *bus = cxl_port_to_pci_bus(port);
+	struct pci_bus *bus;
 	struct cxl_walk_context ctx;
 	int type;
 
+	/*
+	 * Skip enumeration in Restricted CXL Device mode as the
+	 * device has been already registered at the host's dport
+	 * during host discovery.
+	 */
+	if (is_rch_uport(port))
+		return 0;
+
+	bus = cxl_port_to_pci_bus(port);
 	if (!bus)
 		return -ENXIO;
 
-- 
2.30.2

