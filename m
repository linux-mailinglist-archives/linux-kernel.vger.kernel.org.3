Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7874F815A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 16:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241449AbiDGOPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 10:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiDGOPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:15:37 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603AC17F3DC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 07:13:37 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id a16-20020a17090a6d9000b001c7d6c1bb13so6347491pjk.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 07:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mR1YeWMU9tOSnx680BK1SzX5cCKeKB4fg1ibUdrnHdE=;
        b=qxQqqf9dbh1s4SOObcF+A7r6654kIcBnfemh5JwgpwDw9OjGdqjXErU8mqdijeekSC
         loz5BCCusyTbjFg3wiHAgRiJBdc948kp8LH+LZio0/SZIWfoj0voECmUcLpqjb06iL7L
         I+PBrKBpMj/URRb4cFfYAd+qKWdaOIwVdeVyH00i2ANa3rV84pBy48BUVqvLg9sDYhYu
         0t+6DhJYApEMDvKs5C4xHem9+56dSvMihbXiRfgIlTFUB3DRvMa7W5tOuZU4pVpHAQif
         gx9V4lJDwmSTgZBAnGlpnNvIUqnMKReCqkTDr2u1eniwFjTPrS8cYnIhW0haXndr/ACZ
         bpIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mR1YeWMU9tOSnx680BK1SzX5cCKeKB4fg1ibUdrnHdE=;
        b=rUW98IqNmBUEH1lMJWdSF+eUJ6rzG4ADc/Ct8lRa9vPkIghEefdsPxPNNTXpOEzjjk
         eecLyBcAzrcvbQeN8egQpEKZN86Qf933UQPg+ECWhzEfaPA2/+r/+C45v4oNuYEOXE2R
         YQODTF83K6qRHXdb73fTDjAv5n8dhTwDA7U42EXLT2Z7r4U6yiHs0KU4qQ98iGQECorH
         b+AM4hkcxKfYnJh1SJD7VfoXWTVUuVqZK17x6iM1P3p+naAxadapnpSWAk1BaJHUBlf8
         QK6+JJU8+Y17c/E9oa7E1hAedyKBAVvRTSzIlsEZWSYOIcUzvlR8TgtP8QWyjHpnvrqk
         rNUQ==
X-Gm-Message-State: AOAM530sWmHm828NXv6T2l9TdWonMf9++fxAfrdI9J2HACyJ36Zg+Oos
        fjBLoZiA1lifedx7i78bu8s=
X-Google-Smtp-Source: ABdhPJzE8uGA9C15x77lzGAz2d8S8eq63Rm8lnGX6kNwkdDAlDbhC9zDlQ0/mAFkm+ODMIrfRM8ySQ==
X-Received: by 2002:a17:90b:4a0b:b0:1c7:221a:a600 with SMTP id kk11-20020a17090b4a0b00b001c7221aa600mr16063589pjb.112.1649340809591;
        Thu, 07 Apr 2022 07:13:29 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id ne4-20020a17090b374400b001cb142237a8sm2311614pjb.4.2022.04.07.07.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 07:13:28 -0700 (PDT)
From:   Akihiko Odaki <akihiko.odaki@gmail.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Akihiko Odaki <akihiko.odaki@gmail.com>
Subject: [PATCH] ASoC: rt5682: Add jack kcontrol
Date:   Thu,  7 Apr 2022 23:13:16 +0900
Message-Id: <20220407141316.5099-1-akihiko.odaki@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a jack kcontrol manually as rt5682 does not use DAPM pins
for jack and will not have kcontrols for them.

Signed-off-by: Akihiko Odaki <akihiko.odaki@gmail.com>
---
 include/sound/jack.h      | 2 +-
 sound/core/jack.c         | 3 +--
 sound/soc/codecs/rt5682.c | 5 +++++
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/sound/jack.h b/include/sound/jack.h
index 1181f536557e..bb5fcbd70d7c 100644
--- a/include/sound/jack.h
+++ b/include/sound/jack.h
@@ -60,10 +60,10 @@ struct snd_jack {
 	struct list_head kctl_list;
 	struct snd_card *card;
 	const char *id;
+	int type;
 #ifdef CONFIG_SND_JACK_INPUT_DEV
 	struct input_dev *input_dev;
 	int registered;
-	int type;
 	char name[100];
 	unsigned int key[6];   /* Keep in sync with definitions above */
 #endif /* CONFIG_SND_JACK_INPUT_DEV */
diff --git a/sound/core/jack.c b/sound/core/jack.c
index d1e3055f2b6a..967a9769ea24 100644
--- a/sound/core/jack.c
+++ b/sound/core/jack.c
@@ -530,8 +530,6 @@ int snd_jack_new(struct snd_card *card, const char *id, int type,
 
 		jack->input_dev->phys = "ALSA";
 
-		jack->type = type;
-
 		for (i = 0; i < SND_JACK_SWITCH_TYPES; i++)
 			if (type & (1 << i))
 				input_set_capability(jack->input_dev, EV_SW,
@@ -545,6 +543,7 @@ int snd_jack_new(struct snd_card *card, const char *id, int type,
 		goto fail_input;
 
 	jack->card = card;
+	jack->type = type;
 	INIT_LIST_HEAD(&jack->kctl_list);
 
 	if (initial_kctl)
diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index be68d573a490..583dc80f08d0 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -1012,6 +1012,7 @@ static int rt5682_set_jack_detect(struct snd_soc_component *component,
 		struct snd_soc_jack *hs_jack, void *data)
 {
 	struct rt5682_priv *rt5682 = snd_soc_component_get_drvdata(component);
+	int ret;
 
 	rt5682->hs_jack = hs_jack;
 
@@ -1025,6 +1026,10 @@ static int rt5682_set_jack_detect(struct snd_soc_component *component,
 		return 0;
 	}
 
+	ret = snd_jack_add_new_kctl(hs_jack->jack, hs_jack->jack->id, hs_jack->jack->type);
+	if (ret)
+		dev_warn(component->dev, "Failed to create jack kcontrol - %d\n", ret);
+
 	if (!rt5682->is_sdw) {
 		switch (rt5682->pdata.jd_src) {
 		case RT5682_JD1:
-- 
2.35.1

