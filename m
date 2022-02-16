Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F364B83EE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 10:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbiBPJXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 04:23:12 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbiBPJXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 04:23:09 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFEFB0D3B;
        Wed, 16 Feb 2022 01:22:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iqVbK09OAO1LwlxUMeZN8k7jRjlsiNkX4GTjWWE+KLRkGl8LR5ci63CHlXDNHqgozfczhSAEZHHVFaNa7LvNVrfRzPKsq4OrY2ozucTFdrnCKXqBZyRaway/SVQICKjYVQ4KAGp+Y4Y1GMl/Pzk4poiqYwRvSTPBJpuzdJ1J5oIQCtGDOwNYZwtFrW4D/UHo876MvBr7V4ao+n+pOQuMRcqlrlCZ3tL6huxwwtlS32B8ONrOVLQO98g5P/S/dbEnft7lkkJZvD9jUlbN68F4RZ9ebEqqbjgQR0uRBXugah1uVh6lX283sVo3t5S+Wz6Z7jGIoiMuAJ+F7xPXSUobFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsEn2REICZ8v6BwIB4SNdnJiv9KeWycaQtCcr8LFJZU=;
 b=U+o6mp7QZgAna+slROLtF5bMGDNsRfw2L/PkmpL0TjroaqDD/C9jvkrpWmdXTt7PWjnPoenqQFXwHlPjlJkp0cH9sA3cZGcuJxvjHWC3w/oKGbKPiH14tbcu/Q4i400jClWtmvCmlvtBvlc5rBU7XoS8d7vVeCMlMm70VQ97quQw6MUW1Z13302omhsfRRfkHMXYJLtbeVcyiAKSWqyTX9c9KjZNWfJwxPyGIUIc8giizhwb3NgOCRCtbKFp7po98XjEZxFJ8QZ9Q3zsnBOaEZ89YGc9JzRw4C+hj61QqO6eaZnnMtUhfhBTBnqtnObx9uupCN84+rMDqN+p6Xkx+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsEn2REICZ8v6BwIB4SNdnJiv9KeWycaQtCcr8LFJZU=;
 b=CYhDiapyOZxn9nF9TKgCF17BmRpSmUbkkfYL925keX6tdXdOYgud3vBf85dzpDw0sMNd2GREQ9+3tOjwr77rK1C2RfMTMUwLj9rGcPQHLxg0w6CbZE4PVkuVCdX0OJ1Rg4pM6dZEQFQjoFEN8LS2TEDy1rS/wQj80xgosibf6e5pi3xzTj3Cwuin+Ix4RjySZ09ODMJ6/HaJ6HMDoQGWj1pCs7yHA+7uejdMn4zckvSEPHDmsVlCd7ZuYpseAHbyaBAmb+i3EcNLRUnTXX23NQ5PehsbrTugxb3NCuDi6edjMiTGNDNCsXkeU9vANi1Y2bN8tX0+IM2nijLjQbwMHg==
Received: from BN9PR03CA0551.namprd03.prod.outlook.com (2603:10b6:408:138::16)
 by DM6PR12MB3913.namprd12.prod.outlook.com (2603:10b6:5:1cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Wed, 16 Feb
 2022 09:22:53 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::b7) by BN9PR03CA0551.outlook.office365.com
 (2603:10b6:408:138::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Wed, 16 Feb 2022 09:22:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Wed, 16 Feb 2022 09:22:52 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 16 Feb
 2022 09:22:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Wed, 16 Feb 2022
 01:22:50 -0800
Received: from mkumard.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Wed, 16 Feb 2022 01:22:47 -0800
From:   Mohan Kumar <mkumard@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <tiwai@suse.com>,
        <jonathanh@nvidia.com>, <spujar@nvidia.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mohan Kumar <mkumard@nvidia.com>
Subject: [PATCH v3 1/6] ALSA: hda/tegra: Add Tegra234 hda driver support
Date:   Wed, 16 Feb 2022 14:52:35 +0530
Message-ID: <20220216092240.26464-2-mkumard@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220216092240.26464-1-mkumard@nvidia.com>
References: <20220216092240.26464-1-mkumard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5c0895d-3653-4f32-c022-08d9f12de8a4
X-MS-TrafficTypeDiagnostic: DM6PR12MB3913:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB391371AB55F58E30170E1A8AC1359@DM6PR12MB3913.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gUqQz6SoRwy0w9f7eXZZALF+ZWkcEUi3cijNaCIEEFkcWNpUgmoruWwmfIgl5C/8b6on/sjFFcKTe5U5TJgSFSCEz6E9PuVM0x5uX5UvBxQMCe/Xpg96KzuNQfnPgvOHDpdiz1mjyxwu5jdAMHeJXAyl/obRCGC+b8D/uTiUohsFdBOyFaYdX/BLMZ50IEadYBdE1pWTAuQ9yKQ0vcThq40e7RpCujSbmHex/+PpXHOHY2sUj/mbeQoxdJVvfbm9Q9vg5PKsOCEy7h4TdXU5FtXev9qsIOoqF1K/NT7ASIHSJhHd/4oJm7gM9eLXyxORPduiMMieQ4MAAHollqdXpz8xFvhTARfIS6uoLWfbPM8K+UkqUzjy+4N4WP/3+Bh6XsJKECYyk0KfBxbJhPQbaO63o826YUDmxZZVNavmedX/ThVfx4FKhDLExcdaDExx1+f7CeCls16XWvLjTtITFbm4mRBTca9V/jZ+gvFbS6JpQNYOXv2XWffeBqkdygSJbFxJiJAM5jA+hrDocLJH3RRm0l0jtF8cVMSXSWBRS+RzgVzKyqZ91phcNGNFFS2H4kSrUoEsHlEP3pqgIEQG9kVGOOShvoMGrs+g04nJD6TCdC6ELqW7yaEEvMdusDCI8JnI06b7nkG0LqkEnoQTrcojp0wAQW0NEJRpfrOjFOg5gTsrs2neZtg7cONA1LDrW679AcMkQbJ+R5O5PGqmLk1CsVHvZkPXwjOIBQq8z6A=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(316002)(83380400001)(40460700003)(47076005)(6666004)(110136005)(54906003)(1076003)(6636002)(508600001)(70586007)(2616005)(336012)(36860700001)(70206006)(426003)(81166007)(186003)(5660300002)(26005)(107886003)(8936002)(4326008)(2906002)(8676002)(356005)(82310400004)(36756003)(86362001)(7696005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 09:22:52.6850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c0895d-3653-4f32-c022-08d9f12de8a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3913
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 64fe025fda86..0adda9b9ba3e 100644
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

