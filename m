Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D42F51F4F9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 09:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235512AbiEIHFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 03:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234939AbiEIGxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 02:53:53 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2113.outbound.protection.outlook.com [40.107.22.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1180819CEE0;
        Sun,  8 May 2022 23:49:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ES8i/rcc7O1R8WvDFtmZkhXM4GAn1kFhj/W+Ls9PIqDf/GKZVbPk03IwndXb3FpKI1UkjveLdxUxhMayELnZ/WKoqCBjVZOZkh/ZTlKDBO1dP1M9RqM9qJbaNjvAED3a/OuqcJUJk2AKQvq+clm/TzHEt+F6uBAA3AvA86dcO2zmB+/RwyFc81dipis4bBzyrYnhF4KcPngxAzMHqF/yodqvoletBuA1VxrX1R9p6c+DgYH174WU2UcBE83SsaKqQRWL9u8YilYYgsqLZ1RfgULb6Nhx7miKgr1Ms80rWCjEVmmqHgJfOsUvUdwaDz8bbSJ8zEgOXF2aWHIQFI/1vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8pF8QoyeW8SoNhfIv4dgfaNxj6MxM2G5WRPmaYL3rM=;
 b=WQo6u0j0F/vJjfdTXG5C8fTMmomE3Dl4gc+WLcIDRfnwfR+a5V8KtYbgzapt98XUuL4EeCr5K/k9XjXjISSgPpAckv7vWisQp9sDRXsE+G8W73lwms9Cwr0tr3kspAMYXYv1YrScU529udtABgTJaR0YsmZKrougv3lCRvGp+nmEV/pWf7s1TiziS9FsNlx9hKn93OHz1ggu1L8fPiSza61y9HuWCNEG0nBa8aG92ZveY/Uofal17zbH6ltGkRdapnVfcRJl1CbhMqQM4VpdoB4uUg0Sg5EAS4aafgh6qw1h8PzXiKPjxmqG7HPt8MoLHIeNOhsC+c3gjJvC4oSRUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8pF8QoyeW8SoNhfIv4dgfaNxj6MxM2G5WRPmaYL3rM=;
 b=NaHrtsJBte1cnQqqWmuhX7F/JfxanjsLRD3g6rkvRRMg2gfKzyMeEU1u5/VFJmFvVjjISm8NhVDtxoNWoUDTuODFBYu+ExrQCYN+5jrx3Kk/kBPZ8/skOLyKxb7eR2JrJZ39KHGRpR1+n80v6IkIeZvawMcXNdG285Z2je0jc2M=
Received: from BE0P281CA0006.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:a::16) by
 AM6PR06MB5173.eurprd06.prod.outlook.com (2603:10a6:20b:3d::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.18; Mon, 9 May 2022 06:49:33 +0000
Received: from HE1EUR02FT040.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:b10:a:cafe::6) by BE0P281CA0006.outlook.office365.com
 (2603:10a6:b10:a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Mon, 9 May 2022 06:49:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 HE1EUR02FT040.mail.protection.outlook.com (10.152.11.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 06:49:32 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        tomas.melin@vaisala.com, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qing-wu.Li@leica-geosystems.com.cn
Cc:     linux-iio@vger.kernel.org
Subject: [PATCH V4 1/5] dt-bindings: iio: accel: sca3300: Document murata,scl3300
Date:   Mon,  9 May 2022 06:49:24 +0000
Message-Id: <20220509064928.2352796-2-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220509064928.2352796-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220509064928.2352796-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b5ce2242-ef05-448c-d934-08da31881326
X-MS-TrafficTypeDiagnostic: AM6PR06MB5173:EE_
X-Microsoft-Antispam-PRVS: <AM6PR06MB5173EBE8669C550AB049FF15D7C69@AM6PR06MB5173.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p8Hi4mO4GYbAMMPN4l44hGYWgfUFAZldsKoqfmD8nGkg0i39qsPZujVawPV4o5EvoamWf/Cw3Wpd4JmQcHpGCEa0CgdKnuUrZQSHasMzFGvyoWaqJtR0Pz4Uohq93lOOTGD/e6ocSs8BVw2NYedtHgod3mvQI/qLrCfBfcdXdaVOFYjiDBrh8EQms0ODHY1TTrK9M6GOBfEDGap6c4ZFrbriJ2avrzLD9C8biMZk5je9lnAujOOAn5lmik0boIeYqQuyTBIoXW8kVsQYqRdYNH2v29J/ZoPvyv3LE97EqZFKIZpDmLmvqg9NS7Wy3dQk0FjtYwZnMK5AjAw6dgQ7SvuZOrBIH2XZzrA5HkKnz/tGN+a5Kw+wAYiPG6YviNzhCRQth3Y7yX8czcnVaEgQvIzVs/YCUEfZWVJ970BsLOfBtQv4oeF+OYopJsXWTkz+SQbWqMgRqdgaZVK2Ldjt0BL+N6IUzvQIJF6UNonRQXcr9CkW7fE3B5gK4bwBEQq/S3bo+uWD8CkIvsbjzeXKhs9IIInt6WERMja7yOjv3FXsQ1Iw3QxTPBIxxQDfOCpeSKsXxUHac6VywUk2LVGR21z2OqzDyTsI0IjRPp51ud8WROwoiuOxHOZk+Y/uGBBlLCFkXTtnoKsreHCuTfzbxVft4HYTHT7P85TMgxBcx5gisL4qV2Hpe8evoA08cVBr
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36860700001)(6486002)(70586007)(70206006)(118246002)(40460700003)(6666004)(356005)(81166007)(36736006)(508600001)(2906002)(4326008)(82310400005)(86362001)(8676002)(4744005)(6506007)(26005)(186003)(5660300002)(2616005)(316002)(956004)(8936002)(1076003)(47076005)(36756003)(336012)(6512007);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 06:49:32.8129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ce2242-ef05-448c-d934-08da31881326
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT040.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR06MB5173
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

