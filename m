Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F46153E6B6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241091AbiFFPpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240970AbiFFPpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:45:12 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA321F1BE2
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 08:45:09 -0700 (PDT)
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 4789D83E63;
        Mon,  6 Jun 2022 17:45:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1654530307;
        bh=KHCCpJWpvoD0Y/WD41sZEKMPbIOi11fqmo/ZGOG53OU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jpndVbWRhRsEaeapXjcuWY7rbEo8LJdxnGbFRFrBB8x3+IO0K2f/V8Y8kq3HtXO0K
         O8BCQSFbOcUrAChV0FKNoQKCHRhwYBVokwpT2Z0i2pgy305iIDb6szG2XkpO9EzR6B
         dI9MzJp3HQ0BDTVi1IZUdDbcm9qQOnVUAr5yJ++GcwBz9LU9/OMpJPxUgBoO5HpdQ/
         fXnC6gj683X3Qd8VHonzVmqqgExOVUukvxv29H48fdhdyFgweYNjIVe5y6iHrofVQZ
         ser+7OOq2kJh8l6xEWe1P1Hc/m5GWY05yzA9rUdUAqyysCfbsAXV4Sdv5Zz444EYeo
         wrer/YmJNihig==
From:   Lukasz Majewski <lukma@denx.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 3/3] ASoC: wm8940: Mute also the speaker output
Date:   Mon,  6 Jun 2022 17:44:41 +0200
Message-Id: <20220606154441.20848-3-lukma@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220606154441.20848-1-lukma@denx.de>
References: <20220606154441.20848-1-lukma@denx.de>
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

Without this change the BTL speaker produces some
"distortion" noise when test program
(speaker-test -t waw) is ended with ctrl+c.

As our design uses speaker outputs to drive BTL speaker,
it was necessary to also mute the speaker via the codec
internal WM8940_SPKVOL register with setting
WM8940_SPKMUTE bit.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 sound/soc/codecs/wm8940.c | 11 ++++++++++-
 sound/soc/codecs/wm8940.h |  3 +++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
index 6fb1c3780439..a8596f4089dd 100644
--- a/sound/soc/codecs/wm8940.c
+++ b/sound/soc/codecs/wm8940.c
@@ -465,9 +465,18 @@ static int wm8940_mute(struct snd_soc_dai *dai, int mute, int direction)
 {
 	struct snd_soc_component *component = dai->component;
 	u16 mute_reg = snd_soc_component_read(component, WM8940_DAC) & 0xffbf;
+	u16 spkvol_reg = snd_soc_component_read(component, WM8940_SPKVOL);
+	int ret;
 
-	if (mute)
+	spkvol_reg &= ~WM8940_SPKMUTE;
+	if (mute) {
 		mute_reg |= 0x40;
+		spkvol_reg |= WM8940_SPKMUTE;
+	}
+
+	ret = snd_soc_component_write(component, WM8940_SPKVOL, spkvol_reg);
+	if (ret)
+		return ret;
 
 	return snd_soc_component_write(component, WM8940_DAC, mute_reg);
 }
diff --git a/sound/soc/codecs/wm8940.h b/sound/soc/codecs/wm8940.h
index 0d4f53ada2e6..eb051ed29bb8 100644
--- a/sound/soc/codecs/wm8940.h
+++ b/sound/soc/codecs/wm8940.h
@@ -95,5 +95,8 @@ struct wm8940_setup_data {
 #define WM8940_OPCLKDIV_3 2
 #define WM8940_OPCLKDIV_4 3
 
+/* Bit definitions */
+#define WM8940_SPKMUTE BIT(6)
+
 #endif /* _WM8940_H */
 
-- 
2.20.1

