Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD6B549F95
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243591AbiFMUjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242614AbiFMUi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:38:26 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BAB5BD3B;
        Mon, 13 Jun 2022 12:30:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0ZHzzv6HO2OpaCSJOHqIokKrBeOI7ZBnF65ttQ+rqdTReM9sh2rlDVZCn2Y6i3DmBzGx83OvdAVhdDkKAFnOotVLn527oBTASQymk5LaNnt4tM2aalJa3C0Y6mXe+I7pb0YQI3kct3rbOQkB1OSOlNY87CiLhJSxExxKxBzaWnfLJBYDGcmsjhgKJhTlw8gnGQxGQvS9jqporJBgKtUpGjzuLQTkXVnGxBUWwyzpQB4V8i5Q683WTqzfUjYEcyPXtYhLahiI0qA5c8KXY2Yh4qtGLE8g4iN2TaGxyJ4a8kac5jStIOaTdbBg17kg63FD4PjiyV8PhynTrGdJWWSwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ap86ihgi4sFANbME5DoVTwCMJLnETl9X8GDDgDSVo9M=;
 b=GlGUUYv7dE2FwO96OaIetHPdhLaG2+OONzX8kD61HJDKg0xPjUAjXtow/36EbzoK9pxTcWBReIW9hJVs75Ywz3LuHl+GN4Hxo4XqWpEFaAtmaEbPiSLEODDRbNtSDj6Exzjxfs7MS2vrWSpKeyVv9YXq8ECjPw9FXhPK8C38HFZh0K/xauQvhyu063QLY1Bh3QCgoUxlwJjZbvEdmMeVZ+FX4SbYvDB+JRvoGsiWR/eynqDBRPrOfEXQgeetzRWB8qOFmreI8LMkc9A98Y0oxRBosrIjyAj1XI0YtU+mrLPCNpA2O0OdPZD/P7yJylzksXzT347/Z8wngrj+dyTkUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ladisch.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ap86ihgi4sFANbME5DoVTwCMJLnETl9X8GDDgDSVo9M=;
 b=yuswMt6j1j+n+IsZc4P912ucz6xzPGVtdsDFfuyU9Dy1Xs6JfK2zKwNU/DDb5WBwXwkoXlnRVzzlsxcq6vb4Da3sffXrS2WFhAhG/RMFKwzD53L/Xc2bFMH4ONs/3Us8Z2f4P0xEG244p8Ko2nC5UKg+EnzpuqqH7CudmxZK/tc=
Received: from MW4PR02CA0013.namprd02.prod.outlook.com (2603:10b6:303:16d::13)
 by BYAPR12MB3384.namprd12.prod.outlook.com (2603:10b6:a03:d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.17; Mon, 13 Jun
 2022 19:30:18 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::d3) by MW4PR02CA0013.outlook.office365.com
 (2603:10b6:303:16d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.17 via Frontend
 Transport; Mon, 13 Jun 2022 19:30:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Mon, 13 Jun 2022 19:30:18 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 13 Jun
 2022 14:30:14 -0500
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
Subject: [PATCH v3 4/6] hwmon: (k10temp): Add support for family 17h models A0h-AFh
Date:   Mon, 13 Jun 2022 14:29:54 -0500
Message-ID: <20220613192956.4911-5-mario.limonciello@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 889f70b3-a915-44e8-dfa4-08da4d732670
X-MS-TrafficTypeDiagnostic: BYAPR12MB3384:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3384CA2B94040C88DA53B3B7E2AB9@BYAPR12MB3384.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cz3iI4Iyvh0NQDA4hWwTq0q5V1mb5KM/zZBV9I1XNPZMo/sJhprtBr+GYRC2iDBjsEuogNAJHqZvFA/S9qrEi92mQtF3houIAlhllHnlHDEIpfIDWFMvi9kkU+sxdhtH9VuwVeMwTWg6Kxp0HBtgdbRoXuXJkKJ9jAzh5Szxn5oxiMG3P+QiADhicv+ciqjnP69bfhWlSZTdHP/5XlZrUvT326nMVa8xRDT/QZLUJFR6TvHgWIxveBidsjsp2h3JP4Limu4Fk03MHNGKBS99Bm16jjZw0FaDLxo8ZB3oglLX+fojs7nM6wUm9xTWDfncsu8ClYjMc6dXtt2kVnHHBxbfi8ujzCiy/PcFs+by7yDZ39GVQzahQIcOnv7EdyizUc5hu8LP1IyCMqFinlWm9190VtJLoZnB2oKGjt50HSn2AtL0N/tJkeY7ti2Fy1P3RL1hwvg4JNmemYrUwEjCD/Gl0fh9wfiYmoajoZqKeVQCQ1CIp36Z+0SForKwPI/SWIwoXHCSh3W+rn8INXzmlTdW+ABYDVjkYCt7NvqesLAlmQxNBEwt9GqEYDGqf8mUGo16uZDprTy4QyqQQGl78cSb3rHCU8NBlg7Su7uNqB0xL9ajCNWBYKH2GEc+eXBKxP6xD3DkE/xoqgq662UjoEQOLLWeaveBA5tVx6T2/3V3SCulkh9RR46vz1KBegSmAlWiiFu5k9/zc+LVL5HNrQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(40470700004)(46966006)(36840700001)(81166007)(426003)(186003)(86362001)(16526019)(26005)(336012)(6666004)(47076005)(110136005)(54906003)(356005)(36860700001)(82310400005)(7696005)(8676002)(316002)(70586007)(36756003)(4326008)(70206006)(508600001)(44832011)(5660300002)(40460700003)(2616005)(1076003)(8936002)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 19:30:18.5980
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 889f70b3-a915-44e8-dfa4-08da4d732670
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3384
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
Acked-by: Guenter Roeck <linux@roeck-us.net>
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
2.25.1

