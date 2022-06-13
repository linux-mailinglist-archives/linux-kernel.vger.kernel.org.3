Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94F4549F90
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239501AbiFMUjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243072AbiFMUi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:38:27 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2072.outbound.protection.outlook.com [40.107.212.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AF95BE6D;
        Mon, 13 Jun 2022 12:30:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFFUtJ67MniHxbq7ZJHIUnhwXmshY+yaw0I7i7vKFn9Ly72UgOBkWmwlCvO86hlLusVZNQMdEfJfuLY5sPXB76ETesCS6pdoJdvF1lz5WxBjmSU5Ucc4WkLN5m9rGob6fherSjYZY4JZdeamz/u328/ICeviZBJRlS5o4rnhycXruledkKY9/ZJ/IfMlIg49jKwD/NDv37f6rLeydc0QYigkFlAlsB1EiIw/rcc63SV+cipqsO948QPQafPmw86WrKCTa1BdfJAusF1LqcEnb5UhRghFiHGPcCNGAlTXy2gTjF4qB3S5cDe85TcaEQOSWI3d1lDTceR0sGBf1iDGXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wGQeRE9dB5xVd4zPTqfHRq6QH/Rc6K/GXAjfa6toZI=;
 b=SyTnrUVte3nOPgASRkND+p6cSgcQf96k55EMSYF7Hmhalpl3KeuPRivEmLBQRWopmsg17Z4jDWfy4fBitsTrW5W9W707p0+KhXUZQW3S5KdGJrihS5QF8j8s3oqE+FnX+AgHs7P/h9bB3WoAI6pCUhZJQNPGEUT2QKBUp9ONrLqd/WK4+1Yx1Ju+leSvv+ybdiSabkLQn59jb1lUmkLKIdXUf3xoY2hmfKOx3e3ec7XbNAxdR8EniKEjh+HcosIoo1yGUKwqr4xldThNadVmcMhHjE5RjIs88cMuESIrxvDtUeL4X9qOmqkqUxuZkfRG9Euk7bAhlLDfxpXSJ8h3ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ladisch.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wGQeRE9dB5xVd4zPTqfHRq6QH/Rc6K/GXAjfa6toZI=;
 b=w9/0OTh+ZLeCJdRBWeE+wfhAW38XMHrQsjuB9XQWkcqHYXi5XmWHg494pBsuEUMGTpudBGqJTCCcCPa42nY0F1si7ed7C5osdtZoT29jP1Nx0L9pghb+YL3HKL07OCeKMColoPBwhzXoBiReKxZi0Ht/nleJfRdmwVk0nd60GQk=
Received: from MW4PR02CA0016.namprd02.prod.outlook.com (2603:10b6:303:16d::22)
 by BYAPR12MB4741.namprd12.prod.outlook.com (2603:10b6:a03:a2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Mon, 13 Jun
 2022 19:30:20 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::80) by MW4PR02CA0016.outlook.office365.com
 (2603:10b6:303:16d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20 via Frontend
 Transport; Mon, 13 Jun 2022 19:30:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Mon, 13 Jun 2022 19:30:20 +0000
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
Subject: [PATCH v3 6/6] hwmon: (k10temp): Add support for family 19h models 60h-6Fh
Date:   Mon, 13 Jun 2022 14:29:56 -0500
Message-ID: <20220613192956.4911-7-mario.limonciello@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3eb995cb-f0f9-41e1-942c-08da4d73276d
X-MS-TrafficTypeDiagnostic: BYAPR12MB4741:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB47411321229D73E0501BA8D4E2AB9@BYAPR12MB4741.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zi9VVGhA/aYUsTYPxKK2RPOYisSNhuDEeCE+baxqc6e+3ZpSuo3AVgvq1utwvRpFyktd03v3llOWsS4zgvv0Gdtphn/y8GQQvZ48D/mcj3aLlCYY2riTPJqETlLoi9HUf7WXyKWrDxm/KEHIipgq5+nHw3ffUtz1Ozs1TquqfLQlUp4gxoRF4hDMO8n2PSRJYJIxUXdm7S7HAPgFt3o3cTpDWMC6R3sG8kUXXftQGEGuqjjq5x2Ku5loFR941Exfy7vKTL6NctZpVKGbhkEnzEe4W9hx4btZD2/6Rr2r4Pm8aB6N1JfjmH4DjTHZT8frjBDtIptIatbgijlKftXIjjeGq2/Cp96ODf77oxYl4zAYsyfDYWDn04P3kYCljKy/N0dqzviSMhXZGMVHy3kcrvcQIRIb+mAhvA/frtoEjZPJXeLgV05KVtLnSKvrKZLR23LSeEoA0utXBn0XHdBQ0LFfFUzvZN4DXl+v4OJXjIzyK91W/16jgIiwB8i4e8kWcrNpaaKnsP+1fhkN/WqhV5o2zyI2xOMrmRx8Yp4Q2E6ymOIW5xxjA1977BeP7KVbR3d6i525sDHWgQ17t+cFpOzXCgmOcNGbXv4FQr7uPHGk/XyEJVo8Bv+htJKuvy7uZZbn8CTYsc7GFxAfyakweNMahGVeoZdE7WliCYxlxCRHv9audHk8ZWlv9gitYCUj82Y+Lkdz3Sirs4jlCM/ZKA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(36840700001)(40470700004)(46966006)(36860700001)(54906003)(316002)(36756003)(110136005)(81166007)(16526019)(356005)(426003)(82310400005)(2616005)(186003)(336012)(1076003)(508600001)(44832011)(47076005)(6666004)(8676002)(4326008)(70206006)(70586007)(5660300002)(7696005)(26005)(40460700003)(2906002)(8936002)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 19:30:20.2542
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eb995cb-f0f9-41e1-942c-08da4d73276d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4741
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the support for CCD offsets used on family 19h models 60h-6Fh.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/k10temp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 5f37e2e7833e..5a9d47a229e4 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -449,6 +449,7 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			data->ccd_offset = 0x300;
 			k10temp_get_ccd_support(pdev, data, 8);
 			break;
+		case 0x60 ... 0x6f:
 		case 0x70 ... 0x7f:
 			data->ccd_offset = 0x308;
 			k10temp_get_ccd_support(pdev, data, 8);
@@ -502,6 +503,7 @@ static const struct pci_device_id k10temp_id_table[] = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M10H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M60H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M70H_DF_F3) },
 	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{}
-- 
2.25.1

