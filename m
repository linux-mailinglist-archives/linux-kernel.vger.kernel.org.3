Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CEC4B0C5F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 12:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240941AbiBJL2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 06:28:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237809AbiBJL2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 06:28:46 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED12FFB;
        Thu, 10 Feb 2022 03:28:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WN/E4wKbz0ap3OhJmyQKaNycZKVhHYV/HianX+714ZkIBG7Cvjvh91IlK87EEAd8YTeYAL3XZ3gssfNjY50U6xfysufCI0wr8XKp+7Tb06mAEXsTYmaVbTNo3P6D9VkJC5/1heftaOFLSnW9kmqMCoxQ6gFdNmePXelvCVjAJ/DrVxvhVyZtTCLnQaNvzN9CrtdACr5i2zoMvEVDtnQEGWq9QkmBhoBwlVhCXXitx9s9UnB2h/ZD/A0hja3gE2mJ+eQlFYnzKxzdcN098DtSrIdoEOtumue8VmsMTiOnvmLJ2hKhoCqJ6TvyNLlbgMhRYJnHyGguIwaJNNB7GWru6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bEsl5pi0ji4alT/BXd+H03kLuZm9XiYydoO3j3zZp0=;
 b=BQptYz7iid/wwnzC+KZgA+G9d4cluya2Uh4duabpKLfnX1ThMwcRdc7N9THq93//mlRcRz6RnF7NKGjjCj5SFgrw93VURHBu3Yafe+EQg4+na8URHxfdk+RYtP9eVB5+iXWJo8k5gYiyn3rQyuqY25YIF6tZaGoVUHg+4hq62yooW6Ux1ebACEVtvVuG8C1jNoTJGJdj/a0QSWAmHduenix4lZ/2Z1ZhbuDsN/4VlNpP5l1+y4YvvNcaWUzvZEnUrAQb7gPl25GUWwXIrVV04cw7aZu9wdsHNMVI2+hrUatMyTWoVVT5nFH13TfDHnf6Mwdq6Un7ujHpZmBvERt4LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bEsl5pi0ji4alT/BXd+H03kLuZm9XiYydoO3j3zZp0=;
 b=oTO8uz+8Xw957EG4m3TDMXs937d6gneXwUo+P9GYWwog8auDmE42Wd5eAGPjjkG99//RTolB02VUm5mXuqULl4r+nQxxepOOHXI2/JzM9wLhYNlCdRvYLDEh8eoBdas1nm5pvjslrMi7a7PmSXr305nwMhAeOqSgxcsjXLmeb5g=
Received: from BN6PR2001CA0017.namprd20.prod.outlook.com
 (2603:10b6:404:b4::27) by CO1PR02MB8411.namprd02.prod.outlook.com
 (2603:10b6:303:156::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 10 Feb
 2022 11:28:45 +0000
Received: from BN1NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2603:10b6:404:b4:cafe::88) by BN6PR2001CA0017.outlook.office365.com
 (2603:10b6:404:b4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Thu, 10 Feb 2022 11:28:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT053.mail.protection.outlook.com (10.13.2.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Thu, 10 Feb 2022 11:28:44 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 10 Feb 2022 03:28:44 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 10 Feb 2022 03:28:44 -0800
Envelope-to: bjorn.andersson@linaro.org,
 mathieu.poirier@linaro.org,
 robh+dt@kernel.org,
 laurent.pinchart@ideasonboard.com,
 bill.mills@linaro.org,
 linux-remoteproc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [172.19.3.14] (port=48874 helo=xsjtanmays50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <tanmay.shah@xilinx.com>)
        id 1nI7cy-0000UP-02; Thu, 10 Feb 2022 03:28:44 -0800
From:   Tanmay Shah <tanmay.shah@xilinx.com>
To:     <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <michal.simek@xilinx.com>
CC:     <laurent.pinchart@ideasonboard.com>, <ben.levinsky@xilinx.com>,
        <bill.mills@linaro.org>, <sergei.korneichuk@xilinx.com>,
        <tanmay.shah@xilinx.com>, <arun.balaji.kannan@xilinx.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 3/6] firmware: xilinx: Add ZynqMP firmware ioctl enums for RPU configuration.
Date:   Thu, 10 Feb 2022 03:28:21 -0800
Message-ID: <20220210112824.2084724-4-tanmay.shah@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220210112824.2084724-1-tanmay.shah@xilinx.com>
References: <20220210112824.2084724-1-tanmay.shah@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 339ac1e2-0568-4891-942e-08d9ec887f91
X-MS-TrafficTypeDiagnostic: CO1PR02MB8411:EE_
X-Microsoft-Antispam-PRVS: <CO1PR02MB84119CD47C40DF781FDE843BCA2F9@CO1PR02MB8411.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:525;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iKuuw+TcdfeAjp9j0bnHvsB1qB0RLL1+WEX5/B8h+EcMZIPBBniIlNh9cePUlRIpsncWD1OT+lzItlB8ih/ynpMctKAzgLY1Nb4ETNbYsQmv5/EiF1VOVm7kNv7uUEhGPhd4q2aooTJvUDCLP00UrSCRGB5TVjwN0oc45n7Gp1Ud0f7PYyENhCEFBHxmRi0paZePJGQXcmY0OWfBIe7tXUgfndeQcQzMoMYG+7sqsuUW06p0mWRr8swZHFxC3ez64rwIDBr+hmbzgrkc2IGkeeTt9a6mBN9oguMhOrPJtumgEeqXqaiJngyNEL3FpHDE81JWG/8VTAUjJQBCnllt9WFeUWl/YsXANL5yRxvi1yyL0RV8AUAJm1sm/JigboIwZoQxbO7k50q8BeTi3wFBjN2Rg01u6cXK9g0HAk0LrilUWhieMvjWES8fj5dUxiKbps4NvoHiJseXj7m4/qroRzMFhC2WaanCaf/cZOjEIjrKcrwPCeVTVzG/5XkYFzknoYGLM8X56iTbHNir9DS9id9kgHX6go3VJpEf6SELQ81N3OqQEUyPG1y6jrgeyD2phPE7Lla3XyjfGWPRZeqyURbv7XAaPqQ3dnkBIZJsRe9gWPAlwPK7XkRZJYhw4AAHGQ0U9V3LIu28LRsq86wL7ma59zASIxV0Uz9ucrKxroSyThPp2Fh1241X0Iy7nNMskRTQtkjkorw0EqrIsGaYcA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(9786002)(82310400004)(4326008)(426003)(70586007)(6666004)(356005)(54906003)(8676002)(8936002)(70206006)(316002)(6636002)(5660300002)(40460700003)(2906002)(508600001)(44832011)(2616005)(336012)(186003)(26005)(7696005)(47076005)(83380400001)(110136005)(7636003)(36860700001)(36756003)(1076003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 11:28:44.8340
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 339ac1e2-0568-4891-942e-08d9ec887f91
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT053.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8411
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Levinsky <ben.levinsky@xilinx.com>

Add ZynqMP firmware ioctl enums for RPU configuration and TCM Nodes for
later use via request_node and release_node

Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
Signed-off-by: Tanmay Shah <tanmay.shah@xilinx.com>
---

Changes in v3:
  - None

 include/linux/firmware/xlnx-zynqmp.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 907cb01890cf..0834b00ee2b1 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -128,6 +128,10 @@ enum pm_ret_status {
 };
 
 enum pm_ioctl_id {
+	IOCTL_GET_RPU_OPER_MODE = 0,
+	IOCTL_SET_RPU_OPER_MODE = 1,
+	IOCTL_RPU_BOOT_ADDR_CONFIG = 2,
+	IOCTL_TCM_COMB_CONFIG = 3,
 	IOCTL_SD_DLL_RESET = 6,
 	IOCTL_SET_SD_TAPDELAY = 7,
 	IOCTL_SET_PLL_FRAC_MODE = 8,
@@ -162,6 +166,21 @@ enum pm_query_id {
 	PM_QID_CLOCK_GET_MAX_DIVISOR = 13,
 };
 
+enum rpu_oper_mode {
+	PM_RPU_MODE_LOCKSTEP = 0,
+	PM_RPU_MODE_SPLIT = 1,
+};
+
+enum rpu_boot_mem {
+	PM_RPU_BOOTMEM_LOVEC = 0,
+	PM_RPU_BOOTMEM_HIVEC = 1,
+};
+
+enum rpu_tcm_comb {
+	PM_RPU_TCM_SPLIT = 0,
+	PM_RPU_TCM_COMB = 1,
+};
+
 enum zynqmp_pm_reset_action {
 	PM_RESET_ACTION_RELEASE = 0,
 	PM_RESET_ACTION_ASSERT = 1,
-- 
2.25.1

