Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC03562927
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 04:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbiGACd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 22:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233597AbiGACdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 22:33:39 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACDB59255;
        Thu, 30 Jun 2022 19:33:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCV6hm0zral0haWM/Kvtwfhip3QJ1FixJWtYyfZBz8ymtzVzaDCAwDatcu2qmVX1TtEeD6l+5xDnpgmnDFUJnlq4wsBZ5ZzNTMk0Wzo9H9ejWUuckBzwH7DK7dLJgF7NJ7KXmg5VC3JHtkZWOHouwUdt9Z0NxYslTPfH3DSxKSoBlkwY4GckEXokdMUz3vIos9V1AmPaRdTVp7Mk3uyc2kTEhenPU3k5KvPFlhiVnTsmQDMwjuaQDWr6haFzmf7KSgraV+csOID2jYWmVWDBLS02O7lu1e4A9DP2S1wiZFOJ1FvhmNpu+krT7THD/sB6cyayZZioAG1j5OtK1gMV5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwYHCWBiktNLSfc1XdxTouK9jP8FVFrHK5tjfdewSM4=;
 b=PtEB66j6tetoPRxVrf4ZPGrU7pqHJLpQLoiuvqo50c5ktrMoEazGBdE1OliMB5zZmBqAEQOQ5/XjapYz5YxiqonE6x2Eo0vjENnsFBMz1xfqeyLaEsAXz3flGVRa6ehxDsPqGxeebaAYndPDcAnzaqcBfc8oFzJl+EyQzspMArKOoZ81SSKbwp7P3llhNogNB249QimVZZxE5atSmPcmNhPFkeQsp+7+4x10wngCEMHAyyC72WhovU9+hdsjXsFFwXKnDJBziBg1G0gkJR9nlirT+abfK1Eo4QraHriL1HidR0mXS41hXnpxWFk+JkpeLjQMsylPEJj2RP1O4lKgKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=towertech.it smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwYHCWBiktNLSfc1XdxTouK9jP8FVFrHK5tjfdewSM4=;
 b=wMVmToo6t7AsF4VdrhBkdxFkqixY/2zUz7z/xpHT7qBgI791+JyfBrEXcMpf3k5+ji9maFqKxut9kAzeEUXGMoxPwy2ZdZ8aXNDvHZST8+4d1eE8hL7QjzO7YxS/pIif/oXUrGK6166NbmzepglviTgMN7m6uLHWLyMYfXkTzD4=
Received: from BN9PR03CA0977.namprd03.prod.outlook.com (2603:10b6:408:109::22)
 by SJ0PR12MB5609.namprd12.prod.outlook.com (2603:10b6:a03:42c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Fri, 1 Jul
 2022 02:33:32 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::d3) by BN9PR03CA0977.outlook.office365.com
 (2603:10b6:408:109::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Fri, 1 Jul 2022 02:33:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Fri, 1 Jul 2022 02:33:31 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 21:33:31 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     <linux-pm@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 05/10] rtc: cmos: Use `pm_suspend_preferred_s2idle`
Date:   Thu, 30 Jun 2022 21:33:23 -0500
Message-ID: <20220701023328.2783-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220701023328.2783-1-mario.limonciello@amd.com>
References: <20220701023328.2783-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a1c4df6-6c7b-4c30-764a-08da5b0a16f6
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5609:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8tU0E4EImF5CmLr9PvR/wkmpwxCfHEGXCeKien83o7AfmyUpxpo+hWGxehGLOqAsB/uOYqMo724jIW09A3WgY+KXFfrjPU75epnOnXhh7cNPiPGjC0sD9wRzAGHRgZJzW6y7d+U48dTdo+i7FDo8xR/wBlhKBWRAmMRhT/+18hJXSvG4rFpXNxsv6OOmlbih4tXhhVZqmA8eQp/Fz5vUIdpg0rq8VCfRzh2LgwH1kf6r5xZnx3fO9I+uFq6DRKarL/yODvgharwAsLcNfPxeahZfd/1Ke56MiKtMlPxiyFz/Puukmb94ROx+pZ/sJYcyZYWykkFCmD22fu8pjlwQWldm6HEoN63yjQZy499Xu4PTyRtEP1q1XGJ39SfsdV2OUGE9hOC1+wxETe+KsKr7yHPrOzB68xA+Cbr80Fju5zPaqIJXhLMwnBNdTLfoT35ohwNIUsFH0PvF0N7ufpexZAE6OYfDwq2ap3RNJHMirNBIt2X9vRSpTn3BxfCDga2iXTEjQfcluMjiOzKBBaK8lEUEVH8ZmrvRpPuNxkGRxz5N4pXyBJ8dtcANx6RnM1/hVY2HEYfKuzRBx5Un6Aa5UK6s8SBmx3xFRdgKam2hmacGhk1lDn3wt7Vg1no0VXyYLOezgXoio28Ox+O25l5GekVkpXGwfKwl8ACDz6WCOzteioUQg9qM/hPUC834M2uel2KN6ey3HrTnw3DFEMYbTp1/Fn71FeM/qN5oPD2HUaDcKWXxRDLJkPbup4+U89zutsc/BmChqNgu0rF5agp5v5f6446toPHcMOmqrzBeP7QLYchS++er5rhtn0Oo34/wduZ2jPJgCYlYxTn3SQv1yhmVSgt0XPRYuvZxNjYIiJiTqewq5BhzYpUReSwWvhxc
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(396003)(136003)(40470700004)(36840700001)(46966006)(4744005)(81166007)(316002)(36756003)(2616005)(186003)(6666004)(47076005)(41300700001)(426003)(70206006)(54906003)(2906002)(70586007)(356005)(7696005)(336012)(82310400005)(36860700001)(478600001)(4326008)(26005)(44832011)(82740400003)(40480700001)(110136005)(83380400001)(5660300002)(8936002)(40460700003)(16526019)(1076003)(86362001)(8676002)(81973001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 02:33:31.8772
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a1c4df6-6c7b-4c30-764a-08da5b0a16f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5609
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the direct check from the FADT and use the helper instead.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/rtc/rtc-cmos.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 7c006c2b125f..2e3d35e87061 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -32,6 +32,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
+#include <linux/suspend.h>
 #include <linux/platform_device.h>
 #include <linux/log2.h>
 #include <linux/pm.h>
@@ -1260,7 +1261,7 @@ static void use_acpi_alarm_quirks(void)
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return;
 
-	if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
+	if (!pm_suspend_preferred_s2idle())
 		return;
 
 	if (!is_hpet_enabled())
-- 
2.34.1

