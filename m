Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8BB2591093
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 14:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238547AbiHLMMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 08:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238546AbiHLMLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 08:11:34 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C85FB028F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 05:11:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQavvPWiA8edvCBH7JlPfJHHA55KZP5zrM2wts7fysnQetWCG6m/GZ7RA2314YEMmA6SdlmAsBIOibAQd/EdAAkVHfPF3SeVHOU4jKOl5HlmLNMU8Csg8uYGavvtyZXh/NPh/0gyEnEJBMw6wjWCesISwkG8Jvzrxl1hvEMAR+Lj23qdDDgWlOafVvWKMfLwEgdIfvFEUxRhDU6sRmqvUzDp3gSgslVjS2eDI9//kGqB4+n4nfsu6M6brtMZ09If0DNOeMz80rimJm1fzT/TNZJfRhKOGsS/X6XHQcvRRZCO3nf380QZzpVnChjE9Vz1JNz45pHVqoumQ1rxvthMqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FayLB7p0TfLgBPJx1fxveDssSGqTJzT+TPLeAI7pHy0=;
 b=hfMOPhldbG3GjlchdhF6f9Ew2Ypqe1dSI+jN9p6cR7Qcge65k9+PzpuXMZqbBti/XfmqBrxbhso8CfhfjFEAk8T6KI6SFezLPLIEBRGG/tzMpcc7FkOSfhcJHEH/UaCmTcchcinaUXwAXWSe5u75MVKypjwgYlemK7XankgtAjwpSj77zFuBzd2uBH02NL71IfnaQgD8ud0eoy98Juf6cz1oL5IiAJVU7GHWMDd3RiIc1LykDOgykWXBrsHF0d7LFxPrcHKzhJNUFdwypHLadfVGTv4aVCDViHkWtBK2/EBK1B3IKGIQl+v9MWA5fyJviBeIKLzppMn31tCqq9k9DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FayLB7p0TfLgBPJx1fxveDssSGqTJzT+TPLeAI7pHy0=;
 b=QgUVGgUTB1mV5h3oOPASyGQng9idwzlxs4YHbqG8WxucElpyW1+7u1qtIeRtHNBsV4zRXPjxENrsIg09/n7rzosz5uO4mLYFNM8ZgpNotztzE19CoU6mXC+9SuMNDEsTgE4gutWHJGpX4Ru5t5P04QBxggM1TLTNByF5bccrtTQ=
Received: from DS7PR03CA0242.namprd03.prod.outlook.com (2603:10b6:5:3b3::7) by
 BN6PR12MB1889.namprd12.prod.outlook.com (2603:10b6:404:105::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Fri, 12 Aug
 2022 12:11:28 +0000
Received: from DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::ff) by DS7PR03CA0242.outlook.office365.com
 (2603:10b6:5:3b3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Fri, 12 Aug 2022 12:11:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT096.mail.protection.outlook.com (10.13.173.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.7 via Frontend Transport; Fri, 12 Aug 2022 12:11:27 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 07:11:26 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 05:11:26 -0700
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 12 Aug 2022 07:11:21 -0500
From:   Syed Saba kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <mario.limonciello@amd.com>,
        Syed Saba kareem <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Julian Braha <julianbraha@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Bard Liao <bard.liao@intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 10/13] ASoC: amd: enable Pink Sardine acp6.2 drivers build
Date:   Fri, 12 Aug 2022 17:37:28 +0530
Message-ID: <20220812120731.788052-11-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812120731.788052-1-Syed.SabaKareem@amd.com>
References: <20220812120731.788052-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06daae68-c519-4e43-69d1-08da7c5bc899
X-MS-TrafficTypeDiagnostic: BN6PR12MB1889:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lwOQj5eFPKJ+Bebh9anjSjXBpe3zC7GdVtVrdxGAgnXekaywUwABBXrylPZVe4rb82hkCzXrYpaSAUR7mDaCEKo2j6Q+E0s1lnVKNBBomj/jFyiFWfFuZBw5DufEpcn68lKzHsnLuat6EW1duFQ5rol/oEiJFZXTJa8W0ViIQUSUjibiZmDxTNwSY4C9jlqLf2Qa4odfGdcjDD1/dlxhy8rkpE+TZhwsWuLFzqz92c1RiC2wZuxja2kzH0ED3Heup4/mKWL02dsW6WCHjT8pAKy3pRwPU3n8knvkIok9pCq5GVmpcgr6SfnQAXeIXquqjvSJcqUX4Z1rLLjQYUGDO6A4r8+a4EBUk2UeXYsDofddj9ha9nKrnHcILT7BCwXdjMyKPUAJbzrz5VO7I+YU58n0Ne9NU7UuknqzIeGMEF5EN83y9u4LvsR+o/7kaJH5PunoJC+pvx2hr3LxolHy6gsiadLQbHlIEfjrn/RxQG2qjIbivccXK9dLvufSeBYgfYKkASXOi/e128+2lME4EiYT+L/iHkm/WZXJWpL5ofLo4+h6CDGk5RIS83UYmUYhnIaboVEO0xCWb9sOwY9MrBKL/StXtzVg9UGzVR4M8vOauGHbvUVnq2XoFkywi7468IHu4K91VKiIwNgyPzP4JJjs1z98LpwVgNLCLgPmHZI+zu6wf6jF4pj4bNsRWa/Ig0jfXXfemsOP2znrlutMfXGCTYyXhrOa4nGCmIz/l9TR7HS+/HQHgX7wQrOdvp6Vpc3wSQMIdTRHuW4VQEzriTpumnuUj2rTwjbCFR2UX61AasOYA6AibHg1M6KB9GvQNMJR0onhMq99c5rQTQFyyg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(136003)(396003)(39860400002)(36840700001)(46966006)(40470700004)(36860700001)(41300700001)(26005)(2616005)(2906002)(40460700003)(7696005)(86362001)(82310400005)(40480700001)(110136005)(8936002)(36756003)(54906003)(478600001)(7416002)(356005)(82740400003)(81166007)(426003)(336012)(186003)(83380400001)(47076005)(8676002)(316002)(5660300002)(70586007)(1076003)(70206006)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 12:11:27.4774
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06daae68-c519-4e43-69d1-08da7c5bc899
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1889
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pink Sardine ACP6.2 drivers can be built by selecting necessary
kernel config option.
The patch enables build support of the same.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>wq
---
 sound/soc/amd/Kconfig     | 10 ++++++++++
 sound/soc/amd/Makefile    |  1 +
 sound/soc/amd/ps/Makefile |  7 +++++++
 3 files changed, 18 insertions(+)
 create mode 100644 sound/soc/amd/ps/Makefile

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index 08f5289dac54..0f461beca274 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -127,3 +127,13 @@ config SND_SOC_AMD_RPL_ACP6x
           triggered for ACP PCI driver.
           Say m if you have such a device.
           If unsure select "N".
+
+config SND_SOC_AMD_PS
+        tristate "AMD Audio Coprocessor-v6.2 Pink Sardine support"
+        depends on X86 && PCI
+        help
+          This option enables Audio Coprocessor i.e ACP v6.2 support on
+          AMD Pink sardine platform. By enabling this flag build will be
+          triggered for ACP PCI driver, ACP PDM DMA driver.
+          Say m if you have such a device.
+          If unsure select "N".
diff --git a/sound/soc/amd/Makefile b/sound/soc/amd/Makefile
index 0592e7c5c407..82e1cf864a40 100644
--- a/sound/soc/amd/Makefile
+++ b/sound/soc/amd/Makefile
@@ -18,3 +18,4 @@ obj-$(CONFIG_SND_SOC_AMD_ACP6x) += yc/
 obj-$(CONFIG_SND_SOC_AMD_ACP_COMMON) += acp/
 obj-$(CONFIG_SND_AMD_ACP_CONFIG) += snd-acp-config.o
 obj-$(CONFIG_SND_SOC_AMD_RPL_ACP6x) += rpl/
+obj-$(CONFIG_SND_SOC_AMD_PS) += ps/
diff --git a/sound/soc/amd/ps/Makefile b/sound/soc/amd/ps/Makefile
new file mode 100644
index 000000000000..23afa5e32ffa
--- /dev/null
+++ b/sound/soc/amd/ps/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Pink Sardine platform Support
+snd-pci-ps-objs := pci-ps.o
+snd-ps-pdm-dma-objs := ps-pdm-dma.o
+
+obj-$(CONFIG_SND_SOC_AMD_PS) += snd-pci-ps.o
+obj-$(CONFIG_SND_SOC_AMD_PS) += snd-ps-pdm-dma.o
-- 
2.25.1

