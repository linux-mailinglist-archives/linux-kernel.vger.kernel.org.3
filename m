Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29255A78B9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbiHaIRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiHaIQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:16:55 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2084.outbound.protection.outlook.com [40.107.95.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE78C59C7;
        Wed, 31 Aug 2022 01:16:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSXP4QQtj2rJGr37s4JlXCz1SzLR5e0t8z3Y/9H0Ox4igvLPlfsn0uz03dEmdMJ2h6NvC39OrwoieUQis8rX97pvQBjboPoebHiF/2+VZsBbNCnyxFQA40SJAeA6q31RBmJL/Y7tIGXQghIfU4jwl4vJ4sXgIJRk7EJeJNuXX+C9QPNSIs79haZVRAHRgD4FnassI2z3KMze84eaOQkVdeZgCg8dMt542/gYgQkDyJiDU+xtRgO+kOPM5THiXGQGWRJIHqySvswWgfWgLx1hxiJCCZVBtNhDLm3i7iR5kyKSnLLM+rITxOoR+6toB6UBwr/UiqhRwzYL9681QxYfUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hx+YIdjMjwNEQVovUFvkwuaREKypEdzCaGtwbgDT9zA=;
 b=KWFtMtfRSuX8y0pECPiNs5NYKUZSHUuTU2Fl5xbLd19VfmnOyDD6MqTTeajPl0QftaSvhersnjazYRhTLu1DI31kDjphGN+nZfL9rqyR0b5VKjT5GX0m+Qh4nEZtY3m6FcPkw2Bm3Kbap5lbaYIP/3omSsDyVClhXhFw/bODJh7JLuo62LCBPa/QK//PQtkzoTWzWGpjhX9MEqZPUQy+v+SPNYzm9x8m0y2HTDb/zyCja5Wg7ks5ycZ++JUwQ4bLpAj8o0ebevKxMSFqpZCZzdpT1YonAWKiGvfEwSrJobEGZ0POTIOdAw4RODHb9wWD6zQIjizuqNM3SuSrly1Nuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hx+YIdjMjwNEQVovUFvkwuaREKypEdzCaGtwbgDT9zA=;
 b=GBWkzdJmCxQkg+nRXFmieTWDBh0vWRGIgDgUvx0znjfFU2PfZe2P15C7hV/7NWS89/6zjb4WuulTjxCqpDNjvtUB0ZBVARfcZaYNEg+g4eG19T3U45+HYZn7fu3SoCmspMvLktiXa/GrKHRX6Qv7FXFKHiKm+9adKYSIjeQ2X/4=
Received: from MW4PR03CA0281.namprd03.prod.outlook.com (2603:10b6:303:b5::16)
 by BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 08:16:45 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::e5) by MW4PR03CA0281.outlook.office365.com
 (2603:10b6:303:b5::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Wed, 31 Aug 2022 08:16:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Wed, 31 Aug 2022 08:16:45 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 31 Aug
 2022 03:16:38 -0500
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
Subject: [PATCH 01/15] cxl/core: Remove duplicate declaration of devm_cxl_iomap_block()
Date:   Wed, 31 Aug 2022 10:15:49 +0200
Message-ID: <20220831081603.3415-2-rrichter@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: bd3bffab-9b27-4544-f7de-08da8b2924fd
X-MS-TrafficTypeDiagnostic: BL0PR12MB4849:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qSZGZjDjv0ihQDt8wqQUo5rq0Lh/8+/YOPdAHcSG/jP9momyaGzJtOeY6EDUnbMHe+nhiKHeeqpcfumHbD9RTw3+bvwKBSBxqm8KX8ItMx6ILh/ehEIhKIZ83t7Cfrl7M5SsKqy1rnZ2cRt+aBG6EgNy/wbmyi9CtRK1tGj0v9Ji4h3cMjmhdbZz7JxgU0KtANV7FlQKuwTsda6aAVNSQsFtXTfvg2/mlFiSQAGKg1qF49HMWwmX+v6yV+hWf24n5XCIFf0lwYme8LVL0ddzWQdef1aCZhhDKifSiQzFhkyMZ/hS48oePwq1ANqVFYaBbutStDkhp8XSpcWdQ22MVtnfuH7j5k/cqVhkGkdJcn/2PlMzoivbAcH4lSde9IJjRQjtj8HA3seOSvq7cQPfHx4aiKjTqoaRTJbbFVrqf7BAAl8QOtWOtUynkm4CLOuBV6zTOe817GTGp3q0B9zIPzvgruleSWsvQTOtqqajfdJQa6FeWy2t3wQC0UWTbtxJ+scMV5jElIBN0aQWOmR2h4kcXoXMs8qzz7OvWsG5BnJsvajddQl0HMqDwHgfKnfs9iAnIZnnFjTGM0erJm3g6qxm1EqAGgKTVlRYRDAyzMC4WqZVTzgUfxYMTF1kHS0aaavpDTXb/QbZLNX0H0Qv3qWhLdsTcOIUkTwG55hFYUEMTxwRsUDjXNF4qkD/lCboSJyRQTnHd19Pwql7MBWR1EsIv+bPBfNJdAogNArk50/3FkaNCsVFTmvA/H2dDTlJaRXp3rpVhCW4hzpJ1lx4ZfeLno5A0IWOQI98MhOm8GNHdd/7pP74YPNTS9qfpyV6
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(39860400002)(136003)(346002)(40470700004)(46966006)(36840700001)(426003)(47076005)(26005)(186003)(1076003)(336012)(16526019)(2616005)(40480700001)(7416002)(4744005)(5660300002)(8936002)(36756003)(478600001)(41300700001)(6666004)(36860700001)(40460700003)(356005)(83380400001)(82310400005)(8676002)(4326008)(110136005)(54906003)(2906002)(316002)(70206006)(82740400003)(81166007)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 08:16:45.5015
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd3bffab-9b27-4544-f7de-08da8b2924fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4849
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function devm_cxl_iomap_block() is only used in the core
code. There are two declarations in header files of it, in
drivers/cxl/core/core.h and drivers/cxl/cxl.h. Remove its unused
declaration in drivers/cxl/cxl.h.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/cxl.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f680450f0b16..ac8998b627b5 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -218,8 +218,6 @@ int cxl_map_device_regs(struct pci_dev *pdev,
 enum cxl_regloc_type;
 int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 		      struct cxl_register_map *map);
-void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
-				   resource_size_t length);
 
 #define CXL_RESOURCE_NONE ((resource_size_t) -1)
 #define CXL_TARGET_STRLEN 20
-- 
2.30.2

