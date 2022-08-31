Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C8C5A78BB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiHaIRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbiHaIQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:16:58 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718B5C58FF;
        Wed, 31 Aug 2022 01:16:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZUQ2URG2av7/0fSBrg55uAQkfZSfM8oOZ4tigcZn4YlrowAKMiIGcbUOjkNYprS/EW8hoZkQyr46k+Ri6mx+loH6mi+HEJ99/YzO9WDjnnn613kIRs0yw+7nTH4K6lMmFQLqqkQ32hFCWX1cjpHsLWvDyksT0hKl9wqAs7XOWF94bIxoB4t4LQlDEToeDGsr7n6l04N3bz1lYVJdmQiLQOuT5AR6IzGKWGYzfjiFPyJ/BCI6y5+N4irGbKaZPlvco8ZoYTeaHr6LD8Mmj0+bCspDlorWMO2a9szJ/WNdr5BRD5McOC+M+MXQP4u9981Bm9ecrNqpflOwMYhp1j9dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6nwYpwrohXVsCCquXQdqgxdR0LK6//seX9QT6C5AHc=;
 b=D4YXf4IOK99xKCHPVjc8Bm2EUI1hNBJJuGeW78r+Ukth9NpX2sLjR2mX9/DoXYcYvv8eYgp+4HmukTL/Xgm/VZlRrmGAcwr9ok/ipefhPErd7OwFgbtINY4rkSoAGT3fD40Ar9GqCwhAU1zQJmH2Wj9TKGB4DVCKgmcVjg8ZWDu0bzW3xa9Agj5Wdjb9+0HerdKOGMzjknxCPWNb13lxjOWZuMKakW7Yz2XUc8T+BAizWGgTEVNm+HLp2maurW748v7GihSboVrOmW3pf0jdRz+OgcpBfs4VlQLIbzb1ZYFzNx5ImBk0S11P/tKbUXd0bZDLls1M+smOzcQAPd5xwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6nwYpwrohXVsCCquXQdqgxdR0LK6//seX9QT6C5AHc=;
 b=EiFa6ZfAS6p9K9jda63gY2CySc4G60hNZUZ+P2awLSu7SnAFZWHCX1PQBQDAK6NnTIeFHPAeijn9m8KZ7RhUW0A6xD1aBCJWGUnDbcTlUVBRqsGpU6TCX6R8qwCTcSk6OKm71z9KcF6S61t5Vqy7x+u+IUM5ERwFM0tI4SeDmBI=
Received: from MW4PR03CA0284.namprd03.prod.outlook.com (2603:10b6:303:b5::19)
 by BL1PR12MB5302.namprd12.prod.outlook.com (2603:10b6:208:31d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 31 Aug
 2022 08:16:49 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::ba) by MW4PR03CA0284.outlook.office365.com
 (2603:10b6:303:b5::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Wed, 31 Aug 2022 08:16:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Wed, 31 Aug 2022 08:16:49 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 31 Aug
 2022 03:16:47 -0500
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
Subject: [PATCH 04/15] cxl: Unify debug messages when calling devm_cxl_add_dport()
Date:   Wed, 31 Aug 2022 10:15:52 +0200
Message-ID: <20220831081603.3415-5-rrichter@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0c4d9b8f-28a6-4abc-29d4-08da8b292759
X-MS-TrafficTypeDiagnostic: BL1PR12MB5302:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JgPR/0I49GDnLeCskSwruLeHv+Q+Pi3BV1Twwk4iIXOVpA5MjYh0R6AamIGoHoF4zUiTxaaDt01Wpf6L0LkoP+7M6ba6w1X/98l7LfXrlCH4Vn4+CEHtOYixkL8ZCuFAPOceeR75NXJZExdx7ELQ6AQfqTIe1tIeZd/6/II9ePSYJjfSpFF2B6EbDzl/FIocPkgt5iHwdvRFciCKULEP6Y4gE5uoUFUq8i+t/E4+ikroFbI9T5tUcjH6aZahn52LTZ6Dya0FaIqNaJWkdZNZlYTnX52D5SvTvVkKAjc+j1MaUY0yOwkUY02M8fBNtk2lm3f3C0WUZHh+lAz6zc9ksExHqrdEKTeJrl3kK4FrsZD+Sac/POcoToUq5IjjB+Q+O4KXrGbHCbxCd5zghZ2TrDIAEdEt4O8V1mYy5JE7bmouhfTayaW3gYxC0zLImZl94huPmbhPcWBp9YBVJcJEQk84bnd1UyyKPms6+Inak/q623Wjfca8Bi1ldBH3/zyY4W/kluEF15YrWPGGKghCH8vErnhQpOsTpKuvu2LhbFtHPnL8abpKsu5GszKEN2T/seweLYDrqM+Kjk4kMySp1TJ5+usSl0uSYDkYnA2eaOtv3qLscUKXzY1kIiovuU3RhP6cDgsHqPOPNynuRBvZ0oAUEerZLo6sFzW0VFvJugy20scIbnqnWzLT9sUj9TM0M38K0h69T158fLmtAOg1riLjJBD/Jvcf6Hg8b++k2AGgdYA2di29QBOwz87jbuzj27+T37eM+cQJHoPWba60lFeCgnbjRFrVGkdQ81lFEzw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(136003)(39860400002)(396003)(36840700001)(40470700004)(46966006)(5660300002)(41300700001)(478600001)(7416002)(2906002)(15650500001)(70206006)(6666004)(4326008)(26005)(47076005)(2616005)(426003)(8676002)(336012)(186003)(1076003)(8936002)(16526019)(83380400001)(40460700003)(82740400003)(356005)(70586007)(81166007)(36860700001)(40480700001)(36756003)(110136005)(54906003)(82310400005)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 08:16:49.4546
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c4d9b8f-28a6-4abc-29d4-08da8b292759
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5302
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CXL dports are added in a couple of code paths using
devm_cxl_add_dport(). Debug messages are individually generated, but
are incomplete and inconsistent. Change this by moving its generation
to devm_cxl_add_dport(). This unifies the messages and reduces code
duplication. Also, generate messages on failure.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/acpi.c           |  7 ++-----
 drivers/cxl/core/pci.c       |  2 --
 drivers/cxl/core/port.c      | 28 ++++++++++++++++++++--------
 tools/testing/cxl/test/cxl.c |  8 +-------
 4 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 767a91f44221..31e104f0210f 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -282,12 +282,9 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 	}
 
 	dport = devm_cxl_add_dport(root_port, match, uid, ctx.chbcr);
-	if (IS_ERR(dport)) {
-		dev_err(host, "failed to add downstream port: %s\n",
-			dev_name(match));
+	if (IS_ERR(dport))
 		return PTR_ERR(dport);
-	}
-	dev_dbg(host, "add dport%llu: %s\n", uid, dev_name(match));
+
 	return 0;
 }
 
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 9240df53ed87..0dbbe8d39b07 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -62,8 +62,6 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
 	}
 	ctx->count++;
 
-	dev_dbg(&port->dev, "add dport%d: %s\n", port_num, dev_name(&pdev->dev));
-
 	return 0;
 }
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 8604cda88787..61e9915162d5 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -914,12 +914,16 @@ struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
 	}
 
 	if (snprintf(link_name, CXL_TARGET_STRLEN, "dport%d", port_id) >=
-	    CXL_TARGET_STRLEN)
-		return ERR_PTR(-EINVAL);
+	    CXL_TARGET_STRLEN) {
+		rc = -EINVAL;
+		goto err;
+	}
 
 	dport = devm_kzalloc(host, sizeof(*dport), GFP_KERNEL);
-	if (!dport)
-		return ERR_PTR(-ENOMEM);
+	if (!dport) {
+		rc = -ENOMEM;
+		goto err;
+	}
 
 	dport->dport = dport_dev;
 	dport->port_id = port_id;
@@ -930,22 +934,30 @@ struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
 	rc = add_dport(port, dport);
 	cond_cxl_root_unlock(port);
 	if (rc)
-		return ERR_PTR(rc);
+		goto err;
 
 	get_device(dport_dev);
 	rc = devm_add_action_or_reset(host, cxl_dport_remove, dport);
 	if (rc)
-		return ERR_PTR(rc);
+		goto err;
 
 	rc = sysfs_create_link(&port->dev.kobj, &dport_dev->kobj, link_name);
 	if (rc)
-		return ERR_PTR(rc);
+		goto err;
 
 	rc = devm_add_action_or_reset(host, cxl_dport_unlink, dport);
 	if (rc)
-		return ERR_PTR(rc);
+		goto err;
+
+	dev_dbg(&port->dev, "added %s (%s) as dport of device %s\n",
+		dev_name(&port->dev), link_name, dev_name(dport_dev));
 
 	return dport;
+err:
+	dev_dbg(&port->dev, "failed to add %s (%s) as dport of device %s: %d\n",
+		dev_name(&port->dev), link_name, dev_name(dport_dev), rc);
+
+	return ERR_PTR(rc);
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_add_dport, CXL);
 
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index a072b2d3e726..c610625e8261 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -582,14 +582,8 @@ static int mock_cxl_port_enumerate_dports(struct cxl_port *port)
 		dport = devm_cxl_add_dport(port, &pdev->dev, pdev->id,
 					   CXL_RESOURCE_NONE);
 
-		if (IS_ERR(dport)) {
-			dev_err(dev, "failed to add dport: %s (%ld)\n",
-				dev_name(&pdev->dev), PTR_ERR(dport));
+		if (IS_ERR(dport))
 			return PTR_ERR(dport);
-		}
-
-		dev_dbg(dev, "add dport%d: %s\n", pdev->id,
-			dev_name(&pdev->dev));
 	}
 
 	return 0;
-- 
2.30.2

