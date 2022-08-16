Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773805954E1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 10:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbiHPIVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 04:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbiHPIUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 04:20:42 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9085A4A11B
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 23:04:46 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id bh13so8410443pgb.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 23:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=Q+2OJPxyAh41VkQNVhVIveQFr71J1YrrJRjA24sZS6s=;
        b=LBtmGVtAw3vAkbdCYeYLO7DRihAkgZRYcRd+blZGRm7YNgcVdGNaxzsz3tOGMGs32z
         BC12FPIjoEAGufi88HkburDDZtqbZNXGrDrOwsE/OpEi2PnDk0ugeNCLN+hlAr8sr+TZ
         nzHA8XUAl7nVN1GWflmzYtK05v0KsbuVtENxYSxGtQrJ0O2JToqqTZ9RRoVNBwIYjtGm
         VW1sTXpJZgJX84bCStEfQ62b1UyvK2gi91lKgHqc3BuhkBu7gYKZ2rViKSanruavuQa/
         EHq0kWM2U1B7bLN+ozHDJhKY01MKaO+88bBomsHgX80iXcoH1bz3sO3JYhjM02oCADTS
         r5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Q+2OJPxyAh41VkQNVhVIveQFr71J1YrrJRjA24sZS6s=;
        b=QmYSoX9Rjrxegq0kHRHLzAeVIi/bis2oXXUU2ZmHv7VQo8N0dhfywZnAjHn2UI+pGi
         ev2hFWssModD6vpA9y6i5hKw9SrSMKXVy14GxI3quO0WD/qLl86khEb5iwEpzIM190VN
         7vu8cUFNW4fQu1hFCW39sOy3BnQrPOM9L7g81Mwv5AEjeroNA83gJms2e4YafzPS7Tz8
         GaVp0KpOFccOiuLC+V/j6B1IStMZ+wV2F5f4pDG/dHKBl12ftbjvCknBgbwd0fFTxGgF
         bNYJlNuqlpizboDKo/m273AI6lUYjlFqaPLvECxd7DHrXxpKQDBbNSelRJtdRr6/Zb11
         xNdg==
X-Gm-Message-State: ACgBeo3T7n49cddnbpsEpyxHz5RZQXfuowEqAQtGeBCYI6ZUrBhPqINP
        ONJvP1/QxBDfEh9EVGmI9TyCZQ==
X-Google-Smtp-Source: AA6agR5dfOx1zMXF/vjwOZNL/T/IdfH4UimFNyngVvdR9B5C+3FuWTaFVAoB9PRN48Uyqdcm8ZDYLA==
X-Received: by 2002:a63:8b44:0:b0:41c:df4c:7275 with SMTP id j65-20020a638b44000000b0041cdf4c7275mr17003557pge.434.1660629886100;
        Mon, 15 Aug 2022 23:04:46 -0700 (PDT)
Received: from sean-biuld-server.itotolink.net (1-34-200-211.hinet-ip.hinet.net. [1.34.200.211])
        by smtp.gmail.com with ESMTPSA id r23-20020a170902be1700b001714e7608fdsm7994549pls.256.2022.08.15.23.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 23:04:45 -0700 (PDT)
From:   Sean Hong <sean.hong@quanta.corp-partner.google.com>
To:     pierre-louis.bossart@linux.intel.com, perex@perex.cz,
        tiwai@suse.com, brent.lu@intel.com
Cc:     cezary.rojewski@intel.com, liam.r.girdwood@linux.intel.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Sean Hong <sean.hong@quanta.corp-partner.google.com>
Subject: [PATCH] ASoC: Intel: sof_rt5682: Add support for jsl_rt5682_rt1019
Date:   Tue, 16 Aug 2022 14:04:37 +0800
Message-Id: <20220816060437.1115039-1-sean.hong@quanta.corp-partner.google.com>
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

