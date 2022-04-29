Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3425143D0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355568AbiD2ISY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355492AbiD2ISO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:18:14 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EF4C12F8;
        Fri, 29 Apr 2022 01:14:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlHIK2W/+wygmbeuvyyBXv2MLDScRmrseWvuNFMKytCb5x0a82dRa70WN6jtWQ4wOW9MY78vQ6C8S1YZp/mf+EExcgq5ze3ozSZnvK/aaOJvwbK7gYHm0Ux+v+syQdYHahKQG5AlOmK1a4ziHwxJymGXeq/fD0cgIx+jmDlr9KSw/+Jrwh5CO2RZabo/mMsXIQvrUP/2CU4UCsj1ORD9fWFU+LuRAZEdLtkGa4Tk0Q42J7jq6Ky83Z39sBWjHO86zcm3zNdGG1v3cmgz0wLfVzmsipOwy6bsySjEGIB5JzAAbwmxfC0PopbXrnpfDa3EH7m/1ARfOEMUJq4/jJaOUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQDuRxH8m33avCNscVJb8jg0A2Q0IIxpabJvOg8s1xg=;
 b=HcG7s+p/HVQqKcKlFOtvPNgD4X0DvcULOTR6EZMDjy9s1cBaaPHmKn1QHXN9ZJfxNNOAVD5rdQ6Ol0lsIEQ+Il4+naeNu10e+nCR5SHnhMRIMhmVyKDKSbQhrCiJA0GITAGHaUfev5jJFh49eiLP+G1pLNCh1pnro4DZmTMLiHKmRzHMS68pSunZyoEuYwyonb8qhvDPGXD3eBVuFMcx03qgbBMnXCRJyqUOUabxiwlIML0lN+KN+fNwSTECIjebzqk0ooKIDdQxrpW40rGv7LjmYEPQwEbEBF2v6EBtI+aL0+uNmxq/YpdrrPpPYN5mAZLl3O5QOtsGu6tzprVqSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQDuRxH8m33avCNscVJb8jg0A2Q0IIxpabJvOg8s1xg=;
 b=Xpeg8CwoKH0klq/S4LIGskpUw3EJ0JsG7WhSLivmLo2wFueoPbqVY4DTOpaIRO40F6/8s6MbhVgHh2OBt/nIfgFBTijMTn75MgMlcx5bzfHwpqU2jfCZgpeaGHhjGh921+Sf4PtAoNmels/oTMcvkQlzN2CCVCr4QiqjdeQEwSM=
Received: from DM6PR07CA0082.namprd07.prod.outlook.com (2603:10b6:5:337::15)
 by PH0PR02MB8616.namprd02.prod.outlook.com (2603:10b6:510:104::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 29 Apr
 2022 08:14:44 +0000
Received: from DM3NAM02FT059.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::e6) by DM6PR07CA0082.outlook.office365.com
 (2603:10b6:5:337::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.23 via Frontend
 Transport; Fri, 29 Apr 2022 08:14:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT059.mail.protection.outlook.com (10.13.4.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 08:14:44 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 29 Apr 2022 01:14:41 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 29 Apr 2022 01:14:41 -0700
Envelope-to: git@xilinx.com,
 linux-serial@vger.kernel.org,
 jirislaby@kernel.org,
 gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.39] (port=57162 helo=xhdsgoud40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1nkLlw-0002va-Pu; Fri, 29 Apr 2022 01:14:41 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <linux-serial@vger.kernel.org>
CC:     <michal.simek@xilinx.com>, <jirislaby@kernel.org>,
        <gregkh@linuxfoundation.org>, <git@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 5/7] tty: xilinx_uartps: Make the timeout unsigned
Date:   Fri, 29 Apr 2022 13:44:20 +0530
Message-ID: <20220429081422.3630070-6-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220429081422.3630070-1-shubhrajyoti.datta@xilinx.com>
References: <20220429081422.3630070-1-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 901afdaf-193a-4aa0-bc95-08da29b85159
X-MS-TrafficTypeDiagnostic: PH0PR02MB8616:EE_
X-Microsoft-Antispam-PRVS: <PH0PR02MB861627233C924687B2160D24AAFC9@PH0PR02MB8616.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PkeGGAG8l6fDr5enT2xXF3/TYCo5wpPaeYQlHvH4m6ECqaE6VfFQaraxcol7v0HbsAs55WdRu540sxPplRVNYuX0frKY793u1B9cs7BhGJhS/rxE5qZdCWaG3mwdJXDdgEyMuQZir27B3AVw4V/CPkxodCt4ry+ZLPPqqdx8a4TS82Rt3/fMyOFUfFgvJ+WURWi+upjeFfti4I9tkYwJLjkBEeMg/n+LCBrSMZeTQ7Nzbn13oQKCM9/9tWGuBzwwCgtKvIaE3yB7gPw5mMucfJ1lJiKdQVP1R++YMTM77lcNgoFDhVaZHwm9ekzqUGy/Y1rXk02nDEX82PcfUUNAD17MyJEpI/E82X2UA3tQxX/RX6yJO7/f3Y8zI67TCNbuN4ujkUxNATZTNWkzJqdABd8vpqerRgptS2vt2DkeRkyH6Vd0VUCY2uqO5iA09TZU4qZBF/c+4ZHAkHSaoBvnsr8Bx4Sk65MtPGLVumOFaVeK1aSC7ehTmUjtNODt5qpZ/gg8PQCmUpfJpqhCTOMbNQ6PQTK4CKyClN2mUyCndtBM16/VMA1Atbcmsrb6SwfFAtn9oAJwMgdxJjy66nrnHc7wLyPoeVT1AScMFpekpj4KZR8Yu+uFSjB9qWuPqm2WT0VZ3tjc71dZ8GuLcL/idKmRhyhd/dcuC0U65r0OW604pta9g4HUr3AvQRtFjTt9Etpr4AUJQZ44qTbUeSMogA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(47076005)(6916009)(316002)(83380400001)(36756003)(54906003)(36860700001)(426003)(336012)(2616005)(2906002)(70586007)(70206006)(1076003)(4326008)(186003)(8676002)(356005)(107886003)(6666004)(82310400005)(508600001)(7636003)(44832011)(40460700003)(8936002)(26005)(9786002)(5660300002)(4744005)(7696005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 08:14:44.0965
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 901afdaf-193a-4aa0-bc95-08da29b85159
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT059.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8616
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The timeout cannot be negative make it unsigned.
Also the same for the trigger level.

Addresses-Coverity: Event incompatible_param.
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index bf0415f0a194..289d70914956 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -34,12 +34,12 @@
 #define TX_TIMEOUT		500000
 
 /* Rx Trigger level */
-static int rx_trigger_level = 56;
+static uint rx_trigger_level = 56;
 module_param(rx_trigger_level, uint, 0444);
 MODULE_PARM_DESC(rx_trigger_level, "Rx trigger level, 1-63 bytes");
 
 /* Rx Timeout */
-static int rx_timeout = 10;
+static uint rx_timeout = 10;
 module_param(rx_timeout, uint, 0444);
 MODULE_PARM_DESC(rx_timeout, "Rx timeout, 1-255");
 
-- 
2.25.1

