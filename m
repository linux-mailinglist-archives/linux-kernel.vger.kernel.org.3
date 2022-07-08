Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A39156BD63
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 18:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238974AbiGHQCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 12:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238955AbiGHQCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 12:02:09 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89FA7478B;
        Fri,  8 Jul 2022 09:02:08 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id s1so31152067wra.9;
        Fri, 08 Jul 2022 09:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7O7dcwFHYK3zVnrgMRZvSesH1TPKQsF0Od7N+Uo6U2s=;
        b=pQFUEDbMcj/8a5jdZTvaeOgwRdD2gs9EObkREWqU4LBKpbj7QEhGaE9dGdlWzihi6r
         Z/gTwtMgDP8kTv4OF0IaEgSDrDjPyXWW9YKUjAWOF7f3tg5s3+XK+FwlLQV4xHYhT2Ii
         LtVaKzX4qV09kfLIXaHRFtqR9YYNDdUKQsMUAN1AawjOD5WBSi7D67q23DmrGr/yxnkW
         qEpD1xEjsLNysDNGdWR5qELGIf8oAV4lYOBIk/6cHz5RgNdPi1HdOP1W8CQJT5tRnqTb
         7+I5vMYCnmN7UXcvzrVASXPlxnAYgDBJzJ2kbg+I7E+aF4N4cLcawdY7AyUoMCSq7c9o
         s5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7O7dcwFHYK3zVnrgMRZvSesH1TPKQsF0Od7N+Uo6U2s=;
        b=cwCSs6pMb98CFl0firkT0KqCmzTPT9qyRxWlLBW3oLbv9L+u9uz3C19kfQmOAli+mt
         Q6Euz0Tp1SgjJcitd98A9UoFph+/KnCeF3Bc3MDk50WHScp2N6SkC7jXxwLF/ldJA9XY
         KWjVwaiu8WgmfMJHd7OMOS2v33tIV+5nQLJROl9HPhz2m6aJ0yaCLsJR2Yeo+e2rIoEv
         x0FAqwAlSu/RTfb15pAwJHxrXiE3IMKwQQLLl4ypnpQHr9AAzG7gwM9oz+j8IwdDfdZb
         mT7xCZ1D9RmmqAC5y0mOkoFrlHcDbcM1+Nry9SM3sfqpO6VqVnHC12NLN9PmNIo3uRv7
         vUUA==
X-Gm-Message-State: AJIora8T+O64w1Xz0Abbcp28wNW8WPcAL+j0r195V4N9+Rbeo7gldfAO
        q109Zejrry6EKWTXXD3gKWE=
X-Google-Smtp-Source: AGRyM1vX22rHAyjzjPUccF592wy9Ee0LYlejzqTSRp9IzSAnTDc5sDSxM8Xfpn0AZOYHP+YmHLAICQ==
X-Received: by 2002:adf:fd02:0:b0:21d:6f22:7857 with SMTP id e2-20020adffd02000000b0021d6f227857mr4110818wrr.633.1657296127225;
        Fri, 08 Jul 2022 09:02:07 -0700 (PDT)
Received: from localhost (92.40.203.144.threembb.co.uk. [92.40.203.144])
        by smtp.gmail.com with ESMTPSA id c189-20020a1c35c6000000b003a046549a85sm2532546wma.37.2022.07.08.09.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 09:02:06 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     linux-mips@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/11] ASoC: jz4740-i2s: Handle independent FIFO flush bits
Date:   Fri,  8 Jul 2022 17:02:34 +0100
Message-Id: <20220708160244.21933-2-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220708160244.21933-1-aidanmacdonald.0x0@gmail.com>
References: <20220708160244.21933-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the JZ4740, there is a single bit that flushes (empties) both
the transmit and receive FIFO. Later SoCs have independent flush
bits for each FIFO, which allows us to flush the right FIFO when
starting up a stream.

This also fixes a bug: since we were only setting the JZ4740's
flush bit, which corresponds to the TX FIFO flush bit on other
SoCs, other SoCs were not having their RX FIFO flushed at all.

Fixes: 967beb2e8777 ("ASoC: jz4740: Add jz4780 support")
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 sound/soc/jz4740/jz4740-i2s.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index ecd8df70d39c..576f31f9d734 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -64,6 +64,9 @@
 #define JZ_AIC_CTRL_ENABLE_PLAYBACK BIT(1)
 #define JZ_AIC_CTRL_ENABLE_CAPTURE BIT(0)
 
+#define JZ4760_AIC_CTRL_TFLUSH BIT(8)
+#define JZ4760_AIC_CTRL_RFLUSH BIT(7)
+
 #define JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE_OFFSET 19
 #define JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_OFFSET  16
 
@@ -90,6 +93,8 @@ enum jz47xx_i2s_version {
 struct i2s_soc_info {
 	enum jz47xx_i2s_version version;
 	struct snd_soc_dai_driver *dai;
+
+	bool shared_fifo_flush;
 };
 
 struct jz4740_i2s {
@@ -124,12 +129,33 @@ static int jz4740_i2s_startup(struct snd_pcm_substream *substream,
 	uint32_t conf, ctrl;
 	int ret;
 
+	/*
+	 * When we can flush FIFOs independently, only flush the
+	 * FIFO that is starting up.
+	 */
+	if (!i2s->soc_info->shared_fifo_flush) {
+		ctrl = jz4740_i2s_read(i2s, JZ_REG_AIC_CTRL);
+
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			ctrl |= JZ4760_AIC_CTRL_TFLUSH;
+		else
+			ctrl |= JZ4760_AIC_CTRL_RFLUSH;
+
+		jz4740_i2s_write(i2s, JZ_REG_AIC_CTRL, ctrl);
+	}
+
 	if (snd_soc_dai_active(dai))
 		return 0;
 
-	ctrl = jz4740_i2s_read(i2s, JZ_REG_AIC_CTRL);
-	ctrl |= JZ_AIC_CTRL_FLUSH;
-	jz4740_i2s_write(i2s, JZ_REG_AIC_CTRL, ctrl);
+	/*
+	 * When there is a shared flush bit for both FIFOs we can
+	 * only flush the FIFOs if no other stream has started.
+	 */
+	if (i2s->soc_info->shared_fifo_flush) {
+		ctrl = jz4740_i2s_read(i2s, JZ_REG_AIC_CTRL);
+		ctrl |= JZ_AIC_CTRL_FLUSH;
+		jz4740_i2s_write(i2s, JZ_REG_AIC_CTRL, ctrl);
+	}
 
 	ret = clk_prepare_enable(i2s->clk_i2s);
 	if (ret)
@@ -444,6 +470,7 @@ static struct snd_soc_dai_driver jz4740_i2s_dai = {
 static const struct i2s_soc_info jz4740_i2s_soc_info = {
 	.version = JZ_I2S_JZ4740,
 	.dai = &jz4740_i2s_dai,
+	.shared_fifo_flush = true,
 };
 
 static const struct i2s_soc_info jz4760_i2s_soc_info = {
-- 
2.35.1

