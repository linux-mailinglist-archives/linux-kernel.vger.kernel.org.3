Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82956462EFB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 09:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239884AbhK3I5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 03:57:55 -0500
Received: from mail-mw2nam12on2068.outbound.protection.outlook.com ([40.107.244.68]:64119
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239881AbhK3I5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 03:57:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9WhJG8eh3uZUyYnp3RWEKxeFYtsia2kKnVCmA3OXweb8ci2mGeX0lLPTH0Xzv0t41ub1jj/Zq/AY3A4j7MRC3XRRKnoHZ8k0pDTcYKkv9Ve/QkaNul2+zhg7Wn6ULrGXn4KNPvjmahyyfrpY0PjsVj4yxK6IYP/yPjdToqMlxlOGtXs5ahwhYmlCDfaibQmyVbDEqAKdHB+vavM6jbvbrCa3GjuBSlNEsAnowChrduGUY+eN86bTTt5tpvc77GWOUvUzF9NxWudlW3aP8v7kLu/pS3IRy1KbML+7S8TAgsa+U864gpzY/9UDBLTKLkqxPzu3L5OPClvd/rwcTnUTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KrYpX7fo4/IMW25HkA0hJz7Yj/taVrZvSyhe5c7nCvE=;
 b=KXviswHWxcQgPd8oqANMXOXuSHwSVOdzZpiBXPezte+eOCVVPAbSETkJj9hNO6QrfGUxai7r4uFWML22pxpqaORQ2YEP7uBxFt1e8nERz43dLtxEOfo2RSdHS/q/6m2uchgOMP1Wi45oBDRnpoHfhU/ogCJVyitg+HyiT47jKyoLtFGa1tYXHBXARKbev/sxpFRzYRKDGRN/gGJ6mwUzriyk8jcr0MfuYHGjtsA5oHuj/VgQSGtEZ6a6SKxyYOSkVXY7yw7LLilmVXa8btgiep11Sorowcp2LVszA+hMnMO9HTiB7JyRZkt/sWvzuP2xVDwCfjTG1EbIHzQdh3TAZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KrYpX7fo4/IMW25HkA0hJz7Yj/taVrZvSyhe5c7nCvE=;
 b=DTZvvnG0tw4ycN4r+OM5C1HXwYCXDf+hkOuyrHwhITYP9FKHPRWcr1810KpMedU12T2wiMQGoeuGi3Aj88D7KPNbuPirM2DMWn+zVyVtLBSRgTnb96E4P0tF+spiYk3sVKjZ4WafYN5iDSOSzXWHPJPja2pMnX0pdLKJ2jksYd4=
Received: from DM5PR16CA0036.namprd16.prod.outlook.com (2603:10b6:4:15::22) by
 CH2PR02MB6183.namprd02.prod.outlook.com (2603:10b6:610:3::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.21; Tue, 30 Nov 2021 08:54:33 +0000
Received: from DM3NAM02FT024.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:15:cafe::8) by DM5PR16CA0036.outlook.office365.com
 (2603:10b6:4:15::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Tue, 30 Nov 2021 08:54:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT024.mail.protection.outlook.com (10.13.5.128) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.20 via Frontend Transport; Tue, 30 Nov 2021 08:54:32 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 30 Nov 2021 00:54:31 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 30 Nov 2021 00:54:31 -0800
Envelope-to: herbert@gondor.apana.org.au,
 davem@davemloft.net,
 linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 robh+dt@kernel.org,
 devicetree@vger.kernel.org
Received: from [10.140.6.6] (port=56576 helo=xhdappanad40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <harsha.harsha@xilinx.com>)
        id 1mryuF-000GNC-8J; Tue, 30 Nov 2021 00:54:31 -0800
From:   Harsha <harsha.harsha@xilinx.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <saratcha@xilinx.com>, <harshj@xilinx.com>,
        Harsha <harsha.harsha@xilinx.com>
Subject: [RFC PATCH 0/6] crypto: Add Xilinx ZynqMP SHA3 driver support
Date:   Tue, 30 Nov 2021 14:24:19 +0530
Message-ID: <1638262465-10790-1-git-send-email-harsha.harsha@xilinx.com>
X-Mailer: git-send-email 1.8.2.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f86fd773-5d67-4c44-ea44-08d9b3df0710
X-MS-TrafficTypeDiagnostic: CH2PR02MB6183:
X-Microsoft-Antispam-PRVS: <CH2PR02MB61833677D9A970F7EE85FD90DE679@CH2PR02MB6183.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uKKV5HU4beU1lXnFc1tosr52hFpKlFKS7BkleTUcL2juyKbD7Gtu5p8/SEM0YxwZSSfbNk0qb4mGiVky0kvRxP6dytdNNahN5kmPqRrxNciIh3QQTm2Xc/fi+MVR52PWjHPWAwPtEggb8U6IhD60duIi59rUhUjV9oEL+0Vvu1dTuWwZZZ1Y4yiY5VPX1r0qq1s6e8NZmoMmT8ejkf448/VMh7mkqyciMxVMSU0T8lnByW5gydcXs1VzgD1NkZOspNDZtfHHHciTRMbiL3vNBu4Jr6A9fQUT+f745HNpTB0xOYP2MERlwOeZY3BnfkK9YGEkcjMsNrqEPTlzDldl9cHLvXDfvJmk0ipInnD2zbEhEgYMRFWnHLbtGbJI9rLn8gWqmbQvkPDmaZMRpBIUkkalOt3JXYtJupvy0qGDDARRaDzOZjC2uaDRhgM2EByoj8meRSJKP0rS/3GrMTePdXgadCebHWtLsbZKarOT2V6y2IhsIuzbFFotOsRuQX/eN/FALx6ssktVCvPdNJElSEEEXto3fhursMubf38XTXrBrWv4B0EFoRqWA+QoseTck2mzkBCvmig0Yf7s5BYjYJxeMeAzDaz9hehYFFvkjI5uRSuHRf/WpnWGRiau2NNS3DWGtzdwsKbPZSVaaexc4pg1a4ydMvX6OAGbqLKP58S+ZI7PlHyMUGkttmn/F3Pg2I30CFdYCGIK791PWCYY+CdWGvQqINWv/so9zGEcNK4=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(70586007)(316002)(36756003)(508600001)(336012)(36860700001)(54906003)(107886003)(7696005)(110136005)(8936002)(186003)(6666004)(5660300002)(83380400001)(356005)(2906002)(8676002)(426003)(82310400004)(70206006)(26005)(7636003)(2616005)(47076005)(4326008)(9786002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 08:54:32.6364
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f86fd773-5d67-4c44-ea44-08d9b3df0710
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT024.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6183
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set does the following:
  - Updates the Makefile for xilinx subdirectory
  - Adds communication layer support for sha_hash in zynqmp.c
  - Adds device tree node for ZynqMP SHA3 driver
  - Adds dt-binding docs for Xilinx ZynqMP SHA3 driver
  - Adds Xilinx ZynqMP driver for SHA3 Algorithm
  - Updates the list of MAINTAINERS

Harsha (6):
  drivers: crypto: Updated Makefile for xilinx subdirectory
  firmware: xilinx: Add ZynqMP SHA API for SHA3 functionality
  dt-bindings: crypto: Add bindings for ZynqMP SHA3 driver
  arm64: dts: zynqmp: Add Xilinx SHA3 node
  crypto: xilinx: Add Xilinx SHA3 driver
  MAINTAINERS: Add maintainer for Xilinx ZynqMP SHA3 driver

 .../bindings/crypto/xlnx,zynqmp-sha3.yaml          |  30 +++
 MAINTAINERS                                        |   6 +
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |   4 +
 drivers/crypto/Kconfig                             |  10 +
 drivers/crypto/Makefile                            |   2 +-
 drivers/crypto/xilinx/Makefile                     |   1 +
 drivers/crypto/xilinx/zynqmp-sha.c                 | 265 +++++++++++++++++++++
 drivers/firmware/xilinx/zynqmp.c                   |  26 ++
 include/linux/firmware/xlnx-zynqmp.h               |   8 +
 9 files changed, 351 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/xlnx,zynqmp-sha3.yaml
 create mode 100644 drivers/crypto/xilinx/zynqmp-sha.c

-- 
1.8.2.1

