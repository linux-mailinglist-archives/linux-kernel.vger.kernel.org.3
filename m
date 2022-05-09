Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFE251FC48
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 14:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbiEIMPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 08:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbiEIMPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 08:15:15 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C99E14FC92
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 05:11:21 -0700 (PDT)
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 4F1C483A79;
        Mon,  9 May 2022 14:11:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1652098279;
        bh=IVzAp6mLcI5fjIjVSE0UrbrRh7utWQXvE4kL+Mmi6mg=;
        h=From:To:Cc:Subject:Date:From;
        b=Sw6BYO5bLJuvXdSDJyowlWgLu5sQkCcAUtk27KOyW/VgZH+YDRs7sfzGEkQ6xn70/
         wcyDtPEYcxZBpJqbCHw5L2RLAZDO+2T4OF9RBOzo3gC8+aulshR8BxHj82/YHLShan
         hp7EADvCeRp8J1oGiZ+NpGLWRJrxPrEYiL9uS7Mx0X9/eQHHcCWR/m0Ik8TSHx9NWn
         TIf/4ohapp35wP3VW+BQdQnGeC/JUE3D5grlvtm2kTacsJTGwykaO2RVQldiSt5Pc/
         Q+reqQ7uHZ3GVFNtNBEPSyIKcOfYaiQm/c2y8evsZx8NC08aVyyuJH/b9FRqB+A/zi
         VfKsX0yFlp6qQ==
From:   Lukasz Majewski <lukma@denx.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 1/2] ASoC: wm8940: add devicetree support
Date:   Mon,  9 May 2022 14:10:55 +0200
Message-Id: <20220509121055.31103-1-lukma@denx.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds devicetree support to the wm8940 codec driver.
With a DT-based kernel, there is no board-specific setting
to select the driver so allow it to be manually chosen.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 sound/soc/codecs/Kconfig  | 2 +-
 sound/soc/codecs/wm8940.c | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index f46a22660103..5120b15139bc 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1811,7 +1811,7 @@ config SND_SOC_WM8904
 	depends on I2C
 
 config SND_SOC_WM8940
-	tristate
+	tristate "Wolfson Microelectronics WM8940 codec"
 	depends on I2C
 
 config SND_SOC_WM8955
diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
index 440d048ef0c0..8615a55f84dd 100644
--- a/sound/soc/codecs/wm8940.c
+++ b/sound/soc/codecs/wm8940.c
@@ -779,9 +779,16 @@ static const struct i2c_device_id wm8940_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, wm8940_i2c_id);
 
+static const struct of_device_id wm8940_of_match[] = {
+	{ .compatible = "wlf,wm8940", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, wm8940_of_match);
+
 static struct i2c_driver wm8940_i2c_driver = {
 	.driver = {
 		.name = "wm8940",
+		.of_match_table = wm8940_of_match,
 	},
 	.probe =    wm8940_i2c_probe,
 	.id_table = wm8940_i2c_id,
-- 
2.35.1

