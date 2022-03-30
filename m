Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18274EC6BA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 16:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346958AbiC3Ok3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 10:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242262AbiC3Ok0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:40:26 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46538527DD;
        Wed, 30 Mar 2022 07:38:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3lI8oqKifLPc9XTG2RS4u8V7LabeRYH376aDYiirmb1dH6fwxD6GDkPtE6wCl/OB51x74YNQdDtAG5YJnxI8+b/U6UA1O8zavCc+DnucGeIhDSXNc+70xFIqDTvTcnXW2LGiEdV3lXLb0VC4XdfyuzcNJxPsh5rEP7aTHcZVbFcOyt0T9BwX82mRmoSSFU5LZTUs8WaEmicrLsKOHaCYGw4KY8KvHl9yAF1IveHMnAjV+Bs8Bk/irgTfHqZL2Ve1yxB3hop94hUfWUDRketngaSsH+OGc1wON/2Gytf36DeT1rHQBittyyUs5+zoAhrkzp337C873h8SgxzhNdY/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVO/6RmMb+sYeGl9gSQOgbGoNJ7lXY3TSXetXDMHlYI=;
 b=YeFhoB2hsVBqmt6juq0U/aRkW1BLzZfqf2wVGjHQ+fCX0AoOSQOb7tlLmrMdX2SZp/v5Ee4ctFSgOwgrDSuuNG+cxnfKGXrXfKGkQwv9WEvSfbYrAVEzYv2bnnmdxMc3RB27u5sZscTf04gx0wRUAuyjAu72c9+WTI9zdEiwTEvzlIPasdP4khUZgzPph4NqtfrjGGXYAgSF7eV5Ps8CKml1PgRa4rV4VyFqRZvMP9DclEQqRZ6j8ti2Pml9DSYnFCy5JY6HahVnOp7Q3dtquw4mjktUIwWUFHvFHePEWiQYiBryNsoQIxXnkNkbXZNEfJRGmBdvP7L8nB+ePJOaEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVO/6RmMb+sYeGl9gSQOgbGoNJ7lXY3TSXetXDMHlYI=;
 b=J1gR1+2j+FRSRIo8p1W/zlQLSKv5z/m+VxTzh81I9QGkW3ll812PNGowAXRgLOkmMrGvkLfMp2tj3pjBwDgSQPIwwOP78xmaA0BzIXBHaaD5am5XmsCNoPWEm05gj1kps1tVBHVb01jDv1fawOLcUg1yW3TRZHzuEmPt9F3RALavpfdy6EqTtJkynGMSObj4w+Keo2IN3VDfekfVBR2Xi/7GggDC1p1sWC3yDskvVE9dU+o7MZAoKENAY6wxXA4n2MCa8ybtu2j63gaEv7AqWGpoyh9RSiI/ikLHBLQ2Ithm+/TEyKHmS6Xc1sCNMQQxvYm3k5gzdLAQBC/jG5OFCg==
Received: from MW4PR04CA0103.namprd04.prod.outlook.com (2603:10b6:303:83::18)
 by CH2PR12MB4922.namprd12.prod.outlook.com (2603:10b6:610:65::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Wed, 30 Mar
 2022 14:38:38 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::22) by MW4PR04CA0103.outlook.office365.com
 (2603:10b6:303:83::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18 via Frontend
 Transport; Wed, 30 Mar 2022 14:38:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5123.19 via Frontend Transport; Wed, 30 Mar 2022 14:38:38 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 30 Mar
 2022 14:38:37 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 30 Mar
 2022 07:38:37 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Wed, 30 Mar 2022 07:38:33 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <bbasu@nvidia.com>,
        <sumitg@nvidia.com>
Subject: [Patch v2 0/4] Tegra234 cpufreq driver support 
Date:   Wed, 30 Mar 2022 20:08:15 +0530
Message-ID: <20220330143819.27476-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f933a59-7b54-44f1-fd41-08da125afa62
X-MS-TrafficTypeDiagnostic: CH2PR12MB4922:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB49222F5ED7BB6A5DE4E74276B91F9@CH2PR12MB4922.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 81YdkjXnmqBO7TdYfS0AnfT+zlqLFLb7b1sWNhkH8gPnASWbyJ7V3dJyD2lLtdUOisqYjodQGwduaQStpaUAkxc0I+gQc7qqYEJx+paEcSeRpwKz/I9SprmDPMWsJYyIXNHyDt1nyrGNCnyU4nFrECBsCmb+V8/3PF9t8AIgb4vr2b//7E8+yDPp75ECbDh8BFxh8+80n+IRXCFEbAIOueQOPptrep1LjImYBU4oVYOe+DL2KlWKu2mhwyHIFZ6ho9igHnDTiu+3Odsw9K+QqEvwbhBPAoBqCeDEc7J7H262Yf221t4RfLI4EL9h5ExvG8yipRhfsftWcG4UZT8IZWire2MAYyJ93Q1uloderWlEcUuRbFez7vOix3YEBQNGEoYPuXmrah7l6jHkn25P9/NNQ18gmAmxDKIt9/uvw2i0PHZy65ffhXInHcqZy2Yow5lTnNPmntZE0TqgajZIZJNVSZuvkUtv00KGCAndnLHsRjAkqG7Im6vMl46/xWytQSXR0jVyHBJ98QR14J7J+N8WMwNnbiI9fdrXAD57hFrAZcb9jRA5l1OcckLYYNpNQ4cTB/85rmRq0lMQPOrddgH/mO6LKGC3L2UMSZztShqRT+9pPKJhUbaHglfT+Wq1sJFXb3LE9Q+tn0d3Vs2MiapwmYMPE3h1hskLGzouR4uoNypVGffr0TFhaBCbPkckL2Dah037z0NB55rQa2d0h9zVQbjInaDxzgiYdJQ6mH8=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(8936002)(47076005)(356005)(921005)(508600001)(336012)(8676002)(426003)(4326008)(70586007)(81166007)(2906002)(36756003)(5660300002)(70206006)(7696005)(86362001)(40460700003)(107886003)(1076003)(316002)(36860700001)(186003)(6666004)(54906003)(82310400004)(4743002)(2616005)(26005)(110136005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 14:38:38.2400
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f933a59-7b54-44f1-fd41-08da125afa62
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4922
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds driver support for Tegra234 cpufreq.
Also, added soc data and ops to support multiple SoC's and variants
which have similar logic to {get|set} cpu frequency as Tegra194 in
the same driver.
From cpufreq point, main difference between Tegra194 and Tegra234 are:
 1) Tegra234 uses MMIO for frequency requests and not sysreg like T194.
 2) MPIDR affinity info in Tegra234 is different from Tegra194.
 3) Register bits of pllp_clk_count and core_clk_count are swapped.
So, added ops hooks for Tegra234.

---
v1 -> v2:
- added nvidia,tegra-ccplex-cluster.yaml binding doc 
- changed compatible check to 'soc->actmon_cntr_base' field of soc data

Sumit Gupta (4):
  cpufreq: tegra194: add soc data to support multiple soc
  dt-bindings: arm: tegra: Add bindins for nvidia,tegra-ccplex-cluster
  arm64: tegra: add node for tegra234 cpufreq
  cpufreq: tegra194: Add support for Tegra234

 .../tegra/nvidia,tegra-ccplex-cluster.yaml    |  52 ++++
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      |   7 +
 drivers/cpufreq/tegra194-cpufreq.c            | 246 +++++++++++++++---
 3 files changed, 268 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml

-- 
2.17.1

