Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB94F48748B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 10:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346389AbiAGJN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 04:13:59 -0500
Received: from mail-dm6nam10on2048.outbound.protection.outlook.com ([40.107.93.48]:54880
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237011AbiAGJN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 04:13:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5XIdbHmUI45pxsPh6eY/JzWENojz4ENppLrELWuCjMA/6hmU3AdJxdh3irb4xadwszXt2em2R3yg2sGOY0DbFR4UafA2/ir8AgD1nSmScps+7cD2xsdAgXOjQvCL5g9TLglyrwlHBpVy4h/kS7rbrAY4Uqx77qz5fZwJ14d2cjia1e8PufDYWN8hvPMMdZ6iENfzfFgM9Lx4yNSDtq0rOQYjNhQk2/eLg/o6uXQST3H7OFSbfuAesSlR004xKXQcNotNJmENn3cJUO2wu4dHJBmoTija9PTI9xikBaq/nF1bjNEnJWAJrHs6vbFRNuQ1IWc4Tj6uwjIp9MBQNuLcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Awr26PGmdk3wpAdcAfqcnWOomBgvJOi9GIvyD9CyQwc=;
 b=ZMUjGacri1JnbNtl6063IG+abqw5Y4UW5MfZyfpRg8xyDZ08CrU/RQQeTZ+P/WjQwX2wKe24lh64oPURWp4hYK+A9Gt6mT5PuzWq0KwLpZ0fKlbVCdxsnFW3fhAuMgD1Rz6VX8WMzMloKZhAvYpbttOwsqSwuHwB4lMaSao5IRJdldSfXaXEvW31nFWzSTh6M37sM0Tl21kTiIeKbb5uRiOS669el/1PWz64zz+gQnl3tCDWbEiS7nf7DjspgX7bIAU3Xhn+9XR2wIAiG+uSCf0Gt2W4pQWH6YxmteCuVhLc9s0RaEX4PDKKMPQkrA7QD/ZcB+EfZLO/rP3Uxkr/cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Awr26PGmdk3wpAdcAfqcnWOomBgvJOi9GIvyD9CyQwc=;
 b=OKlCRtCyI03bU5JYHSygaCEImdXNEoCW1N6ChFzr4HZUc5KCgitQN6EYfIiBpVd/ZhOExevc4Vg4j+HikT6biRcPUB3Z70q8hxN8HwiLKtrT+GkGcvXTKYvbyCdwPkQdsVh/QqXFa0fYyuKs/DT54ZTbikwNgrzz7ARAK0A/wB/szSBLfYaEx/LtaGos5x9aqryEvc5chA5YHjQ7WxZlE8RHsO1dPT1J51eBgBU5ZHlEpr3qCIlHLrhmHhQ00edEHWw/ALcFcQatAswh3wN3QYVhPFKMAsQliKpuMGgPa4czRN7N/xPLcis0V2PKSOTmIbxuzCcKL8+EqnqmDvApvg==
Received: from MW4PR04CA0098.namprd04.prod.outlook.com (2603:10b6:303:83::13)
 by BYAPR12MB3240.namprd12.prod.outlook.com (2603:10b6:a03:136::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Fri, 7 Jan
 2022 09:13:54 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::f3) by MW4PR04CA0098.outlook.office365.com
 (2603:10b6:303:83::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9 via Frontend
 Transport; Fri, 7 Jan 2022 09:13:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4867.7 via Frontend Transport; Fri, 7 Jan 2022 09:13:54 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 7 Jan
 2022 09:13:53 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 7 Jan
 2022 09:13:53 +0000
Received: from waynec-Precision-5760.nvidia.com (172.20.187.6) by
 mail.nvidia.com (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.18
 via Frontend Transport; Fri, 7 Jan 2022 09:13:51 +0000
From:   Wayne Chang <waynec@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <zhangqilong3@huawei.com>, <yangyingliang@huawei.com>,
        <rikard.falkeborn@gmail.com>, <chunfeng.yun@mediatek.com>,
        <waynec@nvidia.com>, <linux-usb@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] usb: gadget: tegra-xudc: Fix control endpoint's definitions
Date:   Fri, 7 Jan 2022 17:13:49 +0800
Message-ID: <20220107091349.149798-1-waynec@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7f943ff-9bd0-4d11-87a9-08d9d1be0717
X-MS-TrafficTypeDiagnostic: BYAPR12MB3240:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB32400C96BB437FCC0C012903AF4D9@BYAPR12MB3240.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bN/Of/O9Pmfh6xI8/Hti3L243zQEaLwK9OdNwdCNGZ+lbdkrt/613N1GCQBxk+79Jp80pkZHTjdySJxKgazPhsElyzqxbiaauTAA0UYFW0zXOE3hveUlpA+bprg/o3fBc+h+FeeI4GyOVS4kGmQaCj4JwPcWthJITWY9X4jXz9a2H4ZMOOh5IxBev+g90hLJ5xDfRd1+PKc/xM2MlXF67yNVACYf+BO+SYbUr2zGIsJVeQtvIISgQu3XW03lrMSP+sOKeM11JnCb78nDVXPc4b22nL/zWRBsld8E/tQOFM4c66bxIALJCY4CQ9Fs15q7bHAJHi3a3nKumwul2jpt4gJ0eg3kLA+R8/K4Je6X+/PQhqYsFmiaennL+1Z9G9VQDcMVVRgN5v9NOIkggDyIvPuh+G05S5j+mqhko88VL3iRNyUB1QY2GOs1rejUCYi4WquhbFXI1JJOVTtJSc0i7KSek500XPa93y7V0RiEI5OC2xCKyD9hM9DKVxnj4VEwJ4rsT1BHxRrik2vyYHQoF7gACfRxVOuxWY+0mRZgpFhANsR6+lWAg+7dIYSm+w8LMH4sUsnZZLntGiFZQNl3g+mKmcXHtiUr0S1xB8q68CkhOalMC1Fg3xudozFyK4TWT1Dr4TbCTXShD2T3EaTzaxvnxvBOJc7YVxl3MYeb7Vm6Nlmwo/50zx117niEyA0uqlF+xzoA5ZyyT1XRBW/7zP1k12909gfUW6KSgeq1KIIkX+8W6j8DjH13kaUpO0Pln+lCbQwOWrGJUjetLX94NwjdYWhGuiuqNSXiJm01gic=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(40470700002)(46966006)(6636002)(83380400001)(54906003)(4326008)(8936002)(36860700001)(356005)(110136005)(7696005)(316002)(8676002)(82310400004)(70206006)(186003)(2616005)(336012)(70586007)(1076003)(36756003)(86362001)(508600001)(2906002)(40460700001)(426003)(5660300002)(7416002)(81166007)(47076005)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 09:13:54.1516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f943ff-9bd0-4d11-87a9-08d9d1be0717
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3240
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the Tegra Technical Reference Manual, the seq_num
field of control endpoint is not [31:24] but [31:27]. Bit 24
is reserved and bit 26 is splitxstate.

The change fixes the wrong control endpoint's definitions.

Signed-off-by: Wayne Chang <waynec@nvidia.com>
---
 drivers/usb/gadget/udc/tegra-xudc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
index 43f1b0d461c1..a8638feff46f 100644
--- a/drivers/usb/gadget/udc/tegra-xudc.c
+++ b/drivers/usb/gadget/udc/tegra-xudc.c
@@ -275,8 +275,10 @@ BUILD_EP_CONTEXT_RW(deq_hi, deq_hi, 0, 0xffffffff)
 BUILD_EP_CONTEXT_RW(avg_trb_len, tx_info, 0, 0xffff)
 BUILD_EP_CONTEXT_RW(max_esit_payload, tx_info, 16, 0xffff)
 BUILD_EP_CONTEXT_RW(edtla, rsvd[0], 0, 0xffffff)
-BUILD_EP_CONTEXT_RW(seq_num, rsvd[0], 24, 0xff)
+BUILD_EP_CONTEXT_RW(rsvd, rsvd[0], 24, 0x1)
 BUILD_EP_CONTEXT_RW(partial_td, rsvd[0], 25, 0x1)
+BUILD_EP_CONTEXT_RW(splitxstate, rsvd[0], 26, 0x1)
+BUILD_EP_CONTEXT_RW(seq_num, rsvd[0], 27, 0x1f)
 BUILD_EP_CONTEXT_RW(cerrcnt, rsvd[1], 18, 0x3)
 BUILD_EP_CONTEXT_RW(data_offset, rsvd[2], 0, 0x1ffff)
 BUILD_EP_CONTEXT_RW(numtrbs, rsvd[2], 22, 0x1f)
@@ -1557,6 +1559,9 @@ static int __tegra_xudc_ep_set_halt(struct tegra_xudc_ep *ep, bool halt)
 		ep_reload(xudc, ep->index);
 
 		ep_ctx_write_state(ep->context, EP_STATE_RUNNING);
+		ep_ctx_write_rsvd(ep->context, 0);
+		ep_ctx_write_partial_td(ep->context, 0);
+		ep_ctx_write_splitxstate(ep->context, 0);
 		ep_ctx_write_seq_num(ep->context, 0);
 
 		ep_reload(xudc, ep->index);
@@ -2812,7 +2817,10 @@ static void tegra_xudc_reset(struct tegra_xudc *xudc)
 	xudc->setup_seq_num = 0;
 	xudc->queued_setup_packet = false;
 
-	ep_ctx_write_seq_num(ep0->context, xudc->setup_seq_num);
+	ep_ctx_write_rsvd(ep0->context, 0);
+	ep_ctx_write_partial_td(ep0->context, 0);
+	ep_ctx_write_splitxstate(ep0->context, 0);
+	ep_ctx_write_seq_num(ep0->context, 0);
 
 	deq_ptr = trb_virt_to_phys(ep0, &ep0->transfer_ring[ep0->deq_ptr]);
 
-- 
2.25.1

