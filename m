Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F202252DFFF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 00:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbiESWcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 18:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245475AbiESWb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 18:31:59 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23256B2278
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 15:31:58 -0700 (PDT)
Received: from hednb3.Dlink (unknown [109.252.138.248])
        by mail.ispras.ru (Postfix) with ESMTPSA id C7E0C40755E1;
        Thu, 19 May 2022 22:31:47 +0000 (UTC)
From:   Alexey Khoroshilov <khoroshilov@ispras.ru>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH] ASoC: max98090: Move check for invalid values before casting in max98090_put_enab_tlv()
Date:   Fri, 20 May 2022 01:31:26 +0300
Message-Id: <1652999486-29653-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <YoajesD+D1W3ZV7/@sirena.org.uk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Validation of signed input should be done before casting to unsigned int.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Suggested-by: Mark Brown <broonie@kernel.org>
Fixes: 2fbe467bcbfc ("ASoC: max98090: Reject invalid values in custom control put()")
---
 sound/soc/codecs/max98090.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 62b41ca050a2..5513acd360b8 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -393,7 +393,8 @@ static int max98090_put_enab_tlv(struct snd_kcontrol *kcontrol,
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
 	unsigned int mask = (1 << fls(mc->max)) - 1;
-	unsigned int sel = ucontrol->value.integer.value[0];
+	int sel_unchecked = ucontrol->value.integer.value[0];
+	unsigned int sel;
 	unsigned int val = snd_soc_component_read(component, mc->reg);
 	unsigned int *select;
 
@@ -413,8 +414,9 @@ static int max98090_put_enab_tlv(struct snd_kcontrol *kcontrol,
 
 	val = (val >> mc->shift) & mask;
 
-	if (sel < 0 || sel > mc->max)
+	if (sel_unchecked < 0 || sel_unchecked > mc->max)
 		return -EINVAL;
+	sel = sel_unchecked;
 
 	*select = sel;
 
-- 
2.7.4

