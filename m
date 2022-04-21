Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8313A50A4CE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236812AbiDUQA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 12:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390342AbiDUQAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 12:00:22 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D6640E76
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 08:57:31 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id c10so7349964wrb.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 08:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E0Xr29KwZXsM1RSTvbGVQLKdFlm6gLr6JsvZ9omdm1g=;
        b=Hr7mGBNybXCXwQwcy2LhZMdh/KpBSQgzb45nO28fqdIb6vNwaGHZPto4AqwTiu36U7
         1J2H0Cy3CB0P4pTBdwieJdyBcv8KveCl9drrDLRiGm4BlVARbKLHJW/hnop9cbcN9I90
         EV5xQyDgi4Z8kbFDOjkHK67bStZIAzJ+QmzlgzdXGURjmqUy2J54hMne6Klj01BitVe1
         bx92ejZJKC2cswFvPxZFkteZOeEVIbqyfasj3U3pvxTyRoZniputX4dbzF2PiqgIPwv4
         Wkz+RJJq2OMylno4iVKeRVvwDTKo4U9zMIyUfsT1lfUkqCnm7E8bIGShTC/eAnKcDC2w
         GCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E0Xr29KwZXsM1RSTvbGVQLKdFlm6gLr6JsvZ9omdm1g=;
        b=J3ZrUdVSpr/fN/cyPujnXCLFKtKFR3DH/nCqFa1VrjKcUM1Or1oHWX9KVLJmPG4FDT
         SNUJE4Pv2xYK16G5VdwSK3+KMZ700fyK11Y1nhmtO8B9nw89Wf8qhAWg2uvCqp/WbKfg
         J3hAqV4eJqD7k+lCg3cd1jC6MBWazAcxPnhWC4VWfzIkDgzOFmsHDZX9XdS13PxjRXHX
         o1BP3wC9tfyNT5W5j4fM3rrtGxhtxnRJ0bjnXai2o0zgAV/279q2FwRKmqWT8RvueumL
         N1+BW02Kon/F/t4pViR77Xawu3MqHsuPw/0ytnX2jd14ZZf4XNIzXNwnViAv9ct0RjG/
         Z30Q==
X-Gm-Message-State: AOAM532hUaWLW1DrOdtBeMYle2nWkC6S8BcRNYmNle6EWVsTolXfzndh
        /pzhaDDWdWYdGzDTQ46tTaf8EA==
X-Google-Smtp-Source: ABdhPJx7vw1kRWMEjCJYzAEdaiwrgrOvmaqPUNeDkFIzBjyf49b6SsrkX7g8rEkQbjTibXRCOHMuJg==
X-Received: by 2002:adf:efc6:0:b0:207:b89b:232b with SMTP id i6-20020adfefc6000000b00207b89b232bmr280197wrp.403.1650556650106;
        Thu, 21 Apr 2022 08:57:30 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:35ba:2677:956:980d])
        by smtp.gmail.com with ESMTPSA id 61-20020adf8143000000b002061d8d807esm2623140wrm.87.2022.04.21.08.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 08:57:29 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Dmitry Shmidt <dimitrysh@google.com>
Subject: [PATCH 1/2] Revert "ASoC: meson: axg-tdm-interface: manage formatters in trigger"
Date:   Thu, 21 Apr 2022 17:57:24 +0200
Message-Id: <20220421155725.2589089-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit bf5e4887eeddb48480568466536aa08ec7f179a5 because
the following and required commit e138233e56e9829e65b6293887063a1a3ccb2d68
causes the following system crash when using audio:
 BUG: sleeping function called from invalid context at kernel/locking/mutex.c:282

Reported-by: Dmitry Shmidt <dimitrysh@google.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 sound/soc/meson/axg-tdm-interface.c | 26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/sound/soc/meson/axg-tdm-interface.c b/sound/soc/meson/axg-tdm-interface.c
index 0c31934a9630..e076ced30025 100644
--- a/sound/soc/meson/axg-tdm-interface.c
+++ b/sound/soc/meson/axg-tdm-interface.c
@@ -351,29 +351,13 @@ static int axg_tdm_iface_hw_free(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int axg_tdm_iface_trigger(struct snd_pcm_substream *substream,
-				 int cmd,
+static int axg_tdm_iface_prepare(struct snd_pcm_substream *substream,
 				 struct snd_soc_dai *dai)
 {
-	struct axg_tdm_stream *ts =
-		snd_soc_dai_get_dma_data(dai, substream);
-
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-	case SNDRV_PCM_TRIGGER_RESUME:
-	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		axg_tdm_stream_start(ts);
-		break;
-	case SNDRV_PCM_TRIGGER_SUSPEND:
-	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-	case SNDRV_PCM_TRIGGER_STOP:
-		axg_tdm_stream_stop(ts);
-		break;
-	default:
-		return -EINVAL;
-	}
+	struct axg_tdm_stream *ts = snd_soc_dai_get_dma_data(dai, substream);
 
-	return 0;
+	/* Force all attached formatters to update */
+	return axg_tdm_stream_reset(ts);
 }
 
 static int axg_tdm_iface_remove_dai(struct snd_soc_dai *dai)
@@ -413,8 +397,8 @@ static const struct snd_soc_dai_ops axg_tdm_iface_ops = {
 	.set_fmt	= axg_tdm_iface_set_fmt,
 	.startup	= axg_tdm_iface_startup,
 	.hw_params	= axg_tdm_iface_hw_params,
+	.prepare	= axg_tdm_iface_prepare,
 	.hw_free	= axg_tdm_iface_hw_free,
-	.trigger	= axg_tdm_iface_trigger,
 };
 
 /* TDM Backend DAIs */
-- 
2.25.1

