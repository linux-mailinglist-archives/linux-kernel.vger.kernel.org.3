Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B01F51FED4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 15:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236459AbiEINu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 09:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236415AbiEINuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 09:50:50 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70125.outbound.protection.outlook.com [40.107.7.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF9816D5CE;
        Mon,  9 May 2022 06:46:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=haSL6AtJKmb2rcod6/Bx5+zlx9JSjTYJGTu3DQPgMcL91IO4/uGiykHcMOkzU0tjZqbrbrzdlDEGwH+sJjr4T+BiAw00mEfRWfV8sQwFpR6cu71AFPiVjb5XmWaBLFrxFhLBrqnUWETVCGl0m1YZyOfBWFXXi1Y6tQyylfDEavPWn/6lEs2W6MWaKJ8wb7mxvx9y1PgECqZANqhWmypbGivBQBPNjRouqgSB5owIZspDYzlGJNH5KDfvvoe+GoD+CKIzXTG3RGpE/+pOgHlywCwBDYdpMuoTe65ZLzJKwL7z2qBU/Ruu+bwED6qOMiduhM3v1vUv7R9CY7z6ZqadIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHYXk3E8HIAjGeCZQVdDr941iUJX3u0mPSa0nBZ8EOU=;
 b=gOxwN2mFfHPiDCqyEKPkq2UJPoNnIK6N+EKI8UiS/iaNK+Bx/U2M51/V1uKK0lFsHnq3xwifUd/3PY0POT5iU0pkMemmkWkkDalToihmaOknbwkgShigNlCwuUz1sN4Os1IXOVJmZVMWBbKVGX2Vc45UiyD0VZ8+x2W1l/4gocvCwMIokb61U8Ca+umy7vHF1XDll3eMbbjorlEywltYDn5hH4uLoz8NIGyfNK4Zu1xLayqn/AeVRH7ivuXuy+811HWvcKGa64tFSPei6ZAzc2j9z1UsKsgBXNRPl7JulVO8WqbOLJkWGkiIDdeoG7Gtmea+u1wfntb8Bat2Q3b93g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHYXk3E8HIAjGeCZQVdDr941iUJX3u0mPSa0nBZ8EOU=;
 b=aJzCqSaFaAJ6v9s7Wp+1t4vMmVESlcl14ujkLy0usMj2UnzIRp+8WiKqIve+lbBg1VNUnycdokCAemcYG3IoWA0i2s2XMFHG1jw6cqRiDKz8yqp+62rt8FDthJs0FWmQP5A3N6rILczovNmuiom3nXhdQc7+IMK07hZJnBNhLKQ=
Received: from AS9PR04CA0072.eurprd04.prod.outlook.com (2603:10a6:20b:48b::7)
 by AS8PR06MB8181.eurprd06.prod.outlook.com (2603:10a6:20b:3d0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Mon, 9 May
 2022 13:46:42 +0000
Received: from VE1EUR02FT056.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:48b:cafe::ef) by AS9PR04CA0072.outlook.office365.com
 (2603:10a6:20b:48b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Mon, 9 May 2022 13:46:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 VE1EUR02FT056.mail.protection.outlook.com (10.152.13.71) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 13:46:42 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, mchehab+huawei@kernel.org,
        ardeleanalex@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qing-wu.Li@leica-geosystems.com.cn
Subject: [PATCH V1 5/5] iio: accel: bmi088: modifed the device name.
Date:   Mon,  9 May 2022 13:46:29 +0000
Message-Id: <20220509134629.440965-6-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220509134629.440965-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220509134629.440965-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d591f17d-2f21-4c7c-0a94-08da31c259c8
X-MS-TrafficTypeDiagnostic: AS8PR06MB8181:EE_
X-Microsoft-Antispam-PRVS: <AS8PR06MB81816684345DC9A268B8295CD7C69@AS8PR06MB8181.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kBW5qaqJYhhbFg+xlg5uPSeapNobJnsVfgGOVflYWcUwWkxxvyckmTrNPHVeymOOMJMLtl3p8HVbcD8yoBXx6MyfUPCr9Mcn1p1jz9JBr5Fv0c9dRWlBX9HEBwbGX+qZAKb1O7L6vbkngLhCiBrzS7wbKgOzN2ffR+DVEl80AhtoLcbXG+atxr4HoWQ/p2f7O7Lc0qLkvcO2lT9tjqMFUFIbx06YzM/3prMv30CJEoIhPBXSBzIDim8NBQdh8e4Sp1PDHVIwjvfNr1fDfbYFn6A+VgjWTlDvFCzYeJqgDKLBqq0+xLguXQjjvc7lqhanGvh9jDoDChjmH42ppseNmWbQrN0Ls2+nXxTJEBVht1T/WpjetbnbeB86NJ/4vjOE1tLjZsb158CygWxpAmokza/wKFm5dy1mIYldrvvCMlAEEjvABmVzjo+gK1MfoIvPxJtF9fjApNSag2WxfIHLfFeN0yQ6ucZDcc4XclaEYuDkIkROtAoqyz9KaLmOfbgOjbSoXBze7O1WG8oHNwiIpmO1Hk9B8yV/wKCFmG/3t7wOdXRlCT0gh5fS5s4nyw7McqxIBZET+7mC3GDWU4nOXgFUiY89ea16QvlHxpceTmVZ0QVwyLg4jj+Gqb8Yktg+Mykz2Q33043D44WwVJ1r5fb07V7xhsXTPs9eM8mVCWgqpj+n6d1Cl3E41yj3XFnZ
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(356005)(6512007)(6506007)(6666004)(508600001)(26005)(186003)(6486002)(40460700003)(82310400005)(36860700001)(81166007)(86362001)(83380400001)(336012)(47076005)(1076003)(2616005)(956004)(5660300002)(8936002)(36756003)(70206006)(2906002)(36736006)(118246002)(70586007)(316002)(8676002);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 13:46:42.4326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d591f17d-2f21-4c7c-0a94-08da31c259c8
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT056.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB8181
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible to have multiple sensors connected on the same platform,
The commit makes it possible to obtain the device name for
the different chips according to the connected chip ID.

To be compatible with previous versions, renambmi088a to bmi088-accel.

Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 drivers/iio/accel/bmi088-accel-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
index 7c78cfb321ee..8f6920dc2ad9 100644
--- a/drivers/iio/accel/bmi088-accel-core.c
+++ b/drivers/iio/accel/bmi088-accel-core.c
@@ -461,7 +461,7 @@ static const struct iio_chan_spec bmi088_accel_channels[] = {
 
 static const struct bmi088_accel_chip_info bmi088_accel_chip_info_tbl[] = {
 	[0] = {
-		.name = "bmi088a",
+		.name = "bmi088-accel",
 		.chip_id = 0x1E,
 		.channels = bmi088_accel_channels,
 		.num_channels = ARRAY_SIZE(bmi088_accel_channels),
@@ -561,7 +561,7 @@ int bmi088_accel_core_probe(struct device *dev, struct regmap *regmap,
 
 	indio_dev->channels = data->chip_info->channels;
 	indio_dev->num_channels = data->chip_info->num_channels;
-	indio_dev->name = name ? name : data->chip_info->name;
+	indio_dev->name = data->chip_info->name;
 	indio_dev->available_scan_masks = bmi088_accel_scan_masks;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &bmi088_accel_info;
-- 
2.25.1

