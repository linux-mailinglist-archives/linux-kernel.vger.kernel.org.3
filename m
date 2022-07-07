Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA3656AC1C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 21:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236530AbiGGTq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 15:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236409AbiGGTqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 15:46:48 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5BB32EF3;
        Thu,  7 Jul 2022 12:46:47 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id g1so16804279edb.12;
        Thu, 07 Jul 2022 12:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VXKGG9javDrFOkKmb7ryKLnUNvKA3TX1Nnby1SaWrZk=;
        b=n4Y5f97i3NIfTU7jXusYevNsremu+bzSJxGsQhqkaTWbVr5A43Ya9I82QJ0xnvbvyU
         OjpU6n96YZdMKX98GAE/eqOyzk4hW8kYp6PqIKy+rSs+51Cw6JJG5RwwClxUfOsXme5g
         ZdQEiUIXd+0HtOaSDo8jPwacMQ0M6G/rgnQgbd7KqP3TSrW0Xw6bm7RQC7AaEIXOtyFr
         kOlYvWt3jNntG3bGbJRa/wBWdsjOu+RgETf8y1Q0Qp4eQQveaZDUuZwOs84vV1NTUQ/g
         QtxNVwYpi+vpzxaM+49jZrDlS//l5PVrJWUqAL4TxKBgsl8WFU8CSooCNOdu4wXXKpI8
         ZRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VXKGG9javDrFOkKmb7ryKLnUNvKA3TX1Nnby1SaWrZk=;
        b=aSBkb5E/Amw/e5WazIzGKF+pcqXMdNVKbgQ8pSFYlhnQYegXZIjjYHr393bttjTAa4
         sGW2E+t59yXerTU8O3ileW5zu+fdO5uEgZcItZoSm8Ay1wGsCS7oZ6y7wBOLB0cBNv/G
         eRxfGQF/vT4P7WFXc4emu6mBh2JnoI9lvzRaE+SVmi2xsebwisENK/x+t0gk7wcOy3Fs
         Rtk300QZ6HjGXQiZS20zR9GW5BQdGDxhCntLhDLkjz1LrLsxyJJVBtPlHaD1jo1T8gOs
         ZB31jOBjCQaqYybJo6HxUmYlPuTIvhdnxUbVUXzPThev/3nACF0x0OS2MVY6wxVpR3ah
         g/HA==
X-Gm-Message-State: AJIora+IlLY7sG0Xzttc3+Wu8faPzmYMGhO3mW81GfdTpadgMg0QyPqO
        l0zBHixuAwDvqGt5keKuWb8=
X-Google-Smtp-Source: AGRyM1t5YHGaAXCFYhFbkUmZfS61A+phs798Naq0MTaMYMF1qfI/f4QbXo/kslRdhgJz08bZi9NqbQ==
X-Received: by 2002:aa7:d80a:0:b0:43a:6f95:62a0 with SMTP id v10-20020aa7d80a000000b0043a6f9562a0mr26783800edq.284.1657223205729;
        Thu, 07 Jul 2022 12:46:45 -0700 (PDT)
Received: from localhost (92.40.202.166.threembb.co.uk. [92.40.202.166])
        by smtp.gmail.com with ESMTPSA id b7-20020a1709064d4700b0070f6855b90bsm19448053ejv.170.2022.07.07.12.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 12:46:45 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     linux-mips@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/11] ASoC: jz4740-i2s: Handle independent FIFO flush bits
Date:   Thu,  7 Jul 2022 20:46:48 +0100
Message-Id: <20220707194655.312892-5-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220707194655.312892-1-aidanmacdonald.0x0@gmail.com>
References: <20220707194655.312892-1-aidanmacdonald.0x0@gmail.com>
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
 sound/soc/jz4740/jz4740-i2s.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index bd73427b837e..043f100a9cfa 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -58,6 +58,9 @@
 #define JZ_AIC_CTRL_ENABLE_PLAYBACK BIT(1)
 #define JZ_AIC_CTRL_ENABLE_CAPTURE BIT(0)
 
+#define JZ4760_AIC_CTRL_TFLUSH BIT(8)
+#define JZ4760_AIC_CTRL_RFLUSH BIT(7)
+
 #define JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE_OFFSET 19
 #define JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_OFFSET  16
 
@@ -75,6 +78,8 @@ struct i2s_soc_info {
 	struct reg_field field_tx_fifo_thresh;
 	struct reg_field field_i2sdiv_capture;
 	struct reg_field field_i2sdiv_playback;
+
+	bool shared_fifo_flush;
 };
 
 struct jz4740_i2s {
@@ -100,10 +105,26 @@ static int jz4740_i2s_startup(struct snd_pcm_substream *substream,
 	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
 	int ret;
 
+	/*
+	 * When we can flush FIFOs independently, only flush the
+	 * FIFO that is starting up.
+	 */
+	if (!i2s->soc_info->shared_fifo_flush) {
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			regmap_set_bits(i2s->regmap, JZ_REG_AIC_CTRL, JZ4760_AIC_CTRL_TFLUSH);
+		else
+			regmap_set_bits(i2s->regmap, JZ_REG_AIC_CTRL, JZ4760_AIC_CTRL_RFLUSH);
+	}
+
 	if (snd_soc_dai_active(dai))
 		return 0;
 
-	regmap_set_bits(i2s->regmap, JZ_REG_AIC_CTRL, JZ_AIC_CTRL_FLUSH);
+	/*
+	 * When there is a shared flush bit for both FIFOs we can
+	 * only flush the FIFOs if no other stream has started.
+	 */
+	if (i2s->soc_info->shared_fifo_flush)
+		regmap_set_bits(i2s->regmap, JZ_REG_AIC_CTRL, JZ_AIC_CTRL_FLUSH);
 
 	ret = clk_prepare_enable(i2s->clk_i2s);
 	if (ret)
@@ -382,6 +403,7 @@ static const struct i2s_soc_info jz4740_i2s_soc_info = {
 	.field_tx_fifo_thresh	= REG_FIELD(JZ_REG_AIC_CONF, 8, 11),
 	.field_i2sdiv_capture	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
 	.field_i2sdiv_playback	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
+	.shared_fifo_flush	= true,
 };
 
 static const struct i2s_soc_info jz4760_i2s_soc_info = {
-- 
2.35.1

