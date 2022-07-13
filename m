Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1730573B81
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 18:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237175AbiGMQp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 12:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237071AbiGMQps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:45:48 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744C22ED7E;
        Wed, 13 Jul 2022 09:45:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFi4L0tj3F3mpE12qFziAo/TJHfvYUL+DsoJHf6R3kcOEmFMHfqQDA5TzEH2RmrUNNgC9d3FXmufBbtQOUvNpuG7am1cZtk8A49qAJV+ukoF8k89LafTswX8Lj0atxpT24gqulEAPM6Ab5uu5yVLxhDWQ9yx3QJw8YklESXuzdyuzuTDlDREiNSeDeXyYXC990JFDLn1hvmzIiQEUeZ6nzx8tocMEi09BH/FAHJF5vYduKpEBFV9IAKkKRoXHvOXpvsijhhZ+OcxgM5nMV8KgaP90MNYO7KjDg7o8vrqoJo1BtFw803B/ASb1/R7g27inlfFE2uglLXr0ufIIZLMBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zt1gCQg3+36czYujOsSLn6+E7/HctvUgKWEkaf7kqME=;
 b=fngOImSI/P/DVWv9YDZMxBnOzTT4Vy0Mppujxxh0e3aP68dmarFzmR7Jxll50di5g++DWLkqhwEnTI2559zoc3xi1ceLLVxLntJNVJez+5e2uwLVO3ft43puUNs4O3j+miHJXASdDgR1lupl5v9pH5pcOyeO63VMS5Th8sIpwpiHouIKTYbbdq3YOF7ULxank5aFcKxAV6teM2L0vy3Sis8bIAC+8XSiYFNOiXwf25C8eevXdEhKtueFJ+ntqJNRzF/CQRYrLhnkekz/artvhcbM7P3aYfzDZ6Kt116JBDJtyq+CHuC3+FzfEhKpwqJqjFmQGn+rMyouKgptIasxAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zt1gCQg3+36czYujOsSLn6+E7/HctvUgKWEkaf7kqME=;
 b=EVnNkS3fQ6OGlhGIEW3uFQ22ohA3KHoZrExYPH3uoXfOE/YRCkp+5Ywho293TFBYwYfKTCprfkZMzAlvRjUvBcUSK0oomEZcdLmwX/I1Az2rBejR1uJuEZzhSA8E3T2m33Xkm42iBRcrv5LITDAm4ut0lYAbuAcZrc6ew+DY3Bk=
Received: from SA0PR11CA0070.namprd11.prod.outlook.com (2603:10b6:806:d2::15)
 by SJ0PR02MB7423.namprd02.prod.outlook.com (2603:10b6:a03:295::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Wed, 13 Jul
 2022 16:45:35 +0000
Received: from SN1NAM02FT0048.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:d2:cafe::ed) by SA0PR11CA0070.outlook.office365.com
 (2603:10b6:806:d2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20 via Frontend
 Transport; Wed, 13 Jul 2022 16:45:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0048.mail.protection.outlook.com (10.97.4.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Wed, 13 Jul 2022 16:45:34 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 13 Jul 2022 09:45:34 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 13 Jul 2022 09:45:34 -0700
Envelope-to: broonie@kernel.org,
 linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 git@amd.com,
 sai.krishna.potthuri@amd.com,
 amit.kumar-mahapatra@amd.com
Received: from [10.140.6.18] (port=54602 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1oBfUT-000DCq-Ql; Wed, 13 Jul 2022 09:45:34 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>, <sai.krishna.potthuri@amd.com>,
        <amit.kumar-mahapatra@amd.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [PATCH] spi: spi-cadence: Fix SPI NO Slave Select macro definition
Date:   Wed, 13 Jul 2022 22:15:29 +0530
Message-ID: <20220713164529.28444-1-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4fd882d-6deb-4f51-4a5f-08da64ef1b7d
X-MS-TrafficTypeDiagnostic: SJ0PR02MB7423:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gOsPBBLO5uKdC8y9vwK+dmekys8ej7iXADh2lgWEJ+0N5q9H7nLaroHDru10JAKeOBwTH6ka1JbbeS+hvOvHwNJpHat80pmXRGlzkvfQStucRBfFrMBoxEgNZ5oHxArEF1C2f7jIvnP8JU8q8F4Vk1dMgzRZqlg+5ds75WDLFIwpDQQdlbopWi7aioDXSLej7LPJ6e36npTThsW+dIkQyQFzajiUcrOj0GhTFNVZHuVcHULngLipNtqiIuLj/lkPN5YKAwV+r3Wc+yuAMfb5h/ccr57U/NTC4UY1gDMZ3sXbXcmQlh3a9uGbMeECERmTGCxreuXcOKmR9l19CMlPtpiIrtPxi6+v1676q04XY4Azypdy2qiAQ7+iV5ZYJAJTRILMa7pWTetLbSVaUd1KiSQemsXZmLm3E9rQ4HXc2lKOXyl67jK4C8RMKkICX5qOUrExowTrJtgPgd3/LOhWUGKKvbp6pPVOsFcBbsTjGQMamuh+rRJ/I5c9BLiDDcR+WYgtVtj3rb8oyXz6IghV32+em2flo8hHAMwlrN1jOD9WrQhKX3poUDgfdb+c1Cq8pGWNZa1a3ahgE3a2QEf58On91NYSCAtUXN65kcIQrkVPhuciyzBdbIKehXPV9V194d2aQYvCfvgnrlc49qZ5vP78AHlWIOi7Vor3Q7NtIBXlXhq+s+1sdO616a0MrOFK1cGFsThsrWIfj+YWbJFvpsvy1G2jSj3aW1jT07Xkz3wo9O/k5+SyBzXfyGl5sn5KBlhhw6clvoH1QvJlr5gjpNQ/bOqZqV50uXw6/fxgnDudIi8AwwKUhnqJng1E0x9HYesMcWaUVyqju7C2zBZtcwXngrTT4xKEJDoALfbZ6+E=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(39860400002)(376002)(346002)(36840700001)(40470700004)(46966006)(9786002)(186003)(8936002)(40480700001)(356005)(5660300002)(2906002)(26005)(40460700003)(36860700001)(82310400005)(82740400003)(83380400001)(47076005)(107886003)(8676002)(478600001)(70586007)(70206006)(54906003)(6916009)(41300700001)(316002)(7636003)(4326008)(1076003)(336012)(426003)(6666004)(36756003)(7696005)(2616005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 16:45:34.6722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4fd882d-6deb-4f51-4a5f-08da64ef1b7d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0048.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7423
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>

Fix SPI NO Slave Select macro definition, when all the SPI CS bits
are high which means no slave is selected.

Fixes: 21b511ddee09 ("spi: spi-cadence: Fix SPI CS gets toggling sporadically")
Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
---
BRANCH: for-next
---
 drivers/spi/spi-cadence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 31d778e9d255..6a7f7df1e776 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -69,7 +69,7 @@
 #define CDNS_SPI_BAUD_DIV_SHIFT		3 /* Baud rate divisor shift in CR */
 #define CDNS_SPI_SS_SHIFT		10 /* Slave Select field shift in CR */
 #define CDNS_SPI_SS0			0x1 /* Slave Select zero */
-#define CDNS_SPI_NOSS			0x3C /* No Slave select */
+#define CDNS_SPI_NOSS			0xF /* No Slave select */
 
 /*
  * SPI Interrupt Registers bit Masks
-- 
2.17.1

