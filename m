Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FBF56292E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 04:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbiGACdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 22:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233592AbiGACdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 22:33:37 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9CF5A2C9;
        Thu, 30 Jun 2022 19:33:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnqahVUxdpclKM1SxUeRmpbMQ5myrQk4GLG9WKIwKhH3mOf3e2CpVnqQa/yjqM/QInUKebSofxQmk5yFT6nVcP5rTl27UOh1gzB5RiQbk5LvsaTKw/+EsX3QnlAjeRtCQpyIcsR9X+SMxFMH3ZKwPOtHfp75U3tXeNsuRX35TP0skVa/cJjLjwl51BVvg71UDyJNPY2byPIu5bIIRGYj/zDwclh705kGAp0/0DiepVUxl7rWc05fJc9AWbBMMhGv7A1dJFBvfEMvKOcCe6HfcPFxd6qHClt54i/dI/Jp429thO/3bwJxetJCr4Y9E6VvT8SB0ce5493Z0W/s2e4rKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7BA+QwEWsmaSiyolpawy2xY7V05UZModCAa+1IAD4k=;
 b=e3mZ41qJ4t/OrrMf0qbd/nDBTVlo3eI5NltmdECcBQOG6BgjcY2iUnG41zW2U52h45qpGi5jmJDzIAiDfQf2xwra9r6q4pMLrmEFonS/cjX/LE3Qky56DGUGtSBqdMS+jJ8+0NB2MIq4w/f2zZ+Kwne64W7oah7J1gUXeRND8x3epbThfSnQOliUYsmh/iSYRqrZt9e0oTvPo/yO3/AxfjDv2xUhJduUtuOHvZkE4utxJgeo9fspEN8kOcg2fHv5gywomeUuHgBHWjMY/6rdrsQU2d1qOLy1T5LdiYR4gfVp717Z/crMaB39Vjrw+Z7NaR2JkujoWOl66VKIb0HrUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7BA+QwEWsmaSiyolpawy2xY7V05UZModCAa+1IAD4k=;
 b=HVCP2xAWetqB/3RtnR+8Yn8AQTCZ98u0fWNFqILkUU99FXVDYtO60lB//h4uHU/Rq3H1DEtb7nm1zxWTtbpoNwaZOX+DCKuYVyAeANnEKQt/hFKbLtr99SWGnEPvsd7yIjrXB21EXTjdkq3KW9o4Ra3tLS87x+Ec32gMoGx+tr4=
Received: from BN9PR03CA0980.namprd03.prod.outlook.com (2603:10b6:408:109::25)
 by MWHPR12MB1680.namprd12.prod.outlook.com (2603:10b6:301:10::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Fri, 1 Jul
 2022 02:33:33 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::37) by BN9PR03CA0980.outlook.office365.com
 (2603:10b6:408:109::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Fri, 1 Jul 2022 02:33:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Fri, 1 Jul 2022 02:33:32 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 21:33:31 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>, <linux-kernel@vger.kernel.org>
CC:     <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v3 06/10] thermal: intel: pch: Use `pm_suspend_preferred_s2idle`
Date:   Thu, 30 Jun 2022 21:33:24 -0500
Message-ID: <20220701023328.2783-6-mario.limonciello@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: dede7a7c-6020-4552-f88c-08da5b0a177b
X-MS-TrafficTypeDiagnostic: MWHPR12MB1680:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OiDn8axc6gkwf/vtO16PrRgH40BHqTuycXBbv8ylwXozqiuy3w4/wiiUhAoBGWDe7qcGSGeV1TEcILEpzn94G75fK5jxxdKns0cvVUHoz3r0B/EV6DQak25TLTV4NNZGN4v/3l6BiOnJv7nTxtsWwnCp9LNIAO//8YTYrCePfsLgXYeUw/u+o3PyWyuXD9hCQBCBJvotGCkLQN2QNskYBdiSdSwL88/6pe6vZahBDmeJnOtfkuVdQG1gsKPxnbt7JIhQkGZax3Y30qkEyiXLcP9e/3IhY/7e+TBelEkSKfTE+lkh4fWhdi2nVsfPjHRe/PKVIwud7D12iZNbJux2DNvlS1iVuWv7GkSZZXShzpBu2QOv3LwML00QupVxjGcG18SaDr4hlreHuKU1gFce71O3pEREdP9FpX37Yo1W1kQ6ypl9jp1ZQf3uSJigB+U+OCWzMzHRDJkdTExkn/P1iUVfAxgNX26hen7xditFIyiHSIUL7La13rrpj8/TteZCT7w7Cc4mWyAg8iXQ0LQU1jcuKBV0xWMZkI8P3M6wdECKL7yeMys1CdOMxSLpydIBMSiyFioFt1G/3DFxTyjmuwrU0OeGaqH53W++yk6C98v19Ccj1as3dcETiUlfLI5/gTaqYYqWq1S8x/ucVH78XGcRGZtwIJt88WU6T1tYe2zmOnELlOxeupxGC2ITuMOZpNp5y6vhhgye/MYYHnQH4n+Qoy3P0K+qrr0nxP/D55NUlJlPdIE4+4kolqLclTYlC8xIcEVs3hzPG49Cjs+yL2G0jKu1O1cJJNLAtO57lPzxWFPtuWpCBt7bFRTcAAsqrOGYXdeNLsc/SwDaSxnhAVBm35ml4Bvq7G4wZ2uNF35B7DKvp1qlhkUVljbGH8Lk
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(376002)(39860400002)(136003)(40470700004)(46966006)(36840700001)(7696005)(426003)(44832011)(1076003)(81166007)(6666004)(356005)(2906002)(40460700003)(2616005)(41300700001)(36860700001)(16526019)(47076005)(186003)(82310400005)(336012)(40480700001)(4744005)(82740400003)(86362001)(8676002)(110136005)(5660300002)(4326008)(8936002)(70586007)(70206006)(36756003)(316002)(478600001)(54906003)(26005)(83380400001)(81973001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 02:33:32.7522
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dede7a7c-6020-4552-f88c-08da5b0a177b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1680
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
 drivers/thermal/intel/intel_pch_thermal.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
index c1fa2b29b153..3124c4b1da76 100644
--- a/drivers/thermal/intel/intel_pch_thermal.c
+++ b/drivers/thermal/intel/intel_pch_thermal.c
@@ -208,12 +208,8 @@ static int pch_wpt_suspend(struct pch_thermal_device *ptd)
 	}
 
 	/* Do not check temperature if it is not a S0ix capable platform */
-#ifdef CONFIG_ACPI
-	if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
+	if (!pm_suspend_preferred_s2idle())
 		return 0;
-#else
-	return 0;
-#endif
 
 	/* Do not check temperature if it is not s2idle */
 	if (pm_suspend_via_firmware())
-- 
2.34.1

