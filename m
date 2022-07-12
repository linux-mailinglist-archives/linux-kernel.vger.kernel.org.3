Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45EE5721CA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 19:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbiGLRbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 13:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiGLRbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 13:31:45 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2082.outbound.protection.outlook.com [40.107.96.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2978C5482;
        Tue, 12 Jul 2022 10:31:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IC2AzaHSZUEpJIWYdds8WXrYgx7QTn1qlJifWIjEKgWxTj3CInN+rD0LF+AAxp7MxB5Q5Mct7kmYegwb8+FaaRVQ1iTcIxw5z471ACC9D2XgDXl+luDiIvLqJBNB6bqM9MoZrzrfG5jRx4cYxAPvh9Yoy1WD6zxUZuWaEv0lW66SJZt3Ti/xOQ/YFx02On6T0c84xAvs8kL/MXCYIDh2KiN4jJVsRrHRdDEOYfYNsLjMOdGzzbjWwkCh4foo6ROTOQEldoOXTU72wesjdWNj4cVpewaunxd9Sb/xNhkiJFLjlEUvGxKqCYpIHE10dD+7OzSyKdvti0aJq0i9Yp07KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mttisGUbmStlZceGJQZdegKXdT9TubuteEQiP5T8LU=;
 b=d0Cu1pSQQtekBfvweH/d/cKEn+mh/PNE3HZIXcErwns9tWl0g4UxQn4xbJQCm1/mNIjwQMBC7S3NnXwVvF9nD8gs53NzI9rcR1Jj7G1o2n8/e9PZNuLyt9gidClQPHOla21WiQ/KVun8LIvoIAZemD/YZ4zrGmWtjgEV2j6DdOn1fgw54vMZV1yQlKA21msDoBuIWfv5MAA61Y+keI/JhsC5zHOcQAU0Ru7V9fYYbIGMkeUUuORE9dV8Y9vAHqsYYTayYzxkltiUAux1dTTVAYEiEAmIlKJGwrBtWaaZyKsI96Z90VNyYFXjK9P14cMKSR0fhW6Z8fpo8gbsFmXT4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mttisGUbmStlZceGJQZdegKXdT9TubuteEQiP5T8LU=;
 b=Gql4GQtCwi0jha4QBb3SMm0ALWKXd2HzAafh2K8IEulBSsyD6NNpdLCNmUN7FC6OxzuhxIm2wwRqVr54LDnL/t8MFLZFQ99n4dEsxitPiAHn43qSiSiRIM6eC19Sqs6S2lWHOzsHRXHTofJtopBzPrYzdWW6WEkkv29S/6GgIxI=
Received: from DS7PR06CA0041.namprd06.prod.outlook.com (2603:10b6:8:54::10) by
 DM6PR12MB4484.namprd12.prod.outlook.com (2603:10b6:5:28f::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.20; Tue, 12 Jul 2022 17:31:42 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::20) by DS7PR06CA0041.outlook.office365.com
 (2603:10b6:8:54::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20 via Frontend
 Transport; Tue, 12 Jul 2022 17:31:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Tue, 12 Jul 2022 17:31:42 +0000
Received: from ethanolx1ade-milan-genesis.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 12 Jul 2022 12:31:41 -0500
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <amitk@kernel.org>, <thara.gopinath@gmail.com>,
        <agross@kernel.org>, <david.brown@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bilbao@vt.edu>
CC:     Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH] thermal/drivers/qcom: Code refactoring
Date:   Tue, 12 Jul 2022 12:31:27 -0500
Message-ID: <20220712173127.3677491-1-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39413991-b823-431a-6786-08da642c6297
X-MS-TrafficTypeDiagnostic: DM6PR12MB4484:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7cSk/fYT6zOodMXEhW2Xykx+VUMkzWJWwfl+7Ij15STCdnNYtQF+iucTolBOxNz8Lg0IdUdxd7lK7ATVnZxADlvo44K5IzQbW0dp4Wufz3xucEx6i+kmhDzV1N2nSejxqgS8U5pX+9/60SKY/ExpBON9dO5mUwi3z1mEOcrHMlAJ9UCgiuUhV1fUVb36I0uoDps2D7cj9z7kO/36mrXJ7XmJmtkBseAGRE7CwTAEjMMRjaNxw+v1XhixoeMQ3NKCl3Qf/2C+55Dz0tJ3hOiFNniODfhNfhJzVtEtjn6Hv0TLFyl4ro6IAsx0RkxSt9TqdZhGNI2Dy0DcMqvOQOGmaG6ZbRuLZ83b1Disg4AnDXqVLkJIleKn1JBiDcYYGehcXgcooyOhDcUX9Rrp0495RFjlfiy7gRe/3rxVanj/gOeLkWCm0npbB+V5fi8Az/t7AOpkJDopw2Mm8iriqNPzob8kM+vpnmS4m4PV39ZD2XbAa+NyE6t21gqLh1P3z24RCUmma7mjV2+RT2I7olALvx0FZWDYEjRlerKohTr34pGjyaz8f63Vc448dXzthpb8dSHZ+ZVvWrK4wckZSO5KXM2sCvP3I9BUL0h8HnZEGSg3W83ARBdVxSOJ+aO6dQJH3CGnnMSjMYi3758NjYWg/cTHA+u3FUPUmKhw6nmjnIvWS9CXNTTzyTY9RWQAtvF9S7jXXdXyj/cln443JuIWZXCJuAfq5z4iPpvUPcggAkAPZsqhoXqjko4JRljFlV09zDBHDKwABV9XM3JkRrBXT0u+dfsYvxiveecqA66ZiflUQAoRoU2RtiNRgFHESQ05YuKMdj6kP8Ds0PGeVk0y0I/wWwOZ39dWtwrklKen4Xg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(396003)(39860400002)(376002)(46966006)(36840700001)(40470700004)(44832011)(8936002)(336012)(47076005)(40460700003)(82310400005)(86362001)(40480700001)(5660300002)(26005)(356005)(36860700001)(82740400003)(2906002)(83380400001)(36756003)(110136005)(81166007)(478600001)(7696005)(8676002)(16526019)(70206006)(316002)(4326008)(1076003)(70586007)(6666004)(426003)(41300700001)(186003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 17:31:42.0837
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39413991-b823-431a-6786-08da642c6297
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4484
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some functions in tsens-8960.c can directly return ret instead of doing an
extra check. In function calibrate_8960(), a second check for IS_ERR(data)
can also be avoided in some cases. A constant could be used to represent
the maximum number of sensors (11). Finally, function code_to_degc() can be
simplified, avoiding using an extra variable.

Include these small refactoring changes.

Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 drivers/thermal/qcom/tsens-8960.c   | 25 +++++++++----------------
 drivers/thermal/qcom/tsens-common.c | 18 ++++++++----------
 drivers/thermal/qcom/tsens-v0_1.c   |  6 +++---
 drivers/thermal/qcom/tsens-v1.c     |  2 +-
 drivers/thermal/qcom/tsens.h        |  1 +
 5 files changed, 22 insertions(+), 30 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index 8d9b721dadb6..576bca871655 100644
--- a/drivers/thermal/qcom/tsens-8960.c
+++ b/drivers/thermal/qcom/tsens-8960.c
@@ -76,10 +76,8 @@ static int suspend_8960(struct tsens_priv *priv)
 		mask = SLP_CLK_ENA_8660 | EN;
 
 	ret = regmap_update_bits(map, CNTL_ADDR, mask, 0);
-	if (ret)
-		return ret;
 
-	return 0;
+	return ret;
 }
 
 static int resume_8960(struct tsens_priv *priv)
@@ -106,10 +104,8 @@ static int resume_8960(struct tsens_priv *priv)
 		return ret;
 
 	ret = regmap_write(map, CNTL_ADDR, priv->ctx.control);
-	if (ret)
-		return ret;
 
-	return 0;
+	return ret;
 }
 
 static int enable_8960(struct tsens_priv *priv, int id)
@@ -132,10 +128,8 @@ static int enable_8960(struct tsens_priv *priv, int id)
 		reg |= mask | SLP_CLK_ENA_8660 | EN;
 
 	ret = regmap_write(priv->tm_map, CNTL_ADDR, reg);
-	if (ret)
-		return ret;
 
-	return 0;
+	return ret;
 }
 
 static void disable_8960(struct tsens_priv *priv)
@@ -206,10 +200,8 @@ static int init_8960(struct tsens_priv *priv)
 
 	reg_cntl |= EN;
 	ret = regmap_write(priv->tm_map, CNTL_ADDR, reg_cntl);
-	if (ret)
-		return ret;
 
-	return 0;
+	return ret;
 }
 
 static int calibrate_8960(struct tsens_priv *priv)
@@ -221,10 +213,11 @@ static int calibrate_8960(struct tsens_priv *priv)
 	struct tsens_sensor *s = priv->sensor;
 
 	data = qfprom_read(priv->dev, "calib");
-	if (IS_ERR(data))
+	if (IS_ERR(data)) {
 		data = qfprom_read(priv->dev, "calib_backup");
-	if (IS_ERR(data))
-		return PTR_ERR(data);
+		if (IS_ERR(data))
+			return PTR_ERR(data);
+	}
 
 	for (i = 0; i < num_read; i++, s++)
 		s->offset = data[i];
@@ -278,6 +271,6 @@ static const struct tsens_ops ops_8960 = {
 };
 
 const struct tsens_plat_data data_8960 = {
-	.num_sensors	= 11,
+	.num_sensors	= MAX_NUM_SENSORS,
 	.ops		= &ops_8960,
 };
diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 528df8801254..fe5f4459e1cc 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -66,19 +66,17 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *p1,
 
 static inline int code_to_degc(u32 adc_code, const struct tsens_sensor *s)
 {
-	int degc, num, den;
+	int degc, den;
 
-	num = (adc_code * SLOPE_FACTOR) - s->offset;
+	degc = (adc_code * SLOPE_FACTOR) - s->offset;
 	den = s->slope;
 
-	if (num > 0)
-		degc = num + (den / 2);
-	else if (num < 0)
-		degc = num - (den / 2);
-	else
-		degc = num;
-
-	degc /= den;
+	if (degc != 0) {
+		if (degc > 0)
+			degc = (degc + (den / 2)) / den;
+		else
+			degc = (degc - (den / 2)) / den;
+	}
 
 	return degc;
 }
diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index 6f26fadf4c27..42e897526345 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -188,7 +188,7 @@ static int calibrate_8916(struct tsens_priv *priv)
 static int calibrate_8974(struct tsens_priv *priv)
 {
 	int base1 = 0, base2 = 0, i;
-	u32 p1[11], p2[11];
+	u32 p1[MAX_NUM_SENSORS], p2[MAX_NUM_SENSORS];
 	int mode = 0;
 	u32 *calib, *bkp;
 	u32 calib_redun_sel;
@@ -324,7 +324,7 @@ static const struct tsens_features tsens_v0_1_feat = {
 	.crit_int	= 0,
 	.adc		= 1,
 	.srot_split	= 1,
-	.max_sensors	= 11,
+	.max_sensors	= MAX_NUM_SENSORS,
 };
 
 static const struct reg_field tsens_v0_1_regfields[MAX_REGFIELDS] = {
@@ -374,7 +374,7 @@ static const struct tsens_ops ops_8974 = {
 };
 
 const struct tsens_plat_data data_8974 = {
-	.num_sensors	= 11,
+	.num_sensors	= MAX_NUM_SENSORS,
 	.ops		= &ops_8974,
 	.feat		= &tsens_v0_1_feat,
 	.fields	= tsens_v0_1_regfields,
diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index 10b595d4f619..98acc9b64555 100644
--- a/drivers/thermal/qcom/tsens-v1.c
+++ b/drivers/thermal/qcom/tsens-v1.c
@@ -149,7 +149,7 @@ static const struct tsens_features tsens_v1_feat = {
 	.crit_int	= 0,
 	.adc		= 1,
 	.srot_split	= 1,
-	.max_sensors	= 11,
+	.max_sensors	= MAX_NUM_SENSORS,
 };
 
 static const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 2fd94997245b..d2d78c7e20c8 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -6,6 +6,7 @@
 #ifndef __QCOM_TSENS_H__
 #define __QCOM_TSENS_H__
 
+#define MAX_NUM_SENSORS		11
 #define ONE_PT_CALIB		0x1
 #define ONE_PT_CALIB2		0x2
 #define TWO_PT_CALIB		0x3
-- 
2.31.1

