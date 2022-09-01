Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5C75A8D98
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 07:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbiIAFsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 01:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbiIAFs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 01:48:28 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE831178CA;
        Wed, 31 Aug 2022 22:48:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QfqvBwxs6cuz+v9OcNEw03sbPWeDiBGnx3Id5PF5IeUsJ5QGBNCEEsH3Bq5x2TmOKWG6+3Sue5DF0w1X2DLWvfRLiznYiVS/YPC7El5JLv7DJd829h2z8u/iyAzH38I3KaoUO0VuTmKcdhnKR6LPJ32sljoH7uOIu98X/IM81D8pvmXFcGfEjQBW8sNKuIDZIAe4KgC7ghoP66r5rKp4VP4TpVxcQXcHLC+8RFhSBETn7Voi5NXSCCSYsr1lz+X6LXqR4T6G8bu/Pceb9KMshUhRx6pABexmit2jZgqSNw1eq0byb6f2SKokFqtA0TIyt/fiXEdsjdQCbI3QbR5eqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1v/P2GI+FxWoV2dTYVwFeHtohiSKwMhzHD3ochidsF0=;
 b=B3I8VwJCU5bL7ulZ71qKvF35INHv+EM4XKboU//KPRdcS3ZZv3ZC1mdLW4H63VowveNvzv6seva9+Uvjj/AyVEL6G98mba6XtxmkM3Q9gMKNIIRrm2xOAP6aQ3KEhPm5DfbI3acZAfXaq5Bdgl+WD5naF62qmdsXE20drjSh9lr/8iq/lwk9rkLXuT9m4TNb5sz8ufNNdl56Bg3E/AJNc1jFDUNGU5Lf77dSL1vC/3v1K34Hd5Dv+3xfDmPBddGW4SJVUk3vAs+XqJEXIlu6juTb2tAZaJ835URELOlrYtT8UjYugD28W1xMWMW2ow2XL3bgPJZFmX2l3fK1OOpqkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1v/P2GI+FxWoV2dTYVwFeHtohiSKwMhzHD3ochidsF0=;
 b=ELJai+r6vLVqs8JRZMwYgTAE5GJLcUK001LpPBvtSRZY4hEA19FAsCkQkhLquf8XRSBtjXEam9n4y6PX5flPoEI9jY3Jz1W44mZ+LgPpaFauWFpSlvXxEWqoBuBf41K3+vonWWdx84t1n9+YVWfzJeHUbBzVXbZQpKrkeTQWqtg=
Received: from SN7PR04CA0234.namprd04.prod.outlook.com (2603:10b6:806:127::29)
 by MN2PR02MB6814.namprd02.prod.outlook.com (2603:10b6:208:199::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Thu, 1 Sep
 2022 05:48:03 +0000
Received: from SN1NAM02FT0003.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:127:cafe::9e) by SN7PR04CA0234.outlook.office365.com
 (2603:10b6:806:127::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Thu, 1 Sep 2022 05:48:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0003.mail.protection.outlook.com (10.97.4.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Thu, 1 Sep 2022 05:48:03 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.6; Wed, 31 Aug 2022 22:47:55 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2507.6 via Frontend Transport; Wed, 31 Aug 2022 22:47:55 -0700
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
        id 1oTd3T-000Eqz-Ct; Wed, 31 Aug 2022 22:47:55 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <git@amd.com>, <michal.simek@amd.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <akumarma@amd.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [PATCH 6/7] dt-bindings: spi: spi-zynqmp-qspi: Add support for Xilinx Versal QSPI
Date:   Thu, 1 Sep 2022 11:17:30 +0530
Message-ID: <20220901054731.7705-7-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220901054731.7705-1-amit.kumar-mahapatra@xilinx.com>
References: <20220901054731.7705-1-amit.kumar-mahapatra@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 617266df-d019-4f01-ef03-08da8bdd895f
X-MS-TrafficTypeDiagnostic: MN2PR02MB6814:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8y1SxWzHohx5jwd6laTs/sQL7r4/tm7BRhNh6FUk58uXOMtPOHfDlKOouHTg5iGXIcrrMkMzRjBNs0XG2rz1sgvqsYPLCMXMGjNYi5EvYkJTVeL0bgrt9lYzUE/sjvFOl3XMo4iEEluLRg10eqVxuFi93BIF6tGpK6XlyAwi76rXzOXRO5Pua2PxAkEjPRompBkNp8VKsOZtIHImoOBse6XZpav3LXcXg/sM7wDejNnYPeIiwVf8Wb/YdqhrzXyMvwvxduQiUrc0+CmR+UCpEj8UwG8wDftdDRu6OwKkFvE3NCtGwyetVz8NYJowLRpKCHKfPCb6U9Zv/mlJkZNXX2lpswXHCClwOYKhVwq+LjjIPCE2E+ABO9q/kUysFG0HUJt09btGg5I9cSMkHOvlndpTbzajPJFZTBdBtxtTAet2DntZXAEWl8ZNZ4OErFfSwfiT2yXtsz+QJNvuTICiW/likOIUhk1Vp6l1XWaJF+7t2Mfjn9Df+gPwWe4sHrhm6oS1rnjFwPzDWRkYcp1MiQF6/PtFzkww+Bq4tgdx6eHueF/sRJAHWSyoRcC9XgyIsc776JmuiHKHi7p63SCsDeWLTPph8gM6ArqN91HxPcKzHpOGhKsZxJNgmcPMk5LnXQBXtNZufAZ9RVKe8T9uOcwM6v+H7zGChM+Ls4K0H7Z2FaHrUZAnzsXlP5BkCeK0FaAz5BSUinB5DUjWO933ZBUi+ATF0TZkWOAq/7Goanx0SdBU0YXB5V3eknpptTenV/hxD/wfljqB6C63mLMSDyRK5Ccc5wAtwi43PZ9y7Pw=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(376002)(346002)(396003)(40470700004)(46966006)(36840700001)(2616005)(7636003)(186003)(40460700003)(426003)(47076005)(336012)(1076003)(6666004)(4744005)(107886003)(41300700001)(5660300002)(8936002)(9786002)(7696005)(7416002)(356005)(2906002)(26005)(36860700001)(40480700001)(82740400003)(83380400001)(82310400005)(54906003)(36756003)(70206006)(478600001)(70586007)(8676002)(4326008)(110136005)(316002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 05:48:03.4208
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 617266df-d019-4f01-ef03-08da8bdd895f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0003.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6814
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new compatible to support QSPI controller on Xilinx Versal SoCs.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
---
 Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
index ea72c8001256..b28a8c8f5e11 100644
--- a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
@@ -14,7 +14,11 @@ allOf:
 
 properties:
   compatible:
-    const: xlnx,zynqmp-qspi-1.0
+    oneOf:
+      - items:
+          - enum:
+              - xlnx,zynqmp-qspi-1.0
+              - xlnx,versal-qspi-1.0
 
   reg:
     maxItems: 2
-- 
2.17.1

