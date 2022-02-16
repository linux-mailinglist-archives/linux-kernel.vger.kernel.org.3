Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFF84B7FD0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 06:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbiBPFBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 00:01:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiBPFBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 00:01:20 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2423E6BDD0;
        Tue, 15 Feb 2022 21:01:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=foG3ZiM/UjbUBtvPTwifTE+fBFnfYzSSvckL1Fy2VUaojRaEMecAA6nQxY7S42tC8RbnwhSOgL7XfanWlFLhG/QQ9xcItVL4GsN8tqxE4ZohiSVPo3orSoag5daTsTZMrZTdXyMn5zYjwGJ0hVx3buHdntFvHx0K23+d3KyRMXdQR1kgEOkD16RGvq9POUtx9ksXlFRqKI4CwNgkOQb2ZB05sXL638WX/Loruis/o2aXqCih6MiN3qcY9UMiXcZzBOcQkSSBoBPti1dcsci+m9gzNWV4gJbDqmfIuurkDlRtPQcjdJkuckV8oD19mNNLqjm5Ye789PNBYYGXlTTXWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PLJXC8yVy6nfCNJ8CK/0HnWl2IFBeEp0FZppRd0YO8=;
 b=F+e/XBnxUUr0IRJb4DpRt1fanaL1QBKVp3BeE33igKg1oW+GEZpWCsV0A17iL+yUSL2aVzK5hSTtaB7Qy4/O2K4FBRFf4T4J916ZaFwiluPw5A9mNWLI16w8QRgTG3ylve6Sw16i+gcoTUuc1QAtEOHVbRbK5EL75tUHj+0Z/XZrPF5lfp3+O6TLl31ckH59L+swJdp/hJED3wE4823pQEeqN1frbWdr6aswjJx8Lrq9QKo0AaD7cFmwBVkej55/ZyYG1wNciUnuoRPqkDcemUjMKjter7TCJGRiftkHz99PGiWwoq693yz5gKwritPcPylx9MlHH4heahIWnTfNMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PLJXC8yVy6nfCNJ8CK/0HnWl2IFBeEp0FZppRd0YO8=;
 b=BnwkBllPbm74A7A6Nq3iun3UKA8mAZIxzXHqlvSAxXvBGBL56JWy0d59o60nc55pgpZ56iYOk5BAf1SjY5vET/3LdsKuy9KD0UKpz0K8kRpRfr3e2dXGavbRkeEegXzZo+m/mmGI8ajHIJneBiinL51DTTbwyzscPRm2i1bFiBk=
Received: from BN9PR03CA0040.namprd03.prod.outlook.com (2603:10b6:408:fb::15)
 by DM6PR02MB6666.namprd02.prod.outlook.com (2603:10b6:5:215::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15; Wed, 16 Feb
 2022 05:01:03 +0000
Received: from BN1NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::34) by BN9PR03CA0040.outlook.office365.com
 (2603:10b6:408:fb::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Wed, 16 Feb 2022 05:01:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT019.mail.protection.outlook.com (10.13.3.187) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 16 Feb 2022 05:01:02 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 15 Feb 2022 21:01:01 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 15 Feb 2022 21:01:01 -0800
Envelope-to: dwmw2@infradead.org,
 yilun.xu@intel.com,
 mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.93] (port=55278 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1nKCR3-0001Qv-9Y; Tue, 15 Feb 2022 21:01:01 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 01EDA6010E2; Tue, 15 Feb 2022 21:01:00 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <devicetree@vger.kernel.org>, <robh@kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-kernel@vger.kernel.org>,
        <yilun.xu@intel.com>, <maxz@xilinx.com>, <sonal.santan@xilinx.com>,
        <yliu@xilinx.com>, <michal.simek@xilinx.com>,
        <stefanos@xilinx.com>, <trix@redhat.com>, <mdf@kernel.org>,
        <dwmw2@infradead.org>
Subject: [PATCH V2 Create empty OF root 0/1] XRT Alveo driver infrastructure overview
Date:   Tue, 15 Feb 2022 21:00:55 -0800
Message-ID: <20220216050056.311496-1-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b82913d1-bc1d-4047-e8b8-08d9f1095483
X-MS-TrafficTypeDiagnostic: DM6PR02MB6666:EE_
X-Microsoft-Antispam-PRVS: <DM6PR02MB66668AD7AD0BFBE131100FC8A1359@DM6PR02MB6666.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oNsCqoURdnV5BP0POsZRTFMGESRnqzoGrY0gkdG/FVyX2LpOaGNcHRCA5+qzsyfYA4CxCD5kwl5eDokutU0U+5Oxgcgbv9fBYz9fjESzpO4KvWrPV6u0ZB9RbXtjeVy+m/Wwb929UgYxhYrOQnOWaOOsOV2uPfUrhprQrqi2Lm+A1mxWG+GIXBIdM7Vva4NFp2x+aR4P8lBQZ4usEMfoVYHyrZz6N4msYNDLHCRO93khqVzHSop1q4uwEVuBc1NcwBg6XOAcd4/mhDmfdoGib/W6Qc/0xqLLzi/+Yyi/mRG9pFEzKD0WrZYUSMfo1geXmy2eg8njPboHVNL81A3aYUHeGNZ2PBJ/LPC+9rB8F+xBUcT5sW6BdIgJc8I2J3A2DKQPrI7ea99OZdjcC4XtitWAZDRI2f5KISbk55aDYVeybqmtVhJqzDF59bmTrUwU61ngdOkMNrZ/csigChbOs0m0zOIkhuT2KHWSjy50lLCMuQwnXtaq6pbJT8akBhpMwmxlLVt9GyHKcyMkwjDqxUmdqjSOJ8IYLgILtqRzKD5DmYRws3pOJDLuc6gU6y2XRBnhX1apvoE4AVZWJTQSa8YRvUm6wk657q8L3Xi3jrHMKlgoUCEoC0+y4mCAlyVsmwi61Q5SiFbvljVhpP0bTjmFNDfjQw0oI4juvAuQD2cwJyG+vh6ci25manEeTa3vhg5bSnHTjgjoF3h4AmcnZ9gBLNgmgltQK+81UKlJi3Q7A6TjVZmelAhrN4Gec8RruOWiXTszCaSn6nY3ziA+AlipV381aHPebxuX/f4/cwBf41cV8go57u8Oo9RjFGOG
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(356005)(6666004)(7636003)(4326008)(82310400004)(2616005)(1076003)(8676002)(336012)(40460700003)(26005)(186003)(426003)(70586007)(44832011)(70206006)(8936002)(5660300002)(6266002)(47076005)(36860700001)(966005)(508600001)(36756003)(316002)(2906002)(110136005)(54906003)(42186006);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 05:01:02.3160
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b82913d1-bc1d-4047-e8b8-08d9f1095483
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT019.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6666
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch is to create an empty device tree if there is not one. For the use
case that hardware like Xilinx Alveo PCIe accelerator uses flattened device
tree to describe apertures in its PCIe BARs, a base tree with nodes for the
device needs to be created if there is not one. Then the flattened device tree
overlay from the device can be applied to the base tree. Please refer the
previous discussions with device tree maintainer:
    https://lore.kernel.org/lkml/CAL_JsqJfyRymB=VxLuQqLpep+Q1Eie48dobv9sC5OizDz0d2DQ@mail.gmail.com/

This patch is the first step creates empty OF root node if the arch does not
have device tree created. I will post a follow on patch series to add PCIe
interface for the creation of device tree node for a PCIe device. This will
enable a PCIe device driver to apply an overlay under a PCIe device tree node.
Please refer previous discussions with FPGA maintainer:
    https://lore.kernel.org/lkml/20220105225013.1567871-1-lizhi.hou@xilinx.com/

We would like to use this infrastructure to describe and bind platform drivers
for HW IPs in Alveo PCIe accelerator device.

Lizhi Hou (1):
  of: create empty of root

 drivers/of/Kconfig         |  5 ++++
 drivers/of/Makefile        |  1 +
 drivers/of/of_empty_root.c | 51 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)
 create mode 100644 drivers/of/of_empty_root.c

-- 
2.27.0

