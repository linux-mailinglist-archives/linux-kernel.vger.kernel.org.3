Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB5A4B06A1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 07:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235588AbiBJGvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 01:51:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235599AbiBJGvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 01:51:15 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F12610BD;
        Wed,  9 Feb 2022 22:51:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7YUh23djWTAroKEwAXmXxaL+WS1Two442cPTY/GHeLo86cMHqNyW34G7hvZDJQquETWiP4NChH17BLo6x8oE1ldn0zAE3ko33/22XrLA85/1wHCqJopvDdCTzOZH46PbGhFTslfmrRiym0zPZFC8IaTr3qzeT2e4Z384k8xanS11dT5G9FVWZesD/oY3KegnnUr+SGxUPLBeWATU8lSmO1oKpZ5xFQJwMpKxrKyjMamKBf6nVYU8EIGZZ6vwEqOFO/PyXuTpISXdSsHFM5SiS1U3A+6qoubyQg0pJVec4xgXiw3SZQfFD0wbSM6a3OMiyobJDmJwevxJAv5zz3VXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laRYp0AjzlnOtPI+VIIuhkLI9BFmn9x/QkudqF2FOU4=;
 b=kVn4Eh81xI1SAkJKZV4inhzFEx3oUr102lw0UXB4Ch18EM859ARAogsqItsB7NJaMGqhuSdOEEYgwjYs6DDgpUPPSAMly/7rd4kxQ3OiGlkcJD2uLpfnJMC7u/otAQFVp9KoBYRmrGeFH1JqujLVJ9Sn8qNddXApM2b7YOQDL0+dHswTdQJNM8gDjVCnFfEAspEafKA4Poq1pL7ctmcU+is+csQbv847CQlAfiBAOpz0V0wFXN9jDfoBlRhoifhde/ukBW8GfCDZJ9sh4lKzOgJ5EPJRHyDrUjC6rLSOclaO3VWEMgYly8D531HNJdqOxwO7uxgPCRgWLd0DYGXPfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laRYp0AjzlnOtPI+VIIuhkLI9BFmn9x/QkudqF2FOU4=;
 b=h9zSB0JTUsRARIuKjkFAoOCvSGd2WYkVhWg84+vWd1wtWD5Ni6Xp8I5gdZcrcClCv8GgL9psailB3Ht1P4eBIZiwmfWUooXSzBHXqoR7teFywHdjbWC0h4x8ust1ZB5bModNPHE1OnCNwKzzqpIz6IjLi0+y720WeOLhCgSstXRFB9iDTqERa+wPPfzGoS1v5/pHmXBuFx5EdfVqF3s8XGpQ1W/okysm7zBKtoOffF0R+YcRanEijLec0go7XXSiC4gEBYbP1BGESrKE4d8LFfw6tzf1OTOOC8w8jHeOasks0HwC2VQS8IpxkyO7vIsdp4WNK2ZKRWkMlprqpGrb4Q==
Received: from DM5PR19CA0063.namprd19.prod.outlook.com (2603:10b6:3:116::25)
 by DM4PR12MB5892.namprd12.prod.outlook.com (2603:10b6:8:68::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.11; Thu, 10 Feb 2022 06:51:15 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:116:cafe::14) by DM5PR19CA0063.outlook.office365.com
 (2603:10b6:3:116::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Thu, 10 Feb 2022 06:51:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Thu, 10 Feb 2022 06:51:15 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 10 Feb
 2022 06:51:08 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Wed, 9 Feb 2022
 22:51:07 -0800
Received: from mkumard.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Wed, 9 Feb 2022 22:51:04 -0800
From:   Mohan Kumar <mkumard@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <tiwai@suse.com>,
        <jonathanh@nvidia.com>, <spujar@nvidia.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mohan Kumar <mkumard@nvidia.com>
Subject: [PATCH v2 1/6] ALSA: hda/tegra: Add Tegra234 hda driver support
Date:   Thu, 10 Feb 2022 12:20:52 +0530
Message-ID: <20220210065057.13555-2-mkumard@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220210065057.13555-1-mkumard@nvidia.com>
References: <20220210065057.13555-1-mkumard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b03c9f8c-07bc-4476-4522-08d9ec61bbf8
X-MS-TrafficTypeDiagnostic: DM4PR12MB5892:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB58920D56067FA49E7DBA79A5C12F9@DM4PR12MB5892.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 02QskGgAz/XP01gHh8+uAO9aUkBdvgqUGpjGZSGbmijHHl8NsqZvJXJLGTOn3aoROfWCIEDsCdZZxHLgk8wTffdmOC5oVET3uAW0AjzhPAe8e6Y2a7lBV0tEzFK5QLWwib+ZJVLmhzcAu6nGjP+ZqdwuZi6WnWuZCZttL3dhg3KUp0lYnTPDpdl8f01+C4+fAoTyRDY5sCaBpVRYWZNR+lUqe4hW7dn+jva+eqdxyoZ/6O3ZA+XQVLpuRm1xx9FbSWdOY9r8tFk7s94Sv0umndfi4I2O4JDVyAavmtNxzfojL11gw7Xbb0jZYArKtK6b7S23e1C/ZyCvBE1uizva6ba1Beco7/nhWqdvz/5UdrQsVti6Cw6s4RbqLJVsw0PvQoEJVkxXLBVJsfiOroX+tk2y9Vls3XanL48M9Q306HVsVxpB4csB5YPrn3u4ZXPNpyd+neP3mG7vKwUrhUrqgeDlCqUM1d0W9DgDLjcKvojZhvnxjXw0k30Is93Vv2M4+hxo7/IoYlCMhVlyoXZWUMEWXLcbZ8mJbtN9NPE5SjIrM5AbrXNC2bUYHq9VOeCq8V+oUTAehOAT5SS+u8oy4oHXKJ0c5DvvxEwx2aXvhWbkaRoPqxRVBHEvX8gb75C4J6iu9IUs1UbDoQsfYYcIMxAY1Onij6xFQ2xB+44F2JTbfAAzviJsZv33HrwfPiYlkaSdnoplmorltte1PtZDnTWFLWM9IUB/xO6P0hW2dRg=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(110136005)(36756003)(508600001)(316002)(54906003)(6636002)(7696005)(6666004)(40460700003)(2616005)(47076005)(8936002)(2906002)(336012)(426003)(82310400004)(107886003)(83380400001)(26005)(186003)(8676002)(36860700001)(70206006)(356005)(5660300002)(4326008)(1076003)(70586007)(86362001)(81166007)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 06:51:15.6260
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b03c9f8c-07bc-4476-4522-08d9ec61bbf8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5892
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

