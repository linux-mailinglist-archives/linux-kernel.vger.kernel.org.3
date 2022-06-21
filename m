Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6D6552DB0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 10:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347005AbiFUIz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 04:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347789AbiFUIzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 04:55:16 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BC626548
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 01:55:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sr+o4DvsNLqAVk2MvDSAnT0dA7XaRgsZoGI614FA3tFY3zgfppofiLqk0ed6Pp179pDfCN+viY+MIBMb1UbHOf8+LwDK1mbn9K6JnhuEcc1tyOTD0w/o0G0yqCZW0aiPlNoKi4rG7h76jvpac3cKvwaxmIBNQOi26zs+scHfVmxvq/kXoWFb7Or+0eGcR6lww23M5b/MJWvfyLMq8JequdKQKyn0w7DI3eHFrdIijwixD6gARnkg4AnA1402C0fZZhYJnmic8Uo9zP4gfBmVS1nGWGcdhWDjk1BPwC2HQEeVX1bmN9OUi56f2PB9KHEe/Jm5X3iHZxuD2xTvoYQDDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZW0J+X5TWejUyOhD5XIfImghS1Scp3II4SE73b99VLs=;
 b=GPuI3XemyOMKuSrXSlSURq9CNa9Xq8C7eVE6EtUvaN59z1TE79RhaNbSg/x+qG/F1+/rcC6OyT8Rg0b32+NY4BmTN8nSGkA/gEO9V6BZKmP42WW1MSv1KVkfr/yq0AQAgzeCb4CqygAcKKAcaK8m8dzP0g1BPK+ifIng/fYhV4G48JfGeOVQrReZkxVI0zwrJ10tyHtpwGExw4HeQE8o63PGVENfLP1+qnK7bec4eUaY9zDIqIJ0RKK5uRWGL3ndVawKDAGhcjO3NCJwxdNrTHmPKmyg2/K0MnBz6cycAA9ge2SCKEqd8EvFbowMa4VDaxCdpfwrv0E6/9w3nWJZ4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=bootlin.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZW0J+X5TWejUyOhD5XIfImghS1Scp3II4SE73b99VLs=;
 b=rZwZ3GcHG4QRi/JGR0SVybse9KtyNNQXTFJaxCyC9AiiCbqtCeXdhT6C0huB6hwob+VXCGNltdD1FTkTFc2opm6MzEnjMWZUdHZASow9UR0sgXPcKOL+fuqPM7GqN3KU7SnfjnZ2+B+izKrXnA1/jJE6SGzYn3LMewlRAy5d/Ak=
Received: from DM5PR05CA0018.namprd05.prod.outlook.com (2603:10b6:3:d4::28) by
 MN2PR02MB6352.namprd02.prod.outlook.com (2603:10b6:208:1b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Tue, 21 Jun
 2022 08:55:12 +0000
Received: from DM3NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:d4:cafe::62) by DM5PR05CA0018.outlook.office365.com
 (2603:10b6:3:d4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15 via Frontend
 Transport; Tue, 21 Jun 2022 08:55:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT057.mail.protection.outlook.com (10.13.5.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Tue, 21 Jun 2022 08:55:12 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 21 Jun 2022 01:55:11 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 21 Jun 2022 01:55:11 -0700
Envelope-to: miquel.raynal@bootlin.com,
 vigneshr@ti.com,
 git@amd.com,
 boris.brezillon@collabora.com,
 linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 amit.kumar-mahapatra@amd.com,
 akumarma@amd.com,
 okitain@gmail.com
Received: from [10.140.6.18] (port=52928 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1o3ZfD-0001C6-6I; Tue, 21 Jun 2022 01:55:11 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <miquel.raynal@bootlin.com>, <vigneshr@ti.com>
CC:     <git@amd.com>, <boris.brezillon@collabora.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <amit.kumar-mahapatra@amd.com>, <akumarma@amd.com>,
        Olga Kitaina <okitain@gmail.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [PATCH v2 2/2] mtd: rawnand: arasan: Fix clock rate in NV-DDR
Date:   Tue, 21 Jun 2022 14:25:00 +0530
Message-ID: <20220621085500.1005-3-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220621085500.1005-1-amit.kumar-mahapatra@xilinx.com>
References: <20220621085500.1005-1-amit.kumar-mahapatra@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c78179e-796c-4f11-8858-08da5363c06b
X-MS-TrafficTypeDiagnostic: MN2PR02MB6352:EE_
X-Microsoft-Antispam-PRVS: <MN2PR02MB6352B51A9315E31F4594ADC1BAB39@MN2PR02MB6352.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p/vNif7jf/BSVCHiygeHIH2lTn3HBspbNhZldG3G+V+p8SqeinWrQnwVgxsSmnGjcMdpSeJCf+ABYJn6K7UK7I+cT7s8DwWhPorZov8qDDgnKQm3PNyXeSVROPiFi5eDCqXbxH3oKSG/serYX1dvxqv72ahQj/twvz22MKPjkmd2vngGHjs6fEFt6y+nunFnhD00KRLOfhwmqudPj+hJp+Rji5Dw/cdxW1ze9K1zTJ6WQJhux5dIVsn0OkqB6lnicmznyFHriIO5QfguMRBrBVaFhSQfyS2acOhMFs1aFQe2+gCusThdT4B4kkq3inn+Z2x0NuuCWrf++Jf841U9Qbr7Yet8LgdaY+Z1YhehfJLTlmPa9B+13eqsWc+GoePPnqVbas+9k1rFhBS1SKTg8R5jFEtXsjSKIYoFj2vWP7lLS7SAkGLy4E4AOw+Kh1H+ix8oR3nnESu8ooCfZV3anFgqwV4HHyoQMCx4RfDQAFNtYmVqjeZK5GPBaKqtOTE55sYD9BMMF/ZMko7tuFBTJUneB0gN9wqzT5FJMBG/So3S/Zs/+R0s0zUm+wLXWKGD7qe8wzo1HRstbsWtsRQAsxcriqu+Hrs6BhFoTSOmwaDOtdKvBNvsMM0T7ZA3DdUG7/9KmIRFoILeaY6SdWpVn1ytUm2uL5ssxOR2bE3awMzQS5O3Ivf11rR/PebsiSjohUw8gurvQAaJ7NR9VoUMedjjIDiaxoyy/xBPECmQ+jElGxthDJEuDCsyGNRLpBjR
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(396003)(136003)(36840700001)(40470700004)(46966006)(7636003)(2616005)(41300700001)(107886003)(426003)(336012)(1076003)(6666004)(82740400003)(186003)(7696005)(47076005)(36860700001)(356005)(26005)(83380400001)(36756003)(8936002)(316002)(70586007)(70206006)(9786002)(82310400005)(40480700001)(4326008)(5660300002)(2906002)(40460700003)(110136005)(54906003)(478600001)(8676002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 08:55:12.0549
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c78179e-796c-4f11-8858-08da5363c06b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT057.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6352
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olga Kitaina <okitain@gmail.com>

According to the Arasan NAND controller spec, the flash clock rate for SDR
must be <= 100 MHz, while for NV-DDR it must be the same as the rate of the
CLK line for the mode. The driver previously always set 100 MHz for NV-DDR,
which would result in incorrect behavior for NV-DDR modes 0-4.

The appropriate clock rate can be calculated from the NV-DDR timing
parameters as 1/tCK, or for rates measured in picoseconds,
10^12 / nand_nvddr_timings->tCK_min.

Signed-off-by: Olga Kitaina <okitain@gmail.com>
Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
---
 drivers/mtd/nand/raw/arasan-nand-controller.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/arasan-nand-controller.c b/drivers/mtd/nand/raw/arasan-nand-controller.c
index 4f6da82dd2b1..0eff069d7f80 100644
--- a/drivers/mtd/nand/raw/arasan-nand-controller.c
+++ b/drivers/mtd/nand/raw/arasan-nand-controller.c
@@ -1044,10 +1044,20 @@ static int anfc_setup_interface(struct nand_chip *chip, int target,
 				 DQS_BUFF_SEL_OUT(dqs_mode);
 	}
 
-	ret = clk_set_rate(nfc->bus_clk, ANFC_XLNX_SDR_DFLT_CORE_CLK);
-	if (ret) {
-		dev_err(nfc->dev, "Failed to change bus clock rate\n");
-		return ret;
+	if (nand_interface_is_sdr(conf)) {
+		ret = clk_set_rate(nfc->bus_clk, ANFC_XLNX_SDR_DFLT_CORE_CLK);
+		if (ret) {
+			dev_err(nfc->dev, "Failed to change bus clock rate\n");
+			return ret;
+		}
+	} else {
+		/* ONFI timings are defined in picoseconds */
+		ret = clk_set_rate(nfc->bus_clk, div_u64((u64)NSEC_PER_SEC * 1000,
+							 conf->timings.nvddr.tCK_min));
+		if (ret) {
+			dev_err(nfc->dev, "Failed to change bus clock rate\n");
+			return ret;
+		}
 	}
 
 	/*
-- 
2.17.1

