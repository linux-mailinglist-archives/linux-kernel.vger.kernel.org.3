Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1464BF8D1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 14:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbiBVNKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 08:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbiBVNJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 08:09:58 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6675C1520DF;
        Tue, 22 Feb 2022 05:09:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iS9R9VCp7qb+mzZhJLjWubQiW5JptMgKaWK69lLfLQt69Ai4j79PwWpgbuapM/vPe7hGLuYjGhInapWRpdC/Yh5af5qTrujoiJYqeJ3HEewKtVVJb3/BDn3+lAAjKT/OJewF3xVxLAvljZGWXlH8BRySxpatYW2qszoKoADbG98ltI6ymXWXbwF1TbNo2dohBR9W8rDiFyiQ4h70eS/V/Gnd8l9uI/blCNPus/tkyi8gE6ttmxx/fYRrtAWwGJKmh0BcQXg+5bKH6meHYc7ksP7F/ZLEgSv0DS+u2kUvWrjfcZZDDQppU9c2riCDu0hXfJ6eZHVZJN9XkvfaYHZqDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+bxMI2TyLPQoMRYxAZ0w5ehWzJpBjH+Ba6t2LrRFs4g=;
 b=hopS6cbT5/jlGjCl6rdHzgoPyieT9qV55jVyx4QdYye7qyjKJLCPh6X9E36X8AoJ2k4rHitHaaawHS3OJL1DRfR4gWRJwC8DC7OJ090P60AbBwe1w9A9990G+8pue32XV+RqDYUA2GwOR9WMZBCkZvj7Ov/DY8kDX/hcWWgAZ3rHgyFPmjVHG1gYHytj7ts3+0PW/XYf0cnue5MxzmJz3x8m9hMj5Xrm+XUTQHmNa6LBouXJQsXLXnHjUUO1glejvut/eUgTxAzzrkcsrj6HHnfCd+vHgSSH5f/5zNiuJl8wBUL40tPzHsQI94MpcmBTuz2enaakoWF0NT4xycwQRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bxMI2TyLPQoMRYxAZ0w5ehWzJpBjH+Ba6t2LrRFs4g=;
 b=kXtQNU4PfEKEKOiq2okUPR4sW2TrJC6WOszStJblnoEy459LAVNkuZILVI2m1/yao7uVF95u5V5D04Pj8tnG6vRCOmRABy9v+ekSWwHPT2GbAeaFRd+Kgs7E22CJjFlmn1YKkVCxo0ALhDj29/f/nt4B4o07i+R6fcBr2NRlfR8=
Received: from DS7PR05CA0100.namprd05.prod.outlook.com (2603:10b6:8:56::23) by
 BL3PR02MB8161.namprd02.prod.outlook.com (2603:10b6:208:35c::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.24; Tue, 22 Feb 2022 13:09:22 +0000
Received: from DM3NAM02FT037.eop-nam02.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::22) by DS7PR05CA0100.outlook.office365.com
 (2603:10b6:8:56::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.7 via Frontend
 Transport; Tue, 22 Feb 2022 13:09:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT037.mail.protection.outlook.com (10.13.4.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.19 via Frontend Transport; Tue, 22 Feb 2022 13:09:22 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 22 Feb 2022 05:09:20 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 22 Feb 2022 05:09:20 -0800
Envelope-to: git@xilinx.com,
 linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.59] (port=35690 helo=xhdshubhraj40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1nMUut-000Eql-T9; Tue, 22 Feb 2022 05:09:20 -0800
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <linux-clk@vger.kernel.org>
CC:     <git@xilinx.com>, <michal.simek@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 1/2] clk: zynq: trivial warning fix
Date:   Tue, 22 Feb 2022 18:39:02 +0530
Message-ID: <20220222130903.17235-2-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220222130903.17235-1-shubhrajyoti.datta@xilinx.com>
References: <20220222130903.17235-1-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8aaa6c4c-959e-457a-8d83-08d9f6048b17
X-MS-TrafficTypeDiagnostic: BL3PR02MB8161:EE_
X-Microsoft-Antispam-PRVS: <BL3PR02MB81619224F5D2B1CD70593086AA3B9@BL3PR02MB8161.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YgzIRVeCXASFs9L9etvqCVtV7EBr0z6LgQqdF30MSC4sYEaeLM4ys7YL4Xt72w8O867x5iHHZ+6YXd5kWQvQ3cl5LUTXijVp6dUHiUN9L9fI0OV1IBMa1ZbSOxfsoinVu62zkB6OD66or2uvRSAdYSmYSEl4HIxzI7JL0sEHOFFoSURxvm4EAYXjIu95ysrczZ+fzxGc7Qp6Ggt227DlQzIFhe9v1xek82StP2eG+lqSi63i+qUBsnyCOiV5ZrQfBaSEMqtou9aywldOstbhFzoeiC3FxJrqGnAXRk2kKqagsIbCaOzT0L/NMBIfK8OdVSFBZQOAaA14iIEOTxU34P9rbwAajxiXNfpJXZ52OynobAqi6nBXrzTiKxGqCJNzS2KU84brkG9Qb3gBBD0YL4ncYMEEBOM0GkPvJQa8DBr2sz6ulFJ6C6U0yZ7GHiRrE2h5gWZvDQP9hrcLPNWoC7xRqm6s7ExLU9/0heKmM+4iQU6LjpBJ/RRAO6ZgqWuhPYZvnkWOhxvoppJX4CKwlnBiK32qfanW5vzjXTm5C94FvC4rh69KbbljcLl8SxGNzq7yAO2XKnoX0NhAoYynGkNyXZXH/QDhm6qFnYMTGgsWAvj2pHKDe45VJN5Eau0GUioAxifvjgoT1NlbhhwHcOei2coX8vOQ/pDJs0RDjCpP/QHiz0l9K3xZlcX62Bau
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(47076005)(6916009)(54906003)(6666004)(316002)(8936002)(9786002)(36756003)(107886003)(508600001)(450100002)(2616005)(7696005)(70586007)(336012)(4326008)(82310400004)(426003)(186003)(26005)(1076003)(4744005)(44832011)(36860700001)(8676002)(5660300002)(356005)(7636003)(70206006)(83380400001)(2906002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 13:09:22.2577
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aaa6c4c-959e-457a-8d83-08d9f6048b17
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT037.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8161
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the below warning

WARNING: Missing a blank line after declarations
+               int enable = !!(fclk_enable & BIT(i - fclk0));
+               zynq_clk_register_fclk(i, clk_output_name[i],

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/clk/zynq/clkc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/zynq/clkc.c b/drivers/clk/zynq/clkc.c
index 204b83d911b9..434511dcf5cb 100644
--- a/drivers/clk/zynq/clkc.c
+++ b/drivers/clk/zynq/clkc.c
@@ -349,6 +349,7 @@ static void __init zynq_clk_setup(struct device_node *np)
 	/* Peripheral clocks */
 	for (i = fclk0; i <= fclk3; i++) {
 		int enable = !!(fclk_enable & BIT(i - fclk0));
+
 		zynq_clk_register_fclk(i, clk_output_name[i],
 				SLCR_FPGA0_CLK_CTRL + 0x10 * (i - fclk0),
 				periph_parents, enable);
-- 
2.17.1

