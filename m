Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1594B0C61
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 12:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240959AbiBJL3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 06:29:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240886AbiBJL2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 06:28:47 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0925CFFF;
        Thu, 10 Feb 2022 03:28:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbfq5QN4Clr+ZimGejzd8oBZbtJ/pmzTZ/diiP/TljTXITfSk7DG+cgUcJa77vPeJ9aq0fU2c2JC1bEdg1v1FdHry2GrfntLHap1v9eLk/FfUxzS77mAu3ICkX317CohHIQxbv9HG7Wugbyjyw7CmiMLnDJ1dwgiZrQtFNFdv+1C1vTVbAqa3VCxdfVfrqcran8nYiVGwuKz6twlKhTTtnh8jN3S4NCgfOvcU9/hcnKf5U4E89HyP+iAW6rSujW7Tokr+Z6bDEy4Qx+SFP+UGJ/u6upYhPyxM5vnYMfG1Ok9hQZw8QZuw8wrG0VGxEX8603PNxdVLftbWVwly4lIaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zfbF+Lq8vFqcxv1l4L1wZkgpKJl+6mDdDr2b6k6GZaU=;
 b=hg88MO5y2IHof+HelofVHWBvA9Uwx8dCD1VxViMv6mv9FWqLPH/mmPIw+V8WiGXIqUwudZjvNGYB6B1ZwuQSawWTthQjvdNRgHB7ZHYNjUhRQdjcNmOTIJMonSuT4+1YmPa30IHq5LfsPCfnInQydxTOLrLzXycYW7EALxIXxxtYNyMbS/ejmRu0/gR0ocoW8PAJnuS6ARuhDLqasexblOcOwQm5+LXwD66o5YPGaujfoUKA/R+3ZEA2QYxMQwIIKcqLpMiPFl3bPfXUpP2RGayJ7RRiFUsI62AmnKucgx40P9FshHjWBb29YNprxmY5HAU+WCVjvrjzD6LC4jRB3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfbF+Lq8vFqcxv1l4L1wZkgpKJl+6mDdDr2b6k6GZaU=;
 b=IIMutoTI63MO60zyzm+se9ZWinMQc6oLSf+FidEQAUgRh6qFAZNn3xQrlwn0nj/asnkGurU1erGNlXRxCt0m4u1MHHTO33SQVXT1192JIOAeeOYFF5eM9yDLnajA8TGKZsxX73kc1NHWfe6Gl8wIReipEohkpTB+MnsfK9yvnj0=
Received: from DM5PR10CA0005.namprd10.prod.outlook.com (2603:10b6:4:2::15) by
 SN6PR02MB5709.namprd02.prod.outlook.com (2603:10b6:805:e7::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.18; Thu, 10 Feb 2022 11:28:46 +0000
Received: from DM3NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::47) by DM5PR10CA0005.outlook.office365.com
 (2603:10b6:4:2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12 via Frontend
 Transport; Thu, 10 Feb 2022 11:28:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT061.mail.protection.outlook.com (10.13.4.230) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Thu, 10 Feb 2022 11:28:45 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
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
        id 1nI7cy-0000UP-1E; Thu, 10 Feb 2022 03:28:44 -0800
From:   Tanmay Shah <tanmay.shah@xilinx.com>
To:     <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <michal.simek@xilinx.com>
CC:     <laurent.pinchart@ideasonboard.com>, <ben.levinsky@xilinx.com>,
        <bill.mills@linaro.org>, <sergei.korneichuk@xilinx.com>,
        <tanmay.shah@xilinx.com>, <arun.balaji.kannan@xilinx.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 4/6] firmware: xilinx: Add shutdown/wakeup APIs
Date:   Thu, 10 Feb 2022 03:28:22 -0800
Message-ID: <20220210112824.2084724-5-tanmay.shah@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220210112824.2084724-1-tanmay.shah@xilinx.com>
References: <20220210112824.2084724-1-tanmay.shah@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35774944-6815-4503-3567-08d9ec888039
X-MS-TrafficTypeDiagnostic: SN6PR02MB5709:EE_
X-Microsoft-Antispam-PRVS: <SN6PR02MB57096DEDEC2A65AABE87B24FCA2F9@SN6PR02MB5709.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XcLT877Roji1nhshpmZNogO5uJcCkq7IdEL2oE+B7zIMBw4MrXoaHv2VTWYl2MOuFkQYDyHwZDPHn3ESSD4x+K01oy52bjrpqampmBNj0zmwSE5ucMZBGyxe9IbYdl0D99bUQE2gGlJYIEYvVX4+m8xM6xf+tYW12WmdAATPbdJ1FlWKgIH8UZ6NDlyrpnHdtyRT9qpEtaSak5Sf4jNmWGOIVOCn2iMmVQjLkoQ9pjIoo/CUPWwP7dd/et9nK8KD8bEWqNCrFknhGSwW/DrjvnKriGRCa+3UcaZcLC1f0Uwq6WdbREO5wlMdpCjeaFaDoBMdA812jEMEPBZt4QWtu2ZwNrwxa60K61XGsOeRv8iSTb99X8nFCeNh4E2lBPB1Xqi6at2ZyArxKENVxMLJqgNqb49INdjaWtIxnIWlMsSMLEZYojdjbGZQskDT9G1C3jBXLtztPElTwT7lX+Et358FCaTclyfIeORzPz5e2e6m1yEKIylXCKQxc8TykNJleq36yAy+xLTgaRGfmx1m6P3q2uYhlAkGnZY1xhC/JdDRrLdxD0xF/snSSLhrdrwdPHnG0dpRWHAFBaY6DxZ6KARKQ3jBwfsk6jtvYdNHgtP7VxWN6/YNtMhfb0beZ1Jv8K2eq/EMl9wXBwgdazv+p/Dah8WkJVdLAVpCsmndC9F9nfxmT/pwp+YvFg9lv8P3lZROkdduMQ6lh19vZ3YJ/Q==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(110136005)(6666004)(508600001)(54906003)(316002)(6636002)(356005)(7696005)(7636003)(8936002)(44832011)(4326008)(36860700001)(8676002)(336012)(186003)(2616005)(426003)(1076003)(82310400004)(40460700003)(70206006)(36756003)(83380400001)(9786002)(2906002)(5660300002)(70586007)(47076005)(26005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 11:28:45.9794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35774944-6815-4503-3567-08d9ec888039
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT061.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5709
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Levinsky <ben.levinsky@xilinx.com>

Add shutdown/wakeup a resource eemi operations to shutdown
or bringup a resource.

Note alignment of args matches convention of other fn's in this file.
The reason being that the long fn name results in aligned args that
otherwise go over 80 chars so shift right to avoid this

Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
Signed-off-by: Tanmay Shah <tanmay.shah@xilinx.com>
---

Changes in v3:
  - None

 drivers/firmware/xilinx/zynqmp.c     | 35 ++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 23 ++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 450c5f6a1cbf..7928d52c8ade 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -1057,6 +1057,41 @@ int zynqmp_pm_release_node(const u32 node)
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_release_node);
 
+/**
+ * zynqmp_pm_force_pwrdwn - PM call to request for another PU or subsystem to
+ *             be powered down forcefully
+ * @node:  Node ID of the targeted PU or subsystem
+ * @ack:   Flag to specify whether acknowledge is requested
+ *
+ * Return: status, either success or error+reason
+ */
+int zynqmp_pm_force_pwrdwn(const u32 node,
+			   const enum zynqmp_pm_request_ack ack)
+{
+	return zynqmp_pm_invoke_fn(PM_FORCE_POWERDOWN, node, ack, 0, 0, NULL);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_force_pwrdwn);
+
+/**
+ * zynqmp_pm_request_wake - PM call to wake up selected master or subsystem
+ * @node:  Node ID of the master or subsystem
+ * @set_addr:  Specifies whether the address argument is relevant
+ * @address:   Address from which to resume when woken up
+ * @ack:   Flag to specify whether acknowledge requested
+ *
+ * Return: status, either success or error+reason
+ */
+int zynqmp_pm_request_wake(const u32 node,
+			   const bool set_addr,
+			   const u64 address,
+			   const enum zynqmp_pm_request_ack ack)
+{
+	/* set_addr flag is encoded into 1st bit of address */
+	return zynqmp_pm_invoke_fn(PM_REQUEST_WAKEUP, node, address | set_addr,
+				   address >> 32, ack, NULL);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_request_wake);
+
 /**
  * zynqmp_pm_set_requirement() - PM call to set requirement for PM slaves
  * @node:		Node ID of the slave
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 0834b00ee2b1..94ba5a40f6e2 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -12,6 +12,7 @@
 
 #ifndef __FIRMWARE_ZYNQMP_H__
 #define __FIRMWARE_ZYNQMP_H__
+#include <linux/types.h>
 
 #include <linux/err.h>
 
@@ -81,6 +82,8 @@ enum pm_api_cb_id {
 enum pm_api_id {
 	PM_GET_API_VERSION = 1,
 	PM_REGISTER_NOTIFIER = 5,
+	PM_FORCE_POWERDOWN = 8,
+	PM_REQUEST_WAKEUP = 10,
 	PM_SYSTEM_SHUTDOWN = 12,
 	PM_REQUEST_NODE = 13,
 	PM_RELEASE_NODE = 14,
@@ -466,6 +469,12 @@ int zynqmp_pm_load_pdi(const u32 src, const u64 address);
 int zynqmp_pm_register_notifier(const u32 node, const u32 event,
 				const u32 wake, const u32 enable);
 int zynqmp_pm_feature(const u32 api_id);
+int zynqmp_pm_force_pwrdwn(const u32 target,
+			   const enum zynqmp_pm_request_ack ack);
+int zynqmp_pm_request_wake(const u32 node,
+			   const bool set_addr,
+			   const u64 address,
+			   const enum zynqmp_pm_request_ack ack);
 #else
 static inline int zynqmp_pm_get_api_version(u32 *version)
 {
@@ -666,6 +675,12 @@ static inline int zynqmp_pm_pinctrl_request(const u32 pin)
 	return -ENODEV;
 }
 
+static inline int zynqmp_pm_force_pwrdwn(const u32 target,
+					 const enum zynqmp_pm_request_ack ack)
+{
+	return -ENODEV;
+}
+
 static inline int zynqmp_pm_pinctrl_release(const u32 pin)
 {
 	return -ENODEV;
@@ -708,6 +723,14 @@ static inline int zynqmp_pm_feature(const u32 api_id)
 {
 	return -ENODEV;
 }
+
+static inline int zynqmp_pm_request_wake(const u32 node,
+					 const bool set_addr,
+					 const u64 address,
+					 const enum zynqmp_pm_request_ack ack)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.25.1

