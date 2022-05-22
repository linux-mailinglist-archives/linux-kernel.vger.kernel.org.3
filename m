Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736E8530177
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 09:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344627AbiEVHEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 03:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiEVHE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 03:04:28 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00139.outbound.protection.outlook.com [40.107.0.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F84286C7;
        Sun, 22 May 2022 00:04:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGwuM7GmtQgFp4XQ/zHNva8WvC61BTbaITMtadUcrnnOZ17Re/Rn2winrLnHBp33rKEUrL/6l/EYDVCKzfBpv376rqBmkKC7105tEXnoKFLZd2RujE2F0PNNFvZl7jQ1P7qwIROJHtF8GjREhEIPuY3e77i5OS2RH28+aqMcRQhTNZEC6P+uliO0NPwmiuKeLnZ08EMAMBa5IbZjuMtftxks2C7SFZrsBRA2QLwAtFkootzyKnyyGKuAtW/Lzl+DJZrqNLH1wKad3bzCdTQCkQngJehYk69O3VkST/nfvy8YOtzrSmfw1M+hv9qjcT4qEfxKbedyvEAle/kmMPm8fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ekwVoXx/+aYjX3KlJSJLf75Avjb5+QFhAMoKN3Z/Tw=;
 b=jATPmFF4ipOytSWvhrNuADYggGS2jXU1F63EeKRCmD8trgYybEm121M6wqzsksBxwsKCfroVVnbJBiqKXw8NBT6hDlUvsr/cHFMSGnuPnAadSGqpzMH1CUm+KnuEGIxeyZW+z6T6qnLMLsWWlD9iwqtMXQMslr4xsiLdZ6uyxvn3/Wajbp0MH7yGvq03uitl55GYagd1KGIUqLnHCnw/mBIAZIzTG8ciM4cR59cyNz8chA+pAy3tOxUAGyo1iow9+b5J6hyJOXykfUmAZXdbhdEzu6pgAKsi2brHkIhGCMidV8QRcYQNWzdiCYjpnfechqj9WT2P0fVw5VuBxs5xiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ekwVoXx/+aYjX3KlJSJLf75Avjb5+QFhAMoKN3Z/Tw=;
 b=wkLjGWu7TWW3mjwUJANnOkGluvGzDgB7eZpXIa+i0RGzvYlhv88Xfv1FA1litN7RZaLtdsOdo9ZOLFARBHJo9k3mhqZAM2Rsa/d5lvzBiEwArvVlkg87FC1T+DVgn1x4rdZ0tQjyrqmoI4uO6ZKRr+7efr59/+zoXbcEVetOexg=
Received: from AM0PR10CA0125.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::42)
 by AM6PR06MB5779.eurprd06.prod.outlook.com (2603:10a6:20b:57::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.19; Sun, 22 May
 2022 07:04:24 +0000
Received: from VE1EUR02FT008.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:208:e6:cafe::95) by AM0PR10CA0125.outlook.office365.com
 (2603:10a6:208:e6::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15 via Frontend
 Transport; Sun, 22 May 2022 07:04:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com; pr=C
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 VE1EUR02FT008.mail.protection.outlook.com (10.152.12.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14 via Frontend Transport; Sun, 22 May 2022 07:04:23 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        tomas.melin@vaisala.com, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qing-wu.Li@leica-geosystems.com.cn
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH V7 1/5] dt-bindings: iio: accel: sca3300: Document murata,scl3300
Date:   Sun, 22 May 2022 07:04:15 +0000
Message-Id: <20220522070419.409556-2-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220522070419.409556-1-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220522070419.409556-1-Qing-wu.Li@leica-geosystems.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 25e00752-aef3-4620-73ec-08da3bc14d47
X-MS-TrafficTypeDiagnostic: AM6PR06MB5779:EE_
X-Microsoft-Antispam-PRVS: <AM6PR06MB5779458EA29D1CE59CA864C5D7D59@AM6PR06MB5779.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sr2Jw48TPcDh2VrVOPKZlZwYb+nzDj1zesxsD/KwdQ9D6BDpCISjqwj0ozuBwpzHmhQsu+7d7bNIN+OaDHBzIVYhRkTFOnP5MGH21SgXlXc5/Yre1P1Qmm561adUudzvb6htVcd8s8zdVcZ66LWCI3I6ZY98FHShJvrLkcGTQC+b4h/mf0iE5SCnZ03Lqy6ZncYTKa+6oZgmWylqDD067hWofobmrdPyuZ1UhS9UUiwpIwGBTzo2XZ5EW9CFqEe3fpQ7MTB1xEm3O3kbVpaoqj/XO6OBmdTRXAGyTviZw2ofBmPSazw8orclfH7ZTr48I+8Q5/z0ZQ3ZPlarT6JasO69s8pJtXBzRcAPWnLIyPCB3JQjIg4lOy/q+HVmobVIDy4e5qoMFATwLZ/IlLpZV9N4HeWlXQmgspbNl2OPmpdrLSYNAKFoylGOdr7M04TIqksgNtdjcI4EHLsgzmSkyVFjZj9noNeczwifBUg7Z2vGqS/TBKDiWMuar8hIrKb/2np0lHjd/XiSQyiJ80GDyH8ZS+bjkUNhOFvnBIPjDWGK8d9VTeQ/Qk+ds2jNtq+PtIFgD13+hj2FM3s/qjph7EBq18irnQd99ZIwsq2G9AJRJKlVXOUrU2wRDso1HxVvv0cUf9jdqMHZ4LdqE9cJGymDBli7JfvgKKrZONMA3MaD+hKQE0+3n181YEikMPnA
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2906002)(47076005)(956004)(336012)(186003)(1076003)(2616005)(36860700001)(86362001)(82310400005)(6506007)(26005)(6666004)(36756003)(5660300002)(8676002)(4326008)(70586007)(70206006)(4744005)(36736006)(6486002)(81166007)(316002)(6512007)(118246002)(356005)(508600001)(8936002)(40460700003);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2022 07:04:23.5258
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e00752-aef3-4620-73ec-08da3bc14d47
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT008.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR06MB5779
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

