Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32615549F94
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243199AbiFMUjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243052AbiFMUi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:38:27 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4EB5BE68;
        Mon, 13 Jun 2022 12:30:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5lUxtVdMuJJGHYMBYOiOi6RLslAdNUmW4iALP9qRhtjr1xMpeom9dayeYG3pwQWtl3bryN0ydOGOJkVKEY3fOP1qR+ukBHIAgZ1lrtVTl5gboCn+Mlm0qkCtuONbWbgR52ohv2ulaT0teVbA6nmHRmxq5AJpNh+8BllQODA2BodVH960Xswpa8YOhESPijlRw9gzgGP1BQGWl8MFLQk9n3c+Y+RwWyUA1sknLAOvQNC5pdZx8v3EozptZMApJ4rlUTPk4kXJrFD8Q3/V46AxVFHzedLcbBeW5WI/kCdlrJmr3BH1DgAE73JIYPoGo8zsAtj44Xyxbm+W3A5qRMYdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLHJHTH5OQrFcX/JuuUMBpW69SLYm5ZgbDw4u1xvGyQ=;
 b=XCPoOjRAb2Ljo2M7V3OULkLe5kZPpwMC8zf1QNnIHJlgJfthYHLmEq3PxTrgTp1v7EvWNgla0fWyvXVCkVLDbj+KRDMKozRQA/Ur5qfmTqofItZkumNX4NRcu8c/tvAU5M0bQHG5NYFCWDmurDSuRudwIgTush17TEaCcCPb/51I6GP6PwGqytZO9kzmqU4V3nVkZNgQnaH75zezVG94VMrtfppUUQpqRwZweHZLWjPGoQI+vjnBCIK0/ohNK9A4NnhcB9sCMcw9FXEr07IPSaTlYSVp5pjUJlPwc+yW2IkLwWhe/hToab61MqQifV4+9P1J7BGMgqEK8hpxmJzs/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ladisch.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLHJHTH5OQrFcX/JuuUMBpW69SLYm5ZgbDw4u1xvGyQ=;
 b=oozHYCbJqTxFWhnQ3lAEXwniUUR9lkzHK2B2fwwn56k92BRaHxT3Y/cL72tR6BnYr+Vx1uhiexDQ6P0nP9uFyXJpAhWW4y1RpMkHjCiScZTftd6XyYDHL0YIxWk6T9YhnIQSBpshE9+Kp9JaN70TwyBDzFfv1eItmAm1h5HvHZQ=
Received: from MW4PR02CA0015.namprd02.prod.outlook.com (2603:10b6:303:16d::6)
 by DM6PR12MB3068.namprd12.prod.outlook.com (2603:10b6:5:3e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.17; Mon, 13 Jun
 2022 19:30:19 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::e4) by MW4PR02CA0015.outlook.office365.com
 (2603:10b6:303:16d::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16 via Frontend
 Transport; Mon, 13 Jun 2022 19:30:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Mon, 13 Jun 2022 19:30:19 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 13 Jun
 2022 14:30:15 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "open list:K10TEMP HARDWARE MONITORING DRIVER" 
        <linux-hwmon@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     <linux-hwmon@vger.kernel.org>, <babu.moger@amd.com>,
        <yazen.ghannam@amd.com>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 5/6] hwmon: (k10temp): Add support for family 19h models 70h-7Fh
Date:   Mon, 13 Jun 2022 14:29:55 -0500
Message-ID: <20220613192956.4911-6-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220613192956.4911-1-mario.limonciello@amd.com>
References: <20220613192956.4911-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5471c8ad-79f0-44a3-9e37-08da4d7326d2
X-MS-TrafficTypeDiagnostic: DM6PR12MB3068:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3068F7748C201400EFB5AA7AE2AB9@DM6PR12MB3068.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4SyDEjflxV+I1R2yezU64o4OOLnF8ww6/MKv72BV3FbD/7aKSgXdohaP8ZR1pSEadBIGnDvbwIQAi/Gtq5UAwBixYC4QGBng9rMPvSKsOGtRZYscXbwxD/dNNGJs8Yx8VPnnx84J80G8ov6pO6TgKJadxUbkNYSY1B4paNUgv2DzlTlfNK2F1hkF9VBtZB976pTnG3Py6KG+eqCHUKzW0GcNkfIrMu08LnTdEE0Pf8jPGhq9SrXpkwNF4MdVoSQC2bSwu3Pl+I6EjzUVvg+IE1tJhp75YSIKZHbGxDkaszlxOGmz8/6dy5liyKL1hS8+Afhe0t2rzS/rFn8RHlwTrVzrWNvLsU+GgOu9F3NnByYgJX7Gy9XkQpT/L0H+qS34A1hV1emXfEHZx8yisWx7gL/6E0pJLO/OeU5blCPT1r1jO7xGtApD/Jn3emZBvTV2ZaGFHHgmIJz74qjP/oKyp/uIyq16/GQumHXMSd86YB/wO0TOJ4CNne/nxs7WOznqL0Q/FGgMC4QlGKFnVvf4UsbbiXoCRVFqCUkmyoNeMq7cOe7IwkbrvyT/01SYmWvTV4sHPPMPHAQRUp7/UgGyEWDtOfr4xGbhscCOVxBTcf5mAnhAIJjjQN7pCt2ANWLheRjEXUM3H50U0DNiNirJ7MC2HGBcK4g+Sov1NFfN4YaDFdAFrmhysUJxySoQI37y7a82YIkytVkYZc+bQRvD9w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(46966006)(40470700004)(36840700001)(2906002)(508600001)(82310400005)(8676002)(36860700001)(54906003)(110136005)(316002)(40460700003)(86362001)(26005)(70206006)(6666004)(70586007)(7696005)(4326008)(81166007)(36756003)(186003)(16526019)(2616005)(426003)(1076003)(336012)(47076005)(8936002)(5660300002)(356005)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 19:30:19.2386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5471c8ad-79f0-44a3-9e37-08da4d7326d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3068
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the support for CCD offsets used on family 19h models 70h-7Fh.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/k10temp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 5f831e74bc51..5f37e2e7833e 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -449,6 +449,10 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			data->ccd_offset = 0x300;
 			k10temp_get_ccd_support(pdev, data, 8);
 			break;
+		case 0x70 ... 0x7f:
+			data->ccd_offset = 0x308;
+			k10temp_get_ccd_support(pdev, data, 8);
+			break;
 		case 0x10 ... 0x1f:
 		case 0xa0 ... 0xaf:
 			data->ccd_offset = 0x300;
@@ -498,6 +502,7 @@ static const struct pci_device_id k10temp_id_table[] = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M10H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M70H_DF_F3) },
 	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{}
 };
-- 
2.25.1

