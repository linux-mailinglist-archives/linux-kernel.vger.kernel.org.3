Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8AD8521D27
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 16:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345314AbiEJO53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 10:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345566AbiEJO4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 10:56:42 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10107.outbound.protection.outlook.com [40.107.1.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B069824F217;
        Tue, 10 May 2022 07:18:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYHwaJTEOFWk0bUhwQH8yt6XYS97wi7ORm6pI2MO1UTgkq1HHta4iiks3n7W4nY2sGhdFO6lCXaCAgnLw6P6wx55xL+6wfZJZe2BYYvD/epHBF9tiPHsQK5LjmRaa9qEqlXfwrMkMuyxvBBNcMJkEHU95+dpAD81/+oxGfa168avWu47DikoohjtUe0TgDB8EFtSmAHkFTGkIbUnx8TEq9eV7IlaEiGtzFbOVD/trdzpqVZZCiHQkaTmZ0PFqAoCSRUmS0GuztMgZQdeIq7CkomcnfY71Ln//32bwOtW2EUfEAEGoUsGeTAXWHNlR4jP7Beg2sCUv7Ukyrm8b1UTMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJDzayEN0JebeyElP0WpVK+TgjcJr8C8bCFTilKbOec=;
 b=lyhn8XXwb6LHu0Q/wmtW39WsEEcdKmWAB/g5sTGYTfNAfvhHnWUg2R2q9aWCM+3V6A4YHSC+LzDeBX4/FJKiZwdUAjpT0tK0CjXBN4QVnoMolsp57fRdXBrA3BkJSuhvAn9pfKcBYoQFc2ite6i25Oizpvu7weUQTFHGiff+qWYHHCym5vTwK/6bdUaHfPA0CH9L2A9Raf4cdhLzpWCCLQgB0KCSr6j71zYHT3kFDkZfiagUELQKn9HlS70GqpkHIDylAdJNpqlJZXTE8j/lt/bj/w1KMLZxSCiVfG41bxc1xrOCb4s/gytS7PFh7+5w7mDHiHhHU7xaXY6V9R6h6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJDzayEN0JebeyElP0WpVK+TgjcJr8C8bCFTilKbOec=;
 b=mB4yPJcQntO8OfCEAvaV+Cw1KyfP6b8Hobab2lyM+Zq1Mua/JRmZDGUqeHn/U+lAE0xwUD/DsscORMAKTuD6jhs3TxuJi1M0dl/PI0R2U/Ft93CmEJo20YZrkBSf9ApBXpan/cw7NIeiusXB6hz2lmsjigzQ2aB0iEu+bvjZbNk=
Received: from AS9PR06CA0339.eurprd06.prod.outlook.com (2603:10a6:20b:466::31)
 by AM5PR0601MB2386.eurprd06.prod.outlook.com (2603:10a6:203:7a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Tue, 10 May
 2022 14:18:00 +0000
Received: from VE1EUR02FT083.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:466:cafe::ce) by AS9PR06CA0339.outlook.office365.com
 (2603:10a6:20b:466::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20 via Frontend
 Transport; Tue, 10 May 2022 14:18:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 VE1EUR02FT083.mail.protection.outlook.com (10.152.13.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 14:18:00 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, mchehab+huawei@kernel.org,
        ardeleanalex@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qing-wu.Li@leica-geosystems.com.cn,
        robh+dt@kernel.org, mike.looijmans@topic.nl,
        devicetree@vger.kernel.org
Subject: [PATCH V2 6/6] dt-bindings: iio: accel: Add bmi085 and bmi090l bindings
Date:   Tue, 10 May 2022 14:17:53 +0000
Message-Id: <20220510141753.3878390-7-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510141753.3878390-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220510141753.3878390-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c88501dd-c103-476e-2722-08da328fe395
X-MS-TrafficTypeDiagnostic: AM5PR0601MB2386:EE_
X-Microsoft-Antispam-PRVS: <AM5PR0601MB2386AB6D6D72020CF309FD9CD7C99@AM5PR0601MB2386.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VZxzpk4d7jDE7nr61ZgsPGIy8tZQj80p5q33WZjzZhBKA0FNanFmOUxasCTW8ZtWJFkdTBPIbIgbPbck4YfwWoL38klwLKSdP1n3gq5rKW/7JBcZpAIX9kCJ1ImbP910VhNyjyU+vji37XB9haq6VBYiGGFm262+HDlVqz4ZNVeFGQrYGl1hsXOWWd6x5yP5vq85jQonLlh/bX5xZdVYlgCKYInPYtFyHNocDUNtZLneEBM+7U/UEERx/ACQ7Vhv/ytILyApFU1t78w/7A1xRLjGBOF5s/04SRSEMwPmQ8Rcjp+XOG1gR71iNMkXj8NE4+gHJUGlaGx5cVLW8IMdV0JefOgDpU9UPXsRtKwR6lrpxax4ICV9W7YET1NhHWSsn0rkMivsM+cYOjREz6o7p59a7eIM4vShNG1wE8J4SJTIJT0+VpVBZncL8Cby1LWo6HGMLR/3E+012WJ1IbB4XTYvawCNYJHU4GwsnHzind8BorSWe/YfyylKQeWnKhL/ZxyWBF9G+vur7ysEXbIhVstjgDM1JiWx2Y7i4BUnf4ZQm2VQDBZktR9iIrLtJXJyyQYNIAz+9f/7UXpbQARxfIrwkL2EEnhqilYsXuSp5ywDf206HfAOcCg/4e5up8dFJ2xkyAkV5JyPfl/5hEsaDomfDkvgCA10Omic+4WmuwpOWrGxOZo6qvgU/pPZJg+I1CLAp1mT+DWgCzgFiD0xZA==
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(1076003)(86362001)(8676002)(70586007)(8936002)(70206006)(36736006)(2616005)(316002)(356005)(6506007)(921005)(26005)(6512007)(956004)(6666004)(81166007)(508600001)(40460700003)(2906002)(47076005)(36756003)(336012)(118246002)(82310400005)(36860700001)(186003)(5660300002)(4744005)(6486002);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 14:18:00.3917
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c88501dd-c103-476e-2722-08da328fe395
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT083.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0601MB2386
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the device-tree bindings for the Bosch
BMI085 and BMI090L IMU, the accelerometer part.

Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
---
 Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
index 911a1ae9c83f..4290f5f88a8f 100644
--- a/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
@@ -18,6 +18,8 @@ properties:
   compatible:
     enum:
       - bosch,bmi088-accel
+      - bosch,bmi085-accel
+      - bosch,bmi090l-accel
 
   reg:
     maxItems: 1
-- 
2.25.1

