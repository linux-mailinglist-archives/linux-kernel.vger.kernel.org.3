Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CB153AAFA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 18:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356120AbiFAQWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 12:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355391AbiFAQVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 12:21:48 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2088.outbound.protection.outlook.com [40.107.96.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D042311A2F;
        Wed,  1 Jun 2022 09:21:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5VPk56oxcF5E32ApehXLVu5FbbIpOJxtRExwixSjCtWK+UOUrlyYTOLL2+vf+QamXB018/fUN+bQP9ejG2AWFw9rM5ixEOF0PBxGG3ErzJZHsR8lDW/0zIo9Lt3s2cfjbXe3gZjg31lV1SXaokWNpw/51qoTw/d5QkXfqvpacCHaSNoqhKAJdgvAfgfVqSLGV7gCNCEHSUIIlp/Ya2+W8QtsCy4KFnUWzrBVNjefVIMW+a0XLDYrz4n6tU1hEhurZiVTc1RaxSM+VCnfABQUdlO4phfmeGHK8WWJEIXc66eyFCenj/GQ/J9wM2EW9m0Keef0SCw0UCYWUUBBoUqrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3dIr+C9cOPSqyhMkmli6Lp4Y001Ce7A3XETn4DkGCI=;
 b=kNdR7WPflsK+4RApWZFsWLfBKdr0YyFTXf9WlP6GPzsrpn17iN7ypzDiHvX4+5La0PrE2IByMQ9N6C9aw7g3OAFhgEI0YDePtOD/ffVMTEKl+C5OmLeMYYd3R2BcF/HPyhv0NJH0GLcJP1aZx+Mg618RsiWgkNsWs0Fst/VBoBraIdroc+7RC005NB3y/pqyIU7LfWtuL2TqwkAtRz+IZvaP82YMiEcnMuQOQM8Siiu+K8R9vAxwhnGDGMJTAbrdOghgPPA12VLIw1d3Vqx/Ygg2sjqzlSrZtUPNOv39Ou4WiwJdtba8yXZEzGiG/mPF6w4p3m7sfLC5mAjwdTvEiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.openampproject.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3dIr+C9cOPSqyhMkmli6Lp4Y001Ce7A3XETn4DkGCI=;
 b=iBvQHC8FL9NrtnPTWry6Kp4GPU2bXN1l6GnW7Nm1fwh2CRJMW6VIDtLxfu1LSIiQju4TAxBEM63C2Hwkdu4NIlnSHSe4ehiCVC98D6HAtUqqigHabSf3TFoNJXaQzHbOA+d+HPTM1Ju3k2oF/Iuz5/XlaUiNam/n/cRuwTKoARY=
Received: from SN7P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::29)
 by BL0PR02MB4929.namprd02.prod.outlook.com (2603:10b6:208:54::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 16:21:45 +0000
Received: from SN1NAM02FT0064.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:123:cafe::26) by SN7P220CA0024.outlook.office365.com
 (2603:10b6:806:123::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Wed, 1 Jun 2022 16:21:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0064.mail.protection.outlook.com (10.97.4.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Wed, 1 Jun 2022 16:21:44 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 1 Jun 2022 09:21:38 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 1 Jun 2022 09:21:38 -0700
Envelope-to: openamp-system-reference@lists.openampproject.org,
 bjorn.andersson@linaro.org,
 mathieu.poirier@linaro.org,
 robh+dt@kernel.org,
 krzk+dt@kernel.org,
 linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [172.19.3.14] (port=50642 helo=xsjtanmays50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <tanmay.shah@xilinx.com>)
        id 1nwR6I-0003Rb-GN; Wed, 01 Jun 2022 09:21:38 -0700
From:   Tanmay Shah <tanmay.shah@xilinx.com>
To:     <openamp-system-reference@lists.openampproject.org>,
        <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <michal.simek@xilinx.com>, <ben.levinsky@xilinx.com>,
        <tanmay.shah@xilinx.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v7 4/6] firmware: xilinx: Add shutdown/wakeup APIs
Date:   Wed, 1 Jun 2022 09:21:10 -0700
Message-ID: <20220601162111.3505458-5-tanmay.shah@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220601162111.3505458-1-tanmay.shah@xilinx.com>
References: <20220601162111.3505458-1-tanmay.shah@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f7fd74b-ee81-495b-401f-08da43ead1e4
X-MS-TrafficTypeDiagnostic: BL0PR02MB4929:EE_
X-Microsoft-Antispam-PRVS: <BL0PR02MB49298221E0381E522A3A2859CADF9@BL0PR02MB4929.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hoaL4xqvgLTrYNltOKXha8Mr9nq2HCS/XUNaZ8THhxuDb2/iM7IWE5h52JuaV55CQ91KC9nOxc7bJ8xruuVMrm5uQhnzcCipwxhNMZEKQDButFxueKp14J60WqfbnlOLZCsh252Efh+boryRMAEjbcofVd+q5VznNupneOn2S+4ssrEQG2T4R6ysLZmKxCZ0y4Zzb3XL58yUuV6FtSWvNcUfgkibnQyGoAheZv0dDZI98YOszOfrMC4F7N1fp6E9aJA9kR6VDaXtre630SAFZsggWcnRD74yEO15WE+KOkjMfQoAQCywdrd5qCXKu4EahFiMi5NTNWtD13FZI95itYbhBchBdq3vFAOU2WJBRcEsYpCyF22IuL9Q7dNfUo1LqhflvI83CEJ0ko1RhGYup5l1VtwRdaVj0VLKFsHMweOUZ34/3ZYxPQVYZkYddrvk5+Tu8YgsvXL3eXNIxBhz0rcZ4ZQUVY0xKzy0l8aOfd80RDCqeMaWMVQM+GoaN8RNn5cv+gPkwTeCMDpJGwuCWFZ3FL8z+UtALCHF1l7Q3mFpecTDYkld3DNXHTBpaipM/kphIIPLkndG4LVjUJ7CSgqOtHUV6FOrRNTS6Jez3v/LINDKsoizaNi6SdwSnK+Z9AuptTYWxowscfFmChj2/OdpBEgoks6kTWXvgXuRT2WT6gQ92I5+3hnZsyl7ETyzcg9knUoqYzII7B8Obo9bZw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(508600001)(9786002)(8936002)(186003)(356005)(40460700003)(82310400005)(4326008)(8676002)(110136005)(54906003)(316002)(5660300002)(7049001)(44832011)(83380400001)(1076003)(70586007)(70206006)(7636003)(2616005)(336012)(36860700001)(426003)(36756003)(47076005)(6666004)(7696005)(26005)(2906002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 16:21:44.8370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f7fd74b-ee81-495b-401f-08da43ead1e4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0064.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4929
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

Changes in v7:
  - None

Changes in v6:
  - None

Changes in v5:
  - None

Changes in v4:
  - None

Changes in v3:
  - None

 drivers/firmware/xilinx/zynqmp.c     | 35 ++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 23 ++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index f21ece56695e..fabdbac868f5 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -1067,6 +1067,41 @@ int zynqmp_pm_release_node(const u32 node)
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
index 54331b726ab0..bce3465a70a4 100644
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
@@ -481,6 +484,12 @@ int zynqmp_pm_register_notifier(const u32 node, const u32 event,
 int zynqmp_pm_feature(const u32 api_id);
 int zynqmp_pm_set_feature_config(enum pm_feature_config_id id, u32 value);
 int zynqmp_pm_get_feature_config(enum pm_feature_config_id id, u32 *payload);
+int zynqmp_pm_force_pwrdwn(const u32 target,
+			   const enum zynqmp_pm_request_ack ack);
+int zynqmp_pm_request_wake(const u32 node,
+			   const bool set_addr,
+			   const u64 address,
+			   const enum zynqmp_pm_request_ack ack);
 #else
 static inline int zynqmp_pm_get_api_version(u32 *version)
 {
@@ -741,6 +750,20 @@ static inline int zynqmp_pm_get_feature_config(enum pm_feature_config_id id,
 {
 	return -ENODEV;
 }
+
+static inline int zynqmp_pm_force_pwrdwn(const u32 target,
+					 const enum zynqmp_pm_request_ack ack)
+{
+	return -ENODEV;
+}
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

