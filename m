Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B6E51A104
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 15:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350656AbiEDNkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 09:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237418AbiEDNkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 09:40:07 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30105.outbound.protection.outlook.com [40.107.3.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7768923BE9;
        Wed,  4 May 2022 06:36:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwVxqwhDBji3xX6TAbAYM+7K+2tTgcVMPtF74Wz4WnCls0XY4KnR4VuFFaLz4LzofYy9wH1SBEY4xwyAd6UuAhhsJNdj6mRF05eWWwtAfe/Cp0NV6a8xE15pDZs6qlDQG9T4aDcL8qWCGNEpr8mKSWpxcDUMz2WnOIHqCW4js3p6i+GF48vEbCs9u9c52l3biRlDIPymidNsovYgoRzBXUvGpoD3eZr7II1G8byZe1WMiFws1B28aQk9r09fGz8qZeu6Ff1lcX2I++5/qNUe1RYBmRAj9XF+0p2s4bAVK5ovQ4VnGLqkzsWzKHr29uXRp0y4Qb03JcogFArC+t852g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYKSHwURzhuyVCQ1gP8JGPV0Vq//cdhPy0rFDO7w1Ks=;
 b=Iq9yIrEt8EX/dGPc0KtzMvoC3//CxNUyMNJ4SKy2asL5BYwEdqdTIJc5R/Kfb7FIZtR7hckYoP7aB9lJpLLv/jC25Ot5rWGKqlvHXL6t7rPceaYHTRJpTsv7+kWITKGWZ94iYbMKNzTIuDzfnjZH115BALEWl+1Ex8yotcCVvnV2nxSDNUQYrMuL4xZuyHc/2IfEKRDT0T1jntlpAMFVli/9eefC5H8xwSShWYxK9uVvKXzyjbIYTgcV2Bsl8ygknNImHcwhFXmWCFunoPCp9JO/+VroO0mI0NsP+lJ4DKntngE38MnJlurYr+8hOPqAHM19ADmMwzDHHP++QhfZHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYKSHwURzhuyVCQ1gP8JGPV0Vq//cdhPy0rFDO7w1Ks=;
 b=AqwdqcWEcMKNEkB7dIUjB2PODZM5vf63LzLIqT9JTZLAswKSRNQTx/I9EvVe1CvB8HBaphwSRT1g6JWJ95kgCfmCmdnyw56DhoOKv52R77G5B74PCu/CJ8jvRwRIXCDyVWrZIx2bGM/eR8YjJeoWSPBFIxsIyJ89aVhCZxVefdY=
Received: from AM6PR01CA0072.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::49) by DB6PR0601MB2246.eurprd06.prod.outlook.com
 (2603:10a6:4:1c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Wed, 4 May
 2022 13:36:28 +0000
Received: from VE1EUR02FT101.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:e0:cafe::aa) by AM6PR01CA0072.outlook.office365.com
 (2603:10a6:20b:e0::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Wed, 4 May 2022 13:36:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 VE1EUR02FT101.mail.protection.outlook.com (10.152.13.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.15 via Frontend Transport; Wed, 4 May 2022 13:36:28 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        tomas.melin@vaisala.com, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qing-wu.Li@leica-geosystems.com.cn
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH V3 1/5] dt-bindings: iio: accel: sca3300: Document murata,scl3300
Date:   Wed,  4 May 2022 13:36:08 +0000
Message-Id: <20220504133612.604304-2-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220504133612.604304-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220504133612.604304-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 447b2e6f-5460-45d2-ab7a-08da2dd317b4
X-MS-TrafficTypeDiagnostic: DB6PR0601MB2246:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0601MB2246E414EDB69464AF1D5680D7C39@DB6PR0601MB2246.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wzCPpdrWpIHDEBlZn5iUYtbBoS87ZiisUlkRBOzBT6XRzjeE6qNXj8GFSsvr+xTj54oMWY0ex8nFB7hfHOKD2lQdxHo9OxkoN+Zf7hTHu/9GQrGomRm208qcTw7973bFhDpCIPPTr4+96+IArsem6y/CNIWqlk9M9qK0N0euZB8U4RbujsU5IdOBChp7P9+vsVT2qsg0kJ/FNpFkmICc58D5uYDb1ouu5b1DhGT8eSK1rxMTqC5/bhvFWaRpiTfbcTJRrKIN9YkItaerYw8LNOw0R1YMGY2miGZJY/YWa5vy9HNBS48g7AHRl+pEYbusLXk86aKFxd957NsojjQg2hmnaa2HLjU0AHkgdJkGnwzWCJctH5td8MOgQ3Ds7h73BV5qxvVXPtHXGOIDO/OC1HC0IxrcyCLbRF8CVYJ0lewkLZ0LKlIQr/alezdFu8JKYkqXDilhFfXNFTDwMviy5vfa8syJ/CTUJIUrDYONK97wXRecWqsWEopWyD+26g0B2Ll82WRKqEDxPzHW6b6tK92xnzxIRe5zNzTuWGB6+k5sWsDlLegN1jkShgtjoxosTEpyWQ3XuPdpeGWOsu5k/qDzWf75VuEyyqpibd46eX7ua8nU8ncqjilGXImO0FrxGERK/xKtvGntMxtRczWmTqqdhijemNme3rWFF3AAH1RjGqJc4jXC4Zo5OBVRwe3V
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36736006)(70586007)(6506007)(508600001)(5660300002)(4744005)(316002)(6486002)(86362001)(4326008)(356005)(8676002)(70206006)(81166007)(8936002)(6666004)(36756003)(956004)(2616005)(186003)(40460700003)(1076003)(47076005)(336012)(82310400005)(36860700001)(2906002)(6512007)(26005)(118246002);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 13:36:28.3068
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 447b2e6f-5460-45d2-ab7a-08da2dd317b4
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT101.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0601MB2246
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

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Jonathan Cameron <jic23@kernel.org>
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

