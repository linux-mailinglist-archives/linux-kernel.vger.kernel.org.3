Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD0174970C0
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 10:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236109AbiAWJru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 04:47:50 -0500
Received: from mail-dm3nam07on2048.outbound.protection.outlook.com ([40.107.95.48]:52193
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229453AbiAWJrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 04:47:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cS0miKA6pce0cr3S5g3EVj+YJVvlFaAS1IqukA9ldeBes6qV3zXcAnKqmnYnNJss1Y763BwG2uu2YldKdA8SCRwMNoVkHs5bRLM2f502mIhhUxZpJWG5qcUV3XZG2elr9XvPTx0gNeenZYQETRbDIHGAKdJ1Y9momovEc+mCN9YkvNgtjAo5JqeHF/Qo1qkmmCBaGhtktNZ1nzYLpL+PsllV1bbwY6QC4fSgdzXhj5YEhpngGFO4F1aBgUmQIDfSWvZMrdwgvgjrcosvX5QRNkRiGNh7TUb0PmJMZxbGQsX3AmBmMVSJReUhgPXd0c/kXOz95mimbSCFwVTs5UBN1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7oYz+yOpO5fZWjwhrq2haRf5AwCMeX0yNDQBW+j72E0=;
 b=Lk1DCr7K61jNi0+Z685J32yp9XOIV8bXz8yfEbnD+rEKOE11g2/Gkmg84le/4w/crpWzMtPncQ631NTUyPhT1XpuTx2N24sUv9Wu3B2qDRl0scfQvtG9wjdvEocSVQnHeejBUJ6IcjidUDtT1hJcw3WwaKkKXjT28C7CE5/TFqvZrSrRmdantxzSC+WWBvPAjT8vw2R8/N27FTlZhjbSbgB7Z9PzcXE8UvGwpD+bt8VPKrnTwXFOYFllQYyboAL/6+2SvC4pKlbFYG3OqQ/ClEUdxJXCXKabEWIoi/E/tjAV+jP2ilaDpbOj7br1uSZmgNr4Ivx7c6D7seR+DV2ZTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7oYz+yOpO5fZWjwhrq2haRf5AwCMeX0yNDQBW+j72E0=;
 b=BVWYdpjQxPab7IWJJ45471qFxIlHuFgMVjwHLBht9Z/e0CUkAhgH+V3PsyQ3bfsFoluXyKSG9cTM7hkJCagBYjbnQ3egsZwLH3UjxanisKyb5nDubGgo3kl9Vt2uwONQfKuCQ65CTrr8jWLdFyOUqTLGLQ/tHMTJnVn1KohpOYI=
Received: from BN0PR02CA0010.namprd02.prod.outlook.com (2603:10b6:408:e4::15)
 by CH2PR02MB6839.namprd02.prod.outlook.com (2603:10b6:610:af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Sun, 23 Jan
 2022 09:47:46 +0000
Received: from BN1NAM02FT024.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::5a) by BN0PR02CA0010.outlook.office365.com
 (2603:10b6:408:e4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10 via Frontend
 Transport; Sun, 23 Jan 2022 09:47:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT024.mail.protection.outlook.com (10.13.2.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.8 via Frontend Transport; Sun, 23 Jan 2022 09:47:45 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sun, 23 Jan 2022 01:47:44 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sun, 23 Jan 2022 01:47:44 -0800
Envelope-to: git@xilinx.com,
 herbert@gondor.apana.org.au,
 davem@davemloft.net,
 linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 robh+dt@kernel.org,
 devicetree@vger.kernel.org
Received: from [10.140.6.15] (port=60078 helo=xhdharshah40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <harsha.harsha@xilinx.com>)
        id 1nBZTL-0001bj-Sj; Sun, 23 Jan 2022 01:47:44 -0800
From:   Harsha <harsha.harsha@xilinx.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michals@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <saratcha@xilinx.com>, <harshj@xilinx.com>, <git@xilinx.com>,
        Harsha <harsha.harsha@xilinx.com>
Subject: [PATCH 0/4] crypto: Add Xilinx ZynqMP SHA3 driver support
Date:   Sun, 23 Jan 2022 15:17:03 +0530
Message-ID: <1642931227-20706-1-git-send-email-harsha.harsha@xilinx.com>
X-Mailer: git-send-email 1.8.2.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e804ffd-6b8e-4adc-8f67-08d9de55686b
X-MS-TrafficTypeDiagnostic: CH2PR02MB6839:EE_
X-Microsoft-Antispam-PRVS: <CH2PR02MB6839FC5400E32C7DCEB34321DE5D9@CH2PR02MB6839.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nMrzagI2au+uCHp9L7ag043Ep+czDE8OhZugbxbgREQ1JUjL4qkik53D+nPG+xyaK84nhYYfYDfjADwPdBctra79neBywnO8jBml0AtbUCZPEL79CePHIp+2KLRYZtZ+Kx4V1AlS+mExOXKCGkT329cnbTaGSxpMf56TD4MYPDc3tAap6Hduuv8cciQf4Eh7CgeC8Vy7+tVJjtTNLc1r5lBJkv7EKGRTpdP8SWVNGaxl6Z21LoOHUmWrrbguD1glXB57VPmd7mWaZJvReqKk2yTC/ge81CuYEVmf7ETgTJ5lM2klz8hEUFeM2QFKq9g8CDN7LtripQRYJXlqPkgGn1mTQPgzfTm53unRAjjy7ZPURkD4G4JJntC9MPIcQwz+4/19p/nravo30DWqNwn3oPmykRnQa/R5GP5c/6gG0NlB0uXS8FIVEdoscXnnSOWSi9eVWV/9PsuuQmeQ7hxUde5PVUZ66ROalsHInFRFDq0MELPEobeGVXIrTcuWzDqH34NGKxEGlpUGUqdk3nuoFlLObqc/e3HhoWkF7sABo3Raugb54ymk/6ociYUwAz9g+pqIWOBHg2VQruDtAuDiGWo3ZnLf8g6w9fUxU2DvZoiUAcyNGWxsZdOoin/N6tnhngLFjTrBHLPZkbJOJpHukqCJZDRc8+WioT6Sx5eKHP8ejAx4XcKmHIpXBeJjPMvceT3eH5yKr7qN50W5BEn6R23pwiDrqKdQvRsmpn3sy3k=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(426003)(2616005)(4326008)(2906002)(5660300002)(110136005)(4744005)(47076005)(26005)(6666004)(9786002)(7636003)(336012)(7696005)(82310400004)(107886003)(36860700001)(356005)(8676002)(83380400001)(54906003)(8936002)(186003)(36756003)(316002)(70586007)(70206006)(508600001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2022 09:47:45.3851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e804ffd-6b8e-4adc-8f67-08d9de55686b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT024.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6839
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set does the following:
  - Updates the Makefile for xilinx subdirectory
  - Adds communication layer support for sha_hash in zynqmp.c
  - Adds Xilinx ZynqMP driver for SHA3 Algorithm
  - Updates the list of MAINTAINERS

Harsha (4):
  drivers: crypto: Updated Makefile for xilinx subdirectory
  firmware: xilinx: Add ZynqMP SHA API for SHA3 functionality
  crypto: xilinx: Add Xilinx SHA3 driver
  MAINTAINERS: Add maintainer for Xilinx ZynqMP SHA3 driver

 MAINTAINERS                          |   5 +
 drivers/crypto/Kconfig               |  10 ++
 drivers/crypto/Makefile              |   2 +-
 drivers/crypto/xilinx/Makefile       |   1 +
 drivers/crypto/xilinx/zynqmp-sha.c   | 285 +++++++++++++++++++++++++++++++++++
 drivers/firmware/xilinx/zynqmp.c     |  26 ++++
 include/linux/firmware/xlnx-zynqmp.h |   8 +
 7 files changed, 336 insertions(+), 1 deletion(-)
 create mode 100644 drivers/crypto/xilinx/zynqmp-sha.c

-- 
1.8.2.1

