Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6670854F5F2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 12:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380868AbiFQKsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 06:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380514AbiFQKsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 06:48:16 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94772192B2;
        Fri, 17 Jun 2022 03:48:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJG2AcXJiC+k5mWXP5FozdI35EMXw2Tfo46eoIB18tdGolNy142gbe699kYKDpReor4SzCmPAKx1L2GLVr8O3imkEYIsFhKzfoIsrKXGg+bbvElqbKEhr9EXBiOFHcfpXRXsW+qbOgqyEXw8nHfW0VCeiyv9yCFkmJ2H8abW6pFfmQe/LawyRi/lIZnmFTzJl5mfNpvTCMezU4QASqRIT19oNG0bYLIJPS17/ptqBaaYXS5DGqTkBCUBRAQSWqkn48lhoXZv1C/VzGsFT2rgIt9A4xkT+id8Xo4KNvDnXhVpvf0xoXXVjesmsx30sidqzAEfoXdGXMXIlKIKEKRGJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQzEp2+660WAMs2N0VB+RP4Eg5ZmuxHB8GEqAhaakkM=;
 b=iXYkghlTYZvG4dYxtGBso7+MvmJ6auxBPwErUNZYQFp/Yjxb280srzlu3osfCR/+xdyVRj7j5CeuP9op32fkjFX2iRdYAWFvAjoobD+OyPCCdZkrhLua2cCnGAcGJnaqnHOzmA2xC7xhLK3hhU6FYAg6nUXT145BxILI5Kn7i773N8Qm2T/gW5yKKfIYsMOs0VjigJlVCDCdZpzSoEJnM166NL7NliXa+6O8xewynMv108PkD/Gae1fsD5wtuZcyrXMb4zxQuF/H9hy9moxx+3xg2sSIxoU3Xr+xgxIwPPC7Hh1dwtI29Gaaz893/vKYzBtD8uk6ovTg7mpJYJL11A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQzEp2+660WAMs2N0VB+RP4Eg5ZmuxHB8GEqAhaakkM=;
 b=kI/UXC1xdaD6rtf/O3qdMs09cGwCvdeJx8c8Z1n3n/JTc1Skwbws9uAbxgIZcL4yYNRz27PiufUklI/PrcDQn4FEJmQKWIzQjVww5UPXQO2Sn6qzVkyAaXxH8fkw8mWSs91Lf7JmySd4+r3noLnkxtNchQ556jjpzF84pOU/tTQ=
Received: from DM5PR04CA0043.namprd04.prod.outlook.com (2603:10b6:3:12b::29)
 by MN2PR02MB6159.namprd02.prod.outlook.com (2603:10b6:208:184::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Fri, 17 Jun
 2022 10:48:12 +0000
Received: from DM3NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:12b:cafe::fa) by DM5PR04CA0043.outlook.office365.com
 (2603:10b6:3:12b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Fri, 17 Jun 2022 10:48:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT020.mail.protection.outlook.com (10.13.4.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Fri, 17 Jun 2022 10:48:12 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 17 Jun 2022 03:48:08 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 17 Jun 2022 03:48:08 -0700
Envelope-to: git@xilinx.com,
 saikrishna12468@gmail.com,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 linus.walleij@linaro.org,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.23.64.1] (port=60020 helo=xhdvnc101.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lakshmi.sai.krishna.potthuri@xilinx.com>)
        id 1o29WJ-0001R2-Gr; Fri, 17 Jun 2022 03:48:07 -0700
Received: by xhdvnc101.xilinx.com (Postfix, from userid 14964)
        id BFD3021640; Fri, 17 Jun 2022 16:17:08 +0530 (IST)
From:   Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <git@xilinx.com>,
        <saikrishna12468@gmail.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Subject: [PATCH 4/4] pinctrl: pinctrl-zynqmp: Fix kernel-doc warning
Date:   Fri, 17 Jun 2022 16:16:59 +0530
Message-ID: <1655462819-28801-5-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1655462819-28801-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
References: <1655462819-28801-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6b9e3ab-e4b8-4244-5207-08da504ee01e
X-MS-TrafficTypeDiagnostic: MN2PR02MB6159:EE_
X-Microsoft-Antispam-PRVS: <MN2PR02MB61596F2B949F37213BF23557BDAF9@MN2PR02MB6159.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D5IZP56vt/UERjRaBqj3XhPX1hz1Tx5wm34fQO8swzD1dHQLnIxgA3WetrdOZHYdf1GbtTmod2KGO9AUUkJSQs9GQbeCUecryMaI1sun++M4Pw3BfKUO2tQWm3j9LXj/tr709PBXtkwJbYDdO0rPIsSYDXoj+aBy7F5knhf/N4j1bO8P7HavimA6Q5Y2rhcjiFL9ixtpBiFuE/eA/krNnRRCoyPOzSQGA/7kzie2KWLh7WH+y9feTTA/1FOZ8vaT5LVTHQfzGgZG7UWIm9xBkMjab49fANS2Cc9xcBp31lCvi+D+lZFCxZcrNKur7eyNWnhJ7TTZhUSJ6GUA8Ax6R/Uow22McnfblXWHOcISoZSFJvTfmcfWLk8eRNGpF4o2wYUhCVD+IEY9Ob5+aQ7gjWbOEAzNg5dxkuiXEv5mTg7CIe2KYENNF5Cj5RXfte4uthZ7ED1TVy+omlOMv26I+3RepYNPECnd0G2KY8aHCqKLju9Tsf4jPHWs53e/p+zpDdg/I/6KQ0XG3y/0nOgeo4ZcO69Fp+alhTPBAUe+WshiqjVoKfVDMuQy5Zws/cZ+WUGuOM1xpda6XcUwBidC/ZPodckNVLopaxJKvV4EsGmm8lV2JiEcJ6U6Y8QI+dGkxigtrZNKAVDq25vodBb8DH0HPpejZfRIxSexeGhLUXcNQKqrhBY6Kbub55psy2DKVEmC9AMHMug4ItAmrqSQ2A==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(40470700004)(46966006)(36840700001)(83380400001)(82310400005)(8936002)(107886003)(42186006)(70206006)(2616005)(36756003)(110136005)(316002)(54906003)(8676002)(2906002)(498600001)(70586007)(7636003)(40460700003)(5660300002)(6666004)(356005)(4326008)(36860700001)(186003)(336012)(426003)(6266002)(26005)(47076005)(4744005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 10:48:12.3319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b9e3ab-e4b8-4244-5207-08da504ee01e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT020.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6159
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the below kernel-doc warning by adding the description for return
value.
"warning: No description found for return value of
'zynqmp_pmux_get_function_groups'".

Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
---
 drivers/pinctrl/pinctrl-zynqmp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-zynqmp.c b/drivers/pinctrl/pinctrl-zynqmp.c
index b25e9e76fbf8..7d2fbf8a02cd 100644
--- a/drivers/pinctrl/pinctrl-zynqmp.c
+++ b/drivers/pinctrl/pinctrl-zynqmp.c
@@ -163,6 +163,8 @@ static const char *zynqmp_pmux_get_function_name(struct pinctrl_dev *pctldev,
  * @num_groups:	Number of function groups.
  *
  * Get function's group count and group names.
+ *
+ * Return: 0
  */
 static int zynqmp_pmux_get_function_groups(struct pinctrl_dev *pctldev,
 					   unsigned int selector,
-- 
2.17.1

