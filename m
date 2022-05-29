Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27DCA536FF6
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 08:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiE2GTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 02:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiE2GTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 02:19:05 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60137.outbound.protection.outlook.com [40.107.6.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5499D6C0DD;
        Sat, 28 May 2022 23:19:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmHxASxSaaRCXsJdXhyRg3woEUD8hTVg/KrB6zriXAhumiHvPITFujl9cen/t1P24FgAOfkKpHoXGzNbGJb9Zf6M2Nf611/aZb6m0pxpIP+oyjk+p7XpGBV5T90mOgTpLgT5lhsqNdDss9A+ibR9Jx1tsSe20K56jUcmI57q/xqX/iDZQk9mBFnn8OR/4rbSLNXI+ml2NFiK+jDlXQjkYrKc3KT8zFRGOhHRujqma1MWrfl12oAurgMWEAJvSBl2ZABvOQ7pb25w2mq95eI1mTrJecG3oCjwrRiQnnOMM1dS0PnXBz6mUVRjYUch88HmcG1Cqiqjp+AQuQ3MMKJBTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ekwVoXx/+aYjX3KlJSJLf75Avjb5+QFhAMoKN3Z/Tw=;
 b=RMYwbmn5xzdoS/dyoWr8dgeR46c8lgLj1ksZgCQzJwKU8OTMCN5qEHzOkW+cGyRBY5tjqMiU84gqPubN2SunXqDcT8ib4Tm9Ssab7LLoNwHfQrCukMG2HL5vDeYEfRcx2LIwZgJrwBYwCA3a44qQsDtFyCELWsipLlT+z6aLwQdgn6OIe4YKHozughTE5m2aIfD9Tw9ttANfdBls85PVv1G7rw1qdjDcUdyNzlMrUPi768MJ4g461o7sze17ocK4vs5pdA+566GewHpRpOtwhPxEW0vNLldwySlgS9UVM0um03hB/fzSc2cnFRE8jp8NgV1/O4LlB/IGqgwXwCq2lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ekwVoXx/+aYjX3KlJSJLf75Avjb5+QFhAMoKN3Z/Tw=;
 b=w23Z0qXWqYGwJhugbE/WpFtDK0J61kdpvNFlztqkehNa+4LG30qycZ//hvdhmYdkBPMJDD4WiqCM9MeXMCPMPOlaxB6Szvo0BTyYOSI5ZpPXfmAgD0YoRB5T6/fc5WzcXVNJsCKgTsRyRN/bK2OP5+pH4u8cs99KzTPL8jxrPts=
Received: from AS9P250CA0016.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:532::26)
 by AM5PR06MB2995.eurprd06.prod.outlook.com (2603:10a6:206:b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.18; Sun, 29 May
 2022 06:18:58 +0000
Received: from VE1EUR02FT016.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:532:cafe::d9) by AS9P250CA0016.outlook.office365.com
 (2603:10a6:20b:532::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.18 via Frontend
 Transport; Sun, 29 May 2022 06:18:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com; pr=C
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 VE1EUR02FT016.mail.protection.outlook.com (10.152.12.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13 via Frontend Transport; Sun, 29 May 2022 06:18:57 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        tomas.melin@vaisala.com, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qing-wu.Li@leica-geosystems.com.cn,
        thomas.haemmerle@leica-geosystems.com
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH V9 1/5] dt-bindings: iio: accel: sca3300: Document murata,scl3300
Date:   Sun, 29 May 2022 06:18:49 +0000
Message-Id: <20220529061853.3044893-2-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220529061853.3044893-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220529061853.3044893-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 282bcb18-bdbf-4d43-c608-08da413b1d67
X-MS-TrafficTypeDiagnostic: AM5PR06MB2995:EE_
X-Microsoft-Antispam-PRVS: <AM5PR06MB2995DBF6A63E8A6D8DC83A6AD7DA9@AM5PR06MB2995.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jy7CfKVKRpy/7kTZ1nHWyNCmOFOBwxf1utWg1wBz49R5UsY7DVUdGCL9UuJo0JDXWgbjpWebnC9ZhZyUSZv1JfLWzfdh/vGAJVdn34OTU2vFi2Z8AGtPh6rfMS1fDTtiyakxxljpuHREuYI3Sg3KVIkKWT97D1gLjZWn0quwHEmw0xz4fQzYWOAbqLpB8/1C3RIMjKCOA8wM1dmOjRT34FBGx9mIUWNDBRCvmODt6d0d08R6wa3/eqMvUtODGwC8AZ3N1OokWoVbnP6dQDEb8QwKRv3y6GqDQlDd6dX5z1q8ZAjE3jHz7ObOv2J1UkKGefsZ4rd8he5ivz+KK59pXMHv3LRNj0anquVfdqNHnxUtZcZW5wmp/mraS5o9ptfaNl08chV1Mt4AuVnc7rNyhCjmZZE/9wgVvB95ZjfjZxKkogh45IS8O/roXjrQWzy4YgM65vLgEYqKJalLZlYGiFrVePTQ60nXkZBZgyD3IbaK4GAbPY0SIH7RT6yTf6OS3jQnJJDt/3C7FGuCzoRdRlXh270uwWZ0d5ejpDC9vIFot0NQZaO9tuteQBn98MIHG4V6SaukdcAkwtBIGrIVxZEc9iKnEaFkrnWSDiClpby198XcZCM4Aa4MhKZ656swXkU+dWtJzCn2fDSEjNs/BMvus5M19H0IuVnAb2aUj57/pmZN3fuY8d93lp2yGDFY
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(5660300002)(6486002)(86362001)(6512007)(508600001)(26005)(2616005)(1076003)(956004)(8936002)(118246002)(40460700003)(6666004)(2906002)(4744005)(6506007)(186003)(47076005)(336012)(4326008)(8676002)(70586007)(70206006)(82310400005)(316002)(36736006)(36756003)(81166007)(36860700001)(356005);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2022 06:18:57.6062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 282bcb18-bdbf-4d43-c608-08da413b1d67
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT016.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR06MB2995
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

