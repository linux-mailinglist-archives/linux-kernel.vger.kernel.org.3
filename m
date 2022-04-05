Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98CE4F4A56
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1455477AbiDEWkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379712AbiDELl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 07:41:26 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4223F1FA40;
        Tue,  5 Apr 2022 04:01:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OAFxa6tZNX0TH63u4xQIqcJ3+aVEUHnrfEQRwRMkOHqMIxNNq0qQanXrY3N5fmpwk+MEMnE4JEXjwR2TXgyLxPiqzGpDBgemwgaDgA3TsUlU+dMfLrdoWoc7USgxiZzP5w11V40b4M9Mm+8QYNZsfxX0BQwKQ/avTyT6eAU5h6lyCH758aBJY/bBMh3gB80hna7lCh4hhvm3DiH5g5xpgB+f7fL/fjp1XEBIYw2xWTjTi/9uKhOonwljGareINkL4rW3i6xTiY0PtBVI3DWYQCrwGEzdgUghYdywvzujXcHOb4RM/thb/t/Nk0uwhNH1kVDVyxy919QoPYcqysWdcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJUpqvAAH4FLKxtgkjoMTc4/S2thdcEiyPyeSiO3TXA=;
 b=W6pxFD/WmCHOgTsIpG9qF5Brfe9OJw86pwt61bq3p95Gu61hOkFSiZL4VugGWTM865fcYletHhiP9SeKgahByFxo9gFWhNDSAh7POH4wHbBBUix3cT3sbXQR4CQW2Qwa4wYBb0HgUmacSMCyVnWSHytdU7n8TPyGIc2gjPngxx/gAVeJlULnPcg+Q+DEfOlFJd/HJ7Lfrd5tC1xcV9+kp3ZINX14rSDvP0ZoEjt4dhLscsul8w/6s70yxD8BEW9Si/WbwY8oIprPi2ehD68Csg4Dngit1BFwr4ETRkJ+/mTewo8ATps6PTQtkvIwyx1pPTx302TjQLmhF2tMZMRVjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJUpqvAAH4FLKxtgkjoMTc4/S2thdcEiyPyeSiO3TXA=;
 b=cfLTl7iz/43HLak/5ul7o8j5QhXxlSQnytoFAHT8vC+t4jYAQDzNxS7NMiL0kksqO9ZbihatRwX1meOK7TKGJ+IO2nWsMjwirU/iouZeO+DjBuERL2T4TZJPuaWlDqJG+90k527En9ElhxNOqS+ofhUPgHvl7E+8TnMruK0SCw4=
Received: from BN9PR03CA0602.namprd03.prod.outlook.com (2603:10b6:408:106::7)
 by BN6PR02MB2564.namprd02.prod.outlook.com (2603:10b6:404:56::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 11:01:29 +0000
Received: from BN1NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::89) by BN9PR03CA0602.outlook.office365.com
 (2603:10b6:408:106::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Tue, 5 Apr 2022 11:01:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT029.mail.protection.outlook.com (10.13.2.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Tue, 5 Apr 2022 11:01:29 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 5 Apr 2022 04:01:17 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 5 Apr 2022 04:01:17 -0700
Envelope-to: git@xilinx.com,
 saikrishna12468@gmail.com,
 broonie@kernel.org,
 robh+dt@kernel.org,
 p.yadav@ti.com,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
Received: from [172.23.64.7] (port=48930 helo=xhdvnc107.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lakshmi.sai.krishna.potthuri@xilinx.com>)
        id 1nbgw1-000FmV-24; Tue, 05 Apr 2022 04:01:17 -0700
Received: by xhdvnc107.xilinx.com (Postfix, from userid 14964)
        id 31C8D60351; Tue,  5 Apr 2022 16:31:03 +0530 (IST)
From:   Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>, <git@xilinx.com>,
        <saikrishna12468@gmail.com>, <sgoud@xilinx.com>,
        "Sai Krishna Potthuri" <lakshmi.sai.krishna.potthuri@xilinx.com>
Subject: [PATCH 1/2] dt-bindings: spi: cadence-quadspi: Add reset-gpios for Xilinx Versal OSPI
Date:   Tue, 5 Apr 2022 16:30:36 +0530
Message-ID: <1649156437-15609-2-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1649156437-15609-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
References: <1649156437-15609-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bba34b55-1ff5-48ca-1c24-08da16f3a301
X-MS-TrafficTypeDiagnostic: BN6PR02MB2564:EE_
X-Microsoft-Antispam-PRVS: <BN6PR02MB256414E77DB1121F87A1C3F3BDE49@BN6PR02MB2564.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: znESvpMITG2iNzufL+lw11SpnGZ9wSi4CWm2atV1F+OodNwyMf3Fp4QAPw4ksfED7TSNp/6zTzNVqr+Bvq9Fcx2zjb3H7STUzpYczyFxig0PQ0ZISjkeln7/n0YaTE3iIg5WNp93HVsOp3QfbPs5LAdGyn6cIRjRlnGm22wTpexo7QD8fMiIGjjgFxFwy7EQk2Cko+6NWbnK7LP+GkjV4DtFZV5IVcE+ArXQHHFFK2wVFitm9UCQ/QZHtOdu8sHdPN0Scpy4pxBjizSFg+aYkw2PYo6Mh+szfO+kNHArXHPl/+2wArnfyVz5je9F6iky//qCaTryA5DjCmZAl3EeDDm1P962h7jIlB+ONGsVNy7gYwxAHU3VBd+6OZG6Ulwx6rVq5UReF7OSqK/g42n7muPFWpLlTzsN+5pvSsEqu0mVK2wG0fv9GxkbK5odLofi4JzCTpb80exZdj1GS3NSwQYVe9boJd1YHHwpjmrxPQoP++gTgOOnENQcE61QaJDE4nFB8qcMovp0ID2IBqb+e2dT/iQfeQZ51ggEkR3uL+6TNb7+E/z895cidcEO2Qlx/6x1B+Zetkm83/QE+06lD2rtlRIv7vDs1v/5AWkk3kfryJDGRdrfvQaE2s35TNq5F+JglWSK+UEalBUE6Hn4t7amtUBLE/hG+g2UXl3Fjxk3AEyRYlX0xKnIyQmBLzh/SRgXymJV5EafYkew/4Qj8g==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(7636003)(508600001)(4326008)(70206006)(70586007)(356005)(8676002)(5660300002)(2906002)(47076005)(36860700001)(6666004)(8936002)(186003)(42186006)(6266002)(110136005)(82310400005)(2616005)(107886003)(54906003)(316002)(426003)(336012)(26005)(40460700003)(36756003)(4744005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 11:01:29.2719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bba34b55-1ff5-48ca-1c24-08da16f3a301
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT029.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2564
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset-gpios property to the properties list and marked as required
for Xilinx Versal OSPI compatible. This is used to perform the HW reset
for OSPI flash device.

Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
---
 Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
index 0a537fa3a641..56001eaf6365 100644
--- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
@@ -19,6 +19,7 @@ allOf:
     then:
       required:
         - power-domains
+        - reset-gpios
 
 properties:
   compatible:
@@ -78,6 +79,12 @@ properties:
   power-domains:
     maxItems: 1
 
+  reset-gpios:
+    description:
+      Contains a phandle and GPIO specifier for reset with the default active
+      state.
+    maxItems: 1
+
   resets:
     maxItems: 2
 
-- 
2.17.1

