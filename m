Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB00C4BF8E7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 14:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbiBVNQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 08:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiBVNQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 08:16:29 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C94A15C65B;
        Tue, 22 Feb 2022 05:16:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2LXjrE2cwx0T9FNPKuGnuXsX11bXyQZi1MySuYV5thPuTT3vLodujIVxuJXU5EUpxSwQzAonNP7JpzXceXyr1Pshr1Irf9NIsUZsIkpejn4gbJ+ymWFNpRuoRfeMoO8FPYUy/lqN8VdQtyPnp2Dg5EJfwDwUTz08F+T7GvtKgAiT+qYdBdV8vf7p3gjt56FqVjQd/y+y+GeXPZyUDHDXbXzq2zOJwF3qP30uIVv+WFerkE6pZrDOUA3v9fHmqXBkzMXfwXxbriC6Q+eks1AbbRWXmdhbe64TKge663LQxhBxD9HJfSj8HwVVUErTRoQUhv9rxc7mMW9qkqqtx9RTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOElbM88l69uR8fxVgWl6/QapBeF+99Oja8t5c/zbZs=;
 b=EZDhKkaSbLm9m67KG+4DRyq/kVRyQUHwmm8Grosqc4WTmDoGGbtVSuZ60OCHm/5aoWQKysnKFxxnviY87OqVbSnH1X/OJ6fsyXc0qFE5rl+zCoHa7spONp6CqOI3o8599EaqNrHGHS+rsi9O4ty362wJvBWBa2RLoh+5VRqREUSi4PgQZNrhRNddibopr02BPW5toIL7dWQLQ4XO9rrdJIvTJzXbDniqPdPiTso4FIlxyKbnruEUGilzUZOZOTAMW+rvldQkjjQ8o/m7mB5h5PHLsBZJWicc4iUJBJqGvaG/DZHJG7jma77xkt8BRLKGvxpSDkoi+K+RBWOJIX+Vkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOElbM88l69uR8fxVgWl6/QapBeF+99Oja8t5c/zbZs=;
 b=Cj+jlyf7Ju/1x3ZiShCUokwjD+hV9iIMLRAUrqYllZ55rjRG+rnZhuMhy0yEV6xjr5fTEFT7X3/v9Y+bptpH5qAO+WShFolgtHNza9DZ6WQi8qm8RmPGI0eXnTcdSyR27FGGPQTS+ZDpoX+gznXH43uOGiwI+Aje0GGUMagmGTk=
Received: from DM5PR07CA0077.namprd07.prod.outlook.com (2603:10b6:4:ad::42) by
 CH2PR02MB6984.namprd02.prod.outlook.com (2603:10b6:610:8d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.16; Tue, 22 Feb 2022 13:16:01 +0000
Received: from DM3NAM02FT038.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::ad) by DM5PR07CA0077.outlook.office365.com
 (2603:10b6:4:ad::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Tue, 22 Feb 2022 13:16:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT038.mail.protection.outlook.com (10.13.5.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.19 via Frontend Transport; Tue, 22 Feb 2022 13:15:57 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 22 Feb 2022 05:15:51 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 22 Feb 2022 05:15:51 -0800
Envelope-to: git@xilinx.com,
 linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.59] (port=35706 helo=xhdshubhraj40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1nMV1D-000GJf-7F; Tue, 22 Feb 2022 05:15:51 -0800
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <linux-gpio@vger.kernel.org>
CC:     <git@xilinx.com>, <michal.simek@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH] gpio: xilinx: Trivial patch
Date:   Tue, 22 Feb 2022 18:45:48 +0530
Message-ID: <20220222131548.17513-1-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b9043e8-a39e-4a7e-6e71-08d9f60576b7
X-MS-TrafficTypeDiagnostic: CH2PR02MB6984:EE_
X-Microsoft-Antispam-PRVS: <CH2PR02MB6984AF925767251596D0C8D3AA3B9@CH2PR02MB6984.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JtQI3JsrJoKWHiwu/MOSCLV53faZHaccK4DGjiJ5dNyQ6EzyyOXAMGuh8CoBde2lkkc+inMBJNFZbfSc5CdBwuBEFxmPnw+zSnRo6lFcYUynrtkfCFB+XLuFHfpwNzjFs+lbkcMrxuiu1Gd4cYrNQYlaGn7w2y+ZpuTNxSGBUt/ghO1NUtBAQ+hQQJLPkb3k/tOFA0tKXSqbU2/o37edzHCu0MA8NVMYEEYjsgaGDwJxr9byb7v/BKOaGBLY5rx1Ff10C4QaBVsp8ZlVcp5ZTw6iMfrhMjTnsDT3to1LZG3TpUIdxY4PrJLVn74DENid1ZkqWZM7v4WRvR2K4+NHhCBm8w6z//ypVQ2N9OXfM3ge0n+abeiNjEMZLvSvr2f1jWKt7lDTG4FhQ2dpdTD1FMecZMb+fkEM9/TSOBtiA0HQzf68uEOBJt/sH1xglVL55P5QH3iDsoC2WYEyfgxgbtl+KrPRrzwaxr6V6Gvk4EQiWXsdEy0FyskFg3xJWJYS0HO9oMBB1JA1F3zysG4fzMZLKXQW9wja7IbpUW1YiTXd8kiwNnD/bPICPoSarPK+ofqsoVbc6XHmTSVx8OG8C2y+tLbRFIt/0ipNAM9SKgbDR5mJyJz9NCkFd1023X22804981swMzfnSwoIO8KBK8q9xxZqhgcA8H6RjMy4IMfQCgS6wwkKGb+ztbN+18RU
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(2616005)(426003)(1076003)(6916009)(36860700001)(336012)(5660300002)(316002)(107886003)(54906003)(450100002)(26005)(83380400001)(36756003)(186003)(47076005)(8676002)(8936002)(70586007)(2906002)(70206006)(6666004)(44832011)(508600001)(4326008)(82310400004)(9786002)(7636003)(356005)(7696005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 13:15:57.5700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b9043e8-a39e-4a7e-6e71-08d9f60576b7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT038.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6984
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a missing blank line. No functional changes.

WARNING: Missing a blank line after declarations
128: FILE: drivers/gpio/gpio-xilinx.c:120:
+       void __iomem *addr = chip->regs + reg + xgpio_regoffset(chip, bit / 32);
+       xgpio_set_value32(a, bit, xgpio_readreg(addr));

WARNING: Missing a blank line after declarations
136: FILE: drivers/gpio/gpio-xilinx.c:126:
+       void __iomem *addr = chip->regs + reg + xgpio_regoffset(chip, bit / 32);
+       xgpio_writereg(addr, xgpio_get_value32(a, bit));

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/gpio/gpio-xilinx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
index b6d3a57e27ed..7f129e7eae78 100644
--- a/drivers/gpio/gpio-xilinx.c
+++ b/drivers/gpio/gpio-xilinx.c
@@ -117,12 +117,14 @@ static inline int xgpio_regoffset(struct xgpio_instance *chip, int ch)
 static void xgpio_read_ch(struct xgpio_instance *chip, int reg, int bit, unsigned long *a)
 {
 	void __iomem *addr = chip->regs + reg + xgpio_regoffset(chip, bit / 32);
+
 	xgpio_set_value32(a, bit, xgpio_readreg(addr));
 }
 
 static void xgpio_write_ch(struct xgpio_instance *chip, int reg, int bit, unsigned long *a)
 {
 	void __iomem *addr = chip->regs + reg + xgpio_regoffset(chip, bit / 32);
+
 	xgpio_writereg(addr, xgpio_get_value32(a, bit));
 }
 
-- 
2.17.1

