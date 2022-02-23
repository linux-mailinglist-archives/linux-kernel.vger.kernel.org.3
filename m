Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91A34C1062
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 11:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239631AbiBWKgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 05:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239486AbiBWKgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 05:36:37 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3823674DD;
        Wed, 23 Feb 2022 02:36:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gF3xyu8IOuD7NQyfHxXONx7KkII5icEMELQaHPgaRNL2O4bDtKYukPuiF8uWEWFZlFtLLg5KgKbWwdpjxjmf6P3pUif1VUeb9h+54cj0TGGuf0VjPzeCFmEf+J5vVBEIcLnMnQEzbgnKtcEirXjKQ/+uUb/WzDZA+0uZLz8iX+zYExQHmgUIZ7j5tLojVqvjMmMknfYeB5kkBH36OGBZv8o6dHS8s6t3XXpxAPNIWhEyC3ziL9cgP6EVvewrJdr8+F4+v30GO4JsrkFlczO/Acv75y5kMcwYClhd02A4iwRutLEJXpAEGHDJy/ZngcH6gHmjr3FnUaw/WiW6wLu0vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gU76c8YXqyjJqYId7CBqPxg7Qp74rkLTsrT6kIdQTbE=;
 b=aXPYffcwl08wNYM3UM6ExT+EBDbVkgU1xcN6oviaMZpuzc0rw3gV+yqu+KeBvj5rWF9YPFzKJdJ7Wxo8KrWUoQVQTxEIaLlEWRRMokmN/y+Obcp4i3YnoN8k02lruYS2eS4lXBvqhW4L0qjvwGAOEjNb1vGRjU8ZlwZL5WQ47teFnefM+SWKbVYywcTLrqQB7BNDsxXcDEvowYGDKzu0UGc4qhx5i56+hcMajTVWm/sqhmtWlqTI0Uj9lQjrtjYstrhg53Zp9uhbCh9xlwwavITa/Z7svWYcqqTc4ukhLQyGQHDDnEVWNHFIPS1JDmXib+DOHmgF67CdjnwUcFzR3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gU76c8YXqyjJqYId7CBqPxg7Qp74rkLTsrT6kIdQTbE=;
 b=omUBHKU91QQUXQyYK0gk2SZnGHt/AOFGnO2eKbq9G1rGVmcJW55W84s73aIyULToaDDOOQC3Z/TzZqeNcHeakxMz8DNGRzA6XYok5uSPHWv3RO0kRxtsqEv/uApGugkgAoMZ1ZT9gOGTU7ZIiz4Aikh+xrFwMt3PTVfZjOqi0Y0=
Received: from BN0PR03CA0041.namprd03.prod.outlook.com (2603:10b6:408:e7::16)
 by SA2PR02MB7692.namprd02.prod.outlook.com (2603:10b6:806:148::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Wed, 23 Feb
 2022 10:36:08 +0000
Received: from BN1NAM02FT058.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::6a) by BN0PR03CA0041.outlook.office365.com
 (2603:10b6:408:e7::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Wed, 23 Feb 2022 10:36:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT058.mail.protection.outlook.com (10.13.2.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Wed, 23 Feb 2022 10:36:08 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 23 Feb 2022 02:36:06 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 23 Feb 2022 02:36:06 -0800
Envelope-to: git@xilinx.com,
 herbert@gondor.apana.org.au,
 davem@davemloft.net,
 linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.140.6.15] (port=60324 helo=xhdharshah40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <harsha.harsha@xilinx.com>)
        id 1nMp09-0000KH-SZ; Wed, 23 Feb 2022 02:36:06 -0800
From:   Harsha <harsha.harsha@xilinx.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <michals@xilinx.com>
CC:     <saratcha@xilinx.com>, <harshj@xilinx.com>, <git@xilinx.com>,
        Harsha <harsha.harsha@xilinx.com>
Subject: [PATCH V3 1/4] drivers: crypto: Updated Makefile for xilinx subdirectory
Date:   Wed, 23 Feb 2022 16:05:01 +0530
Message-ID: <1645612504-3047-2-git-send-email-harsha.harsha@xilinx.com>
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1645612504-3047-1-git-send-email-harsha.harsha@xilinx.com>
References: <1645612504-3047-1-git-send-email-harsha.harsha@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1db4d438-b09c-4f10-b532-08d9f6b84d97
X-MS-TrafficTypeDiagnostic: SA2PR02MB7692:EE_
X-Microsoft-Antispam-PRVS: <SA2PR02MB769267B2E0F281932527B287DE3C9@SA2PR02MB7692.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mXSnR4vHJO7B/jS1UmQ+nftP8JYawev3yIbZRlw0fTJIm028kS8vE0+cBKUOSBDbrV6oSEAyG7Y+9irQbAvLksLLKvwd7yr57Jg66ZIHSNo/JNqevBUahu0h0XPN6qEUgM2yvEcvVbZqcYWkV67LiMSFqjXMYUuqr/rytKDI0inpQqHxk4y23BGO27b6LKZMN5wXaimCBYbFsMOqhsSl5iccSaSCWJ3py5DfF23YF89EnSzHB69/7UYirKQ0S3JGs297MWcjGRv7IiOsDMta6p1+Bip77tlpYIF9XF3pzpndZK8Ug8EJErj23piAz0tm5ZnTWW6Tl1qW9B9Yx4eX6uh0NT+rmhTJQw+ltQHD4uBELSbTKiWWTQNlbE1WnXcT5QjrqPFG5rKpHuWqkk/YHH5+wH8sQhW8jLMV52HGmhR5dkLSqQA/45aJB0Omfpetx999LAJiPhOfIl8Kc+O3QmBOrgsl9SmzrmDtLsTAP5c/5rc3VemzstPg3C0kKNTD6m3/jIi0e8Qv8gYK9QQrQ4A+7Edd7edJ1gslJ+6DqbqNPp1jetMiiCMZObIAXdCjLQu4tkKeUsKN7xZ0fve/HEdjNfAVlNdK+g9MI52fuxSbkQ8mTllKbRHlpTty1zWlTHsgGFrynqjBBViaUCTUUtxZxmnSU6jhuIsmmRuoBNxV8BYhmyz+HR4EbCvP+VOi3rlJx9/sA8JsrkIAjCwP7x4XzWlZIYhHnTv2kEWgjBk=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(6636002)(40460700003)(6666004)(110136005)(54906003)(186003)(2616005)(26005)(107886003)(356005)(7636003)(508600001)(316002)(82310400004)(70586007)(7696005)(4326008)(8676002)(70206006)(15650500001)(8936002)(2906002)(9786002)(83380400001)(4744005)(5660300002)(47076005)(36860700001)(36756003)(426003)(336012)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 10:36:08.4276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db4d438-b09c-4f10-b532-08d9f6b84d97
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT058.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7692
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

