Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3968F562919
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 04:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbiGACa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 22:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbiGACam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 22:30:42 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2131.outbound.protection.outlook.com [40.107.20.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84F161D74;
        Thu, 30 Jun 2022 19:30:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2DSwbh+3VVoAH5MVmMPTdSHcNtTzMdSfvcY8i1Cs2aaVfuObPHXGTx5VdizB7TkrnuXBZd0QPOhoWl/uENavRE9/gsQf7cVPAWtX4izX/EVUKCtsaiA+0ONcHhlBf3oDs0ge/R3yA/fU1AtLSd9p+MR5ad/+oEr5zDE1kQJl1CNsjQjZrXGph2ANcPgXjtrnH1lrID226cc+ie+kl6g61Bwlr01UffhC9dt6JRDwAruCkBNTIHLfzYNG/U3euG6EcHEaOJI+XfSqDeGfenWcSRFsh0mxv6aKx7A7D4ZWdx8cHqWaOAALfHclkQSM/VCjRICQINJ1DPQ1aJDtOdpMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r88ctCMpA9L1nitUf8d2nQQV+W86OodmnjonfGPKri4=;
 b=hVrZ+owl1c7boIuNMA4+tfkYfD6QRTHhjBgx1Fy5/ydQ4KHOHDux4vg5z6mOEmKPnySmfvloCn6HB5bfO5yTRZAcXeO/3O0EVnx8vZL9Zaovu4a8fTtZXNGXe66SPCAtz9OnVlNYvU/MvwG9H9ClEM6Nhn2JzidRghD6/zjoxz/AXgUe55ll18mXNnGkDmWlnmKwooS3DF67MO3q+rTREMC7zlmiScmVDuPBI9UFn3Boz76G9tShllZNw6VBOgb9QPZzn/mCf4oV0vwpkHD9WkSEKa5nNWbMFttoig1NUkkYt7/IkTMmoBO4UX/UG8s0cSzqSG7B/w04TvdCayQJrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r88ctCMpA9L1nitUf8d2nQQV+W86OodmnjonfGPKri4=;
 b=MIaKBD/SSA+sv+J6bNJnMrugmA86Rd68+SEnXMJfEluHnZGt4EESkQQRa0a3fC5SuXcdnF5eKOrZOnsujvohEsr9A6f1242VjejIHwRgYMg1gbmB6mke00UFWSigmTsvUhc2R4qNYYD+cXw0+jSMN8xxZ2BlN0C7NmUXFuUQ/Kg=
Received: from OL1P279CA0011.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:12::16)
 by VI1PR0602MB2848.eurprd06.prod.outlook.com (2603:10a6:800:b0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Fri, 1 Jul
 2022 02:30:37 +0000
Received: from HE1EUR02FT104.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:e10:12:cafe::b4) by OL1P279CA0011.outlook.office365.com
 (2603:10a6:e10:12::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Fri, 1 Jul 2022 02:30:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com; pr=C
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 HE1EUR02FT104.mail.protection.outlook.com (10.152.11.230) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.14 via Frontend Transport; Fri, 1 Jul 2022 02:30:36 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, tomas.melin@vaisala.com,
        nuno.sa@analog.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qing-wu.Li@leica-geosystems.com.cn
Cc:     bsp-development.geo@leica-geosystems.com
Subject: [PATCH V1 1/1] iio: accel: sca3300: Extend the trigger buffer from 16 to 32 bytes
Date:   Fri,  1 Jul 2022 02:30:30 +0000
Message-Id: <20220701023030.2527019-2-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220701023030.2527019-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220701023030.2527019-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 30446440-5983-416f-6d8d-08da5b09ae91
X-MS-TrafficTypeDiagnostic: VI1PR0602MB2848:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JUvOFCXyvVnTLWmus0Sb5cjQM6WtG8C19OSVmRJlplwEXVQL8VW6rajhVRxEEYMH/VbgVhRmKLo02ahzYqA4nWGiqFOm0fz8tiaodToIgVWMUdsd8HVxHPqNhl+n3KhfcY9O67WqX/u8D3m6Sn2SK6CIdiCVwEjwt/axpF9Fhs+SJyZc+T9Gyt96924+q/JdDq4Lg75eHRAI9h+Y2Bo7WWCOQmeVcbGmbNhWQ3Ce286xXfjl9bZP/ZA2uy22wLJibmky0Q3W2K3cB3getjDhOn7I7PHQa02SBaZmLsPkzLZ6v2V8aSv/wahUdHPSz/oc57pD3jGl0oi121CwFqTtdXT98A8DV+AHU+v8G2iok4gcn8hU1JBccNXF9Mo+dpWd7dfqM+//DNpwJbW5gL+e9JEX1T4ZjHxgWpVUZVAcUlclDiZJA8NKKU6PAi3wJlyw6LleF3jo8FxZSAICgfm4UmiGHP9lF4m57Wn+s4Yegc5cxFiS/RkwaHBcYeDNBxbk52hzPMs9vml0zonLI1ofhZCo0+zv87n7h3ByDw8HwI8xM14vqqf3dw7hkCLYUk+cosyKLjcT/Vlgq5SXV3U4BnaghpieT+L6cK4TazSvjcVg6dJ8Bqi//hS9lcRd6w/IZAdJU+ggvTU2edYHLdP0MvdI079jVAnkZbZbi/TG8OH8482Bj0jPVdplYc69J6LoMo12R0lAU8Wkuj6p7mmDiW6hdESjyHpb8GQl1Ck769dHsfYU9WnhDxt18yxXRSNwDEbuFjVjDINgDNWDvZ1YHPFmFcSiNzh3EoUWkc0eKt+zYVNAzviLlJhdiVaE+AO4
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(136003)(346002)(46966006)(40470700004)(36840700001)(6486002)(2616005)(336012)(70586007)(1076003)(26005)(81166007)(6506007)(107886003)(47076005)(83380400001)(6666004)(956004)(41300700001)(8676002)(186003)(356005)(82740400003)(6512007)(36860700001)(36736006)(478600001)(118246002)(40480700001)(5660300002)(36756003)(8936002)(2906002)(86362001)(82310400005)(4326008)(40460700003)(316002)(70206006);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 02:30:36.4040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30446440-5983-416f-6d8d-08da5b09ae91
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT104.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0602MB2848
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After added inclination angle channels, the trigger buffer size is
insufficient. Extend the buffer size from 16 to 32 bytes, and change
the trigger buffer from the struct to a u8 array to adapt the sensor
with/without inclination angles output.
New trigger buffer data:
  - SCA3300: 3 accel channels, temp, and timestamp.
  - SCL3300: 3 accel channels, temp, 3 incli channels, and timestamp.
Readjustment the scan index to make it consistent with the buffer data.

Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/iio/accel/sca3300.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
index 3c4827bfef53..820dfb635bf1 100644
--- a/drivers/iio/accel/sca3300.c
+++ b/drivers/iio/accel/sca3300.c
@@ -47,12 +47,20 @@
 #define SCL3300_REG_ANG_CTRL 0x0C
 #define SCL3300_ANG_ENABLE   0x1F
 
+/*
+ * Buffer size max case:
+ * Three accel channels, two bytes per channel.
+ * Temperature channel, two bytes.
+ * Three incli channels, two bytes per channel.
+ * Timestamp channel, eight bytes.
+ */
+#define SCA3300_MAX_BUFFER_SIZE (ALIGN(2 * 7, sizeof(s64)) + sizeof(s64))
+
 enum sca3300_scan_indexes {
 	SCA3300_ACC_X = 0,
 	SCA3300_ACC_Y,
 	SCA3300_ACC_Z,
 	SCA3300_TEMP,
-	SCA3300_TIMESTAMP,
 	SCA3300_INCLI_X,
 	SCA3300_INCLI_Y,
 	SCA3300_INCLI_Z,
@@ -140,10 +148,10 @@ static const struct iio_chan_spec scl3300_channels[] = {
 	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Y, 0x2, Y),
 	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Z, 0x3, Z),
 	SCA3300_TEMP_CHANNEL(SCA3300_TEMP, 0x05),
-	IIO_CHAN_SOFT_TIMESTAMP(4),
 	SCA3300_INCLI_CHANNEL(SCA3300_INCLI_X, 0x09, X),
 	SCA3300_INCLI_CHANNEL(SCA3300_INCLI_Y, 0x0A, Y),
 	SCA3300_INCLI_CHANNEL(SCA3300_INCLI_Z, 0x0B, Z),
+	IIO_CHAN_SOFT_TIMESTAMP(7),
 };
 
 static const unsigned long sca3300_scan_masks[] = {
@@ -184,7 +192,9 @@ struct sca3300_chip_info {
  * @spi: SPI device structure
  * @lock: Data buffer lock
  * @chip: Sensor chip specific information
- * @scan: Triggered buffer. Four channel 16-bit data + 64-bit timestamp
+ * @buffer: Triggered buffer:
+ *          -SCA3300: 4 channel 16-bit data + 64-bit timestamp
+ *          -SCL3300: 7 channel 16-bit data + 64-bit timestamp
  * @txbuf: Transmit buffer
  * @rxbuf: Receive buffer
  */
@@ -192,10 +202,7 @@ struct sca3300_data {
 	struct spi_device *spi;
 	struct mutex lock;
 	const struct sca3300_chip_info *chip;
-	struct {
-		s16 channels[4];
-		s64 ts __aligned(sizeof(s64));
-	} scan;
+	u8 buffer[SCA3300_MAX_BUFFER_SIZE] __aligned(sizeof(s64));
 	u8 txbuf[4] __aligned(IIO_DMA_MINALIGN);
 	u8 rxbuf[4];
 };
@@ -484,21 +491,21 @@ static irqreturn_t sca3300_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct sca3300_data *data = iio_priv(indio_dev);
 	int bit, ret, val, i = 0;
+	s16 *channels = (s16 *)data->buffer;
 
 	for_each_set_bit(bit, indio_dev->active_scan_mask,
 			 indio_dev->masklength) {
-		ret = sca3300_read_reg(data, sca3300_channels[bit].address,
-				       &val);
+		ret = sca3300_read_reg(data, indio_dev->channels[bit].address, &val);
 		if (ret) {
 			dev_err_ratelimited(&data->spi->dev,
 				"failed to read register, error: %d\n", ret);
 			/* handled, but bailing out due to errors */
 			goto out;
 		}
-		data->scan.channels[i++] = val;
+		channels[i++] = val;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
+	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
 					   iio_get_time_ns(indio_dev));
 out:
 	iio_trigger_notify_done(indio_dev->trig);
-- 
2.25.1

