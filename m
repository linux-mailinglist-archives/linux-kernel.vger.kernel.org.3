Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9105A78C8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbiHaIS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbiHaIRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:17:48 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB86C6954;
        Wed, 31 Aug 2022 01:17:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7GOQjEDGJ0dtIp03ncxt/UOclDvY5jnBF7GXW9mx3dBcax1Jttnb2jQYAPcoJu9IUIDeRN3cuc6bubUPyXSRHQxlC7DEtLtUTQ1NvHkrshjB+oBVIC9XHAQfXPa74swRyNc32HosYdy5nLj61QF0KQt+/of8m/apcWBOce/X+9oNEktYs+Ftc3EkYTk2WfV2Zf/Mvlg2LaBcxvpXvcVFUY4AsVcgjsMVtaE2Xte7W06SVJGyHZ7lpdhkVVmlp1crV6qEiKWY0iAsQQRzV9zWhDFROn6SeqohsxUOyCXH3/ybU3g8QcZbQqTz1e5KQbjGRThP8D11P/F+TquTYau9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAQ21ronJ5wXoc2m9ir1X7VABURfwzylIVMW8sW83lk=;
 b=BBT6Qoe+p9izQ9lmkGRxQSVLwKF4OLWQOW+n+dvOjEs3UTLG7PcgM3yod+gWa9ttLErW1NjYhK+FYZhTbSvcdkokGT4e02Xw477/64ayM12kP+SaKHOSHFTd2PiQqi+alxB15tr21YCwYF+8KfMZk1jm8uEDLRdyG3PqM+uyTCl+hUK7/WJAB8OBDD4R7PswBS6mZsb4X3m4ShGz0iAKa0BzopudgmoJvVQvb0GLShMLbNwGHHpXecoa1q9kIkWa8+Of/pLzeZUxMxm8OhP59ysjWsCXHQpaYNb1cH2XTBJUTeTdi7HybCIGxZrS/xbRG1ldPrGMzL/HnGFcsafFAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAQ21ronJ5wXoc2m9ir1X7VABURfwzylIVMW8sW83lk=;
 b=l3HyvTynqPaQQNtexKiQO+JAZCefaj13BFbJ80EKwNt8CuAcdIuSv8rVaQwMgiI/88Bv9iDIzB6+c0zhoKmJuNfi7tKKLu+y+7qdzJmO2+Kt32Svy7xvHHFMoorYkLBYWMZzs/PxOxGycGh8Suh0trNGZWRX2dh+BhB7nS4FAWA=
Received: from MW4PR03CA0205.namprd03.prod.outlook.com (2603:10b6:303:b8::30)
 by LV2PR12MB5872.namprd12.prod.outlook.com (2603:10b6:408:173::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Wed, 31 Aug
 2022 08:17:09 +0000
Received: from CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::6d) by MW4PR03CA0205.outlook.office365.com
 (2603:10b6:303:b8::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Wed, 31 Aug 2022 08:17:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT109.mail.protection.outlook.com (10.13.174.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Wed, 31 Aug 2022 08:17:08 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 31 Aug
 2022 03:17:05 -0500
From:   Robert Richter <rrichter@amd.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Robert Richter <rrichter@amd.com>,
        Terry Bowman <terry.bowman@amd.com>
Subject: [PATCH 11/15] cxl/acpi: Extract the host's component register base address from RCRB
Date:   Wed, 31 Aug 2022 10:15:59 +0200
Message-ID: <20220831081603.3415-12-rrichter@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 682f27f5-b0b2-4607-d48d-08da8b2932f0
X-MS-TrafficTypeDiagnostic: LV2PR12MB5872:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vo45bC94gBVvI35we4tqHBSfPENmEXfgpBt4KjOqj1VY59N0N8vDBgF5vfqbLq8IAa1pOTVBY0LRsbN2t9IupMqkb6Eku2XOR78HVWXl3F/mKdt1hrnlSJNWZptoSJRlmRNjrO3md91hXp0svpo84S/bmp4MHfIt6sk+wTOt135bqjXNmKN0uQYuWUIYlvCf9wxpBruhU9Mpmk311BzDLRUzAcpYe4OoP6fhdtX7O25+m0zIlUMjkqooltPOzKNFxO9LfLP8TiY8wPqH6LKhEKtBnOX3SAgv+OfnXXLEm1UJhiWY7CPAstYP349gpaonXzQTFH+vTbjEEUD/hGqFXa0rsqZzBzSxGSDPc6Li6drXg/c0QmGogbNdthlifBawo6s8mZcH6qD9k977cj/MpeAErXVoH9lrXobJOfAPdj1kxZhprJ0Hj9nkCrWNk7ep1mRHP7jbwbd6evuUUlLLNX+f3+ta6sc7gtWFt9ClLHyka+NVJF4L6KAtisKhZ2e64wuOl3ev+qn18PUu2NJ96Jnsz6jKrAHb2XPqaJcKzevvz0u/5iITj2MBoStRlt1tP9tXtwpjcOCWi1Z9s1kmn5D9sVp0xUX7CkD/N1MYTWjPAYUGXfZXq+FdmpxhwiYv3N0aJruA8cGOgGgOfEaZroOde9VaBq5SVJlwGnESwrMmXT8cWtgcY9DMTZSRkoPROY1GMUkl8w89p6F9NN70YE/5bQCNFrZyNWtwAuSRc89CFQsMTcO+eDloCfTbytaiOlaH09IGXw4sH1Lcj+WuF3KzpnnZD69GiwnB5LTavEo6ttVbBCh/7bNTr08LiADF
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(346002)(136003)(39860400002)(46966006)(40470700004)(36840700001)(26005)(54906003)(110136005)(1076003)(81166007)(70206006)(316002)(8676002)(40460700003)(36756003)(4326008)(70586007)(478600001)(41300700001)(8936002)(5660300002)(7416002)(356005)(6666004)(82310400005)(82740400003)(2616005)(2906002)(40480700001)(36860700001)(16526019)(47076005)(426003)(83380400001)(186003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 08:17:08.9191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 682f27f5-b0b2-4607-d48d-08da8b2932f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5872
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A downstream port must be connected to a component register block.
Determine its base address from the RCRB.

The implementation is analog to how cxl_setup_regs() is implemented
for CXL VH mode. A struct cxl_component_reg_map is filled in, mapped
and probed.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/acpi.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 439df9df2741..88bbd2bb61fc 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -401,12 +401,84 @@ static resource_size_t cxl_get_rcrb(u32 uid)
 	return ctx.chbcr;
 }
 
+static resource_size_t cxl_get_component_reg_phys(resource_size_t rcrb)
+{
+	resource_size_t component_reg_phys;
+	u32 bar0, bar1;
+	void *addr;
+
+	/*
+	 * RCRB's BAR[0..1] point to component block containing CXL subsystem
+	 * component registers.
+	 * CXL 8.2.4 - Component Register Layout Definition.
+	 *
+	 * Also, RCRB accesses must use MMIO readl()/readq() to guarantee
+	 * 32/64-bit access.
+	 * CXL 8.2.2 - CXL 1.1 Upstream and Downstream Port Subsystem Component
+	 * Registers
+	 */
+	addr = ioremap(rcrb, PCI_BASE_ADDRESS_0 + SZ_8);
+	bar0 = readl(addr + PCI_BASE_ADDRESS_0);
+	bar1 = readl(addr + PCI_BASE_ADDRESS_1);
+	iounmap(addr);
+
+	/* sanity check */
+	if (bar0 & (PCI_BASE_ADDRESS_MEM_TYPE_1M | PCI_BASE_ADDRESS_SPACE_IO))
+		return CXL_RESOURCE_NONE;
+
+	component_reg_phys = bar0 & PCI_BASE_ADDRESS_MEM_MASK;
+	if (bar0 & PCI_BASE_ADDRESS_MEM_TYPE_64)
+		component_reg_phys |= ((u64)bar1) << 32;
+
+	if (!component_reg_phys)
+		return CXL_RESOURCE_NONE;
+
+	/*
+	 * Must be 8k aligned (size of combined CXL 1.1 Downstream and
+	 * Upstream Port RCRBs).
+	 */
+	if (component_reg_phys & (SZ_8K - 1))
+		return CXL_RESOURCE_NONE;
+
+	return component_reg_phys;
+}
+
+static int cxl_setup_component_reg(struct device *parent,
+				   resource_size_t component_reg_phys)
+{
+	struct cxl_component_reg_map comp_map;
+	void __iomem *base;
+
+	if (component_reg_phys == CXL_RESOURCE_NONE)
+		return -EINVAL;
+
+	base = ioremap(component_reg_phys, SZ_64K);
+	if (!base) {
+		dev_err(parent, "failed to map registers\n");
+		return -ENOMEM;
+	}
+
+	cxl_probe_component_regs(parent, base, &comp_map);
+	iounmap(base);
+
+	if (!comp_map.hdm_decoder.valid) {
+		dev_err(parent, "HDM decoder registers not found\n");
+		return -ENXIO;
+	}
+
+	dev_dbg(parent, "Set up component registers\n");
+
+	return 0;
+}
+
 static int __init cxl_restricted_host_probe(struct platform_device *pdev)
 {
 	struct pci_host_bridge *host = NULL;
 	struct acpi_device *adev;
 	unsigned long long uid = ~0;
 	resource_size_t rcrb;
+	resource_size_t component_reg_phys;
+	int rc;
 
 	while ((host = cxl_find_next_rch(host)) != NULL) {
 		adev = ACPI_COMPANION(&host->dev);
@@ -425,10 +497,18 @@ static int __init cxl_restricted_host_probe(struct platform_device *pdev)
 
 		dev_dbg(&host->dev, "RCRB found: 0x%08llx\n", (u64)rcrb);
 
+		component_reg_phys = cxl_get_component_reg_phys(rcrb);
+		rc = cxl_setup_component_reg(&host->dev, component_reg_phys);
+		if (rc)
+			goto fail;
+
 		dev_info(&host->dev, "host supports CXL\n");
 	}
 
 	return 0;
+fail:
+	dev_err(&host->dev, "failed to initialize CXL host: %d\n", rc);
+	return rc;
 }
 
 static struct lock_class_key cxl_root_key;
-- 
2.30.2

