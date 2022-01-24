Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556DC497C26
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 10:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbiAXJjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 04:39:22 -0500
Received: from mail-eopbgr150134.outbound.protection.outlook.com ([40.107.15.134]:64088
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233758AbiAXJjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 04:39:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kevqc7l4XnlacEn96eyggy64Dv1U/v1YotwHH2ReEld0U46o/2736iT4fJJ4r+mPqyprh4LM2CkgZuoRvsqlaNmKe2wcCO+lOMcnfmJbUCv3dihjJ/oz9i9MCFznEVxbMSAKnmx5aGf8d1GPlZZelZCfuEu2VD7TEvt7yIC9OIJq2tg0W2ulc0ia/jvcuidlwy1t1NbBF7BVkMWCqp1iQLOkdLH8Wj84mdDyJay9fLaqfjRi1lSsEAfyy+HvQTtFfcqBheMGQMcoEquIjRfGhknAXqO2Nc4I4ukCdtLpLrEei/3pCxUck52A0PS00sGeeL9VjUisBZ1b2NYGF6aFOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kdx4mxTaJlezx/zW3mXNu/RdOemxcDuWzZn6tc0WfzI=;
 b=MiRyfewKzm+CrG1SUfYFMI7EAma/0z6Kc57I5ONPcu48kuVsjVIL8UAuyoS1BEqMRTVCZpWt9A/AH9+q9pEp9Jcc5xgZw5zcLcJ7qh+5rDUSxJ0uKwUU94rhgPRjKTXOrPQEHdLaLKnQdYrps16CYTlfkHw9piTirZkGpb7+XGwekCQWGB64QKuXvUTa/7ozzKsQTsQ432C8Wa7xmvcZ7NX6CZrjh2aXvpyl9rYj1mm2kGdgyZU8llDZqaICz2M5eUHfy3WAfkrQMVw2D2Jquhv3bZbBBOvydDHCb64CYJd4yymKhfM2OAhO4nA01Zzre/2r9VuljZdapcxPNyEljg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.8.40.112) smtp.rcpttodomain=leica-geosystems.com.cn
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=leica-geosystems.com.cn; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kdx4mxTaJlezx/zW3mXNu/RdOemxcDuWzZn6tc0WfzI=;
 b=LCG1+uI4PUZdo2deSg2cugKUxh9nXIsD+pbA9uxJE7pkW8RmSXYMrFZwFT9zFacuru/iTeE9CaWrRKriuSrKVVksWbK8PEcJVrMMxfj532bG4zTuPwaWFevfebgiubHLYpICXwTa/nnx7TlNZcRH+EORIwy7ahw8+KPiKnLcxrg=
Received: from AS9PR06CA0041.eurprd06.prod.outlook.com (2603:10a6:20b:463::16)
 by AM7PR06MB6504.eurprd06.prod.outlook.com (2603:10a6:20b:119::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Mon, 24 Jan
 2022 09:39:18 +0000
Received: from VE1EUR02FT049.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:463:cafe::40) by AS9PR06CA0041.outlook.office365.com
 (2603:10a6:20b:463::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Mon, 24 Jan 2022 09:39:17 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 193.8.40.112)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine
 header.from=leica-geosystems.com.cn;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 leica-geosystems.com.cn discourages use of 193.8.40.112 as permitted sender)
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.112) by
 VE1EUR02FT049.mail.protection.outlook.com (10.152.12.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.7 via Frontend Transport; Mon, 24 Jan 2022 09:39:17 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     qing-wu.li@leica-geosystems.com.cn, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, tomas.melin@vaisala.com,
        andy.shevchenko@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Subject: [PATCH V1 1/6] iio: accel: sca3300: add define for temp channel for reuse.
Date:   Mon, 24 Jan 2022 09:39:07 +0000
Message-Id: <20220124093912.2429190-2-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124093912.2429190-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220124093912.2429190-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6289f96a-bbc0-4db5-2785-08d9df1d643f
X-MS-TrafficTypeDiagnostic: AM7PR06MB6504:EE_
X-Microsoft-Antispam-PRVS: <AM7PR06MB6504423A1E3A41ECE03F7C4FD75E9@AM7PR06MB6504.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dfcNaSF3w8ZpRf/YBLnPrfkc7nHqa5YknoGONO60MFXyxk4ZZ4KW8pFJZw0cnZt91knxAE94XS68HDWk5h5txK0rXwoEw9c5tZ8ri7QD3p/FO0vh302dbPLo1vSsPLW0WyVsNAKQJ5drfQpxo1prRmWu7c4pqiSFCrPmyEoXdoSYV/T86uhpzcqtumEfqnOfjVCRZdR16NKSldgTtEFo03fk/ckR4J01LiJWWniU3zL9UXPujWZArjodwlhWszdm4+L2B2Yi7f8+iSJkFtHhmkEK85AaFX+f+G5H3Sin0o/diEoabVHss3sCg0TE1t9+NhcWJoiP41MOCQIlXbMeBcJTwIYo7qZ78q2zs7hyJiKQEe3pAwsRq2rN46dxl8BxKw5Khrok2rvf4CLz2WCy9CVVUy//XvIyXqIe1IjwS7bAjPcL9AuM+WwGrOpVa+BizjiKvGvaMbpcnuOncQy+q2QO86RyHh3c9dA6qydX9Io8Mmm4whbLH2eVk710LXM/0Xws1nzOrY+QXs1xFj1ejIWqH2u8VmnVWrvpL2fI1TRE1Sl4Hzjlc5CdSN7VZB01e1NNB4H9B3BnJAkueWo4rEY4kNV0Uu0crXwZHCPZhdhtfJJ5y2Gw05+CHpZEFo+U31I2u/38hIMytnHCV5QavurdCbuKEwD12bZ7sPjuIRu0nHsSftg+W5D+2bEeYz8ZgyOsphmxsKNhxt/VBl2keBmtGlkEzaB1evIViyUbqBoI73B7tsRFefcH1wpofqUwrBOQDITUCGmRklNmTzmQoA==
X-Forefront-Antispam-Report: CIP:193.8.40.112;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:mailhost.polymeca.com;CAT:NONE;SFS:(4636009)(46966006)(40470700004)(36840700001)(86362001)(6666004)(70586007)(70206006)(1076003)(40460700003)(47076005)(81166007)(8936002)(36756003)(83380400001)(356005)(118246002)(26005)(6512007)(2906002)(107886003)(6486002)(6506007)(8676002)(956004)(2616005)(186003)(508600001)(5660300002)(36736006)(316002)(82310400004)(4326008)(36860700001)(336012);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 09:39:17.6510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6289f96a-bbc0-4db5-2785-08d9df1d643f
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.112];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT049.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR06MB6504
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add define of SCA3300_TEMP_CHANNEL for reuse.

Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/iio/accel/sca3300.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
index f7ef8ecfd34a..083ae2a47ad9 100644
--- a/drivers/iio/accel/sca3300.c
+++ b/drivers/iio/accel/sca3300.c
@@ -72,23 +72,25 @@ enum sca3300_scan_indexes {
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
-	IIO_CHAN_SOFT_TIMESTAMP(4),
+	SCA3300_TEMP_CHANNEL(SCA3300_TEMP, 0x05),
+	IIO_CHAN_SOFT_TIMESTAMP(4)
 };
 
 static const int sca3300_lp_freq[] = {70, 70, 70, 10};
-- 
2.25.1

