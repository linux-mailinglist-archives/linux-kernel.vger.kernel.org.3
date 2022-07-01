Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CA9562926
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 04:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbiGACds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 22:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbiGACdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 22:33:37 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D38231915;
        Thu, 30 Jun 2022 19:33:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VubtvMxUNDW9B5SOG96p21t1SSlDXUIJ0oNklUI6rUuZYMoAz+NQ0PILk4Gcy8msnw70NHWwpidFZhMggvofHtoF9bZxrXKzUoCulO7OnvmA74LmhWzdIy+HTtgKyDIsYqsjjW2gBOEAtmNoZzA8OK/5Qy9P3GY9Cq5yipA0LU0lj6nr09IrxgvF5w739cKh9X+ikhIT4j6npa62cMsmK+g1ypZLrfOoyedq6jO5H+QV6HBiqDN3b+4hvZl/dmU91D1rSIVQrWspy1nJgD//v+VzfieisJCGxTGB0pTsbJa/TEhih4DCIg1623vwugvwOF3sSxUGsyu/Al3ffnVhnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQ2jCG+/BGFUJOgmgaScen+SAE8p6B0K9/Uu236103c=;
 b=bGScZTKZ1X/905OMRFtVBxpW08EWF0pJYeoQLllg/b3gEytVG+JVhwFqUNNuq1n+qCYIep2lk2E2xr3Ko3FKrP8iqT1CnypmVHJhth7o0oD57P1FB1fjQJ9rz1EvTXNoKQJjNhvh/jCPAkEWK9vyOpn+jnICZrmDEkLH/5RrZsYQkdTasDzS3hcZHJjMWJ+aEqa7KIIDGFDxPWBN9eYjzp19FjQRWdzoECD9KrnO9BbLfhK3amC0cl5tikZOTlgUQxduN6EQ7hBYPpOspR+VF9la6U44lMhrOBF1baoTsCDzHUWTPvgdK4RBr7f/rdvn+FiYbFsunGGPT5z8tDUQLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQ2jCG+/BGFUJOgmgaScen+SAE8p6B0K9/Uu236103c=;
 b=fzkNMna/Dkxn7kKTwedutf002ITjQotIIXTlILOxz4KMH9NUyZQ+PKuzThET1uybgYvh9ZT3G6At8XWQ6Z5KmQBLbp1oAeSI/rWgTEX81EibIyRajbEmHEcJjilPmqtQVC+AzKNhF+rLhPtaGyp1P59PP+hecZRAMFYPJZkt8mQ=
Received: from BN9PR03CA0963.namprd03.prod.outlook.com (2603:10b6:408:109::8)
 by DM4PR12MB6638.namprd12.prod.outlook.com (2603:10b6:8:b5::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.14; Fri, 1 Jul 2022 02:33:30 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::b1) by BN9PR03CA0963.outlook.office365.com
 (2603:10b6:408:109::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Fri, 1 Jul 2022 02:33:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Fri, 1 Jul 2022 02:33:30 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 21:33:29 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Len Brown" <lenb@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 03/10] ACPI: LPIT: Use new `pm_suspend_preferred_s2idle`
Date:   Thu, 30 Jun 2022 21:33:21 -0500
Message-ID: <20220701023328.2783-3-mario.limonciello@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 31dccc51-a4b2-4a59-32f0-08da5b0a162e
X-MS-TrafficTypeDiagnostic: DM4PR12MB6638:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IDxk2yuwL7PsxVLJL+cnLOpa91cPfiSD4M4+o4+3CxfDqipmkOGew2BydYgCZ2WoHRAp2RXNXQfiFWMnZe2/MQ4m+h1CYby7ez5mCD6UejKC/5qk2CFtOysM4+v+JQjYvu5E6OVhrtmxIVcwTcQIcDYbjjW0KbKLAUYh4ypb0t8gSTghDsL3qbQdrV7q4TcykMEpvazhEbkc/ySoKdHwQZgkOaYhzTG2lcfHqajq0/YRK/052DA8O6+3fAmibpwK6Y8Vaba7itR+5peZeFXhbvUD9mU2TCtKTGLfcArZQT+vMwu9GA4/P7fEiCkd1r3UK+a/TYNtUJXuwepUehv4EWeUJav6p0l7nO/00djLb36cVPzRH4LvUMEHjC/8wou3qbjgGSI9xqMcFloHlUxQIfS+vuyiJiwmF2VBYUXRxOc/OBhA1RYR4CO1VqNxsHLX6xkWZcSiaARDAnTySALkmopx/fdDQKl94/nG4KrRXsf3DqK6I86zb03F26fdMXFtvYAd2HdFywUtHRtyVvCMk1+5I9AiHuAqzAyEZgFCk0aDj42yWYcLfY6GDbrD8+6WbaiaR42q+XeNlYwgVLmHVDM0CcbAo+NjeQvTT2e15P6VL7x8GC7KSoLRb4zEx9GB/Vad5SJObVo/Sa5chelNBaayJ2c7tBfCg73aGenHhjtlBzDxUTI/rOIGe9iC5bVstvOkP0ZVNkOqrpcEzVeSjrGbL9GsOjZIACaxcIMDlpWdGyqEAgM9w6yZNX7w5kATGtz3Vy0YP4G8Czq28mzTnPANKHgDmiFiEiaemUU0yJwN4r4MpZmnTNfOaAG4JMcL24HmznaSlYj6VgzQ9LuWixADRPD8RBT8qzOJtuNZuHsMR8qbuBbkum9nU424ka28
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(396003)(39860400002)(40470700004)(36840700001)(46966006)(36756003)(110136005)(54906003)(316002)(2616005)(26005)(86362001)(82310400005)(7696005)(1076003)(82740400003)(356005)(186003)(16526019)(81166007)(4326008)(70206006)(8676002)(70586007)(478600001)(8936002)(44832011)(426003)(47076005)(336012)(36860700001)(40480700001)(2906002)(41300700001)(83380400001)(5660300002)(40460700003)(6666004)(81973001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 02:33:30.5648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31dccc51-a4b2-4a59-32f0-08da5b0a162e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6638
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
 drivers/acpi/acpi_lpit.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_lpit.c b/drivers/acpi/acpi_lpit.c
index 48e5059d67ca..31c49107c579 100644
--- a/drivers/acpi/acpi_lpit.c
+++ b/drivers/acpi/acpi_lpit.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2017 Intel Corporation. All rights reserved.
  */
 
+#include <linux/suspend.h>
 #include <linux/cpu.h>
 #include <linux/acpi.h>
 #include <asm/msr.h>
@@ -109,7 +110,7 @@ static void lpit_update_residency(struct lpit_residency_info *info,
 		if (!info->iomem_addr)
 			return;
 
-		if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
+		if (!pm_suspend_preferred_s2idle())
 			return;
 
 		/* Silently fail, if cpuidle attribute group is not present */
@@ -117,7 +118,7 @@ static void lpit_update_residency(struct lpit_residency_info *info,
 					&dev_attr_low_power_idle_system_residency_us.attr,
 					"cpuidle");
 	} else if (info->gaddr.space_id == ACPI_ADR_SPACE_FIXED_HARDWARE) {
-		if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
+		if (!pm_suspend_preferred_s2idle())
 			return;
 
 		/* Silently fail, if cpuidle attribute group is not present */
-- 
2.34.1

