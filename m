Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E96D5A78C5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiHaISK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbiHaIRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:17:38 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBD4C697C;
        Wed, 31 Aug 2022 01:17:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=llA89JxQCdbPj6buUTP1xqejwdcLV+oTrhsD0yhdrZcPWOsYyXwLj7qmQD2+yL/h5ybuEPRcGOSiwr7HA5JDDtdyVFyHB0O4IZ38jHqPVUiGC99azq/uh9KH9zYuYCD+NeGmaww4JY7OCvbFVOgLqOx9NdOw7NIDJvkDYbwsbq9mwz4OJkktcUqGKKw7Dy8UnszHbpLd6+RyZo2DFqRk13HevLqax9cGLvt+L8fFe0QusEm9xTl5khAPFjVy2DGJHMHiosAWd6CpveMP+2SkGKv9bGaVmbM9hX9ZLsaRreuXQvM4m9Nc7k0y1qouADpVvyF+EzChkiqriosx1VcvPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=um7hzKWI4ePkiyGH3rZmr4gvxOVSzvmMAV0swzZYtp0=;
 b=LHv+KszgB4Ax6so+JMWjjQaCPlMuYB9zJhDb3aAyx5p0Qp7n7z55JkzADpdgRpQO3y6+5WWS+yzg179ITc6LX01aoXz5lWR89nA6Hyel3RltX1t38zj0A0IiV3WbwwJROj1cdnCgULRrlo3NeTASyc9aQxDHjSDJBzm/paFcUSD6/bmLkbyBRNfCv4xb1cfRKEig4ZWFaz1f2yFW+U0GXUtztVDx+rTfIzv1z50Pjs46uGBvFJmnT2E1bnlsmorMi34mpFSBi0lLMChKRF8GMiqmOY8thTBZab6CRpNO3wPSOtLrPvjjBOgmAl3QkwyUH38QZKwUb/e1kmQIfJ3Iug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=um7hzKWI4ePkiyGH3rZmr4gvxOVSzvmMAV0swzZYtp0=;
 b=JAe4u7xyvym6GUlNLa8CPwr3cAFqxZhN9ZJNQA/NYiFnhA3HmxpYlA4TZwuL8dkE067hQEvcFqhTfvBEuDabDpY+8dmrKvrY3rzvp9VbDJ10cnb3foKFdYu6V5uqbEgSYsQcX7lVxpGep43ng51KXsh5JCZNIpvZ0612zanpN2E=
Received: from MW4PR03CA0268.namprd03.prod.outlook.com (2603:10b6:303:b4::33)
 by CY5PR12MB6371.namprd12.prod.outlook.com (2603:10b6:930:f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.28; Wed, 31 Aug
 2022 08:17:06 +0000
Received: from CO1NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::af) by MW4PR03CA0268.outlook.office365.com
 (2603:10b6:303:b4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Wed, 31 Aug 2022 08:17:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT085.mail.protection.outlook.com (10.13.174.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Wed, 31 Aug 2022 08:17:06 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 31 Aug
 2022 03:17:03 -0500
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
Subject: [PATCH 10/15] cxl/acpi: Extract the RCH's RCRB base address from CEDT
Date:   Wed, 31 Aug 2022 10:15:58 +0200
Message-ID: <20220831081603.3415-11-rrichter@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: f56fa265-d6de-4c00-dd9e-08da8b29316e
X-MS-TrafficTypeDiagnostic: CY5PR12MB6371:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xoMMCQwC4iE2tyuJCkHx1IWt6sLAEK4VKUPiSoW88MKTCD5c2E51NUrY/R5Nb80Sl44owfDgqoTW7bD9MR7HIJONK16SwkeU3qpsV3oB84tKHHhFv5HbZ8f2VXQxUVLXWp65qvN9i5MBrJFSPvXAVr0LVj9/W6wL+hY2UMEb4jTOa8R2RElgFDHdAusNFnm38v1A9vJRSxp4x7RBinv6lnqDOcP7pDRQcD9EMlJuCb9zVfObUXIwQ3DJm6mKeQbpLYBKep9sF1Zj31QNNTwf95sxIUpX2l4OrXRnZLqD6E/8i2LqfS8YtLTRwnhBo8QSQ71M0FESatLxCEUy/5YVuRNpbTYUlxJPX6aFhesYLeaHM+qVQkQd73IWeQ7ra5We0hyL0m6CyfRT24aLLYAfy9UvLNxOOWt/97yBzLSLExAZATtKTeeOy54YiSBpRWemSqw9Gb3a6/VOt08H1yaGykjQPCOvFtAAjuteuD8IvIC6UlToknffmlcfuMSP5jX4cSpRQ3A4+m61gIEcV31nxOmanUMe0rgGciOb1DwIFZwybY8lySPo+cdmcTieCrIgcHzKx6fTLGb9mKpLNzF0/f2J89xsfniLh4i49RuZt3dH6KLEx1ZmGOTzNzLBIbv0T+5SEo3xIBSQuqxchFWnVw1hdSxR0qvoO220Et2SLlpIKKjaAaZpkABDws7EzyOZ5qsUtW3+NhKItdw8RKyId6tqtd3iDzjKbsYyLngnStb8S1vJQPMJCByb1SZlakCkMEyrHI8YLMro39XLUATTHmsOiOnSHw383xSW6a+JYlxK1yOJa/zKsBKM8Jyxe9fY
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(136003)(346002)(396003)(40470700004)(46966006)(36840700001)(36860700001)(5660300002)(82740400003)(7416002)(8936002)(2906002)(478600001)(36756003)(16526019)(110136005)(316002)(70206006)(4326008)(70586007)(81166007)(83380400001)(54906003)(40480700001)(336012)(426003)(2616005)(82310400005)(47076005)(41300700001)(6666004)(186003)(40460700003)(356005)(26005)(1076003)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 08:17:06.3897
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f56fa265-d6de-4c00-dd9e-08da8b29316e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6371
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The downstream and upstream port Root Complex Register Blocks (RCRBs)
are needed to control the ports and CXL devices connected to it. It
also includes the location of the RCH/RCD downstream and upstream port
component registers in MEMBAR0. Extract the RCRB from the host's CEDT
entry.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/acpi.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index b3146b7ae922..439df9df2741 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -365,11 +365,48 @@ struct pci_host_bridge *cxl_find_next_rch(struct pci_host_bridge *host)
 	return NULL;
 }
 
+static int __cxl_get_rcrb(union acpi_subtable_headers *header, void *arg,
+			  const unsigned long end)
+{
+	struct cxl_chbs_context *ctx = arg;
+	struct acpi_cedt_chbs *chbs;
+
+	if (ctx->chbcr)
+		return 0;
+
+	chbs = (struct acpi_cedt_chbs *)header;
+
+	if (ctx->uid != chbs->uid)
+		return 0;
+
+	if (chbs->cxl_version != ACPI_CEDT_CHBS_VERSION_CXL11)
+		return 0;
+
+	if (chbs->length != SZ_8K)
+		return 0;
+
+	ctx->chbcr = chbs->base;
+
+	return 0;
+}
+
+static resource_size_t cxl_get_rcrb(u32 uid)
+{
+	struct cxl_chbs_context ctx = {
+		.uid = uid,
+	};
+
+	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CHBS, __cxl_get_rcrb, &ctx);
+
+	return ctx.chbcr;
+}
+
 static int __init cxl_restricted_host_probe(struct platform_device *pdev)
 {
 	struct pci_host_bridge *host = NULL;
 	struct acpi_device *adev;
 	unsigned long long uid = ~0;
+	resource_size_t rcrb;
 
 	while ((host = cxl_find_next_rch(host)) != NULL) {
 		adev = ACPI_COMPANION(&host->dev);
@@ -382,6 +419,12 @@ static int __init cxl_restricted_host_probe(struct platform_device *pdev)
 		if (uid > U32_MAX)
 			continue;
 
+		rcrb = cxl_get_rcrb(uid);
+		if (!rcrb)
+			continue;
+
+		dev_dbg(&host->dev, "RCRB found: 0x%08llx\n", (u64)rcrb);
+
 		dev_info(&host->dev, "host supports CXL\n");
 	}
 
-- 
2.30.2

