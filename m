Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8724D4F82
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 17:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242467AbiCJQny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 11:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiCJQnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:43:49 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001D412A92;
        Thu, 10 Mar 2022 08:42:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIYjNr14sT9YPDlIibTeAy2OgqhGabovv9bmNZ0IZ1Y/OXDti5mpcwu/7bWqJv+uoLgcAcYI7NqVV9vMNACXmuFExcEJsY4f+Y3FOyNKfelUnkmHpRmAx7UqMMwntb8fX2DuuxMlr2YukJD3f5bB5gfKBnKfc1oGarHPeWLlKB4p2LR0Q/WvY+PSBqf/6zF0O2+PkvNLtwzO3jdWesP1oQajSovgV0anVEZtt2KLKVONWuA2108t9VvT0xZEpHAZ/AUcDvV51MZVPp7yjrxOleGwSFHuvNZ6VtRGpLZk15VWpybGxyp7IX23xSElrpAsi68SRt4A/6LSL+7/0Pu04Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gi+vPPEUXfs8JNr5u+S0tbxiGsDNv0LFmpdDXqSymlk=;
 b=GpjBRm+zIYybLdmLt+eczh43YzbOowRImB1pY34hDUvOiFPycjFey8HzbGB1PUCpirOkBzJi5oznHz629iaiCSH0WTJcuPZPn7SvEazbR4aOThPcMjguA3/EUIUCSManCEry3CgzfpQiYdqcL/t+uuqr2buizxKHhCQKjgkUUd21fYPF8yee8yk1okvB/7FlXT+eHFEiYFf+hDI+uQTYQHuustIyS1pDzt36xgcHJd2M7aQLrT4lqsIEUTtUq3o6wzYg1j4L2r+shkRjVpWm352ptb4+iChTN/c5pLxEuNqVrNWvUz2/NIrCZgnKFieoQP7AJzhPH9YrEJe8bZGoPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gi+vPPEUXfs8JNr5u+S0tbxiGsDNv0LFmpdDXqSymlk=;
 b=KEViWV9+HOtijcLLaU4amLAC6GtL2UDgq+kTd6CgpQ9addIMHNzw6We/9RGCsbauTSLk+CMG2wehisH+u6tcsomvZxhUKM2kIjQiPmBlQh6CLKUiufWL8S8vNSbsS28rhuqkZz59uYy+BEWg7NvY9LeUdcm3XD2UTxP9v8j0JVA=
Received: from BN0PR08CA0005.namprd08.prod.outlook.com (2603:10b6:408:142::20)
 by CH2PR02MB6823.namprd02.prod.outlook.com (2603:10b6:610:7f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Thu, 10 Mar
 2022 16:42:46 +0000
Received: from BN1NAM02FT063.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::60) by BN0PR08CA0005.outlook.office365.com
 (2603:10b6:408:142::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.20 via Frontend
 Transport; Thu, 10 Mar 2022 16:42:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT063.mail.protection.outlook.com (10.13.2.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Thu, 10 Mar 2022 16:42:45 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 10 Mar 2022 08:42:44 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 10 Mar 2022 08:42:44 -0800
Envelope-to: git@xilinx.com,
 broonie@kernel.org,
 linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.18] (port=57612 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1nSLsB-0003SM-S9; Thu, 10 Mar 2022 08:42:44 -0800
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>, <akumarma@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [PATCH 1/2] spi: spi-cadence: Align function name s/cnds/cdns/g
Date:   Thu, 10 Mar 2022 22:12:34 +0530
Message-ID: <20220310164235.32230-2-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220310164235.32230-1-amit.kumar-mahapatra@xilinx.com>
References: <20220310164235.32230-1-amit.kumar-mahapatra@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff9f907b-2219-4654-f55b-08da02b50133
X-MS-TrafficTypeDiagnostic: CH2PR02MB6823:EE_
X-Microsoft-Antispam-PRVS: <CH2PR02MB68231CB02A31CA8EFCA749D9BA0B9@CH2PR02MB6823.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K2neN9H0rRDmq1Mg4wzZc52hJ3JjMvSk0iEM/A/j3jokxvQlozPt903OTnDozLanhxURa+f9Nug0qFX2+HttcVD/7AnwTPbLkzOzMU4PmJ6hlbktE33Wa2ImVSTI/C1I5cFihGywevlGLrHqqq9VG2Dx+jJNnvDkZ2e6DUZnJpjg5wkM/WRZdxFeKoujueOHyqn9E9EIbebL1+BiT1nzKe+oyAquksjx0CYzi0NG7sKh0gIUDSVDric/b3PpxAVsSy+gcIrcagSuI+tSatOnTAFxJz5q7gKAvNPtkxyuy6DpxAmI2t4XyyoufP3q1X0JU3KuG31XBsXdZ55Jonfxhadv4T2HnlbbZhRK4RQ4XEyX2ocjx/9gq3dlkBBhSAe9pt3vrvaBy5z6lFzExvLKGcqccKsl4FnNOGdhVaQl52kWA9NuJxeFt6w1e+qCodX/aGLogY+Be3haYcbY4vCuwRV7L0QIKYegcEpOCFHk3sitVpk9m89/XBDu/Jn57Ja3hc3spEH0RGzq1PKWRIUCZyCfK07+l/2rz0UhbaDwSROa0rFeQtCl5JYjZ3j9Pyzm8vxc+HvRv+oPNxTFtJaoep3CWpe4JZdxevJkGdss0mD0Xo+6dJ2KtRfrZRVz8Jb45ADRqUfa06H3JMWxK/hMK87HLyvkIy7doqGx2H2wA+Z/979YoEOs5ia0UJrSXQrXpCcMH8Z86m/nNYbMqPudaA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(316002)(82310400004)(508600001)(6666004)(26005)(336012)(47076005)(1076003)(7696005)(186003)(426003)(36860700001)(356005)(7636003)(107886003)(83380400001)(9786002)(8936002)(5660300002)(8676002)(4326008)(70586007)(70206006)(36756003)(2906002)(54906003)(6916009)(40460700003)(2616005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 16:42:45.7458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff9f907b-2219-4654-f55b-08da02b50133
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT063.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6823
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Simek <michal.simek@xilinx.com>

Resume/suspend functions are using cnds instead of cdns that's why fix it
to be aligned with the rest of functions.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
---
 drivers/spi/spi-cadence.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index ceb16e70d235..aff3f4241840 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -657,7 +657,7 @@ static int __maybe_unused cdns_spi_resume(struct device *dev)
  *
  * Return:	0 on success and error value on error
  */
-static int __maybe_unused cnds_runtime_resume(struct device *dev)
+static int __maybe_unused cdns_runtime_resume(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct cdns_spi *xspi = spi_master_get_devdata(master);
@@ -686,7 +686,7 @@ static int __maybe_unused cnds_runtime_resume(struct device *dev)
  *
  * Return:	Always 0
  */
-static int __maybe_unused cnds_runtime_suspend(struct device *dev)
+static int __maybe_unused cdns_runtime_suspend(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct cdns_spi *xspi = spi_master_get_devdata(master);
@@ -698,8 +698,8 @@ static int __maybe_unused cnds_runtime_suspend(struct device *dev)
 }
 
 static const struct dev_pm_ops cdns_spi_dev_pm_ops = {
-	SET_RUNTIME_PM_OPS(cnds_runtime_suspend,
-			   cnds_runtime_resume, NULL)
+	SET_RUNTIME_PM_OPS(cdns_runtime_suspend,
+			   cdns_runtime_resume, NULL)
 	SET_SYSTEM_SLEEP_PM_OPS(cdns_spi_suspend, cdns_spi_resume)
 };
 
-- 
2.17.1

