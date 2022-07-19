Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA3057A780
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 21:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbiGSTxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 15:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237683AbiGSTxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 15:53:07 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2043.outbound.protection.outlook.com [40.107.100.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C3252E7E;
        Tue, 19 Jul 2022 12:53:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhUdgvKY7/aD9iMV//7uUoAuaoIjI5R1Y14OIQjr34FaH/tuTcw5p3NDB/0yud3iazMupX5E00Kgouf/jpbR/b3JMsWQhu9BwCJWyE9AuFsqPY3er/2d9loDoagScDVlPGV9YxhKrzYZjyiOIi6+dPq7hQhggvtVcE9G6693TWXr532eB3oeIC244M/iUDJLOVSHOXsMqHLfK6KEW4/xXWJQJMN0OMvvWM3GX8idHUBmMGrAFAdx1DTbzLYWW7RwKL/nk+P8IKHr4P91VXxDBOdBzy14SNCU8qdJoTIbkWOaqHkO3rfaW3Wv/6OBWBJEePcY3FGSOe6sUu9C/v15Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JoCTEt3xZp4z+2Fb/usOZnBgMyFA2YwyhTyEr5+bSQk=;
 b=UV4DhhGyrnGQzlGfwQPAKKnKyaTJW9pTsvrHWIMaWdKwMZkc8laQHFixTQxh6U5ZU0F/d352k6r8u65zrDh6rixXxspKEeZ9uc88Og6hB9ksK5PEPrnMaqCAvmjoVyj1UEySrnMNEaughpHPTm3SarPm93qdf51qC2pP7j1gSfOK3lwgu3Isr3uqua2d2bKenZSzRfsxKU9ii9B0bPEDQMHUikbjE9hVZAW3lIsGha6SRYLiaKmxwcsnncVqXdLn9m5DTJEF/wEAtOKy+MERZg776Shuf7gEycWZfBlZiYrXVkuEUblajJ67kBLbKfxmb2IIB5uD23OIkdbcnbVJQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ladisch.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JoCTEt3xZp4z+2Fb/usOZnBgMyFA2YwyhTyEr5+bSQk=;
 b=wjmlP7zh6sJEKVifqSkChlknz/BchMXzSKFYbqevWmGslOmRYkn1O3BAZ0PPi5wSftxwlLbzLGT1jtYErKtSPGxCk8Q6RU9kzGD+3m86ZJMx/zW+BC5ewS0bhvwWR0xX/MoSg5japJ4o3rLt5Zq5UVcS8AsQaqRnFd9KlfUfi3k=
Received: from MW4PR04CA0222.namprd04.prod.outlook.com (2603:10b6:303:87::17)
 by MN2PR12MB4254.namprd12.prod.outlook.com (2603:10b6:208:1d0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19; Tue, 19 Jul
 2022 19:53:04 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::18) by MW4PR04CA0222.outlook.office365.com
 (2603:10b6:303:87::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26 via Frontend
 Transport; Tue, 19 Jul 2022 19:53:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Tue, 19 Jul 2022 19:53:03 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 19 Jul
 2022 14:53:00 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Clemens Ladisch <clemens@ladisch.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <dave.hansen@linux.intel.com>
CC:     <linux-hwmon@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>,
        <babu.moger@amd.com>, <yazen.ghannam@amd.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 RESEND 6/6] hwmon: (k10temp): Add support for family 19h models 60h-6Fh
Date:   Tue, 19 Jul 2022 14:52:56 -0500
Message-ID: <20220719195256.1516-7-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220719195256.1516-1-mario.limonciello@amd.com>
References: <20220719195256.1516-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 921d60ef-a775-4283-fffc-08da69c04b21
X-MS-TrafficTypeDiagnostic: MN2PR12MB4254:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ofoou+rPelEz0Or17oqUdqzGUYefjANxhi6lkTv2lR+W8vn1vSZbau8CYU3HK1ZrrfrgUWSXhNg0KbaeQiqP71nBqASSqoPys3Y9ltb8cQJLOCOZSwa7/h76XIuEBBKyJxjZNna+wgB4hwGTBRgoQKHtrv38LtPdw9JUNO1rw9tsggYVz20BTVTiimKE4cnrv3jbNjmrMVnEY4XnvW2XPtTKKsQD1pGV7GCgL0lMXqezFXXRo98zIKSvRf3sDxMW4RuQR8Opml/xJ39tjzyhsEzZYH9RqOe9L6PY+31mgBvlbwoaOyU3inztfBW/O7xCPmE+8CEI/5LY7V1ZiOzTyIM2RfbTfDDmFTcWTuQ4L9RqhoTNBdIc53srhKmjAfSX9gsZvuRlviZxbO0TiSKv2vh27giN0QlJuW69SWQwTLm03JkkLxjj+xicm5bM8SO7xw1X6LEBcNgjmEjXnumetAuWVmTxoBYC6747GGB+wymVhIvtxZmCFo3dGhAmaV+WdHGIE0tEAVqZnBiEFRxWePi0yKlsF04CJXtDtS/RjSLQCEJPZsMqPukdyF+hxwIzvqy5Zpxl2FaVJbySqzOFO7KsrwWW9AYNBPpKGOwJQcRzPjeQZFCJg4mzUyaR5HwGyyYkVkZhvmfKqwpr5ziRZsWd5PBp6cNOEjeHx3L+AptV7gNSnsvxyTIrkYCgA6UcnNctVPy+ze0IqGaB6/xrI3ivckkIuvhqtRVv9oMTnDUbstqql35fd31BD7nLQAUiyjUW0p+0sLUkNSWifdmup6PplF15mhxUw17TOdHe2DWuL5jZx6n1H+D+iIV6KmBzUWhKukF2bhwR8higwuGIkA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39860400002)(396003)(346002)(40470700004)(36840700001)(46966006)(110136005)(16526019)(1076003)(336012)(186003)(26005)(47076005)(426003)(82310400005)(478600001)(36756003)(40480700001)(36860700001)(86362001)(8936002)(2906002)(5660300002)(54906003)(81166007)(316002)(40460700003)(2616005)(6666004)(7696005)(44832011)(70586007)(70206006)(82740400003)(356005)(41300700001)(4326008)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 19:53:03.9628
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 921d60ef-a775-4283-fffc-08da69c04b21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4254
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index 5f37e2e7833e7..5a9d47a229e40 100644
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

