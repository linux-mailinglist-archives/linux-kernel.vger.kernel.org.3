Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18AB54B841F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 10:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbiBPJX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 04:23:27 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbiBPJXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 04:23:24 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B398172880;
        Wed, 16 Feb 2022 01:23:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Poc8qXmWOp1MiacRzQYeGdmDA8JiAUP+PfBxHPxcnbcdYiKRIFae1RfwJxtgbXlhKuJCo3GPDdWrApvuNRVf6z7bPp+KTao8k9ZIYm0Ip9wtJqG0C1eJHpvj11tSDcLo+LHs3sITL79TMCprZXBYQ9ZG/Bf7VVlu4Sc/Z+wOtOBipHyenr1TF5WbtwmhZ7cRisgI2uyAYmwknWlW+RtucdT8XmTTDVHyDvGev+MuMjwM6ujPLryiMPi6uie3Is+jiFjaJfykN5WPgknRhoBQE1/rG5nIyn//LcnTECtfsU+jI4eMe2AQa/YcoNM5wES/vVzuzJJq1H/ZRvHLwjqYbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pII77mO3Io6u+knTTwfUZLXGz6wFEgNfioZ26By5kI=;
 b=lthrWWA5/sVOXEl09RFhGuFxgNyYyu5KgjERojrBtfO9JfLXeV2uQyQNr13AiD64AE6JawtMBkHFIj3NYsVgeUDuUZi96QW+PHwXc6O+8wR57QnZDob2Oof4V8o8bfXjtCdUzkTp65ovedYs4eTVDDvmcE9zEYajtsBBRtaEHte6qlVv5Mp4kr658HzE4iR61OuNXjdwqjGnDT3TnTYZEEia5XaRm2/KPtRcJrA6U21EFaplgoOj7eBQ+F2Pp6hEkn1JYhsJ1EGeWjaR7EnFU7wjSNuuTjolEf5ZtNsV+Rn3QKn0b55YxwbNKO0XQQiTYJzqsTF8n9tx2QTEohW2XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pII77mO3Io6u+knTTwfUZLXGz6wFEgNfioZ26By5kI=;
 b=Izdp4XAcXSA2G9a3jzOTYPqjD0sW9YYKpQUbHYpr0OSMxKDsD5Usid8CM1ny9k7SovJtcRyzD71V3OD5rGoU1BimaAmsxGbFcxK2EyokAl+I8rcMTch1Z+uy5jrCIm4uZnD037qqxXH8TyR6xqOyZrjBqY09j2hVCJFwNBwZOk57MpsMGzBmcV/Q81wBbx1O+v05Bq1loAVFnL88oKvSS+rtqpDCeJQMc+ST4H2oZVZuAbJWmLjtXN4uZwQPRvFicFTaUyqCat2toxqVN23n7euJLimytXpne5r6DG/98XrJUqA3MfXdKXwewvz3K6t8hZ/jbV5iRQcP9LNwsxyC8Q==
Received: from MW4P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::12)
 by DM4PR12MB5214.namprd12.prod.outlook.com (2603:10b6:5:395::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Wed, 16 Feb
 2022 09:23:05 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::ea) by MW4P221CA0007.outlook.office365.com
 (2603:10b6:303:8b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Wed, 16 Feb 2022 09:23:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Wed, 16 Feb 2022 09:23:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 16 Feb
 2022 09:22:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Wed, 16 Feb 2022
 01:22:57 -0800
Received: from mkumard.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Wed, 16 Feb 2022 01:22:54 -0800
From:   Mohan Kumar <mkumard@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <thierry.reding@gmail.com>, <tiwai@suse.com>,
        <jonathanh@nvidia.com>, <spujar@nvidia.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mohan Kumar <mkumard@nvidia.com>
Subject: [PATCH v3 3/6] ALSA: hda/tegra: Update scratch reg. communication
Date:   Wed, 16 Feb 2022 14:52:37 +0530
Message-ID: <20220216092240.26464-4-mkumard@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220216092240.26464-1-mkumard@nvidia.com>
References: <20220216092240.26464-1-mkumard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 146f2c94-3958-4b9e-1a44-08d9f12df012
X-MS-TrafficTypeDiagnostic: DM4PR12MB5214:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB52142212C1D753C3DB94D764C1359@DM4PR12MB5214.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: matW39eIM6oBjPeot1Q8NGzKCJU2OPuMQd0zQ0xVw8ejk4hefgBSkBogpMw36Y4SKj6yylLAWu4fc0yGyiYZU7YNnr8OufXNqwkLaMmMZfs3BI9LWZ8e4FdkHXx06BtRnR/gdqYcSKCoFAgNEru/J1zakZmnSgOnt4nnL+CDM3/4uXmFGVFDu7oY3usPk3S1xFT2VOb0ILKltrlM5mjUIJ0XAIWTO7GmvlEcceajnMBBcUFND4LK+R4JjzeKTydwaD9VyWjaoYFGzOAwA0pOtYXlQyMcouvMwUvNE6TcXQKbpDUdi9JcqS3lrF9rcJRW1s1q3hKiIKCMM0Ypze/oOKuCrcj9/GfDfQQisVQVZRgs8biliuTaE1EZqsbGFuGgzKWF9GmDRlf+scrsAnUjmR6lnh88q93ihDhv3Hsma1Kq65Sr/30fVD+mlHYdytzZSgfJqL0ywONBhOrjztBqP1BZg0XcL90oPgPktyEg1BACyxYAIp1N+HgCnW1mC1LSppS6i+yGRjLvhAoS8J/cxMEaA5gpjRy2t+EoX22Z3+ZRgU7pukZ3yTsCxkq2HP5tP7H7S7ahDzxZUUdoofqYDUVjd+ENSDlLyHsv7ANdx7kDGKq6R+zOwu2rsGFS9gyGrC3g4ONIIetvIRv0JiDE58pQMf2ukX0xxMLfScpI17AluIJ0M1z1XrDyAanEuxsSBuRHmLCyV7cd+YugaNQs1kHGd3Zwv0wdM4jz3CA3z38=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(82310400004)(4326008)(81166007)(70206006)(107886003)(15650500001)(356005)(7696005)(86362001)(508600001)(5660300002)(336012)(426003)(2616005)(83380400001)(8676002)(186003)(26005)(70586007)(36756003)(6666004)(110136005)(36860700001)(6636002)(8936002)(2906002)(316002)(54906003)(40460700003)(47076005)(1076003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 09:23:05.2082
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 146f2c94-3958-4b9e-1a44-08d9f12df012
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5214
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 0adda9b9ba3e..8e513cc4aefd 100644
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

