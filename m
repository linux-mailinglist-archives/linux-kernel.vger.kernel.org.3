Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD18E4970C3
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 10:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236124AbiAWJr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 04:47:56 -0500
Received: from mail-dm3nam07on2047.outbound.protection.outlook.com ([40.107.95.47]:14465
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236113AbiAWJrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 04:47:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8KMLU3nILmIG+kqkhl0Tr+w5fBrUwVy23E1vqtz9efcNPHjeZSKFn0+CzkTnQY9ijDW79PKx0jBEyWQ9HTpEmeNb41dv5V88qkf2SzS0+NcBbAN/kxM5mPTFyxSO8hzIOPXdAAuERWlVso38ScQ3OAr9ew6LqD6nt8vQop2pmcRJVNAO2nwyUzI7YMCYY7PiDZKZH27lx6LVyEEdpCQQnBbi1QVR2c6pqS18qklM79+XtYs2q9aAK9IbsLvWZYZ4OMkQcMhgGjCtAx4xceQqACqhEuLGwDFQXPCVDzvq2Fypy+QmMZdIW/bWFgqGXMyIsCOuz3VHKlf+ZVdk2NCMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gU76c8YXqyjJqYId7CBqPxg7Qp74rkLTsrT6kIdQTbE=;
 b=PF4jc7xbUMWehkSzsknCfxixlD5RKIwf5ARFg2seNwY2wIEw1fkOtqF6uPDREaATxtgVgN+IRnvj2YgHARaSebDAyFQ8pgdZIHoupCMERxFh8jyGaprg3blfjTx2kyktVq4Zz031bQJwmjt60sL4uthkHxZe+/VDd4nHN3A4kKAfB50rQSFPFTvTY9RyD3Zd9a+em4KZd8mQF/cBEKJKVHTd3gpjoBSGvXqkj7eE8XMyiRrbS3Lx06j9DzWvnWnnXa1PwA8jBjCbb17lcXJeQzUE0QrO2kJuekolvC7FCZAtQencmEQVJca4MFkQyrU9a08yINGDE16mWyaIdtwKKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gU76c8YXqyjJqYId7CBqPxg7Qp74rkLTsrT6kIdQTbE=;
 b=Z1tD7GijFSdaJXrgreFF+idCraCGBLZI8EoxRRNu59nabUPS5fvMA2GxkFAewD6NBfSHHzjkb9lKSMLj9Yi5Pev+iGrSM9cJkt9LeiE3CHX9kvdZnf2ixoXhCmOdLVC4CaLbEWZrBUcg5ySAi/7SAH1y0z9evbNyZq2Bl/JgoCI=
Received: from DM5PR19CA0014.namprd19.prod.outlook.com (2603:10b6:3:151::24)
 by SN4PR0201MB3533.namprd02.prod.outlook.com (2603:10b6:803:4a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Sun, 23 Jan
 2022 09:47:49 +0000
Received: from DM3NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:151:cafe::51) by DM5PR19CA0014.outlook.office365.com
 (2603:10b6:3:151::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17 via Frontend
 Transport; Sun, 23 Jan 2022 09:47:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT007.mail.protection.outlook.com (10.13.4.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.8 via Frontend Transport; Sun, 23 Jan 2022 09:47:48 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sun, 23 Jan 2022 01:47:47 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sun, 23 Jan 2022 01:47:47 -0800
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
        id 1nBZTP-0001bj-2v; Sun, 23 Jan 2022 01:47:47 -0800
From:   Harsha <harsha.harsha@xilinx.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michals@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <saratcha@xilinx.com>, <harshj@xilinx.com>, <git@xilinx.com>,
        Harsha <harsha.harsha@xilinx.com>
Subject: [PATCH 1/4] drivers: crypto: Updated Makefile for xilinx subdirectory
Date:   Sun, 23 Jan 2022 15:17:04 +0530
Message-ID: <1642931227-20706-2-git-send-email-harsha.harsha@xilinx.com>
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1642931227-20706-1-git-send-email-harsha.harsha@xilinx.com>
References: <1642931227-20706-1-git-send-email-harsha.harsha@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebd9becf-d46b-495e-a94c-08d9de556a2f
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3533:EE_
X-Microsoft-Antispam-PRVS: <SN4PR0201MB3533BE2C53134E1A5B433448DE5D9@SN4PR0201MB3533.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j4WEydejnzuFmKQCb3aBX9jFAgur96O2sMwtgWI8HGcnrZC8lvnig6x2hRalx2uNR4g/L9HHWDzvYlEGr6+pLIQB2s/1uBvHjMwVM11F26vVgk7OcxNRQLa0o6QeIDO9EE/LX4GOtILlGiA7kDdzO2+tAmBkzZ+6EKAEVpFyZ3GA8K5s5StCWMiQHzud0Uy3iIPNKkranA4D1cq1sOZ4Z5dTEgIGtiwaZNQTSpCm+N3mYu8IVIE/D/ddqUBteee5SfvZG5HBpwsP2yeL2ZWTuvTdppQ3ApGiLQOeCl/nfYIXdfkzSipxvejdnSGa4qOiZYrhcOv2TsFe9Fyw3Tt82VLuIucA8Up6oh2qHQWuiBHtxEaTzz9Y3+6gtiAe+SzZzD2onTGsUD6n/NLvlX3yJr2MJYLqCXey06MC9gjsabDzt5Xn3mj2GM0k0ioKfCB07UIilXKlHIZAxh0q+aBUYOeuoAxhYEHqhns+kiOn8vvxCjKU+elYNib8f3x9bI9sbvq6YfQ9FYB5DS8WJXps7j5GL2de5t2s1NCFQCt2L0GBkqPGtO1n2oTh9ILv8Y9H97sPvXTG5trSxKsMLGlQCGKJU0QjTzfThT7ys+78ifOuymUgjyD0UHtzKY6VtptwLSNWY4EvqujKCWJCUuTm+XmjmNASVtw4eQxvBhNZq89AOZbuJTcrP1Cp2rxSST0q2IlmJ7YM5VM3+iO33QPNA5hzLK3smidBEHXGQxunBGc=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(8936002)(426003)(7636003)(8676002)(26005)(2906002)(70206006)(336012)(15650500001)(356005)(5660300002)(47076005)(54906003)(110136005)(83380400001)(9786002)(70586007)(316002)(82310400004)(508600001)(7696005)(36860700001)(2616005)(36756003)(107886003)(4326008)(6666004)(186003)(4744005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2022 09:47:48.3793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd9becf-d46b-495e-a94c-08d9de556a2f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT007.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3533
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the Makefile for xilinx subdirectory.
CONFIG_CRYPTO_DEV_ZYNQMP_AES protects zynqmp-aes-gcm.o and it is used
twice (in drivers/crypto/Makefile and drivers/crypto/xilinx/Makefile)
and it is enough to use it once.

Signed-off-by: Harsha <harsha.harsha@xilinx.com>
Reviewed-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/crypto/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index 1fe5120..0a4fff2 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -47,7 +47,7 @@ obj-$(CONFIG_CRYPTO_DEV_VMX) += vmx/
 obj-$(CONFIG_CRYPTO_DEV_BCM_SPU) += bcm/
 obj-$(CONFIG_CRYPTO_DEV_SAFEXCEL) += inside-secure/
 obj-$(CONFIG_CRYPTO_DEV_ARTPEC6) += axis/
-obj-$(CONFIG_CRYPTO_DEV_ZYNQMP_AES) += xilinx/
+obj-y += xilinx/
 obj-y += hisilicon/
 obj-$(CONFIG_CRYPTO_DEV_AMLOGIC_GXL) += amlogic/
 obj-y += keembay/
-- 
1.8.2.1

