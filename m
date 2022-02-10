Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4CB4B0699
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 07:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235724AbiBJGvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 01:51:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235654AbiBJGvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 01:51:32 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91150111B;
        Wed,  9 Feb 2022 22:51:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJM7/mdSzSKJC2pQBSQpu6MLv03XVmXD6qZYlBPYu4J/psW43cc9q6vBWe8wi+PXiuP+gI8wXGtccOpmC522/GZKiRMHKtvdhTd1Tg7Vnqdt+EC+3/Uk45kg1XjRae7no36mANKhXlmPPfiLYyW1lCGONUGQpEgG0oISSFlhy9GnTrAAxu+M8Ta01rXktfafsavyeAeDJqvoiz0sf82YPF/Or/ii5+JwRwTiwqHloevmWUpoqGVDyhWG29re1WqHBbe0uBGS85zbxRZlemBaVvApmtsj1tHKBwvSLD7WKkU6NRv4WPSOEoblukiN5QT4WqgZDf0paPzBNYzSi5RUjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqSv5upnBHfrIMKWFCoWxPoIIXnra5crEdhhW/W4OXo=;
 b=B1GXsSHglvtgM+idaJm68yDUsAYw5wzVBJRwAiwqh1kPWg2iqezTLssXpmMPmoHPJCT1WshgjckxvrqINdsDJr3iCqZ6J3bX7LXLOn+49px5Uxsi/cK1poVb90idNrUtETgX8uObLMdpI2+PB7uleay14Gnbim++N4aRtwv+p81BORMjOL5tjdbnKQ0vbuuLPVXMV1QDtjxu2SiOEAl7meucpXwwRMlxJEc7++zSNiKDIuyyQFo235Fi3bXIwYsFGqvDLoURzIHgVhFE+7KOt0M1Yu+s/V6TjF1DvPcGHppkuNuf9y9R3bs8yV3/2yADEf1DniQYtYa9etS+mMvLJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqSv5upnBHfrIMKWFCoWxPoIIXnra5crEdhhW/W4OXo=;
 b=oDu2yZ6GfzTbUYcQOCtSFaGxTnjwuEePn0evGlrgwUbGwE/vMkHaSTF6minvAR7m3NL6L6KFgjw5YGyiJ8ML/vXlwfnISGfF5lOblfq6YzJ6G0GKpwYKlPc7edgk4qV9BxMeX66SlrNmJ+9uQrf2fvIbFPsbOaGA5p8wznNXPp51Gy4y2r8Cs0w2H+PWSfJprDMqbYrT7TTLXzh8E4trbeu/P8BNwUDoG/UehDC/MAutndLVUSZ2udYw2tr2jEQPoKFX2vzPg8p3iT9liaMgDLPUy+0DAn/giz8Rw0B/j+w2gSN+BwSXbgiWuQrYzN0W45w05OCtJPZtH8hU2Gz5QA==
Received: from DM5PR17CA0063.namprd17.prod.outlook.com (2603:10b6:3:13f::25)
 by BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Thu, 10 Feb
 2022 06:51:30 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13f:cafe::7d) by DM5PR17CA0063.outlook.office365.com
 (2603:10b6:3:13f::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Thu, 10 Feb 2022 06:51:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Thu, 10 Feb 2022 06:51:29 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 10 Feb
 2022 06:51:24 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Wed, 9 Feb 2022
 22:51:23 -0800
Received: from mkumard.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Wed, 9 Feb 2022 22:51:20 -0800
From:   Mohan Kumar <mkumard@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <tiwai@suse.com>,
        <jonathanh@nvidia.com>, <spujar@nvidia.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mohan Kumar <mkumard@nvidia.com>
Subject: [PATCH v2 5/6] dt-bindings: Document Tegra234 HDA support
Date:   Thu, 10 Feb 2022 12:20:56 +0530
Message-ID: <20220210065057.13555-6-mkumard@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220210065057.13555-1-mkumard@nvidia.com>
References: <20220210065057.13555-1-mkumard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fab4c882-7308-4da4-19bb-08d9ec61c439
X-MS-TrafficTypeDiagnostic: BYAPR12MB2711:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB271178B145E0356B33EBFB77C12F9@BYAPR12MB2711.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lFN7NlowEG1U7rujNPm9t8SbdlhP5qTCmCofKGr/Gfe5M83zF9D06D0UPJh/R+omPTykzYG/JG7ZL9Ff79FT5tXBICVUbsgXF2aa13su1gNQMRTs1p8AwYD46hhuBt2AiUdzMyCnjd1J16LnRfVpQy1Mj/14ZTYVMJaMZLoKt0auv80u47BO+aT3egA1/1Zfu+ChVk+XrIvq2KJRb7/ylCmql0K5SsMQGxzAXZyMUli7EJc+7sHjUWjyrLIsY467nSs7gCbmqvxITA2uocEQB2JidDf3Syy9JV+CN4pwLH/asZt+MTkfyK10mK8/h7AQW/yDXFBKiHzOEpaC4WMjmiAA6p78gJ/j0dUTbr1biewbws1c+qFPNcyo2Efy0ShHMynYv0qTtc8wXIPJ98F9cgwMpI7X4qyPu5y1ql3DCrk2sGd3SKboo1YBDy8H28h+WOo5AGlfvE0IFDhicn94HjiYN2Rq+wL9Fr5HmBy21U1A7h6r8hXXXoGHOykn2MTvbGnYYiof3JV0vBdLK40/tZzU9vRVWJhYJGzNT+VdmfNsKA2+853gn8TDFoopAF609OLFiN+wUSOnAwr2flsKLjTvd8skpxN3UDwppSJin08i+/bHT4vBYfq9Y942x3chw454GlWR4oS0MNCAlAgJqn7lRylKW0joQoqq76U1k1OgcwIsMA50E6UNIcf2Wc5a7/RaNXLNAHbijoDeByALZJZBPE6z9dveh02pCo5teT8=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(47076005)(186003)(54906003)(26005)(508600001)(110136005)(316002)(6636002)(8676002)(336012)(70206006)(70586007)(83380400001)(36756003)(4326008)(1076003)(8936002)(2616005)(426003)(107886003)(86362001)(40460700003)(82310400004)(36860700001)(81166007)(2906002)(7696005)(6666004)(5660300002)(356005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 06:51:29.6601
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fab4c882-7308-4da4-19bb-08d9ec61c439
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2711
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update binding document for HDA support on Tegra234 chip.

Tegra234 has max of 2 clocks and 2 resets which requires to add
minItems and maxItems for clocks and resets as Tegra chips can
now have minimum of 2 and maximum of 3 clocks and reset support.

Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
---
 .../devicetree/bindings/sound/nvidia,tegra30-hda.yaml          | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.yaml
index 2c913aa44fee..12c31b4b99e1 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.yaml
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.yaml
@@ -23,6 +23,7 @@ properties:
       - const: nvidia,tegra30-hda
       - items:
           - enum:
+              - nvidia,tegra234-hda
               - nvidia,tegra194-hda
               - nvidia,tegra186-hda
               - nvidia,tegra210-hda
@@ -41,9 +42,11 @@ properties:
     maxItems: 1
 
   clocks:
+    minItems: 2
     maxItems: 3
 
   clock-names:
+    minItems: 2
     items:
       - const: hda
       - const: hda2hdmi
-- 
2.17.1

