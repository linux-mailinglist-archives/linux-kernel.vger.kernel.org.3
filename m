Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E18F4BF8DC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 14:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbiBVNLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 08:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbiBVNKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 08:10:04 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75301533BB;
        Tue, 22 Feb 2022 05:09:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5jfkoAVeLUAf7mGS8yqZW0DqDBbBdYgC9chpZ/RP83RXQvy2GeIMPpCcX2v+jS/NW8Swauy4tnC+s7IPUrjjrCc7Q135u/XBOpKE9fEzXmis8lhBIiskUSW/EZGDGAyAxpN18G3FJLgEaKaCi73MzQqQdUz6Xj7eMAJInzvn0rQLLqfsgJ1Fl/UoZTJingMp25bUVtzKD3wPSesiKPkZA2TXnxmwAxDnGikRvOWHNIkqTijhRUj9Fimp/gVCE4rdB24XNijDofmeZ1Y91HKxOS8t+TFx2LSWv7YFO73icHS1pBNtpsJ0jk0r5tNYMkAWBpwjOGj5eF3O0/Fm02MTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vfXcr536bemeh81FHzrlNim153nDcqpdr7jFH1GHMQ=;
 b=m+Q0uspoS+cPuQaZAqf8nEmmY8Kp8w5t8UVezHeZQvjAroMg6ZAvAOkjSzNm7Kp0tV3NutiIi0Wybx3Fj1VTH9kRvoEiWUCXBkaO1cO8ePcfVzhRiqlwP/YpHRZw7gdq0Ues6/2RdNBA8ozERVfmcdNvi1kWmlKKmzu6PX635jsO38FS+tNErQUAHnTpd7gYfPQMaR9/3WH4wQWd4AnwkH0Ust+zmgIDsFdzlP6dEoq5jr56fe+iwQmh74VDrbGXkSPAgGZFxv8kxJT/so4IKWQ2gki8JvAJbkeF4lPL1SQyuqw7HY/ZzFyVB/6muzHR3S3GRBSklvQ98k+YYNVC4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vfXcr536bemeh81FHzrlNim153nDcqpdr7jFH1GHMQ=;
 b=Em7M+jvnt7iHkgbaOnVGWDrJhYEiKa6i+cLKKWo+n8p+VYCA2e+z9EweO/Kf3f6uqEut/ViAHeeR36P4qsKoZFIK4j1UUmS5gSzVDeYYm598Xzo+PORnqNT7aPV54kzM9XiKUz0IuulwlyeUDj9UC4zVKY1vgJz3mUQOh7QWxuY=
Received: from DS7PR05CA0085.namprd05.prod.outlook.com (2603:10b6:8:56::15) by
 BY5PR02MB7026.namprd02.prod.outlook.com (2603:10b6:a03:23d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Tue, 22 Feb
 2022 13:09:25 +0000
Received: from DM3NAM02FT037.eop-nam02.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::75) by DS7PR05CA0085.outlook.office365.com
 (2603:10b6:8:56::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.9 via Frontend
 Transport; Tue, 22 Feb 2022 13:09:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT037.mail.protection.outlook.com (10.13.4.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.19 via Frontend Transport; Tue, 22 Feb 2022 13:09:25 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 22 Feb 2022 05:09:24 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 22 Feb 2022 05:09:24 -0800
Envelope-to: git@xilinx.com,
 linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.59] (port=35690 helo=xhdshubhraj40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1nMUux-000Eql-K8; Tue, 22 Feb 2022 05:09:24 -0800
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <linux-clk@vger.kernel.org>
CC:     <git@xilinx.com>, <michal.simek@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 2/2] clk: zynq: Update the parameters to zynq_clk_register_periph_clk
Date:   Tue, 22 Feb 2022 18:39:03 +0530
Message-ID: <20220222130903.17235-3-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220222130903.17235-1-shubhrajyoti.datta@xilinx.com>
References: <20220222130903.17235-1-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1994d895-6f7e-4db8-e567-08d9f6048cde
X-MS-TrafficTypeDiagnostic: BY5PR02MB7026:EE_
X-Microsoft-Antispam-PRVS: <BY5PR02MB7026C9C2A15323375D9005CBAA3B9@BY5PR02MB7026.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M3mbS1x9XA4rLwSrHDMlNUzHpiEFFp+RslrfPMiJaeQv4mKa1bkP08+rMoJzatGzK5zAoGi+eZgTVfeKNg1qFjxDr7vUtMsd5D2FGwekyPOOwe5B2u29GrgwAniLg2TnFHIyHgs+PDjqpsFvxh6hEmh5e65DjvtAvDo1ccTmaa7t30r11+MuAjyQ9IIIJid71e+KX6vTAdiD/txSE85vd/x7DcCzcJ9Toc3eN4vQJ8OmJPv/z0vqJNqXfTuy+6Z3ngzigzMw74y3TksDDGIgVi0WNmcphxZKhGh4L8dCagAIgNoJjeoHYgxzE5m+UaUhC8fOYL3wgoQXTqDOtbIQyceBbLvMwAPLpXiddPySAaJXNS2Be5DFOm6UKH5dCaIFAHPgmrkyBQ6RfmUHZF52fm/8wSbmJ2JMzKpj75tuqWmei8rMBI/uP87gQ3vI6SZdVk9D/bYUpOsPU6X7t5iHyFIn4oRXW/v1dfHEQPS5i63zbUGcok4/oxTXFC2exb3zrcZ/wFduvErd9sniLFpsBaDGWJSGDfhrb/UhjQxOcZhq4l8kw47NshQvF1aYoWbbQnMctC9NUZNGJBlrrheJG5ftLaLU6RA1YFXlTwOQSh07OPV23pbfT1PvId4iuIUZ9pqAn5OjsiToJS0egkK/h8jZTSG4+xPh2D7VmhNL9LfKqj6kd0LNTqWH9K5pdYm4
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(4326008)(426003)(47076005)(336012)(83380400001)(44832011)(36756003)(5660300002)(9786002)(2906002)(8936002)(26005)(7696005)(2616005)(107886003)(36860700001)(186003)(70586007)(70206006)(1076003)(356005)(7636003)(54906003)(8676002)(508600001)(316002)(6916009)(82310400004)(6666004)(450100002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 13:09:25.2417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1994d895-6f7e-4db8-e567-08d9f6048cde
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT037.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB7026
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case there are only one gate or the two_gate is 0 the clk1 clock
passed is not used. We are passing 0 which is arm_pll.
Pass a invalid clock instead.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/clk/zynq/clkc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/zynq/clkc.c b/drivers/clk/zynq/clkc.c
index 434511dcf5cb..7bdeaff2bfd6 100644
--- a/drivers/clk/zynq/clkc.c
+++ b/drivers/clk/zynq/clkc.c
@@ -355,14 +355,14 @@ static void __init zynq_clk_setup(struct device_node *np)
 				periph_parents, enable);
 	}
 
-	zynq_clk_register_periph_clk(lqspi, 0, clk_output_name[lqspi], NULL,
-			SLCR_LQSPI_CLK_CTRL, periph_parents, 0);
+	zynq_clk_register_periph_clk(lqspi, clk_max, clk_output_name[lqspi], NULL,
+				     SLCR_LQSPI_CLK_CTRL, periph_parents, 0);
 
-	zynq_clk_register_periph_clk(smc, 0, clk_output_name[smc], NULL,
-			SLCR_SMC_CLK_CTRL, periph_parents, 0);
+	zynq_clk_register_periph_clk(smc, clk_max, clk_output_name[smc], NULL,
+				     SLCR_SMC_CLK_CTRL, periph_parents, 0);
 
-	zynq_clk_register_periph_clk(pcap, 0, clk_output_name[pcap], NULL,
-			SLCR_PCAP_CLK_CTRL, periph_parents, 0);
+	zynq_clk_register_periph_clk(pcap, clk_max, clk_output_name[pcap], NULL,
+				     SLCR_PCAP_CLK_CTRL, periph_parents, 0);
 
 	zynq_clk_register_periph_clk(sdio0, sdio1, clk_output_name[sdio0],
 			clk_output_name[sdio1], SLCR_SDIO_CLK_CTRL,
-- 
2.17.1

