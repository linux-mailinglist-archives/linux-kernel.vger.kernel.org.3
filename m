Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F195D53BCE0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 18:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237284AbiFBQxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 12:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235643AbiFBQxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 12:53:03 -0400
X-Greylist: delayed 445 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Jun 2022 09:52:59 PDT
Received: from mail.shift-gmbh.com (mail.shift-gmbh.com [85.10.195.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCB027B9B0;
        Thu,  2 Jun 2022 09:52:59 -0700 (PDT)
From:   Alexander Martinz <amartinz@shiftphones.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shiftphones.com;
        s=2018; t=1654188331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EtLUtGgtzmMn/jbekYRhgMbH2I3kcpmuGEIvnJpeso0=;
        b=b4JM09k7nFCSVq0T51RJbyb2fTAuM5XtI3WD+QMJwNzcS5nVhCZ5NiWjxFyxT2x068LG85
        jWwCTMycoDmu1v3tSHXq3UE4X5AOLKIGRxPxiZBHZygfD5HoN4xGdreaOSSC0ljoeYw6mA
        qyorhrGR+M6x4g5qoOHJzNCQLM/pyvQF9i5ABm7gl7Ig/KizYeTMKSs4O/sZRbXNLZd0AW
        KNAQgjIbPJdVKdCwe9GrI3AQy+8YOcrlbQdjQIaiNQlM5Ygc2ovzjdeInwfA4qqpUWThGl
        G628nuK0mmtsW2H5+nGQZLDxBjPqRmWPJWZ53sGXiu9CvVxahMo1KbewQ2zZww==
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     phone-devel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Caleb Connolly <caleb@connolly.tech>,
        Dylan Van Assche <me@dylanvanassche.be>,
        Alexander Martinz <amartinz@shiftphones.com>
Subject: [PATCH 1/2] ASoC: codecs: tfa989x: Add support for tfa9890
Date:   Thu,  2 Jun 2022 18:45:03 +0200
Message-Id: <20220602164504.261361-1-amartinz@shiftphones.com>
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

Signed-off-by: Alexander Martinz <amartinz@shiftphones.com>
---
 sound/soc/codecs/tfa989x.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/sound/soc/codecs/tfa989x.c b/sound/soc/codecs/tfa989x.c
index dc86852752c5..8ab2656de750 100644
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
+	/* unhide keys to allow updating them */
+	ret = regmap_write(regmap, TFA989X_HIDE_UNHIDE_KEY, 0x5a6b);
+	if (ret)
+		return ret;
+
+	/* update PLL registers */
+	ret = regmap_set_bits(regmap, 0x59, 0x3);
+	if (ret)
+		return ret;
+
+	/* hide keys again */
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

