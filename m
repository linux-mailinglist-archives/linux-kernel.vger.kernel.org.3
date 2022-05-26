Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B7F535009
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 15:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347581AbiEZNe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 09:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346493AbiEZNeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 09:34:11 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70105.outbound.protection.outlook.com [40.107.7.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DA5D80A4;
        Thu, 26 May 2022 06:34:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5SjsPB6QiibQB/zM+th117D9ImD/EkZjT0fdV6FG6YtR4H2a2hcQnbiP9qLcbg3uvCrYhoy6qQ1tpP3sc22FzLdMN3KBbc/VOOajT8NqRni6Zqv29MZSQH4UyNU4QYYzT207LPE33MFW5tQAfJqYQhsujnfAmNlJTW1t6NkNw17bQyJeIuCOkO2hPnzVqJvNgButGQfAUG2Wc61bRklXkrdyqVw9HvktBtKECcNS+3L6G4PGo+ifGhYUmgykKbPCmLbHtDQYvF3MsqpnEC4HWfR7B1mcbYJMb/uF3B0XQnrYxD+H+46CDmHdfbIFt+qz8F7yMXCZTBquTc9OvWUpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJlUU6YxySDAwWSlxINHVVG9+kZ8eRSqdrqEm05zcz4=;
 b=XP7jJdflYxxm+Bgd86A9yoyvsWXVlvG17fNOtTSG1ef9Uf338c8mrxq6NnjPTSYCn0Hlar/Z9wzD8ysCVbmTJAp4gc7i85e4egLtriCPWAQl08Cf7RBmKvoUUooxmrLnP2dktlwp/kNgzWOKH6hBNF7vzyPdD+EePXw4FKm2sPYqNw9gVCIPPAbbYwLcxUzQAEYu1wBFPTGKmtlKWDbD3/gxG/AK3ChVyCtgjr9uU4DYF0qQUZgBVGLMiYSGJvHm5BRMfwxtKdTB5x+qyFNaWey0paKSpiRFZq6hfhj/mO3yqQFN58bt4KYFAhrPUblCzQtvkQwsg49gW7v8sXGg1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJlUU6YxySDAwWSlxINHVVG9+kZ8eRSqdrqEm05zcz4=;
 b=zGu4EjV6np3w5GE1P42BcAEKLaRFllSK70wEnckTKFTs6JzJJSs0tAYsPagZE0AKeFl3V/wU8pb3mD7BSFx2kiJgTupH4faJVV+PPROKDv+GmzgNZqRx5Rd1NLWr/LwKQHUdIuYkOFPuZXfgJbFvOHj4bl+YejBgE0ujOHzH+OA=
Received: from AS9PR06CA0029.eurprd06.prod.outlook.com (2603:10a6:20b:462::18)
 by PR1PR06MB5803.eurprd06.prod.outlook.com (2603:10a6:102:2::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.19; Thu, 26 May
 2022 13:34:07 +0000
Received: from VE1EUR02FT025.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:462:cafe::d6) by AS9PR06CA0029.outlook.office365.com
 (2603:10a6:20b:462::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15 via Frontend
 Transport; Thu, 26 May 2022 13:34:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com; pr=C
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 VE1EUR02FT025.mail.protection.outlook.com (10.152.12.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13 via Frontend Transport; Thu, 26 May 2022 13:34:06 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, mchehab+huawei@kernel.org,
        ardeleanalex@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qing-wu.Li@leica-geosystems.com.cn,
        robh+dt@kernel.org, mike.looijmans@topic.nl,
        devicetree@vger.kernel.org
Cc:     thomas.haemmerle@leica-geosystems.com
Subject: [PATCH V5 5/6] iio: accel: bmi088: Add support for bmi090l accel
Date:   Thu, 26 May 2022 13:33:58 +0000
Message-Id: <20220526133359.2261928-6-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220526133359.2261928-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220526133359.2261928-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: bc0b8792-8a05-4fe0-f877-08da3f1c6857
X-MS-TrafficTypeDiagnostic: PR1PR06MB5803:EE_
X-Microsoft-Antispam-PRVS: <PR1PR06MB580377064859481846740722D7D99@PR1PR06MB5803.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5h/cCWX32JqumXFIYTVNjbocFl8MPflwumIoWTq65q/Xg0h+eUB0hkseEOCq4O/yXnlIpa8sSwsn3DTLhQ3wf1mqP3SEKxYeI+OwzqKah6asGu5Vx6OR8Xl2K8vsrOEzqzP850bh0MnLupefNqV6kPhG9P2xxNn2Sik4ihualpTY3uMXJe9xd+uE5R+kF2TqxQGXvdW43Zp+xfkb3sI58IqHBwwpKhLe0sJWqM5PHQHEnBSFN39O8aO3gJ3+aN2BawdyUyhhaeesmov25qkG5zbk7nGd1cH75uXagPJESLXBL0OA6L2xRmojwfgDAcMuIvcElS343VOVPpne7NDHZ4nbJHVX7Aqnj0stv7R/Y9DgfNPNKoDOW2oQyMZGaHxQQtflzZHReN4mVfbXB7y7ctvpmSyQkUMJkVUq1gxALPKdvZK/3mLBrfu+YSQX2SQ+qPSpDXMHlCJlblogHHLtQ6kkvnQeEVQJgccWcDJaxLkQ3F1Ett8wy6ouLNE9geJf5bHiHVfCazeFRHDeW+LHEecZuhLSonvCB1IHfZ0068iL4seq0EBNRNSIZPnke7p1kPVOEKkYV//JuykLnpsxtfGWzx76RI39NmnZDXR8KudHamyg7yZ5M3pG93AP57rPF3HeTijkQJTmtPgGPgyFsRSIAwRVjLhHi7WQOHNHrD1IZ/z3eFTJSRloC7QFwnrzgwxRs+Vr3QzOnDMVrsRa8A==
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2906002)(82310400005)(118246002)(356005)(70206006)(6506007)(6666004)(921005)(336012)(47076005)(70586007)(956004)(1076003)(8676002)(2616005)(107886003)(4326008)(26005)(40460700003)(186003)(5660300002)(6486002)(36736006)(316002)(81166007)(86362001)(508600001)(8936002)(36860700001)(36756003)(6512007);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 13:34:06.6076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc0b8792-8a05-4fe0-f877-08da3f1c6857
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT025.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1PR06MB5803
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add supports for BMI090L, it's a high-performance Inertial
Measurement Unit, with an accelerometer and gyroscope.
The commit adds the accelerometer driver for the SPI interface.
The gyroscope part is already supported by the BMG160 driver.
Same as BMI088, BMI090L have the range of +/-3, 6, 12, and 24g.

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/iio/accel/bmi088-accel-core.c | 7 +++++++
 drivers/iio/accel/bmi088-accel-spi.c  | 2 ++
 drivers/iio/accel/bmi088-accel.h      | 1 +
 3 files changed, 10 insertions(+)

diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
index f6ecb081456b..a4e95cf63fab 100644
--- a/drivers/iio/accel/bmi088-accel-core.c
+++ b/drivers/iio/accel/bmi088-accel-core.c
@@ -479,6 +479,13 @@ static const struct bmi088_accel_chip_info bmi088_accel_chip_info_tbl[] = {
 		.num_channels = ARRAY_SIZE(bmi088_accel_channels),
 		.scale_table = {{0, 897}, {0, 1794}, {0, 3589}, {0, 7178}},
 	},
+	[BOSCH_BMI090L] = {
+		.name = "bmi090l-accel",
+		.chip_id = 0x1A,
+		.channels = bmi088_accel_channels,
+		.num_channels = ARRAY_SIZE(bmi088_accel_channels),
+		.scale_table = {{0, 897}, {0, 1794}, {0, 3589}, {0, 7178}},
+	},
 };
 
 static const struct iio_info bmi088_accel_info = {
diff --git a/drivers/iio/accel/bmi088-accel-spi.c b/drivers/iio/accel/bmi088-accel-spi.c
index b14a1e5b986a..8aa25138f098 100644
--- a/drivers/iio/accel/bmi088-accel-spi.c
+++ b/drivers/iio/accel/bmi088-accel-spi.c
@@ -64,6 +64,7 @@ static void bmi088_accel_remove(struct spi_device *spi)
 static const struct of_device_id bmi088_of_match[] = {
 	{ .compatible = "bosch,bmi085-accel" },
 	{ .compatible = "bosch,bmi088-accel" },
+	{ .compatible = "bosch,bmi090l-accel" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, bmi088_of_match);
@@ -71,6 +72,7 @@ MODULE_DEVICE_TABLE(of, bmi088_of_match);
 static const struct spi_device_id bmi088_accel_id[] = {
 	{"bmi085-accel",  BOSCH_BMI085},
 	{"bmi088-accel",  BOSCH_BMI088},
+	{"bmi090l-accel", BOSCH_BMI090L},
 	{}
 };
 MODULE_DEVICE_TABLE(spi, bmi088_accel_id);
diff --git a/drivers/iio/accel/bmi088-accel.h b/drivers/iio/accel/bmi088-accel.h
index 044999eb4fd6..80cd396a3141 100644
--- a/drivers/iio/accel/bmi088-accel.h
+++ b/drivers/iio/accel/bmi088-accel.h
@@ -11,6 +11,7 @@ struct device;
 enum bmi_device_type {
 	BOSCH_BMI085,
 	BOSCH_BMI088,
+	BOSCH_BMI090L,
 	BOSCH_UNKNOWN,
 };
 
-- 
2.25.1

