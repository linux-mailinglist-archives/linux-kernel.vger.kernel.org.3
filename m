Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2485657C445
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 08:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbiGUGNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 02:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbiGUGNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 02:13:15 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2065.outbound.protection.outlook.com [40.107.96.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D962F7AB01
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 23:13:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2t0jHNNFAz0K8eUjX2fuw2dZ5+RM64n+CrytLeZStxEqdssm4SGTt8Qcrg4f1zA0d+xSrkaTn0eilgNX4Au86lXFQlCubxHpNiQJkQyqvXI64t8RX5akAQ2+qFRPLAfTandog/mMaW5+/7lfBGsy5hbYAX16EqoS1l2t5XKIwyqdtgqlppRTzzGW0q34TJAyF1YgVBjObH6eoVzb2geWiuYa6OlpTtyfFzudF5OugcmZNkFBuU9DxW0co8ghr1+mvVfRJF/VkibzvYk52aQ9sBpYmypg7jCyRPgFqPWgYsnod6X1X/rMWjuPIym7THXKYnYF6MBCNSi6PNiKoU+0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0D4igSH7BZLvBKhq9qPOhpohSGkdXgBNNRu0eLmGCQ=;
 b=O0A8OzxxOb08GNzCALQR5P126JUGGH2iU+5dQDB53Qn7K1+XCr38DsxvBnp1XJxRStbmPVgIW1zaIa8zURZmVGwIB+KdbRVOsbiS/QdYh2E4/edIoJJ5wMsr+Gdrudtlg2XXTQMdMYLd8shnFFjaf3kzTFsnXfH3xHEmFfrEzLYP1x/SzgUZZHgMs7oJLPwI+Fg10WN/O8YftmPUhyLh3LhE+qThOL0Vuu9u5CFt0uJ7yRZ6lkYAdNiBwkKXNninOdvCWUhCrUqV/4oE5nHUGE3aJ+/CgA5b6O4n9v37UJmxCbRkXABUg//IeWBxTFuO/gMLHnEuPzjM1h+gJsSLzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0D4igSH7BZLvBKhq9qPOhpohSGkdXgBNNRu0eLmGCQ=;
 b=KSKl4Nni6Ye9Be6Td3zfQCuTbWgkmbefc7CKdIDSTnxirTP6jjDeRPkmJAPIrBA0KdIRghN06ynlSalScBsC6jKbbmHiZFndpWmTFOS6SeRJjLdwcvKXGfMLVkSgSrlapAbu+5fH4t2IEdGmWzidVOzQeLF11EdY/nohI0OrM9Q=
Received: from BN9P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::17)
 by SA0PR12MB4384.namprd12.prod.outlook.com (2603:10b6:806:9f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 21 Jul
 2022 06:13:11 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::63) by BN9P222CA0012.outlook.office365.com
 (2603:10b6:408:10c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18 via Frontend
 Transport; Thu, 21 Jul 2022 06:13:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Thu, 21 Jul 2022 06:13:11 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 21 Jul
 2022 01:13:08 -0500
Received: from amd-Z97X-UD7-TH.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Thu, 21 Jul 2022 01:12:58 -0500
From:   syed sabakareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Alexander.Deucher@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <vijendar.mukunda@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Julian Braha <julianbraha@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Bard Liao <bard.liao@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/5] ASoC: amd: enable RPL Platform acp drivers build
Date:   Thu, 21 Jul 2022 11:40:02 +0530
Message-ID: <20220721061035.91139-5-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220721061035.91139-1-Syed.SabaKareem@amd.com>
References: <20220721061035.91139-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f000a1d5-e8f1-4d5b-ad38-08da6ae016f5
X-MS-TrafficTypeDiagnostic: SA0PR12MB4384:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S1EOC2ZAnEpkfZMNsWp1nBKpK7OBmdsltmHW8YFwyAyQLDrT4sOXPl804nvgcFBchcLXGZ1B5Yw5XRQ82QlvmLP6bNgi60fPRBb7KqPDhzLSugPG5N/5u6udTriB6mYUBo/nrQ1vl9naqtmE099XVUQ6iNfv7gW+9DsxTDYV0D24d/4qfeFYFeVNfQC3imhgV4Nsqw13CUQM8DJNhgIkRqHHQLZqZHksGWutnrqt5iVNyOmptKAPvxUpR5Rb5XoFWbwE0XXv+6nN8FaNGophl2bL0+M9Vf5vBNDGL3Qu8PawWzJDOeWU2BwL70ub/JjtOUmJzZXL+45CYS3G+AdgKuXOVjRAeQRdN7L0W3PbMUsxB7jceb58/G1Uj5LsCyoIlpl83bZ+7QMowNGviJeViVG+x9X8YohPSv3VQmZT7zdccbYJ4kMWMTiDW3y7bGiTdVZEi1PtJhTLG8RyErNXGXDE98PABUkCkqiqGlrQPnNKk8+Z+iC+daxpVa1nAB91Gy2nL51irO8Cmr/7rzJ5IXRkPF8oglICk6DW8len/Y3PK/M3XdQ5by1tXeS+9o1RNlDYgZFdCT9H1gfSCakKXq7RFgHamcWzeRF86Hk7jy7i0it6tr86Zrxm9AaQl/gYDAzVMdy0wVqaoCIMcdNhULrEhZEwmDDW53i6UJpeVtUgcWCyv2GnpFYPv7E0USaLgQ1wWeJE2cKgffLSW3+MiNyLsU968H0ksbNEg+UhyvVINdsR48K7qNrGn7rzhMSJCbUPIX8bpoE80pBRbwFrDIEvna08/4QsjPWBQtmBWsbp9i73w7aM565OTgnEBuicesDBcLJKWoapdFdLzDKr7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39860400002)(346002)(396003)(36840700001)(40470700004)(46966006)(8676002)(4326008)(70586007)(70206006)(82310400005)(110136005)(478600001)(316002)(54906003)(8936002)(40480700001)(2906002)(5660300002)(7416002)(40460700003)(36860700001)(86362001)(36756003)(336012)(426003)(82740400003)(186003)(81166007)(41300700001)(1076003)(26005)(83380400001)(2616005)(356005)(6666004)(47076005)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 06:13:11.5983
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f000a1d5-e8f1-4d5b-ad38-08da6ae016f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4384
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Syed Saba Kareem <Syed.SabaKareem@amd.com>

RPL Platform drivers can be built by selecting necessary
kernel config option.
The patch enables build support of the same.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/Kconfig      | 10 ++++++++++
 sound/soc/amd/Makefile     |  1 +
 sound/soc/amd/rpl/Makefile |  5 +++++
 3 files changed, 16 insertions(+)
 create mode 100644 sound/soc/amd/rpl/Makefile

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index 9c2fef2ce89f..08f5289dac54 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -117,3 +117,13 @@ config SND_AMD_ACP_CONFIG
 	 driver modules to use
 
 source "sound/soc/amd/acp/Kconfig"
+
+config SND_SOC_AMD_RPL_ACP6x
+        tristate "AMD Audio Coprocessor-v6.2 RPL support"
+        depends on X86 && PCI
+        help
+          This option enables Audio Coprocessor i.e ACP v6.2 support on
+          AMD RPL platform. By enabling this flag build will be
+          triggered for ACP PCI driver.
+          Say m if you have such a device.
+          If unsure select "N".
diff --git a/sound/soc/amd/Makefile b/sound/soc/amd/Makefile
index 8823f6f28611..0592e7c5c407 100644
--- a/sound/soc/amd/Makefile
+++ b/sound/soc/amd/Makefile
@@ -17,3 +17,4 @@ obj-$(CONFIG_SND_SOC_AMD_ACP5x) += vangogh/
 obj-$(CONFIG_SND_SOC_AMD_ACP6x) += yc/
 obj-$(CONFIG_SND_SOC_AMD_ACP_COMMON) += acp/
 obj-$(CONFIG_SND_AMD_ACP_CONFIG) += snd-acp-config.o
+obj-$(CONFIG_SND_SOC_AMD_RPL_ACP6x) += rpl/
diff --git a/sound/soc/amd/rpl/Makefile b/sound/soc/amd/rpl/Makefile
new file mode 100644
index 000000000000..11a33a05e94b
--- /dev/null
+++ b/sound/soc/amd/rpl/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0+
+# RPL platform Support
+snd-rpl-pci-acp6x-objs	:= rpl-pci-acp6x.o
+
+obj-$(CONFIG_SND_SOC_AMD_RPL_ACP6x) += snd-rpl-pci-acp6x.o
-- 
2.25.1

