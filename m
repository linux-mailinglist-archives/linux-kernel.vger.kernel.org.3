Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20C9497C35
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 10:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236669AbiAXJjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 04:39:32 -0500
Received: from mail-eopbgr60122.outbound.protection.outlook.com ([40.107.6.122]:8710
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234398AbiAXJj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 04:39:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhZLCUlKiH39K3qMllLaSO/NtCYLbuEBmk+xqDHW4dtotbnhNJYY8kNDsFq0ZNwyPke/oUfGpMPOKoocLz2JBmkN7eKxU3jdT6ze+ij3fc73peoPlETn/7ZKUbroHEilj++ho0lyme9tn2IDnejUzX1IsurJBg8HM6rDElQL5TF07/O61p1Yf0y0NXEeUqqDBbvCoOSTmGbhryNCRdom0tW9JiDVJniHVdQMuEaw1SJ9TXPPHYoduN5FsQntjtlPu7QBX0NUpN35hH7VgzYpbpR0uDFT8h0j9XcrdYxNjm1E24Zd1TbhiOYhRuvOajGo+7v8JK5dZ5AscNKPW5ndCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JnbBP7fY3I0PFmMf3k1v/vD8mE+phezANdW6sUfc1tc=;
 b=fnAleay/v5i1vlbhbP8uRnYNYlk0HNaz6tWZjPAdj9i3x9dVH4QXFn3+8Zg1o/ljjo32aiJ2p5+V2CBGkGrSjw6RFpdv59ljyBdfsgvsLXlJEczkZ90Zfdi6XI4Ym0a3E+q8SQfx2rCA6XnF8+AC8/HBcp5kTPhW87v6JhKSRNgw8VnqgnQ4VJFwJpPaHP4r/aEAC4rlm+g/0xZCHXIP6jy/VWRCrBmPreic4l3EWeYaWxDzccFNPsQxN6lKtxoo1SxHU6zE9X/gucxXZFpwhmK34ZFzClgiXRRD0IMuvmlnK1YtwC+VlkO5oee7M/2cBFK3+IKGAJUQ8Ur9pVPEDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.8.40.112) smtp.rcpttodomain=leica-geosystems.com.cn
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=leica-geosystems.com.cn; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnbBP7fY3I0PFmMf3k1v/vD8mE+phezANdW6sUfc1tc=;
 b=OvEXTUNxAsBWyxAVG2Qf4JpvX1PgQWJSYqw6D7PfP2/K4ewxpC9QdPGnrhh+tY2GvonGl6DZvpZhxCrvRixr12kYAz8qi3R7jC2UzIzC/hqbEXWhsPrXpVMKpgc3dsYj08dqkB07MXK0WVY6I8QLOP+VwtFlAcnSavteQjv4csk=
Received: from AS9PR06CA0053.eurprd06.prod.outlook.com (2603:10a6:20b:463::15)
 by HE1PR0602MB3659.eurprd06.prod.outlook.com (2603:10a6:7:8b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Mon, 24 Jan
 2022 09:39:19 +0000
Received: from VE1EUR02FT049.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:463:cafe::19) by AS9PR06CA0053.outlook.office365.com
 (2603:10a6:20b:463::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Mon, 24 Jan 2022 09:39:19 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 193.8.40.112)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine
 header.from=leica-geosystems.com.cn;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 leica-geosystems.com.cn discourages use of 193.8.40.112 as permitted sender)
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.112) by
 VE1EUR02FT049.mail.protection.outlook.com (10.152.12.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.7 via Frontend Transport; Mon, 24 Jan 2022 09:39:19 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     qing-wu.li@leica-geosystems.com.cn, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, tomas.melin@vaisala.com,
        andy.shevchenko@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Subject: [PATCH V1 2/6] iio: accel: sca3300: Add interface for operation modes.
Date:   Mon, 24 Jan 2022 09:39:08 +0000
Message-Id: <20220124093912.2429190-3-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124093912.2429190-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220124093912.2429190-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 458ea030-a566-47b3-1811-08d9df1d6537
X-MS-TrafficTypeDiagnostic: HE1PR0602MB3659:EE_
X-Microsoft-Antispam-PRVS: <HE1PR0602MB3659ED836A2F0070739D7ED1D75E9@HE1PR0602MB3659.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:644;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b5ReDvpJl+j9/ORifgbAhGZe1/t+rhcIx3i6bJ7I7S/fgjPfTs7FORs5PfQgSEbxeTn9bNOE2PD4rjIrNfAupvDzBdf24SigTYqIB/UJiv1lVZIhRTKo4T/j+NZLA0LSiMILaxbm+rO02833QmXjtcdGgaPpVdDV3kbSOUIr4kyZ48AjTR1lEaYLriMekjwO/pnm5UIOiXxRhWlcVq11kJGNsAPjjDTP4MdzWPIM2jWePhalx2Z2ApYxUJF9GVS/p5LGhGiedkQqeSqC0rw7PKbbdUDPOzb3JhMJ/F4+W6Ey1gt/K4QqqL0wz2cdJmbPBnH+chmWc/CtKmPtea/7GDy+CuvtlPVemdTTfd+uFTX0CM5w6PJsMpKDqvIk6esm9DrnT8viMzdOfDE8daIYjYMktc66nAHw2UpBrme8iVyqUrAzoQ7kCk3fYVHsxY3NiV8E6K0yOOMBxIoon5aRx8+gotVTW5oujT4/a2whYaWIbOFLpxd8YtyBIRWHqhjo9IBOaBfHtEXFKMHUKd4KpKfy5UoAn0SARadiwWeGgJkYbSO8uUqaeu5IwApWwf4R9Gf6hIiqqIVBXv9ZiZsYqLdbylGeYAxqZDcTH3GiKeEmImsM3QM9xrlXky9KEjoFBsRRmFAOD6n4KL4lI98x5e1E65Eeovzdtv4ZkcJFeIsNrAq3sVsVhmciz1EBHocEcPsZDi/afLC+69GimJauEmdXsgJtcK1DV338KT0lTdOVPjvcYt8C4GnJN4cng283mbub+sbUb3rtEhMOBk1xlg==
X-Forefront-Antispam-Report: CIP:193.8.40.112;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:mailhost.polymeca.com;CAT:NONE;SFS:(4636009)(40470700004)(46966006)(36840700001)(356005)(40460700003)(956004)(81166007)(8676002)(70586007)(36860700001)(316002)(5660300002)(2616005)(1076003)(118246002)(70206006)(26005)(36756003)(2906002)(6512007)(4326008)(6666004)(336012)(107886003)(86362001)(186003)(6506007)(82310400004)(508600001)(36736006)(6486002)(8936002)(47076005);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 09:39:19.2759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 458ea030-a566-47b3-1811-08d9df1d6537
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.112];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT049.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0602MB3659
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The acceleration scale and the frequency were set via operation modes,
the scal and frequency are both non-uniqueness,
this leads to logic confusion for setting scale.and.frequency.
it getting worse if add more different sensor types into the driver.

The commit add an interface for set and get the operation modes.
the following interfaces added:
in_accel_op_mode_available
in_op_mode

SCA3300 operation modes table:
| Mode | Full-scale | low pass filter frequency |
| ---- | ---------- | ------------------------- |
| 1    | ± 3 g      | 70 Hz                     |
| 2    | ± 6 g      | 70 Hz                     |
| 3    | ± 1.5 g    | 70 Hz                     |
| 4    | ± 1.5 g    | 10 Hz                     |

Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/iio/accel/sca3300.c | 55 +++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
index 083ae2a47ad9..e26b3175b3c6 100644
--- a/drivers/iio/accel/sca3300.c
+++ b/drivers/iio/accel/sca3300.c
@@ -42,6 +42,38 @@
 /* Device return status and mask */
 #define SCA3300_VALUE_RS_ERROR	0x3
 #define SCA3300_MASK_RS_STATUS	GENMASK(1, 0)
+enum sca3300_op_mode_indexes {
+	OP_MOD_1 = 0,
+	OP_MOD_2,
+	OP_MOD_3,
+	OP_MOD_4,
+	OP_MOD_CNT
+};
+
+static const char * const sca3300_op_modes[] = {
+	[OP_MOD_1] = "1",
+	[OP_MOD_2] = "2",
+	[OP_MOD_3] = "3",
+	[OP_MOD_4] = "4"
+};
+
+static int sca3300_get_op_mode(struct iio_dev *indio_dev,
+		const struct iio_chan_spec *chan);
+static int sca3300_set_op_mode(struct iio_dev *indio_dev,
+		const struct iio_chan_spec *chan, unsigned int mode);
+
+static const struct iio_enum sca3300_op_mode_enum = {
+	.items = sca3300_op_modes,
+	.num_items = ARRAY_SIZE(sca3300_op_modes),
+	.get = sca3300_get_op_mode,
+	.set = sca3300_set_op_mode,
+};
+
+static const struct iio_chan_spec_ext_info sca3300_ext_info[] = {
+	IIO_ENUM("op_mode", IIO_SHARED_BY_DIR, &sca3300_op_mode_enum),
+	IIO_ENUM_AVAILABLE("op_mode", &sca3300_op_mode_enum),
+	{ }
+};
 
 enum sca3300_scan_indexes {
 	SCA3300_ACC_X = 0,
@@ -70,6 +102,7 @@ enum sca3300_scan_indexes {
 		.storagebits = 16,					\
 		.endianness = IIO_CPU,					\
 	},								\
+	.ext_info = sca3300_ext_info,					\
 }
 
 #define SCA3300_TEMP_CHANNEL(index, reg) {				\
@@ -400,6 +433,28 @@ static int sca3300_read_avail(struct iio_dev *indio_dev,
 	}
 }
 
+static int sca3300_get_op_mode(struct iio_dev *indio_dev,
+		const struct iio_chan_spec *chan)
+{
+	int mode;
+	int ret;
+	struct sca3300_data *data = iio_priv(indio_dev);
+
+	ret = sca3300_read_reg(data, SCA3300_REG_MODE, &mode);
+	if (ret)
+		return ret;
+	return mode;
+
+}
+
+static int sca3300_set_op_mode(struct iio_dev *indio_dev,
+		const struct iio_chan_spec *chan, unsigned int mode)
+{
+	struct sca3300_data *data = iio_priv(indio_dev);
+
+	return sca3300_write_reg(data, SCA3300_REG_MODE, mode);
+}
+
 static const struct iio_info sca3300_info = {
 	.read_raw = sca3300_read_raw,
 	.write_raw = sca3300_write_raw,
-- 
2.25.1

