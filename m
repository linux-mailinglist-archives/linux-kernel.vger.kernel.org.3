Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDEC85139F8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 18:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350115AbiD1QkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 12:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350108AbiD1QkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 12:40:14 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2070.outbound.protection.outlook.com [40.107.101.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D9CB1A8A;
        Thu, 28 Apr 2022 09:37:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5CRVYVJuu6Q3ImLDWKdnc304k/N6cfbPGzyIf+9AzGWBZbDWHA67HPZfO/RXkTdWZapFHJCbgBxXnLVM7YBotL6wlgIgKJR03ViCglALeTgvNaPJIixxstljC8tLPaSNAQcOyWDCthoquHsOCuKZ2/YOEYQh0nIL2v1pyRt0R8Qlw0+OwoYBuxVfG7RSNHwAE99w25hiuXa2kCN9qvc7knvItGyEvOy3iGbfe+SerMeS9RX2BMJfKztpc98qIKse358VZm21GImhOyB/JtZLvOs0BtJQxQP9YGPZzMeuEOiw2/h6YvbArLItBuZ8okH8ERRsp5rf+wPgjzFO/bCgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQBHqytcmqj0KrnGwazj8MmtPhTGGTqgbOeevzgfWiQ=;
 b=QhRgWxaxQvJFXNK7OXnAok+xheh9pLfNxIwDouhKVUH0jqjCF3Ew/iGJHG2mGAVm6f1SK+LDOXq5H7Opnnw78mGSRC7Uq9PC6JGHnHL+/vv5L9wTqibQXsN3ucdg854izrB0gjshFjHpXc8PSTYiinNUta08GaRDoe20OXf6xYgKe+NiYYyesS//njyRk7yK/p73Zo5IqL6hdv5lIjIE+JSwd/jkdhu16NdhyHh6b2xVzsxWTiVHomJf0xndG842DmEdJOJAC8owqTthrZEMr/dFvKRVbrIkhsIzR7seRymTHhGvYDwqgUviCmc6KTvnOaYIQEJQSNl7HBTJzhf4ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=bgdev.pl smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQBHqytcmqj0KrnGwazj8MmtPhTGGTqgbOeevzgfWiQ=;
 b=DxQQt8/7X8+D8AHnhDAtgnwSwPuYmkVv7YtLUJFL3KGAoTgRbht4oGnF354M3weyOqyZQtHgiANsOO93oHOL6Mn61qBwLNnJ1U+qDl1ukbhdOwjYYc5O2HYKrn/DfM5OHOQkMqxFqbFBpwdsmi10O3L14mzq785NZKOqyYH6HUA=
Received: from SN4PR0501CA0129.namprd05.prod.outlook.com
 (2603:10b6:803:42::46) by BYAPR02MB4373.namprd02.prod.outlook.com
 (2603:10b6:a03:12::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Thu, 28 Apr
 2022 16:36:57 +0000
Received: from SN1NAM02FT0015.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:42:cafe::1) by SN4PR0501CA0129.outlook.office365.com
 (2603:10b6:803:42::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.6 via Frontend
 Transport; Thu, 28 Apr 2022 16:36:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0015.mail.protection.outlook.com (10.97.5.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 16:36:57 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 28 Apr 2022 09:36:41 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 28 Apr 2022 09:36:41 -0700
Envelope-to: git@xilinx.com,
 brgl@bgdev.pl,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 linus.walleij@linaro.org,
 devicetree@vger.kernel.org,
 linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.23.64.6] (port=50319 helo=xhdvnc106.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1nk78D-000CCM-Hk; Thu, 28 Apr 2022 09:36:41 -0700
Received: by xhdvnc106.xilinx.com (Postfix, from userid 13245)
        id BD5726052A; Thu, 28 Apr 2022 22:06:40 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <shubhrajyoti.datta@xilinx.com>, <linus.walleij@linaro.org>,
        <brgl@bgdev.pl>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH] dt-bindings: gpio: zynq: Add all the supported compatibles
Date:   Thu, 28 Apr 2022 22:06:38 +0530
Message-ID: <1651163798-15123-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f62ceb3c-81b6-47de-c30f-08da29354ff3
X-MS-TrafficTypeDiagnostic: BYAPR02MB4373:EE_
X-Microsoft-Antispam-PRVS: <BYAPR02MB437396785DB863B4E717F6E3C7FD9@BYAPR02MB4373.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B3pRiqO/tGhseZvdArhrpSPfNORpZ4OjGH+qxKTkCIxxCx9YNmZaLI5bNgY+j75+CG/Gi+B4CVVEtthNqLs4OR5insUpNMD7jqZRMdkFdpvtXHFHMqadLg7+MXE0B4Eh3S9SS1vRGBj7QPuwWG7TGVSbRXH/tZwR4UUSrBoluRddBGzYcWy8Ven86Zdj0m84mrth6VpTdqN9MN/JPQtZOqE0tbIjpDdyTopmKOm5vmh45B7maT6Z996Wme+7swPBZ4f8wvfseotvhdcqTVjVdRNS5bi15IWyQJzt7JyNz1mpXMAjQHriguahBD4bzqwN0jGhKQHV9Kok9/CmHq0L7NeVkjn62iPitn/V6o2Yibt4Tx+/T/SzBY7q0GBqN0i3Si4TCTABMaHpc4Jn9fsskRLm43pHoo35R+rQJXkgn+6/84C4sZZ7/cI3DTcemaA/dfiEbyAsfUneW4HpqHsWtVytKZUaocY7CauUD6ImSpH+e/kKqyD98nvIVaFMjpTb3fX2psjInbw+KFnU9S3S8LpzeVicBpgUJ6ikoJTLOrbyWmASvbVyKCBdiEHdYPNqPPh5tInJ8/7ZDmtlb3sXixU5DM6ApRZHuPZb2d4sGmppU+el5IJ3arCUrPS0Q/zLZeCWLowDjARUvMfm7RGszCDhFmNolF+0oDgDCbBfWA4m+8TmXcMQ6Xw5L4x0HVDMGrz1e86snD36YlbdTz/tMx+NgGSkyaLlJt1egzD1EP/syfb38sIzxQPYt8yqcpegguFqZEibLX1lg58w+hgx1MrYA/AFg9cmG7qgKa5J8dw=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(8936002)(2906002)(40460700003)(36860700001)(54906003)(110136005)(107886003)(2616005)(7636003)(8676002)(4326008)(70586007)(70206006)(356005)(186003)(316002)(42186006)(82310400005)(26005)(5660300002)(508600001)(83380400001)(6266002)(966005)(336012)(36756003)(47076005)(426003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 16:36:57.6946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f62ceb3c-81b6-47de-c30f-08da29354ff3
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0015.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4373
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Add the compatibles for zynqmp, versal and platform management controller
nodes.

Fixes: 45ca16072b70 ("dt-bindings: gpio: zynq: convert bindings to YAML")
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
NOTE- There is 'gpio@e000a000: interrupts: [[0], [20], [4]] is too long'
warning coming with upstream yaml. I am checking it on devicetree mailing
list. https://www.spinics.net/lists/devicetree/msg493762.html
---
 Documentation/devicetree/bindings/gpio/gpio-zynq.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-zynq.yaml b/Documentation/devicetree/bindings/gpio/gpio-zynq.yaml
index 378da2649e66..980f92ad9eba 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-zynq.yaml
+++ b/Documentation/devicetree/bindings/gpio/gpio-zynq.yaml
@@ -11,7 +11,11 @@ maintainers:
 
 properties:
   compatible:
-    const: xlnx,zynq-gpio-1.0
+    enum:
+      - xlnx,zynq-gpio-1.0
+      - xlnx,zynqmp-gpio-1.0
+      - xlnx,versal-gpio-1.0
+      - xlnx,pmc-gpio-1.0
 
   reg:
     maxItems: 1
-- 
2.1.1

