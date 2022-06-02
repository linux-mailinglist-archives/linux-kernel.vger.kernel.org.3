Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F4C53BC9D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 18:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237122AbiFBQdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 12:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236738AbiFBQdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 12:33:47 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2085.outbound.protection.outlook.com [40.107.212.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7A4120B5;
        Thu,  2 Jun 2022 09:33:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VArtMxIEDJW2KfYskuCkQ+8r9270Qhuy9qLzLeOt4dFLrIC/oJ+cE92tutS2wuHWtga5ZPyPzrwBWqBWPba4yQ0Atw/8yin7BzfYbsor9nl/P9sxe/j+F9aPGWkTWHyR0yqSKRyDPJBswettIprjrZdXz8WmDVX9cpygm0zRlOR457B/V9LXi8F8kfwOyA+is36WRpJWPbaaJ2C1Wch4w7yGMn9e2bDmQt0krILIrS/XV9Kr+WNozVKReOA2SDcMf45PrhSZY3QLoxdeZBW9dM3N9aK8Ymjpe5lYyQUV/D19Zp6pQedaTwMce8R5VjhBWQpZTFNnEhq5elclPEUEVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BX6190VSgLen77RoMkwUrlOLC1ypj71gF8A3fC4KhiE=;
 b=kdVyFF8u1/9p/LBpXcyfy5ZpbWoNpA8r2/Y/56dTWAVUIkBrUodtO30TWV8AlvqMr7iVU4r4BQetl6k9l/XKSZYFzrNCb+ZNhW148PvUJ4khM7ok/D2Fr8bUHvuGcXie+X2IjklEooVwYXuWbn6p9LPaZlUSqHhtNz0TmwwTiHgawVr7M+irGWs1QcTi8hjqZHLxQ2KQU1ts+bTxuNtWChCVJ8f4Gpv/jTu/biR5VQgwfTCibdM1ur+Z8u78vJHgM4B0eladYvAixUVTtGl4NXguGsBn8GSdmm1scF8DASAqiGlTzjhC96k3P4xbVkb/NiDecV7c9cflICrviMKvLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BX6190VSgLen77RoMkwUrlOLC1ypj71gF8A3fC4KhiE=;
 b=oJMkOQbDSl1txgro8KWpM956FbQVDOiRzYxrdb4mLeMc26t0HfnDGeAhdu+63trQ+5J6gv9B4e25QQFzDDy6T+wEqV3/JwdrKNKflWfaZ679nUQwktinS7lGIqH4jerdtaXzEfSE5sMnVl5s+OCv4gMNDYq6rHkf6nSO5tlUoLU=
Received: from BN9PR03CA0472.namprd03.prod.outlook.com (2603:10b6:408:139::27)
 by BYAPR12MB2885.namprd12.prod.outlook.com (2603:10b6:a03:13d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 2 Jun
 2022 16:33:43 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::5c) by BN9PR03CA0472.outlook.office365.com
 (2603:10b6:408:139::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Thu, 2 Jun 2022 16:33:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Thu, 2 Jun 2022 16:33:42 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 2 Jun
 2022 11:33:41 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Len Brown" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Documentation: PM: Drop pme_interrupt reference
Date:   Thu, 2 Jun 2022 11:33:30 -0500
Message-ID: <20220602163330.317-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39d104f6-7a76-48b0-0da8-08da44b5a803
X-MS-TrafficTypeDiagnostic: BYAPR12MB2885:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB28851D2D19E65EE6C1CEC2A3E2DE9@BYAPR12MB2885.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mtyAw7IATVYijCcr/RRxALAFueHC8ufCSI13qKojhwH6mGWRijQvBhYXEVJbrhNgSw2/vSvdjqTBqngjPyAZHWBsiIeXx58PHTyMpLfn/+z7m5jMCYF5LkKoZYTgfK5crORtOTRrkLgQcWmafKqZ0HL/DOIcu9b5SqlB/vvN5duUP2rwEK0oEEz+pAIoWQuMSkRmNd7w3/ZXcz1K2Iv2vAR8tdE/qSjGZG23TXmQcyBmPZj7W4dKczdGI3vrBC4+IvIh+RcROxBDdJlKFYN0tmRgHEjIapz1K/0kZcorOa8U2n3k7KtVRMlW4NlfTk+H8eewzdAK/JlDHDgpRidoV8T3Qoe9BT5pF6dlI1LFKPenMBqpENB0HukiAkGd8wMFf0YCMNtR7X5A3akxS8k1Aja5HR7XUrYtrekM4lHjMloTxIG30yITEvysFGExdAJTZXsdXv+UXSG07CipsXV/uneyD6utyLK16kNKTrZ/40wPduxWG39x8pNisVP9MdfWfZVlNZTXMvJDNCLMK9eyp7jduQTmG6qCVLpm9tg4Cpp5QLWEAwHRBhTAmmNFz/enPEvkYhR0svoXtWUN+itFWE/GgLvAwMmQFs6uprxvjHbnSaShHp0nEzdqOUgCe8am/QEcMgrdXw1LrMaOf7bv4YP+ivzzGWdD8B4NAdAqQlMBxmNc0BuFSqa/QCFeMiQ08lpxFEYBKvXfsEjPmu9LrQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(44832011)(356005)(86362001)(82310400005)(7696005)(81166007)(2616005)(83380400001)(36756003)(336012)(508600001)(110136005)(70586007)(8676002)(316002)(6666004)(70206006)(1076003)(426003)(5660300002)(47076005)(16526019)(40460700003)(36860700001)(8936002)(26005)(186003)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 16:33:42.4107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d104f6-7a76-48b0-0da8-08da44b5a803
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2885
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`pme_interrupt` was dropped from `struct pci_dev` as part of commit
8370c2dc4c7b ("PCI / PM: Drop pme_interrupt flag from struct pci_dev"),
but the Documentation still includes this member.

Remove it from the documentation as well and update it to have the missing
`pme_poll` member instead.

Fixes: 8370c2dc4c7b ("PCI / PM: Drop pme_interrupt flag from struct pci_dev")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/power/pci.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/power/pci.rst b/Documentation/power/pci.rst
index b04fb18cc4e2..a125544b4cb6 100644
--- a/Documentation/power/pci.rst
+++ b/Documentation/power/pci.rst
@@ -315,7 +315,7 @@ that these callbacks operate on::
 					   configuration space */
 	unsigned int	pme_support:5;	/* Bitmask of states from which PME#
 					   can be generated */
-	unsigned int	pme_interrupt:1;/* Is native PCIe PME signaling used? */
+	unsigned int	pme_poll:1;	/* Poll device's PME status bit */
 	unsigned int	d1_support:1;	/* Low power state D1 is supported */
 	unsigned int	d2_support:1;	/* Low power state D2 is supported */
 	unsigned int	no_d1d2:1;	/* D1 and D2 are forbidden */
-- 
2.34.1

