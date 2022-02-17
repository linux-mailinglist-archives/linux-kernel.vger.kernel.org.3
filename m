Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053C24B9941
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 07:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235630AbiBQG1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 01:27:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbiBQG1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 01:27:30 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2091.outbound.protection.outlook.com [40.107.22.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7B31FFCA7;
        Wed, 16 Feb 2022 22:27:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChmCUhF5sjvqlirtQwRtyq4EhDX5dzDUQeW8wJiVhd0WrzxKJERVuTOm1PqyorB6DsRylZL0ZITGeayFmMJ9Wa1vbwnju73ek+AL42t7x59xS9tw6qXfhJ8AtZ6LHHW+EZ56IK2g800PI9mZrNS3FbpaFCNSRREucO/+6VSa1YceQocC/XMmFCtyYl2Ui/J8iM7jFnaL3AAslco9jsgPETLhxkLndnNsouguhQrIeRVkrRrBbd5OXeBLwe9gwUFJfQbch9kBdVTfzU9o0ElhEshr80RLxdfWaMOf6loNaSkj0dtav/serRLYeolNhsfTk9WnkCKlkkRjV/40ZKP+3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLDuV2KrgenZkIPe4JZZX6YDLV+Fb0+07JQWbhDnbSY=;
 b=N1oggykPGhqRoNc4RVwLsZY5cWFz+UH8MWgsuKKPz93Jlm1FiD1XT6VtP3jaUGfi3x91A6AomJBNLXGFofCy5vxhOVN99LCkj/YzFnRsqJZKUUY8QTafMk1TY+8o/PGfWwxpg+Ksqii21x6H3Ic+gwtRJ7ROiTOBwYNPjGeAsYHNcb35pK5RvV/5TvxWc7C12EtdwlInSo2jp+J3z8qVYCqdXOy78K5LXzJOtkWrxS7ec8mLCXzm0CAt9lwts1C0NDZJqMXYZ1v/nBvtI8OpKfnAR8SppuHD8rQJJNihjW09v+EKHMC2z2WUvBhkVE0JeU8pWsGbMqMRG8f3FJpMpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLDuV2KrgenZkIPe4JZZX6YDLV+Fb0+07JQWbhDnbSY=;
 b=cU7RRm75TbsigVDyoISfMBaQCGYtlwo7+8iurMwxkYwbgWoCd2Q36onbXYtpEUDj6FCFxfQSa48oW/6lLhhv9DXXim1TCA1wXo9jcjaaKWwtPN+1ETXUU73nu3fFRYjABe8/dZKB5F6TsMmlpJbA3Xn/chXl0nl8LHudKw8b6RI=
Received: from AM6P192CA0078.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:8d::19)
 by AM7PR06MB6487.eurprd06.prod.outlook.com (2603:10a6:20b:111::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Thu, 17 Feb
 2022 06:27:10 +0000
Received: from AM5EUR02FT043.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:209:8d:cafe::5d) by AM6P192CA0078.outlook.office365.com
 (2603:10a6:209:8d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Thu, 17 Feb 2022 06:27:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 AM5EUR02FT043.mail.protection.outlook.com (10.152.9.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.11 via Frontend Transport; Thu, 17 Feb 2022 06:27:09 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        tomas.melin@vaisala.com, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qing-wu.Li@leica-geosystems.com.cn
Cc:     linux-iio@vger.kernel.org, bsp-development.geo@leica-geosystems.com
Subject: [PATCH V2 2/5] iio: accel: sca3300: add define for temp channel for reuse.
Date:   Thu, 17 Feb 2022 06:27:02 +0000
Message-Id: <20220217062705.2867149-3-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220217062705.2867149-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220217062705.2867149-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c11ffb48-f080-4be0-91d4-08d9f1de8720
X-MS-TrafficTypeDiagnostic: AM7PR06MB6487:EE_
X-Microsoft-Antispam-PRVS: <AM7PR06MB64878190441F00AE959C9F63D7369@AM7PR06MB6487.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 21dKtA1wlLitvsb+Bbp6/RpteOUBINTtwH0nvp3JMarNgxE3QfPtdD65V2SoAm3HqR5nk8VQLPrftfMiiHFwcjnE8NOpRoadpjs/M2ATFUxPrPU152pnBcAGzNqlwK+sbcg5e9QqEGJ7Jzr0HRYAOs3qnRWnW5bRBDi1MSkoN5phnGAbzsYj5dX12aHSL6168KExxZamn/E12qw2QMD17rNrQtdG5Ff6fsrQx/E8HgA+NNY+0d/gyb5C8tIPtHR/w4byfLVUhW+sQh2oXOS7VBQ0pq3A6+sI/63aLDhSmwuB3NYe+p4W1uHThVEjqn87BZJOKahPMriW7bvGXi9Bcda7QRl3JpS0rnywFeqqiv27ch8Ga7163vUJysPCNqR2u7oOYvgc+qkcaRt8d7fn9SX9RaApq4tiSEdLYTxiMmS1HQ1ekkRi4wDIZI8KvJQL2FgY0qsTYmzzAd5hKFadxgcgglZX5kZHmqwzdI3RrsiE2KijtVb6UcuZK3au9XMcpDxdh+tJh9Gn4jZs5UH4Z+BtbNKs1eAPWgGeaukHUCyTFzf712kIoHPE/yrmh+JOBo7oI4CpWrae50HDxMxPlbJI0JDoOn7yWG5bOhtS6dQI/GBIVMvUHPy+KpGAcf7GT7m7yL8FoYa9OWbk893kj/yKiQXAjJzFQydpSAxPzWAGiT+fBKlEXBrgFl+Qt9BW
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(4326008)(70586007)(107886003)(6506007)(36736006)(6666004)(186003)(86362001)(2906002)(6486002)(508600001)(5660300002)(8936002)(2616005)(956004)(36756003)(26005)(8676002)(316002)(336012)(70206006)(1076003)(82310400004)(40460700003)(356005)(47076005)(83380400001)(6512007)(36860700001)(118246002)(81166007);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 06:27:09.9187
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c11ffb48-f080-4be0-91d4-08d9f1de8720
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT043.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR06MB6487
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add define of SCA3300_TEMP_CHANNEL for reuse.

Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/iio/accel/sca3300.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
index f7ef8ecfd34a..ff16d2cc8c70 100644
--- a/drivers/iio/accel/sca3300.c
+++ b/drivers/iio/accel/sca3300.c
@@ -72,22 +72,24 @@ enum sca3300_scan_indexes {
 	},								\
 }
 
+#define SCA3300_TEMP_CHANNEL(index, reg) {				\
+		.type = IIO_TEMP,					\
+		.address = reg,						\
+		.scan_index = index,					\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+		.scan_type = {						\
+			.sign = 's',					\
+			.realbits = 16,					\
+			.storagebits = 16,				\
+			.endianness = IIO_CPU,				\
+		},							\
+}
+
 static const struct iio_chan_spec sca3300_channels[] = {
 	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_X, 0x1, X),
 	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Y, 0x2, Y),
 	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Z, 0x3, Z),
-	{
-		.type = IIO_TEMP,
-		.address = 0x5,
-		.scan_index = SCA3300_TEMP,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-		.scan_type = {
-			.sign = 's',
-			.realbits = 16,
-			.storagebits = 16,
-			.endianness = IIO_CPU,
-		},
-	},
+	SCA3300_TEMP_CHANNEL(SCA3300_TEMP, 0x05),
 	IIO_CHAN_SOFT_TIMESTAMP(4),
 };
 
-- 
2.25.1

