Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAED4AE8BE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 06:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241837AbiBIFHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 00:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377696AbiBIEcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 23:32:03 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4167C0613CB;
        Tue,  8 Feb 2022 20:23:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQVQw/X94Jn5tph5CeKj6z8URZVXuwCkfKydGLXcN8wvehF4ppjg7pObepSEBvp+7ULZNCMm5SbmJYiiEvUkfcYllRdXHdqEq2rXrhwbC4B1uGelWAUBQ8BIMRge9ej0SqnjV7FZlDbFngsEB2pvGuUAkA0mD3QNrQmY2p6Qa0EUsRhvMvH3AVLD2AF98n7nLZjvjkQ6DWExiby16LI/1HjttUgOX8TGAuIRiE2U5lcDIZExlzHVShfkpt007pbOTD/ZGvyRksYmhMmJLxHx0deEro1xw+IdgyRKye7JuXiQh/A/NJZRpPrBJc3x6k0hv93ORm12WLGhQAeB1lxytA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laRYp0AjzlnOtPI+VIIuhkLI9BFmn9x/QkudqF2FOU4=;
 b=YI/CGuyLZQC2sKDt5tsJfjQOj+Lf3U82/xYSax8IIgQgnIoYhxIgjUhaNmBGrIIn8ZzibIXmLHRY5SOookF23NIV6xVbkpAwlWBOA3Xd8xrOo56SHMI3tNmS0qOJVkihDj5diLNiN34mVLcu6NQJIuvTYyAzM60sjRV7L89HSmbE4oEN+JmgO0xR88mMG5PjaulxxqNL5YlhnQoLoY6RWX6cVFe0H7t5UFREARvlx693qaW8pvocSY55MjPywIaMnBQVoLExraGbNuGTGQ3p4494/DpDJZ3qXrlo0aDzY1/Qh0dcgDdXRfhWxZWQNmNLtPXlOzCKkb3oIXfoInrBLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laRYp0AjzlnOtPI+VIIuhkLI9BFmn9x/QkudqF2FOU4=;
 b=XVHSwH64WKyfRjnWbMWurJ037HM5sQGOsyS+7W+eYeRwB9lSm2U1ZE4p5mdhuWdRtBU6TlG98YPZ2R5j8RQY2rsrglghOaCMs1Re3MquaKD7XyWb9bsKpAvMdeEHY1hhEIqBYbC88SWua7AjbGRmdso1LenGwpJ3F2jKBgGCdWIjwjGx1XtCy764XxV1iJSc3CVTGtLUQ1wB+l2lg9IHrCRUkMehgSKmn7WeqitRf0u/AxIai8UvIweb6yuyOWsLYtYib30lR1NBY8s+uecFVzwWs1Oj4kzKvI0NyjPF7N3Wq2+weW8qbqS5Hpe98HtLKYcWleHA96kutZC3rfy2LA==
Received: from MWHPR17CA0050.namprd17.prod.outlook.com (2603:10b6:300:93::12)
 by CH2PR12MB4859.namprd12.prod.outlook.com (2603:10b6:610:62::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 04:23:56 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:93:cafe::e8) by MWHPR17CA0050.outlook.office365.com
 (2603:10b6:300:93::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19 via Frontend
 Transport; Wed, 9 Feb 2022 04:23:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 04:23:55 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 9 Feb
 2022 04:23:55 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 8 Feb 2022
 20:23:54 -0800
Received: from mkumard.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Tue, 8 Feb 2022 20:23:50 -0800
From:   Mohan Kumar <mkumard@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <tiwai@suse.com>,
        <jonathanh@nvidia.com>, <spujar@nvidia.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mohan Kumar <mkumard@nvidia.com>
Subject: [PATCH v1 1/6] ALSA: hda/tegra: Add Tegra234 hda driver support
Date:   Wed, 9 Feb 2022 09:53:21 +0530
Message-ID: <20220209042326.15764-2-mkumard@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220209042326.15764-1-mkumard@nvidia.com>
References: <20220209042326.15764-1-mkumard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8cf64c5-303a-4327-a611-08d9eb83fc5f
X-MS-TrafficTypeDiagnostic: CH2PR12MB4859:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB485991F44372BE8E6C6A9F89C12E9@CH2PR12MB4859.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cSMpMCVH+FOZhHnKqvpueLpTp0BKgsoFcycTJwEJB9gOVO+KLcDFU+atBx0dL4nqBRKBCxvLbq4dvAls/HQwhw7+/t4ePZnhpBFf7/KvUDZ1MkXfN/iMMKHFem23ZbPaVpxfIiiM6oCbcTdXLP9eAn/hiCXLP+KBP+L9yYmaaawNFtgMCgSpUvBh1qc3mSCg2oLyCu1KNqEVJxBKQrkVM2NM7iiF7xHAVfxOlxaJCnvRGqX8q6Rk5FJ3+kyi1CVEygnk6VO2KeMU8kfbEdf8G242N1mtRakT6+0K6Th34ael9vI2ES978U3I28LrV8h/hPFlgb8ZYPfWTzJB4oK0tQqsm6sWy+8brI+LysfDE27WPepyoJBX2cvItTPr+65+rA1w9cCtxzzlI2pBZBSNLwkgHXGwL/UYDyzoijtC0h3SfOFGA19UtSIiiZy6NemTrkbKNI431VAEmAHzJ43ZoNNq17EGW7TFEu9nni8CtSdKxaycApE9UHOdd5XkhzOsmlj+m2ce3S1EcEh9alqGdC37O50F4ptMIoGZwPUnkW37t0AqZ9lpZIuXrwmwDxpWuC8lWQimcHzTMA64Uyjjvs2ThK87QpKz0rnYDj91Zd1Id8Mzqe19AskRJHNyK1LsOMFDDuprqthAdgjjfkELb11Bk/4mzv53UzhNuIYFHTiw3ulv829ov9a+kMgNRorswRkO4QPZT1Dhu1ALcSuwSsVRB/zAzauUPlZTCq9e9vU=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(82310400004)(8676002)(5660300002)(356005)(81166007)(6636002)(316002)(4326008)(70586007)(54906003)(70206006)(110136005)(40460700003)(7696005)(508600001)(83380400001)(107886003)(6666004)(186003)(36756003)(426003)(336012)(26005)(2616005)(1076003)(47076005)(8936002)(86362001)(2906002)(36860700001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 04:23:55.5912
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8cf64c5-303a-4327-a611-08d9eb83fc5f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4859
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hda driver support for the Tegra234 chip. The hdacodec
on this chip now supports DP MST feature, HDA block contains
azalia controller and one hda-codec instance by supporting
4 independent output streams over DP MST mode. There is no
input stream support.

Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
---
 sound/pci/hda/hda_tegra.c  | 21 +++++++++++++--
 sound/pci/hda/patch_hdmi.c | 54 +++++++++++++++++++++++++++++++++-----
 2 files changed, 67 insertions(+), 8 deletions(-)

diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index 773f4903550a..95df52b0505b 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -70,6 +70,7 @@
 
 struct hda_tegra_soc {
 	bool has_hda2codec_2x_reset;
+	bool has_hda2hdmi;
 };
 
 struct hda_tegra {
@@ -435,15 +436,23 @@ static int hda_tegra_create(struct snd_card *card,
 
 static const struct hda_tegra_soc tegra30_data = {
 	.has_hda2codec_2x_reset = true,
+	.has_hda2hdmi = true,
 };
 
 static const struct hda_tegra_soc tegra194_data = {
 	.has_hda2codec_2x_reset = false,
+	.has_hda2hdmi = true,
+};
+
+static const struct hda_tegra_soc tegra234_data = {
+	.has_hda2codec_2x_reset = true,
+	.has_hda2hdmi = false,
 };
 
 static const struct of_device_id hda_tegra_match[] = {
 	{ .compatible = "nvidia,tegra30-hda", .data = &tegra30_data },
 	{ .compatible = "nvidia,tegra194-hda", .data = &tegra194_data },
+	{ .compatible = "nvidia,tegra234-hda", .data = &tegra234_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, hda_tegra_match);
@@ -473,7 +482,14 @@ static int hda_tegra_probe(struct platform_device *pdev)
 	}
 
 	hda->resets[hda->nresets++].id = "hda";
-	hda->resets[hda->nresets++].id = "hda2hdmi";
+
+	/*
+	 * "hda2hdmi" is not applicable for Tegra234. This is because the
+	 * codec is separate IP and not under display SOR partition now.
+	 */
+	if (hda->soc->has_hda2hdmi)
+		hda->resets[hda->nresets++].id = "hda2hdmi";
+
 	/*
 	 * "hda2codec_2x" reset is not present on Tegra194. Though DT would
 	 * be updated to reflect this, but to have backward compatibility
@@ -488,7 +504,8 @@ static int hda_tegra_probe(struct platform_device *pdev)
 		goto out_free;
 
 	hda->clocks[hda->nclocks++].id = "hda";
-	hda->clocks[hda->nclocks++].id = "hda2hdmi";
+	if (hda->soc->has_hda2hdmi)
+		hda->clocks[hda->nclocks++].id = "hda2hdmi";
 	hda->clocks[hda->nclocks++].id = "hda2codec_2x";
 
 	err = devm_clk_bulk_get(&pdev->dev, hda->nclocks, hda->clocks);
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 92df4f243ec6..879f886d2406 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -3851,17 +3851,29 @@ static int tegra_hdmi_build_pcms(struct hda_codec *codec)
 	return 0;
 }
 
-static int patch_tegra_hdmi(struct hda_codec *codec)
+static int tegra_hdmi_init(struct hda_codec *codec)
 {
-	struct hdmi_spec *spec;
-	int err;
+	struct hdmi_spec *spec = codec->spec;
+	int i, err;
 
-	err = patch_generic_hdmi(codec);
-	if (err)
+	err = hdmi_parse_codec(codec);
+	if (err < 0) {
+		generic_spec_free(codec);
 		return err;
+	}
+
+	for (i = 0; i < spec->num_cvts; i++)
+		snd_hda_codec_write(codec, spec->cvt_nids[i], 0,
+					AC_VERB_SET_DIGI_CONVERT_1,
+					AC_DIG1_ENABLE);
+
+	generic_hdmi_init_per_pins(codec);
 
 	codec->patch_ops.build_pcms = tegra_hdmi_build_pcms;
-	spec = codec->spec;
+	spec->chmap.ops.chmap_cea_alloc_validate_get_type =
+		nvhdmi_chmap_cea_alloc_validate_get_type;
+	spec->chmap.ops.chmap_validate = nvhdmi_chmap_validate;
+
 	spec->chmap.ops.chmap_cea_alloc_validate_get_type =
 		nvhdmi_chmap_cea_alloc_validate_get_type;
 	spec->chmap.ops.chmap_validate = nvhdmi_chmap_validate;
@@ -3869,6 +3881,35 @@ static int patch_tegra_hdmi(struct hda_codec *codec)
 	return 0;
 }
 
+static int patch_tegra_hdmi(struct hda_codec *codec)
+{
+	int err;
+
+	err = alloc_generic_hdmi(codec);
+	if (err < 0)
+		return err;
+
+	return tegra_hdmi_init(codec);
+}
+
+static int patch_tegra234_hdmi(struct hda_codec *codec)
+{
+	struct hdmi_spec *spec;
+	int err;
+
+	err = alloc_generic_hdmi(codec);
+	if (err < 0)
+		return err;
+
+	codec->dp_mst = true;
+	codec->mst_no_extra_pcms = true;
+	spec = codec->spec;
+	spec->dyn_pin_out = true;
+	spec->dyn_pcm_assign = true;
+
+	return tegra_hdmi_init(codec);
+}
+
 /*
  * ATI/AMD-specific implementations
  */
@@ -4322,6 +4363,7 @@ HDA_CODEC_ENTRY(0x10de002d, "Tegra186 HDMI/DP0", patch_tegra_hdmi),
 HDA_CODEC_ENTRY(0x10de002e, "Tegra186 HDMI/DP1", patch_tegra_hdmi),
 HDA_CODEC_ENTRY(0x10de002f, "Tegra194 HDMI/DP2", patch_tegra_hdmi),
 HDA_CODEC_ENTRY(0x10de0030, "Tegra194 HDMI/DP3", patch_tegra_hdmi),
+HDA_CODEC_ENTRY(0x10de0031, "Tegra234 HDMI/DP", patch_tegra234_hdmi),
 HDA_CODEC_ENTRY(0x10de0040, "GPU 40 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de0041, "GPU 41 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de0042, "GPU 42 HDMI/DP",	patch_nvhdmi),
-- 
2.17.1

