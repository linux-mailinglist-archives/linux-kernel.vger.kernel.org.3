Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F6953BF71
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 22:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238725AbiFBUMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 16:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238140AbiFBUMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 16:12:03 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2074.outbound.protection.outlook.com [40.107.212.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E819B8D;
        Thu,  2 Jun 2022 13:11:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hf6V3+sRjNsoe+3JymHZP4E9QOBH3WP/oQ89AkRqfQu/hLiD6yKp0bhusnakuXwUZG+BjmvKp4IsdxGX0XAvV2idAVl9/HnMupFsbeQFM3iA/5U2X0qGe2Ofn0Ij4TQJ3SbEZcUwxB+8POvkchLFZiFYiuM3Gpz0aNuXu1py60RFhJ6hqzxghPoi+Rq+6lYJD9HqqqDM2/UeCILSNacxgjaqgjgZ+KGpjraa8Ww8K9rFuSKqYTgyi8EO4ZMuinAA9jadTtKvXsfA0u0jcbBNRpGP7DdDIUXaVMgDqQqKcfaPKSt19EWbfrWd6F5pdWhYASMbHakXC2xz/UNduvh53w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dRRDtyfuZSUkr5LYhGnHNslyDFA5ROC+AwBrrA+azU=;
 b=KLE2EZnYFypF/uB4H31IiWpZ/g2LKV6LO4cSf7nZhHVuNtsLGggmABbJO7hw/RJiiIvFCYrTqFubJj0RFFqWATMRPAcfldGuyYT0fOgoUnESzvcVEL1eybtRc/hseWzLaWxRaO7IewLYssa1ZVUDrLMqM1w4TgK/C/+xlqa43AsJhtwA0SOTGcdDXXuQDunYZ5LkJvuS8UMnJm3MGRvQbungGdquzRbYH6HSnNdgrGdQnyl/H5JcJQFE5rkm4zHNav/gVOJk1mcvNW1R5IRjY5GBqAPYbOzXHtLG5W4IjcYgxkZ7tXm/Dtz3+2uIt0t4wHi5wuJL+H2bBV/aPtqNvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ladisch.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dRRDtyfuZSUkr5LYhGnHNslyDFA5ROC+AwBrrA+azU=;
 b=nMufSjlHBE/xwk9P82iAt1AjR93FAcX0eVnuibNy5/XO+N2Ykadbh05e2dHcEdoHzOrTCcxMiZzFVhhfbw6ZKKpUOyIRKWvjikxpw55PzSpfMNoO54w5XSw3MPkHxOpne5o8upsWXIS/OeyC/0qZZNLu0IkUDN4T19nflDQePq0=
Received: from DM6PR11CA0031.namprd11.prod.outlook.com (2603:10b6:5:190::44)
 by BL3PR12MB6452.namprd12.prod.outlook.com (2603:10b6:208:3bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Thu, 2 Jun
 2022 20:11:54 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::3b) by DM6PR11CA0031.outlook.office365.com
 (2603:10b6:5:190::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.14 via Frontend
 Transport; Thu, 2 Jun 2022 20:11:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Thu, 2 Jun 2022 20:11:52 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 2 Jun
 2022 15:11:47 -0500
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
Subject: [PATCH v2 5/6] hwmon: (k10temp): Add support for family 19h models 70h-7Fh
Date:   Thu, 2 Jun 2022 15:11:36 -0500
Message-ID: <20220602201137.1415-6-mario.limonciello@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: ea39f804-d2a0-4d00-5f66-08da44d42257
X-MS-TrafficTypeDiagnostic: BL3PR12MB6452:EE_
X-Microsoft-Antispam-PRVS: <BL3PR12MB64524543AD65390B5D3E52DCE2DE9@BL3PR12MB6452.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0P/8PCkHcKuu9KFqi7swoefkhNEU3KX1EmPd/VAmNc7WvOpLTxSKqDePAyBZ408qNa7akwvU5uFm26WKRlexTWYEYyqlsjZjqTe9LTJioY3DRe5rNZ1vPjq/UONgca+dnfSffdCxc/lhr58XeuaDYxnM8AWeAzzFTNpXgKJhPSssqYKULVNXpFAV0qdOGj1ib5JBcw2PXz7aPjyKYHlQKxq0ljxpvd5Zh1IehqLy6awTBdLT4VSOY+ZwA4+kbTp7GmKhIPiFc3ageyqUsbb/jgUY/i+ZIx1YIASkK62jvwhLcmfsrP039xWfXrrt61E9I7AGbGQlE0bgvUgRx4+U0E3mTENzBap0zHgF1hko3cHd0TvbsQjJCGIpzovUU1PXdSyb0eoNq8MkdJyyekTuUy1CgAUZmK1z0wzF/PSPB8Nzmr09ilk3DZj0FbkK4zknAopzheemNApsNjROzNkMVa+6rM56KkO3GyOnFQ2MOqK96qSu0028XzdYFB+wqvkoMsG6g9rKcxd5hfDnoti5awnbUaihdjYiwtstf8xVsVMpAE73UIddQOptr7UAT1M/B33sIWvmHbEdDRRRpMZZv7kQM97UKWxJDPruGh1WpQ5nl4TYteBvKQNmgpwrYiqdjvkTbFzPZNlgXKoJi2WN/Bm9E8YTlygGW2ak3VsbXIa70I3qd0nX6e9xb8rgArqF7TdEkSQsshYONvXyWFG01A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(186003)(40460700003)(16526019)(1076003)(508600001)(36756003)(316002)(26005)(82310400005)(54906003)(5660300002)(426003)(81166007)(70586007)(8676002)(70206006)(36860700001)(47076005)(336012)(110136005)(7696005)(2616005)(8936002)(86362001)(356005)(44832011)(2906002)(6666004)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 20:11:52.4691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea39f804-d2a0-4d00-5f66-08da44d42257
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6452
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
2.34.1

