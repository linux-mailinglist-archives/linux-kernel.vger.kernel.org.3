Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58965591057
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 13:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237535AbiHLLsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 07:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235923AbiHLLsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 07:48:15 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22C1AFAE2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 04:48:12 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id e8-20020a17090a280800b001f2fef7886eso679196pjd.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 04:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=1WPdo9M+Sx6XTbFXOZ/AtUfevOxtbqvZ35Od/wJosKk=;
        b=z7o6YDD1kXTK8o/DG7hkIWs3Z8hy7Yo6SjbLpSvIWfUN4EG+Ch1bZ3ZBpz6v7RBpud
         y36XNext6pDcS1uCMdAZqOzQxBc9V1FfdE7xmc6CIonPd1wxpgRn2GSZMY/IUbblmFZ4
         6E+y+Z5m71GgwfbcNAB42ohiR5R5VoFRgJ8Nn1EPz1NOMpww7sJi8q182alt/1Ql2Ik1
         VGOme+UfJy4285EOw2UvJkVBeOvhcGF4EOQucHIjQlQPxUtotN6BctQaVa6WdfLShiHD
         qmzgFgOGBzNT4F2yPczyhmDuye8ZkLRgeKYTLLiPYFyY3Y1EyRmPmuB2F9bj7C1UiBoK
         2fvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=1WPdo9M+Sx6XTbFXOZ/AtUfevOxtbqvZ35Od/wJosKk=;
        b=WYNB0bJpUk4HB5Lz/4hiXxJDxSp3qSd3/+pu6QZ7T5jv51nXTVBKZsfLHNzM/o+Qxg
         hIDNnxRYgv3tRgHs3yvWwj+3qKCWIvJMukGJyNjDoejeBUUMWexT0baLXW8G58k6YxJY
         HP2wKR800lBOGrOhNPQbnPLnR78zUK5tblSWpQ/MTo4dIZ1AhlNKXFUIozajCD8WMAwB
         SL4cGo4tyJtX1thpG0QkHTJAe4MrdrxOxLQUxydcOtOwK8V34WJge8Nr/n2zqmYyIhgV
         zavuD9IRZPoDVB4lRu7Nkb7jvUKOsryewbflJSbO61izFD8FrwccKablZ7SIf69FhBgo
         Frtw==
X-Gm-Message-State: ACgBeo3JMckxvxSOEStC8g1+7/kBi44rwwb9mo1OkDA9yNk/SyBAAZa6
        HVeMhq8Y2V4teQCFobfNMmwFFw==
X-Google-Smtp-Source: AA6agR7d1ezsS3nvkyhQ1bVhlUpxExz65NeFOzJabTp4+B2vJE68BRef/AbGYGLCukUi5Cc1rnwPrA==
X-Received: by 2002:a17:90b:394:b0:1f5:90a1:acf0 with SMTP id ga20-20020a17090b039400b001f590a1acf0mr13458944pjb.40.1660304892505;
        Fri, 12 Aug 2022 04:48:12 -0700 (PDT)
Received: from sean-biuld-server.itotolink.net (1-34-200-211.hinet-ip.hinet.net. [1.34.200.211])
        by smtp.gmail.com with ESMTPSA id z6-20020a1709027e8600b0016d7afee272sm1499378pla.153.2022.08.12.04.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 04:48:12 -0700 (PDT)
From:   Sean Hong <sean.hong@quanta.corp-partner.google.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     cezary.rojewski@intel.com, pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, peter.ujfalusi@linux.intel.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, broonie@kernel.org,
        brent.lu@intel.com, yong.zhi@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Sean Hong <sean.hong@quanta.corp-partner.google.com>
Subject: [PATCH] ASoC: Intel: sof_rt5682: Add support for jsl_rt5682_rt1019
Date:   Fri, 12 Aug 2022 19:48:04 +0800
Message-Id: <20220812114804.550809-1-sean.hong@quanta.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the driver data for rt5682s on SSP0 for ADL platform

Signed-off-by: Sean Hong <sean.hong@quanta.corp-partner.google.com>
---
 sound/soc/intel/boards/sof_rt5682.c               |  9 +++++++++
 sound/soc/intel/common/soc-acpi-intel-jsl-match.c | 13 +++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index 045965312245b..3a840f3a9f5d2 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -1100,6 +1100,15 @@ static const struct platform_device_id board_ids[] = {
 					SOF_RT5682_SSP_AMP(1) |
 					SOF_RT5682_NUM_HDMIDEV(4)),
 	},
+	{
+		.name = "jsl_rt5682_rt1019",
+		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
+					SOF_RT5682_MCLK_24MHZ |
+					SOF_RT5682_SSP_CODEC(0) |
+					SOF_SPEAKER_AMP_PRESENT |
+					SOF_RT1019_SPEAKER_AMP_PRESENT |
+					SOF_RT5682_SSP_AMP(1)),
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, board_ids);
diff --git a/sound/soc/intel/common/soc-acpi-intel-jsl-match.c b/sound/soc/intel/common/soc-acpi-intel-jsl-match.c
index b95c4b2cda947..139d2468f5f70 100644
--- a/sound/soc/intel/common/soc-acpi-intel-jsl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-jsl-match.c
@@ -29,6 +29,11 @@ static const struct snd_soc_acpi_codecs rt1015p_spk = {
 	.codecs = {"RTL1015"}
 };
 
+static struct snd_soc_acpi_codecs rt1019p_spk = {
+	.num_codecs = 1,
+	.codecs = {"RTL1019"}
+}
+
 static const struct snd_soc_acpi_codecs mx98360a_spk = {
 	.num_codecs = 1,
 	.codecs = {"MX98360A"}
@@ -78,6 +83,14 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_jsl_machines[] = {
 		.quirk_data = &mx98360a_spk,
 		.sof_tplg_filename = "sof-jsl-rt5682-mx98360a.tplg",
 	},
+	{
+		.comp_ids = &rt5682_rt5682s_hp,
+		.drv_name = "jsl_rt5682_rt1019",
+		.sof_fw_filename = "sof-jsl.ri",
+		.machine_quirk = snd_soc_acpi_codec_list,
+		.quirk_data = &rt1019p_spk,
+		.sof_tplg_filename = "sof-jsl-rt5682-rt1015.tplg",
+	},
 	{
 		.id = "10134242",
 		.drv_name = "jsl_cs4242_mx98360a",
-- 
2.25.1

