Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD4157A1A3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiGSOdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238327AbiGSOdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:33:18 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70AAB4BE;
        Tue, 19 Jul 2022 07:22:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzPoOYoWL5ghOa0s3d/TL8huVh5OYquhrsK389I8T4AA1zh9og3UnOu2XCwiMeOrIq2wJ4srnolrhIyawwXUKsX/T5Rh+3TD5H3FNEMQPSdeW+493PATLBYmXMpI/jSfnQBGHLGMS6oXhFteb4s8m48QDTr/vYYjjG3kXp083zx+NZw4VR9qfhPrJLPDrIH9mm9Xrqz/1YLrJlrEbbZkc0lc30frO3BsSayg+ivpqCkMS9AytTrnObrQTA7HCHnBVNk/1jYlwGyuiaF0i/FDaI/JVozxicsIeu/iXU8fJBPruxx135zvfppQ6kqehA4Fhe0cOcdppqMLbQl7D6aRvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CdakZyoYh21ndREI5FBRJMGorWfr8L99FCp0hiSSn/Y=;
 b=XgAR/9UNMGUlszV8uMp5GY99L5lnBZYt4CArh1TDWvUZZNnZA6Mnt4RYchwuk6jz70373YiSojkEmO6qJK8BtYGukLtwL+o1RHeaeFzEo2jXEKjdsLrQK2Michkc1HKXQDLmkaiBV9Q3BrMEqkNw5bCWQHntKHStCkr5Hur1q4+rUnt2kN4brR5Y2G0JkIsWauWYw6/Yjk9XkBbRNZpOjO/gGfQ/PouLdEjtWQEksWPFBNHX+IwoDw353xJIBpJl6Df19YZEgqcFv0kRYiT3bYYdOoIvKK8Wd9KSiqjkdeJnLHXP2Kc5u+j9hXaS1z3JNFVZbDzGQGcfPEA3OR0sDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdakZyoYh21ndREI5FBRJMGorWfr8L99FCp0hiSSn/Y=;
 b=FbdDG0DwlIUtaEduOa11D4M+sS0+8wuONvZqS4JH8H3WRHBhQIf0CqWZAAx6pWwJpUiQhf07mv3182mhDS9xCLsIjPh+UCAWxnvaZWZg5wZe69XlnqS72U6Q2O3WVWXRNcOpxKx50HTblD3DWaCvrS7jUSCrH3qSZyBEIPpo8AQ=
Received: from BN9PR03CA0954.namprd03.prod.outlook.com (2603:10b6:408:108::29)
 by BL1PR12MB5032.namprd12.prod.outlook.com (2603:10b6:208:30a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Tue, 19 Jul
 2022 14:22:18 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::4d) by BN9PR03CA0954.outlook.office365.com
 (2603:10b6:408:108::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23 via Frontend
 Transport; Tue, 19 Jul 2022 14:22:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Tue, 19 Jul 2022 14:22:17 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 19 Jul
 2022 09:22:17 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC:     Pavel Krc <reg.krn@pkrc.net>, <linux-gpio@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] gpiolib: acpi: Add a quirk for Asus UM325UAZ
Date:   Tue, 19 Jul 2022 09:21:42 -0500
Message-ID: <20220719142142.247-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220719142142.247-1-mario.limonciello@amd.com>
References: <20220719142142.247-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 149414e0-72fc-46a4-560d-08da699215dd
X-MS-TrafficTypeDiagnostic: BL1PR12MB5032:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RLn6HnK4MdRxSP9qB9NwEDxGlq9xPb1K+g8s5CYPywK6TSGX6jeojGXnjVAJGDf5OEpUzfL0DKu2eFAvEUOBqa9xLqk3UT4rmCGQeI32LouXQXLdEjlWU/hUd6PgXL6Qw3uP+sAYNY/t3cWuioX533BeukeE6ls7vCZiXBcQVzqAFI4c+YzoQ+vJhEHCYCVmUgA1BbBTlZTvHMG/MitO5fsRgaiAoIiicIh4vw24C5fIpmlOSVSE0bslptedklzfNJdzH1302rG9uY1ij7ySe6aXtbO+kzbQ1x7UY3jFs5J310pjzXQ8R88AoTu88ocX+mv9SG15nbyw7MAgx/R0e10WonGTmSa91+kb83sfzilpi44JvYpyvTXOKbmqa+yErbzShxdB4NPBOSIJVYmpVH41ZtztcLU2KqpjGmJwsp2fuZGcgBJXrPtSPF/6614JHEoWuSkYLcdufxd8uhEwlNfcGt3lxxOy4BD3wnErht1c4AlQQOFJyue3CrIL/olYFVcLIPcC7OAucnp+OG4VzFkHodzAxIyW+vyUqDGk0ZffH2lwGw0FC8UlyA4t+llun+DJ/9UmPoH9NQXTidgzpMIXBosk4Xw/zROtyCdSZ0BY8uGtNI7v6GGNOwxajPWDNAlMh4hNtGcp6St3SZBAYJGJQcKNyx04QAYoTkyOx0r8qUU+bUAQJ88pKzROu1k3oUX7akeBb8fV3JN5pkUMkkEND4YNLe4V9dW1OOmhJJ9fh6zIP49TFbGyTyOB4lhX3rFkhtx/i4CRbPiwslbejDteIs7lnoWT3UEScbksUBEIj+I2iatIGV2AeH5XUBKapiFlii6cakqK5fqHb27MIbtShGvor9DWAa5t6n0xPcpFPm9IXqLojFoLO2KORHOb
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(396003)(136003)(40470700004)(46966006)(36840700001)(26005)(83380400001)(186003)(2906002)(44832011)(41300700001)(6666004)(336012)(2616005)(8936002)(478600001)(40460700003)(7696005)(86362001)(36860700001)(47076005)(5660300002)(426003)(1076003)(966005)(81166007)(82740400003)(40480700001)(82310400005)(356005)(4326008)(8676002)(16526019)(316002)(54906003)(110136005)(70586007)(70206006)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 14:22:17.8534
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 149414e0-72fc-46a4-560d-08da699215dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5032
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Asus UM325UAZ has GPIO 18 programmed as both an interrupt and a wake
source, but confirmed with internal team on this design this pin is
floating and shouldn't have been programmed. This causes lots of
spurious IRQs on the system and horrendous battery life.

Add a quirk to ignore attempts to program this pin on this system.

Reported-and-tested-by: Pavel Krc <reg.krn@pkrc.net>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216208
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpio/gpiolib-acpi.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 375942d92d6f..2149713ea8f1 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -1586,6 +1586,20 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
 			.ignore_wake = "INT33FF:01@0",
 		},
 	},
+	{
+		/*
+		 * Interrupt storm caused from edge triggered floating pin
+		 * Found in BIOS UX325UAZ.300
+		 * https://bugzilla.kernel.org/show_bug.cgi?id=216208
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ZenBook UX325UAZ_UM325UAZ"),
+		},
+		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
+			.ignore_interrupt = "AMDI0030:00@18",
+		},
+	},
 	{} /* Terminating entry */
 };
 
-- 
2.34.1

