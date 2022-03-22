Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1151E4E4274
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 16:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235566AbiCVPCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 11:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234293AbiCVPCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:02:06 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2089.outbound.protection.outlook.com [40.107.212.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507B230F4F;
        Tue, 22 Mar 2022 08:00:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ec76/PqTG+rNElLwHtTkkeWL4v/0RCy4bwf3l+pnpVu8SHqCA1300C/5Pa8qbEXygoBls3Rtidm149GtI9IWZVantEwTtrKaGccPGCk5zNfa6tLLbKfZxNif20euIX7AKwuLl06mgCr5sR81I7OBckk5npN6vKfXUbHIckwaFNI8Kn890YWAwgiCm0W6mXLD64/YKn03G//Pr5ppEngDDZ1k2SPyDo2xSnE40cWUwaZQCEkPJUa2y6Hv5XDXDeGMbCKil4fXvYsJKDEnn9ulOEXS6TWHlSbEWVLL9TJlVBLxnBWWz4ZCT6YfbyTcGMURqxmREDU2Rq2+WYj+qRrV/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3E1nGwrNGDLEh8iqn5bAvKRNxNTfQx4PtXwAfHhs4eU=;
 b=n6wCqNjTxfzmZLXzz/vUkC6qe6t/PZxVqIlxzrDPwYpxhvUldSGtKlv+z183njyIT3p4zD9FCyUXt+Fqn0nMetbzo6FAdzMFlUWPRv1hSvZBI5u2pZUvtGNyUO8TIxAY3iCCU6U3VXF4z01OoGs4c/dAbyCXwRZAxNmhrMtlQMtZKtL3m7VQQUpK3soDkErF+5O09LWBH1zf6h/9iCEehSgjHh3tdzs4t3z/N+iWyM7VajRGSr65O+jfC+gI2DQRiWG/IBozWNxueq4nKNzeW2exmZUlWicE8gcfkpMl/in0Ne5ttaqhrlf7utUP7dyilMTP6pWhHk2nBwwl1vk2/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3E1nGwrNGDLEh8iqn5bAvKRNxNTfQx4PtXwAfHhs4eU=;
 b=GS90wuK5KzLTUK2tjD4GwoJGumAYmJEqomalZK1sglFX93QlraWpwboIoe0H+0/ojg4BUs+0XtiEtxxekHn/kCirq3eHoR/g4M/RDJTFVL3XjHEBukWegoP1gpJgSHN/htUnFL+K2KSrBKXb6ndLstNzeRDUHYJcfafVGwW996c=
Received: from SA9PR13CA0117.namprd13.prod.outlook.com (2603:10b6:806:24::32)
 by DM6PR02MB4857.namprd02.prod.outlook.com (2603:10b6:5:fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 22 Mar
 2022 15:00:35 +0000
Received: from SN1NAM02FT0004.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:24:cafe::3c) by SA9PR13CA0117.outlook.office365.com
 (2603:10b6:806:24::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.11 via Frontend
 Transport; Tue, 22 Mar 2022 15:00:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0004.mail.protection.outlook.com (10.97.4.226) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Tue, 22 Mar 2022 15:00:34 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 22 Mar 2022 08:00:24 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 22 Mar 2022 08:00:24 -0700
Envelope-to: git@xilinx.com,
 broonie@kernel.org,
 linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.18] (port=40996 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1nWfzi-0004hf-CR; Tue, 22 Mar 2022 08:00:22 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <broonie@kernel.org>
CC:     <git@xilinx.com>, <shubhrajyoti.datta@xilinx.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [PATCH v2] spi: spi-cadence: Fix kernel-doc format for resume/suspend
Date:   Tue, 22 Mar 2022 20:30:18 +0530
Message-ID: <20220322150018.12736-1-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5171ea9-6a08-4700-e41a-08da0c14b7da
X-MS-TrafficTypeDiagnostic: DM6PR02MB4857:EE_
X-Microsoft-Antispam-PRVS: <DM6PR02MB4857479A5F74EDB6030B5019BA179@DM6PR02MB4857.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nTZp2J/YAQrGOhEOJUROcyRDzARMrCVsroRyaf2xM8EkUtEl/PmLs2sK2GF2FIxi/4JeqzK3Blp3aiS81ADeLFccKD1bx5B+5b5/y+nhcujlTPXFoVymN82KXkmMAme/xrXy1oIhb8GqJYFPliQv8/IxgoR2d+IFqsWsuCfwTToGLhdMxKGsazTEcb75mQstjdfGhUrbvON8jVN5Vi3kLb8cXLiGFViuJDE89AM4v4z8AeO2XC0uB8hsYh8LxqhjMu//VSE6lmNa6YP2UXHr8Z21RFUH9wJiZg7GdkkzqPwS/MHTBQzitbhDETLp8s7oy9MOYNcGwXymklRJxMoav44P8pNIumaDBVV2FHr4CYHSjuk2ZpfVDPTXc94X02Awubr2ymByde2LuPAP/AzDj6WZTZtBBktpZUoFCMpek0wWfJyVRRMcNzfVpRpJbqx0cxM/ZI9V2//Zb5D5Ko0lFxHs0EyZufz3XiquWLa8iIpLQ5P43XXHbVDgHZZyLo/JKMCUH8izOq7uhGFmXr5fm/IEp0tkjV2tUlcCZ5l1VmpA3P0tUzErMsXLwbeVtGNA4MZI+pniY6Jcv/qrcVJN3vuElLl15OeDjBYwPhPIQJyaTySleDqxDiporx7ULZVJ2MEO8j+QOo994djHaRXvy5FIJXHe2lIjrxzcngVQahBMNKq2N4n1CH1r2RLD30TT/J2r0undn0493FblS93YLQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(54906003)(6916009)(36860700001)(70586007)(8676002)(316002)(4326008)(508600001)(1076003)(82310400004)(426003)(186003)(70206006)(26005)(2616005)(336012)(107886003)(40460700003)(83380400001)(47076005)(5660300002)(9786002)(6666004)(7696005)(8936002)(36756003)(15650500001)(356005)(7636003)(2906002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 15:00:34.8864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5171ea9-6a08-4700-e41a-08da0c14b7da
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0004.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4857
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Simek <michal.simek@xilinx.com>

Kernel function name don't match with function name.

Error log:
drivers/spi/spi-cadence.c:661: warning: expecting prototype for
cdns_spi_runtime_resume(). Prototype was for cnds_runtime_resume() instead
drivers/spi/spi-cadence.c:690: warning: expecting prototype for
cdns_spi_runtime_suspend(). Prototype was for cnds_runtime_suspend()
instead

Fixes: d36ccd9f7ea4 ("spi: cadence: Runtime pm adaptation")
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
---
BRANCH: mtd/next

Changes in v2:
 - Aligned resume/suspend function names and fixed kernel-doc warning in a
   single patch.
 - Added fixes tag.
---
 drivers/spi/spi-cadence.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index ceb16e70d235..b509eefe16a8 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -657,7 +657,7 @@ static int __maybe_unused cdns_spi_resume(struct device *dev)
  *
  * Return:	0 on success and error value on error
  */
-static int __maybe_unused cnds_runtime_resume(struct device *dev)
+static int __maybe_unused cdns_spi_runtime_resume(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct cdns_spi *xspi = spi_master_get_devdata(master);
@@ -686,7 +686,7 @@ static int __maybe_unused cnds_runtime_resume(struct device *dev)
  *
  * Return:	Always 0
  */
-static int __maybe_unused cnds_runtime_suspend(struct device *dev)
+static int __maybe_unused cdns_spi_runtime_suspend(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct cdns_spi *xspi = spi_master_get_devdata(master);
@@ -698,8 +698,8 @@ static int __maybe_unused cnds_runtime_suspend(struct device *dev)
 }
 
 static const struct dev_pm_ops cdns_spi_dev_pm_ops = {
-	SET_RUNTIME_PM_OPS(cnds_runtime_suspend,
-			   cnds_runtime_resume, NULL)
+	SET_RUNTIME_PM_OPS(cdns_spi_runtime_suspend,
+			   cdns_spi_runtime_resume, NULL)
 	SET_SYSTEM_SLEEP_PM_OPS(cdns_spi_suspend, cdns_spi_resume)
 };
 
-- 
2.17.1

