Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1ECC4B06A7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 07:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbiBJGvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 01:51:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235599AbiBJGvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 01:51:18 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6D410B8;
        Wed,  9 Feb 2022 22:51:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXHHUgeqkRB1BHqJM5od56q6uo+8jWCq2wgzafS+UctvSsJwvRpFUmCJOH16pmh2RwPAEEG3bMB+u9rs/fFwD+CF99ElRvhhuI0KROMX4u08BbHpTW0UDvgttBr2JzAC6TgW374hUUS5qHYc46tFf+V16U+phD52Wzi/bpmmKDCvFt6qxjyijcdvs5XmtFCLEKCqFOF/shcqIw/r9lkU4Uk3x1h8642b/MumrB/srPz0khUKuV6iY8xUI6x7gmA9An3odQo+P9p6WCdInqRI0bnQOXkT8aOEaJT07/tkiCf89L391P1+2+osJBQWiSA45n9DX+YVSpdLs+Rj9WWY4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XXBHuuCU2aQXvty1QvSm76FHqWPp9E1FmvmSdPCD3Y=;
 b=BFhEDJYoIhpK99mv4EUbGp66tpMOCzzekJUxUyXfkWW44zYakHTAZHOjAQi0T+d/GUE7mx3eU8N/l9ubGNmzSCdlstT8fRg5h5Fi0Ug8bMS2BFq2fJGkAQ1q5xdkvIo5u1ZeykCpa32sCsHXCAcXNpCI3xuQsLwnNL5Xu/H8CotQa7NnZUaQSfejDoUyh0CBiXrNygbbP7/jkM1lMFP1laAqpTJOI1Z/RWP332BJtvjnDghobshATEurdMtlx6pSnGAr9UVODnUvG39IchSs/1yvHswqjzBZARUWAH7xElzDKZY+xp+pNbCdMn+Atihpq05Tx39IX0s2hBnyLLTomA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XXBHuuCU2aQXvty1QvSm76FHqWPp9E1FmvmSdPCD3Y=;
 b=uVTmwhM8WomuTQhYaXNQcg9Jiivi0RmSkiqrFRWXMPeI4iV2Zm7kwEDkTZ5fCXXX1yyWfatjWe15VCeNMwa6dH7DVMKHHtSgDvatXUejjkHMK0uzSq+2gCaAICC99NpEwW+txvk/pDF/59asi/fzHz0BZDGek7TX1D967oIJUbMeJCUvSSbPXCV7DCStajOtIj3wJwVyNJQwshwPEMRNF7lOBtFImsmqfQiLlqAd3f8VUCr9cHxp25sbYI8wwjU5g40gsS1/8hiAh49U4jzkGWqZgRI32/nnQ+BBxdyvai6oqYhNTUVt84M2qmjyFH8PVyLHiLPiaKNOlLtIcUmrSQ==
Received: from MWHPR04CA0065.namprd04.prod.outlook.com (2603:10b6:300:6c::27)
 by CY4PR12MB1670.namprd12.prod.outlook.com (2603:10b6:910:4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Thu, 10 Feb
 2022 06:51:17 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:6c:cafe::c0) by MWHPR04CA0065.outlook.office365.com
 (2603:10b6:300:6c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Thu, 10 Feb 2022 06:51:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Thu, 10 Feb 2022 06:51:17 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 10 Feb
 2022 06:51:16 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Wed, 9 Feb 2022
 22:51:15 -0800
Received: from mkumard.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Wed, 9 Feb 2022 22:51:12 -0800
From:   Mohan Kumar <mkumard@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <tiwai@suse.com>,
        <jonathanh@nvidia.com>, <spujar@nvidia.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mohan Kumar <mkumard@nvidia.com>
Subject: [PATCH v2 3/6] ALSA: hda/tegra: Update scratch reg. communication
Date:   Thu, 10 Feb 2022 12:20:54 +0530
Message-ID: <20220210065057.13555-4-mkumard@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220210065057.13555-1-mkumard@nvidia.com>
References: <20220210065057.13555-1-mkumard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87dd84aa-bb64-4aa9-5731-08d9ec61bcee
X-MS-TrafficTypeDiagnostic: CY4PR12MB1670:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB167073507FFF08C4664EB58DC12F9@CY4PR12MB1670.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2kLK51b4pE/jUKj6otRn3SxuSs3w3DIAAypoxGVvvN90AehiV5BMLXOAhqLZ400akRPdF5XuY15prr/iLcSNexgify4TKyGxXwcdqMMYi3pg6Sxa2AwudmSA6eBTLCO71C3CJRjWK3DLHw7aVw+sVivFyccoDSphaSVY7FvVoN6sTdThbRsrpbD/hBkZuDFVZo4SyF1aj/CWqWkTXEZ8kKUZvCJPggIAtZ8hSVreWFotnEl2jvN2ldLZp83C+dNoriNbAz0U0ulIYMj/yAg8V9DHCWBqbt9uWpFVQ4gGVaK60TH5Wx3ZKVK+03ZsGAVCS101ky3YhAYETdaCo8jDAv+Ms08CCovby9EME7CmExHyZ4Urud8gop6xU4ZKwUBip8fpbEHZ+c0U0u04gsa1E4kuGrpoSFswXLBHE4QkY8ghl9CKSQ4Uz//1capdHLJubjgKsjNLqQhwsyldj+J1Qva0LgYT/KX1HqKMysxtUbuCHt7XhtjXauyonahPRXz7ZGbdYM5nliO2OX0HLScoH/g5O3TA+SEYVs7zTEuoFaGhRg3urL5cMSrOYevTIF/yuT/dppyMKsnbuMQtsKMgP1DFm2Y3twfuu7hbQjm1HNxmXRiYdnKNcm8nPvH+Xmv3bIEmoBqANlakik1Trd1HCUqtICxwJam6zklemyOHd2s0Pbnm/bygsCF7jo/J0Tu6p/nsW5itDG5eaNwHG0K4CHUcoxFqUIR8okUtsOaWz34=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(186003)(316002)(70206006)(6666004)(54906003)(6636002)(82310400004)(8936002)(36756003)(110136005)(2616005)(107886003)(1076003)(26005)(426003)(4326008)(83380400001)(70586007)(8676002)(336012)(47076005)(40460700003)(15650500001)(7696005)(86362001)(356005)(5660300002)(508600001)(2906002)(81166007)(36860700001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 06:51:17.4417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87dd84aa-bb64-4aa9-5731-08d9ec61bcee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1670
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra234 chip scratch register communication between audio
and hdmi driver differs slightly in the way it triggers the
interrupt compared to legacy chips. Interrupt is triggered
by writing non-zero values to verb 0xF80 instead of 31st bit
of scratch register.

DP MST support changed the NID to be used for scratch register
read/write from audio function group NID to Converter widget NID.

Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
---
 sound/pci/hda/patch_hdmi.c | 64 ++++++++++++++++++++++++++++----------
 1 file changed, 48 insertions(+), 16 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 879f886d2406..2eebb302a7bd 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -162,6 +162,8 @@ struct hdmi_spec {
 	bool dyn_pin_out;
 	bool dyn_pcm_assign;
 	bool dyn_pcm_no_legacy;
+	/* hdmi interrupt trigger control flag for Nvidia codec */
+	bool hdmi_intr_trig_ctrl;
 	bool intel_hsw_fixup;	/* apply Intel platform-specific fixups */
 	/*
 	 * Non-generic VIA/NVIDIA specific
@@ -3721,8 +3723,11 @@ static int patch_nvhdmi_legacy(struct hda_codec *codec)
  * +-----------------------------------|
  *
  * Note that for the trigger bit to take effect it needs to change value
- * (i.e. it needs to be toggled).
+ * (i.e. it needs to be toggled). The trigger bit is not applicable from
+ * TEGRA234 chip onwards, as new verb id 0xf80 will be used for interrupt
+ * trigger to hdmi.
  */
+#define NVIDIA_SET_HOST_INTR		0xf80
 #define NVIDIA_GET_SCRATCH0		0xfa6
 #define NVIDIA_SET_SCRATCH0_BYTE0	0xfa7
 #define NVIDIA_SET_SCRATCH0_BYTE1	0xfa8
@@ -3741,25 +3746,38 @@ static int patch_nvhdmi_legacy(struct hda_codec *codec)
  * The format parameter is the HDA audio format (see AC_FMT_*). If set to 0,
  * the format is invalidated so that the HDMI codec can be disabled.
  */
-static void tegra_hdmi_set_format(struct hda_codec *codec, unsigned int format)
+static void tegra_hdmi_set_format(struct hda_codec *codec,
+				  hda_nid_t cvt_nid,
+				  unsigned int format)
 {
 	unsigned int value;
+	unsigned int nid = NVIDIA_AFG_NID;
+	struct hdmi_spec *spec = codec->spec;
+
+	/*
+	 * Tegra HDA codec design from TEGRA234 chip onwards support DP MST.
+	 * This resulted in moving scratch registers from audio function
+	 * group to converter widget context. So CVT NID should be used for
+	 * scratch register read/write for DP MST supported Tegra HDA codec.
+	 */
+	if (codec->dp_mst)
+		nid = cvt_nid;
 
 	/* bits [31:30] contain the trigger and valid bits */
-	value = snd_hda_codec_read(codec, NVIDIA_AFG_NID, 0,
+	value = snd_hda_codec_read(codec, nid, 0,
 				   NVIDIA_GET_SCRATCH0, 0);
 	value = (value >> 24) & 0xff;
 
 	/* bits [15:0] are used to store the HDA format */
-	snd_hda_codec_write(codec, NVIDIA_AFG_NID, 0,
+	snd_hda_codec_write(codec, nid, 0,
 			    NVIDIA_SET_SCRATCH0_BYTE0,
 			    (format >> 0) & 0xff);
-	snd_hda_codec_write(codec, NVIDIA_AFG_NID, 0,
+	snd_hda_codec_write(codec, nid, 0,
 			    NVIDIA_SET_SCRATCH0_BYTE1,
 			    (format >> 8) & 0xff);
 
 	/* bits [16:24] are unused */
-	snd_hda_codec_write(codec, NVIDIA_AFG_NID, 0,
+	snd_hda_codec_write(codec, nid, 0,
 			    NVIDIA_SET_SCRATCH0_BYTE2, 0);
 
 	/*
@@ -3771,15 +3789,28 @@ static void tegra_hdmi_set_format(struct hda_codec *codec, unsigned int format)
 	else
 		value |= NVIDIA_SCRATCH_VALID;
 
-	/*
-	 * Whenever the trigger bit is toggled, an interrupt is raised in the
-	 * HDMI codec. The HDMI driver will use that as trigger to update its
-	 * configuration.
-	 */
-	value ^= NVIDIA_SCRATCH_TRIGGER;
+	if (spec->hdmi_intr_trig_ctrl) {
+		/*
+		 * For Tegra HDA Codec design from TEGRA234 onwards, the
+		 * Interrupt to hdmi driver is triggered by writing
+		 * non-zero values to verb 0xF80 instead of 31st bit of
+		 * scratch register.
+		 */
+		snd_hda_codec_write(codec, nid, 0,
+				NVIDIA_SET_SCRATCH0_BYTE3, value);
+		snd_hda_codec_write(codec, nid, 0,
+				NVIDIA_SET_HOST_INTR, 0x1);
+	} else {
+		/*
+		 * Whenever the 31st trigger bit is toggled, an interrupt is raised
+		 * in the HDMI codec. The HDMI driver will use that as trigger
+		 * to update its configuration.
+		 */
+		value ^= NVIDIA_SCRATCH_TRIGGER;
 
-	snd_hda_codec_write(codec, NVIDIA_AFG_NID, 0,
-			    NVIDIA_SET_SCRATCH0_BYTE3, value);
+		snd_hda_codec_write(codec, nid, 0,
+				NVIDIA_SET_SCRATCH0_BYTE3, value);
+	}
 }
 
 static int tegra_hdmi_pcm_prepare(struct hda_pcm_stream *hinfo,
@@ -3796,7 +3827,7 @@ static int tegra_hdmi_pcm_prepare(struct hda_pcm_stream *hinfo,
 		return err;
 
 	/* notify the HDMI codec of the format change */
-	tegra_hdmi_set_format(codec, format);
+	tegra_hdmi_set_format(codec, hinfo->nid, format);
 
 	return 0;
 }
@@ -3806,7 +3837,7 @@ static int tegra_hdmi_pcm_cleanup(struct hda_pcm_stream *hinfo,
 				  struct snd_pcm_substream *substream)
 {
 	/* invalidate the format in the HDMI codec */
-	tegra_hdmi_set_format(codec, 0);
+	tegra_hdmi_set_format(codec, hinfo->nid, 0);
 
 	return generic_hdmi_playback_pcm_cleanup(hinfo, codec, substream);
 }
@@ -3906,6 +3937,7 @@ static int patch_tegra234_hdmi(struct hda_codec *codec)
 	spec = codec->spec;
 	spec->dyn_pin_out = true;
 	spec->dyn_pcm_assign = true;
+	spec->hdmi_intr_trig_ctrl = true;
 
 	return tegra_hdmi_init(codec);
 }
-- 
2.17.1

