Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0795F5A78BA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbiHaIRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiHaIQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:16:55 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2065.outbound.protection.outlook.com [40.107.102.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45FAC59E8;
        Wed, 31 Aug 2022 01:16:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIznUkMvw4+JyhRyhDvlGdH1TeYm604zowdNdgBMvgdL+g6boJ374G6m9voJ5k65o4tjkuYTO/n8jXEiFzlh7/gDFWN+CpIcMVktZ8FfhYSsf5mqpKR4IRQ91kd4/86cHp05OpgJCN6vREOy0Cr2y2wZKsWCd+1anLJ3EqmaHJ6DuXksc9oUNNGxoXtGTfaAptH+Z6+G9iW2HKMwjprowtgHno0S4e55CP3k88GYKX7Uo02gINwVnQZpBVKxFM5oe4TCHZVd+0HbyBWQ1SvtBgsnKs2A4YWiSknJYXDh5Ek+SCVLYLXbR8gzXI7TVIhZqPJT4ydw0BEfS48YssDW1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7OsswjDIf269tkBH66DhqIXK/bbAziXiPPDXTXXjmw=;
 b=fSqWUrn73bX8/8vA+cHnWLdaXoqnTQHtMyyzjmvyFIYyrsLCxnT59U7hkgccwzRQ228JM8WJ698dYH7BlAZ1KoTO2uKcDbjzU7wJU53qZ+r4qrDqbCqkYBcZodoEURi1UgJCPKoAg9imcRfCU+qhJQ8kRIK7waukBeaIslBPgng2R87KgvR2Z4EK1ya6CoZ+CkkfjH6MwaGvaAnSViO2IIp8eq3b8e38Sfu1CPKbm7E1YpnZXePh3qqi1etrC77ZeJtpedAQF19F7AfljUudKxzcIYt5kz/9TlIUaCtlv35AsrovPDwiYk3LBEbtWlVwtv8MLA4PxiUgmqKwKi2N1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7OsswjDIf269tkBH66DhqIXK/bbAziXiPPDXTXXjmw=;
 b=z5tjTO8tzuwgjMMG6Jh0S8F2BsFVQN90/Gp6Tr+7+lO9+rfxHnSdJArB99gs1ftgLj27XH53TEv05GCbFPp8IobxqOSa7+PM9CJJmg/dt6XJAaPy0T3t2fNSk9pkx0gxLFyHoRB1jKXEl3+VC6sBpunzo7kbkfpkka+RFOtxH7I=
Received: from MW4PR03CA0021.namprd03.prod.outlook.com (2603:10b6:303:8f::26)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 31 Aug
 2022 08:16:48 +0000
Received: from CO1NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::ed) by MW4PR03CA0021.outlook.office365.com
 (2603:10b6:303:8f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Wed, 31 Aug 2022 08:16:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT100.mail.protection.outlook.com (10.13.175.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Wed, 31 Aug 2022 08:16:48 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 31 Aug
 2022 03:16:43 -0500
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
Subject: [PATCH 03/15] cxl: Unify debug messages when calling devm_cxl_add_port()
Date:   Wed, 31 Aug 2022 10:15:51 +0200
Message-ID: <20220831081603.3415-4-rrichter@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 234b2cd0-d6ec-4dbf-1f72-08da8b2926a2
X-MS-TrafficTypeDiagnostic: SA0PR12MB4431:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X1gJPzFqMy6y/ZdofZ85yCDOWhn4IxvZJL1zbHsKyXxZUuxC7QNxtIUGDu/STvljSXbJnLl3AAMslXL15JeJ9oWGReYtPyON49fgWpB3IBim1EpBEeVs1YCRE9INPcvbs/TgWwOnZhZUmkhcGjs5cgM2sPSLsDoZ9Ylt7Iszz32v4PbunngNf1v/VRrIhNrDBBpKKDRJnC7nKlEO64d7Tm4grV0DgPfAU7/KhhMUMsTJT7zNRMHmc3wIFz85yOSipoBGKj9v+e1cHn12BNru/zkUuvB7X2ZY9yshUFL+PXays0l597DPNf+XVi0XlyoYheqfJpPhgTaodHl17rK3y7k/t0fH4a3nKduJS67Bx2Ec1v8j+JEfPVCyLosy2B1H0blBxDDGUvjC/vp/q5WNZHq3WmYJraELHyJgU6IcGKvghWdvbzqik4mCcm0PVaUSV9yS/DWoXFbU4lUWatj04fbQFD06EPQexDeS+loqDVM5eVz/lMRafvLE9RHipP8fnFq4C8AW/9XFg01fQhMxLe3lm6n0G3laKStbfrTGwLqVDurZxW/4LuZM72TDobH4XHSZ3y69QFT+WDjxS8o4uTD11Ci/uiUiqi54AkH75iazUrcd8cT7Sl0on05cYh6UkrzCpOuUEFff2dg83PTVyy4/o+9uRUxsrwUWmTunKncawEzGc4npAIQiGYj+PKZOGIYpFR8P3f2Ufj6ExKef2XZ/qb2l5wAigBHLqPwu5ziYWUtoGns7dzfCPvjZo2a0q7jiDM8ghmNJmJxOBZgl8ERWBNZw+IgC+NEWzyGY0bGEWsOiAJF4SpWfbCkaI5He
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(136003)(346002)(396003)(46966006)(36840700001)(40470700004)(26005)(6666004)(426003)(478600001)(16526019)(47076005)(83380400001)(336012)(1076003)(7416002)(186003)(41300700001)(54906003)(5660300002)(316002)(40480700001)(110136005)(82310400005)(40460700003)(2906002)(2616005)(15650500001)(4326008)(70206006)(81166007)(8676002)(8936002)(70586007)(356005)(82740400003)(36756003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 08:16:48.2550
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 234b2cd0-d6ec-4dbf-1f72-08da8b2926a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CXL ports are added in a couple of code paths using
devm_cxl_add_port(). Debug messages are individually generated, but
are incomplete and inconsistent. Change this by moving its generation
to devm_cxl_add_port(). This unifies the messages and reduces code
duplication. Also, generate messages on failure.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/acpi.c      |  2 --
 drivers/cxl/core/port.c | 39 ++++++++++++++++++++++++++++-----------
 2 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index fb649683dd3a..767a91f44221 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -220,7 +220,6 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 	port = devm_cxl_add_port(host, match, dport->component_reg_phys, dport);
 	if (IS_ERR(port))
 		return PTR_ERR(port);
-	dev_dbg(host, "%s: add: %s\n", dev_name(match), dev_name(&port->dev));
 
 	return 0;
 }
@@ -466,7 +465,6 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 	root_port = devm_cxl_add_port(host, host, CXL_RESOURCE_NONE, NULL);
 	if (IS_ERR(root_port))
 		return PTR_ERR(root_port);
-	dev_dbg(host, "add: %s\n", dev_name(&root_port->dev));
 
 	rc = bus_for_each_dev(adev->dev.bus, NULL, root_port,
 			      add_host_bridge_dport);
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index bffde862de0b..8604cda88787 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -666,13 +666,17 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
 				   resource_size_t component_reg_phys,
 				   struct cxl_dport *parent_dport)
 {
-	struct cxl_port *port;
+	struct cxl_port *port, *parent_port;
 	struct device *dev;
 	int rc;
 
+	parent_port = parent_dport ? parent_dport->port : NULL;
+
 	port = cxl_port_alloc(uport, component_reg_phys, parent_dport);
-	if (IS_ERR(port))
-		return port;
+	if (IS_ERR(port)) {
+		rc = PTR_ERR(port);
+		goto err_out;
+	}
 
 	dev = &port->dev;
 	if (is_cxl_memdev(uport))
@@ -682,24 +686,39 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
 	else
 		rc = dev_set_name(dev, "root%d", port->id);
 	if (rc)
-		goto err;
+		goto err_put;
 
 	rc = device_add(dev);
 	if (rc)
-		goto err;
+		goto err_put;
 
 	rc = devm_add_action_or_reset(host, unregister_port, port);
 	if (rc)
-		return ERR_PTR(rc);
+		goto err_out;
 
 	rc = devm_cxl_link_uport(host, port);
 	if (rc)
-		return ERR_PTR(rc);
+		goto err_out;
 
-	return port;
+	dev_dbg(host, "added %s as%s port of device %s%s%s\n",
+		dev_name(&port->dev),
+		parent_port ? "" : " root",
+		dev_name(uport),
+		parent_port ? " to parent port " : "",
+		parent_port ? dev_name(&parent_port->dev) : "");
 
-err:
+	return port;
+err_put:
 	put_device(dev);
+err_out:
+	dev_dbg(host, "failed to add %s as%s port of device %s%s%s: %d\n",
+		dev_name(&port->dev),
+		parent_port ? "" : " root",
+		dev_name(uport),
+		parent_port ? " to parent port " : "",
+		parent_port ? dev_name(&parent_port->dev) : "",
+		rc);
+
 	return ERR_PTR(rc);
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_add_port, CXL);
@@ -1140,8 +1159,6 @@ int devm_cxl_add_endpoint(struct cxl_memdev *cxlmd,
 	if (IS_ERR(endpoint))
 		return PTR_ERR(endpoint);
 
-	dev_dbg(&cxlmd->dev, "add: %s\n", dev_name(&endpoint->dev));
-
 	rc = cxl_endpoint_autoremove(cxlmd, endpoint);
 	if (rc)
 		return rc;
-- 
2.30.2

