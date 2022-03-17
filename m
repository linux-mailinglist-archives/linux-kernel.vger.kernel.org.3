Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CE14DBC32
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 02:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357436AbiCQBVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 21:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240599AbiCQBVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 21:21:40 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579B51DA50;
        Wed, 16 Mar 2022 18:20:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzKOI+8mMgMfbQWG+WhwfOlGYVOh6SLm3gfBokWJVR9aPhmlaLrZ/koc2rfGY7MnRODYKC3i88bzwOg+pswuebXXxZdJzerBfxaOk4nfdk/yt4tnsJnOoNWy1n4leDA4YdJbVhnApkezItwst3usfd5jc2CEllVbQH6vSlddyYBsDGOyweVqjmhoYM85ZKsye8E6GwfxXZgMU75UXqKNHzECXAyoip7oKdon8GgYVwEUL9qRT/K6o4OoB3pQxjuG9p+jCx+sHEXB5yULygBQl5nFhHqai9zIPL0vQJ9enSRSaPTAuptVYIr2gbOGHWm5wpQiq16B2us+GoYT8IYj1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKd7eAfN1fu+XWvyKxcZQ6MawbQKdqO1DYy+bm9pbXs=;
 b=SVIr8S+DFLQhH+1YN32J+aWuYa51hcaP8L3UnwLHXzQ3ykyW9bBJKEgKBoKuhJjPgJ+w6hVOUvijh1j/FzquXcEsB8S5ztVkEATOYMfAyj7MkXLKFUKfXkTQ5JtoJjEMNlULvs0ED94Mz+O5hluPdKezSpJPng4tYGyLWOHFISSdk8ODb9dAPST+NtQowLcSdh/fAg+xowxm/L/AcU1W2yqfViqDaRGFlfaixSaHV6eZkCwdeCqpEArYLT7KdvMw4GG5e8XZN0+tTnnDxcHtjJgggYElcIkUgqpJR239DdQVW13qu8CqOjmxhhuomlz/qJIe9KW1g3Ld8dwiHJTEzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKd7eAfN1fu+XWvyKxcZQ6MawbQKdqO1DYy+bm9pbXs=;
 b=AsDyLlbINjqvUR2ob9XP/qhUaofPB3g1kSTUxmbqFXwg9D7VYMNu+j6gawaiLOCKjkIAf8wlyTRL6WwINsvFcLpj0wB5Dp8xR7XNsO2qqzsQyYiOuT6x+884+W9y28miOPiQYNGt1W39l3HQDscS5RvV/z9DSZnhdkopdlrJIhbV2CeFdhT9YK01hwzDs8G3/UjkK98Qa8FFbNYVFd4fYj3azR5Hg83+F9I1PzpuM1QM9IrOu/7SNlOzSAF+ahwhQ6ROpQQMh4lErgODaLMqTTifWJgZoYGtOA1OlgYc/toTsVBKxY32UQ/kPLjMUD7HX0MuZ1NK4es0Hc9jwoRRhQ==
Received: from DM6PR03CA0007.namprd03.prod.outlook.com (2603:10b6:5:40::20) by
 BYAPR12MB3159.namprd12.prod.outlook.com (2603:10b6:a03:134::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Thu, 17 Mar
 2022 01:20:18 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::75) by DM6PR03CA0007.outlook.office365.com
 (2603:10b6:5:40::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25 via Frontend
 Transport; Thu, 17 Mar 2022 01:20:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5081.14 via Frontend Transport; Thu, 17 Mar 2022 01:20:17 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 17 Mar
 2022 01:20:17 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 16 Mar
 2022 18:20:16 -0700
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Wed, 16 Mar 2022 18:20:12 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <broonie@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <ashishsingha@nvidia.com>
CC:     <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Krishna Yarlagadda" <kyarlagadda@nvidia.com>
Subject: [PATCH 0/3] spi: tegra quad: Add Tegra Grace features
Date:   Thu, 17 Mar 2022 06:50:03 +0530
Message-ID: <20220317012006.15080-1-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fdb9412-d891-4ee1-044a-08da07b44c31
X-MS-TrafficTypeDiagnostic: BYAPR12MB3159:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB31594BA40A69A979FD6E07E2C3129@BYAPR12MB3159.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3WrT6frW933uOQESZjB14tTVJKmO2VRnj0ySQa4SRls6OBRvO0WGbUotzgR6oRYY/EwhcuBvG1BredjHxogFQ02ZkHeDDoS5QGPTbAWrvp4nxmo5DSb9VOEizF5W5xRFjDSE7AIVNxO6w/rv2OOP0b/t6KHMQeFNlvt3KlL55n7R37munopN1wV5cSyGAGHWMEUBsHb6tIj5ifS3yfGWrXGHt8675kNNlxSv9I9XqMkerYxYJdp4u+hs68UqHiSCINYAUz4BEHWFpzesLBhKW17byyI3pfhxpMUcH7b+P1KUOYxFXX6sO6BdHj+JKFJeLWycJOeGKklOkgzufmX7OmbX9JUhC7A7dKvIlETFwvuq6lRtGwk85Lp8m+7shp0a9KhnO903Q9EVAsMBHvI42dY3PAmBlVn8Jul6xiBIur07YkeQF4o3oYAIead6TISsMI5uc3rChYmZ1uOJht7fc6JfR/EL6EVbjB2G4YIB0M41ZaIC3sio0IwKV71cE9T1tmEnLvN9cF2jWUGjwDwBKFT4bKar37bMEtuobgBbwxGbnTNVRQ/haztbC+TG+smzaaxJarGl4mP2K4nR3lpU4O2oG5eDl+VBooH4s0IX13CeeIWUnSrSW14LCYBanGHDUvvm/09f0SDHef1EzWw8uBGU/fXR0zVNJabvGWU75wE7gK9cvx6Twgh0qSO2fw+8273QefLjzjbRBGSjXlPMlw==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(6636002)(316002)(54906003)(110136005)(2906002)(70206006)(70586007)(82310400004)(36756003)(508600001)(36860700001)(4744005)(8936002)(5660300002)(40460700003)(8676002)(4326008)(356005)(81166007)(186003)(86362001)(1076003)(26005)(426003)(47076005)(6666004)(2616005)(7696005)(336012)(83380400001)(107886003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 01:20:17.8885
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fdb9412-d891-4ee1-044a-08da07b44c31
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3159
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add multiple chip selects and hardware wait state polling supported
by Tegra Grace.

Krishna Yarlagadda (3):
  spi: tegra210-quad: Multi-cs support
  spi: tegra210-quad: Add wait polling support
  spi: dt-bindings: Add wait state polling flag

 .../bindings/spi/nvidia,tegra210-quad.yaml    |  6 ++
 drivers/spi/spi-tegra210-quad.c               | 64 ++++++++++++++++++-
 2 files changed, 68 insertions(+), 2 deletions(-)

-- 
2.17.1

