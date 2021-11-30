Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFFA462F08
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 09:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239906AbhK3I62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 03:58:28 -0500
Received: from mail-dm6nam10on2061.outbound.protection.outlook.com ([40.107.93.61]:34305
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239922AbhK3I6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 03:58:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvqfWPtAC1w4faghGJk9+HNX/PLqieU1FfWJRF2TOoKHz6GJDW/VQ4qoEQcGoS/kuXoKdUc77iEMuXX/gkGoIa0DoupZ66as5P+RcVrDA5yNsvdsf9uJCNwcTUXqvkitsxkMA9EqOES70XOxzlaKFcHvdntCcdxywykgeS2+kWy89vHU8f7/T5t2TzNtvAYOL8ddy97AFohoHXuzdOuGqqJNpuiOCu6hmAamcjZfRuKdfcZALdLmLefKQkTSsw2nk+t0FGMrz5WRksGNzmd/wYXY0c32+hwBV1q1Dcjw84Sa84g/F+j0ked+y6r1vU6838BS2YohqJfv6Q7hufAXbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yn1idgsrINtwXzIfFMcoi8JlSDgxZYo+E3PlYIHq85Q=;
 b=lTK1Baac9FVBODLgoRkpnrvlstOujJsQ53RPm9fRCfG9OdZMge46V/2wAXYbpJbp/GMWpS1Bp4V8M33Q5YixObtcfDgI2lt7qULV6XDMGCzOKGpQFQsKgdMIHNuZ3NSMgpquTE5Cr1pgWuIVzQYELJJmJ14oldhfRh1Vm9NdDTppmA+d4skPRnC0rBnDTIK+5pDeh5YVnskm/tI9ilKJtIXxegyNXRe7tIQ4Pgl6OjosmW4qs8oiSCBDyoU+SptB2DdlrwOLgjueUNNP5Y+71HxSdhyxztxMaDUnA5CrDO/vbIWlI/lFqIU5UVi2v1bz3n39MoUYrJ6m07Phd05zjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yn1idgsrINtwXzIfFMcoi8JlSDgxZYo+E3PlYIHq85Q=;
 b=PZflkUVEToYmLgQr0lgPEqGOeov0yGGloXw3hAU5RAx0+gY1wkr71SZcyAVXtljRUVKuT0IriUxTWBOc6reu6nBg8Zw7evwwBIInnQuPqTHa4eZHVElZReJzf+rGgb+ioy7o9Py0/1iwNqchZxD9G8/OjLQpQrFeqEz0LWEOvA0=
Received: from SA0PR11CA0065.namprd11.prod.outlook.com (2603:10b6:806:d2::10)
 by SN6PR02MB5295.namprd02.prod.outlook.com (2603:10b6:805:67::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 08:54:45 +0000
Received: from SN1NAM02FT0064.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:d2:cafe::6a) by SA0PR11CA0065.outlook.office365.com
 (2603:10b6:806:d2::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Tue, 30 Nov 2021 08:54:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0064.mail.protection.outlook.com (10.97.4.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.20 via Frontend Transport; Tue, 30 Nov 2021 08:54:45 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 30 Nov 2021 00:54:44 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 30 Nov 2021 00:54:44 -0800
Envelope-to: herbert@gondor.apana.org.au,
 davem@davemloft.net,
 linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 robh+dt@kernel.org,
 devicetree@vger.kernel.org
Received: from [10.140.6.6] (port=56576 helo=xhdappanad40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <harsha.harsha@xilinx.com>)
        id 1mryuS-000GNC-5S; Tue, 30 Nov 2021 00:54:44 -0800
From:   Harsha <harsha.harsha@xilinx.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <saratcha@xilinx.com>, <harshj@xilinx.com>,
        Harsha <harsha.harsha@xilinx.com>
Subject: [RFC PATCH 4/6] arm64: dts: zynqmp: Add Xilinx SHA3 node
Date:   Tue, 30 Nov 2021 14:24:23 +0530
Message-ID: <1638262465-10790-5-git-send-email-harsha.harsha@xilinx.com>
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1638262465-10790-1-git-send-email-harsha.harsha@xilinx.com>
References: <1638262465-10790-1-git-send-email-harsha.harsha@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10348434-ea36-4b08-6198-08d9b3df0e81
X-MS-TrafficTypeDiagnostic: SN6PR02MB5295:
X-Microsoft-Antispam-PRVS: <SN6PR02MB5295B2EC56AAC1C17893FD4FDE679@SN6PR02MB5295.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gdyNbKW5LfiGQ38VsBbOu8zzbjTx1jNG1yXgbBvCrfxSItI+0l6MFhYbVqWzY35PsMasNh8UrvUznI1Dp8088BlfqyOsImX9votFhNnqh3JlRkhKsDJvkVAkCrXPdxM+FxbQ6YpCnPitG2A+kSVyqtFjqTV1ywDR9b1PlMO049U9jAf9GlvNzCKxkuHrtRPJkLTYtPUbv1QSeYcdZsq+M1c6uCYoOlrMmJLtiY3uXpKCh9C40QpCFidwIqH8tbLAmyarrUcz/iu4JI3/GqXHQzARlMoOr/28SEkBWeQOu8ibVqYmVzJm0gPDhgYepAFHMRXV5C6G911QTohLTJcFJRincX0GvJ/wl7lj80Rrg9ofV54BMhXueIxSoman4dVCT3xDCCTYuzPEIgUwvTbPuvCEO2Ao328xDGfMxPN4JK1kFegfk/lLxKq/6apo4AX96PrxOXHuJxES06Ubjl7EodKtKbcKRrM1l2Ug0V7ElEoTLf0eSstbtjnRSZnS4A3fV1gVrQH5XP1kw3z0RBZZsPQWD1MiCOM/4yQQ/lgf4J36+oGm7IfFHySHllRXY/YYKvO3e//1u/CD0jt2T5jGdLQT30/VRI3MZPfC0yq9i+ww8d9x23/1uMexP0lKop1P5TBJB8Ddb78hg6vzR00nC9i6rAar3EPLBrDdH7otr9QaQRcD1tbYgcugCwEiRp0l6b5z0btRJbI2VwVI0hGxEpTWL1N03dcY9kfiCN4QssQ=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(426003)(82310400004)(508600001)(186003)(4744005)(70206006)(6666004)(107886003)(2616005)(336012)(26005)(36860700001)(70586007)(7696005)(54906003)(4326008)(316002)(2906002)(36756003)(8936002)(5660300002)(7636003)(9786002)(110136005)(47076005)(356005)(8676002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 08:54:45.1265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10348434-ea36-4b08-6198-08d9b3df0e81
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0064.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5295
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a SHA3 DT node for Xilinx ZynqMP SoC.

Signed-off-by: Harsha <harsha.harsha@xilinx.com>
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 74e6644..33b7ef6 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -174,6 +174,10 @@
 				compatible = "xlnx,zynqmp-aes";
 			};
 
+			xlnx_sha3_384: sha384 {
+				compatible = "xlnx,zynqmp-sha3-384";
+			};
+
 			zynqmp_reset: reset-controller {
 				compatible = "xlnx,zynqmp-reset";
 				#reset-cells = <1>;
-- 
1.8.2.1

