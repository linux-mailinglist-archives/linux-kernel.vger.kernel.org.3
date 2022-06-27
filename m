Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB0E55CFC0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239892AbiF0Q6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 12:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235496AbiF0Q6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 12:58:38 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA40EDEC6;
        Mon, 27 Jun 2022 09:58:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjbGEMEc6RZv7d9iAwtEErD/VGEdipHeFCDlGXHhggEQjIS6oxrZgOBsCM3ApCq9oNk3fKNWpxRntkY3++aIhou0fRGLvZH7tx1mKyRpf3FqHLJzIXIooIyyneD4Jp+wYgqTlY68d6F57IO47r6JJpdxU2r4pBxYMDNZ0f2Iq8V+sthsLeY1Oi0poqBqhMPsWcUuDf6zzKRNxJgo5w7N3Z9iCei8NlwKt6GZCMkGLH8nlRoA04fg+aEYQk8vAx4Kv/TTDCsKSZYyRDmaUgD76xFgZFrUPSA44zmMyfRwREZYnhgMWCuWepYX05NsWVJzzBgI4QjKRyWPOO4d+HTjwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydlR1fzsxt1FvrgMW+n9FnS1SZhYni8yRpVC0QhosG0=;
 b=YUP9+ESFLD6wdntPQiftXjjABY+sCiXMbH9XAQqSUzRRjABu4XNAg6KmCYoFH2xhho4wJtFvqTUIK0sfLFK9SJIqxQ10fWH4doc6ALJSeyqGkdqqLDpK7QY0u/ReyU0vBOuHXnMBlxHL0+fzrnz2JTqkJharloPmdl6QUnUQtAxO5ZyfMZ2BGVpBq5eShKiRAv/vzN1pz917YgDLUy8aMGBM69sfiOsaxEu/tMmAFuL66PMgG8pQSoe0fwyQVdoH3JgHLW6yPig04EMaPRPypkOxMizjGDhndST/ZI1ptHiz1PEsN4rttEOQM7fzJe21jhBxHsAfiVpYUlRBiENqJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydlR1fzsxt1FvrgMW+n9FnS1SZhYni8yRpVC0QhosG0=;
 b=uqGo8BLiCFxy5H0K/AcdB2pXvJCo+SzI8+F+BvKQ6slrWHzXtXVHndf+UOyBDKWHM9REXwhXZo4Tc9Y4ZYyj7hjP8g2GrbYnlLcguO5H5n+VIEWDPh7Gg0GyLH9/8POZUvRwd1DQmiHOcUjXuXSOy/UQKmu3G44r0QD5ywAJ9Gg=
Received: from MWHPR19CA0018.namprd19.prod.outlook.com (2603:10b6:300:d4::28)
 by MW2PR12MB2489.namprd12.prod.outlook.com (2603:10b6:907:d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Mon, 27 Jun
 2022 16:58:35 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:d4:cafe::5a) by MWHPR19CA0018.outlook.office365.com
 (2603:10b6:300:d4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.21 via Frontend
 Transport; Mon, 27 Jun 2022 16:58:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Mon, 27 Jun 2022 16:58:34 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 27 Jun
 2022 11:58:33 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Len Brown" <lenb@kernel.org>,
        Pierre Gondois <pierre.gondois@arm.com>,
        "Sudeep Holla" <sudeep.holla@arm.com>
CC:     Perry Yuan <perry.yuan@amd.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ACPI: CPPC: Don't require _OSC if X86_FEATURE_CPPC is supported
Date:   Mon, 27 Jun 2022 11:58:32 -0500
Message-ID: <20220627165832.10246-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c537722-33a0-4a9c-e29d-08da585e45d1
X-MS-TrafficTypeDiagnostic: MW2PR12MB2489:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S0/PmP1SAk5mrDNG6aJeQQYFrIIANpbkwec7XvdX7yxPTLDmK/QEyzASo4R5gnGcdCMlKw5OeBzLVD8jYs1xg+EDb0rwZ2SxJFTdfiQAcVBUNJXfXBmmhZIEOUT8hb4E1LoiuRUz9wBWpTta7VD5VJMy8/XOQ8pCDjqhipLhUBkPUyALCCDMc7s9sFLjEbS78UVRvTzERDSCQ2C4RIELfUdJ4o6TSYiB3GzEFeFGsWpBkkGbuZzebi4VTtRnFSPMu9u9w1S51P3aN32ASyqNKU4SDSeEKojtz+c7PxFAodtmMCqCWFhJkbcZ9ttc13Zoiq1+MVcdXM4YXITbVQtrmOpyHVSBP1FSqPUiBZweZ+cp8y4FJiEKXd5Ts0QsOGXbku7FmZY5ubmOJONo6HuX3avSjemuNKtxnd7VlQnaYNQGqK+6uRGEFWWDcEZijOuYNwzGbheQylUdqZfFUgaAKfbYY2U8RWw5CQViftVxxhbOhHsnC4LI58F4Wz6gFZNMftTCsJK/vnn2+vSSRVn9q7bCOqgdJshtPk90zGDalOEFhBr4rVRGRzm8hWgtMxeY790yhrIwlN3/42FlDuRj/XLSF60BHlugO6ytRlkG3fYcYXvW618NmTQ3nQCEXVF3W8iVGddDC/DTm46bbZo3W9GjuoU8pPSXZ5Utbr87TUhXPGcE2DGhywbrICNxj18I0L9ew+hKZywPJ2CI4TTxDAukUEmmO8BJal3z42BEu55id6V+YPXabUEmrR8+vb4qvuZ7qiA53zFRAIujYcH7Elci8XMfO1dyAZKsYrjlTvu04ZHDaQ6Pv3nH7xaDLNutQ+RZikOaBp0DCVtkmCVqYw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(396003)(376002)(40470700004)(36840700001)(46966006)(478600001)(1076003)(16526019)(110136005)(316002)(40480700001)(82310400005)(336012)(186003)(426003)(47076005)(36756003)(40460700003)(2616005)(81166007)(83380400001)(36860700001)(5660300002)(8936002)(44832011)(356005)(7696005)(70586007)(8676002)(70206006)(86362001)(82740400003)(41300700001)(26005)(2906002)(4326008)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 16:58:34.6024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c537722-33a0-4a9c-e29d-08da585e45d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2489
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 72f2ecb7ece7 ("ACPI: bus: Set CPPC _OSC bits for all and
when CPPC_LIB is supported") added support for claiming to
support CPPC in _OSC on non-Intel platforms.

This unfortunately caused a regression on a vartiety of AMD
platforms in the field because a number of AMD platforms don't set
the `_OSC` bit 5 or 6 to indicate CPPC or CPPC v2 support.

As these AMD platforms already claim CPPC support via `X86_FEATURE_CPPC`,
use this enable this feature rather than requiring the `_OSC`.

Fixes: 72f2ecb7ece7 ("Set CPPC _OSC bits for all and when CPPC_LIB is supported")
Reported-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/cppc_acpi.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 903528f7e187..5463e6309b9a 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -629,6 +629,15 @@ static bool is_cppc_supported(int revision, int num_ent)
 		return false;
 	}
 
+	if (osc_sb_cppc_not_supported) {
+		pr_debug("Firmware missing _OSC support\n");
+#ifdef CONFIG_X86
+		return boot_cpu_has(X86_FEATURE_CPPC);
+#else
+		return false;
+#endif
+	}
+
 	return true;
 }
 
@@ -684,9 +693,6 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 	acpi_status status;
 	int ret = -ENODATA;
 
-	if (osc_sb_cppc_not_supported)
-		return -ENODEV;
-
 	/* Parse the ACPI _CPC table for this CPU. */
 	status = acpi_evaluate_object_typed(handle, "_CPC", NULL, &output,
 			ACPI_TYPE_PACKAGE);
-- 
2.34.1

