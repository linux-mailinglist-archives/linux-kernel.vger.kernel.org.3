Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663D94BA96A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 20:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245046AbiBQTPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 14:15:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245035AbiBQTO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 14:14:58 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDEB8D697;
        Thu, 17 Feb 2022 11:14:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iX9/+C5CDscWcxlpGzrFFSHmPZomLuOoV5bWLzwPa+Nx/T2Pop4VpnyefFyMCr8ejiACTZaBge2TCzmb602RtS2paIdXF+mWpS0gYbkkKvMMK6XerVQpwljMDcuSRDi+9Jb4b2a8DnElaD+Tkzx/LWcR5xyYtlajMj0Coyi0RDoeZx1Sv0yyIUJKwfnLZ6vasKhGvO/rTJf0HoweOyJEn5Xb0WooztZMlzrRx+MKhvQn+r60htq48EeV9A6mAu0b4a2RSEXn1NtZ0/cKO6on7Wz/ps5iAUkK03/Udtck8J31Mttv0gLpdN3FsUiL+7avFQggE+B1yVfqiCMHzi/2mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gU76c8YXqyjJqYId7CBqPxg7Qp74rkLTsrT6kIdQTbE=;
 b=N9rLwE9QaQ3KR6fxlejAwp5+l2X3lUiBtThjauSv+XKBpqSaHj1QIwREzG5hTXTEkExeH9hjrlG9bSQS5uY9K6qO25cACjEl7yO6ndz6mS46SIZn0C7CSK8XsmUdDoN7Bahcgz+kbD34JXXBzRRQc0uKD+h2YZ3EewfxCD5hg5zOtoKepzyMQM06izBxSFIMWrZBmOWyknTJqlO/tS/hLKd26yWwMYsgBqI515R4cBoBMMzUGGeHq9M55w6+bYh2wwwak0UDt/c6aP7Fb8VWbkAeacZQHm4XCvpvvuvCAqLpd/toLdTkimbPJUVhuCHRVlTnpBbR3tG9NodILxnCtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gU76c8YXqyjJqYId7CBqPxg7Qp74rkLTsrT6kIdQTbE=;
 b=bcdsiM7xvdv9wQ/zFdRg5k/t9/VqhyXX7LbInIbJNql5VGVq/ZVpBlGfJnlCS5na3t57BK7TsXePcpKHYEGXICDFNouZLlKZsMSENRETXrZ/BllbABPYinSmu4PMcBw08LkMrOE0NbvBPDpzoEO43Oi31AIxutcr1NkOa5kad10=
Received: from BN6PR22CA0066.namprd22.prod.outlook.com (2603:10b6:404:ca::28)
 by CH0PR02MB8117.namprd02.prod.outlook.com (2603:10b6:610:10a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Thu, 17 Feb
 2022 19:14:36 +0000
Received: from BN1NAM02FT010.eop-nam02.prod.protection.outlook.com
 (2603:10b6:404:ca:cafe::23) by BN6PR22CA0066.outlook.office365.com
 (2603:10b6:404:ca::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.13 via Frontend
 Transport; Thu, 17 Feb 2022 19:14:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT010.mail.protection.outlook.com (10.13.2.128) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Thu, 17 Feb 2022 19:14:35 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 17 Feb 2022 11:14:32 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 17 Feb 2022 11:14:32 -0800
Envelope-to: git@xilinx.com,
 herbert@gondor.apana.org.au,
 davem@davemloft.net,
 linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.140.6.15] (port=57270 helo=xhdharshah40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <harsha.harsha@xilinx.com>)
        id 1nKmEZ-0002nF-I8; Thu, 17 Feb 2022 11:14:31 -0800
From:   Harsha <harsha.harsha@xilinx.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <michals@xilinx.com>
CC:     <saratcha@xilinx.com>, <harshj@xilinx.com>, <git@xilinx.com>,
        Harsha <harsha.harsha@xilinx.com>
Subject: [PATCH V2 1/4] drivers: crypto: Updated Makefile for xilinx subdirectory
Date:   Fri, 18 Feb 2022 00:44:21 +0530
Message-ID: <1645125264-11033-2-git-send-email-harsha.harsha@xilinx.com>
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1645125264-11033-1-git-send-email-harsha.harsha@xilinx.com>
References: <1645125264-11033-1-git-send-email-harsha.harsha@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd4a9820-6119-4305-1e21-08d9f249bc4e
X-MS-TrafficTypeDiagnostic: CH0PR02MB8117:EE_
X-Microsoft-Antispam-PRVS: <CH0PR02MB811764963AB432CFF9D08929DE369@CH0PR02MB8117.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VBQeMarPRjAk4QFEL2MyNnXfYB/MJQTGRkIIagWWXSOxuYcOYtDt80UvOJ+nwh4AbPAcTX7LHUB7frDEDmS7hjW0r4HoIf2BcnC1d3vWDFCWciHcbZn0e2TQmUguJu1UBKaSaFLkI6M/c6/D8YPAz8H2N55xW2IxGC12Uuk1lRjHjIYmdi1zTd7HuKbLNSkgx43VPz7mjVT6UEmswo9e24ywg0ANi0SRH1LVomvNd89ptLYfDcn+2OrugZ12YXOlgVSv/66Csu0gCkiUbIsIkCfyF6w5rsggrJ52LzgN7eRa1HssPsUBT874/1SEiRaYC8tzv1BkiQLE4jv5swgRZBWndmyuRPss3VvxtwnLaYdNmfWXq6Fc3NM7SspPl+Q0GtvQgVOJtQgGnSW9AMmPGwVN9eilKntXr/7fF0jd4Lz1xu7hcMr0JRHCovKiWiiQXwTJHOdHH5KHyfKX95IaTBI/1cnUK7px7iEyER+a6+ThNoNyKtfx2GiU0IJTWLT/tsrcMVTySt5JMpKghphtaZj3ilLKjjuNr2DonZg7aJZlGQQhTRfIs0gWtROv87wYgIUPpAJwIuxa3rvzpC3Z8A6Z132pLk1+60gfzGv7fnDKfO8VReMFQkB7sGQzBd9jT6TWXtH/IZtbGBPOjlPrFClaIwUlF+54Lh5OKr1RU63xUFZIQSvyX3JllgBE7FtRlrU8Xg+9Th6W4bxORs5O6vlhIahfGB8SVLVfqyNfqDQ=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2616005)(26005)(336012)(426003)(6636002)(186003)(107886003)(47076005)(7696005)(83380400001)(6666004)(9786002)(82310400004)(7636003)(356005)(15650500001)(36756003)(54906003)(4326008)(8676002)(70206006)(5660300002)(4744005)(8936002)(110136005)(40460700003)(70586007)(316002)(508600001)(36860700001)(2906002)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 19:14:35.4000
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd4a9820-6119-4305-1e21-08d9f249bc4e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT010.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8117
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the Makefile for xilinx subdirectory.
CONFIG_CRYPTO_DEV_ZYNQMP_AES protects zynqmp-aes-gcm.o and it is used
twice (in drivers/crypto/Makefile and drivers/crypto/xilinx/Makefile)
and it is enough to use it once.

Signed-off-by: Harsha <harsha.harsha@xilinx.com>
Reviewed-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/crypto/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index 1fe5120..0a4fff2 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -47,7 +47,7 @@ obj-$(CONFIG_CRYPTO_DEV_VMX) += vmx/
 obj-$(CONFIG_CRYPTO_DEV_BCM_SPU) += bcm/
 obj-$(CONFIG_CRYPTO_DEV_SAFEXCEL) += inside-secure/
 obj-$(CONFIG_CRYPTO_DEV_ARTPEC6) += axis/
-obj-$(CONFIG_CRYPTO_DEV_ZYNQMP_AES) += xilinx/
+obj-y += xilinx/
 obj-y += hisilicon/
 obj-$(CONFIG_CRYPTO_DEV_AMLOGIC_GXL) += amlogic/
 obj-y += keembay/
-- 
1.8.2.1

