Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B9D4D04A3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 17:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244329AbiCGQ42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 11:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239265AbiCGQ40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 11:56:26 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AF82DD7C;
        Mon,  7 Mar 2022 08:55:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LebmS8wvAF5kqM4AQpgDOT3QlM2gE8Nyy5/JgEzgP/1dB6iHdpWAuta6PDjkEatyEswpeJmZhGIl0BZZyDXWDtJYxCiELUxkhjYjQUMFLkuVUwAVyn59a7tuTRXWH+tF8AXti95z3OHiMm9ZVzgN4zvUfT1eyt37PHl5cA6qrj2mHlEbS01ildmSGzqnrLXtlsVTqsG5ODIdNfttj+PMJdfjXzjkMhByxYhrYT/HYmerajjoZmPQyN/JkUQkXasUaKf+NHs7zWtz/SEO5YwVrzCOH1hBlhiNtFlxM22DfTMyNWno4ZMgETJ7weCbkKqWJD/sKBKV3ftEHz3aMwlkEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=slBoERK2AHmUJWNUzkEuC9d9KKE4C54N2Nm+Tze5zCY=;
 b=eG1ffvdBh60XaGERNdSsaiN5pykB+nKleyLZRartHmeXC5qsGyqw/aukiq8J/TEYnhp/G/X8VPtDIg3eTKp9wwasSvdpJhLN9eh2f42gnI28WYZPmMuoHVHN6inWkHSc2GGH4WZ0V4lrGwjRhzaVoQ8CgJuC6eKjVdg65A9iS+Ev2IPuuYqHDm97Yn5vNImzjT9bY2I6gpNYlBRlEPHP3sY23gftUqk5ByOh2Aqr1XnOg9NpAoCkMWFQNKYu4cH2LyrrOGpo4vP7Bz7UpwXSFXPEQqdkoEbkgL7YPmw7w1Hb/4HhV8XsOmCpmcOyYSLpLTXoPB5QJe39G0Drog7I8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slBoERK2AHmUJWNUzkEuC9d9KKE4C54N2Nm+Tze5zCY=;
 b=fiGZsiLSP1RWRKde9QAxAd7fA9kw0CK9Jf0MMAuC0F7MoxyDDechLSIsAlEbprkIO8yFLRAguLGxjBTTMpnzcc7RTpO3T+0tDRroAETxZtPK++FRDXdhbpPiE7F/5Iwu776s00As2WftUPhF8SEKLXVGEoOxPZUOO1zHuMlnLDWUxwkgAdmnIfVSnnEnQ8fzNkK4m62cvoT40OLrH9geiQ/EaTnblSQM1nS/8sW4P0aFQiMQ2bnpcnRdtauTFIgOV5Wy1D3yxIaLztTcOWAq5t3PcHkeTOK+VvVbUTE9VY/rrDhCuCpK7pNWBX39oS/tVWcMAHPLY/md8TtjYOphig==
Received: from DM6PR07CA0101.namprd07.prod.outlook.com (2603:10b6:5:337::34)
 by SN1PR12MB2574.namprd12.prod.outlook.com (2603:10b6:802:26::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13; Mon, 7 Mar
 2022 16:55:29 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::7a) by DM6PR07CA0101.outlook.office365.com
 (2603:10b6:5:337::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13 via Frontend
 Transport; Mon, 7 Mar 2022 16:55:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 16:55:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 7 Mar
 2022 16:55:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Mon, 7 Mar 2022
 08:55:27 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Mon, 7 Mar 2022 08:55:23 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <broonie@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <ashishsingha@nvidia.com>
CC:     <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <p.zabel@pengutronix.de>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH v3 0/3] Tegra QUAD SPI combined sequence mode
Date:   Mon, 7 Mar 2022 22:25:16 +0530
Message-ID: <20220307165519.38380-1-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccbe8083-fd94-480f-c140-08da005b48d2
X-MS-TrafficTypeDiagnostic: SN1PR12MB2574:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB25746A8E599637790AF2D58AC3089@SN1PR12MB2574.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0QcAtJae/geOmE2onvMNJ890/AR/vMa9tO5d6POXK+autfII2m/LqL2OqhQSEHHcgk8jfUj85LubepQUfTOdBnc72aW7PQZkgmMlXuI1kxX6kkKRLAcFuaKXedNo2d6LwCGous9m6F9jTR3L5PuLj0g0q42Wt6AXZfXnbxEMUObnVWrWK6tZqf0Xzy2DSWvBUdTToqRIBHEwmL2XmqE7R89WJZnWhSjoV+3KblkC0yqFnCbbF8cfJpig7Palie0ccGa0Wqd7jWwWDRAuM8FpkcRchnE4eqNBtSdh7r3Ab5vKaycJ+eqrZ+7XVridg9lTWjrKSvE9YHPKP91P3M4jpCOHvV2HpJ4NCT7/uRxRq0wAE/E2jiiOBS5SwtYm0VTh3tx+A6LZbsmOdA7szdxJzLS8E56lBJHlElL+SX3IhL9A0tLAXxdhv8TBnTLbFPlR4BubqbIRBUsDIYonuNpq7BMNNO3JwDJzPwZTjFlx9jy/U3oRhg5zMluZP2Q9T69V1vkhvOJiIvBa3JCsKJ3IMqzKwbpNgdPEMqryqzZEjXJ8CguwGPv2vkn2o3/1gHVHICCjvCINuoOt4+YNTOdnSliPVhjrbS/o5ttZIbJS2h00w19oSxzi6Cucso/d8RThqvzwQBmsejC1f89F3g/c/8VdSGy/BM8l5QinNsSBrbVwACF52P0WPiIW9RxDN5WRyYk51eQWSWsYVBuQXEML8w==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(70206006)(8936002)(81166007)(426003)(356005)(336012)(4744005)(70586007)(40460700003)(316002)(5660300002)(82310400004)(26005)(54906003)(508600001)(8676002)(4326008)(110136005)(86362001)(6636002)(186003)(1076003)(6666004)(36756003)(7696005)(36860700001)(47076005)(107886003)(83380400001)(2906002)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 16:55:28.8735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccbe8083-fd94-480f-c140-08da005b48d2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2574
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ACPI support for Tegra210 QUAD SPI driver
Support new Tegra194 feature, combined sequence mode.
Add Tegra234 bindings.

v3 changes:
- document runtime pm disabled in ACPI
- clear cmb register for non combined sequence
- fixes for errors reported by kernel test robot
- skip approved patches
v2 changes:
- use combined sequence mode as default
- remove property to switch transfer modes
- fix compilation warnings

Ashish Singhal (1):
  arm64: tegra: Add QSPI controllers on Tegra234

Krishna Yarlagadda (2):
  spi: tegra210-quad: add acpi support
  spi: tegra210-quad: combined sequence mode

 .../boot/dts/nvidia/tegra234-p3701-0000.dtsi  |  12 +
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      |  28 ++
 drivers/spi/spi-tegra210-quad.c               | 290 +++++++++++++++++-
 include/dt-bindings/clock/tegra234-clock.h    |   8 +
 include/dt-bindings/reset/tegra234-reset.h    |   2 +
 5 files changed, 324 insertions(+), 16 deletions(-)

-- 
2.17.1

