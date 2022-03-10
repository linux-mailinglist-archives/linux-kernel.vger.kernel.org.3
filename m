Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091B64D4F87
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 17:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242763AbiCJQoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 11:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240945AbiCJQoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:44:21 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2065.outbound.protection.outlook.com [40.107.212.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A37159E86;
        Thu, 10 Mar 2022 08:43:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZR/oSTVdM8BozSbnnXY1/HgJK3ApCpnrBhUyIGEq+aqxYZ3UWAQaTYXFOcMgbFkqdxNt9vJ5eHmddIH0XUbnzJoEs7Rpge+LUawoU9RgDV+3lg3OQP8wP4YH5JyUBD1i0kjgHlWUcJv8+ufF60X6i9KnHayhHSRGZ2WcM0vC8QiwDJgQrX8wuqwPXVpy7MD4jY3yeT/jYdpu/rQ0bf0yg1p2e/RxUg5FbWXi/eSuwYCtiJ0KaU+BsF8xVORtKF37Ya1WhKUKUubGKukC8/57qvw4iB9+obiogStlRJTDxJOZWDoKuTr/CRjJHXU8mC9FujVf1F6qORVUjS2HGODOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOsccuODO3ein78CsvfflSxfNbKB2PBGc0H+XdYUEdY=;
 b=GiFv2U86uB48Qnn8E+ZlL3W4bc4iRUMzgTGBc+zixTlg/LN7IK9jU/Z0hdSCv98xwBaYHN2umGWeR4xo5DBUc4Avvh55Jfgjt5/osBme7x/t+54X92DibhL5Yy4iK9AzWovuCed4n9wk+p4OYRyB0FTKcwS9HzM0ZC44WpC2uAs7FMu/shTE19mRFIsdLfRSFi0TnGmbtp1HmkkTEomnq1+2zjZ4ioTQlbPIMrpgScksMGNahNf81QfUlIcsutcdAUBub/oiD53XC+7tDxGkRM5263Pv3Cosi/lI7EuIwXztwp3GnxcIv9e2f5XFpNVGAk792y/dNHkylnpkrA8pBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOsccuODO3ein78CsvfflSxfNbKB2PBGc0H+XdYUEdY=;
 b=fz6N8vJzqXMQukrZgpKtlIJkb7ojZbF1bRQmhjWxsltBA0j8ykC6lyTn7PmWhZmR/wVNSy91GupJKoxUn4iw9WC0d7lzTrxFWa393YBSaky05RX+ciZbi/ASBobo4O3tstahNGbt0T87lrfdBoEMyApTzOhVhnMPkxvrp+VlK0Y=
Received: from BN9PR03CA0381.namprd03.prod.outlook.com (2603:10b6:408:f7::26)
 by MN2PR02MB6685.namprd02.prod.outlook.com (2603:10b6:208:1d5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 10 Mar
 2022 16:43:16 +0000
Received: from BN1NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::ef) by BN9PR03CA0381.outlook.office365.com
 (2603:10b6:408:f7::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.20 via Frontend
 Transport; Thu, 10 Mar 2022 16:43:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT007.mail.protection.outlook.com (10.13.3.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Thu, 10 Mar 2022 16:43:16 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 10 Mar 2022 08:42:46 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 10 Mar 2022 08:42:46 -0800
Envelope-to: git@xilinx.com,
 broonie@kernel.org,
 linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.18] (port=57612 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1nSLsE-0003SM-6S; Thu, 10 Mar 2022 08:42:46 -0800
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>, <akumarma@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [PATCH 2/2] spi: spi-cadence: Fix kernel-doc format for resume/suspend
Date:   Thu, 10 Mar 2022 22:12:35 +0530
Message-ID: <20220310164235.32230-3-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220310164235.32230-1-amit.kumar-mahapatra@xilinx.com>
References: <20220310164235.32230-1-amit.kumar-mahapatra@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18d1e972-5618-4f06-d5e6-08da02b513a4
X-MS-TrafficTypeDiagnostic: MN2PR02MB6685:EE_
X-Microsoft-Antispam-PRVS: <MN2PR02MB66856563CE00DFFD6DE52991BA0B9@MN2PR02MB6685.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qAHgYla3kOg3rTCblgVVEX3DjbpJnuB3lbojvbW7dmGiJJuemxJdzV41joHSOPhlhh8MC9cXEeh+HkGJ4w7M4EVTMTDIqD87ASKksfxHy/9eOWG0lP40cRPvKgCKiYjSE9v/tE8a6uk7FupOVV8O4aEbzWVkcNk2ygCX2bvvrWGudKzkLTspxJrf4vM2vWdoRfn5zDyc5VwNIuH10yYE1AqwN06Z4SAby/YhHzNqfCMai4DAQ6lHQgqfvscA95oF2z0JuKY66OaB9qK9DCIN1HFR3JeRiQtdCpZBq9CZQ+gg0YQmr8QqLQg5znxkAMf5Ve1lNyCuzMjPz5EuD0p9SHdqSFgNyHwMNaHgQaLaLOntJ54tmmrkaYgY8S3fQd2LiD9bYI9u4pSe9LKHGKpAqhIIbb99haVhFD7Fp7fvPtLbVbrv7Ha3YJKvKrEth2HtMNUYldnNyxqzv9Qly8fmsQ2Aksq8CUQeAtVaOHt7lc2+2W585i4zmZQrx5c/RlRNUYN2Wi7V1zAealMn/Tx6GENEyWuNjHWlsnw5lIn6cASWg2YNspePz0ZC2Mr70ggb4crZ2gKeeAX0opdHMO004/VQX+C0tY1m1BOca3KFEn1IKFVQbwXacWvSiwp1hIdmjUibbATtkTaoT5ntVLHYW1Ytf3J+Tc8OAT2f6nMKrrVa76SYJ2umxXateKhCxKg0y8GXuS7PV4yH/HW7WfCogQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36860700001)(508600001)(316002)(7696005)(15650500001)(47076005)(1076003)(107886003)(6666004)(2616005)(36756003)(336012)(426003)(186003)(83380400001)(26005)(4326008)(356005)(2906002)(82310400004)(8676002)(70206006)(70586007)(8936002)(6916009)(9786002)(5660300002)(7636003)(40460700003)(54906003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 16:43:16.6690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d1e972-5618-4f06-d5e6-08da02b513a4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT007.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6685
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
drivers/spi/spi-cadence.c:662: warning: expecting prototype for
cdns_spi_runtime_resume(). Prototype was for cnds_runtime_resume() instead
drivers/spi/spi-cadence.c:691: warning: expecting prototype for
cdns_spi_runtime_suspend(). Prototype was for cnds_runtime_suspend()
instead

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
---
 drivers/spi/spi-cadence.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index aff3f4241840..87bb29ac4d7c 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -650,7 +650,7 @@ static int __maybe_unused cdns_spi_resume(struct device *dev)
 }
 
 /**
- * cdns_spi_runtime_resume - Runtime resume method for the SPI driver
+ * cdns_runtime_resume - Runtime resume method for the SPI driver
  * @dev:	Address of the platform_device structure
  *
  * This function enables the clocks
@@ -679,7 +679,7 @@ static int __maybe_unused cdns_runtime_resume(struct device *dev)
 }
 
 /**
- * cdns_spi_runtime_suspend - Runtime suspend method for the SPI driver
+ * cdns_runtime_suspend - Runtime suspend method for the SPI driver
  * @dev:	Address of the platform_device structure
  *
  * This function disables the clocks
-- 
2.17.1

