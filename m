Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8AE34B62E4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 06:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbiBOFe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 00:34:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbiBOFey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 00:34:54 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535142DD9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 21:34:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hni2vqbrQsE4ZcgLXEo5JES3Pig4zlc+HnuJA7UvGuOfBfN9VuXPAaCBQenbRMIGwWLsDHzX5vnrCBXN74lPPOOphp5rsx8mUWhuQRV8YeHrmGX9spEh8u2K6e1xiqCNZWJx2OhOuwEBbRl08w8UQN4lt/F/zeTY7xOyZORwM1Ir7Vg24NvPJkxedDw70oc4dztCYr+/0pq4rvOcUbddsLL5VDh8ZMB07ikdyENJwoe+DAFvSx5UC70BPNjp1b6WJYDarXAEHGnC6fbivvdxlCsaCn0nmZPFM7yT6TvTR2UN44vJJjDoMygg4HBvf2zTQArU5XP4LWnXpxhAylBJAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUEYW/y//cvqHzdZQNgOwwCI2ZIeZwJYzC1xtwxjvoU=;
 b=NSrIPhs2vh/7/ZrimaH4ZgetKZoBTCxOjR6e9mJw9MKWpZBpXwcoRqpOmFfGqvtghZJTUG02T0HBAJWA9+FTno7Fkbdmp7CDbmote+xQw8p6TtNC7s7s7ZtV8kA5/yWeJSA5oXenuFPmcHRictetmOwfWyUwqBA96oY8obov2V3SLRL7XXkXPrYWV6p+kw0R+02G8bvPMorBWhjkzTOFBDNzaZqGGv2XR1kSk7bIunLtrTqh5R/3V4ffP2LpD3o7D00wDAGr7PcaWiuzYW6P2SnxNUxtPChnxcl8V+EMaaf0GMS8jje8nunLUaMC2B0K/9wES+o0g32V9GtKrMG2BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=redhat.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUEYW/y//cvqHzdZQNgOwwCI2ZIeZwJYzC1xtwxjvoU=;
 b=rkAUsAB+S5ddJCei67TOtksqdQ02m3SFXf5phr8mcL36l39fNjFDYPedxL6rWCwcMtCZEd+1sgDd9HMzputNxoNNnGR5UpObk/FSzpo97q8RpalfnGbSkBBSQdG7TZZ4w17dnmvFxwjjV09ccWiRkkKyEdl3S0V3AOS+D1Ss8EY=
Received: from DM5PR08CA0045.namprd08.prod.outlook.com (2603:10b6:4:60::34) by
 BY5PR02MB6851.namprd02.prod.outlook.com (2603:10b6:a03:211::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 05:34:41 +0000
Received: from DM3NAM02FT059.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::ca) by DM5PR08CA0045.outlook.office365.com
 (2603:10b6:4:60::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Tue, 15 Feb 2022 05:34:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT059.mail.protection.outlook.com (10.13.4.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 05:34:41 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 14 Feb 2022 21:34:40 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 14 Feb 2022 21:34:40 -0800
Envelope-to: jasowang@redhat.com,
 mst@redhat.com,
 virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Received: from [10.170.66.102] (port=55580 helo=xndengvm004102.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <gautam.dawar@xilinx.com>)
        id 1nJqU4-000Gfz-BB; Mon, 14 Feb 2022 21:34:40 -0800
From:   Gautam Dawar <gautam.dawar@xilinx.com>
To:     <jasowang@redhat.com>
CC:     <martinh@xilinx.com>, <hanand@xilinx.com>, <pabloc@xilinx.com>,
        <gdawar@xilinx.com>, "Michael S. Tsirkin" <mst@redhat.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] Add definition of VIRTIO_F_IN_ORDER feature bit
Date:   Tue, 15 Feb 2022 11:04:29 +0530
Message-ID: <20220215053430.24650-1-gdawar@xilinx.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b1a09cb-35cf-4a80-b7c1-08d9f044dd8b
X-MS-TrafficTypeDiagnostic: BY5PR02MB6851:EE_
X-Microsoft-Antispam-PRVS: <BY5PR02MB685174F8A0FE0BDFD47B5D9BB1349@BY5PR02MB6851.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XVwak13/1o/u3hUO9wYgTBtsfyZq/KzTrssNU9nJhFG027HLcpKZbD9Y0RrBTOJswPUF+I7mzO2ix8WHEtjrNvOzDW9w0L3l9AVSf2cW/KNMMrXE0e0bwY2jNQ/hIwPpCrHcERQHreUNxJdgtlqXSXyoFUalaI8qm5U2uWitO721uC1OImDkiE0G3dE5ywXlgQjQHBg30hTy5cFlSL+p6pV+cb/EQ/8R0FVK+Ue0OYOUnd3oaT4tFw5T7rg9sN7NwzpSENEV3gNbhWnqTqXdOJhoJrDr9VB6lBYnjdDUBSN1lVAPhm2lXYb02V+7phuiZZukKBea6OOfWUJohmEgXnZh0q/VsrBWYIEsEfsljcYPiE2KCKKSyE/eea1OVBIUd4aFheaZQkpzfLRXMWjpbSBkp5SWSw+HTQTIGF2atbs38wLe54ias4Mi/KEUga5PdvGxuC6xKmgFAHphkVkfboT3NHvVMhRRzERBPhaZTT2/b5Qxy3dO+tBa4zhTVegAqa5z0F5ZDXWiaY678yhxb4w+uxnO3fWMhkOS9tX3RbeKOlOUv0sBy0CSX+AfHuGkAzcjkYzelr5mBqJoue3QG+MPm1RJkNND0ETDwkMI2inv0/J+q47g5EVNWqpNMJ3O6BqDh8Pzvcd4kuvkLg3MmSy1DOZRQbzce6sesiF6Hi6iFApJFkhQTQRcCjr1f9YF5yEGtqjhKigJeakDrrfvVQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(82310400004)(316002)(8676002)(4326008)(70586007)(70206006)(36756003)(7696005)(6916009)(426003)(186003)(26005)(2616005)(1076003)(54906003)(336012)(7636003)(83380400001)(356005)(6666004)(508600001)(44832011)(47076005)(4744005)(40460700003)(2906002)(9786002)(36860700001)(5660300002)(8936002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 05:34:41.4062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b1a09cb-35cf-4a80-b7c1-08d9f044dd8b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT059.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6851
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the definition of VIRTIO_F_IN_ORDER feature bit
in the relevant header file to make it available in QEMU's
linux standard header file virtio_config.h, which is updated using
scripts/update-linux-headers.sh

Signed-off-by: Gautam Dawar <gdawar@xilinx.com>
---
 include/uapi/linux/virtio_config.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
index b5eda06f0d57..f0fb0ae021c0 100644
--- a/include/uapi/linux/virtio_config.h
+++ b/include/uapi/linux/virtio_config.h
@@ -82,6 +82,12 @@
 /* This feature indicates support for the packed virtqueue layout. */
 #define VIRTIO_F_RING_PACKED		34
 
+/*
+ * Inorder feature indicates that all buffers are used by the device
+ * in the same order in which they have been made available.
+ */
+#define VIRTIO_F_IN_ORDER		35
+
 /*
  * This feature indicates that memory accesses by the driver and the
  * device are ordered in a way described by the platform.
-- 
2.30.1

