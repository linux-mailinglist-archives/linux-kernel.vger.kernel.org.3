Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D64A5198FD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 09:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345944AbiEDH56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 03:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343600AbiEDH5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 03:57:46 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73303192AE;
        Wed,  4 May 2022 00:54:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=agM3T9aux+Zzhg0nO978GFmtBzI4sn88zw44Fm7oNWrLIiYC2EXlObvUNTn8RW7BKW0nE8myMMut8M8kn7VxDCblE/Gj3rgNtHbLoHH384BxxOaM4Eme9YJG0++3vFTtN4jsm5QsRpXjdohrJgMX9kl1DLMBE99f3Hw7jIoVtfkwlNTBE7a2kHLYNrFfXbsiQCDvQIHpGlndbKzDz8gmLwIjPIe/z4B+rhAatSgc8KXCEnWT09TxfBReu/X0aLUCVwMQX1KXNLnAjoH09mP37/mhrueJjk372+iKsM0HfS4yPwK4XbHXbkx4RD/9T2K5X4g2RZiQCcvrtid24vDtNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9h5nSShZ/DSZbL3NrtC2wNtfJPAUAghoW+aqDcJaJ/0=;
 b=P8j0dYv8hBYhFT/93DuAcAYyMdK6Yh2iiJnaGMGGr0dOpDjBTbQJhbenIZSu9YzczPJ1/3+F2VCSCqRF7cvC+amHWAoNvgfL8MlKjXTZZpxxDUow2QJElOLskTl9fmMjDEN4hEC74Y9KCtOvbDq2yeQFJMNWxuTTVamNb4wL8QnksCCoKn6yE7zR+6olfrkScQjaeRKugtndyY2CHprT0AhNflcHAKoZB6cJNougB9lxFj7rXnRyNj6TA5563UdZIxo7RFnrOMPMd04KWdhZni207fHD9QhbVOXvoLFkG+jxxz30U0/Fb0yZ8+hwuU8MKgqurUR+kwVWNv3U9a9pvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9h5nSShZ/DSZbL3NrtC2wNtfJPAUAghoW+aqDcJaJ/0=;
 b=rBB+x3NOd8uAAI2eluG4gKwn1qNxk6IyZqSyCMD5N9Knjh7z3ihugJgJZ2x+X2X3zqXdHeC1DpFti8Moung2dtymwnQcdojD0eZsrfNP8oCC681W6pASJTzpU3ufpZ+XqIRlpg7Sq56FAQl0IWih+hNK0+lg8roE9X0CKcCWfK4=
Received: from BN9PR03CA0083.namprd03.prod.outlook.com (2603:10b6:408:fc::28)
 by DM5PR02MB3209.namprd02.prod.outlook.com (2603:10b6:4:64::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Wed, 4 May
 2022 07:54:09 +0000
Received: from BN1NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::12) by BN9PR03CA0083.outlook.office365.com
 (2603:10b6:408:fc::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Wed, 4 May 2022 07:54:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT022.mail.protection.outlook.com (10.13.2.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Wed, 4 May 2022 07:54:08 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 4 May 2022 00:53:50 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 4 May 2022 00:53:50 -0700
Envelope-to: git@xilinx.com,
 gregkh@linuxfoundation.org,
 balbi@kernel.org,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.18] (port=46956 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <piyush.mehta@xilinx.com>)
        id 1nm9pV-000B5T-Hq; Wed, 04 May 2022 00:53:49 -0700
From:   Piyush Mehta <piyush.mehta@xilinx.com>
To:     <gregkh@linuxfoundation.org>, <balbi@kernel.org>,
        <radheys@xilinx.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <michal.simek@xilinx.com>,
        <manish.narani@xilinx.com>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>,
        <sivadur@xilinx.com>, Piyush Mehta <piyush.mehta@xilinx.com>
Subject: [PATCH 1/2] dt-bindings: usb: dwc3-xilinx: add optional property reset-gpios
Date:   Wed, 4 May 2022 13:23:08 +0530
Message-ID: <20220504075309.6244-2-piyush.mehta@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220504075309.6244-1-piyush.mehta@xilinx.com>
References: <20220504075309.6244-1-piyush.mehta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37556571-75ef-447a-05d1-08da2da344fc
X-MS-TrafficTypeDiagnostic: DM5PR02MB3209:EE_
X-Microsoft-Antispam-PRVS: <DM5PR02MB32093C048307B6871ECFF658D4C39@DM5PR02MB3209.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8XeQsacuXmMS1X6b31DVXpvCCGxCyrAbWKgnwfBDLCwgG0pQ/O3wxr5wZzf6VHSxq1HSdovOOSon5NLMIyVXLDbDpnNTrUkEPRRQr2t5AoYaCxrgZQzLI+vGf6h+tTcgiBSDwPsBu1bXji5oPrdNSzR57pXNgaQ2ONZaNiTQfbMt5DWuNd3ybtBvO8pBJBdq+4dxofqVCneKHdcoRxu6MpdgenQP5tERtRY8ZCqfjwWSXpb9W/omx3sFmqK5JKqlI2f6pvymJ7J5gTGnlblS43aw5oEgh4WSEXWmFZ+FfVsUYYxdXxQhtGjSBvulV2RJ+7Z+sqrorP25wyOOSZXV4p/iRWv9h2TfFibS7M4/VPHMO387/z6CG1u9NLJNN7dwAFqJRY7D4UkO9JCrAf8zpIxG8nLqy5Jt1KP7/T4BzpvswmPpFb7KSGG6BviBWqbNMdwkD16+JRHrzSe3VhBUJ8rJTYvc8q2cGlF1F6e1K7kgaCPqBhvMLlSJ/GvUJQxC40u8x1yKkLVEfYu1XmiXMnypvZuSwQ61M+TU9sSlN/SHATjXm34qpbHEPQSAywUbrKbQrqML9+qJaBjo81WWIxP1i0eihtDC3zl64dh/nEo/PUPwWNOekWFTQdis1I2gtTn6f7XsO3YeYRKBP2OWGMRqkpDBN64jca90XesEz7IM0xohHjhzJUQZtX80OpCXZvG+q+0T3+FR2++meCcWhA7oY/OWmtf6kLhbvvCykf0=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(47076005)(426003)(336012)(1076003)(186003)(26005)(6666004)(7696005)(2616005)(107886003)(7636003)(356005)(40460700003)(82310400005)(36860700001)(4744005)(110136005)(44832011)(5660300002)(54906003)(508600001)(6636002)(316002)(8676002)(70206006)(4326008)(70586007)(9786002)(8936002)(36756003)(2906002)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 07:54:08.5383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37556571-75ef-447a-05d1-08da2da344fc
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT022.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3209
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added optional property support reset-gpios for the dwc3-Xilinx
glue driver.

Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
---
 Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml b/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
index f77c16e..098b731 100644
--- a/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
+++ b/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
@@ -71,6 +71,10 @@ properties:
         - usb2-phy
         - usb3-phy
 
+  reset-gpios:
+    description: GPIO used for the reset ulpi-phy
+    maxItems: 1
+
 # Required child node:
 
 patternProperties:
-- 
2.7.4

