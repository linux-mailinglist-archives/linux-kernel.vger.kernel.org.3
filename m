Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1DA59ECC2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbiHWTs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbiHWTra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:47:30 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64ACD79A6D;
        Tue, 23 Aug 2022 11:51:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WeA/NLM8Sc/NkHi5Eyudw227WCItl3yhaMhFAvLdN/UjBqCSuz8AfoZBjZzpp6QYm1MN+36jHJP+YB9AxLjbMHJlK297CPkqBafh6CVuhyFGlIRBVcBMKbUmmdyEPQO5O9f0t5GH0RS8TC/bVi3Y2if0mEr28WX1jE80H1VwqNZtAZ6ZoyEahYsRQhjjtSDQvcLmaw8yN4zjgbyNfNrCAYcLw9OJl175soI9utDFlepUIRdZG6rIrHxdnD7JFYrNdDym8wPRwHXMFXepZnhgIcRs8KGcb03C9q4H59eYykCg0EWvRf9BIVmPZ3HzBltx78W43TnJSLTdhijuDPq3BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SsoHITZrqnb3mNGDS2K+UaTSr6gRdeEOxVeDyc8Atjw=;
 b=DsgTacNjvolb7kZEr0evuM9VNK60BeBrdXnASfEzPT6og2gFu/xUiq3oT6fATANeHBcGxZKrt28jKvu2Cm3HuPJc7uCAPgFej1YNmcPADInOMP18DbAvB/esImP99uAdC80XkHkkB6Q4t1asF/S7xevtTUQacORtqdlOolnxudav8y9t9+PRZtKXqrFSYL73Bq2wg6hlJ4WeinFIuF9h3jTen72Aj2f+4oOldfrW/86j8tfnYfYWUUUam7daq6IGbbOWZXsPkCK/Nm/n3xXs0YcT5vCcLUBByi9yIEZNNU12Oj9gA0HbIsnynsuD05LOLbEbECZXYor/DdBX/z0mCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsoHITZrqnb3mNGDS2K+UaTSr6gRdeEOxVeDyc8Atjw=;
 b=GL4brSc8up59kSWCHqPkwoC5ZqgjikF+mtqvv1HHxPttAZ9o1f7X/wLmKqZBOkGE/3UFPTw5tiLwU58X6Zjvt84HYqyI6khOxUfowveOqNP5gSOzl2nlaOTh5tMHbVLHi9plylSgJPjraEAHW05w3QisvcSamPtkBdlxcnW1pdc=
Received: from MW4PR03CA0116.namprd03.prod.outlook.com (2603:10b6:303:b7::31)
 by DM6PR12MB2636.namprd12.prod.outlook.com (2603:10b6:5:4a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Tue, 23 Aug
 2022 18:51:24 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::25) by MW4PR03CA0116.outlook.office365.com
 (2603:10b6:303:b7::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16 via Frontend
 Transport; Tue, 23 Aug 2022 18:51:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Tue, 23 Aug 2022 18:51:24 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 23 Aug
 2022 13:51:23 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>, Len Brown <lenb@kernel.org>
CC:     <nouveau@lists.freedesktop.org>, <hdegoede@redhat.com>,
        <ddadap@nvidia.com>, <Dell.Client.Kernel@dell.com>,
        <kai.heng.feng@canonical.com>, <kherbst@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Lyude Paul <lyude@redhat.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/4] ACPI: OSI: Remove Linux-HPI-Hybrid-Graphics _OSI string
Date:   Tue, 23 Aug 2022 13:51:33 -0500
Message-ID: <20220823185134.14464-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220823185134.14464-1-mario.limonciello@amd.com>
References: <20220823185134.14464-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2a95f05-800a-4ef3-dee5-08da85387a72
X-MS-TrafficTypeDiagnostic: DM6PR12MB2636:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lF/ocmL32O5nJGbe14bO67e1pc960zJjvFxuyPMRWj4XiHtA5D7ukhIPzdHOgUujnq+4h2I1LHCmT9kZwp9gBCYIU06JdwSt2YyR8HohnedRRbLzCHhS8Yew9xnr9xa+cogM8An5fAZeVRWhAzJpYVgVJKVZzauDJPmREBo8S4cO5gVFF97MKN8CvkR2wwaGpubsoOc9s9LgbrSrRSH5kh+Lc5QTr28AdzqO0X4m1TtIQ45ZSSAAiWLiVKyAXcIFcYHOu6NsbkXb+sr+VP6FiX2FrlWNknB32iA8gTq8k1U3537t5wNXAFfAexBXjQV8gPHMqID/d6nEXpn9X36pPT8ADfCGzCAOc8A4553raE31dG/6ws3ZlHKGpSEtcCOkOiT188wTiNQdVubFuXgtS/WmqzgR/TuMShNzQYHNWBc0l21Q0TPjp+5qQJVASdHgyDvWEZRVIS+5MSu38lULsYwz47hzMqTpz2CeRXWLIBTjrcJGR6Nu5z5t9aRaGCUOgTIwY/t+d+IJo7zl6sUNNgi8w+tbfa71c/dHfDZWoOm7Gi75sxFa1NUip3hZh30+uuUvcCN38sAVgx0SFdJNDi1zl02ntfZSBEQ/E4xoaEdnxT3SnSRYp8S28W84M9G6ozvz+6gC1EWaXtKf4zTth+Dxrn3XA+NluZSVgTQgaejpyHS4eVoF3fQPRRK8JZY3Dvrt3huqcEKHxtm+M17wH00tLgKSxyT3jKw9MS+vST1bG0wnKbRIlIJ5Bi/G9OAnGjV/H5B0qEpbLKTxksKMkYuW6ULXOaTlqoQ0dwyE7xIuFDu6bsDr4lDsZJYh018O
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(136003)(376002)(346002)(46966006)(40470700004)(36840700001)(47076005)(426003)(83380400001)(26005)(2616005)(1076003)(336012)(16526019)(186003)(2906002)(81166007)(356005)(40460700003)(36860700001)(86362001)(82740400003)(7696005)(40480700001)(5660300002)(82310400005)(7416002)(70206006)(44832011)(41300700001)(316002)(8676002)(70586007)(478600001)(54906003)(36756003)(110136005)(8936002)(6666004)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 18:51:24.3326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a95f05-800a-4ef3-dee5-08da85387a72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2636
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This string was introduced because drivers for NVIDIA hardware
didn't handle mux control properly.  This was fixed by commit 8e55f99c510f
("drm/i915: Invoke another _DSM to enable MUX on HP Workstation laptops").
So vendors shouldn't be using this string to modify ASL anymore.

Suggested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/osi.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/acpi/osi.c b/drivers/acpi/osi.c
index 0d635eec87c4..d4405e1ca9b9 100644
--- a/drivers/acpi/osi.c
+++ b/drivers/acpi/osi.c
@@ -44,13 +44,6 @@ osi_setup_entries[OSI_STRING_ENTRIES_MAX] __initdata = {
 	{"Processor Device", true},
 	{"3.0 _SCP Extensions", true},
 	{"Processor Aggregator Device", true},
-	/*
-	 * Linux-HPI-Hybrid-Graphics is used by BIOS to enable dGPU to
-	 * output video directly to external monitors on HP Inc. mobile
-	 * workstations as Nvidia and AMD VGA drivers provide limited
-	 * hybrid graphics supports.
-	 */
-	{"Linux-HPI-Hybrid-Graphics", true},
 };
 
 static u32 acpi_osi_handler(acpi_string interface, u32 supported)
-- 
2.34.1

