Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F4B525CE3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 10:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378059AbiEMIJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357659AbiEMIIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:08:53 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2068.outbound.protection.outlook.com [40.107.102.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541281BADD0;
        Fri, 13 May 2022 01:08:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVHj/mEeANi04bUgi1hHJ0WIkszciRKQkH56XY4901XzfZqPNsHQlYuW6vY9cMHlwRLzccFBcHQUbuZroBLtRfiIojHzQrZ7AqWNbCdlIfqIvGCqLi8RKx+MDcclh9VFTAUlVY0yuCxN1+EJM5RX+fdWwfO24cA+HSxL5lYhB2UO8UlhD9+PTC8LZk1lsUD1wJfPU7FcH221gInj3S8Y6hAVrp/MAO5wsrHFxufN2BgaEZVoV1lr0rQFTs2nwf3wh8ayc3Qfzft7PpA4JjEDrWwAkjtsNOlRijjOApV9Ib+2mH/Fkd1O7Lf3MraqIgPkKlto1d48+aXdT9T4FgBBdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pjGvyDjR4qFN5KVF5yKSGNvT4NQ0lLmi8mbydz3ErM=;
 b=MaILGhBmzLMMWUUW4fibHqno2TjOpoc3EGeEd8F7q/J7apGxqRL1wf+5XPUUHgzgD2xP+7TxbBCU+KzfPlAMUG6n+aDyUjOW27K3uoN3xBv5FQzBGxEpzOmEaveKYPIvq+7t0/Irm/B7Yeq+Vq+8Z8rXvI8+Hzidepc47ejkVGGFCVTnh44+NMwwQ+1BP/aAzM/ILJmX3+pBGJJKC7/NbbIXYhgo14LdMyBEF4yrfqAtcjzeWSzGk7jXXVQIUw0a14rVw1SGf6RAWKQ3QMosyVeEBhiDMAlRhTJ5vt1o6TFyQuH/62wGEDrOoj8Qayk9tXWM7U7gl7bCZA8JE0JQLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pjGvyDjR4qFN5KVF5yKSGNvT4NQ0lLmi8mbydz3ErM=;
 b=TY2e90MvErN/HgBVXWYg+P3DVgX1c4tcRry89H6F8YspiQAjNVWZl8erwJMQbr0ZZ8e9b9KSOT4+tzJqRgBduzDHy0eMqWne5a3StvhKAH0Qyy4n8FNEyjRkBN/8blZbcSVXy1as0wh4bb1QroXunj1QvyUAQaqdKOQRhTNTV0M20LW7l+9hmMu12LsmOYvcBxzfrz3paCrFdvecU7jNzVHFdDnzf+LZy+7qG6DA++/vXc0LPwErfbK49NFTz7Q1sSQYNcnGChztLDr2GQYvIjFM3teZpV/5fqBLj34DncZtd+jy+yV4deRjcu5UbRDa3QoO6XW9d+1dd7WtJS7KnQ==
Received: from BN9PR03CA0494.namprd03.prod.outlook.com (2603:10b6:408:130::19)
 by MW3PR12MB4571.namprd12.prod.outlook.com (2603:10b6:303:5c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Fri, 13 May
 2022 08:08:49 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::1a) by BN9PR03CA0494.outlook.office365.com
 (2603:10b6:408:130::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Fri, 13 May 2022 08:08:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Fri, 13 May 2022 08:08:49 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 13 May
 2022 08:08:47 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 13 May
 2022 01:08:47 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Fri, 13 May 2022 01:08:43 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <broonie@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <ashishsingha@nvidia.com>,
        <robh+dt@kernel.org>
CC:     <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Krishna Yarlagadda" <kyarlagadda@nvidia.com>
Subject: [Patch V2 0/3] spi: tegra quad: Add Tegra Grace features
Date:   Fri, 13 May 2022 13:38:25 +0530
Message-ID: <20220513080828.22079-1-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c46ac1c9-857c-424d-29d5-08da34b7cf95
X-MS-TrafficTypeDiagnostic: MW3PR12MB4571:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB457123DED68A4B3503E2334EC3CA9@MW3PR12MB4571.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sy2xrbY+zTvj+vw+hOF1iBkD3GgeCxGhbzjJRFbYfuPB8Hz64WJeklgrDmpyNY4md0hVrzQeuHblqKSPq+kLgT/nMPOfvib+QAUxYuMua0IuCbt7Vrge8Fct+Ay3y5ecwa8ee2GoiI7lwgAdPPVMg91U2efOUTcO7G/+wvYY9F4DRZkfOedoKZmiRupNMrXInRHqAn+j4CjC2F5YWqdcUK9OU+aasmTKQcqhTpG8oQKcKyy8t3+a0142csN1l25Ttq1cxr/rKsUi+bYzuwlp/6RKagJhVaSHFbDMnY7RAe1RL9cYKrqnoZX7GYxciCQkc37OEw/e/vJcfRPg1Vholw7GkmIhEEyrYDA38gXyfFYKbQCM2hnku6aH/ZtSsiqtFOC8OdsPSdv5Tio6W5hqwrq3QUDKw69m4KKCYSKhYY1mkKkqqsUGPvYpiqToAEOXND5jTxIHlWulnTYfxRDfElUSPUQVwMV1Bg4eeRtEI7cQhYD6WweH5MQG+Fu2F4E/DeyJ/6jsQLg07kerZRmHMFZIjajP/7VQrJmqxHKnBMpCXeJCLts+Jc3V21AWW3XCjvxNlzwIvPmbcyy2xscHeEiTPm3wQsS5xe/e25feHryZAz4SnBOSdmp/iFXTOu5o9gVt0obdbrJ98WJstQh/6G1V1Gz5sBvTEFHHGkrJYuycOsXax0x4ZDZQtClPgC4v/PzjLZV4KyI9dcWjN3TeDA==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(6666004)(26005)(2616005)(7696005)(5660300002)(2906002)(4744005)(8936002)(36756003)(82310400005)(86362001)(70586007)(508600001)(356005)(70206006)(54906003)(336012)(81166007)(4326008)(316002)(110136005)(8676002)(40460700003)(36860700001)(83380400001)(1076003)(107886003)(186003)(47076005)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 08:08:49.0946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c46ac1c9-857c-424d-29d5-08da34b7cf95
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4571
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add multiple chip select lines supported on Tegra 241

Changes in v2:
Split Wait polling changes to be handled later
Change chip name to convention followed (Grace to 241)
Add tegra qspi peripherals yaml file

Krishna Yarlagadda (3):
  spi: tegra210-quad: Multi-cs support
  spi: dt-bindings: split peripheral prods
  spi: dt-bindings: Add compatible for Tegra241 QSPI

 ...nvidia,tegra210-quad-peripheral-props.yaml | 45 +++++++++++++++++++
 .../bindings/spi/nvidia,tegra210-quad.yaml    | 33 +-------------
 .../bindings/spi/spi-peripheral-props.yaml    |  1 +
 drivers/spi/spi-tegra210-quad.c               | 33 +++++++++++++-
 4 files changed, 78 insertions(+), 34 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/nvidia,tegra210-quad-peripheral-props.yaml

-- 
2.17.1

