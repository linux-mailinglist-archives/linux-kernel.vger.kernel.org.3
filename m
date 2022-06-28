Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658F855E708
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347571AbiF1PtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 11:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348000AbiF1Psj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 11:48:39 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D1B27CE8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 08:48:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPZzkr9Iv8MRjxAEZQMKB4MB65E35ewKWKTSLyMrLuVSMMiX1ZJ+ZyAfhGD9pXBWu263/LWHIx3kPW+r79xmI7pZWFhoGzAc+1I0o+BnSk5SRc7roLANYZME83bgikktdq2Ib3zWkGgvuksueu6ViHdAsZs1+gNDkAJJukz88xEXxHeFU7l0l+yhUD3Tx0R0FZi4/1arKFYwdww0vw5rrYJTJGqs8+V7rFA4i4j2DZhZd91jMbN6TGN/MLL42YcFD4jfkQ3mYYFcRQ/s7Ogl9zm8vFlCELZsCyajzpjSDyDlDxffiGIvMUBptfiZQ5mc14GCap9UcrYR5E5Kg5hlHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azLm4BkNw4f8sVxdNWbWIR2HEv48QjO+z/4GvNzgrxI=;
 b=aqLyLn+H9VQ4ZKFvy0As7p9LfPaHJLn/7jTa8O2phVs3kMeIAJUIK1YkxGliThNdTkW2Mojk3GX2sUiW85Rq6RzDYEAERqDrn11JtyRrQGG41pnvIbfDemMU42DbX30M38tj8Vvb59B159OoZG+XHdYRmg5kdU5HyTsMJDeGvGM+wMEn29c2nmNSud0tTdbpuB+uS+xHewIWN+3zoFlkkHtSW4PdTOTwWKxEuhVs5AD5O8NY0Xm7whhNzUu0nPF/5bbXZDnuc/2I5f6V1zQ4XsOpnnk4IrsfIp5494YLEMqYFp+DRGKXyzNVOj8m/ogIPzq9Ke0/cjvvvnIeGktKpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=bootlin.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azLm4BkNw4f8sVxdNWbWIR2HEv48QjO+z/4GvNzgrxI=;
 b=mI4700cTFhlv0IK9HcwwX5ZgLY01Xd8lDrbRHJqju3mvj6M/XCIx9u8/KPaZ0q5r3TfEDV0IJ8q4WDX39Zq3bEjmk3Kccu/mwWOqaXn9bwoKXySUoH1//5Z2dY8KbviwfMEBbPrhbeJSuN3EY/hV5Kc8cwUD5XRG3qjj6L10BjI=
Received: from DS7PR03CA0303.namprd03.prod.outlook.com (2603:10b6:8:2b::19) by
 SJ0PR02MB8628.namprd02.prod.outlook.com (2603:10b6:a03:3fd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Tue, 28 Jun
 2022 15:48:31 +0000
Received: from DM3NAM02FT031.eop-nam02.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::ef) by DS7PR03CA0303.outlook.office365.com
 (2603:10b6:8:2b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15 via Frontend
 Transport; Tue, 28 Jun 2022 15:48:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT031.mail.protection.outlook.com (10.13.4.184) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Tue, 28 Jun 2022 15:48:31 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 28 Jun 2022 08:48:30 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 28 Jun 2022 08:48:30 -0700
Envelope-to: miquel.raynal@bootlin.com,
 vigneshr@ti.com,
 boris.brezillon@collabora.com,
 linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 git@amd.com,
 richard@nod.at,
 amit.kumar-mahapatra@amd.com
Received: from [10.140.6.18] (port=39110 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1o6DS1-000ELN-OF; Tue, 28 Jun 2022 08:48:30 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <miquel.raynal@bootlin.com>, <nagasure@xilinx.com>,
        <vigneshr@ti.com>
CC:     <boris.brezillon@collabora.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@amd.com>, <richard@nod.at>,
        <amit.kumar-mahapatra@amd.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [PATCH v3 0/2] mtd: rawnand: arasan: Fix clock rate in NV-DDR
Date:   Tue, 28 Jun 2022 21:18:22 +0530
Message-ID: <20220628154824.12222-1-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5d45bcb-37fb-47f2-6a67-08da591da6a6
X-MS-TrafficTypeDiagnostic: SJ0PR02MB8628:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JlHsSOrDY8y4jkgquyIhiWz/xdKyUzdaz3MN+hWH3tj21Sp9zbj9Xydo0ovOijo2giJ1I/ZuKfF6xQ7EwQmsNSEgTZI7SmW02eUji0DTWmTt144s28cvPKdzsbEgN2fB17wmTW6KbjjDoLfq5Q1azRP98wiI+irnCarDMzW+/bDNR9GQbdCEH2sEWqLcNXG5ltBNaoi9uSmKI8sO9SnvNGzXEGMQsKhlbGQW6YPg2v+nZp4JV50vzDmPjKU5IEyq0c3atKXe/Y5FdSloOcZCDcHLRNO1BeyMbKD+fqgpSrfqVuk7XDHdmwbLiFDwixwFkUCV8fRnjKAk+sWZoVyNlnNa3dZPl9a27mab1UsavYTw1AeC9EXQjfEQIxGQCpbZ5+Xr6876ejldl9d3nqAGyguzW2XgbbTTXcry5SUNsNDZ1iZAQlwbK5axMce06p/y0aFu9D7t3mvKVJyA6pEATshtG49nHZpcYptQx4Wp6SLJmV/TddbBWAMrFrQKnCFeIRQAsD1vJfzM42JnioB06/qrDAQYz/UjQuLYecB/uz/saDFrHC9lJFIPpWv7MDbv9BzOHeIoAFYGSLuONOYmdhqwfAFU3Uedhjldg4kJ+RVs+92UnZCNh7Us0+0Wipwd6YpJI+fvBV6WYdw2QFTpFiVhiCE96vR1hV6yT6xRcIJ86GmKSkCJT48iw1RMsi9wNGNAdq1it6kkH5MD+Nx/7CW6VyDjxl8FZdHTHVrEnfuXdRSTmLNSTirX39JHXlEeifEAWXOX23LVIm/365DU4Y7AJDjy2v2SFvCPL8ccebjeUK/2oE1km2scjdTHeHimOhr2PCaXsZICUUWkDGHRk7SmjSKcpAIO4cs0W9Yx6/w=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(136003)(376002)(39860400002)(40470700004)(36840700001)(46966006)(82310400005)(110136005)(316002)(36756003)(47076005)(36860700001)(40460700003)(40480700001)(54906003)(70206006)(426003)(70586007)(8676002)(4326008)(83380400001)(7696005)(82740400003)(2616005)(26005)(186003)(6666004)(1076003)(336012)(107886003)(7636003)(356005)(41300700001)(2906002)(4744005)(8936002)(478600001)(9786002)(5660300002)(966005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 15:48:31.0256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d45bcb-37fb-47f2-6a67-08da591da6a6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT031.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8628
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on upstream discussion here:
https://lore.kernel.org/all/20211127180758.30884-1-okitain@gmail.com/

This patch series:
 - Updates NAND bus clock, instead of system clock, as per the timing modes.
 - Fixes clock rate in NV-DDR
---
BRANCH: mtd/next

Changes in v2:
- Add a patch to update NAND bus clk instead of system clk

Changes in v3:
- Set the NAND bus clk in anfc_setup_interface
---
Amit Kumar Mahapatra (1):
  mtd: rawnand: arasan: Update NAND bus clock instead of system clock

Olga Kitaina (1):
  mtd: rawnand: arasan: Fix clock rate in NV-DDR

 drivers/mtd/nand/raw/arasan-nand-controller.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

-- 
2.17.1

