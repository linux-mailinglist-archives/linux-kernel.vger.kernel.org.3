Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4D15B2539
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 19:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbiIHR5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 13:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiIHR5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 13:57:07 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2083.outbound.protection.outlook.com [40.107.102.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7F4A5C5F;
        Thu,  8 Sep 2022 10:57:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FtKILoAp91njFlPYPUk512OfH50YPAd21ds5QUa6ZdPe+3NPIxtQyHaZw5ODgZVN0WDGyYljXgq7XyIRzC89P5n9D0njTx7OvwVq31XnG6/l+hV/Yx64F3Yd2VVMH4JgAgLjZf0hZFscAO8Hjv6ZXNftltocLmFjs7SsA2NJ9Hc5caKYIQglLQ2PDytP9/DNWQ3h4uTN2ydCBL4/U4FQVgaQn1NiwoDA2vnTcc/Vhs3N/ANtoa2vCB8HfdtBI46iXnwuHJP70nZo7jI3zkTE/rndHisQWH2GDzApRumCLcbfgScujzhLtSdv1qPjCkXzh0yhgt5B+rH7iTklb9I0eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5JgX1CGKAryk+BON0Mpxmwa8dcA+gOcn3LwsmtFN7c=;
 b=bIvwIncVZn8J8kzSv0M8iN5z5DE0S9JrYZOi7Oy5bgxuCzH4TROie0BTcgG+iseY8bB9i9b38a6OAr6dzcY+SDPdYT7YXCqG9YUFNdkcrHa1m+8q8SkgMn//IslDEhVBOV/g8iBeJTYAtWE+5XQTg6iyB+edbyI1gDrRH9UyNqG54Nu1J/j/PN4dFvPCyPgc0Bb/IOrZfjgI8Q3tRAXDDHUOQo9KBjvKuq9BRnOCG2J7Gfi5UwvRhKzv3N3MpVcP5QV3uKE8KUv9PUgItCrnyh7+BIul/ikK4Dyrihk7Q2ZPQs00Ue8wUptv/C+8Kh49TVpO31EG/2JTUSRyW3DFIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5JgX1CGKAryk+BON0Mpxmwa8dcA+gOcn3LwsmtFN7c=;
 b=fOmysIec1QL5ItMF1dInpxotKo1K8qFB1DItGI6ShgyIUK8/U+MoObScHOiaSBvCvUEBCAu2oPSlZrIo612FCe6iHPgXFIkrmoNrQ+iqrOLOiOjL85qwVI0kk+JtMo42LvZwwE5unH/WNZjxTcDLQSeZFdszvdLUuIzHl/Mv8BjZxWot9pW0fCxrpS1wIbLr6dGtNw+EK+0AGf7mXA0DAe2RlIkucXV7Sf8aWrM2ncUMMVZfpkI8/9PctDDVSflnYSEfVBQozW5gJNgTgFY9qAPpHrykVeKYs+zSw/Kg525qFoDCGjomFdVnkYZMdkMarqKskkOQmmnUhx306+rJ5w==
Received: from MW4PR04CA0077.namprd04.prod.outlook.com (2603:10b6:303:6b::22)
 by BL1PR12MB5969.namprd12.prod.outlook.com (2603:10b6:208:398::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Thu, 8 Sep
 2022 17:57:04 +0000
Received: from CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::59) by MW4PR04CA0077.outlook.office365.com
 (2603:10b6:303:6b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Thu, 8 Sep 2022 17:57:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT080.mail.protection.outlook.com (10.13.174.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5612.13 via Frontend Transport; Thu, 8 Sep 2022 17:57:03 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.38; Thu, 8 Sep 2022 17:57:03 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 8 Sep 2022 10:57:03 -0700
Received: from jilin-desktop.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Thu, 8 Sep 2022 10:57:01 -0700
From:   Jim Lin <jilin@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jim Lin <jilin@nvidia.com>,
        Aniruddha TVS Rao <anrao@nvidia.com>
Subject: [PATCH] usb: gadget: rndis: Avoid dereference before NULL check
Date:   Fri, 9 Sep 2022 01:56:15 +0800
Message-ID: <20220908175615.5095-1-jilin@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT080:EE_|BL1PR12MB5969:EE_
X-MS-Office365-Filtering-Correlation-Id: 22f1a052-7bba-442f-3332-08da91c389b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EJmncxMdVbRsszgOWppqsSM/v2VFv2+zaMLN0Me33ODmRlY7rSgb20JfeTgVCf8KTGmTrldWujSE1eho5XCJJz93Wza074Nrg57r6hegzGdYA+elXGJXAsgBqXBtOMj801LvxE8fimMr9xpSEw1xEY3gCkJ397iLkhcZfOGj2LlxuYX78FUYcOGKlehKI+JXrNO8y2MnARClTlz/6JcCbEgmkeafhAnHxnl1RSh7S43fZwqmws6W3oqs4L3QeklLKY3gELvKZP9u5XAGUtlhHhufEoRNA5lZvDin/ruQ+g+T7UalXtbtMSp1IBXPxkCWP7Hu2emXl3kC5q1TKz+hDhCZuJivhifKMCnRvGg0gJfwCroL9f29Z/zZXwBtm1sFooOKWcUMB3x2GW0YxuW2NldBQd6zZnubujKWL+dGDb3CrdWzwvUTeNg2GmbQKsfwD6ePyxs0oMlhY9suzOWJ30xdLCmTVT0Tnldf/qvTIsOlts3K54k4Kyw+sEWtg3nIY9/qatEuTJq7N2EjWarHDvhLhbZj2fPQMm+9DRQRoczAwrUgQDK5nKGxdl/pRRk6gQcAA4RIPohrOfUbiRTbm5iApGTYPjiRacbgMM1iti/bKDJP060FABvVczvf+k42oN2DXZsrilzJEjYNRTOFDfIkSQVxxQ7TaFnz2dx+UYQIJcxBDtWUlJv36hEzMUEdZLyLXVOiHmnzaWffWLZFSPSvnnsMZsgLd5CVsCWawUx13WSNhs8qUuM/XO453C7mw2JbBLv2niZWL+DpNLg/21VS8WY4S+3y4B0ktqH04POnbEfVJQmZqnlJUdFnL5jD
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(346002)(136003)(39860400002)(40470700004)(46966006)(36840700001)(82740400003)(40460700003)(426003)(336012)(47076005)(4326008)(83380400001)(81166007)(70586007)(70206006)(8936002)(86362001)(26005)(7696005)(41300700001)(6666004)(1076003)(8676002)(186003)(356005)(2616005)(54906003)(36860700001)(316002)(110136005)(2906002)(82310400005)(478600001)(107886003)(40480700001)(36756003)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 17:57:03.9772
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f1a052-7bba-442f-3332-08da91c389b0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5969
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NULL check is performed after params->dev is dereferenced in
dev_get_stats.
Fixed by adding a NULL check before dereferencing params->dev and
removing subsequent NULL checks for it.

Signed-off-by: Aniruddha TVS Rao <anrao@nvidia.com>
Signed-off-by: Jim Lin <jilin@nvidia.com>
---
 drivers/usb/gadget/function/rndis.c | 37 ++++++++++++-----------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/drivers/usb/gadget/function/rndis.c b/drivers/usb/gadget/function/rndis.c
index 64de9f1b874c..d2f18f34c8e5 100644
--- a/drivers/usb/gadget/function/rndis.c
+++ b/drivers/usb/gadget/function/rndis.c
@@ -198,6 +198,9 @@ static int gen_ndis_query_resp(struct rndis_params *params, u32 OID, u8 *buf,
 	outbuf = (__le32 *)&resp[1];
 	resp->InformationBufferOffset = cpu_to_le32(16);
 
+	if (!params->dev)
+		return -ENODEV;
+
 	net = params->dev;
 	stats = dev_get_stats(net, &temp);
 
@@ -246,10 +249,8 @@ static int gen_ndis_query_resp(struct rndis_params *params, u32 OID, u8 *buf,
 	/* mandatory */
 	case RNDIS_OID_GEN_MAXIMUM_FRAME_SIZE:
 		pr_debug("%s: RNDIS_OID_GEN_MAXIMUM_FRAME_SIZE\n", __func__);
-		if (params->dev) {
-			*outbuf = cpu_to_le32(params->dev->mtu);
-			retval = 0;
-		}
+		*outbuf = cpu_to_le32(params->dev->mtu);
+		retval = 0;
 		break;
 
 	/* mandatory */
@@ -266,19 +267,15 @@ static int gen_ndis_query_resp(struct rndis_params *params, u32 OID, u8 *buf,
 	/* mandatory */
 	case RNDIS_OID_GEN_TRANSMIT_BLOCK_SIZE:
 		pr_debug("%s: RNDIS_OID_GEN_TRANSMIT_BLOCK_SIZE\n", __func__);
-		if (params->dev) {
-			*outbuf = cpu_to_le32(params->dev->mtu);
-			retval = 0;
-		}
+		*outbuf = cpu_to_le32(params->dev->mtu);
+		retval = 0;
 		break;
 
 	/* mandatory */
 	case RNDIS_OID_GEN_RECEIVE_BLOCK_SIZE:
 		pr_debug("%s: RNDIS_OID_GEN_RECEIVE_BLOCK_SIZE\n", __func__);
-		if (params->dev) {
-			*outbuf = cpu_to_le32(params->dev->mtu);
-			retval = 0;
-		}
+		*outbuf = cpu_to_le32(params->dev->mtu);
+		retval = 0;
 		break;
 
 	/* mandatory */
@@ -405,21 +402,17 @@ static int gen_ndis_query_resp(struct rndis_params *params, u32 OID, u8 *buf,
 	/* mandatory */
 	case RNDIS_OID_802_3_PERMANENT_ADDRESS:
 		pr_debug("%s: RNDIS_OID_802_3_PERMANENT_ADDRESS\n", __func__);
-		if (params->dev) {
-			length = ETH_ALEN;
-			memcpy(outbuf, params->host_mac, length);
-			retval = 0;
-		}
+		length = ETH_ALEN;
+		memcpy(outbuf, params->host_mac, length);
+		retval = 0;
 		break;
 
 	/* mandatory */
 	case RNDIS_OID_802_3_CURRENT_ADDRESS:
 		pr_debug("%s: RNDIS_OID_802_3_CURRENT_ADDRESS\n", __func__);
-		if (params->dev) {
-			length = ETH_ALEN;
-			memcpy(outbuf, params->host_mac, length);
-			retval = 0;
-		}
+		length = ETH_ALEN;
+		memcpy(outbuf, params->host_mac, length);
+		retval = 0;
 		break;
 
 	/* mandatory */
-- 
2.17.1

