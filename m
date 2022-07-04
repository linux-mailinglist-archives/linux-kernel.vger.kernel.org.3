Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F49356584F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbiGDOJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbiGDOJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:09:12 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43A16383
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 07:09:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YvYgHWJbogqbLZQJCsUt1d5D25caEqRdAG1D4QJ09ESGhOEeWlifyoyLKC+hWtmGs2R+Oj3T3G3jkew1WP9PW5cXUQzkeoRtndrGSdslaZ1ASFYUO/auXRRW62hovBROW/IRGXZXe62oP5YbZhzdmACpJUwtXMUFWAXhqIjTYA+jnF9FzR7mmHi8NdpWN0LUHfn7/UarpLsLVmm/uItymUgwZGkA1hbk2481DoH0JVp4d2/FKhpAU9R+NsC/Tgk/joVZU5FvmXyLsQQRY+pL/LPwO5foOQItdxyumP5NRzSXFhAWyIjdjH3fUvKTaOaw5nUU+kbuYWiyuj9WQUQVDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhMzU624SB5hj87G1aAhibZr/Bx7YvAXgVavTMMLvEA=;
 b=UWp5HXD4w48QTygpCLX9eMollifVhuWalFfweDef6pjdvq4iiB5NfRaX0arJRUY5PyPcV83G9SwVWid4ITYqmcyDhKDpfcUL3JsYfsxAWcA66djoAE/8UtzVsJXXr1Gg9lD7VCIjaXb3lt7YUiyaH0TXoYOSZsrLMOgH2S7Ry5FTJBv75j3yoacOtBo2lsLoEaU56SXdke9NnXLcrG40+1iC1JQByuvGdMLFgGqdHmXhCklq0JaN6Qj5qxuCKIHxMIFaQ9/nF+AIhVmAOiJKNRY5FB3Z8CwvKqTxbxBdPMFyV+cOn7IT+045kgmnBp40tOF303KGoy/hOUxH+WEBJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhMzU624SB5hj87G1aAhibZr/Bx7YvAXgVavTMMLvEA=;
 b=va2inCuwju96j2J746eTTMHPJHMwMxoZazQig4duyE64do7A6mLnCRx9R7Wevq+6MsnQY6wUOuof6SMyfcVxNeU4+bIAtBeIpKTNHZZu6vawlO4slamXj983ozmeWT5HH6Xx2ZDGQ3H3B4cKaEhnMU+4CB/iGNthLjz+zKzsB/M=
Received: from MWHPR07CA0023.namprd07.prod.outlook.com (2603:10b6:300:116::33)
 by MWHPR12MB1549.namprd12.prod.outlook.com (2603:10b6:301:10::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Mon, 4 Jul
 2022 14:09:05 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:116:cafe::4) by MWHPR07CA0023.outlook.office365.com
 (2603:10b6:300:116::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Mon, 4 Jul 2022 14:09:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Mon, 4 Jul 2022 14:09:05 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 4 Jul
 2022 09:09:04 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 4 Jul
 2022 07:09:04 -0700
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Mon, 4 Jul 2022 09:08:59 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
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
Subject: [PATCH RESEND V2 3/3] ASoC: amd: enable machine driver build for Jadeite platform
Date:   Mon, 4 Jul 2022 19:38:35 +0530
Message-ID: <20220704140837.1215534-3-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220704140837.1215534-1-Vijendar.Mukunda@amd.com>
References: <20220704140837.1215534-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e5d17fd-e897-4e00-8ae0-08da5dc6c171
X-MS-TrafficTypeDiagnostic: MWHPR12MB1549:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wty4eHFsafAu+0pm1u5dm21kJa7pWsXapr0uhNBM8zZS9bEAo8xwgKqWnO0JLzH1GjOscGFlHasZ39g+yeDMam1uh0fy5zTF4ln7tXnGmNXHkFwnYL4stVMvOgt3LdKcZBvRUsb4hWAWzvu+gL5Sm5ChVYMb4NUzkKxOL7pG6yHa0XW0do5jwBtR1BOT0WeHIPRMnZb2sE7p8b5z8PXj0BCB+M1/0sS9lqycTTirkecAhRK0XtBuaVF04jrrbk7BOQP0UXsLHqgkVtbW0p4yyPT+QLrKLRsRL04eTqq/frCDGyEggQAmNjqurTCA8uktVichiIxBa48K4A7J4SB8lXT+zQ9xpQfqf/M5zYToq8FIHGjd9FrGmGarg/SbGuh7Ia5fPucRtAbxeeqY8W+c+Zzr9r9aj4IMfQxLXdg3KtYKQDAcAwrzdyy/4AKBrbyZBV4zPTsC5zlAoZRL7P3ILoHq8VL7OWZwrhntU79f6q3afO3QtD2xZgeXmNMTNaUI4t0e9AkfR4zbjWYPu8brMImOdYSHvshwGlfkptnfKM2yLYWkVKyzSISfcJ29HUUU0IDdbiE9IBmuc0ccN7NFTXV6uSoYRbVO93+M5vLJfPoAJK6nkwvCPPpWR4Jj8sPV4YLRqe/twlzn55jOdKhNOtzpjCr3idkuufc+IUG8bRb5dOSxM3ugP2BqhSEIJWRCn2z8LPW/IPoB5po/7IhW4s/Kq/OKBeb8u49WNG0TBfcdEhWTZeoIUenHF1Zz0VonrqS4TBVtFzRXKhINpaEYJ+ajZForyuaJ1WPK2NnV3ilWa6DvGnl3HURfG41GThQ2eMhUcBD0ZEglKRSrqaQNIo5WlAZjU5kNrqBn52hsQ/3sudpfmh5aRmi0oe5/1qYV
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(39860400002)(396003)(36840700001)(46966006)(40470700004)(110136005)(54906003)(86362001)(41300700001)(36756003)(82740400003)(356005)(81166007)(34020700004)(36860700001)(316002)(83380400001)(2616005)(82310400005)(6666004)(2906002)(5660300002)(8676002)(1076003)(70586007)(26005)(426003)(336012)(186003)(70206006)(7696005)(7416002)(478600001)(8936002)(40480700001)(40460700003)(47076005)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 14:09:05.4823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e5d17fd-e897-4e00-8ae0-08da5dc6c171
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1549
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

changes since v1:
        - Add COMPILE_TEST flag
---
 sound/soc/amd/Kconfig  | 13 +++++++++++++
 sound/soc/amd/Makefile |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index 1381aec23048..c373f0823462 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -23,6 +23,19 @@ config SND_SOC_AMD_CZ_RT5645_MACH
 	help
 	 This option enables machine driver for rt5645.
 
+config SND_SOC_AMD_ST_ES8336_MACH
+	tristate "AMD ST support for ES8336"
+	select SND_SOC_ACPI
+	select SND_SOC_ES8316
+	depends on SND_SOC_AMD_ACP
+	depends on ACPI || COMPILE_TEST
+	depends on I2C || COMPILE_TEST
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

