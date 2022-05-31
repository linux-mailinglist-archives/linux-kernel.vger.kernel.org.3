Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9FCB539A2F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 01:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345725AbiEaXpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 19:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348718AbiEaXor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 19:44:47 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2077.outbound.protection.outlook.com [40.107.95.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E912C6EB21;
        Tue, 31 May 2022 16:44:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+PsdgoG4bcoaA9ytZgCUFjYBFFd91KYlN70hi3S80zcoCSdiUATcqggzRX61gsh2lEcHht0wl4jqqlw/GTGAQ5hSAKbEksxKRr1s38qRjH0p/EKQOlBIHTyk2m25KzVtSEksDAn65at6m6byk+yhe8Lu7umcTRg/LkEkA9TxwNwzRlMxoW5NLGBTrVWkhw5aWgc88Lu5wiPCabowp2dkyTehWebS9BQGO0HxRYWvpQsOjMYGYg85v6Jt+kuZnFqkbLxLHljmaEXHcwzVwmkGd5b9FspQUOJV4i1dbBshQKHcONWQ5/nZIpMxGjweRvjDSzvo+O1F/TAfScxfYm28g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1qo+X4zID93t2PC+EJanl3LngcEvB4rz4mVRVqEspk=;
 b=AWGbHoUGEeKNLAzDZ7qolvjUEpHsyl5kmBisM/n2CsFSvodezwtvUnTiTH9R005hn3noaJm+PjZ/t5lIla4brC3ZenMADjPFcTeI5a1Wi23deEbI1TThPco8xX5R9kcvTEAHGWttCm/zSR3r7VtIk34WWpzBF0/afXB2ORFdYTdgR3K6AhGXY1EP7JA4cr0gnzCmUM+4Nbp7c1TbZuQ3EIR1HRGCuvoHkgLnPRds0gTVfd0yngDC2WVKbUDyqypuHzYxAyLzYgdGZxAIJwkb4wiX/h5BFanK41ZpXnZb92rp4KhGnr1VZVEjMMgMtG8m1Vi7QVyOcQ91w5Zrdi4eZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.openampproject.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1qo+X4zID93t2PC+EJanl3LngcEvB4rz4mVRVqEspk=;
 b=Qms4BxkGPxij/gfDiYiXmeLik5XCySvW0GqU5aQqCvjjnTgkDRg8s98B/l5tzIO6NnK77L0xbkPI8dLUtrQy8K3fFz+1kaLCQVncP46R2rJ+Wk/HOLF41N49cQzhBCWQ9BNo8tlmE9bVY3A1XmSBZfIo8efG3KS0HqipEldStco=
Received: from BN9PR03CA0416.namprd03.prod.outlook.com (2603:10b6:408:111::31)
 by BN7PR02MB5091.namprd02.prod.outlook.com (2603:10b6:408:24::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.18; Tue, 31 May
 2022 23:44:45 +0000
Received: from BN1NAM02FT041.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::4c) by BN9PR03CA0416.outlook.office365.com
 (2603:10b6:408:111::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Tue, 31 May 2022 23:44:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT041.mail.protection.outlook.com (10.13.2.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Tue, 31 May 2022 23:44:44 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 31 May 2022 16:44:41 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 31 May 2022 16:44:41 -0700
Envelope-to: openamp-system-reference@lists.openampproject.org,
 bjorn.andersson@linaro.org,
 mathieu.poirier@linaro.org,
 robh+dt@kernel.org,
 krzk+dt@kernel.org,
 linux-remoteproc@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [172.19.3.14] (port=48904 helo=xsjtanmays50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <tanmay.shah@xilinx.com>)
        id 1nwBXU-0006jm-WC; Tue, 31 May 2022 16:44:41 -0700
From:   Tanmay Shah <tanmay.shah@xilinx.com>
To:     <openamp-system-reference@lists.openampproject.org>,
        <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <michal.simek@xilinx.com>, <ben.levinsky@xilinx.com>,
        <tanmay.shah@xilinx.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v6 4/6] firmware: xilinx: Add shutdown/wakeup APIs
Date:   Tue, 31 May 2022 16:43:08 -0700
Message-ID: <20220531234308.3317795-5-tanmay.shah@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220531234308.3317795-1-tanmay.shah@xilinx.com>
References: <20220531234308.3317795-1-tanmay.shah@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aed1bf90-f07c-4a0b-780a-08da435f8a80
X-MS-TrafficTypeDiagnostic: BN7PR02MB5091:EE_
X-Microsoft-Antispam-PRVS: <BN7PR02MB5091627C9D66946E72C848F5CADC9@BN7PR02MB5091.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DNKuTHd+kmVeJddfU6UbdmzJwiyGvtJ+DZE5fTvIY7Y9llgwGYbVPVVQ+Bke3bnFoKnNg93+XL32mwr3c2+8EMueCYl9VCTQC6SYlPJzak7OryWhCk095QR5yXwAWBxzm2lbPrMYNleZK2/miUTwbTj3XuHzsmrAofYoSp1PO5S4+Hmsyw5765GGT7MzwW8Hw6GuEtLw7uYBtWN29NYKdcY2CnfAylbS4drPtZsgiFACmAuaqQQopUFAWElN4MH7bYDnO9ZR3L6Jyda7yL7tW6RSIikA1to8dsJZokdJ4Rlv+J/skpMHVt6ZIKGjxnVPyHRbgY07b2gRwis5E60kybNLz9TVfp7NSY8DYZu5vFRALhNZ3tlUVvq3h9Kn2zRqQRh0c0bxDGdsZpP/0CyPG7drWSzRk+MwoXjpOWou7CidFgPCnkyq9l+ic4aXTID36VBVFgI81RyXXa1NEM1oF3Fj3a0XMRUeOxXw8h8BcUjIYtjwOjRpcXac2/AIdji1FtfjtKKshlyaV2axCgFDyLya01i8IWNAvs+ncxnABkp+R6a7A9UIgg51aBOyIOl+P5Uo6BcpIP6y7uVcdfYe+RfCH3YVzx1IH5mvevreR+B4hVnE/+9j4pGbqs7nJFkbW9V9i6O+OEyaTkEXatTjK2yhZhcYhEHEpx4m3AWLvuwJGwCr542IUdIN67Pc6vtc+6FHxK4QNmLE/egu/d5ILg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(70586007)(70206006)(4326008)(47076005)(8676002)(1076003)(2616005)(7636003)(26005)(6666004)(7696005)(8936002)(44832011)(9786002)(5660300002)(356005)(83380400001)(508600001)(54906003)(40460700003)(110136005)(36756003)(316002)(186003)(426003)(336012)(82310400005)(2906002)(36860700001)(7049001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 23:44:44.9413
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aed1bf90-f07c-4a0b-780a-08da435f8a80
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT041.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5091
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

