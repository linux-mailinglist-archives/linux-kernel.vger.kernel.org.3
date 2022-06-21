Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E147F552DB2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 10:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345960AbiFUIzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 04:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348453AbiFUIzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 04:55:13 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF65E18348
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 01:55:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=km6V0RKK3y5Y80jfNhVmfFNU0TiJ/vgl7OwHWug9n9SCpD4EFiaUOX9XoIUlUG01uM2hsy47clfUDDz+4KgzzRThs7ij9QyptvA6VgemhGw770bujsuNBzp01hCPqTbQrnhstwuxB96BBPW63PjTw4v6rvviMb/zQS3BL4tTpTJT9LIqbXlSdXnBzx+PZrDjL4+xgSaAfSzRzqfgC1Qe+Otpvm72GMTAktKi1Li8uRCDV2YHEgSkqkWyMM+VHYpWD6q8A9zf19oAlX34XopCcPm7MZQW2oZpKUZ0W3ZTHszBC3OfPeS0J76jpcSlzifEehwuAalkawA3lXuGHvBVbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWuhFKZkoR9XhhCvX8b1gJ1Kcm2UEsDerZQ3fiBrzK0=;
 b=m5wNc03JidsKI7kB7bI3S3KnsNGNgRbpXCn5gDgXUYCvgt6cUWs6APZPmO0iE5OXazZkuCpX97w2X/ZwVTaeyNoOFD6+13KVM3Y9fswRJFEAqCWcrNWefZsjcmlg+AxHBSPebQrkPx0re4cmBRluVlM4If8U/KUuALMMCM9l50ADi4erOzp2NsD7vcE7Qe7GWKDeA/zciZD+KV2z05GxmrK/qTe3sq+uzNwNBqzfUx6vl4xzCcjT7gAB3aCf8L5q58JB0IvFy4DrrxisdJjDVnvXxnNhDDIE/2D553fJtJ90QO7dqzyNm5ksMSikGh/6QAtDU86gzYI8flIK1x9zAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=bootlin.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWuhFKZkoR9XhhCvX8b1gJ1Kcm2UEsDerZQ3fiBrzK0=;
 b=A/72gAAIPwUAv1+0OM2h2KZRJDa52ibuBOGOGda4/kHXUrJCQGNg6Hps95YTDK1u6xNwtrKRZkCl2hGUcRaMJdgN3oDt5nDkU6z3wRAEcUAlLbHvxjfeSzdJ3Pofgl4u+Gf92963m+jUyd5cs4jhUZD/cgJ4x98rWgeG6tYgl/c=
Received: from DM5PR07CA0089.namprd07.prod.outlook.com (2603:10b6:4:ae::18) by
 PH0PR02MB8732.namprd02.prod.outlook.com (2603:10b6:510:db::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.17; Tue, 21 Jun 2022 08:55:09 +0000
Received: from DM3NAM02FT034.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::71) by DM5PR07CA0089.outlook.office365.com
 (2603:10b6:4:ae::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16 via Frontend
 Transport; Tue, 21 Jun 2022 08:55:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT034.mail.protection.outlook.com (10.13.4.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Tue, 21 Jun 2022 08:55:09 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 21 Jun 2022 01:55:08 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 21 Jun 2022 01:55:08 -0700
Envelope-to: miquel.raynal@bootlin.com,
 vigneshr@ti.com,
 git@amd.com,
 boris.brezillon@collabora.com,
 linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 amit.kumar-mahapatra@amd.com,
 akumarma@amd.com
Received: from [10.140.6.18] (port=52928 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1o3ZfA-0001C6-7b; Tue, 21 Jun 2022 01:55:08 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <miquel.raynal@bootlin.com>, <vigneshr@ti.com>
CC:     <git@amd.com>, <boris.brezillon@collabora.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <amit.kumar-mahapatra@amd.com>, <akumarma@amd.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [PATCH v2 1/2] mtd: rawnand: arasan: Update NAND bus clock instead of system clock
Date:   Tue, 21 Jun 2022 14:24:59 +0530
Message-ID: <20220621085500.1005-2-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220621085500.1005-1-amit.kumar-mahapatra@xilinx.com>
References: <20220621085500.1005-1-amit.kumar-mahapatra@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb0122d4-8e1c-419d-b76f-08da5363bec2
X-MS-TrafficTypeDiagnostic: PH0PR02MB8732:EE_
X-Microsoft-Antispam-PRVS: <PH0PR02MB8732F080BBC834BCB665B347BAB39@PH0PR02MB8732.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: adZRKBIUMNp7Hn8lb+8y9lf/XlBU3c688pvFDtPhAC194RZ818vQNLIvkVl53fV4ReSnzkuBnIn0Ni0gQ05yQQwktm/iAy4wK3uZf9O/K3isW0Wcl1gswR/os9FcEM+Dc2dcOnNLyIyPDkiOfuXP9ZV7WcbfLoYELS3asCUE8kjX8Q02j0r0xspxoMAC33NUwUAioMKR2Z3GXiNBeIorCgCwDsW1cZ3iatqbWhyVy1f8nuNMxulJuiLbC/IsUnv/O2zFNYywfUjLj1b66kpHo8RWVfXXgEBKJBGN2nu8qd0S8nyQGE0ZoIT9Oe/xGuStYp4T07zkb3EtEFEPCibVvt3Ug+8xPTGXOWhdvIreJ0/meIIrd/4uXYaU9LbSzQb94b/osZrdkWDKPbEmuOkXVZ1qfWXW7JVyfyI7/p4fT1GfqQocs89PAIYpycGZwL5dtd3IVBH2qx/5JLI+iWCG9/DKVYcA7u0noKxkeZZFns31qymcpsuotU+17a5mqA5Sqh5SLOeqULrifurEQyejRc51rfSDMgPInTsezlu5k+MQeLVYu8gVDhSoeeoLchAUj9gJVTWXJsC8YyRiDRSPFI3PThPKrJtQ0us0KuS0bLGmZIBM3SU61piCh8nXg7oNQ2aH7tWFkAMCtBOdSJ3/TbsetUmFWDp+a6gjFP/TpB8Ki8qDFkdei6Wr/+y02t1Pg/GgCaPr7AldBiXegVDy9ewde8Y8gkji3irntIjQQpz9CjVI75mJpdk6wmbyQryp
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(136003)(39860400002)(346002)(46966006)(36840700001)(40470700004)(356005)(107886003)(4326008)(7636003)(40460700003)(478600001)(26005)(82740400003)(15650500001)(70586007)(5660300002)(36860700001)(36756003)(70206006)(2616005)(1076003)(8676002)(7696005)(41300700001)(6666004)(82310400005)(316002)(8936002)(110136005)(186003)(336012)(426003)(47076005)(9786002)(83380400001)(2906002)(40480700001)(54906003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 08:55:09.2708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb0122d4-8e1c-419d-b76f-08da5363bec2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT034.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8732
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In current implementation the Arasan NAND driver is updating the
system clock(i.e., anand->clk) in accordance to the timing modes
(i.e., SDR or NVDDR). But as per the Arasan NAND controller spec the
flash clock or the NAND bus clock(i.e., nfc->bus_clk), need to be
updated instead. This patch keeps the system clock unchanged and updates
the NAND bus clock as per the timing modes.

Fixes: 197b88fecc50 ("mtd: rawnand: arasan: Add new Arasan NAND controller")
Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
---
 drivers/mtd/nand/raw/arasan-nand-controller.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/arasan-nand-controller.c b/drivers/mtd/nand/raw/arasan-nand-controller.c
index 53bd10738418..4f6da82dd2b1 100644
--- a/drivers/mtd/nand/raw/arasan-nand-controller.c
+++ b/drivers/mtd/nand/raw/arasan-nand-controller.c
@@ -968,6 +968,7 @@ static int anfc_setup_interface(struct nand_chip *chip, int target,
 	const struct nand_sdr_timings *sdr;
 	const struct nand_nvddr_timings *nvddr;
 	unsigned int tccs_min, dqs_mode, fast_tcad;
+	int ret;
 
 	if (nand_interface_is_nvddr(conf)) {
 		nvddr = nand_get_nvddr_timings(conf);
@@ -1043,7 +1044,11 @@ static int anfc_setup_interface(struct nand_chip *chip, int target,
 				 DQS_BUFF_SEL_OUT(dqs_mode);
 	}
 
-	anand->clk = ANFC_XLNX_SDR_DFLT_CORE_CLK;
+	ret = clk_set_rate(nfc->bus_clk, ANFC_XLNX_SDR_DFLT_CORE_CLK);
+	if (ret) {
+		dev_err(nfc->dev, "Failed to change bus clock rate\n");
+		return ret;
+	}
 
 	/*
 	 * Due to a hardware bug in the ZynqMP SoC, SDR timing modes 0-1 work
@@ -1052,8 +1057,13 @@ static int anfc_setup_interface(struct nand_chip *chip, int target,
 	 * 80MHz when using SDR modes 2-5 with this SoC.
 	 */
 	if (of_device_is_compatible(np, "xlnx,zynqmp-nand-controller") &&
-	    nand_interface_is_sdr(conf) && conf->timings.mode >= 2)
-		anand->clk = ANFC_XLNX_SDR_HS_CORE_CLK;
+	    nand_interface_is_sdr(conf) && conf->timings.mode >= 2) {
+		ret = clk_set_rate(nfc->bus_clk, ANFC_XLNX_SDR_HS_CORE_CLK);
+		if (ret) {
+			dev_err(nfc->dev, "Failed to change bus clock rate\n");
+			return ret;
+		}
+	}
 
 	return 0;
 }
-- 
2.17.1

