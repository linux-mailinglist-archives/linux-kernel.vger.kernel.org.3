Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E388518C76
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 20:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241511AbiECSiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 14:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbiECSiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 14:38:11 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7551EAC4;
        Tue,  3 May 2022 11:34:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewm9n3AZ+4tk+uzmyABPc8qqoySF7c5HZCujLv0l9oaJNXnD2EfnwwwTfi6NEDiioKLNR4ZuadphbdSwF/sSErdXxSqbI0lkk4v26UYEhxvsAMqAZaYAcmFFspEndrBur1KCAUzESn0wXJO0JcBfjYu/l5e0ncSHJ0jNMi+TpQBh3IxtmapysnAwHRWPe9pnndRYYFFEMpTm50rV1Ka3MzmZy8fhxdFDhLcDwsdKAbHoJ6dP41lBHfc8DZLRuqCDv7RMorXH5Fw6ZXzibbWaMLs7eN25HW7vdsYgw4tMBOUGRNoAIn0YbkVyQ4dn+4AmSqrUNgoUlwHgmQ9A6LEgPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RwVV8+iphMKJpY9VBQjS5Z6HMTjRGMQ1gHlrtQKHkI=;
 b=HId9rICao/ZZmtbQ//I2wOupKyTJtr3iBxs+6t7lfqbun8ZN7NHfU35kdTzDRpV7EMBCrvOCqWPs6TdeT8ZEShJAE0MuV1uqgImgxjXPpQ+3D0/JoE1HHkA/3yZkyuWxgZoM7OEVcbSEa7lVMM3pCm3FAbjOAA9ajNkLjCHPUgsUuqF5hOZqCRja4AQUbKJkaT21iEGRaHuj0zHLybbighIkeyP08IESdrPmp/Hrdu2i8tHw650rk/pi/SQYKUA+W4XcZDzCfy73uoweOScAdf8zCGI3SSZEN/FI3kfM9YIVWbg+TWT9W2wpMOl0mLCzVU3PfDUiZIcitta+pc34zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RwVV8+iphMKJpY9VBQjS5Z6HMTjRGMQ1gHlrtQKHkI=;
 b=R+3IM9oRGJq2nXHmASouSmpQnGtXEri2N/WrRCzq4ZVlJrTUI99lk5WZuwABhb/UKhEkccxLwoZzR2phl/cIQQelJ7LF1XG4PyIAAaHO486Khpom9XyuavfRo3F69OJDDVtw7sXDF3VZkRjcq6MOLbqYKE2CWKCig2MTupymhS4=
Received: from BN9PR03CA0797.namprd03.prod.outlook.com (2603:10b6:408:13f::22)
 by LV2PR12MB5992.namprd12.prod.outlook.com (2603:10b6:408:14e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 3 May
 2022 18:34:35 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::a8) by BN9PR03CA0797.outlook.office365.com
 (2603:10b6:408:13f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Tue, 3 May 2022 18:34:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 18:34:35 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 13:34:33 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Pearson <markpearson@lenovo.com>
CC:     Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Mark Gross <mgross@linux.intel.com>,
        "open list:THINKPAD ACPI EXTRAS DRIVER" 
        <ibm-acpi-devel@lists.sourceforge.net>,
        "open list:THINKPAD ACPI EXTRAS DRIVER" 
        <platform-driver-x86@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] platform/x86: thinkpad_acpi: Add a few more models to s2idle quirk list
Date:   Tue, 3 May 2022 13:34:20 -0500
Message-ID: <20220503183420.348-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91621de0-8bfa-443a-a4df-08da2d3392db
X-MS-TrafficTypeDiagnostic: LV2PR12MB5992:EE_
X-Microsoft-Antispam-PRVS: <LV2PR12MB5992F1641B8792F7CE17F7EAE2C09@LV2PR12MB5992.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fBU2oL6SYic7anlp2VfCnIrtCEhcwosUymgt/263qkAyaRfZPRIF8YTwPaKNBSCosdDABp9tfiFSq5COPibjY0Xj+5X35sVWPXhsNbrKDG9np6bDILATVpuuDfXQOoZz5jZgbDunbUyO7raZc+zmzgh4P4NcjRB5fKz1D33HTTrSyAjata5VuVKD/Yy9/KH+XqVQmLcPL2vatknX8b+bNODfvS8wiYS6s7R3a60oB9qbLTB8bultMDCrpe3G40v7VTMlppv+Va3negXXRbby59tJboXWvdaoaZG0HSpq3X2TNzYyvBW86V6sWobpnLvgpcV4WHfpZuTzPB+HHvS7YOqj3i1AXxsoI9SMLRNuBZY93y8CVA0Ii7WzENj1Y5F6nhgWEFee8VV4Wd5hrgHGolOzs1CO735KWcJThDVDt6dg8bER82JNlrHKlryTG5JBGteNcRXR+jdwVqRQLGkJfcuMXXeJASPBm3vc5I4lAXjjGRoeE+PeYuaHzWYUPe1uEGV6wg//AajcCfF5XoWzZzZmDKke5Mt8+ATNsVumLjGgtGHaAZc4LTyYW31eLwehG6Ti+1IEH/ayu1vRaSZO5b6xbQ3HOi5hDGFqQXi6KzX7584ZQ4CjimH79dWRR3Au8kNC7MZGmFkMz6fFnrmoiebn19guzSBWziGkIu4eDxqXszH9O2OMYgpmuGniZOhnT2PNcXzh4FeBNYY3cM+4lA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(8676002)(110136005)(508600001)(54906003)(4326008)(70206006)(70586007)(316002)(86362001)(81166007)(36756003)(356005)(7696005)(426003)(336012)(186003)(36860700001)(1076003)(40460700003)(26005)(6666004)(8936002)(5660300002)(44832011)(82310400005)(2616005)(16526019)(47076005)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 18:34:35.6015
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91621de0-8bfa-443a-a4df-08da2d3392db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5992
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Users have reported that there are a few other DMI strings that T14 can
go by, and so these models should also pick up the quirk to avoid the s2idle
firmware bug.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/thinkpad_acpi.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 2833609fade7..f3554068dd1e 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -4463,6 +4463,22 @@ static const struct dmi_system_id fwbug_list[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "20UD"),
 		}
 	},
+	{
+		.ident = "T14 Gen1 AMD",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "20UE"),
+		}
+	},
+	{
+		.ident = "T14s Gen1 AMD",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "20UH"),
+		}
+	},
 	{
 		.ident = "P14s Gen1 AMD",
 		.driver_data = &quirk_s2idle_bug,
-- 
2.34.1

