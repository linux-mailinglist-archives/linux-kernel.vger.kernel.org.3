Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC14A53ABC4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 19:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354291AbiFARXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 13:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354241AbiFARXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 13:23:13 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA92A33BF;
        Wed,  1 Jun 2022 10:23:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogmc8tgEX0RQPpqjPtbyqb7e4Yux7BqdoX2qW2nnI7fTkZNjRip5hmWiC4VPnlkYwC/Qdo8GjRj9VTmM/GmAgqMSEQIU88ohpX8hun8nfTZgYFM5d1ijl0HqMTl3DSE3SMpkG5/JcZk6uLRIuSs91BnQfZdC1KEBSCFcG2XcqfjRwY8G2xqPj9oKvpCXwm5xKPrZ452nBCgyKoIMf+8aNYJ7dbOSNaAHSzUDCU6eDkhZz/k7VvBh7KQbE8Ljozy7VjlCDj5zaD52u0ppK5gS8KleUu7N50KBRPbZLQM1e8heUroATdSxVJPDf3yzXemmFzdPphu340KLIopH86ReDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gH3esTinjgzxfhCIl4hWtxZ4GlyYXHnAB4NtU5/6CGU=;
 b=PDJg/YgKOsCbG/awiEBRfSNB9rcGYgV54gWJhu03Z9pTcQyjpbDgPEq/IEM6Pmw0OI7oHD/3CkovsT8XxSnkOr7sAavsYoHkp9/pzelCpj2VHxuzRKybzeT19Es5Nn7graCpT4pMfoXQsiZqflZsTkZwKyWq+k0oJvrIQVN1rhNIF00oROeWxnW3xdSrHzcB/EiB4e87g2XAZPKDHj/g7LKVZcNKXCTR2BSXEpAmDg8RSFs7V2GZjpLn0mEb69Hx6z9KFjpLCOuBRoCQNQWQdNRt+7RK7Duws1lX2DG+zrACD2ThaigT0SEKOGyiEETNnx/K4edZBz5By96N5lInZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ladisch.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gH3esTinjgzxfhCIl4hWtxZ4GlyYXHnAB4NtU5/6CGU=;
 b=B+Ka0y/wEJHvFsAg4BPLWaBfbNRz3ROpLa39ajP2oJzkZM9XUNC5uQGjtKK9yg/PIvLqq8EdWa52t+v+2GqXl3eQSYHC20ykDxLc9gP7KVMWZE1QPGokiask/Qfgif97bTphX8UJJaVilr7Rc/xcjEkMq5YNdoX0CATCg1ZO8NA=
Received: from MWHPR1701CA0004.namprd17.prod.outlook.com
 (2603:10b6:301:14::14) by MN2PR12MB3822.namprd12.prod.outlook.com
 (2603:10b6:208:166::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.17; Wed, 1 Jun
 2022 17:23:09 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:14:cafe::12) by MWHPR1701CA0004.outlook.office365.com
 (2603:10b6:301:14::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13 via Frontend
 Transport; Wed, 1 Jun 2022 17:23:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Wed, 1 Jun 2022 17:23:08 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 1 Jun
 2022 12:22:32 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Babu Moger <babu.moger@amd.com>,
        "open list:K10TEMP HARDWARE MONITORING DRIVER" 
        <linux-hwmon@vger.kernel.org>,
        "open list" <linux-kernel@vger.kernel.org>
CC:     <linux-hwmon@vger.kernel.org>,
        Gabriel Craciunescu <nix.or.die@googlemail.com>,
        <yazen.ghannam@amd.com>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/2] hwmon: (k10temp): Load the driver on models A0h-AFh
Date:   Wed, 1 Jun 2022 12:21:19 -0500
Message-ID: <20220601172121.18612-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220601172121.18612-1-mario.limonciello@amd.com>
References: <20220601172121.18612-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54d985c6-fa22-4abf-64f4-08da43f365a8
X-MS-TrafficTypeDiagnostic: MN2PR12MB3822:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB382273A53F8AFF3FB220243DE2DF9@MN2PR12MB3822.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H14LvjMy1b4e/2M96GdwQ5oDhSz0746YveXJhGI3V6wKqcj5MFhYB+QpI0FanRENJ88+/55jChx4xBeq/Jat1oQghh7HK2fD0OMUdGLkGABM7Cn8FVKIdxYXgMI9Uqg9zXXK8tIk15vKe56D/a1LTAIskMOKbhYv21GTg1dvAK9F0sddfwpz2isCogVFMEiP6wOn3JM5AzjRhj3DIMkEqElc4hKZSFz7pPa2HpqejKyjzFHvtz3xPDPgs7wzgkkjkLmKJ444MbMaOSs70G2XVUyBmt/UpvDTBZywzc48uwN0BhkBGFDx3VDemrwlrTLpLyVJkrJwd7+Z4kZ3EKd/WtLYPzWm3SVvmxcp78GRFNz3Lh3zR7Il3x7KghZODg54b8fgnxnuRjX2XkvZ48dm9uWwy/t4BfwZGI+5JibzobbcqD8FP/NBuDl63J1DqI7NWrDlJdjsMmQRjlYlml0ABV1rLI/mY/BM7fFTgrINAE4zyxxA1l9FQ7h5blFZ5042DSHeXpCIAykgwPiyYPN8ic7jPvxoVUsNS/aue9PDTmHvH6xkFnYJTnKobO7qpvc3kohmxdMRf5GPMQYH6qe8vG3SXYUqdns3OvAI1dGv8yyAQgmKQnY1rj7NBp+u9xpLbFofeHLCXK/wzAu/BUysMntMglFd14GAKTRXh5v/G1M5MqGa6FCLKM6NWpoImPVE1bLqSymMHT5Z96Vj+46ZAA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2616005)(47076005)(16526019)(5660300002)(336012)(7696005)(8936002)(186003)(4744005)(2906002)(26005)(36860700001)(40460700003)(1076003)(81166007)(426003)(356005)(86362001)(82310400005)(70586007)(110136005)(6666004)(4326008)(8676002)(70206006)(316002)(36756003)(508600001)(54906003)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 17:23:08.6120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d985c6-fa22-4abf-64f4-08da43f365a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3822
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 8bb050cd5cf4 ("hwmon: (k10temp) Support up to 12 CCDs on AMD
Family of processors") added the CCD offsets for models A0h-AFh but
didn't add the PCI device ID for the device.

Add the missing ID so the driver works on these models.

Fixes: 8bb050cd5cf4 ("hwmon: (k10temp) Support up to 12 CCDs on AMD Family of processors")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/hwmon/k10temp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 4e239bd75b1d..80a489f89aa2 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -493,6 +493,7 @@ static const struct pci_device_id k10temp_id_table[] = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M10H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_MA0H_DF_F3) },
 	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{}
 };
-- 
2.34.1

