Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670255143BE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355467AbiD2IR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355455AbiD2IRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:17:53 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90AAC12D6;
        Fri, 29 Apr 2022 01:14:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKvz4OKnNZK1d8nOe/XvVxSoIaA/D0qCUQoroUOJojwt4w0d9/JZr6Sqe0+kg91FBhX4ryAg7ELbKjl0Fav9O3SfVp/VjSSoD2HWzLHWpSUSmzwcdyexBUbK2DHDjPz6kJzAaRty1LjpRCtELtHlYQN72d1Kvpou0nXGEVQZ7qwWTMKfdHW4FiLzUho0xJC8/9aD8evfXW4TqUpRAYdC0g/c4NeMiicLnM4gDYHAty4501MGOb6Syx6LNyGTkwC+cTGUJjx6dBz5q69G2gjvYKwch53KxP+XQKb9QdgWmPXUoNcDm4m7gE9i32PDDHg+m0gCqi2wRx5DBpUo1q+wuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQbeBOVIVK1PgYBlxHFsFLukyM/k7bxqNaQoFvP9Ggk=;
 b=GGV7+UORsz6tRPgvW1Cm7oxC7CPkRIOzKG9kKSv1hxcysSndwcY6cVioCrxNTpYtAgHeZ6xfoYHUjOXZ15w+QH1L/BXvOGjStYHlUkCSSX9whUoIO29ml/jB+ZPVmYv4f/rv0jnMKgIGJcof8zCfDsDDMtPnaFshq0SyA7SI1RF+tOSLFtOpsxq4Jg7VbPPKRk2/fjI52jKHBmfuaMDTG8IpJKeqAs5nK07j48enix4gzljAwtlox+iA+HnTT/ppkgCHAHxWnrvMt0Y5BWIWWTQ7yNElceK+AWrH2SrrZanEXRI9egvYY0hswR/QcM6moGZ45+c9RGNA2zdtxztmcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQbeBOVIVK1PgYBlxHFsFLukyM/k7bxqNaQoFvP9Ggk=;
 b=FyhaDIQGBkIJMpFFpHBcOTuutY9tBjUsyHjjJaAvtaOZs6DYGE4eFl/BA/ggFv+CBELlFQmkaxjscTZxTYjoaWMRrgZdT/zxLl3NEz+iK6Sl/H8jiVE6EyaAOcS5lhrvnUbkRAojm0lvrMh4/eEMHo39ZReTCVJTNATwk58IdUc=
Received: from DS7PR03CA0299.namprd03.prod.outlook.com (2603:10b6:5:3ad::34)
 by BYAPR02MB4392.namprd02.prod.outlook.com (2603:10b6:a03:57::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 29 Apr
 2022 08:14:32 +0000
Received: from DM3NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::77) by DS7PR03CA0299.outlook.office365.com
 (2603:10b6:5:3ad::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Fri, 29 Apr 2022 08:14:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT011.mail.protection.outlook.com (10.13.5.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 08:14:32 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 29 Apr 2022 01:14:30 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 29 Apr 2022 01:14:30 -0700
Envelope-to: git@xilinx.com,
 linux-serial@vger.kernel.org,
 jirislaby@kernel.org,
 gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.39] (port=57162 helo=xhdsgoud40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1nkLll-0002va-RR; Fri, 29 Apr 2022 01:14:30 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <linux-serial@vger.kernel.org>
CC:     <michal.simek@xilinx.com>, <jirislaby@kernel.org>,
        <gregkh@linuxfoundation.org>, <git@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 1/7] xilinx: Update copyright text to correct format
Date:   Fri, 29 Apr 2022 13:44:16 +0530
Message-ID: <20220429081422.3630070-2-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220429081422.3630070-1-shubhrajyoti.datta@xilinx.com>
References: <20220429081422.3630070-1-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb4243f8-caa2-43a1-782c-08da29b84a44
X-MS-TrafficTypeDiagnostic: BYAPR02MB4392:EE_
X-Microsoft-Antispam-PRVS: <BYAPR02MB439219DC6720E0F8023227BDAAFC9@BYAPR02MB4392.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OtgDgrhpJs3tGdu+TnG5E7c40fSIeze4QnxIvMaC9c+AmIo9amBI8on/C88eFbvMqPEDXHHron6DahEwHk6a3/ZDDbFweWAXjidutPatIevnj0wEqaaGfGrLvEDBvIHtdNy+e1jv+beveB8dMmzJEFelAFpcud0/XvlV26Q2qX+ByDcBVAZYX+yznSkAerjo2GMjyWaAMCe4t2IvGCnOqAOSyLVWDiYOX4Vr/BZzBUoYNuxL+CF4AZPbJOr6BdCXi2CLBkdKnBxO92Nom+mXXlnwMVJJk5LTOZm+7GnUwCFwFiopEawg8ooFk5Vsa1DdYqNZ9HoB+7tq9jzaUc6hv72g/91j9C4v7okF+/ShCsb2MAb2ox66huK7qrTDGziZx8XRJVWC7iAFf6paYH+CM8ySrvprinwYvIBa4ew63ib+Ci9ZIkWdTmPbG7ChjyhobfsYW1exAE8KUXzHLmn2PBsIjEL6CHwG2zcLkMq+rpexANXTCCuDzLAc6pvAkzmx81DOZPfThRyiOv75BZGCFJ2PtHnlS1jDyRqYcUqvS0XTcXgj9S55LOP/feokuSE5vsdjuU8w7dPOI63gF0NpGPXfGRx55wQPkUhKDGObLzW6DrywEDPm3RxBTP8B2SblLpRh/3MZFDRpoBV/xiacMJl4/8EbJ+cPJNzofOOV86YT8lQVFlt8bpPFiIm14uXa+AsB9x0Fj7gUM6CMUjpcOA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(82310400005)(186003)(83380400001)(36860700001)(7696005)(6666004)(47076005)(426003)(2906002)(107886003)(336012)(1076003)(2616005)(6916009)(316002)(54906003)(36756003)(40460700003)(508600001)(44832011)(5660300002)(356005)(7636003)(4326008)(26005)(70206006)(70586007)(8936002)(9786002)(8676002)(4744005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 08:14:32.2131
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb4243f8-caa2-43a1-782c-08da29b84a44
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT011.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4392
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Simek <michal.simek@xilinx.com>

Based on recommended guidance Copyright term should be also present in
front of (c). That's why aligned drivers to match this pattern.
It helps automated tools with source code scanning.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 250a1d888eeb..fa82f88844a1 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -2,7 +2,7 @@
 /*
  * Cadence UART driver (found in Xilinx Zynq)
  *
- * 2011 - 2014 (C) Xilinx Inc.
+ * Copyright (c) 2011 - 2014 Xilinx, Inc.
  *
  * This driver has originally been pushed by Xilinx using a Zynq-branding. This
  * still shows in the naming of this file, the kconfig symbols and some symbols
-- 
2.25.1

