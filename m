Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D6C5A78C6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbiHaISE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiHaIR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:17:29 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2087.outbound.protection.outlook.com [40.107.96.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D98C59EA;
        Wed, 31 Aug 2022 01:17:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzIYonHnW04KQAo3rskZ9iIYR5lDEaq6j4VeUB1orTAGPwU4JqfKbCg+gOMK5A7g1r67Z3KfBV7CgDaQQ6YlPh22F5+2bVcZpyJFtjS+iOlgvZ6oWfIk4zdGJnfpLfFroc5eopCaJ9KRhoxhrnGBYbI3RKMfi51QndzM0EvYUyBbnHkHSXJhvxTfOi9TE+4PnEDOAdkGiiXfmgjuqUpTnZw7PO1ilEBkY9D+e67j+ZB7rPZi1+9NCCn7CuXq1zW4rfar6z+S4yGpEkDgEIjbA5Jj5Npq4faUFZ0ANvn4VI1psi3de62vzIuKmWwAizgStwgBNYGf90CGLRE9cScPqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BmEK2yubcX2euJpR8tmTwMJbmJFxVv2NN8CwXcClx6Q=;
 b=WTo2EaXsZ0oLAnB87wmCcxUAJqUS5ojy1DnSzVgGkBW6QS+mUcAcwUZatSfqscTHWo3azb2Yobmi43gl+FtYaVzwPE4304a/wNyQZIdqpnZaoKRqDfv4n31YeN9blx3V9KP21fJT0+B42Q1TuqW/o9JZlVI/1y0khN+IQKjuI+2ZvxdFnRxmLySju0MIVutXgbGV+2dw00DqirUpVZEm9QTzE0gaqI0r/OMG7h7GoH7ZVGNP4LPhkvJdLtoxtuxRKg9eJWF+sFa/qwtqxHlHf1xGMS+pflHaJC7aUQ2wdawADXtuMlCSRFn7UlggXHF0O/w3rzCsAW68DA7tuVzUUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmEK2yubcX2euJpR8tmTwMJbmJFxVv2NN8CwXcClx6Q=;
 b=G80mD5GuUGCbbmng6VGfS6PIdekLvJP4qwuRXJNZ1gorOf7Ppo+Hul0LJkmqARzFJRfZxUARK2fm/IOUpmA8bBRx6YqC8COHlvKzwjE9sWqekkYRYfw0UpNmqKRpMEBOfWvAyU1nhqjMu4TPedg08A2+PZYXlyXV/3oQHlPMJWM=
Received: from MW4PR04CA0242.namprd04.prod.outlook.com (2603:10b6:303:88::7)
 by BY5PR12MB4164.namprd12.prod.outlook.com (2603:10b6:a03:207::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 08:17:03 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::65) by MW4PR04CA0242.outlook.office365.com
 (2603:10b6:303:88::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Wed, 31 Aug 2022 08:17:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Wed, 31 Aug 2022 08:17:03 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 31 Aug
 2022 03:17:00 -0500
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
Subject: [PATCH 09/15] cxl/acpi: Determine PCI host bridge's ACPI UID
Date:   Wed, 31 Aug 2022 10:15:57 +0200
Message-ID: <20220831081603.3415-10-rrichter@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 52dd6f28-f93a-4ebd-d43b-08da8b292f9f
X-MS-TrafficTypeDiagnostic: BY5PR12MB4164:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JfcToTMR2eokj+jaTF2Y9k7Ks5cIrQhxP2Mhk0zDxfsWExWFQHTeQpIh8D0gKUMh1SQg3H7WVrjjrM4ghGwNqEgfqKZp6c2yVjbjCrg8ysaWgYlbXqWs3lFgGCWe8nrMR0TWmjFQum7e1itYKtpyZR9PYs9d/LqLZ53QvKuWOlRDTUH31qW1MnThM/Tl6gE4k6+mOkCHwOZO7qEnaWz48nwy7h90u5/trWwbrRQmjXv8ejPMPkdvANBkIWBSxxSj3LGNdmOz8EA9j11VbbRUjjRI6pVtgcEu6ieHxSaSijtb732VVPlzWr/FVq+NkS5LzxAXPqN5HAiAMPisNriA744IdBwd4Pi5FLo+K69LtNaZS9ALcVhLchnxEiHPBApC+BBITXNQOu//8fl5uMUdGGthvSuIvooz/Cb09a7H3urmlSP+8/qPAhGWYQYZjhX1tEloRoxmHkrueEpmTb9BS1RogQlGElXET6FOAAnEdipV2iT1YsvWW5NGAO5fkElU2s8d0bv5u2ksh5ClZ7ObAALOUO5QjWhXZywcpfyJpyfYqJoQuCc8K5lfHkO5pujVYaGXa0LCUhrEseYpFZq1UWmmlFHdgpJcb66nJ2ZP90mj+7bPAy+xAbQCSsUk8UlspQklA7nPEq8MqGzfiqj7FjmZ4EFhruJ5jRTXTafnZqbCzESemdk8AeAvj/k6AKtNdVJQ3OkWn5v7yc/xRuAfkrFRQMa5IlEUW0NrZd/fDGvgjGNSzuwTT+2sSCTnyHhioY7TeL9tl7NHBw/PPAzn0+4Vq8l57jzQjmI8B0Qlz9MxnGS5qVhJITQeRApYd5ML
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(346002)(396003)(136003)(40470700004)(36840700001)(46966006)(336012)(36756003)(2616005)(16526019)(2906002)(8676002)(4326008)(26005)(41300700001)(6666004)(47076005)(1076003)(426003)(186003)(7416002)(36860700001)(5660300002)(40480700001)(54906003)(316002)(81166007)(478600001)(8936002)(4744005)(82310400005)(356005)(70206006)(70586007)(110136005)(40460700003)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 08:17:03.3395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52dd6f28-f93a-4ebd-d43b-08da8b292f9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4164
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UID is needed to read the RCH's CEDT entry with the RCRB base
address. Determine the host's UID from its ACPI fw node.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/acpi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index f9cdf23a91a8..b3146b7ae922 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -368,8 +368,20 @@ struct pci_host_bridge *cxl_find_next_rch(struct pci_host_bridge *host)
 static int __init cxl_restricted_host_probe(struct platform_device *pdev)
 {
 	struct pci_host_bridge *host = NULL;
+	struct acpi_device *adev;
+	unsigned long long uid = ~0;
 
 	while ((host = cxl_find_next_rch(host)) != NULL) {
+		adev = ACPI_COMPANION(&host->dev);
+		if (!adev || !adev->pnp.unique_id ||
+			(kstrtoull(adev->pnp.unique_id, 10, &uid) < 0))
+			continue;
+
+		dev_dbg(&adev->dev, "host uid: %llu\n", uid);
+
+		if (uid > U32_MAX)
+			continue;
+
 		dev_info(&host->dev, "host supports CXL\n");
 	}
 
-- 
2.30.2

