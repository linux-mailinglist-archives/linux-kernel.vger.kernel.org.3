Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A21A573C4D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 20:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236587AbiGMSAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 14:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236479AbiGMSAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 14:00:14 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2202DAA2;
        Wed, 13 Jul 2022 11:00:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EiZhnHDg4csGNluPRlijitD5Ec46Vqr6htYT7eBvVA0e2DHDeaLsNqr53EF7skK/EBTmctH9tm5XHlyqoJsX1DXQ1JwGerdT621Wu1Qmvroj6o5Cfne+L7aqRn3Ta+iPLRqTtL7sdyQytf2EAff7mJkl2R7LELtppEGqLL4iWrHs8hUyNVaGe7FkGh42m7sQOQ2sa70bBvTfHbk6pKu/0TdmIR41TEjqEf8h4MZgi862EQzBuv8axpY6GKEFFa77yA5Vg6aI6AJKffE0EdhLLWNuHUoZjrgO5nTDZmRkwz+PGFZDoyGpIxW2ce6p5oRYPhLfNsx/05KDd5t8BfKpbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3+5u3Uykyy3Fx6ZZHjE1MaqXki0VVWbz5bzkkcgM0E=;
 b=XaF0Rv4GN1S5ZVgayQ/mxDEJYjG24eJm2C/y5BgNPX6NJ2glbdU9Ca9FiVELrHKzLtGLzHgh0IL46CLy5wUONbDy/WjyhmISOvF89LDA1jCbziik/AQ6iFNBqh6bjsXhdgZuw6ODGK0mvH5jpiD5n3B7jjJcSJvz0YFDmYde3nHtSk7trRcEHhM3E0TiU+VNw+lcxbts6DopY0/N0ubLAGW6lzJCNGycxVIbtXRZRSHEU5lXu6m5NgxWiupJFGZd0WtJSXdcm4m+XrvR8TsZBmHosAqzzMq6ku9ZNON2GOFtMKHdTAaMtjIMWyQl/baMVkclDSlCmtTir54EjlkFaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3+5u3Uykyy3Fx6ZZHjE1MaqXki0VVWbz5bzkkcgM0E=;
 b=GDfSUhV7nPEGJLReJXxq1nr5vyyNhkc3hEJPI3rZlRdsFcrEQIPvM0E1ynDsFwTtIZJpZOcesxXdKbuwqzSQLNrqODgm2ii5hlytfSGzqyff7rpj/0Y09Jy2DGMENm6+lPIjzUfOmg3kWhfxggCa+UWGQnkjHtq3GZ+HtAMNUZo=
Received: from MW4PR03CA0240.namprd03.prod.outlook.com (2603:10b6:303:b9::35)
 by MWHPR12MB1389.namprd12.prod.outlook.com (2603:10b6:300:13::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Wed, 13 Jul
 2022 18:00:05 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::df) by MW4PR03CA0240.outlook.office365.com
 (2603:10b6:303:b9::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16 via Frontend
 Transport; Wed, 13 Jul 2022 18:00:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Wed, 13 Jul 2022 18:00:04 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 13 Jul
 2022 13:00:03 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     <Basavaraj.Natikar@amd.com>, <madcatx@atlas.cz>,
        <jwrdegoede@fedoraproject.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] pinctrl: Don't allow PINCTRL_AMD to be a module
Date:   Wed, 13 Jul 2022 12:59:50 -0500
Message-ID: <20220713175950.964-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff5f8ff5-39f7-4d2c-ed1b-08da64f98408
X-MS-TrafficTypeDiagnostic: MWHPR12MB1389:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DsX61uXxNrMIWAsp2wD47n1wYXPCrkFhTgYSGX57DsPXpsYW52ApuoNOcgeCOeTCOhzsuPzY5cnuFaY+89SwNO/ZdIrjpXsVym2OPLS5CwODemjWCWqAkiHJ1x/TC9KhMLNlzs3AgvQZj+EnYq6k7b4eyTBkbQJamDn5F4vsWVvPu6QA1h+DS0aZqEdxkuZuWbj1R8opihOv7IzY4WULLhKECvECnBwfPyyTx0xj4RexEooYg92ZHewPQgYjXKEmr/dWS38Yh9PawntHMqUiKOO3/KZwII0z6KpvSqiYm+3jlI0bk019FEggrdIaLmdbN96zIx9PbxUBYvxhZSpwAXMR1i0JWV08mqKpvKYUkB4KelXmnvYqgaFYgdzHuLyPlxrpdASmbLinp6qrc1Cjqo6AioODRzjdRfqiI0x+AQ0AeZcZ91An/qkKXGRkNdBR4AyRXuai8jazDHDwwjil96eRugNo//cOGleVsbTcxAULnz1AGGc/2tUX026OmrQAkd4AFbBnielqC/q8z8d6xM7jSHHudrnfDCRvMLBfyn9exW9IddKizTitfGfxWuRRcOJ+xQCWRf3QE1EwDNd30wH97m5lqdMUx/0hCyOCKLNjV4sSCe/sykaJO8JV6GbyXjxwEwXRCU7/qvTYaHtDSsAZrVrHn0ib5cn8YD0+lfy7l7hBYBfkoq0/PHww3D/5jTwknH1dICldnNz9yuovAwmHtO516dSsozeHNRFIHQCEM0bPXFae3QzjdzetZXTKYmZHYgxjJSD/lAssNlhg8+4iM4sBXsNTrivQ6dHqGCMYvayrDMiGTcehyb0sh1SExN7UvxcjmtMITdNcLNWiXcGG4gDh1eQ5fd4GA4yVGMzpzA9Rz24R6XSGGiI2eXFZ
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(346002)(39860400002)(376002)(40470700004)(36840700001)(46966006)(40460700003)(36860700001)(4326008)(26005)(8936002)(41300700001)(44832011)(36756003)(2906002)(316002)(83380400001)(5660300002)(82310400005)(47076005)(2616005)(426003)(1076003)(40480700001)(86362001)(82740400003)(6666004)(16526019)(81166007)(7696005)(186003)(336012)(356005)(54906003)(70586007)(478600001)(70206006)(966005)(110136005)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 18:00:04.9283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff5f8ff5-39f7-4d2c-ed1b-08da64f98408
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1389
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was observed that by allowing pinctrl_amd to be loaded
later in the boot process that interrupts sent to the GPIO
controller early in the boot are not serviced.  The kernel treats
these as a spurious IRQ and disables the IRQ.

This problem was exacerbated because it happened on a system with
an encrypted partition so the kernel object was not accesssible for
an extended period of time while waiting for a passphrase.

To avoid this situation from occurring, stop allowing pinctrl-amd
from being built as a module and instead require it to be built-in
or disabled.

Reported-by: madcatx@atlas.cz
Suggested-by: jwrdegoede@fedoraproject.org
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216230
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pinctrl/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index f52960d2dfbe..bff144c97e66 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -32,7 +32,7 @@ config DEBUG_PINCTRL
 	  Say Y here to add some extra checks and diagnostics to PINCTRL calls.
 
 config PINCTRL_AMD
-	tristate "AMD GPIO pin control"
+	bool "AMD GPIO pin control"
 	depends on HAS_IOMEM
 	depends on ACPI || COMPILE_TEST
 	select GPIOLIB
-- 
2.34.1

