Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFC85A8D84
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 07:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiIAFrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 01:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbiIAFrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 01:47:43 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9044F1166D8;
        Wed, 31 Aug 2022 22:47:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHD81yRLhFEO1M2HeX4qmRmlWRHdBam2I9XmybqWQiwqVyz4NEjLcueWIfSlTGb54Kw2S4sIOEus0Ja0rSDfgnz3hLttVSNEtRy+70MneGaTtI1IYTSJpwLbfO0L8FgQpm8BA7LE6xrR6ZoJGJqMAYtFxXg4+TULOMILKwRSnjfdpSHWd+jrJSnIkI1gx5J8A0R05RpOJ8LaMdapmH2Fg4Dv7uwBtWB+Loo9+NG63eQIRUMTCNpiODRBVep5j0pgVSVdOMUmnlDQTcMwhgLhJATdL7IeuXf1eZ5wtpycVhJj2/l9EYRzzf6SJuA5S7/lmQKYjL62hoKsInlUr5Rsuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rlf+q62Tu3DzaaDyHQDmvQijGnenPLWxUFobuI0mhKg=;
 b=CtWCEoSTBuiIOyeklIu25/4hQcwBzgh9m/mlPZoIXc1gHbYbHWgirRMLwAGH7utLT7Z+vAy5HfYeGo0a5LeQqeL7pfyE7I36kCNLMQW/kFE+MYw67c1r5NPZCCW8k2ylLwuvTtyjBxmeXf8nDRCXlUfRnUyqjn2Y36wou8E9/P/2eDJuq1BUje8eSEuJI2+CH/eflXze+Xyk2T+YqzaDwXD4Z0gtutyQCnXHVHbQ5YbkrnZEDtJFZXhcmmlB4e+b/A5mGGbstjfD4yVgjl1xDqX/ZbloXI0r0OfYjEPkmyPbGeiyEk0ihCAmEpzeZcv/9+USycf+BqzP0IwIFfy55w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlf+q62Tu3DzaaDyHQDmvQijGnenPLWxUFobuI0mhKg=;
 b=Sy4PMwRHBXpIFV0NE9UxS/OlKEICPZsmoTNMhzltt+TFLlHriYibpRwnVCYxPn7Ehhqcq26DrwaL5VliFkaF7+ma1ReC+7lCvtFI8yHKQW0NvUqqkniYyrXKLp/JY8KK/oGZNhE8PIwTkFKEAMT79BNhutCPZxD5z34OB23KiIc=
Received: from SA1P222CA0064.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::15)
 by SN4PR0201MB3454.namprd02.prod.outlook.com (2603:10b6:803:4f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 05:47:38 +0000
Received: from SN1NAM02FT0034.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:2c1:cafe::e) by SA1P222CA0064.outlook.office365.com
 (2603:10b6:806:2c1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Thu, 1 Sep 2022 05:47:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0034.mail.protection.outlook.com (10.97.5.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Thu, 1 Sep 2022 05:47:38 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.6; Wed, 31 Aug 2022 22:47:36 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2507.6 via Frontend Transport; Wed, 31 Aug 2022 22:47:36 -0700
Envelope-to: broonie@kernel.org,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 git@amd.com,
 michal.simek@amd.com,
 linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 akumarma@amd.com
Received: from [10.140.6.18] (port=60724 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1oTd3A-000Eqz-98; Wed, 31 Aug 2022 22:47:36 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <git@amd.com>, <michal.simek@amd.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <akumarma@amd.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [PATCH 0/7] spi: spi-zyqnmp-gqspi: Add tap delay and Versal platform support
Date:   Thu, 1 Sep 2022 11:17:24 +0530
Message-ID: <20220901054731.7705-1-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88436e2b-3532-47fd-1995-08da8bdd7a6a
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3454:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zQLl5V34EnB8O7iipAHPFAO3gL1M+lo1zVfCcuCkgnZN3RUuFM8KqJ451IQbYlNppYN30ITnlC0YCont4Y+dkQdlSlYzuu4gU0Uf8W5CBrx4inW31n+pPurer715etG+mzJ3eF/ZL/IP7/KwKbT0zRM07Fo4Z9kIiubKBh7eev4rEulcv5bYXA3siBgYakGJYMoi0qOLhJ91kPQntaIyugS1RasugsX0nIXtQ6//ZQbjeaTBowGYQcN7e6zotvvfTsm5WAfYTRGAvFw/ZSXlQwCcIliRrmskwyS+uOXxsiA+csaJnGNvxhoXrzNF1drMl4xhjIS6JskTOyrxoOhQiB+J3u8AvT2ufOwjSuU5ENlO8IBsLK6AvDURSxs1bZ4RhKs/4TWf12sNpVYN6iJ7D+m7+SlLNQhQnHFn4U0mxQSuh6pH1JKQykjwF0OkCHuBJlSpTs3dFjyhrxQ++liNu2PhsO+3578EINzvXMzAos0E44z10bsY7mwtnPLfdyMkh4QFfM2DzV21mDUkvefSOo4HM0lrpd0hEMxK4JUoTlO4mnXzUTnqvgoWGV5HIW7nBFp0vE22UzzGa4HSlUhXomnt88/YbpMWU5raIIILzWQB7CI+rMRfchocWgBAQt/ZZS2gx4B1mbSdvSVXL2Q4C+AO4hwqB4sRrPpPuWqgQMovxTNocN+kPv78BiNgkW/2wXFub9k4UcQDchwEJOdNmu4YrM3hoT4W4s8tVBzWlUwn4C8G5i3grpvkAn2ltCJIvX/09yEl0AZuMFZMRNVUQA5bfM0jgPycuI4GD94M9Uw=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(376002)(346002)(39860400002)(40470700004)(46966006)(36840700001)(7416002)(107886003)(6666004)(2906002)(82740400003)(40480700001)(336012)(54906003)(110136005)(41300700001)(47076005)(426003)(7696005)(316002)(83380400001)(40460700003)(7636003)(82310400005)(1076003)(2616005)(356005)(4326008)(186003)(36860700001)(36756003)(8936002)(9786002)(5660300002)(70206006)(26005)(478600001)(8676002)(70586007)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 05:47:38.3059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88436e2b-3532-47fd-1995-08da8bdd7a6a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0034.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3454
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series:
- Fixes kernel-doc warnings in GQSPI driver.
- Avoids setting CPOL, CPHA & baud rate multiple times.
- Adds Versal platform support in GQSPI driver.
- Adds tap delay support in GQSPI driver.
---
BRANCH: mtd/next
---
Amit Kumar Mahapatra (5):
  spi: spi-zynqmp-gqspi: Fix kernel-doc warnings
  spi: spi-zynqmp-gqspi: Set CPOL and CPHA during hardware init
  spi: spi-zynqmp-gqspi: Avoid setting baud rate multiple times for same
    SPI frequency
  dt-bindings: spi: spi-zynqmp-qspi: Add support for Xilinx Versal QSPI
  spi: spi-zynqmp-gqspi: Add tap delay support for GQSPI controller on
    Versal platform

Naga Sureshkumar Relli (1):
  spi: spi-zynqmp-gqspi: Add tap delay support for ZynqMP GQSPI
    Controller

Rajan Vaja (1):
  firmware: xilinx: Add qspi firmware interface

 .../bindings/spi/spi-zynqmp-qspi.yaml         |   6 +-
 drivers/firmware/xilinx/zynqmp.c              |   7 +
 drivers/spi/spi-zynqmp-gqspi.c                | 193 ++++++++++++++----
 include/linux/firmware/xlnx-zynqmp.h          |  19 ++
 4 files changed, 188 insertions(+), 37 deletions(-)

-- 
2.17.1

