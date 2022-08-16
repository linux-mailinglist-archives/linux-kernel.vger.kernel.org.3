Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEF159567E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbiHPJcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbiHPJcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:32:11 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738F2205D4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 00:54:33 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id v4so4253015pgi.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 00:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=Q+2OJPxyAh41VkQNVhVIveQFr71J1YrrJRjA24sZS6s=;
        b=Gr5cK8eokw/wW8HUesUmQvbAMvIqb3T6PNglwlE8uUDGw1OFSrNVzSOuPTB7JPBYPl
         ZrDxIW4BfGbb4vWF7FjuEqhnEt+KLy2hdGz2dbt90MVeo9hrivk3iivUgHcbSUVlFBtv
         agnXviWLUHnTQKZetBQkBjBzM2d9UtvXJd83uM0iXGjlhMX9mKIREF4PfLosmPZxNtTr
         XPnpkEg9f8R98swVFTKVwt+OvX5RKLTKvxHYqhMauzA4+lmiJSG83fdwlI0x4lbda4mj
         tWewh+ubCectSST3toS7g9bKvCIXng0L0OTcaEveLhWt8295/RUXe8k8gqF/fufbBUNV
         cHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Q+2OJPxyAh41VkQNVhVIveQFr71J1YrrJRjA24sZS6s=;
        b=0qJuQFvzF4YYM4IsPw5+kIuKJ3bgLacfMB/hLb7a6jojxP02yeduDi+VJgyhQqKwNG
         VAlrhuqsG8ZLICL8QLpvyjnUn5GMfLRuDp5raNHmrV8hJ6Gb+HTCRwb3h0LdLYCuPuP/
         dHFTUH422F8IkqhD1+XVWOuHmqDmOHUASi2xrPRrVNdR/bwmtlMzA2HxSQ2qNVP8xdpW
         HcZoSitdgkxkYqRIVUKrlybUCmummzmf70n9ixzOK1b2RtTtu9bElxFPmYbrTJtiEq/e
         P/aYJSEUU5+Xi43uJ8oL1+aPNSkTfrIQ2iPLj2M/pq5tUS6TRqDbzbhjuD6uh/uKMNdF
         gbVg==
X-Gm-Message-State: ACgBeo1/BLFds06ViQEAZvuUYFI/YUpZP+FXGv4oAZFYckwiLIgHB2Cs
        xERETrFTirVvaPmLMf1ETKddRg==
X-Google-Smtp-Source: AA6agR6D9B+2I/h+hZSwACo5e4NCzdYEYH/wXIDeXMr84ap6jJDKP8sEYnl6/SNzQqLQnYXdwx+L3A==
X-Received: by 2002:a05:6a00:1a44:b0:528:6af7:ff4a with SMTP id h4-20020a056a001a4400b005286af7ff4amr20222768pfv.78.1660636473521;
        Tue, 16 Aug 2022 00:54:33 -0700 (PDT)
Received: from sean-biuld-server.itotolink.net (1-34-200-211.hinet-ip.hinet.net. [1.34.200.211])
        by smtp.gmail.com with ESMTPSA id d65-20020a621d44000000b0052c7ff2ac74sm8035010pfd.17.2022.08.16.00.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 00:54:33 -0700 (PDT)
From:   Sean Hong <sean.hong@quanta.corp-partner.google.com>
To:     pierre-louis.bossart@linux.intel.com, perex@perex.cz,
        tiwai@suse.com, brent.lu@intel.com
Cc:     cezary.rojewski@intel.com, liam.r.girdwood@linux.intel.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Sean Hong <sean.hong@quanta.corp-partner.google.com>
Subject: [PATCH v2] ASoC: Intel: sof_rt5682: Add support for jsl_rt5682_rt1019
Date:   Tue, 16 Aug 2022 15:54:24 +0800
Message-Id: <20220816075424.1245593-1-sean.hong@quanta.corp-partner.google.com>
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

This patch adds the driver data for rt5682 support jsl_rt5682_rt1019.

Signed-off-by: Sean Hong <sean.hong@quanta.corp-partner.google.com>
---
 sound/soc/intel/boards/sof_rt5682.c               |  9 +++++++++
 sound/soc/intel/common/soc-acpi-intel-jsl-match.c | 12 ++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index 045965312..3a840f3a9 100644
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
index b95c4b2cd..e374bf163 100644
--- a/sound/soc/intel/common/soc-acpi-intel-jsl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-jsl-match.c
@@ -29,6 +29,11 @@ static const struct snd_soc_acpi_codecs rt1015p_spk = {
 	.codecs = {"RTL1015"}
 };
 
+static struct snd_soc_acpi_codecs rt1019p_spk = {
+	.num_codecs = 1,
+	.codecs = {"RTL1019"}
+};
+
 static const struct snd_soc_acpi_codecs mx98360a_spk = {
 	.num_codecs = 1,
 	.codecs = {"MX98360A"}
@@ -78,6 +83,13 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_jsl_machines[] = {
 		.quirk_data = &mx98360a_spk,
 		.sof_tplg_filename = "sof-jsl-rt5682-mx98360a.tplg",
 	},
+	{
+		.comp_ids = &rt5682_rt5682s_hp,
+		.drv_name = "jsl_rt5682_rt1019",
+		.machine_quirk = snd_soc_acpi_codec_list,
+		.quirk_data = &rt1019p_spk,
+		.sof_tplg_filename = "sof-jsl-rt5682-rt1019.tplg",
+	},
 	{
 		.id = "10134242",
 		.drv_name = "jsl_cs4242_mx98360a",
-- 
2.25.1

