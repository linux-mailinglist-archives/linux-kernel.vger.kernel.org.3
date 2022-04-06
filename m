Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986944F61AE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234730AbiDFOdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234956AbiDFOdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:33:23 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF4A4D2757
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 03:57:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vz10Dy+89MLxg18JfYmzCtx6Kz1MXMYGcBdcILuzAkfk6rwS8ZJOssbnDSHzMdSLhkhcnyRr+SP2zYaczKUq4/4dpFYxcXIKiBB5WoH8yX5Z9hnO8SPSbxtZpSgln2Rf+EI+M/RGDr/g7YCGrz95+o1PBphrb60mXKZ6blQT12OLH6agfmULyUgH86dnpm23/vugkdQLj246Bub7vZoVLSCgsaO0oK+hOXGpv4nV/nIMqr6ol+xnRwGHwuhoiQNMppK99TJnge30R8le20GhgkdFRC6ZvjM+3NxrXCFNdV9oGwt6g3E+4PFiHlUlEXDCvLj3nRbvl+++lR3RNxIyyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFVW/PsGy90COQ1+V+xVBCjd5AF8+iTJMoukAU8I5EE=;
 b=fEpzJzS2QwmlVGV6Aijao0R582D8ww65ermCUxQ2xYnElY1q9JUNcPuQymW6mkfu1IkcspH54cCIXPfKZgIlcAi6CpM53TYF6nmMgZug05tqBFuGJc8yRSnQ1JyoVYgG+euannjxmVWHB64NWf7FX1qr8H4mCn7FcJ0W6SS9v7zPz0RWXuMANIzYLBvtrDsUucQvwqnT7vtigDWh4kQhj2DL2oZvn8WyumiArmBOldxtQbXaqCIF6wAbJ/72tk3b9yLx51RxoOGqCOwoPgAqM5Av6a6A9AHsY8a49kP4WkRhcs+8cwNtrEg1efSbinPMBgK84CHP5CG9EOTeyUXR0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFVW/PsGy90COQ1+V+xVBCjd5AF8+iTJMoukAU8I5EE=;
 b=hEHPrUi8TLUEzSNiDX4zgjvP/lFnq8sGgiNpBX51XJZCl+IKAlgSkFR+seN04SWVDbih/FuptvqajFmqTrmJ9biArUQRA1nBXvO9nb3sNxYfiB3goyp1e8yx4k0DvAVJJXAuSSUnGi7UHaQ7J+79cY3RDPmhgHpQ8VGdUA1ayDs=
Received: from SA9PR03CA0027.namprd03.prod.outlook.com (2603:10b6:806:20::32)
 by SN4PR0201MB3566.namprd02.prod.outlook.com (2603:10b6:803:51::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 10:55:59 +0000
Received: from SN1NAM02FT0036.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:20:cafe::bc) by SA9PR03CA0027.outlook.office365.com
 (2603:10b6:806:20::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Wed, 6 Apr 2022 10:55:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0036.mail.protection.outlook.com (10.97.4.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.21 via Frontend Transport; Wed, 6 Apr 2022 10:55:59 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 6 Apr 2022 03:55:33 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 6 Apr 2022 03:55:33 -0700
Envelope-to: linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org,
 corbet@lwn.net,
 linux-arm-kernel@lists.infradead.org,
 arnd@arndb.de
Received: from [172.19.2.243] (port=36060 helo=xsjwillw50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <ronak.jain@xilinx.com>)
        id 1nc3K1-0007fI-Ic; Wed, 06 Apr 2022 03:55:33 -0700
From:   Ronak Jain <ronak.jain@xilinx.com>
To:     <michal.simek@xilinx.com>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <corbet@lwn.net>,
        <linux-arm-kernel@lists.infradead.org>, <arnd@arndb.de>,
        <lakshmi.sai.krishna.potthuri@xilinx.com>, <radheys@xilinx.com>,
        Ronak Jain <ronak.jain@xilinx.com>
Subject: [PATCH 4/4] firmware: xilinx: enable feature check for ZynqMP
Date:   Wed, 6 Apr 2022 03:55:26 -0700
Message-ID: <1649242526-17493-5-git-send-email-ronak.jain@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649242526-17493-1-git-send-email-ronak.jain@xilinx.com>
References: <1649242526-17493-1-git-send-email-ronak.jain@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0165b6cd-4197-4a5f-bd4c-08da17bc08cc
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3566:EE_
X-Microsoft-Antispam-PRVS: <SN4PR0201MB35664573B09D5824754C4434A4E79@SN4PR0201MB3566.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5pff+5lqmCjoYU+vqoEtY0AY0/L+99X2iNLnyfhHnq/ZIhRW8abK51ZnN+pzjo0Nv53Ihvc2AeTXeiwIeSr0fdXnBv68o4hQT1VkixyqplGc4WD0tmtCL0TuZRXKcq9/EzDcy52vXvbgjU7DvZu+xlNd03134lJVYCN9c+wNYThsRLoiW5B0pkkq/VKZfm4woCqAfVWGreNEsZlpjlP925sHuKl4C5tatD85mJyBZ8AZGySHb5WOOCHgI0HZTFgYra6wvy9qlRUiFZQgMayWFrDlbnfWLw3rJiu8odllWt8X5PZCFa5PBxvWqaLaB5TuVRc7vuyl8IQKa6NHgxqw/4HDZhExMJX8NEmCBgV5x3qh+GwSO/ah/OstN5ce0nVIcibC8aK0NDWL/O8F73TNhlsdjBz9RC+SOnq0xaYhSrR7ovZESaBR5HR3CckzyN+/b6XUfgI/gtQy5KMuk42u4SmwEYTl1mXM4QW+ZrjK6z1ngHCohXGeMUL54qdkmtgWFQlAKheHORKWFjGZJR4UBBbSB9CC94Vj90u6AGWvlAB6x+lwInGh3pUbP+O/+dVEpoNxo/1qXZA0vh0RJiJ6VFnvf3HAr6ZchVhlppTYolFEmbNWcas/Y/f2ewe1+saXsRfh3QIzqGYHi/Yb8r+HqP0mw/ysXKxYNgV57gqwMd1VBdbvwif2rXI+26KQjSXIbcFGfzJJp+up2MYfIkqUJg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(186003)(54906003)(47076005)(316002)(36756003)(7696005)(40460700003)(2616005)(508600001)(110136005)(336012)(26005)(107886003)(4326008)(2906002)(8936002)(356005)(70206006)(82310400005)(8676002)(70586007)(44832011)(36860700001)(9786002)(6666004)(426003)(5660300002)(7636003)(83380400001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 10:55:59.4491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0165b6cd-4197-4a5f-bd4c-08da17bc08cc
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0036.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3566
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the feature check if the PM_FEATURE_CHECK API returns success
with the supported version for the ZynqMP. Currently, it is enabled
for Versal only.

Move get_set_conduit_method() at the beginning as the Linux is
requesting to TF-A for the PM_FEATURE_CHECK API version for which the
interface should be enabled with TF-A.

Signed-off-by: Ronak Jain <ronak.jain@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 6ee94f31ac98..7977a494a651 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -1662,6 +1662,10 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
 	struct zynqmp_devinfo *devinfo;
 	int ret;
 
+	ret = get_set_conduit_method(dev->of_node);
+	if (ret)
+		return ret;
+
 	np = of_find_compatible_node(NULL, NULL, "xlnx,zynqmp");
 	if (!np) {
 		np = of_find_compatible_node(NULL, NULL, "xlnx,versal");
@@ -1670,11 +1674,14 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
 
 		feature_check_enabled = true;
 	}
-	of_node_put(np);
 
-	ret = get_set_conduit_method(dev->of_node);
-	if (ret)
-		return ret;
+	if (!feature_check_enabled) {
+		ret = do_feature_check_call(PM_FEATURE_CHECK);
+		if (ret >= 0)
+			feature_check_enabled = true;
+	}
+
+	of_node_put(np);
 
 	devinfo = devm_kzalloc(dev, sizeof(*devinfo), GFP_KERNEL);
 	if (!devinfo)
-- 
2.7.4

