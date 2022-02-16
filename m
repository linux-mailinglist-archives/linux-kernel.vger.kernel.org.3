Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CBD4B83FD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 10:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbiBPJXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 04:23:05 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbiBPJXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 04:23:01 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4822B265;
        Wed, 16 Feb 2022 01:22:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FC+JFsBk9p+CiMtS5b2vUTCGjDmMXd+CQdCXnvf9hA6o9LZhsF60dofT5MCAqpM0EOCKNNXZasRQI6XMiYEWJHq2P0crHMx8uK6+dQuiao1kYwB4DqllqZg0qUPA0qeEsNxIGJtB7ujYUftLfNpOE1LejiCk4YFsiMudt9QxeTohiSTnO/lUX/bBKc0ZsCJO4COGMmSxxCH6Aku6hoDv0vbZ0W8gY9co5EmHmPh+nl9vty+gWHQlHkPgs7IZjU2Zlh3Fqxh7NE9pJ4Uzmv+glYHwzdDuF2S6m13TBXmkI32+R+tldJiY8Ubi0VRXdx/Sb8r5kX9h0bBj0vYSDJyrrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1iWgl0GueuFkkHuHWqW2ic+nN0HZdfaJYhTKmJONk4w=;
 b=an4B8JIvJCwGIB8OJIIyz4DYM1bDMi1K52ojWrlTCFbR9KDsnFSUQzLu6oPeFBSwzDPxjLb+9REPFw13FKsDAs6uJMlF16vw672zHe1izhv6twXDvuJT29qKYeSWqwfcInTmcyXPb5o276/ZL7ZcG3YL3YPXCw+vRpEu/a7AJOuRgA5VAEgxXmhBaeMf+BxaQPbuPJ0wWqgvWr/nhFeIxnCTVBlojJcjEFKpSWKAtOgRBpsthSq7WanCnU/GVSJrSvJtObSWRrmEmuoGnYVZmcSKa26cjHf8ycjjis0BNuDSWlqwy5w5GmLcPjhPRlEZZ/CKjyVT+RjqTLcKWas0GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1iWgl0GueuFkkHuHWqW2ic+nN0HZdfaJYhTKmJONk4w=;
 b=ay++BrNe1zjzVKipyWcQpxrFBjGCX23hbootPaYBYDiMr0icZJ2R2CE/HVEDcnGBrfjIxv+hxpssq/k5PcLQyUA0UntVK36f4Jsuzdh6d8324Iz4RIbfVgl3/BPx08Nb1pPQ+ntITxIdHJw4f3F3EVMimxrnda8dJldWtJYlpLL0xMWRHMtsiAcocbIqjZqpPMXACXWxZDzVJBnkq/sebGpOYxFYxeaqSwlCvrCkpJG6W1j+9X4KTfH7B+DrdTGNKLh3WyNhzXaLCna5l82danZB5/hv9BrGtd2pCGY/3mhJbVV7qwssPuRCkc07LG3cavTxXmZPTmwXhnW1LaKRpA==
Received: from BN9PR03CA0429.namprd03.prod.outlook.com (2603:10b6:408:113::14)
 by BN8PR12MB3411.namprd12.prod.outlook.com (2603:10b6:408:40::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 09:22:48 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::45) by BN9PR03CA0429.outlook.office365.com
 (2603:10b6:408:113::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Wed, 16 Feb 2022 09:22:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Wed, 16 Feb 2022 09:22:48 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 16 Feb
 2022 09:22:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Wed, 16 Feb 2022
 01:22:46 -0800
Received: from mkumard.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Wed, 16 Feb 2022 01:22:43 -0800
From:   Mohan Kumar <mkumard@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <tiwai@suse.com>,
        <jonathanh@nvidia.com>, <spujar@nvidia.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mohan Kumar <mkumard@nvidia.com>
Subject: [PATCH v3 0/6] Add Tegra234 HDA support
Date:   Wed, 16 Feb 2022 14:52:34 +0530
Message-ID: <20220216092240.26464-1-mkumard@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4bd5d897-b56f-4bc6-e844-08d9f12de5e9
X-MS-TrafficTypeDiagnostic: BN8PR12MB3411:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB341112F58FF2EA82CA5958C3C1359@BN8PR12MB3411.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ltVc7ryCeykOup0NPpx/Jo2prSW0FYNt9kCHPf21rdJ8J83B99Tw9VKxjeaXczechHWGLvb3rJu4fLXejnoFkYELK467We2imwVbBRVI9qhCrqHH3C51ban6itEJaHWIOG5kUCE1A+WIMfjpNuge806aKOlbCOLN10cxOMAhpiCIc9YUUqQkQ5KH6qgjqtP1lRaG4SagqVNajZttoqJiyLLpQXRubtxh1GKSdhDsI/4kX3dd0udHKdz8rv5iP2DVeRGf/A6lXya5ocE0P7fXpiO8yvZRu/OHf6Jk9ZnNnc4T+qoWcGZBicHOtj/wcUzdscm+2tDoVQX9a8uuYCuLQxvMVx98y0T1s1uNi2qeppz02f1PPK9Sx3KHWtoe/A4S1N69+lFT327N5VbljjkoSi4S+lvXcRQfPRRhQ/aLSLjLEty7hwtohCACjjBQ2ecwAEX6rcB8nr48dXvwfkQxt7+Glkdq8Mo9jOstE1FbcUt73LCTJuMTr2DM95+5TxK+rTjSaBd1uWnfbjV6/Fvcg6/VzBG2WSjieEMyYk93XgvcZ+AcmRCa+V4kXshDHC/jNjtr9Rn9wKvZjuuhExrap4/orqyEuPrrITYkeXhLGyUTuqHLWpiMcaREwdNrf7xArOrrtHBlzdsEwhDWMp9ltesk9esRiwHyfTM2dvKS4kU1cR7stS5dVfSxGl04KmnqBERfDk5Fgs43xRjKOKWs71LHD0JXK4TOq3/hUr2oHVs=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(8676002)(4326008)(54906003)(110136005)(316002)(6636002)(2906002)(47076005)(6666004)(7696005)(40460700003)(86362001)(70206006)(36860700001)(508600001)(70586007)(81166007)(5660300002)(356005)(36756003)(107886003)(83380400001)(1076003)(4744005)(2616005)(8936002)(26005)(186003)(426003)(336012)(82310400004)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 09:22:48.1051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd5d897-b56f-4bc6-e844-08d9f12de5e9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3411
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add the support for TEGRA234 HDA driver support
- Patch v3 removed conflict on top of linux-next tree

Mohan Kumar (6):
  ALSA: hda/tegra: Add Tegra234 hda driver support
  ALSA: hda/tegra: Hardcode GCAP ISS value on T234
  ALSA: hda/tegra: Update scratch reg. communication
  dt-bindings: Add HDA support for Tegra234
  dt-bindings: Document Tegra234 HDA support
  arm64: tegra: Add hda dts node for Tegra234

 .../bindings/sound/nvidia,tegra30-hda.yaml    |   3 +
 .../nvidia/tegra234-p3737-0000+p3701-0000.dts |   6 +
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      |  18 +++
 include/dt-bindings/clock/tegra234-clock.h    |   4 +
 include/dt-bindings/memory/tegra234-mc.h      |   6 +
 .../dt-bindings/power/tegra234-powergate.h    |   9 ++
 include/dt-bindings/reset/tegra234-reset.h    |   2 +
 sound/pci/hda/hda_tegra.c                     |  33 ++++-
 sound/pci/hda/patch_hdmi.c                    | 118 ++++++++++++++----
 9 files changed, 175 insertions(+), 24 deletions(-)
 create mode 100644 include/dt-bindings/power/tegra234-powergate.h

-- 
2.17.1

