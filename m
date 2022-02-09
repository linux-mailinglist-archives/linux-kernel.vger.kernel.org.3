Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABBE4AE8DB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 06:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242747AbiBIFIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 00:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377704AbiBIEcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 23:32:03 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7B9C0612A4;
        Tue,  8 Feb 2022 20:24:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JzT8U6014ZPPIHFNms+GrFO2W4mPLbfv/KN+UmKVYMg3EyMGaZtDm7hqhQl9xOaQYAM897+q6Iq10ddc8Jt+fMGkJGEJ9hMEtYbZ49fkCzq2M0r8ImL7QWRT6JSn1GuU1+HjpqlyaECttkflNbfXQgOqq2P6CJQgtRNjERS3aixo4yQPeER4hhKwNZCnRM7QREbi//e4ZCuXxHsnGFu0hQRBCzEhcSGi2XhXL/sRzfP/l8+bZZH4ESrXdo3Ydn5oYgdQEVabNgls/B+QfgkEBko1wdmmkea03sF3dvGv2nA9L03qJIQhaBTt0wNf1NrUH8fPdGnB6zd1L6ExopHNhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ii7EdkTSEf4L9/vhdjfXV7XMODifvwEHdNeewlWZVZ4=;
 b=FkM1tslY+0DzRDPC7zpFocPMTAQJ/QXlWogKg6U5w/VKsRl1TGRg4L6h4ICc9A+MuQ2rbk9fA5UQ0NbPkGNitVnZk6WujzKI87b87FRvu0n+7tNo3W5ZBHNsMEWHRdSi9VDA+aSnTkd0aDW+4lXvHbsPdDoxTmxNSbN/vg4X6OVZPRDzhut6getiX19RBKpIqjIDIeWUKNH2RzMqmfTr0vXXYXre9FBL8f9CkXX8YzH+G/q/OY+VA9RJS0GkQT13stbAuUWslhbMDHoRzvEbTymPjJInRX0HbtwlBzhWOFMnmKZMaH/S5taYGQgMd8flvYifESQenR/veiERWljUOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ii7EdkTSEf4L9/vhdjfXV7XMODifvwEHdNeewlWZVZ4=;
 b=MsBux3tV0x/VNyj0+NAAtdRxkevoeumTP+gAeWamlF7zdQenQihXkhNa+4eTZAXmWi3XztLzibYdbqHmF/qT6buxy0xX84KqVy3IhdV7KVNAkRvjVjwo1ztEbDpBBGraWP+Hhrb3ydFLtQQXUXE4SC/fShLQQT6rW1B3yOqo9oAOf9Ar/FzPN5D7xNY9MybPuIU0eP8Z9RR7Og+60F9VUAR5Y7IqhnDp8r1Zl84Gv3oMaZDljjcN9cMdtjE4vouep6pDiMrU282+4BQCSezzQkOpg5UlpHTDF6YojVTgjHw4ex/U7nW6O+nbSN40zBimwF7VLohKZcIiP6VOdzvZ5g==
Received: from MWHPR17CA0065.namprd17.prod.outlook.com (2603:10b6:300:93::27)
 by BL1PR12MB5240.namprd12.prod.outlook.com (2603:10b6:208:319::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 04:24:04 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:93:cafe::34) by MWHPR17CA0065.outlook.office365.com
 (2603:10b6:300:93::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Wed, 9 Feb 2022 04:24:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 04:24:03 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 9 Feb
 2022 04:24:02 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 8 Feb 2022
 20:24:02 -0800
Received: from mkumard.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Tue, 8 Feb 2022 20:23:58 -0800
From:   Mohan Kumar <mkumard@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <tiwai@suse.com>,
        <jonathanh@nvidia.com>, <spujar@nvidia.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mohan Kumar <mkumard@nvidia.com>
Subject: [PATCH v1 3/6] ALSA: hda/tegra: Update scratch reg. communication
Date:   Wed, 9 Feb 2022 09:53:23 +0530
Message-ID: <20220209042326.15764-4-mkumard@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220209042326.15764-1-mkumard@nvidia.com>
References: <20220209042326.15764-1-mkumard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c53c494f-caee-4a55-64bf-08d9eb840109
X-MS-TrafficTypeDiagnostic: BL1PR12MB5240:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5240B8DBCD7DA989E71DE19DC12E9@BL1PR12MB5240.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OfyR2YtuUfO9LOK25CxSnnuGshSmUG3BlzG4vKq2tk0F9EfWF0shGjZqfZqih2C+2iolXODP6nVfJ0VXUpI6PIK/E9r87lciTh5tS2/kzeonrR37ohmb4Hyp8k/G3rFTcGwGxQ3MKVve4NehEoJldrZ0RnlG60HAc47OU001223M+z0rMLHeeHNTSKlG3CxIA/ZEPI0WaE+yckISpZ6NtEXYv9tgUTSRsWjy/ZwlzghSKweNRGgbIKuTZsUynUliOZDiY7Yv9IqKSVR7sE3hAVHHFHsbXxkR7HoT6Z2r2CdZuBFSQOPgIlpAZ0qWEy3OIcIQQXOk4Utd1SnwU1BwtP4yy4JYWBMOhoEWXA3pcPV7/+9CZ9Ie1M1FiWeofReq3MXpUp06+c79utlkKxW3xR/YMfq+ZqsLbQm4kkipAARzlOc4J7zur5U3P/yiz31ttHFEQz5yZobvQzw695qB0Edv6UYMBsBngE6wE5PoeH2Ct8D/9ndAfbGbui0piDGemnzDss0NLHDrNC066MLM6Dc/973zZ9luaJCFSRFU+SJyQqkF2/duyT2DbzUoSiO9xlH7WgLF/yeaPPZwF+5tVGo4Ice2fHb8LJ+ULnMM6n9XOCuqaYepltup3h5nsrfXlAI7W2k6OKBh/Y1dXPmB9aw4j9FCcVL5PZyCtTFhQXbfSyx3BPCq5nBZgFz0lKx9NwedVTbkNWJe9uZAWaTV1+HKKqnvgS5SAlPuzrlvWVI=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(8676002)(4326008)(356005)(8936002)(81166007)(36860700001)(2616005)(70586007)(7696005)(5660300002)(15650500001)(107886003)(1076003)(47076005)(26005)(186003)(70206006)(6666004)(508600001)(2906002)(36756003)(54906003)(110136005)(6636002)(316002)(40460700003)(336012)(426003)(83380400001)(86362001)(82310400004)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 04:24:03.4145
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c53c494f-caee-4a55-64bf-08d9eb840109
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5240
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
 include/sound/hda_codec.h  |  4 +++
 sound/pci/hda/patch_hdmi.c | 61 ++++++++++++++++++++++++++++----------
 2 files changed, 49 insertions(+), 16 deletions(-)

diff --git a/include/sound/hda_codec.h b/include/sound/hda_codec.h
index 82d9daa17851..c1c19dd4c423 100644
--- a/include/sound/hda_codec.h
+++ b/include/sound/hda_codec.h
@@ -240,6 +240,10 @@ struct hda_codec {
 	unsigned int single_adc_amp:1; /* adc in-amp takes no index
 					* (e.g. CX20549 codec)
 					*/
+	unsigned int hdmi_intr_trig_ctrl:1; /* hdmi interrupt trigger
+					     * control flag
+					     * (e.g. Nvidia codecs)
+					     */
 	unsigned int no_sticky_stream:1; /* no sticky-PCM stream assignment */
 	unsigned int pins_shutup:1;	/* pins are shut up */
 	unsigned int no_trigger_sense:1; /* don't trigger at pin-sensing */
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 879f886d2406..f0e87e39c53e 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -3721,8 +3721,11 @@ static int patch_nvhdmi_legacy(struct hda_codec *codec)
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
@@ -3741,25 +3744,37 @@ static int patch_nvhdmi_legacy(struct hda_codec *codec)
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
@@ -3771,15 +3786,28 @@ static void tegra_hdmi_set_format(struct hda_codec *codec, unsigned int format)
 	else
 		value |= NVIDIA_SCRATCH_VALID;
 
-	/*
-	 * Whenever the trigger bit is toggled, an interrupt is raised in the
-	 * HDMI codec. The HDMI driver will use that as trigger to update its
-	 * configuration.
-	 */
-	value ^= NVIDIA_SCRATCH_TRIGGER;
+	if (codec->hdmi_intr_trig_ctrl) {
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
@@ -3796,7 +3824,7 @@ static int tegra_hdmi_pcm_prepare(struct hda_pcm_stream *hinfo,
 		return err;
 
 	/* notify the HDMI codec of the format change */
-	tegra_hdmi_set_format(codec, format);
+	tegra_hdmi_set_format(codec, hinfo->nid, format);
 
 	return 0;
 }
@@ -3806,7 +3834,7 @@ static int tegra_hdmi_pcm_cleanup(struct hda_pcm_stream *hinfo,
 				  struct snd_pcm_substream *substream)
 {
 	/* invalidate the format in the HDMI codec */
-	tegra_hdmi_set_format(codec, 0);
+	tegra_hdmi_set_format(codec, hinfo->nid, 0);
 
 	return generic_hdmi_playback_pcm_cleanup(hinfo, codec, substream);
 }
@@ -3903,6 +3931,7 @@ static int patch_tegra234_hdmi(struct hda_codec *codec)
 
 	codec->dp_mst = true;
 	codec->mst_no_extra_pcms = true;
+	codec->hdmi_intr_trig_ctrl = true;
 	spec = codec->spec;
 	spec->dyn_pin_out = true;
 	spec->dyn_pcm_assign = true;
-- 
2.17.1

