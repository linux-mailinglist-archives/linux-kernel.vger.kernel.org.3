Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B11E4FB900
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345081AbiDKKIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345058AbiDKKHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:07:20 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7910120A1;
        Mon, 11 Apr 2022 03:05:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMUUBkO9bxGnPWTO1Cr39zkBqubIwGgQg1RFZhz0/M5+ERAi9cYZv2+ybH6bm/Ic5en2rOc9CEgCzw0AgcmYn8BLk2hlnWgc0s1FzBcHxznum3fo7Hh/1foBhdY87RfgOO2tmdT6Sjd34AuHE3xZiemAEJN+wtYwcIDFXIo/YzYm51VLcQM5qel/MHtT9Fbgb+ymFI5xXxG2+8e0RBM1Ymd0n4jvdJkR2kWHvQ3SSTryahn2dpx96u0ukeTpQrtQ7inB1x/iiqhYN33v0gKSs7F5YsazevdLdfW8ASEhZI/vgcmDXF0ldFrJxKMr/opVpzMuvHgvvpu4TB2LNmcO8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FnH7QGzW+UXnLGRce5p/WoRnah+/kZPhep9Y5J0jQgU=;
 b=FqRH97AEYQIZgfkmL5e1zmZHOHUWVZXf/nhlcm2b3GuJjOu+HVVKpn89xFJ+FKzwDjOQZcEgA6isiUSQYCXucN0ewCkhICMxl1d1zCiCRm2K/DiZ+/eAqWMfF7LL3PK49VoHP8xEAEaIdKENAOjM0xeGxvRu+RmHwcZv06+RBVXE4f9iRzBJbqa24ZitVXUXRX8daMdCN0M+5xL2R7J2BHMNJWKQAPnPmUxs5oQbIOarrWnaOjqvP3LRxsrgN12wro9zFpIrk1z7wBJ5KlRa0TLso8SR2CTAUXRxDIvhNWygI0sFyGFHORHdUHmusV0MOiPfxLpPKiiuis0qKC2c8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnH7QGzW+UXnLGRce5p/WoRnah+/kZPhep9Y5J0jQgU=;
 b=ScgUh9VQ6K6/7Jb2wBXBELONq7WP9dqQFoCsVQSAyDAd2wTH0w0iWk9KOCc61mGSFMeO45rxZBQuXtmE2rKLU3cKmUyLr4SZ2DFsbU2ACR/c3BtGtx9MgWrD/Znw1DRE2gYRDeNsZ1mvdobPU+tGOEbG6THcYowy0hiBQfCa9fw=
Received: from BN9PR03CA0325.namprd03.prod.outlook.com (2603:10b6:408:112::30)
 by DM6PR02MB4300.namprd02.prod.outlook.com (2603:10b6:5:1f::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 10:05:01 +0000
Received: from BN1NAM02FT039.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::19) by BN9PR03CA0325.outlook.office365.com
 (2603:10b6:408:112::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Mon, 11 Apr 2022 10:05:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT039.mail.protection.outlook.com (10.13.2.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.21 via Frontend Transport; Mon, 11 Apr 2022 10:05:01 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 11 Apr 2022 03:05:00 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 11 Apr 2022 03:05:00 -0700
Envelope-to: linux-clk@vger.kernel.org,
 robh+dt@kernel.org,
 gregkh@linuxfoundation.org,
 sboyd@kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.59] (port=36530 helo=xhdshubhraj40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1ndquq-0003Jf-En; Mon, 11 Apr 2022 03:05:00 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <linux-clk@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <gregkh@linuxfoundation.org>,
        <sboyd@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v14 5/5] clk: clocking-wizard: Update the compatible
Date:   Mon, 11 Apr 2022 15:34:43 +0530
Message-ID: <20220411100443.15132-6-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220411100443.15132-1-shubhrajyoti.datta@xilinx.com>
References: <20220411100443.15132-1-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbc2d339-b99d-42d3-0424-08da1ba2be4d
X-MS-TrafficTypeDiagnostic: DM6PR02MB4300:EE_
X-Microsoft-Antispam-PRVS: <DM6PR02MB4300E6B7AB87501E28240BA2AAEA9@DM6PR02MB4300.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U5XVk7suDSw5w3YZuAI21c1ttSqvJ1UgeLiPOdpEIUNfGNGvAEkmeJ5xHTAuGLeyqMuVmYShA6f+ojV5fGd6Rvn7ptle/WMBylWxCOrbio+EuS3z3Vu6Pjtcg7ZXmjHPDjWUBQ8EWumxhx2MKTcviaC/+Z0hfAAfOer6x4rAD0Xzqu2d+rPeVAr0rSyM8/c/z8dBG7F6wVbj2VC+9V+GaSVyMOLv5CrwkbvoIv6L9V6FyR+oUwKx8V+KZtISw0F9FVa2zrrHFCpCxWVmyNeBAVZgeMrlZwBU1cbHp8yspjDUgMeu64TPUcmnylgRpRMHvJ/WNTE0Zm8EYhzxwDFSwEIQCV3LCXOY7/n7e7M6at8aG1I/yvP671hs1a2wIpJZFdWPwsfmV9Q4KV4mkZMnz0ruvkw+BNY8Bjuhzmb7Dyat7Yo7abCvX25YgCL1iqXf/hvq0PK0aKfCn/Scjf21eEal9pXJN7y/IEkUQ0ow4n5iF2OyK+/rUTNjCSgDXkYisS3asEOFauV9huHEXDr7yekLf4PA/u9Qle/ZGG8vQV4T+l9tRMC6uX/R0vZRfi+J4iTxUsWVzyKve0+OMD0ws/ln8kmQQ4v+nUmwqAxc8CTsR6eJTGMDEgREiS+X63dqVERDAMu36f30oWt4U9/IQNCKOKkH/hFAPvRUw1c/7Lkq/KK+57xTINZIXT2F3fZtRU0uh77A2w9NRnaqIxL9/Q==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(44832011)(356005)(186003)(5660300002)(6666004)(54906003)(6916009)(36860700001)(7636003)(4744005)(47076005)(1076003)(40460700003)(7696005)(9786002)(8936002)(2616005)(107886003)(15650500001)(8676002)(36756003)(316002)(4326008)(426003)(2906002)(336012)(82310400005)(70586007)(70206006)(26005)(508600001)(83380400001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 10:05:01.6310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc2d339-b99d-42d3-0424-08da1ba2be4d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT039.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4300
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the compatible to indicate support for both 5.2 and 6.0

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/clk/xilinx/clk-xlnx-clock-wizard.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c b/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
index 61c40e06e381..5b8433468cc5 100644
--- a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
+++ b/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
@@ -621,6 +621,8 @@ static int clk_wzrd_remove(struct platform_device *pdev)
 
 static const struct of_device_id clk_wzrd_ids[] = {
 	{ .compatible = "xlnx,clocking-wizard" },
+	{ .compatible = "xlnx,clocking-wizard-v5.2" },
+	{ .compatible = "xlnx,clocking-wizard-v6.0" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, clk_wzrd_ids);
-- 
2.17.1

