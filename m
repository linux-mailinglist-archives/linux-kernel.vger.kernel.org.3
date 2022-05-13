Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8BC7526232
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 14:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380412AbiEMMmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 08:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbiEMMlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 08:41:46 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00121.outbound.protection.outlook.com [40.107.0.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A6E369D2;
        Fri, 13 May 2022 05:41:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OB5XYuByddw9iKVZnkoDnEg4Lmptugh2Jmt7i4gapr0//igFMKWZmN+HWYcOr+18E5Qukl6tmyX43Tgg/tgVjkrzpzLRgqsNFMRg/l/1hvJvHI0MrJgp2uyWEajoSpLcHdLAjWHDLYCuWVyhUOsjwB6LKrTFARAJJ14durX7wBS5jP8+giyRFJkFytl5b3uUuYyA1QhoB+sVrSHb+IsLizCn4nGTCe6aCqNS/i0k3DGKSxZyi/NOLu4gIYTp4g4hnx07jQcOxWxC/bwRONANerblPJPo4dMEDxPHR71sL59UXVgWvMUoaQCCYSHbOJqBgglDPebo4m1u7coj4jkHbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLDuV2KrgenZkIPe4JZZX6YDLV+Fb0+07JQWbhDnbSY=;
 b=TsPETARwc2AiI5/T8fV11Qa3dy23jeFl8Z19lIN6850PvILXavwLtzPZu8D/UPkAknNhusTMTo9bGg9BvR7JwuIixizxtQ0onqnpCJya+xBLJ3NiMHWD+wFvBaqiLBmVUdEreLmPk4a0JuQOxdKsB9rNgwEZ26EjO3XXk8dn+BnN3eOzzraA0ihQe5tGBEnnauwWyOYL6uV+9FKCP3mATCvIP7PCt0grsBRibSmE8MhOEh7rLI4Yx5bR16EtpO/UZJEQfNVpcMI4Ck6cn7F/54/jlqg8U66dYhm4UMfE47OOrQaiFhOdjGZh0WWd/zoQvadDHW35+v/SReSZ0cM5iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLDuV2KrgenZkIPe4JZZX6YDLV+Fb0+07JQWbhDnbSY=;
 b=rBln3vtfn5JWPVFhZ5WtIXuDAK+ai6YMLH0GAygEtItpj1oSTeprvzXDToCMfGjlG5sOOPvaWQekQXB69lvSpDuK69/zIe7bFv77Ag7XZZ8pz4gqIbDOfvjSM6FxNcrVCu1nff5G7hmNZ9QdAqB6IKj+i6xhLS8WWTSEetspfS8=
Received: from AM6P194CA0078.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:8f::19)
 by DB7PR06MB4773.eurprd06.prod.outlook.com (2603:10a6:10:59::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Fri, 13 May
 2022 12:41:40 +0000
Received: from VE1EUR02FT036.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:209:8f:cafe::a3) by AM6P194CA0078.outlook.office365.com
 (2603:10a6:209:8f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Fri, 13 May 2022 12:41:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 VE1EUR02FT036.mail.protection.outlook.com (10.152.13.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13 via Frontend Transport; Fri, 13 May 2022 12:41:39 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        tomas.melin@vaisala.com, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qing-wu.Li@leica-geosystems.com.cn
Cc:     linux-iio@vger.kernel.org
Subject: [PATCH V6 2/5] iio: accel: sca3300: add define for temp channel for reuse.
Date:   Fri, 13 May 2022 12:41:32 +0000
Message-Id: <20220513124135.1295822-3-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220513124135.1295822-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220513124135.1295822-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 202ca082-0661-428f-d383-08da34dded26
X-MS-TrafficTypeDiagnostic: DB7PR06MB4773:EE_
X-Microsoft-Antispam-PRVS: <DB7PR06MB47739BCEA14407C56B3E5285D7CA9@DB7PR06MB4773.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4FntvAQv455pU/FfziuDgN0RrDRnBBTysxZVoV6AHRWfHij3yn/A0hGDzd0bn1bt0+VN+iGRJ9FBssu7bA+42qnVfDvFigz3Il12oxeN0r0sy1O6MTFoPvcoezTSqwCJLq1CjCktUsXZpX01qSjgDKs/p/Zv6gRmekDzSncOXZMMq7Lp9sGYkFPOpqv+wjfKJb2kICvacAvMlGEJ5bK9SeGS/uKNFVyRXlIV+II7NgWxFJTTs4HRikGPR8v/XNUMWyZq7tqRfa8Oi+fXZC9ST+b4/uCKaNVUaU4xyPZRvnND9NDGwPVjeneGdZ+jKX8x8aXTFxv+2LJ4QH9QprqeP0p5kShwpgNA+b0NBFF0guLmGksah0w6JtoMP0STTuszHxeprcEB4iAzv+P7FwCozzdeX0MKFmzjUkCYmJqfOZExCqHMeb1YAz1iksD2+y4XSNUZ4LCxqCr1wo0kYpHN/7K1AB27boi7GrtDS3/E2R/hTD62rFP+/GLcUmNqiID0SBLPiNUWi1gddVmYIOiMA7u+WASEL1/C6zolpxVW2Z2WycQXpMoL5HU0L0jEn7nhqGRRsW5G6XcXXkiEh2I/KTQ50yakLP+m9j7R+Za3ynF5sq4K8k0YE7ypLPGQH/fXiUbjW8ECDrBvb3/Qz2vmjneu6RodyBwweKY/wQsVXMyPuCC1ydlMpvok6rIKXD89
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(5660300002)(70586007)(1076003)(36756003)(8936002)(118246002)(2906002)(70206006)(47076005)(508600001)(336012)(86362001)(36736006)(316002)(956004)(2616005)(40460700003)(6486002)(83380400001)(6512007)(356005)(82310400005)(81166007)(6666004)(36860700001)(186003)(8676002)(4326008)(6506007)(26005);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 12:41:39.5320
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 202ca082-0661-428f-d383-08da34dded26
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT036.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR06MB4773
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

