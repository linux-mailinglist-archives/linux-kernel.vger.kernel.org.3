Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4434C2310
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 05:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiBXEgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 23:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiBXEgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 23:36:52 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43BE234018;
        Wed, 23 Feb 2022 20:36:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iaRsni/1GcoyMpMJU6gm0MBYzznZj5QKYeesk+OdZ7IJmeNBX2uEQFqgdR8bIrlYlbgTcXrPQQCFWp3dsJ54I/clFH5MYEilbfQW+UxSdbBhHooFYge7fqxMLtAYkAz6t0D53y3fEXJ6qSjl7JvhTJMgPGPSeh0cO+n1gmie2UCc4vl6heVZlFWxwgAS6/ZliDb2z0PdLQAXUqV8thttxtYDY+nR01idRnI1lkB0GHsClW0lznLE6rcjjhZ+UGl+/zVGXbZyypHZ/C8PLbw0i8Yr76PDKY6yjKKfoeh+iYdFgNys4U6JKsykEy005HoGLPesk0OQz4ZxC1MEEZsWZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/TsG39ipZGQYE+i3brsg2EuK9nBdqvOCuFZLHIBUjc=;
 b=G3NC0tn75uI1lKlpiJXAO5EZXBmGnlCS1fvcNbzjeW5OnzFhHfEE6N3QZw5H668XUFuWW7AfkvBHvR2wEXa+53rdAhua2ZApfdP2mbItoU/i5ZfuGtFB48aqVc6sSSSrkUF4bWxmCHoszfggvDLcdztCJ/mHGhetPlKvroDfzTVEy31J3JxQyBk4g0glMk5/xNO5Nz2OAoN3XVgPow4Gz/hmnGseeJ1Y+p6wqRZuCTirobSlD+09UgSzTsiY4TzuMJClbEGd5k2DPMywKYafpVnLUtprC3Ruxw0OzSq2vRt1tGQztnHiJT710PnXpat/6Wbv+LdSuvYbPWX2sDIfmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/TsG39ipZGQYE+i3brsg2EuK9nBdqvOCuFZLHIBUjc=;
 b=pTZUWs32rBfdOpHlQ6UqUZcd3xEbxK/rPTPRPzXxKTY5wD/0N1hPE8dpq/9YrQ11QG8ZKmsQQ9donjqRAyXf6P9pqwHDNIwLZh6tfUPXOCBnrJHeXXT+91z6Pb3FQx11JissE0Rj+7ZRNqKZmLLiKDJu3Q9RSrPzHAs4WSQaYcU=
Received: from SA0PR11CA0173.namprd11.prod.outlook.com (2603:10b6:806:1bb::28)
 by CH2PR02MB6613.namprd02.prod.outlook.com (2603:10b6:610:79::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Thu, 24 Feb
 2022 04:36:20 +0000
Received: from SN1NAM02FT0064.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:1bb:cafe::4c) by SA0PR11CA0173.outlook.office365.com
 (2603:10b6:806:1bb::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23 via Frontend
 Transport; Thu, 24 Feb 2022 04:36:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0064.mail.protection.outlook.com (10.97.4.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Thu, 24 Feb 2022 04:36:20 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 23 Feb 2022 20:36:17 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 23 Feb 2022 20:36:17 -0800
Envelope-to: git@xilinx.com,
 linus.walleij@linaro.org,
 linux-gpio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Received: from [172.23.66.193] (port=35678 helo=xhdsneeli40u.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <srinivas.neeli@xilinx.com>)
        id 1nN5rU-0000M4-W1; Wed, 23 Feb 2022 20:36:17 -0800
From:   Srinivas Neeli <srinivas.neeli@xilinx.com>
To:     <linus.walleij@linaro.org>, <michal.simek@xilinx.com>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <shubhrajyoti.datta@xilinx.com>
CC:     <git@xilinx.com>, <sgoud@xilinx.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>
Subject: [PATCH] pinctrl: zynq: use module_platform_driver to simplify the code
Date:   Thu, 24 Feb 2022 10:06:05 +0530
Message-ID: <20220224043605.26157-1-srinivas.neeli@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fd542b0-a4b8-4be9-2617-08d9f74f348a
X-MS-TrafficTypeDiagnostic: CH2PR02MB6613:EE_
X-Microsoft-Antispam-PRVS: <CH2PR02MB66130D5B09FC0A651F24C1D7AF3D9@CH2PR02MB6613.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WxSqL4eDoKqB1mpmtSLeUxMhmFsyaqhaXfFXOYPOFHoaeOCQxf50vASChRpUCAKnoGv39cq7BGFbyslllGW7M9Iv8VJr2v3Hzgn5gyTlJRJ4YIG+Mu27XyrI/eIYODSqmsuWKPO08kE34GVV4H1kvWtCzPI6eWC8X56OeKB7uGk8uj8VQbP6vo3S+LkqBfuu6/fqd8hPQiuYkQu7ZCVqvtGHPKQVq9cyodvnOhzpxNZeMWGLKdiYSY6eSRVm/bEe0oqFI4nxuKyga6T4lDmecP0/xant8khG2mkXPmi0w2w6bhumxJYIgBI0z0thZzkmPIyLDgLk5a60Cs2siSk4ry+h78J46bUVW3cCtIBi23yhDCevKsQjt1UT1fN0rzmMy6yjDswqETfholo6P9PZxfNMYEvGps+tCh1YJF96GAGQuA+mXU/vTnb07cqTFN305ym1z+4FXL/V3fVPHkRw6AG4NjTnQsge8VvzjOrq4Dpc/j2E4/K3t4mtm1t3Y1DgHTcpXSs8WIH35wHpt5+p++1fdYkktdnHkut6usAP0zliAUzpi+WOed5f3pkWAh2bhRRgqyMuVd/UYp72ENUBr59bOprc7KKuwgzJ1WZnIloFWXjZiO5+Hi9ZpWv5fLAbBaoGkmU0N+LTbrqNdTe3IqA9YfVvMn4UutyIlUX3js+udaI50ykhSueLmYyhOU6v/6kxdCXliTbzuUHd6f9/zikiwWaVVOIYm9O6rDXSIGo=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(54906003)(6636002)(40460700003)(83380400001)(110136005)(36860700001)(47076005)(316002)(7636003)(9786002)(8676002)(1076003)(5660300002)(70586007)(426003)(336012)(6666004)(36756003)(4326008)(186003)(107886003)(26005)(7696005)(2616005)(508600001)(82310400004)(356005)(8936002)(44832011)(70206006)(4744005)(2906002)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 04:36:20.4800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd542b0-a4b8-4be9-2617-08d9f74f348a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0064.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6613
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

module_platform_driver() makes the code simpler by eliminating
boilerplate code.

Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
---
 drivers/pinctrl/pinctrl-zynq.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-zynq.c b/drivers/pinctrl/pinctrl-zynq.c
index a96af8a76a7a..0e8de27d0de8 100644
--- a/drivers/pinctrl/pinctrl-zynq.c
+++ b/drivers/pinctrl/pinctrl-zynq.c
@@ -8,6 +8,7 @@
  */
 #include <linux/io.h>
 #include <linux/mfd/syscon.h>
+#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -1210,8 +1211,4 @@ static struct platform_driver zynq_pinctrl_driver = {
 	.probe = zynq_pinctrl_probe,
 };
 
-static int __init zynq_pinctrl_init(void)
-{
-	return platform_driver_register(&zynq_pinctrl_driver);
-}
-arch_initcall(zynq_pinctrl_init);
+module_platform_driver(zynq_pinctrl_driver);
-- 
2.17.1

