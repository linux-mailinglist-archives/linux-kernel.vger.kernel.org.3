Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0ADE4C1066
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 11:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239652AbiBWKhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 05:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbiBWKgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 05:36:50 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2067.outbound.protection.outlook.com [40.107.102.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977BD8118C;
        Wed, 23 Feb 2022 02:36:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKYHI20PQQc45asnXya5dy+GDG0kYcrTRyOzfxXOd7WfoktoYIovj3jzkxdcbnD1i/shHxD/v83Mcx9LseVrnKFRRJ9XiNLAv7t8MUCBjxLUQKJqG3HoUEYZBhb9nnHLau5/OuJGFlEhTPscxCyO6cy+F4a4VKQGOchByVErgR211LIDRp7rZ+NTapKjL7hprtQ/+DOmcczta8A243lTwZiu8eTAyVJM8EvHybG9WRStJPnLfKSuWcfSeS4Q1Lk1YuTnNjCnIa++SDdqt6yllzhc8Sgv4hoG7lAx+Bn1XUA+CMPsjIIHFsseAt0lcwzOmbgCEcxpGFmGWXQLR1Yozw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NiWZMfJQek6gI8XVl9p9fNAe96zfD8fVDEIHx2/RQ0Y=;
 b=U9CqsIdBZPSfKp0aLhwBLd6B/a40GyXVZ5NMVxLMsgsVMF8UVSlkiDbYMuTWvWn+H5PvUB6ecyx85vWFMfP9BveGZOXT1xiysiNv0jBjH+ZnLFCDTulqoSTjtC27ilHBxY43uCbIMXZ14KGU8UkoE8vQifTVGJvzkIBGnQpAmvUDrk2jN4aYg7x2KZLjup4AbpBrqZ2KjbXinRd09b2BcpVj236c7VC8pAt8mG0XCGmukuAM76V7e2/mB3lv5IbUAYPBOMdrYnAylT2+8pg/VG9VI3uT01IM4WU10YoIsCR9qwM+chOZ0lRv9zW38vbHoXymdHncl+31/RZAsHJlqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NiWZMfJQek6gI8XVl9p9fNAe96zfD8fVDEIHx2/RQ0Y=;
 b=Fa3j4Y33rXQ2GoF8mVoQQppV2yw7NHU4CsvVo3ZXrrUdo6YG6iG5Of1oG2+kW29hZUubCcGs6nfAc59YDCAAk7282/ROpKJPzmdNs6bBWB4IbVDkLUgwzMvdpD8DaOU6kwSx+RjlqzdjOJPvS2qPmxpo4ws0VKXnSZSLePk4S5s=
Received: from BN9P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::25)
 by DM6PR02MB4364.namprd02.prod.outlook.com (2603:10b6:5:28::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Wed, 23 Feb
 2022 10:36:22 +0000
Received: from BN1NAM02FT017.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::38) by BN9P221CA0003.outlook.office365.com
 (2603:10b6:408:10a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Wed, 23 Feb 2022 10:36:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT017.mail.protection.outlook.com (10.13.2.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Wed, 23 Feb 2022 10:36:20 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 23 Feb 2022 02:36:15 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 23 Feb 2022 02:36:15 -0800
Envelope-to: git@xilinx.com,
 herbert@gondor.apana.org.au,
 davem@davemloft.net,
 linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.140.6.15] (port=60324 helo=xhdharshah40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <harsha.harsha@xilinx.com>)
        id 1nMp0I-0000KH-Um; Wed, 23 Feb 2022 02:36:15 -0800
From:   Harsha <harsha.harsha@xilinx.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <michals@xilinx.com>
CC:     <saratcha@xilinx.com>, <harshj@xilinx.com>, <git@xilinx.com>,
        Harsha <harsha.harsha@xilinx.com>
Subject: [PATCH V3 4/4] MAINTAINERS: Add maintainer for Xilinx ZynqMP SHA3 driver
Date:   Wed, 23 Feb 2022 16:05:04 +0530
Message-ID: <1645612504-3047-5-git-send-email-harsha.harsha@xilinx.com>
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1645612504-3047-1-git-send-email-harsha.harsha@xilinx.com>
References: <1645612504-3047-1-git-send-email-harsha.harsha@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 760f4fe9-09d7-492d-7794-08d9f6b854d6
X-MS-TrafficTypeDiagnostic: DM6PR02MB4364:EE_
X-Microsoft-Antispam-PRVS: <DM6PR02MB4364DA43F227C01335CA5260DE3C9@DM6PR02MB4364.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jIb3Odry10Y4VBpMhUM0PCGPrCH15eHMgR1UGauD+DdZoL2JBEs3zy16PylcOts0mq9llNZrgvxTY8lwN3nBQa1zoifZlNrq+UjFTeuiFKYjJIs4LHVilq+zNrDNTtf7ff5vqF9cmGP5eUgLYGPaAv/Tr6890p44rtHeaxrYtcCcQ7bCiGbHzo4uUBLpeJUVBKJL7QwHzR5xvIwC00v8es/773t4mCUH0HyhkrJ+zUuDcYHPIz0Y6dkD69rPuP9hUgu+BkdYaeDT9IEXIjDyVqwfodFo0BOrgFqC1jzvqPDZKoXAiUKB1mBBM/i4bsSx+trB/E0Y7ediiHh0s/BdvKMKd+BWCdMLDpm+8OYQIKswDUod9tVmDJ7X0j7+pYr6XteGvodLtw5S1iFMLhh+kzNgwJjIW7WM1vhYMe8R67PXJGzxruMEU/eX/15GrocWTyC3b+obnC8GlyLaKMN5t3oZfmtItCQS5rPqjMgrlXR01qY436eImrXxxvYwK6Sl3SF3mPbMTYSxfw4qSWwb6QrQCOMsOnmEH9nR2FgxZsvLTtsvPS/W6WdxxtMExP0zh3qfDJwfbC5qPax9BJCE81iHAYTGqvAO0pWTjeKSsPy/jo6poMex+Mcw4VzTsqkHO4KKEjlRNMePdpfDeOJrvo19A2s0EHhrrE7T3RS0Lxr0hM8dvA0tbh718SHUq/RV+HtCeZNMEzYbjoIkp7UKGFJLNrpb7ErI50jaE9cxAnHvLthoGL9VXrcKZvzB6iVjWaamd9uCm3myLUEO4Y31AlwhxG5r+s4VdQYyWePpG6NVomfqoewf3x5FyscUR2RE
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(40460700003)(47076005)(7636003)(36860700001)(70206006)(336012)(36756003)(356005)(426003)(186003)(2906002)(70586007)(4744005)(26005)(2616005)(7696005)(82310400004)(54906003)(9786002)(966005)(8936002)(8676002)(4326008)(110136005)(107886003)(5660300002)(508600001)(6636002)(316002)(6666004)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 10:36:20.5830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 760f4fe9-09d7-492d-7794-08d9f6b854d6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT017.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4364
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds an entry for ZynqMP SHA3 driver in the list of
Maintainers.

Signed-off-by: Harsha <harsha.harsha@xilinx.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ea3e6c9..6ee2441 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21229,6 +21229,11 @@ T:	git https://github.com/Xilinx/linux-xlnx.git
 F:	Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
 F:	drivers/phy/xilinx/phy-zynqmp.c
 
+XILINX ZYNQMP SHA3 DRIVER
+M:	Harsha <harsha.harsha@xilinx.com>
+S:	Maintained
+F:	drivers/crypto/xilinx/zynqmp-sha.c
+
 XILINX EVENT MANAGEMENT DRIVER
 M:	Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
 S:	Maintained
-- 
1.8.2.1

