Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597C54D4605
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 12:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241737AbiCJLni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 06:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241763AbiCJLne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 06:43:34 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D63145E30;
        Thu, 10 Mar 2022 03:42:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j27EDWcbQHPDQWfGt2ma4VRWvHvaAUOSFZqAT4wIbY78+x9YbiiHmwE4fYDK31uwVNtBgKFk/sHvNEVFvMi5HkaH5Zm6hMnAgP/1H83GeylHeibpj6pqkvQ/DA4G9gThg543x5WJytIxKwTly+VY3/NJM8SlDeFPJVU1qZMPxR2DNzP3R06WY1avUZPbPVWf/DI/FKGa2x90Dquc+0Pz47ouI+KhZRnG6J7nQkc27CJ4c4+Ob58xDi1CCcMJU4v3PobYcz40zb4XDRGSOv7sbU/NjoQKjlo30YemjkHvVvew6B//ON2NPGgOnsueSEPL8bSl5DRNvNArjSh6O1QeLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pn9ha6MI+JkQb6XPGZPSLKR/Hbe4jEnN3HXYYdnT+Wo=;
 b=Enc//0OWXdKuamzOiL+oOoc5oGaoCiSt0jYitA8QSqlMVJGWsb5tFeaEEJ7Drtlzr06VKb2qLPIlfY93QjacbRMMhoUAkpg9K0Yl9Jx3FJVbV07XZ5EGwIDPurW3sD+oqnMCNAHPfiqXaWOZY+4i6PVI5O7K8WD5lDAaqqmUFIXAieJWPR32R0kYonSRtulCTO5fVHyU9Auoel3ApKUFJl+jV6kIVSYgOvLdUcqn3BeAjcF4gTMxOpIAPAylgeMQOb64xf5qR1dWCiAqIw+pYfEyJGAuA/m4G5LdUxqCnJDXVaxCsogj2RiyA4Nio6YU3MmhBzZ7fl1qJSuiuKnX2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pn9ha6MI+JkQb6XPGZPSLKR/Hbe4jEnN3HXYYdnT+Wo=;
 b=SvlGoB0p1c3gobPsp/71xDMxQYLW/+l6ISQBOFL92Zf4kO2Eoff8sprL8pIzssbiV40PbfF6/a8VwbPr1yz8dfE8az1M9rYj3PSFj1Rxcctr+Jv9YNoMPnSGwviWUdsYHY9ZhuNzdqLiF3SD/x9Fea0psYErXCOBA+xvYZMAanbwaxTnh3vMmKxiWI1mj/f5M4BbJWectOQP2sK/nnvMLpR8zXMm5FKEiwXBF4if9UnBSdwXeDBULcbn3MPDsfnhcyWqpJAOsU3XuOyVXaKCbWGhfxBnC09gywPotEQ3lz2/Du8xk15o97UG3xjGRbR4PmdLhT0XR8PKmBURRnqXEg==
Received: from DM5PR17CA0067.namprd17.prod.outlook.com (2603:10b6:3:13f::29)
 by MN2PR12MB4848.namprd12.prod.outlook.com (2603:10b6:208:1be::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 10 Mar
 2022 11:42:26 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13f:cafe::42) by DM5PR17CA0067.outlook.office365.com
 (2603:10b6:3:13f::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22 via Frontend
 Transport; Thu, 10 Mar 2022 11:42:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5038.14 via Frontend Transport; Thu, 10 Mar 2022 11:42:26 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 10 Mar
 2022 11:42:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 10 Mar
 2022 03:42:24 -0800
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Thu, 10 Mar
 2022 03:42:21 -0800
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <oder_chiou@realtek.com>, <robh@kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [RFC PATCH 0/3] Flexible codec clock configuration
Date:   Thu, 10 Mar 2022 17:11:14 +0530
Message-ID: <1646912477-3160-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d467749a-e86d-41d6-9f02-08da028b0cbf
X-MS-TrafficTypeDiagnostic: MN2PR12MB4848:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4848B979CF269FCB33DA5305A70B9@MN2PR12MB4848.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tEwgMOzYRGgQEAz2aV7NMweK6VOkVH2neKBrVuEum4Eb1F0shp7ypZLzf/P5LWofpuK+eKGIc2+K4H3SeOnw/E7b20ERrEuR32aiCnQuc0vG6H1DyoRZlSeWx9ptdsqdL+scxjd+uVKPpNa/uAzWYy648j3Dqzv9g246tI5KYMs760095swKzzphCnZQrDamy/aLJzYPkeZrOGPYIZtc2WsWiWb5/Tf3zUQpVNrb7GJUhPUDX2/evAprNRRihdrAQ4DYoLgJMv0Xi9vYkkt6WBcVKpWOdft2f3I2rfDje+07ovhkQNT2Pe0xk5VQ6aYB/lLONRGpDOEC2zLdUjDlYWwLAEQh1jNwpU1rbGwQsIupGPn9WTQXcS6NEvfsUm6k8YsWi8zpw1HSEzGArUHZSK08ZjCkb/4shzu9RDSIzUStxSKPDuNknfa+VLdVUNzC/XOhpe17f7iq2yzmIdrXTzIY6Er3qxbQh1HxHraaDLaV1uDyGlu4OE4d1bU9CR7SKn2lYiVphR9yQBYTV4BoOiaXH1le6MDj0Gl4HEkZDkGTQQi9q0wAJPfa1s7/MfWzN9lw+fVrBs5Y63TwzqySJmRNVsPMcgdKgJnJVNqCAu6v1FmB+qKZL8pj6WwFmarNh9N/iNQKciC/uKlRl2CCu2lAZFetusQ0Shg2bbT7ZG6yft7Ap/q/wfpfgKNgiLfuKMXN86JdZSQ76VPzB5fXlK20iny5Vqaxmjmo4Yx40KZQXoNl3vORfuftclQ0tp1BY/DQNslyOajBeGm7ZR7nnLwWK54viv4f5WrCTlIQ41Y=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(47076005)(70586007)(4326008)(2906002)(8936002)(5660300002)(40460700003)(7416002)(86362001)(36860700001)(70206006)(8676002)(83380400001)(316002)(426003)(2616005)(508600001)(107886003)(36756003)(186003)(26005)(54906003)(110136005)(82310400004)(966005)(356005)(6666004)(81166007)(7696005)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 11:42:26.2534
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d467749a-e86d-41d6-9f02-08da028b0cbf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4848
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Sameer Pujar (3):
  ASoC: soc-pcm: tweak DPCM BE hw_param() call order
  ASoC: rt5659: Expose internal clock relationships
  ASoC: tegra: Get clock rate in consumer mode

 sound/soc/codecs/rt5659.c      | 257 +++++++++++++++++++++++++++++++++++++++--
 sound/soc/codecs/rt5659.h      |   9 ++
 sound/soc/soc-pcm.c            |  60 +++++++++-
 sound/soc/tegra/tegra210_i2s.c |  25 ++--
 4 files changed, 332 insertions(+), 19 deletions(-)

-- 
2.7.4

