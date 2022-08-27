Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78E85A390A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 19:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbiH0RCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 13:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234364AbiH0RBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 13:01:39 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9252B182
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 10:01:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zj9pq72ZRAUJkl5l4IK6zdVB9m4U7cpQL7sBTL52XE0UnsjnM0MKe+5Sn56/0++Nr1cYVf0opWYHwJ2P9otQLtrp9QUEDaQoo06B7pPvG2kfuXRR0uW/V1DdMQOBOqxmHjrn+SI/1sE2T3z9leYkMtKV0w8K7HPQbiUXHcPkGhgMFNXRZQ2+S9fcX2aijzjJUd2O4XJSS3ZuujMzrJieg6IQmu7NiX6GaRSrRj/TiSawWdCEQPHK99sRKb5HjSBksp3n3XkyphUNP9kbCUjNFa9q9ermlf7CkTR9d3lnneDNKyjFdiodmmhG5FhVYSFQy7nJiN1cl1hXtHtC6O/2sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lz7OJOfGf4ps/Au4KkYHj79h5U+ZA7XRPNKk8EuGins=;
 b=EbkQuI0lfujfqwxX8AjQeSyT3z00w/HAdGZuPZnb2AWHFu3VlW2QauuLBLUHFUnGIf+giVICTitUljl3pZsG60JsjP2RAeGMzBdH+m7eIo/V8rvwApSaU5PRZhFhZHVJAQNRpNjOE+0vNbpQCrJlnqzQQH+Lsjnk9zYmZbQZ4xa/wH9c8YpwxWS9/lUKLBobdCDBXnCkUXt+hJaqn21rWxXnah57IGXXRB5yW9weFnhLf4S47QiyGlOZ5c0+MiAkp5JhAS+fZtQiQUDdeiQ1ZQNH1Jor3bSLvaeh2evKpon9QiKAOUJNNaaxBhdtEFUXvd23rUETomSIIwDshlupMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lz7OJOfGf4ps/Au4KkYHj79h5U+ZA7XRPNKk8EuGins=;
 b=iCT32Rp9mdAtPdn4hzNAbQYeexGccwjphoAHR2003C8Xzu9ozORaWbyWmfQEFqo5xpFqBNzR5daZ4uUrmtGh6JRl0zlZSCKSaJD8rW8kqVHf5nD7XuzvXs+bpkyXv064Xf/sG0D7iLq013gbJ/vXWYzhNu0p0Ew+7TgHMGJxTSg=
Received: from BN0PR04CA0193.namprd04.prod.outlook.com (2603:10b6:408:e9::18)
 by BN8PR12MB2977.namprd12.prod.outlook.com (2603:10b6:408:4a::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Sat, 27 Aug
 2022 17:01:04 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::1e) by BN0PR04CA0193.outlook.office365.com
 (2603:10b6:408:e9::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16 via Frontend
 Transport; Sat, 27 Aug 2022 17:01:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Sat, 27 Aug 2022 17:01:04 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sat, 27 Aug
 2022 12:01:03 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sat, 27 Aug
 2022 10:01:03 -0700
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Sat, 27 Aug 2022 12:00:58 -0500
From:   Syed Saba Kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <mario.limonciello@amd.com>,
        <alexander.deucher@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Julian Braha <julianbraha@gmail.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 13/13] ASoC: amd: enable Pink sardine platform machine driver build.
Date:   Sat, 27 Aug 2022 22:26:57 +0530
Message-ID: <20220827165657.2343818-14-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220827165657.2343818-1-Syed.SabaKareem@amd.com>
References: <20220827165657.2343818-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 883ce161-ab42-4f2f-d7c6-08da884dba1d
X-MS-TrafficTypeDiagnostic: BN8PR12MB2977:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V/zL/YW+ScawkQ4ZeABpX0DNj3RmgmmbEdWPpX0fIm2yCTdvCHfK9kAmMAk65gRe1/8V8nrCE2EJfbeuDtbVjvCAkGoxPOd2+BKstxcdTNDONUfaLYgya5xY0MKmanFHQ7F6h527XabgbbOwsIMzAUuOgFgSGQNN4NRmZSWyeJoIugtWkUTbb/RsHOzisMT6L10ArSlQYK60OpA4YobNcS7zDLXNm8svhmYEO4JGTVUx1amR/vHD7yekeRmQwC3VQgdM924awc9AcgqdIf8yXNN6fX0gSPyoe9KUfl095SyLnRHB1ZqwNlV0gpiBTqOA/7IaxvVhPcLA/kn0NqqWtpk5YKKgxX4k5TJumEQ0JUZI/fP6EDZPtRlykHt/rP9dv+IB00uYbrEIrLtAoJoRlFTbKy8kktGr0BHC6peKBWlosNdIAcgVvAq/j1qiBwfs/hyC1GwFiKlIx7w0ADhkEIzaI4GPqoX+xeKWgcUfuLWc/UUdt9yl5d3iHdqM2C0m384o02z9eckIuUT4f4Y7vcTzW5BnA74GtZW2wJV5gfUT+3NYPEER8IPD627cn45aPHyAXIzLXGmfQcXdIGqW1M8uOZduDwK5Wyzp1xJqqbICQiuzByeXLcj//CV616UzUAVTigabQDkn0IVWCvRdJ87x+mWYwGiE+JZe00mRAoTQ2+djCUU6wVGP0kLQbMLFKRw/C+XfDh8JvMvIf7b59/8lFaQ4SkDhbfIqwcozGhxaM+Oj+q1CEZPLarLo1GiBU6J6ckdmWBTC/TKfAQNkU6QEL/94s2cAfxwY2pyfsbOGv0M0KrGou6rswtcWL+5v
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(396003)(376002)(346002)(46966006)(40470700004)(36840700001)(83380400001)(36860700001)(82740400003)(81166007)(356005)(5660300002)(316002)(110136005)(7416002)(8936002)(70206006)(54906003)(8676002)(70586007)(4326008)(1076003)(2906002)(47076005)(426003)(336012)(186003)(2616005)(41300700001)(478600001)(7696005)(40460700003)(26005)(82310400005)(40480700001)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 17:01:04.2098
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 883ce161-ab42-4f2f-d7c6-08da884dba1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2977
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables Pink Sardine platform machine driver build.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/Kconfig     | 11 +++++++++++
 sound/soc/amd/ps/Makefile |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index bd785a0efb67..68837d42736d 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -137,3 +137,14 @@ config SND_SOC_AMD_PS
           triggered for ACP PCI driver, ACP PDM DMA driver.
           Say m if you have such a device.
           If unsure select "N".
+
+config SND_SOC_AMD_PS_MACH
+        tristate "AMD PINK SARDINE support for DMIC"
+        select SND_SOC_DMIC
+        depends on SND_SOC_AMD_PS
+        help
+          This option enables machine driver for Pink Sardine platform
+          using dmic. ACP IP has PDM Decoder block with DMA controller.
+          DMIC can be connected directly to ACP IP.
+          Say m if you have such a device.
+          If unsure select "N".
diff --git a/sound/soc/amd/ps/Makefile b/sound/soc/amd/ps/Makefile
index 23afa5e32ffa..383973a12f6a 100644
--- a/sound/soc/amd/ps/Makefile
+++ b/sound/soc/amd/ps/Makefile
@@ -2,6 +2,8 @@
 # Pink Sardine platform Support
 snd-pci-ps-objs := pci-ps.o
 snd-ps-pdm-dma-objs := ps-pdm-dma.o
+snd-soc-ps-mach-objs := ps-mach.o
 
 obj-$(CONFIG_SND_SOC_AMD_PS) += snd-pci-ps.o
 obj-$(CONFIG_SND_SOC_AMD_PS) += snd-ps-pdm-dma.o
+obj-$(CONFIG_SND_SOC_AMD_PS_MACH)   += snd-soc-ps-mach.o
-- 
2.25.1

