Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE01D4E609B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 09:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242544AbiCXIs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 04:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344084AbiCXIsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 04:48:52 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DC39D05D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 01:47:20 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id h19so2470622pfv.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 01:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=33aPXc/mS/jNewOzlkvWpaIPpntrWzVJqKx+1PHJOcc=;
        b=B/PWwhBsfcXhm4SXAAv8CYraVSF4L9JLe6uaFJFtRL6EwhMk6+iWDReghpMVf+9cJ2
         vuGNAT2F0X4gmkBG0IyE0+ko7c+XUe7eJOoEIJV2tmI+vr15rKJvIRjyjuCf7vkXXpMB
         ks9AFnR0g0RQRb2WAXmCRy36N8hqrGbsO0EKDeF2nUrpEHjaslFIs065ii896VwBajJp
         kEr6g1XnoHKe946CNFfhbbrcdADcfRbWO9l7JGNOEANQVBhmFWG5gJqTFNaRa1djH16R
         S3ScU5eRYbZkAlnht3RPhUmTvy81dhiw1gzsaX50rGi2beSh8u6dpVxJVuf4IGI2W6ks
         gbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=33aPXc/mS/jNewOzlkvWpaIPpntrWzVJqKx+1PHJOcc=;
        b=kdnAwBK2ONLfk3lylytg3vynIoMSpz3BFuyieFAVfuCd6gNVNJD3Uf/X7N4xv3NlRO
         miW2xsYtl7ffFB8rrpMsm9wBRSGnAOIMkPfNpfq1rCOA4gEc9EZUHWLQXdysgyqpBgJu
         51gj7/a4nFS8SW3+KySdfb7z16ihhWxhyx4zdRNDkctKTJWPJYSmzDGvSTIaPCK6OYTL
         hUy1B0ypueQbkqZXcP7qem2Pr+DCVnz1IAmhaELPmp4gzVEI/GInNKetxnI846i3ZhCd
         nUW0hMW+j3w4WiPt7E5HC2BXD8sLrnu1uvgZCJZOfLfeu/t+EqWUsr4uOfJf18urKdLt
         Chug==
X-Gm-Message-State: AOAM532CqnpII5ZtyXlqFeap4aRAMgeFl8ABWkIC3TsJswKrOl7S7OQM
        MkWXbjn5FrB9UqdXsO4gno91EcMIXedCNg==
X-Google-Smtp-Source: ABdhPJwgl+qMNlis/u8O3JqVzA/WRpz85V+ZGKqf84PGubMlFZfP3ETLxy8awqUZh8bQNz0cGJem/Q==
X-Received: by 2002:a63:1a56:0:b0:381:ede3:979d with SMTP id a22-20020a631a56000000b00381ede3979dmr3224293pgm.372.1648111639392;
        Thu, 24 Mar 2022 01:47:19 -0700 (PDT)
Received: from localhost.localdomain (118-167-208-50.dynamic-ip.hinet.net. [118.167.208.50])
        by smtp.gmail.com with ESMTPSA id z16-20020a637e10000000b00382b21c6b0bsm1924605pgc.51.2022.03.24.01.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 01:47:18 -0700 (PDT)
From:   Ajye Huang <ajye.huang@gmail.com>
X-Google-Original-From: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Brent Lu <brent.lu@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        Mac Chiang <mac.chiang@intel.com>,
        Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>,
        alsa-devel@alsa-project.org, sound-open-firmware@alsa-project.org
Subject: [PATCH v1] ASoC: Intel: sof_rt5682: Add support for max98360a speaker amp on SSP2
Date:   Thu, 24 Mar 2022 16:47:08 +0800
Message-Id: <20220324084708.2009375-1-ajye_huang@compal.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow Intel's design to replace max98360a amp SSP2 reather than SSP1
by judging DMI_OEM_STRING in sof_rt5682_quirk_table struct.
And reusing max98357's topology since DAI setting could be leveraged.

Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
---
 sound/soc/intel/boards/sof_rt5682.c | 13 +++++++++++++
 sound/soc/sof/sof-pci-dev.c         |  9 ++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index ebec4d15edaa..7126fcb63d90 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -212,6 +212,19 @@ static const struct dmi_system_id sof_rt5682_quirk_table[] = {
 					SOF_SSP_BT_OFFLOAD_PRESENT),
 
 	},
+	{
+		.callback = sof_rt5682_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_FAMILY, "Google_Brya"),
+			DMI_MATCH(DMI_OEM_STRING, "AUDIO-MAX98360_ALC5682I_I2S_AMP_SSP2"),
+		},
+		.driver_data = (void *)(SOF_RT5682_MCLK_EN |
+					SOF_RT5682_SSP_CODEC(0) |
+					SOF_SPEAKER_AMP_PRESENT |
+					SOF_MAX98360A_SPEAKER_AMP_PRESENT |
+					SOF_RT5682_SSP_AMP(2) |
+					SOF_RT5682_NUM_HDMIDEV(4)),
+	},
 	{}
 };
 
diff --git a/sound/soc/sof/sof-pci-dev.c b/sound/soc/sof/sof-pci-dev.c
index 4c9596742844..12f5cff22448 100644
--- a/sound/soc/sof/sof-pci-dev.c
+++ b/sound/soc/sof/sof-pci-dev.c
@@ -83,7 +83,14 @@ static const struct dmi_system_id sof_tplg_table[] = {
 		},
 		.driver_data = "sof-adl-max98357a-rt5682-2way.tplg",
 	},
-
+	{
+		.callback = sof_tplg_cb,
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_FAMILY, "Google_Brya"),
+			DMI_MATCH(DMI_OEM_STRING, "AUDIO-MAX98360_ALC5682I_I2S_AMP_SSP2"),
+		},
+		.driver_data = "sof-adl-max98357a-rt5682.tplg",
+	},
 	{}
 };
 
-- 
2.25.1

