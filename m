Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936B252509D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355607AbiELOuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355602AbiELOun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:50:43 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABC5D81;
        Thu, 12 May 2022 07:50:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klNlsx6ZQdfI4x0msYzUlC0+KgSj/pOff7dXLkps6GUre6SZQchMsfuAt+SZzBYvTYVvkNJdtbFWnGkl39JSbG/JlOaophdK3FZq0lNaHs/qELS+FQU0Qc+gBevOwY1z1dNpVvbcfe0ahC7MzgYR0kwyHr3g1hyOT8HvuwivnsuHI7DsHCvAyvbMlVRUjqcm0XReHgBFfmpH7NDktS5Z2tyEclGykNJdlqj8Msk99RdxMdHyrZ0TF5Qfx8TrXy2+UkiKVfSF2j8ogsmvDtxntqUpcO6feZ9RobI6/gYvR3d7t8ww7G2sA27rrb7wPs2sh8jXyj9gzHDQ0KVXd+d0sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5xG+3nNR9+r/gwXjF9AMZIK/Kz5IkJTseOZlxF3Ldk=;
 b=iCSwVQLWsnBmZ3oFwYjGYzjlXebuA4hwLVLG2DwSBfpmphUGf0sfCgtwBlp01bHmVFq+S83GcorpBr2pAzu7wy5TA/2YMKYRVxgHlHwKBZXiRxDyyGAg3XkCzPlKkDIdWmrGnLF7afrC5ncqFszDa0cyZ9gQOWAhZvdYai9+82izwKHxRgOnfWGDjOE1GOigZ8T/8PWs0zHsF1mnfttNtwVjSrmHuluwZS7Z9/nUV1ykIfRKiE9PWdQX0h1dvziEWs7mcqfbcvOnqVTzEvYZfiwa1mAWTrOmlg33hBZDarz8gNP5JQdX04eyptMkiUoUQYNlyiFIP7pfB7ctDuBjaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5xG+3nNR9+r/gwXjF9AMZIK/Kz5IkJTseOZlxF3Ldk=;
 b=bE9i5RZmyB9/PU2L10RkffNzpkObg9UDAR3+YnaEP9Yyw7/M+u8PQ7XQgTwVLqmhtr3PEeWFRIOsA1oVzkIAngPAMUsZAfeZDvA9RKSk+iq105TcNKNyu+sPToSLlBLGX4fAM6pw96QrwBhaddjvR0121/6tOHAJNf05hIcSppc=
Received: from BN9PR03CA0806.namprd03.prod.outlook.com (2603:10b6:408:13f::31)
 by MN2PR02MB6127.namprd02.prod.outlook.com (2603:10b6:208:185::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Thu, 12 May
 2022 14:50:38 +0000
Received: from BN1NAM02FT028.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::fd) by BN9PR03CA0806.outlook.office365.com
 (2603:10b6:408:13f::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Thu, 12 May 2022 14:50:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT028.mail.protection.outlook.com (10.13.2.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Thu, 12 May 2022 14:50:38 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 12 May 2022 07:50:34 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 12 May 2022 07:50:34 -0700
Envelope-to: git@xilinx.com,
 broonie@kernel.org,
 linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.18] (port=54500 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1npA9B-0006j9-7S; Thu, 12 May 2022 07:50:33 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [PATCH] spi: spi-cadence: Update ISR status variable type to irqreturn_t
Date:   Thu, 12 May 2022 20:20:25 +0530
Message-ID: <20220512145025.20205-1-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92b71749-e146-46ef-f8ea-08da3426c735
X-MS-TrafficTypeDiagnostic: MN2PR02MB6127:EE_
X-Microsoft-Antispam-PRVS: <MN2PR02MB6127E80B97147983FDE5B5F1BACB9@MN2PR02MB6127.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EAhr3s3rUw82LpqO+JmsDbK2Rl3EjrOscf8oVKc4r3KX6KOO9I5DoD4N0w9SnPOGp+5oMyskEa8lKvo3fXgljoBgkvkjZQahPSpZhPq0Q9eqGmiFCIrTUhsb4aSPnMAdnhVCCs7BZNCkiXmE0s0CJq741ujRgR603uCyIVCiLMHg9kKYcsYvvjCs9xyjvrM7/W5k+A/b2SP8F9dw0F+vVrBudk0MfbxlX2yi67ik+1eFrSDPZ3pHvPNQeQBogrdh0fOlOAFc+zAVOW8v1XLXWwqWkT9Ed/HIXW1jC1ZW4Id6qq0Z1ECQ1+tjAWFS03ulduwqHkYxPNtvvk/4lHjs8WCrFkuxbHo7IXeItrqQPra1DGPjB57POtZbEx1wBjhyOCiqLaRccZY/6XYPpMXWSfmLkrDK6V479b0udGaE0Cuc0MQsexmjGe2Hs+iXIRy1MUcvhwe/gxKtqYN5WU26Op2ViaMoEEID1xCh3ca/MM13KzifAdeFCuF+Ew+bnouQo/Aay0X5OBNWBJcRwtEwLwLtBnWlZD52jHJpWhPWX0cam4/cLL1qvcPRVBf+Y8RXZQwJQtP0gmnuEFDp64IhWAxLFoeb8nIGQkVgki3l3LJLMSf5wU+ka5RqqulJ1NyvJrQCDQTaGP+BtLiPJKksPvfmiJjTPN6qvQ6kAPPAXUSENvVl9p5WzaHTkYccvEdT+KjpiIw3YJBOLdrBDzrfMA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(15650500001)(6666004)(7696005)(4744005)(9786002)(8936002)(5660300002)(508600001)(7636003)(83380400001)(356005)(36860700001)(26005)(2906002)(2616005)(107886003)(1076003)(40460700003)(47076005)(426003)(186003)(336012)(6916009)(316002)(82310400005)(36756003)(4326008)(70586007)(70206006)(8676002)(54906003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 14:50:38.0388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b71749-e146-46ef-f8ea-08da3426c735
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT028.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6127
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Data type of status variable, that hold the return value of the ISR,
should be irqreturn_t & not u32. This patch updates status variable type
to irqreturn_t.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
---
BRANCH: mtd/next
---
 drivers/spi/spi-cadence.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index ceb16e70d235..115164295a6d 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -342,7 +342,8 @@ static irqreturn_t cdns_spi_irq(int irq, void *dev_id)
 {
 	struct spi_master *master = dev_id;
 	struct cdns_spi *xspi = spi_master_get_devdata(master);
-	u32 intr_status, status;
+	irqreturn_t status;
+	u32 intr_status;
 
 	status = IRQ_NONE;
 	intr_status = cdns_spi_read(xspi, CDNS_SPI_ISR);
-- 
2.17.1

