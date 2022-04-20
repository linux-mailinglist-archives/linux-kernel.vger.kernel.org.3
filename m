Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91BF5082B9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 09:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376456AbiDTHxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 03:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376502AbiDTHxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:53:05 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBEE344E2;
        Wed, 20 Apr 2022 00:50:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWZ/ZRiwgxejH58B5KmUwQO7rjcfLNE0dk4uuc0wpSstBiitIbtw6jOWd+2OY/WRrmsJJSJRsVF4hk8gpa8OlfFU7YXg3OZ71FbR/FZPsAqOL1bE2DiqeEIVO5iD1iC7Fo/qStRfpSHx9H19RF9DkeYfCZjGDyRzoZYjjshXhZ5UZFK5ffFc8fXybwEyAlZ6Yg7R09D5UHe7J4hKouBQ+BBjEAOSPJ/7AXwIKTtDp1VK+Yuf63ClLMK5cJLg3gcqy4A42d1+6x47/7Vj8yclJcT+jmwgEK0bPfEaRgs3dFSne+X4gZGtIGvesP1bno/FT1W1EJXLUfLUNA4qeZ2kgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvLQspai5366iYyww6EDe9QFLxgy8c96MdOj/lhgiV8=;
 b=WDYPgw4m6rhYQ65SADlEEfaJ1yKSK62cJGP1hBtK8j17+x7O4uUkP1iuKc1y7Qs8gdt/+LoU9LUDMF3sBpvI4Ud1UelRz5S56jVkfo9VMZdBy0d+RMRVi1sK5eYOjpWpX+4uzmG2Qrh378i1Syb4INwB9wes4l4EjPBVAxBFccy0B+d/m3TObhszRInGKf0yq1UZpuQZY1mp7OGYTOojSkzY0/WgaUh0m2nYGLH/6soJS/XftH8raPuWdzD+VApVg1FCVSLTgI0CAiNXFecG0ol8c9dY7EZWzQP7D+pJ+jlHSVEa2vcb4CJjxLgqlUQvovt8rM3I8a7Oj80TWMaQHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvLQspai5366iYyww6EDe9QFLxgy8c96MdOj/lhgiV8=;
 b=sYC3AFqCQP4+oFPcvpPhatzFj+/52OtiJ0985HGIdJrJyGaBqwtvUt7MsEYlsIoa+19rPyVhHnErvQUqi1225u1f3f8zpnirUG0igMbl0aRUcMfsqMSxFPopfqup4D7y/Ka9XRGSJyTWNYUUWii7y8MC/K/ltYbMzfcRLXuAluQ=
Received: from SA9P223CA0029.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::34)
 by CY4PR02MB2341.namprd02.prod.outlook.com (2603:10b6:903:f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Wed, 20 Apr
 2022 07:50:18 +0000
Received: from SN1NAM02FT0006.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:26:cafe::ea) by SA9P223CA0029.outlook.office365.com
 (2603:10b6:806:26::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Wed, 20 Apr 2022 07:50:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0006.mail.protection.outlook.com (10.97.5.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Wed, 20 Apr 2022 07:50:17 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 20 Apr 2022 00:50:12 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 20 Apr 2022 00:50:12 -0700
Envelope-to: mathieu.poirier@linaro.org,
 bjorn.andersson@linaro.org,
 robh+dt@kernel.org,
 bill.mills@linaro.org,
 linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [172.19.3.14] (port=51254 helo=xsjtanmays50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <tanmay.shah@xilinx.com>)
        id 1nh569-0001h6-GA; Wed, 20 Apr 2022 00:50:01 -0700
From:   Tanmay Shah <tanmay.shah@xilinx.com>
To:     <mathieu.poirier@linaro.org>, <bjorn.andersson@linaro.org>
CC:     <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <bill.mills@linaro.org>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 3/6] firmware: xilinx: Add ZynqMP firmware ioctl enums for RPU configuration.
Date:   Wed, 20 Apr 2022 00:44:52 -0700
Message-ID: <20220420074450.2034092-4-tanmay.shah@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220420074450.2034092-1-tanmay.shah@xilinx.com>
References: <20220420074450.2034092-1-tanmay.shah@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6170b7e1-72ad-4470-e8f4-08da22a26994
X-MS-TrafficTypeDiagnostic: CY4PR02MB2341:EE_
X-Microsoft-Antispam-PRVS: <CY4PR02MB2341C747C4D6C77EE73B352BCAF59@CY4PR02MB2341.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j4+JVgvSqwDTp86itqpHKYjj+fgKKAee1EphEzyrMBIRndxIYm75/Devc9OmJqSEl7NUQhsWmrjTekSqb92neHsPOOxytEIHTMbi5BbsSQaxxOxJTYwPu3akEplINjVlNwvndh50ypoFi8fsTKHc+/+Eyin8rE0ZKKuZOqf9jQ37+QZiXPs0dVeSW1cQ4GxUVk5QcMLYn/H4XJFKcPhz+PyUZCsdYiOQ2egekEChvfihFzzdpKdcTN7EUogimbgjRJ2QODoiq766+4osiOMhep8Akk6cLNV3Zq+PS+m0RfMh/lHkLV3QVxMT92VNpdTYReKU7DdZlZoJsVn2nKBuoV7ksrQnLPlUY1Z1G8nWLgWguOBhAaCI/swBCRWJZylw4x8L9DwySFDGznFHwMogU7IH0ophqidK1QRi7/jywwHNQhYsv2NNHY10mWFuGpYMmYxJXHKI40s0WJfdSnuWsK7hGvtImh8SEOn//GoeVVChfb8xLDl3AAShxLzw+tJfmzbf6lhHv+r+DCjTn2m8trrCxKzjzHNk+Ay7VGNw3/GIJ1tnA1OTt0RpWGbARqgx6WT2Nqn7rFzsvNn5vu5hOS+K6iETVxtQ3nBcLatlEs1PriTyYE8GjuYbObAowGoQO7e9mypvgdci/KUb9dh8tApTF3u5YYhkFfrGx9fHNFoqOZL+Ju5dZLfN55VVZ2O3V6+zDSyAk8LRcZg7SI3CZg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(2906002)(508600001)(70206006)(70586007)(83380400001)(44832011)(1076003)(4326008)(8676002)(2616005)(9786002)(6666004)(8936002)(5660300002)(26005)(186003)(47076005)(7696005)(40460700003)(336012)(82310400005)(426003)(54906003)(110136005)(36756003)(316002)(36860700001)(7636003)(356005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 07:50:17.6978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6170b7e1-72ad-4470-e8f4-08da22a26994
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0006.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2341
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

Changes in v4:
  - None

Changes in v3:
  - None

 include/linux/firmware/xlnx-zynqmp.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 14f00a7672d1..54331b726ab0 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -129,6 +129,10 @@ enum pm_ret_status {
 };
 
 enum pm_ioctl_id {
+	IOCTL_GET_RPU_OPER_MODE = 0,
+	IOCTL_SET_RPU_OPER_MODE = 1,
+	IOCTL_RPU_BOOT_ADDR_CONFIG = 2,
+	IOCTL_TCM_COMB_CONFIG = 3,
 	IOCTL_SD_DLL_RESET = 6,
 	IOCTL_SET_SD_TAPDELAY = 7,
 	IOCTL_SET_PLL_FRAC_MODE = 8,
@@ -166,6 +170,21 @@ enum pm_query_id {
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

