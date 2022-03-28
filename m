Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A854E8DE7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 08:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238342AbiC1GRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 02:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238337AbiC1GRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 02:17:16 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC14E25C41;
        Sun, 27 Mar 2022 23:15:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8DqTountFIyK14xZNYyu+pm7XnWYROYqta91GYx9lTdcs1UBEaxfqjiHGFFBcMSAscs3YmZASjqsVbmMiIByo9FeA79VQ99kcY9TRBe4UUx/m8ynsVUXD8yddX3A1+7eoQV+lo3bM4nnFXHJyGa73S4FzK98Ml1SY/D2hRfQ/3oSIii0BC2FaeSuieagMNBHrYw6BCyKROWZEPp3DOvL8c/PppJVSin3JEtbGrdve+a/s8X0EqmUVnOmnEIARVNAInulwXYH3Qb2DW2ir7NNSWThFk1TJi+Y6s/jqhTE0ZdwpXWqCYOngsIf47KBtW4xhcCY3caLc3Y2mfNNIX0Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZT4XT3JMcW1sON4CueFXyQLqOqqsrrGrWnG/f4sJKM=;
 b=VTiHGXWF917z+31RklWNepjSiicC+cequAw2HUL6IGWP+AGEmo1KfBBT7zTx0T7xOhi/PkanaEUMo5KPDMUz3VCXu/Y6Y2rAkUrqEysVyyOM6K6b/7QnFLOQ7Wzl7acs61fETr3QMbgx8MDoUaZhRxGxcgV454NOznDF359E24OaqyEx6rTslxOYtH0Lx/bYW+5Yt+ySYzl4xAvV0n06DlI+xb7L+vy2hLIBxb/2w2Ddta472Bs3R4l/HjLMp+kWL2Jw6UHMZPFEil6x+Zh0ZtP0rzq158zvt/YhL+91+b3iN3GaOtPwurA0SU/hJ1LJWDk+1AdLXUZVROLbUen6qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZT4XT3JMcW1sON4CueFXyQLqOqqsrrGrWnG/f4sJKM=;
 b=e4eE/kUlitFruq+IKtxc9uGgt8G9+ad36EyJkv9dd0ZhwqtRIB4rKLYKswCz5MQwD0Idps0Td5fvyFphzuv8APFQK3BB+Wt7JZHVmK36Wz3hUP21l+J7Ddk78a3JyRdIegB0KL8wzn1m+GvdqyxTTAjQ/spmOAQklvtNGIOwvGNLs8GSZ5WAG8rg4gjPPgYmY7ytlmUV1BmTasKmt1k3FDrXtlRfydvZ/0pe3zwTp2eO9ETDiHMZApPmWWUdVVW1KMv+hT2Qd8HosJ5M7/cBAHu9psvWCGwFFe9Rws0iNQM+RVMOn2x0klJyMUYxQNWOYrj0lVE/o7CY8vD+Pf5fSA==
Received: from BN9PR03CA0379.namprd03.prod.outlook.com (2603:10b6:408:f7::24)
 by SN6PR12MB2749.namprd12.prod.outlook.com (2603:10b6:805:6d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.21; Mon, 28 Mar
 2022 06:15:34 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::a3) by BN9PR03CA0379.outlook.office365.com
 (2603:10b6:408:f7::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Mon, 28 Mar 2022 06:15:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5102.17 via Frontend Transport; Mon, 28 Mar 2022 06:15:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 28 Mar
 2022 06:15:33 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Sun, 27 Mar
 2022 23:15:33 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Sun, 27 Mar
 2022 23:15:28 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <peter.ujfalusi@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>
CC:     <oder_chiou@realtek.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [RFC PATCH v2 0/6] Flexible codec clock configuration
Date:   Mon, 28 Mar 2022 11:44:04 +0530
Message-ID: <1648448050-15237-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e46d8270-6368-444a-e8d7-08da10825ea8
X-MS-TrafficTypeDiagnostic: SN6PR12MB2749:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB27499513D3EBDBD5BA8B70BCA71D9@SN6PR12MB2749.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DlyU97Kx1awe/v9YEXAauZaREGPYk0yC0uWH1bLKL/JoTCyGVcFPeM1M/+OG8xiP/JF8HES8ASDnYHXZWN+ngkFyrsch1cbZ7595gJvvGozKjszcxnCN4PIFyw2auE8vKF/EPPAFfRZxrSCoIZsT6MTiG+joRkDsIptpW7/GiEl1QdXBF52qJ6LL1ile++/2bVO4VfRPlq85tJ2XOCK8JVrehxmpdr9+p1EwbGk6J0uo60IEMJYT5K25TafxZI8ETMTqu7Tgc6H1M95DkBSSQTYXfkm79v0DZHgUstSEvfOZC2cNaKvK0fKtGJodDlr/Yu1W1BChdr7bNU2/F+orDYC27hl1iLZ919rC8t/J4x3Nzkvrt3EEBmualV6G6Da/LOpIxJKDlQao1GH4uZ9k2D6SK/rSYVaUR14eDzqvv98TuZmsHxEHLpO5HGHJr8TEsw5+k9gMhOOcWg32Glprorkw4DXVHlBZ7I2rvQ6WbpESQv7jIHzWHqj7oXXfysCBNpTc0Pc2THI1HisBzOf+LEfq39HD6BlizRGTDIRxzVpurM03cuqfqVe8mlyBU7kX4GCKRgblqgBP9WjEVWZJkxHrLZx4ncH/CtAdWH55SDljS23n0LasZJWzTgWlD2o4kofbV3BlM8+rXrl0BH6W4NPnQLr0jXw+hOvulkiXlkQ/ygNCUpgIpFeV80cY6h78A2rcg0JEu843OubXoKraaQlU7NEPyWb1dcyRZuVhTmbORqmKzT5DNCrj5/ZBFsB61JdsoolvK0oC5nMcV3FaRaoC1jnzrm+nhSHylk+bqvs=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(8936002)(508600001)(2906002)(47076005)(82310400004)(107886003)(2616005)(966005)(26005)(7696005)(336012)(83380400001)(426003)(86362001)(186003)(40460700003)(70586007)(6666004)(5660300002)(356005)(4326008)(81166007)(54906003)(316002)(8676002)(36860700001)(110136005)(36756003)(7416002)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 06:15:34.4548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e46d8270-6368-444a-e8d7-08da10825ea8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2749
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Typically the codec drivers require setting up of Sysclk. Sometimes
presence of internal PLL can provide more options of Sysclk configuration.
Presently ASoC provides callbacks set_sysclk() and set_pll() in such
cases. However it comes with following limitations considering generic
machine drivers (simple-card or audio-graph-card):

 1. The Sysclk source needs to be passed to set_sysclk() callback.
    Presently simple-card or audio-graph-card card rely on default
    source value (which is 0). If any other source needs to be used,
    it is currently not possible.

 2. The same would be true for codec PLL configuration as well, though
    simple-card or audio-graph-card don't have support yet for the PLL
    configuration.


Earlier attempt[0] to address above was not felt suitable. The suggestion
was to use standard clock based bindings instead.

This RFC series takes RT5659 as a reference and exposes clock relationships
via DT. **This is not in the final shape yet**, but I wanted to get some
valuable feedback to understand if the idea is right. If this appears fine,
this can be extended to other codecs (wherever necessary).

This does not completely remove the need of set_sysclk() callback because
the clock requirement (MCLK * fs) would come from the machine driver. But
machine driver need not worry about Sysclk source. It would be internally
managed by Codec via DT clock relationships.


[0] https://patchwork.kernel.org/project/alsa-devel/list/?series=438531&archive=both&state=*


Changelog:
==========

  v1 -> v2:
  ---------
    * New patch added to convert rt5659 binding doc to YAML format
    * New patch added to document audio-graph-port binding for rt5659
    * New patch added to document clock binding enhancement for rt5659

Sameer Pujar (6):
  ASoC: dt-bindings: Convert rt5659 bindings to YAML schema
  ASoC: dt-bindings: Add audio-graph-port bindings to rt5659
  ASoC: dt-bindings: Extend clock bindings of rt5659
  ASoC: soc-pcm: tweak DPCM BE hw_param() call order
  ASoC: rt5659: Expose internal clock relationships
  ASoC: tegra: Get clock rate in consumer mode

 .../devicetree/bindings/sound/realtek,rt5659.yaml  | 179 +++++++++++++++
 Documentation/devicetree/bindings/sound/rt5659.txt |  89 --------
 sound/soc/codecs/rt5659.c                          | 248 ++++++++++++++++++++-
 sound/soc/codecs/rt5659.h                          |   9 +
 sound/soc/soc-pcm.c                                |  60 ++++-
 sound/soc/tegra/tegra210_i2s.c                     |  25 ++-
 6 files changed, 503 insertions(+), 107 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/realtek,rt5659.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/rt5659.txt

-- 
2.7.4

