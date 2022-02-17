Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2B74BA98B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 20:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245102AbiBQTQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 14:16:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245093AbiBQTQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 14:16:00 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287C990CC0;
        Thu, 17 Feb 2022 11:15:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VmBzdgDCsRFzDQurRyq51C6IkaV8gz1PWofqdupPOj9xiWtP9ITkddg15mijgEnLeDOB2VT2sV1/xmGKP6QGs5IboZpiPr3Mm324hURshM/bqd/AONjThYJlbaYMpdKVI1+FxV7jeLG3sExs7jj36IblYe0pBohYTKm8FUlgEXRsySAqcBpVVEC2+Vbxt0S7BbyDWImgrvxFj1c5lFWwQZybmHRYIH9Wlbu/z21aMQuKtDSEXAbMzF0DRQIPOYcNmyJFnl554qoTWewVcHeDctocABlnyuYrXFcjwKtz/HNt6fDhIyn0rXrAZcjc/NgKY35xXiMgYucTk76FBgnEQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NiWZMfJQek6gI8XVl9p9fNAe96zfD8fVDEIHx2/RQ0Y=;
 b=IiiKGAYeHqliWMZB6DtgWu0pv3hRQgOPfnq3gvmycM8M4esmV3FZfxQat5Xja4BWtu1Aoj6ZsAvVUNJbGaNiOYfEN1VZctLR1ouPgpKx0919ki9j3VLp0yZmRMMhrEwZ1KTkDO63RS8F1eNGDSqt0jmM173fTx8jutzUzKuRAHbTlMbKb/Wo51SDJGw+SGgKh7c2ikp9uQ0UkPgjAQhwk+Oy9mbh+p7R7KuAbtF1EkFs8Koy+4koMUa3GQlTC7+iyNqfo2TXTCJkdLrKm5CPBl85Nnd1Cwv4xyD2AAPDDpeRCChCGo/g1FI4MsUYvmP4TnfF3Nrp38kL5Jry5IMpAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NiWZMfJQek6gI8XVl9p9fNAe96zfD8fVDEIHx2/RQ0Y=;
 b=eoLbfeXeVlYV/C2rUu9/pxDmubRXgFZ5+doat7310vNCbm0TFs+SwhlCtZxUjudLu7qjknLzPUgBxJ7CeaRINTkVFuH7EsPxX/MzkqqV/hfXJxlE6SlMlINr5ajeAfHU6Hr+bwJcaqFcdCyp3s+M8Dt3Seb1nA/Y4PAPNpPbJMs=
Received: from SA0PR12CA0006.namprd12.prod.outlook.com (2603:10b6:806:6f::11)
 by MWHPR02MB2448.namprd02.prod.outlook.com (2603:10b6:300:41::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 17 Feb
 2022 19:15:42 +0000
Received: from SN1NAM02FT0042.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:6f:cafe::1a) by SA0PR12CA0006.outlook.office365.com
 (2603:10b6:806:6f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15 via Frontend
 Transport; Thu, 17 Feb 2022 19:15:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0042.mail.protection.outlook.com (10.97.4.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Thu, 17 Feb 2022 19:15:42 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 17 Feb 2022 11:14:40 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 17 Feb 2022 11:14:40 -0800
Envelope-to: git@xilinx.com,
 herbert@gondor.apana.org.au,
 davem@davemloft.net,
 linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.140.6.15] (port=57270 helo=xhdharshah40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <harsha.harsha@xilinx.com>)
        id 1nKmEi-0002nF-6E; Thu, 17 Feb 2022 11:14:40 -0800
From:   Harsha <harsha.harsha@xilinx.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <michals@xilinx.com>
CC:     <saratcha@xilinx.com>, <harshj@xilinx.com>, <git@xilinx.com>,
        Harsha <harsha.harsha@xilinx.com>
Subject: [PATCH V2 4/4] MAINTAINERS: Add maintainer for Xilinx ZynqMP SHA3 driver
Date:   Fri, 18 Feb 2022 00:44:24 +0530
Message-ID: <1645125264-11033-5-git-send-email-harsha.harsha@xilinx.com>
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1645125264-11033-1-git-send-email-harsha.harsha@xilinx.com>
References: <1645125264-11033-1-git-send-email-harsha.harsha@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f437dc99-cbe3-423a-bb64-08d9f249e444
X-MS-TrafficTypeDiagnostic: MWHPR02MB2448:EE_
X-Microsoft-Antispam-PRVS: <MWHPR02MB2448FB14138FE571B822293BDE369@MWHPR02MB2448.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bIwb9Na0v95egiZDATgIcqGjbpkJMzyntTqgSHkahQFvyx/KXknvIrzqzkzpNwAiiedapLLlYUyWBQc+Qh9Pz9QauZfvzOD6v/8xlhvB5PWtmzCsPfiW3TLzj6d2GeOxBcJRwAuRL7xP7EL0NI8U0SByVfM8A+P/4BVKHJn5BIWJfE+iqsFYZGmW+PKDi9F7F7nSMyut2itWmtiFuLDNJ8CX1JRYtm1+1b2mlindABAkxqe1qZl8gQgN90Svr3EpCPpgShhoKq57NBNbq/O5D9wzX3eblWhaxwZOasmjccXdAOil1Zmr3UPKOp7cNyw/4RJCVhzDkpNuFL1DLbfHiVrcUgz90S2LZJpDsEBKkCGvgvoTD1H89ME07VdE6AV2nVOPWmGXBxnPn5r1RIajjzu2FxbPc/2+5AA5s+6DY60M5SXZMjod8m5WkHPXnf2SghQqCEmpaB5IsVOhvSOyHUv6bsSF1xRKi98aISR4lmNNbw1qZvq89gYFDw6/luD/Qf4X4HZLzgYj1FZzG4/4E8vKanmUnwOOtcq8dkk6+5mzSz+ngFDA6mylG4t5RlhDp0qXwsqL68ffKG6t8Me6WwsATgnf3bqKyCXFKxjjHnrX0eq4Gay6w7/FHTgIKzXU8I3ItfTVZCEMF1M1t/1RPVn4v9qfpDDuxwjjhHEec7jy/sqBEP7YYww4Kt1qM2FL+UxLIsjMa5h1B2SjT3pGOntwg4/nxckgo6zxWCbD7rlBSNyaX1+Iarx8J5MMCvGkpb1n6fNqlTyovZkf2hzcRwMO1RGlm8Ljpl5u0b2SKo7iwYLssxUCto1ZVxbfbwFV
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(7636003)(26005)(70206006)(2906002)(36756003)(356005)(110136005)(316002)(966005)(54906003)(6636002)(508600001)(82310400004)(4326008)(336012)(70586007)(2616005)(8936002)(8676002)(6666004)(107886003)(9786002)(47076005)(40460700003)(4744005)(5660300002)(36860700001)(7696005)(426003)(186003)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 19:15:42.4942
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f437dc99-cbe3-423a-bb64-08d9f249e444
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0042.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2448
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

