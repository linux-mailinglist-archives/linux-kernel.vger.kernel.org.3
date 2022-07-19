Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052F057A3FD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 18:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237476AbiGSQNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 12:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbiGSQNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 12:13:40 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB704C610;
        Tue, 19 Jul 2022 09:13:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=brCS8OPby6GWIHonkGWN6YbGD4J/wQe/mI0NHcuzeciTGzirFQ7O2/xqWgc02ow8iOOrcHOvB1Q+0pKL7A8p5yCtZPw3RnuH0NGEqEkhNZeCVeK9nOgEU3YL5wF7pdy3QXgwDnZOrtt+imPN8CHQgChuVM6mqnGx0g10B1vzSWha73zaENGZKgvh/S61+jjrWIIJApR8QvCnAMG7yt3Bbdvv5q5kLfyxGtYxDTtcOxlx7bQlpMQcUKK3vxX2P0StOQ2TIS4EdV+61DSfPoNFag6ATrrzbzyOBXctTkEyz8A21FIM8zphxDsgKCMJew4pucw78CDbcWDr+/ZroU5ZzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddtGx0KMFJdQFk6Y95cMIs/e1GlpeKvQRgip1ocXj3M=;
 b=ju9yoC9ZkdrObU+1ur9SVleuFbj9RP+1oJK7fcFPClU547XF/MGX4vraD7AuXT1dbv1fqluggyDg//szIVo0yPsnXs4fNPst0psks4bCtxQ/ySR7zhD4u8y1Y9KC3+1m7KO/Mc/0WOZpRmqjzzRTfDkz7r5ZNbjMv8x73xPQ110z+60A9EVMmGC9V045TKjYtUaNRtIRPBdNdZLVnsYTWXu7nAVwT1ugVgeCEoJlTYivWC5s3h4NHYAv5f1X7b2Np621tJOc6FY065TRPBzHS0mmxDTKgiBN3rk7tHdHL40XId9wr7dlrTuvqQ9zbGOp0UlsKcJjnkSfXZc5hAMgdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddtGx0KMFJdQFk6Y95cMIs/e1GlpeKvQRgip1ocXj3M=;
 b=uCQ4/EQH4O9yzmImRmltrA10CWVYSSrezTC8DOR9UhnPBMtttoEOfQMgAcLgIETbYsvJyaIJMhxkT3pBa1RtMUiXnK6AuZNE9Q2YbVxcmmQlLt7KLGV2TUTCZBLyqNz68Oo9YB6+MY2EIqfuK7w6up+DTGNb5v6TuumbpgVEpJw=
Received: from DM6PR05CA0056.namprd05.prod.outlook.com (2603:10b6:5:335::25)
 by MW3PR12MB4555.namprd12.prod.outlook.com (2603:10b6:303:59::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Tue, 19 Jul
 2022 16:13:36 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::71) by DM6PR05CA0056.outlook.office365.com
 (2603:10b6:5:335::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.11 via Frontend
 Transport; Tue, 19 Jul 2022 16:13:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Tue, 19 Jul 2022 16:13:35 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 19 Jul
 2022 11:13:34 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "John Allen" <john.allen@amd.com>
CC:     Rijo-john Thomas <Rijo-john.Thomas@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] crypto: ccp - Add support for new CCP/PSP device ID
Date:   Tue, 19 Jul 2022 11:13:28 -0500
Message-ID: <20220719161328.7907-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aef96a68-2a7c-4b4a-6979-08da69a1a1cf
X-MS-TrafficTypeDiagnostic: MW3PR12MB4555:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3/8YWn+1y5JdYJGGAR8jSH7nx8PI5cZ5CfYJXClv0YAYJtjHYoVLFI1vQB9/TimSBaYDVisHpVKXYlfc0JpIbALcFRKqzuEtq8GPG5Kj66k9Azprxj60ECBIB9Rhi67slG2SZ6OIapDa8FV3CCEhjMYuk4DuBoF5Fx/a8OFLlzaQHW5L03XzN7vMoJuNDiiasH4NMVaneUnIiPsQhSLEUUvFaRFJDnCLcW6jcgGPP0uNslzX43s9rbdFcaC9IUO3QlQmiRmU1WuVzRcnv4syNqgY6O1wrlas/2YOooZA38o1IUmMpc3kuAg+UJoBR2K2l4fzHKptQdmKAVHaNZfgyK2Mve6OVJufrxerKH2L90oDaZD06xilBtyyKtxVOGzA46gqp5Ecl0gxEoR/ZQeX4DLgTJceVDlPaCuzMzzGdjPX2aFWBUHCgF/meLDuICPQG6MEH6Nj2XhcnAoK8zxvrbcuU4OXtpaKcbp5EHYQb7R8oY1H6zeMBU142y+EUE+AGC85aGZbZpd9CzvQwPeT1V6gRihtCGJiIU3/UJwVTifEfiHDHwEil6ZTH1em5IZN638f6K3l9zyGgzCxbpDMF9guf4jx0vGo1qtj7xpu7+fBWeY5F4aVnaPOYK6KMvqpn3HwH4EdE4Ug1pxXhGI1uPZRSY8xwNseqmRk9RTNA31RsIYUZskLpCsP/IxwUv7QJzVpk6MAYr0i8mZ708JAAvHCaz5D7znjr+QAB1g2ziBiXNdq/4DrTnG8vx/agq+TJLMawEdkleJqdAfkttV9pwMRhocaW44fUTHsPumkUnutJHsrixpNUh/g7Gdxff3ggevHVW1WUPWbzGkHbZHhMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(396003)(136003)(376002)(46966006)(36840700001)(40470700004)(54906003)(186003)(16526019)(82310400005)(6666004)(86362001)(36756003)(316002)(6636002)(1076003)(110136005)(426003)(47076005)(2616005)(336012)(40460700003)(4326008)(70206006)(478600001)(82740400003)(70586007)(8676002)(26005)(41300700001)(7696005)(81166007)(2906002)(40480700001)(356005)(44832011)(8936002)(5660300002)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 16:13:35.0784
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aef96a68-2a7c-4b4a-6979-08da69a1a1cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4555
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new CCP/PSP PCI device ID.  This uses same register offsets
as the previously supported structure.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/crypto/ccp/sp-pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/crypto/ccp/sp-pci.c b/drivers/crypto/ccp/sp-pci.c
index b5970ae54d0e..792d6da7f0c0 100644
--- a/drivers/crypto/ccp/sp-pci.c
+++ b/drivers/crypto/ccp/sp-pci.c
@@ -427,6 +427,12 @@ static const struct sp_dev_vdata dev_vdata[] = {
 		.bar = 2,
 #ifdef CONFIG_CRYPTO_DEV_SP_PSP
 		.psp_vdata = &pspv2,
+#endif
+	},
+	{	/* 6 */
+		.bar = 2,
+#ifdef CONFIG_CRYPTO_DEV_SP_PSP
+		.psp_vdata = &pspv3,
 #endif
 	},
 };
@@ -438,6 +444,7 @@ static const struct pci_device_id sp_pci_table[] = {
 	{ PCI_VDEVICE(AMD, 0x15DF), (kernel_ulong_t)&dev_vdata[4] },
 	{ PCI_VDEVICE(AMD, 0x1649), (kernel_ulong_t)&dev_vdata[4] },
 	{ PCI_VDEVICE(AMD, 0x14CA), (kernel_ulong_t)&dev_vdata[5] },
+	{ PCI_VDEVICE(AMD, 0x15C7), (kernel_ulong_t)&dev_vdata[6] },
 	/* Last entry must be zero */
 	{ 0, }
 };
-- 
2.34.1

