Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB6B4B9940
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 07:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235618AbiBQG1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 01:27:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235427AbiBQG1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 01:27:30 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2107.outbound.protection.outlook.com [40.107.21.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63BA2804F0;
        Wed, 16 Feb 2022 22:27:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HvTvCyVy/VpoLu1cGfCz3ayXYNEkKvzqll+y5Y3HEfoIRnxof9ifyhQ1/J4kDm02AckbiZBsMdwk87zxwsXlr6PqQ7N08gTMzgsAkPK+ShJvL1kTQd3T05tWIx6CfxbTmQ21GTwI6kDH0bTDXaRBRNjNc3a+HmGJlIQDdiHO8DkwtqCOcE1Z1M2XUgH33IPw+B6scMSUfsWpQuH7ZYXrysaiJ9wWz0wTsTDrDQ9AHXRtafLyQ4r6Lqw70obWtMfEjBGeXWlwdD3hGdHvDag8+r7+cJPWBIrq4E8k7iFKkJ3XtgyGN1jfDaULFDb50LtKAZY0229c0rtICNvN1sybrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8pF8QoyeW8SoNhfIv4dgfaNxj6MxM2G5WRPmaYL3rM=;
 b=IyVFm6O3L6tl3fxv6AZ+sAjEsvSV0vFnPaDQGzX5H5SIfaPJKtEL82db0/ZQ4W8tjpSQw2VwftSsxZwQSh97gn28om2FA7HBmVgq1tpJoAbEU+sM155DfHL/iZweVIc7ddZ3m0lHTBCpPXqLFQTfv90dxrIWRt3EofbFiGVDcLxXeLc6XPNRc7ZrAlxEwmCkxb9yX3Xgr145dyBExXoHVyvzokArYFbrWUpjBeOtdWZnRnT1i8k61xEibCgePhBXAWXANvrhoguwBBxVDwCm43oN9PP8KpHR/ezm3St5iyojiJn67VR239LI91RF1q/+TIEX8kRJzdfZBvV3Z/8Vww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8pF8QoyeW8SoNhfIv4dgfaNxj6MxM2G5WRPmaYL3rM=;
 b=quuqjDUSWGFhHjpswXRSr4ohFLThDaSC3smBIFRy8JucpDRDBsWuDa6eQwRCW8c95RfBWAUDCDsejTg/jDBbBwSbMpK2kWr1NYXLRv92q9BS4pVJuH+6RbnvmeUC44k3hiDechG+kfYu86jqv9vC4tJXsehHUsOPakwIwvQWgW4=
Received: from AM6P192CA0107.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:8d::48)
 by AS8PR06MB8244.eurprd06.prod.outlook.com (2603:10a6:20b:349::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15; Thu, 17 Feb
 2022 06:27:09 +0000
Received: from AM5EUR02FT043.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:209:8d:cafe::bc) by AM6P192CA0107.outlook.office365.com
 (2603:10a6:209:8d::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Thu, 17 Feb 2022 06:27:09 +0000
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
Subject: [PATCH V2 1/5] dt-bindings: iio: accel: sca3300: Document murata,scl3300
Date:   Thu, 17 Feb 2022 06:27:01 +0000
Message-Id: <20220217062705.2867149-2-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220217062705.2867149-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220217062705.2867149-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b81072c9-e360-42b1-ca01-08d9f1de86dc
X-MS-TrafficTypeDiagnostic: AS8PR06MB8244:EE_
X-Microsoft-Antispam-PRVS: <AS8PR06MB82444D6779C15A749FF63CF8D7369@AS8PR06MB8244.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7aTl8bP1hZ39D0RNdIOoWJY/O0MQ6zaD3nPKKwdzadAG/veQ16LQL7PHCCBOo6Pw1cAnujYWnheeCZ5asCS+oXNOQ/3LIdSv3GbDHFwP8RyQyrs3Mxc4T6TB6U3rPLp27waIgT0p2Vdhc1X2T11PGVy4vWobCLv9H+hw6R+Sn9QJ+4EEBtsOxNuvocWUtTu/0fNfNE4U+rflbJ4/ra2/O3+wCrr+9VKQYGaemPb3ONn/iRKzCxu8eun1Qui4iosN7ZkBpgNsdddRlsa1lZtlmQCcI4aUVQwhyuu4kn42cPTGHxR0D+mDwgK+bDkeKqTW/fvDLoflnKsQ44PRRfM6GSfeyM05wJJf3cC0Hfw2vz5vXg1vEsE89C+dRKG5xJgUUlPiuIB0UPm2zMOnBlB+7xPBFo6GSjp60GUsuh8I1Tp7IOsRkIZmJCwQQ7OXgjxgsShC7gxLI/nsx14JjawRD5y5u3BE9DmWM2RGbVFS5oifb8aS0QjFBMcktGnQiw/cfM30IRMx04eN+4jvNzt59L/N5MqX0NZRBhk7KsAvrsQ3iESn7E0cFle4pk9fG5vJtFsVMavb3dGlBKcAnWgCmnzvBHKu+Mgta265VXgDo/aL5fEzMTWFIHVogtaeapW2PdOGUyLA9SatPBD7GmpwM2yCR6KgVqwtr3iTvwYqHDtuduj7l4tLdyICNDZPWTmx
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(6512007)(86362001)(6506007)(36756003)(47076005)(36736006)(6666004)(186003)(316002)(107886003)(8676002)(4326008)(82310400004)(70586007)(70206006)(40460700003)(118246002)(4744005)(26005)(8936002)(336012)(1076003)(956004)(36860700001)(81166007)(508600001)(6486002)(2616005)(356005)(2906002)(5660300002);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 06:27:09.4735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b81072c9-e360-42b1-ca01-08d9f1de86dc
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT043.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB8244
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings for Murata scl3300 inclinometer.

Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 Documentation/devicetree/bindings/iio/accel/murata,sca3300.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/murata,sca3300.yaml b/Documentation/devicetree/bindings/iio/accel/murata,sca3300.yaml
index 55fd3548e3b6..f6e2a16a710b 100644
--- a/Documentation/devicetree/bindings/iio/accel/murata,sca3300.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/murata,sca3300.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     enum:
       - murata,sca3300
+      - murata,scl3300
 
   reg:
     maxItems: 1
-- 
2.25.1

