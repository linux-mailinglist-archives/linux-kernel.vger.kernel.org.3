Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0DB54F5E7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 12:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382072AbiFQKrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 06:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381975AbiFQKrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 06:47:35 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECA1271A;
        Fri, 17 Jun 2022 03:47:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ufv6AHc24PGfDh8rNNbVmEglR1LH8i3KsiNMfaKpu8QSH/T5qmCG4cuUzxdxzoVxd5WaEtEI4ipd7dH9LbNbETzqsIJfrzRXt3lBnaE1oeMNOmfD8km3Vsb+wNDwB3DZfN0PxgEw9Gzxj9sks7lniBsgncv5dsvDB3n30E4xgfsinCm1126WR2lDtc5Dx/K9Itb8Onuzt8FE8/thnAyipQfihmEB/hbwSUc1VT2kTbkLR6wmg273CslWQNq2/FVCnHKDFbA5PwhIkYAwK8528O4xMR9prW3254TS2bMo59lz+wK02ia4PcNyknEh4UZ40DvTMtc4W1s9FBq7aadgJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HC3R+vOEnFv40FR9MtEy5wY78xXPXvZvX2B2cehwhgQ=;
 b=QXWCUWZX+FjfrxnYfuIMwWT6f7+ZlkuwuWqTAbjjlG2O86evwWqwKrQFGFDtplHlR4SzSlNZEv3XB7hDrjS68PMhndmhorB9tELUMGbBLlu0JjnoU2QPzA+s+57erA1NDsJ6zqzIu/Ns2ZtgMp+6UNz4z82xBUueIhYw1bVz1pJg3KzOemBB7PUATv24NALVAb58pPOYONB3OyR826VT/7WF9tmnEsDi411yFj8bbJjkPxoPmHde3zv0MQ74CEyy6kTYIlxhh35anUS6eaFsppOWbMhhNHGaGPMcEva+uwk/J0qBTdYFA4EGMkzd6nMBf2vfudKRbnHHK2HwKQqWCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HC3R+vOEnFv40FR9MtEy5wY78xXPXvZvX2B2cehwhgQ=;
 b=pwNTHim5OhdXDkuNHxPNgW2lCx66+a0BE8Z5F7WpeE/FBpRoype+mgQIoj55NUklDJFH8PjwiLHVAxFhr2xn8F6ZEkIJrR1eLQ0qf+Xq5EJMw8uzxFwXCzls+S6TLbQQzNX1UlIxL0q2ZpfBp+qC7MOhnn7xlClA60F0c85xHLk=
Received: from DM5PR12CA0008.namprd12.prod.outlook.com (2603:10b6:4:1::18) by
 DS0PR02MB8926.namprd02.prod.outlook.com (2603:10b6:8:ca::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.19; Fri, 17 Jun 2022 10:47:29 +0000
Received: from DM3NAM02FT058.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:1:cafe::a6) by DM5PR12CA0008.outlook.office365.com
 (2603:10b6:4:1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16 via Frontend
 Transport; Fri, 17 Jun 2022 10:47:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT058.mail.protection.outlook.com (10.13.5.42) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Fri, 17 Jun 2022 10:47:29 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 17 Jun 2022 03:47:28 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 17 Jun 2022 03:47:28 -0700
Envelope-to: git@xilinx.com,
 saikrishna12468@gmail.com,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 linus.walleij@linaro.org,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.23.64.1] (port=60016 helo=xhdvnc101.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lakshmi.sai.krishna.potthuri@xilinx.com>)
        id 1o29Vf-0001Nv-Ri; Fri, 17 Jun 2022 03:47:28 -0700
Received: by xhdvnc101.xilinx.com (Postfix, from userid 14964)
        id AE6CB20F5E; Fri, 17 Jun 2022 16:17:08 +0530 (IST)
From:   Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <git@xilinx.com>,
        <saikrishna12468@gmail.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Subject: [PATCH 1/4] firmware: xilinx: Add configuration values for tri-state
Date:   Fri, 17 Jun 2022 16:16:56 +0530
Message-ID: <1655462819-28801-2-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1655462819-28801-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
References: <1655462819-28801-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 981606b8-dbef-4ce9-19da-08da504ec69d
X-MS-TrafficTypeDiagnostic: DS0PR02MB8926:EE_
X-Microsoft-Antispam-PRVS: <DS0PR02MB89268E949332E0E63E648B83BDAF9@DS0PR02MB8926.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZxeI1UiWGh84BvKz1UntHcKsiGwSaK1TMvq9fAVu/t4drE5FdxZcAGyQSUbvLXkkS+76cIhQOy1EGsCMStPhaEnoqwYxxwk877s+rj6NgzIMEGfZu7dWM1Ezuq8vuPO8QAQabk2r4vYAf/5aV3XUG0/d7u9xa8pqGecB/DXkIy7knPWvJAwhQaDJVmWwYDahrcoLNfo5xP9zp8muZKgoID4kgcX9yGpxYJsiNTivS30YWAnryGu9vOVha5JTUm/ihEr80Ky0HZdbtm5lzMkROxYhfkFXnfjuYMxSmwPEHKjmiJ+Ufe3KIDMzmdntd71N/3XY00A0jPqypZT0MW3VMIKC/2avkcE3S7LCPVhA9q6pqVaYXfM3XyO5F7ooKjwZoNjftZGx0bGz0woeEI+ihrfK19hblb+pMSPFso6Do3Ls3+z1EvMZkcdlgmQxZkc03BrvDkhW/AXMkZnt8I77jZgHOjNA5U64R9FfPXdxgtIeZxhszm0s4ceG8pqBXORvnu0vLjEMPHKJC5ahLQQ2O+vvmKBGeqS9mEAbfRaz42fDK9a2yHq68rPMq6cmjUhPTCiWFD56m9l9Lzq34OmHsMzx0h5xjQI/csg9VPPq1nUTu7NNXnkGAP+P/sUYqnksSnkKsMDbF0KADE35vbV6yNUcmdm7tWxn/SSJ2P8UElSsOrrR6dk2RBiyfT4PJm90PefmFdUoG1UsXrI6gbKe8Q==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(40470700004)(46966006)(36840700001)(82310400005)(110136005)(336012)(26005)(186003)(2906002)(40460700003)(6666004)(4326008)(7636003)(356005)(426003)(36860700001)(47076005)(8676002)(8936002)(54906003)(316002)(70586007)(70206006)(5660300002)(107886003)(2616005)(4744005)(508600001)(36756003)(42186006)(6266002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 10:47:29.5264
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 981606b8-dbef-4ce9-19da-08da504ec69d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT058.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB8926
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add configuration values(enable/disable) for tri-state parameter.

Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
---
 include/linux/firmware/xlnx-zynqmp.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 14f00a7672d1..7c4d2297cac1 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -363,6 +363,11 @@ enum pm_pinctrl_drive_strength {
 	PM_PINCTRL_DRIVE_STRENGTH_12MA = 3,
 };
 
+enum pm_pinctrl_tri_state {
+	PM_PINCTRL_TRI_STATE_DISABLE = 0,
+	PM_PINCTRL_TRI_STATE_ENABLE = 1,
+};
+
 enum zynqmp_pm_shutdown_type {
 	ZYNQMP_PM_SHUTDOWN_TYPE_SHUTDOWN = 0,
 	ZYNQMP_PM_SHUTDOWN_TYPE_RESET = 1,
-- 
2.17.1

