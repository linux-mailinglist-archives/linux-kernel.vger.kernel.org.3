Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52EC653BF72
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 22:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238402AbiFBUMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 16:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237676AbiFBUL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 16:11:56 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2050.outbound.protection.outlook.com [40.107.100.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5489CB87E;
        Thu,  2 Jun 2022 13:11:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JwnfnBzToLdowQ+N4hKHHAhqKchwH1qk2uiUj6Iiy4AiCARtzu09osGr5yBZjudk8JSpUUeiu6gd80AouSXFCkipc8tUw3fts99PWXdNu0Z54+DHzsDG+3i2A3DED0Er0sUzMi7HI5YTtTIiLGc4JnPEN9yGvlTPR25cXE0kn2SvwbCLVORrwQfQqwzniJ9rk/bKdG+OmivEA3ua1Cur0uQKXho3fkQMFmXBxQCWB/1jF5HegV7Rw26SSoozEfVcfk3Vfm/zt2STCX0jDLl49L2Wsn3xsLzsGG5n5hMa3qzLV7N6bsx0PuAiXCPpkBBqsWzY94C1fDaI6jBMqYaC4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtyGdWOUtX7++ZhJyDyzd1RtNQ3n/bBgTMe4AW1yqNY=;
 b=fwUU460bXVjEKnkwh/XwYBv/G+dxykRnMCrxkQ23FUHb7TQXaXoKH4paJntqsDc3+yCFGL1WnSrcuTIi+Y8lT/jxd8LgY+NllUpsF2zTYjjPiOvrvardiUs4Qo8mVY6SJjzLYxOxKzt84UVPsGB9O2Zav4Ut4XBqZRcfWXrOYT2Xf5gfC+ndDsVSnSfS2NXrzADtiHuO79E/kdsKn73NhZe+oHQ5HKJM4JpBYfQrYe7vK1twYDz1jVt//UpvbsKSEP6A3LSHIVR4/BulZ4Ux5GSPt89HTuFAg4q1XuylbPvqRc8xTVeW0F0zdc6VJ1SitzrRFreF1T2l5M+WkPq2mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ladisch.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtyGdWOUtX7++ZhJyDyzd1RtNQ3n/bBgTMe4AW1yqNY=;
 b=t5OJVffHomH86B48obZ/29jEurRi9fiQ65Tjk7e17why7FvcD98vaTEIkaVe8eDHulfARHQ8EaTfRB/eojnYoUBbuwaZN/XARHRle49cYApD3PG0d29S/ylym1srJF2alq+ve/Bdt+J2jj+VXEgppdIRbpCo2iiyucMR8wSC8Zk=
Received: from DM5PR18CA0072.namprd18.prod.outlook.com (2603:10b6:3:22::34) by
 DM6PR12MB2699.namprd12.prod.outlook.com (2603:10b6:5:4a::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.17; Thu, 2 Jun 2022 20:11:48 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:22:cafe::2f) by DM5PR18CA0072.outlook.office365.com
 (2603:10b6:3:22::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13 via Frontend
 Transport; Thu, 2 Jun 2022 20:11:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Thu, 2 Jun 2022 20:11:47 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 2 Jun
 2022 15:11:46 -0500
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
Subject: [PATCH v2 4/6] hwmon: (k10temp): Add support for family 17h models A0h-AFh
Date:   Thu, 2 Jun 2022 15:11:35 -0500
Message-ID: <20220602201137.1415-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220602201137.1415-1-mario.limonciello@amd.com>
References: <20220602201137.1415-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c5a7ead-00c7-4c64-5763-08da44d41fa8
X-MS-TrafficTypeDiagnostic: DM6PR12MB2699:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2699998A3C8310BA72764E88E2DE9@DM6PR12MB2699.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0U6TQQv8a5PGLVpiZnNokY6yPLb1fmnlGlq5wZpjLSYaDNRDpuC1AavVtRH7S5uDmllyJBN5waGIJ7g3vZvJ7VcyxDembACcMBDs0ddf/UA/kc4CIu0zntnSCC2NIz3ajjfkEtDzrKbrKk8UlzxIKG0EfryQlc+Xqbs1ulzM8aAv5f6U8gLhcefa9nYV4mVWSkIAiPkLnuAzzFnB9NJB5n294R/7Klo0LZ+p1oHSxrpy1800YljSVJsPKEEVukbfiJ3fGS2YiEyqaIVmExFmevPVNAslp4tp7MIqE7MBTy8GhSK0HzGXUPRKIDM+HBiuafuxwNsU3w/0BlZoSqBTIX4VMAlXiojqbfp7ZCFLHjdcbwbiuGL+9bUktphvzspDNO3wJPyroK4hgKaTzmfFEQ/W/HW+GdgE9Sc48kp/JXfu2e6A2FPnKgSKmuXmHWUmrZzSF/DVtYn5wswV40Q9QJHTkiRHgb+ZwHCd2f6sSq7i2/WYPCKaR1DOZO0jdQj3yKPwiEkOcg2DGn3iLXFC1RN2YVe6GmuV99MjXSt0plDoNhAsCsOI+lLU6Ui+VLFRgQ1H7Zmd13p9QFwQV3C1YpmfaQcHME9Z8tCXBknhVbq528Tg9os/6IKfvXlyXB87xpk3+nrQTd3iloyjk5NsA2jspwthg/JqAjLoqHDQneiEDUiK9WGEicT63DoILzL5XkEc6SyxnPlNdLfupNS3jA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(70586007)(54906003)(4326008)(40460700003)(8676002)(5660300002)(6666004)(336012)(426003)(26005)(47076005)(8936002)(82310400005)(44832011)(316002)(36756003)(508600001)(86362001)(70206006)(110136005)(2906002)(7696005)(36860700001)(16526019)(2616005)(186003)(1076003)(81166007)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 20:11:47.9978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c5a7ead-00c7-4c64-5763-08da44d41fa8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2699
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the support for CCD offsets used on family 17h models A0h-AFh.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/hwmon/k10temp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 4e239bd75b1d..5f831e74bc51 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -428,6 +428,10 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			data->ccd_offset = 0x154;
 			k10temp_get_ccd_support(pdev, data, 8);
 			break;
+		case 0xa0 ... 0xaf:
+			data->ccd_offset = 0x300;
+			k10temp_get_ccd_support(pdev, data, 8);
+			break;
 		}
 	} else if (boot_cpu_data.x86 == 0x19) {
 		data->temp_adjust_mask = ZEN_CUR_TEMP_RANGE_SEL_MASK;
@@ -489,6 +493,7 @@ static const struct pci_device_id k10temp_id_table[] = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_MA0H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M10H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F3) },
-- 
2.34.1

