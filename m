Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF3348CC8E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 20:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346165AbiALTxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 14:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350393AbiALTwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 14:52:39 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B18C06118A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 11:52:35 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id o15so11847725lfo.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 11:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=He7BjM6dCMMuZ+d1PaptWEfTiiaWHjufRifL/qaqDNQ=;
        b=NCgDByj6hejwY7MuOGvvvTVFdE0SIutf2M2dNIqTnLWvTYZrGZcHThTDRYKIyu0+1a
         v9LpidK7TVBhU34aEpmdnnkJ0neebUciWxItaGoons6aj1nBdDkqm59faz57DZlHdAWi
         LPIyKtOTp3ok2nd2Jmr9r68FSIQcIybhJZBVkeoeiwoVX52xpNi8jiWudtU4Rn0v5Vy4
         8DFPJi+9FV/6Y9fmLfT/OaaS+p9/y3rZQ9nG8x/au6mEU9hDtKvNeSt4FVZD88FDnGGC
         lKUrV7JjzA4vV7c4xyOMrkgZtcCrKwwSFUyDXpWRqtpDfS1CU0A0cS5aJZY/mLd5/imR
         1kYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=He7BjM6dCMMuZ+d1PaptWEfTiiaWHjufRifL/qaqDNQ=;
        b=E58F7psqBmae8yjGhBEBKZx/bBB6S4zHVeyTM4aD44qZHjIqiVx4+Gbno/02XuPvs8
         QWFxfu/XXOU3Fqr2h7T9HJeJta9TXfa/59JoO22ulyCUEBViqx9izdCkaUKkmY4hqb/B
         O1UKuHjEITxzOYos4F6hBWcHgKf+xBBvCbaUXLRbJxhEEsAjTjWyxxOwqu9WxSDy9qbH
         SY+xWPgVLiRQPpG8sTfPAofuOJU8aj2TCi9CgPpKkZDgb8doD6X008bBfh88nlx1LHqC
         RBW9b8PKJGz7bHz9+H9Ur+pkUy2i9u2tgfnLKQihLIaJHPpVhpbfQRInpKfbgB1B3kZ7
         JhmA==
X-Gm-Message-State: AOAM530lIJHrNa8NYwrHDCnntfV0lbNhvFvqU9Z3JOktRBYcHrkzjdhZ
        rsk/Ic8WVAgCfDpuzH6Qm7U=
X-Google-Smtp-Source: ABdhPJzk+NRGmXVUet+lyHm2CN5FnEA2iJ4erteSkUXSDA2UFv+FYnd+7IGa8JwGGNOUHUesuS051w==
X-Received: by 2002:ac2:4c56:: with SMTP id o22mr945861lfk.558.1642017153504;
        Wed, 12 Jan 2022 11:52:33 -0800 (PST)
Received: from localhost.localdomain (94-29-62-108.dynamic.spd-mgts.ru. [94.29.62.108])
        by smtp.gmail.com with ESMTPSA id k7sm75860lfu.141.2022.01.12.11.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 11:52:33 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] ASoC: hdmi-codec: Fix OOB memory accesses
Date:   Wed, 12 Jan 2022 22:50:39 +0300
Message-Id: <20220112195039.1329-1-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct size of iec_status array by changing it to the size of status
array of the struct snd_aes_iec958. This fixes out-of-bounds slab
read accesses made by memcpy() of the hdmi-codec driver. This problem
is reported by KASAN.

Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/uapi/sound/asound.h   | 4 +++-
 sound/soc/codecs/hdmi-codec.c | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index ef0cafe295b2..2d3e5df39a59 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -56,8 +56,10 @@
  *                                                                          *
  ****************************************************************************/
 
+#define AES_IEC958_STATUS_SIZE		24
+
 struct snd_aes_iec958 {
-	unsigned char status[24];	/* AES/IEC958 channel status bits */
+	unsigned char status[AES_IEC958_STATUS_SIZE]; /* AES/IEC958 channel status bits */
 	unsigned char subcode[147];	/* AES/IEC958 subcode bits */
 	unsigned char pad;		/* nothing */
 	unsigned char dig_subframe[4];	/* AES/IEC958 subframe bits */
diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index b61f980cabdc..b07607a9ecea 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -277,7 +277,7 @@ struct hdmi_codec_priv {
 	bool busy;
 	struct snd_soc_jack *jack;
 	unsigned int jack_status;
-	u8 iec_status[5];
+	u8 iec_status[AES_IEC958_STATUS_SIZE];
 };
 
 static const struct snd_soc_dapm_widget hdmi_widgets[] = {
-- 
2.33.1

