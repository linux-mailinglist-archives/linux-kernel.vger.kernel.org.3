Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19053560F8F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 05:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbiF3DTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 23:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbiF3DSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 23:18:53 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2043.outbound.protection.outlook.com [40.107.96.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A0D3615A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 20:18:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ic8eTOQlr3NhNoZVwWU/YUd2z6EbuQmEe7BPbhxGRGFcOUSB9OiwCpjYjWIYTuewoEucUs1XkgVmKXxtu+o1R2ycO24qRUxoajvOkYbXOsLm6w2+OiGj2ajrqMi6EpiOBiGl5KpYP8cIcygqCNdHozuAoca4HMPfj7ZDrRQrbvxN48hC6pOdr1o22yIA59LwwKDheFI+jVusV4lOEawYegCHDao0tuFy4TjEDf+MVWNQolbrLn1QH7JWhl6gqR0vNMMkDgCm4snf2xw9SFT8nWyxgUruO54LyZeOqUO7nDFquiEC7royiZtxKHrDwhTkApAPEPi8Sh9RwOCHo8zRVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbcrE8o3BqQ0wkcaWspm54rvor8qZt/971uAd7IHLf0=;
 b=HR5QKYIQYMnk6Oa+YNtRNwxJ15KcjJQi2FFfyL+LKv/juf1HDEfgHicGu9YLn4tjlOlFdHDE5uJv+3MGwBAIKftrtYKtbHu9IytIepYU4eZAUP02MkIv+gkaXvqsZLyVkWOS8ayqmNVjXHnf3KUsJKEebuxhAKx1vk1zeOBln+7b0MJAW1zYSiOgIsfbtsui/gF3Cws8EuaP7C+a/S4SB4Ai90gzmP+EvTuytzmNQg5FaA9e85WAitP/Hx23Dh1hUkHNx6QmUFBL1zYoyehmZlQCGO3coj2PYt8PPBxgXxdeihcVRrL7E4VAUQQEW/hlrJ4xvrndvglc88QFz7tgMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbcrE8o3BqQ0wkcaWspm54rvor8qZt/971uAd7IHLf0=;
 b=fYy4ZzrTI9cJrI7Z2uIaXqko5GR/FKGjb9uLqGVhsvtrKQ/G0mUEKKpgqBCu3b3b7w/cvfj0d2wlClrgXpzRjenzeYX75uthW5IKHpl8dqKiVuB/xsQ+gJrnqil2P44YuZ4NZ4JZ0RwMZTsX1/FCM3FTOYlul71cK/ZVBBUDJvM=
Received: from BN0PR07CA0009.namprd07.prod.outlook.com (2603:10b6:408:141::8)
 by MW5PR12MB5652.namprd12.prod.outlook.com (2603:10b6:303:1a0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Thu, 30 Jun
 2022 03:18:50 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141::4) by BN0PR07CA0009.outlook.office365.com
 (2603:10b6:408:141::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Thu, 30 Jun 2022 03:18:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Thu, 30 Jun 2022 03:18:49 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 29 Jun
 2022 22:18:45 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 29 Jun
 2022 20:18:44 -0700
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Wed, 29 Jun 2022 22:18:39 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC:     <Alexander.Deucher@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <zhuning@everest-semi.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Julian Braha <julianbraha@gmail.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/5] ASoC: amd: enable machine driver build for Jadeite platform
Date:   Thu, 30 Jun 2022 08:47:55 +0530
Message-ID: <20220630031755.1055413-6-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630031755.1055413-1-Vijendar.Mukunda@amd.com>
References: <20220630031755.1055413-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd0e86ff-b98a-4605-d005-08da5a47409c
X-MS-TrafficTypeDiagnostic: MW5PR12MB5652:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VoWMJDhMfeIUbNwQk0ZYCmNysvCeNG1griFSp9cGliUGMcWBGnQYfvwfc+WYdSWC3euUD4HwGxLIS3JSkP4IDQmNJzZaNJmpLu7hOA8R+KDJqJsGSxcM1mGP42/qDM2xDnJc5ma5fFGXtwotzWd11LnTkWD1SPVUwOLcOAfB4V8apCqdoPDzXydde56s9GGtXRiZGQ18pWq27dyCRlpixGTc777zAXoJgtkba/WSyB6KmNLirevrq9/XJHoURntt8csvOnmJmPklt6PubBSFg+i7NUh2AdtVcb4O3ahph807024Rvy48FeccBQ5j+J38Di6oEKpkzZNQHNgDxfHQoYq8e2SOEd2GH39rQUTfMW7yXBJVcIYhlXXni1HNagcC6I8DT/bF+WKqzbZXhfvLvm0VY41sG7l8Jzx+1FZXmOpOqOId8a6AYqC4O1cwyJKgN/yny3ARDiGTnXNHflSrsiDdYxNgxCV0wUfmw0ICUR5VQUHvHCHQ9AqD1Uc2UI876XV4Spi0R3zi+mvEBI29CYnaneFgXeJOhCjVfFNzm2jAvYxbKn0mPuzRNkZxDHJnPoiJsCXMdBhdWeeeFvp7AXgNQ7f6u25T6bU44OgPDOMuF2DXJPucgS5I81EstmN0kFqdn7ixbHdUbXrMTOAB3Ir73lvDwrQB4J7FwlIfBtWDQrUV5mEQZ5FfTxGig6dsebdLfQC9sT7y9AzZbc3BZ14yORz6sf3TQ+4+y0440qyj/ROIs6FZL1Ks1wtDAsy08ywR2J0zsRMss/Q4uPsv0hp97JFGQyJyjXAU/3yd7gzgxOj0SQVQ5ePHA2MclQln+6TxPLe4QjZm+GHVUdI9BCyDXDynJ/gm6lGS1BBIYhA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39860400002)(376002)(346002)(40470700004)(36840700001)(46966006)(6666004)(110136005)(478600001)(4326008)(36756003)(5660300002)(8936002)(1076003)(2906002)(8676002)(47076005)(26005)(70586007)(186003)(70206006)(2616005)(7416002)(316002)(336012)(426003)(54906003)(41300700001)(40480700001)(82740400003)(86362001)(81166007)(356005)(40460700003)(7696005)(83380400001)(82310400005)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 03:18:49.8761
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd0e86ff-b98a-4605-d005-08da5a47409c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5652
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable machine driver build for Jadeite platform using ES8336 Codec.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/Kconfig  | 11 +++++++++++
 sound/soc/amd/Makefile |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index 1381aec23048..da0c3dc357cf 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -23,6 +23,17 @@ config SND_SOC_AMD_CZ_RT5645_MACH
 	help
 	 This option enables machine driver for rt5645.
 
+config SND_SOC_AMD_ST_ES8336_MACH
+	tristate "AMD ST support for ES8336"
+	select SND_SOC_ACPI
+	select SND_SOC_ES8316
+	depends on SND_SOC_AMD_ACP && I2C && ACPI
+	help
+	 This option enables machine driver for Jadeite platform
+	 using es8336 codec.
+	 Say m if you have such a device.
+	 If unsure select "N".
+
 config SND_SOC_AMD_ACP3x
 	tristate "AMD Audio Coprocessor-v3.x support"
 	depends on X86 && PCI
diff --git a/sound/soc/amd/Makefile b/sound/soc/amd/Makefile
index 4b1f77930a4a..8823f6f28611 100644
--- a/sound/soc/amd/Makefile
+++ b/sound/soc/amd/Makefile
@@ -2,12 +2,14 @@
 acp_audio_dma-objs := acp-pcm-dma.o
 snd-soc-acp-da7219mx98357-mach-objs := acp-da7219-max98357a.o
 snd-soc-acp-rt5645-mach-objs := acp-rt5645.o
+snd-soc-acp-es8336-mach-objs := acp-es8336.o
 snd-soc-acp-rt5682-mach-objs := acp3x-rt5682-max9836.o
 snd-acp-config-objs := acp-config.o
 
 obj-$(CONFIG_SND_SOC_AMD_ACP) += acp_audio_dma.o
 obj-$(CONFIG_SND_SOC_AMD_CZ_DA7219MX98357_MACH) += snd-soc-acp-da7219mx98357-mach.o
 obj-$(CONFIG_SND_SOC_AMD_CZ_RT5645_MACH) += snd-soc-acp-rt5645-mach.o
+obj-$(CONFIG_SND_SOC_AMD_ST_ES8336_MACH) += snd-soc-acp-es8336-mach.o
 obj-$(CONFIG_SND_SOC_AMD_ACP3x) += raven/
 obj-$(CONFIG_SND_SOC_AMD_RV_RT5682_MACH) += snd-soc-acp-rt5682-mach.o
 obj-$(CONFIG_SND_SOC_AMD_RENOIR) += renoir/
-- 
2.25.1

