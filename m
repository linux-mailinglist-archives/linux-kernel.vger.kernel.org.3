Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E554FB8F3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345067AbiDKKHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345081AbiDKKHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:07:19 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2052.outbound.protection.outlook.com [40.107.102.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301D311A0E;
        Mon, 11 Apr 2022 03:05:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IcNzB7a5q3eHTdciTlH8ZWqaG2/EadfMnYTalzsOEPb1xPMAAss/2Q3KrfGuXUDx2C9pvP8vG6obQ2KYLehfp6sfH3Xk0ckMCMpOZmYQav/WLZArd1mq1WmkTWEiokH8Z/BPyLolhsbn/a8MWvVF8Fq3iOAw6M4LjdD9HVWq9fpLinUgG5WQTkD3Cccf6VAzlIdCTyQqaxC2Qsew6G74BBnv6pXF4ry0u/7vSb4ge3AXa9veXpNYPG0xMhVSwg57HACgFItk4IwHaS3XA9mADOm8WUTbie5GXjNzyA4IhBGEeD+8a2PuSe4QbTgv2wE9bjUTMrtIvEA0FQtfWISsYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sq7ND5bG+mCvLfj1TMM3Zo/onLIFhz4cDByXk4nN0Cc=;
 b=AJ2aSYMq9VPNMdRsyoVBj64ZAorn9BRf8/axY80wRBImIR4FxkEOeWr32CxR+zLkolzeOFg3Mq6y4xq+PWowx5EJt13NOdiESJiRtHgqZQP0XUOGw+iMrwgHzNLaaBi89MCQFEhFnXTbjf8SYWszhysrNnJZWegjNKhn6tS7rYvvG3imE+d5agedZ4Uutdaf8oBFb8UNewtMfVrsXlpHE0QJpnLyr4pRTsgXIptzExu1pfhI3h2OeYPE9fvG/3jrZtKrkKfLnnshaj4ssAh+am8R1EPM8rfb+vKFcULxK9DXf0KfXUEDS8rwKwD8mN+H5o90g45LTjh2dvtX8UAHMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sq7ND5bG+mCvLfj1TMM3Zo/onLIFhz4cDByXk4nN0Cc=;
 b=nchrtgyM54JsuK3iXT94ByA4xBtoA9bPvU89GB8hetl5nW5PxPoqDqJivnpO8RC/u/l+vdNCXDFTsQ5v+tnHMI8FUnnzz7bFP753sG34W/aXIrlEJ69crb4eF1zNfcuLDp6yUhNlDEfbhY7txAIg7MY1ei6lD29Y7C36OvYhSXw=
Received: from BN9PR03CA0556.namprd03.prod.outlook.com (2603:10b6:408:138::21)
 by PH0PR02MB7799.namprd02.prod.outlook.com (2603:10b6:510:5d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 10:05:00 +0000
Received: from BN1NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::ec) by BN9PR03CA0556.outlook.office365.com
 (2603:10b6:408:138::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Mon, 11 Apr 2022 10:05:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT008.mail.protection.outlook.com (10.13.2.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.21 via Frontend Transport; Mon, 11 Apr 2022 10:05:00 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 11 Apr 2022 03:04:58 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 11 Apr 2022 03:04:58 -0700
Envelope-to: linux-clk@vger.kernel.org,
 robh+dt@kernel.org,
 gregkh@linuxfoundation.org,
 sboyd@kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.59] (port=36530 helo=xhdshubhraj40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1ndqun-0003Jf-Kd; Mon, 11 Apr 2022 03:04:58 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <linux-clk@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <gregkh@linuxfoundation.org>,
        <sboyd@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v14 4/5] clk: clocking-wizard: Fix the reconfig for 5.2
Date:   Mon, 11 Apr 2022 15:34:42 +0530
Message-ID: <20220411100443.15132-5-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220411100443.15132-1-shubhrajyoti.datta@xilinx.com>
References: <20220411100443.15132-1-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a168b07-178f-40ba-7ed6-08da1ba2bd59
X-MS-TrafficTypeDiagnostic: PH0PR02MB7799:EE_
X-Microsoft-Antispam-PRVS: <PH0PR02MB7799803BFF2F549C93E1A100AAEA9@PH0PR02MB7799.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5NHgy+kR5j5ne1Ds3QN0G+s9WOFEoGkq3AXAVCJgiMC7voAy0CVX9yGh0UwzF7OfWybZ9oPmzHm5nEg34p9rW1EONzPPmDHttD6tiyDnYKZy0h6zlWM9yUuVbcPjJsfUwLfe8c9Tinf8Gxgc955+VLKSR3hs2nH6hNeeWbmUGPFdl9JxXWyUt6EJEytcGex1dY1iTLNa5Bbk/ArZyHoSI5iejkzvUqybGnFv2iJCXsgd7H/Zpy7QHg+I1lT3ePpPXfApHY9TBDT4rfZapMsR2caNvJMIgsbEQugoSR8/QHVPczXoUhSAg3FoM93wbUSV5dK9Dj1XijVHe7Ii0SmpQ9MwIQVe17r5szBaN4ogU5ZS5VtHHsZxZFYTTtZKgOjjGm2wuA8N1zt4tHBSZmhdiB0R9Nl9K6BznEaLkQr4+rn6VlGUyQvvrVyDCof40a9SUrxG2SgMSxkDPFvnzRWf06L0D1ceTFAqKyi/yDdCJTT24WhDwBzOVupzKD7nz84jn7DhHXUmUl8+IskXHLvVAwzu91H44S/0HUEo4gvDKeRQuhh4A2r0RcReIR+prjdyYybZ+FCVh9rDuF6v+pnWNMeG8CwA95Dq+iutv+RKWUCUIznMpCYBi3SU8/cBqwqzG/nvkvECgCXQVMISrxO6ukC9uEofT9kz0NRh2aSmoFRTAubSz1HN9sajQwuVW3qh/9Lpd1UuUyCKKnstOzvWRQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(8676002)(9786002)(6666004)(186003)(70586007)(40460700003)(70206006)(4326008)(26005)(44832011)(426003)(7696005)(7636003)(107886003)(508600001)(8936002)(5660300002)(83380400001)(36860700001)(6916009)(336012)(1076003)(54906003)(2906002)(47076005)(82310400005)(316002)(36756003)(2616005)(356005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 10:05:00.0351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a168b07-178f-40ba-7ed6-08da1ba2bd59
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT008.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7799
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 5.2 the reconfig is triggered by writing 7 followed by
2 to the reconfig reg. Add the same. Also 6.0 is backward
compatible so it should be fine.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/clk/xilinx/clk-xlnx-clock-wizard.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c b/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
index 1e0818eb0435..61c40e06e381 100644
--- a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
+++ b/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
@@ -44,6 +44,8 @@
 #define WZRD_DR_INIT_REG_OFFSET		0x25C
 #define WZRD_DR_DIV_TO_PHASE_OFFSET	4
 #define WZRD_DR_BEGIN_DYNA_RECONF	0x03
+#define WZRD_DR_BEGIN_DYNA_RECONF_5_2	0x07
+#define WZRD_DR_BEGIN_DYNA_RECONF1_5_2	0x02
 
 #define WZRD_USEC_POLL		10
 #define WZRD_TIMEOUT_POLL		1000
@@ -165,7 +167,9 @@ static int clk_wzrd_dynamic_reconfig(struct clk_hw *hw, unsigned long rate,
 		goto err_reconfig;
 
 	/* Initiate reconfiguration */
-	writel(WZRD_DR_BEGIN_DYNA_RECONF,
+	writel(WZRD_DR_BEGIN_DYNA_RECONF_5_2,
+	       divider->base + WZRD_DR_INIT_REG_OFFSET);
+	writel(WZRD_DR_BEGIN_DYNA_RECONF1_5_2,
 	       divider->base + WZRD_DR_INIT_REG_OFFSET);
 
 	/* Check status register */
@@ -224,7 +228,7 @@ static int clk_wzrd_dynamic_reconfig_f(struct clk_hw *hw, unsigned long rate,
 	struct clk_wzrd_divider *divider = to_clk_wzrd_divider(hw);
 	void __iomem *div_addr = divider->base + divider->offset;
 
-	rate_div = ((parent_rate * 1000) / rate);
+	rate_div = DIV_ROUND_DOWN_ULL(parent_rate * 1000, rate);
 	clockout0_div = rate_div / 1000;
 
 	pre = DIV_ROUND_CLOSEST((parent_rate * 1000), rate);
@@ -246,7 +250,9 @@ static int clk_wzrd_dynamic_reconfig_f(struct clk_hw *hw, unsigned long rate,
 		return err;
 
 	/* Initiate reconfiguration */
-	writel(WZRD_DR_BEGIN_DYNA_RECONF,
+	writel(WZRD_DR_BEGIN_DYNA_RECONF_5_2,
+	       divider->base + WZRD_DR_INIT_REG_OFFSET);
+	writel(WZRD_DR_BEGIN_DYNA_RECONF1_5_2,
 	       divider->base + WZRD_DR_INIT_REG_OFFSET);
 
 	/* Check status register */
-- 
2.17.1

