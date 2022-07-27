Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD6358288F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 16:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbiG0O0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 10:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233565AbiG0O0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 10:26:44 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BD92BB3E;
        Wed, 27 Jul 2022 07:26:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVkIV5s+3S9Ea0Urhym49a+Z7vFVdBfxa2G5Vy6IapW+tXcgxOmvVJdKX07r3J21Uxe88NaLjaVlzDYJCMh1fmFQounXm2gIfJUoIdlcLj4Nf5b/r9u8WMhYpFjoTJwy6jGzHuWRk/zEc/OY3ylpeC1pHuVWFJIpYmwW5B9uOWsboA+bVC43P+V0zVQy1FdxV5mfGFq51VFBiZMD3uDjlzbpLfnh80DmLHgSfOz1qdxWzCVymuSF/1aMjhQ4Fa2fsJ9g9jq3lIxQ5m8EbNSKnlDkXKBCvaSjCuMopKGAofQxWxs1nyqJtDZRP2kJkx+yiV0PmevAkoCWlJJGOek5cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4F/LlD/JxutDEty4/El9J284e61PGpdKkuG2b6dWt0=;
 b=ZEMv0ZUASmsi5Z0G+o9UGc+O+a5J/f84oGdFI6nOKzUZ6KTtghBXZZqdMMTTrE9x7C6EJ5s5H+L9F8OpWFQLfy52stzjHprv12+XRxOkCA38Jc8vddelk6WjuCPa9HbkZuSjxo1MLiYMGT523KcMDr6WwrBrIMgvgACWPdPxLm2KN45rIn3OdArRBO/tRwNsVv+FHRakPCNIlIYli1rWmAhA8zf+lPuGL3nLRmA8bNZ3//pkVlRjh7Hm5lNZovnx3sxLgDL4ZpZVM4KKFcFOGwCY276khk9uTL1mJv9XslRhzE5ttU7uZEG4km6+cgNEwSAC06WiMVdO24xPqtxa0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=renesas.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4F/LlD/JxutDEty4/El9J284e61PGpdKkuG2b6dWt0=;
 b=aXL/QeEelmga9o0sxFNT/RbFcstBgUhVyonJY7eHYN1O4ZTKYlxxvAQlShd17+YqHSkE13x40sdU2mtQips9tWPeHVnqqtbhWYI9Q5RJCPOTZepCaOq1jcC5Tqr1S7+BGDW59g0QQuUnG4QsSla5mZHTrxqiRnHu/U+oVLQB8tPfWHwx4n3o6Vg0gT3lVlnnL+/iTaWc7HaUeua3Q7SIgMz3RheD4M43tGmfRQo8z7LWjkqLidAMUThbRZv69zWt3dPB18XIjmfl2AMtdtRgQfN4d9cspe905h8S0Vx7XJY5oNygs9ghTZYoxyexnDYPCQIsT1FnlYnDwRR72BIRoA==
Received: from MW4PR03CA0042.namprd03.prod.outlook.com (2603:10b6:303:8e::17)
 by MN2PR12MB3661.namprd12.prod.outlook.com (2603:10b6:208:169::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Wed, 27 Jul
 2022 14:26:39 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::4c) by MW4PR03CA0042.outlook.office365.com
 (2603:10b6:303:8e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.10 via Frontend
 Transport; Wed, 27 Jul 2022 14:26:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5482.10 via Frontend Transport; Wed, 27 Jul 2022 14:26:39 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Wed, 27 Jul 2022 14:26:38 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.26; Wed, 27 Jul 2022 07:26:38 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Wed, 27 Jul 2022 07:26:35 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <kuninori.morimoto.gx@renesas.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 0/2] DT binding for sample format conversion
Date:   Wed, 27 Jul 2022 19:56:21 +0530
Message-ID: <1658931983-31647-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7f0f674-bfac-4c88-948d-08da6fdc04d8
X-MS-TrafficTypeDiagnostic: MN2PR12MB3661:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eI3K/awxtusKo46hV0/n3lEH1HhH4YdGEYEa6PqelFTXpp44V7ZUM2rmUev2w3k5tKSnjCn1jFjbmg+gZWFYupVAlQChVKG1YG4Gp45O3OTBxOM/i3hHjOk1EZ2irIqq9KsGjmy0rdU/lXM8YPvMYsApFpl74u3pLQUd1jAdlzHHI0hlCE3b4sKN8GOkhrr4aNqLnTSpaBVk8TVGv4SjzeS9Nr72cuWvv6jz4MT5Yp00vtTvhQwNVZCwnTsVSOu1LWcfRxNAQLXfVyfZKr82bef+2kR3Ijt9jgPrOlwheaXQfgs9nE7yNui5xnjibjo9Gj7l7+an+DK3OBpc3KgO6Er6kI1S6fJ4hPS7Ktyo2bIYk5+16qTFHUrAQFZYdBqDduFWqfsQEicrmiLm6RYunEm6hZmge7f3mvaFq7KYgsIaqOhkm29NVxjbhKH/JOVVmnWzmFPHm+JjVxh9Vbo7xSBwRQrnRPK9Zq9pQeEN6kLb8icUmgNB/o7MrHy0YMndqc099BPxNBBfWpyzzIonE9I3oxG0YA63q/fTLNBDuR450QY+nJIfLYdRHp479DGSs76dF9fQqdGjW0kQXoUwX5cHH1f72C/iOYI1r//DpuMpcJzv+Wr/yV5RnMnHTafgZ0lmrzunE1eFiTrKSyEksNVXror3WORqh0d8PnQA/BdFUMQqOVCIX7bcwSAtaHLQ6Kc7qqDSCFohPi7AesfFyPxw4NH8KKFO/RgloxfabNpCKEVGpXITB1k1UeMNigssRVEHNTpRkFJwrMmbz54tX4AE26l9pLROewTfRDyVDunvmOTrFNWTP5Do3Q8/BUz9xkfSn/BTRHomtdlZMPaCaA==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(39860400002)(396003)(346002)(46966006)(40470700004)(36840700001)(5660300002)(47076005)(478600001)(86362001)(186003)(2616005)(4744005)(40460700003)(426003)(40480700001)(8936002)(36860700001)(54906003)(7416002)(36756003)(110136005)(107886003)(336012)(81166007)(82740400003)(70206006)(26005)(356005)(70586007)(316002)(2906002)(41300700001)(7696005)(4326008)(6666004)(82310400005)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 14:26:39.0043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f0f674-bfac-4c88-948d-08da6fdc04d8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3661
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT binding properties are available to fixup rate and channel
parameters of a DAI. This series extends this to sample format
conversion as well. With this now DAI PCM parameters (channels,
sample rate and sample format) can be fixed up as necessary
in an audio path.

Sameer Pujar (2):
  ASoC: dt-bindings: Add sample format conversion
  ASoC: simple-card-utils: Fixup DAI sample format

 .../devicetree/bindings/sound/audio-graph-port.yaml | 21 +++++++++++++++++++++
 .../devicetree/bindings/sound/audio-graph.yaml      | 11 +++++++++++
 .../devicetree/bindings/sound/simple-card.yaml      | 15 +++++++++++++++
 include/sound/simple_card_utils.h                   |  1 +
 sound/soc/generic/simple-card-utils.c               | 12 ++++++++++++
 5 files changed, 60 insertions(+)

-- 
2.7.4

