Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F165309BE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 09:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiEWHCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiEWHBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:01:54 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on072f.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0e::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B1960ABD;
        Mon, 23 May 2022 00:00:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LeERqvch0szNVHh+A3v8pZW/i6Gy4oH0O84ENTduj7aYPceB6suo4tljtHLANlK00V9YwI09QlHOIL0z7ObiI3zesAXd8vR4WpwysSrVRyUvVn2qzZw+rEVVvSbZ+MSfPTYvtWwBBGswgu6EQbJKUi+3B7DmyKGfph6yULWRTgS8F+SKj7sUCqDln3GATFWK6X83J/XZs3aGOWBsj7s00nP1PD3oNtnC7tnVqGOoQ4oYUBys37wCz/U5sTQKt5QY9OLc0EdVMUG03FHySKt8l/wlaRxYfdu4CCRSy3j2wnJ1ksfp5eV+5W77SXA6jylNdqy7WctzSfIgXnEDsgSAlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLDuV2KrgenZkIPe4JZZX6YDLV+Fb0+07JQWbhDnbSY=;
 b=V13nWHHt2mv3J6Dn2MtxzU1UbxfdPD0j40+hfJxY6OCqJnol2jhz/CgNv1ALnejK2y5SXwL9UuNZ0+sfbJhOCx3qLB0WfGIzHJDh86RBg6C7ueWo0Ih2y/JodIHkMEvcLhHLtPuYuhnsken0ZHdyoxZood4KtVocRzdBD+6LbuQiSDPLjhiBieU0nljdEQGJuNK+JknXUTeAHanpbcQF7gn+ws6OYGYJO0/mb30169iHbmESfP9hiacLoxZ8x5kRlH1eMS/a3mWwQPghP05UdEeXJCbrUlwsgaIf3XSDHBMZgOJOYT0/sFwVGQv2KsEHGbSwqqM1Udk3/kuFWErEjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLDuV2KrgenZkIPe4JZZX6YDLV+Fb0+07JQWbhDnbSY=;
 b=geP7/kfZVhkFQwBcoE22qtKUKkb/kGjuCmWTaRGwEvXB8rwh2ZceH/ZF+abqKzNE1SgB4X21Jml++0ySS13NTr8/gXTZFcEydfkBxMA35suA1m3nEzBqnWUeUZT9v8Nv6JoemhyRSEgdEBHrLXW/N7sFkz7ZBhuzniB4TeJgZHs=
Received: from OL1P279CA0055.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:15::6) by
 AM6PR06MB5475.eurprd06.prod.outlook.com (2603:10a6:20b:57::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.22; Mon, 23 May 2022 06:23:18 +0000
Received: from HE1EUR02FT087.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:e10:15:cafe::3b) by OL1P279CA0055.outlook.office365.com
 (2603:10a6:e10:15::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14 via Frontend
 Transport; Mon, 23 May 2022 06:23:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com; pr=C
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 HE1EUR02FT087.mail.protection.outlook.com (10.152.11.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14 via Frontend Transport; Mon, 23 May 2022 06:23:17 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        tomas.melin@vaisala.com, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qing-wu.Li@leica-geosystems.com.cn
Cc:     thomas.haemmerle@leica-geosystems.com, linux-iio@vger.kernel.org
Subject: [PATCH V8 2/5] iio: accel: sca3300: add define for temp channel for reuse.
Date:   Mon, 23 May 2022 06:23:09 +0000
Message-Id: <20220523062312.1401944-3-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220523062312.1401944-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220523062312.1401944-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: bbc99829-e857-4858-ea70-08da3c84b9eb
X-MS-TrafficTypeDiagnostic: AM6PR06MB5475:EE_
X-Microsoft-Antispam-PRVS: <AM6PR06MB54750FE2A492531731B329FBD7D49@AM6PR06MB5475.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6heVSCn+/racin1QXqbpZAhKXznCLPB7sSw6nyl1Xa4DZ4KNcRYDRFi4wbXdeYrVYCe+uJAsbnDdAsJD0Txn6xBvXtGEGoRQJ/ShhSLJoTpKIwlChxEqKN5chFh2aJl5PelWYLibdRGgD1UkQuBNtPZG6afCdP7jYbHfC0fHwy6tCXwFVJcGDC48s01H3BB8eVEJZrlMa6n1DpPhSb80LlYjzHbsvYPF2FQbI5wengEKHNifo2wYxw19jd9JHAEWxUlEPxGUl/R/endeM+QnBZf0Q0MiFxkrooUXL9Hkb3tTG8X5o+oyz/pR+Bdn6/qVcFIuy5bbPxG1pA5PtUYSqaM9dH2zit+icJWAI1ofEZ1/2Ks5i+G+rMItIaAaCQOh5GawN6RbqdOLFjtKXiMLUzhju4oATOZ56JXf6oVaMRU6D9WbBJ+oG9zHNDKLCiStH7nWhnpUcn7c7Dq7w5jo4bmeoE1ZZ0/TZjEBqb8+/47AsDhZgkmyBM3TD6qsOLldvfdLnrEkeAW94BqkxvhTrkEAJJrZTBICUTyC+k5MqNKM87Dh7qIm4m2acZzUtZqRCv1RPGVz1ZAwV4sz/rDew9HZ5ejIm6T3ILK8ZXS5gDTA2a26lM1957aRZZgqRiwmLOP6qj02YHI+qYNs1QmprZlCn7+ZWf1oT1+y0P0ikjZpJb0NeSW/ee2c4EhT0zaO
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(956004)(1076003)(2616005)(336012)(6666004)(36736006)(186003)(6506007)(36756003)(6512007)(2906002)(316002)(47076005)(82310400005)(508600001)(86362001)(83380400001)(26005)(118246002)(6486002)(36860700001)(5660300002)(356005)(40460700003)(81166007)(8936002)(8676002)(4326008)(70206006)(70586007);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 06:23:17.4275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc99829-e857-4858-ea70-08da3c84b9eb
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT087.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR06MB5475
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

