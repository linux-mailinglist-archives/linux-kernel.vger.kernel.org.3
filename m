Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F814B83FA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 10:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbiBPJXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 04:23:36 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbiBPJXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 04:23:32 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on20605.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eb2::605])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7631D4B5E;
        Wed, 16 Feb 2022 01:23:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrDUa/UJc8/OBL9cGe6wwRIscQ+AwigZfU0TtvJYls1HscuXPV2GKei6TOzbdpFtoCAHVbR7PlTrvgTeCPZ2bV0gGySXhzfpQTND1MvBAesfvAeq1dZuM6l8DinGZ+YByCgeOHrcQEUIeN6oGtCDksweF8imKuVeNDLxx6+kBy7X3/Q9hJQiueQpi9+ZDGsU7IYixw6GPcVNzP3a5UCUmta9yf9qyIwr1Pe2Z8RF5+3oi8oaeiBM6BaqcUCBjemKVzS/rtXyAxypM5H3sswPrtVEk3wdSc/7MrLAcqCgG2bnQ1O2ohwZwwXwz94QbHPzvArf5s4N275dM5rrk+a2AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqSv5upnBHfrIMKWFCoWxPoIIXnra5crEdhhW/W4OXo=;
 b=cyNbPchvob0cHtfTy0WG033coREFmdwrkbdOSSQSF1iafBGInQB7GwwYc3pmWkTTMYjwOoiHBTFqlSsZbSKwzBKcN60G/bgn4vdEbg9Ww/3dLdb3SrlVQqYMdRUlEqeXhl0P1WwvFMlwGYGfWKZ/Y+3AfaW1Tvj9r2llOdT+Q0ZGTlQXDcc8Q45mBqWnDUX+fOJNh8XiSF7PvcrhLCQtlqfPYc1lTvfIdgb3AD79cjFtN3iup0m15FWB/hkK/UPy4AP/UV4E6e8V7AwJiLQtQtUpwT4jDKEY6MveZEurEju+7TwocUTajYAKgGGcJ6tz28ZnYqdVn+zXqZPg4ORu1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqSv5upnBHfrIMKWFCoWxPoIIXnra5crEdhhW/W4OXo=;
 b=YxSpQv0kmfpIsTDO7daR//SFooa5h621d65q+yXLRb8UxoVA9RITFn5NuhtIx7qNIa2Qb2PvgP0jJC+OH6LTjy8wlsLm73s5vrN56cZotciFSvRTGKZn8Nhl1aOylycvsHJR8Fc0/2TlAdN0jlPDJ4JIfVi0O4pvTboLQ2TWSq6i6YD18lppsXx1f9kFlI1sl6eGRftv+31PZuxXoV5+CdUoIvjyAOfN43w0lmEFPe1GH9zYGP+RLiT/WNj5LhM1GRN7U4R3lweslksGtCOEwBF4/B4bADO4Ql8hkjhgqN7UrmW/tmaCBRswPfZsX8CQAD29HjvaJNnsF5OBuHVfqA==
Received: from BN0PR04CA0123.namprd04.prod.outlook.com (2603:10b6:408:ed::8)
 by BYAPR12MB3240.namprd12.prod.outlook.com (2603:10b6:a03:136::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Wed, 16 Feb
 2022 09:23:08 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::e8) by BN0PR04CA0123.outlook.office365.com
 (2603:10b6:408:ed::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Wed, 16 Feb 2022 09:23:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Wed, 16 Feb 2022 09:23:07 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 16 Feb
 2022 09:23:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Wed, 16 Feb 2022
 01:23:05 -0800
Received: from mkumard.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Wed, 16 Feb 2022 01:23:02 -0800
From:   Mohan Kumar <mkumard@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <tiwai@suse.com>,
        <jonathanh@nvidia.com>, <spujar@nvidia.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mohan Kumar <mkumard@nvidia.com>
Subject: [PATCH v3 5/6] dt-bindings: Document Tegra234 HDA support
Date:   Wed, 16 Feb 2022 14:52:39 +0530
Message-ID: <20220216092240.26464-6-mkumard@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220216092240.26464-1-mkumard@nvidia.com>
References: <20220216092240.26464-1-mkumard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f83bba7-a689-4dad-c3e6-08d9f12df1a8
X-MS-TrafficTypeDiagnostic: BYAPR12MB3240:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB32401ADB0C225C7967BD6D7EC1359@BYAPR12MB3240.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hJX/OPhcZfO6Cty5nSPhNUIqk4w3HY/2ME71hfdYdH2ULk6TnR3X1IIHGCbBn4hrZZ/mebGVUECEMvtWNAyY+xj0/TeU0ZfAO25WcjtjsE9uBzFGWswA268IwGdGq9ww/jen/jod7Gh6D3cKt6e1CkkDSSHTgR6j8IGpcraZy0iD7StUrRRGeRA2icXQjNJ5lSMBdSUtZ8T3uqcxfr6XWsc0sb10aAMWBehAWR4DWu8uEGYRhGgrLZVUcoijn/KpGgTk70D+JSItSM47O6lZcTSRKNPQ7XyVFcpDqMUmWrsAjphXbqyorpnZXqpLluYsREWlGT0tJzT+h0v8O+oOjjGMowTz3Ous66bG89pcotWHJbCJDNlrZ6VH5zl9pJgjoW/oNT9im85NyZ2yK7l2pt1cW4as7hr4p1I9F5+MvFQNfpNux9fMdYFLZoQX9grpc3y0d+rrgKCl0tLV3uNGWVkQtV8DQhXMTu6KmlHi2g5moBIgm3VBNmmrY2cfPv4cETgHX9UKcp37JitRj9sVFVzBd9QMRKOf9F6VLTkDzpILTx+VMMd1s6EgN+NzdGeJ/DINzDY8QoieoT13JH+F7TXZEZRw42/gPOK1dmn/3J619pGUAvtcp37ydTeXMGggqVDIZvJ1LNpSHTcojFV8tIaBA/zh5Lw/njGoIvBiycUFUKJVjmjbzIFpTusIoqn3N5BqrJ09E27tLMgPLjUZ0n2wKPshZ28NNOPkdAqQCJ0=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(5660300002)(36756003)(8936002)(86362001)(107886003)(508600001)(6666004)(70206006)(70586007)(8676002)(110136005)(54906003)(316002)(4326008)(6636002)(36860700001)(426003)(7696005)(2906002)(81166007)(356005)(1076003)(26005)(40460700003)(186003)(82310400004)(47076005)(336012)(2616005)(83380400001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 09:23:07.8108
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f83bba7-a689-4dad-c3e6-08d9f12df1a8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3240
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
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

