Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A005053F781
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 09:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237856AbiFGHoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 03:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbiFGHon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 03:44:43 -0400
Received: from mail.shift-gmbh.com (mail.shift-gmbh.com [IPv6:2a01:4f8:a0:5496::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D816A2ED49;
        Tue,  7 Jun 2022 00:44:39 -0700 (PDT)
From:   Alexander Martinz <amartinz@shiftphones.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shiftphones.com;
        s=2018; t=1654587877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Asv1fLCYiPiifmvDhcl0BxRwcR2Y3nmkKTyFuAD1iew=;
        b=YHMAwMYTWczcAj2vcskeAzuUVY+UHKweEBxCPj+RcGMEkxbufH/8VKVpi/dknM/AJEC1iL
        ogmsA73Oya9Fbyp8XaZ4gZJSWHKAlt+gbp7fcW0sMo8yYdKJJ4mBtK5emUjkbk7epOPz2W
        HHVRLErLaCVOjHZhaEJYCiIBqJVR3I0nLrXlyDhyAEEuGw9dcBh82zBun/wLPN2wqzyoEl
        vFcFZTom22STW2i+LoBy5aRQWburriZDzq+JF/KlxtGlPQjhFg28GtvRp3i5BasoLwj7L/
        52kN157aFcMiqQpb0G78DqKaRomxQ4gFjZXwSk6QKzjbZJwk59iXr5foaKs6ng==
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     phone-devel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Caleb Connolly <caleb@connolly.tech>,
        Dylan Van Assche <me@dylanvanassche.be>,
        Alexander Martinz <amartinz@shiftphones.com>
Subject: [PATCH v2 2/2] ASoC: codecs: tfa989x: Add support for tfa9890
Date:   Tue,  7 Jun 2022 09:43:31 +0200
Message-Id: <20220607074329.13129-2-amartinz@shiftphones.com>
In-Reply-To: <20220607074329.13129-1-amartinz@shiftphones.com>
References: <20220607074329.13129-1-amartinz@shiftphones.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=amartinz@shiftphones.com smtp.mailfrom=amartinz@shiftphones.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initialization sequence is taken from the version provided
by the supplier [1].

This allows speakers using the TFA9890 amplifier to work, which are
used by various mobile phones such as the SHIFT6mq.

[1]: https://source.codeaurora.org/external/mas/tfa98xx/tree/src/tfa_init.c?id=d2cd12931fbc48df988b62931fb9960d4e9dc05d#n1827

v2: Fix comments regarding register access based on review feedback.

Signed-off-by: Alexander Martinz <amartinz@shiftphones.com>
Reviewed-by: Stephan Gerhold <stephan@gerhold.net>
---
 sound/soc/codecs/tfa989x.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/sound/soc/codecs/tfa989x.c b/sound/soc/codecs/tfa989x.c
index dc86852752c5..e6cb62165524 100644
--- a/sound/soc/codecs/tfa989x.c
+++ b/sound/soc/codecs/tfa989x.c
@@ -40,12 +40,14 @@
 #define TFA989X_I2S_SEL_REG		0x0a
 #define TFA989X_I2S_SEL_REG_SPKR_MSK	GENMASK(10, 9)	/* speaker impedance */
 #define TFA989X_I2S_SEL_REG_DCFG_MSK	GENMASK(14, 11)	/* DCDC compensation */
+#define TFA989X_HIDE_UNHIDE_KEY	0x40
 #define TFA989X_PWM_CONTROL		0x41
 #define TFA989X_CURRENTSENSE1		0x46
 #define TFA989X_CURRENTSENSE2		0x47
 #define TFA989X_CURRENTSENSE3		0x48
 #define TFA989X_CURRENTSENSE4		0x49
 
+#define TFA9890_REVISION		0x80
 #define TFA9895_REVISION		0x12
 #define TFA9897_REVISION		0x97
 
@@ -188,6 +190,33 @@ static struct snd_soc_dai_driver tfa989x_dai = {
 	.ops = &tfa989x_dai_ops,
 };
 
+static int tfa9890_init(struct regmap *regmap)
+{
+	int ret;
+
+	/* temporarily allow access to hidden registers */
+	ret = regmap_write(regmap, TFA989X_HIDE_UNHIDE_KEY, 0x5a6b);
+	if (ret)
+		return ret;
+
+	/* update PLL registers */
+	ret = regmap_set_bits(regmap, 0x59, 0x3);
+	if (ret)
+		return ret;
+
+	/* hide registers again */
+	ret = regmap_write(regmap, TFA989X_HIDE_UNHIDE_KEY, 0x0000);
+	if (ret)
+		return ret;
+
+	return regmap_write(regmap, TFA989X_CURRENTSENSE2, 0x7BE1);
+}
+
+static const struct tfa989x_rev tfa9890_rev = {
+	.rev	= TFA9890_REVISION,
+	.init	= tfa9890_init,
+};
+
 static const struct reg_sequence tfa9895_reg_init[] = {
 	/* some other registers must be set for optimal amplifier behaviour */
 	{ TFA989X_BAT_PROT, 0x13ab },
@@ -376,6 +405,7 @@ static int tfa989x_i2c_probe(struct i2c_client *i2c)
 }
 
 static const struct of_device_id tfa989x_of_match[] = {
+	{ .compatible = "nxp,tfa9890", .data = &tfa9890_rev },
 	{ .compatible = "nxp,tfa9895", .data = &tfa9895_rev },
 	{ .compatible = "nxp,tfa9897", .data = &tfa9897_rev },
 	{ }
-- 
2.36.1

