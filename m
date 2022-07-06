Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6FA5693FA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 23:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234647AbiGFVNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 17:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbiGFVM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 17:12:57 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA9D29CA3;
        Wed,  6 Jul 2022 14:12:55 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id dn9so23882486ejc.7;
        Wed, 06 Jul 2022 14:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ot4wRXZEFrjMcEpIgIGqrJ2+/NIs1mmDnW8eBaCbRmg=;
        b=pXn/zgG37fA4vrVG8yBFSuhqnS8A9mtgnUfIhO7sQCN27/+C5FRqmP1JXHoaw7/3MD
         JBAZc1gc+y3Z+iT/ncrT44XgUf5Wu/JQPXiJcfSXCNF/oFoPRoB8UIJGm76qBJXU3YE5
         reX0MIzAlUadWZ0zhZ6ZyHO4CT3/PwRC8z56JDzf8ajmRqj0XNcn7XkpeU1JxUTwIeoS
         2QmOck0y4fAdLnfssHFVMAhpaBbuYXU9xv0aQ64w/drDdI8eehj20PHtw00uAYfmep4W
         +56Z4+6uF8B3KZ1VPBf7lf7KffOuu5dJLDj4G3O5UUEs6U0Kuc362jDCw8aXpx+z5Zot
         mPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ot4wRXZEFrjMcEpIgIGqrJ2+/NIs1mmDnW8eBaCbRmg=;
        b=sUrTTF4rsFZO6+TVjwNGQ3eXBAQDcG6yNgKU7P2XUH6JeV4BgdA5Z1ILKqfYA9VlvW
         uwqGEnVpUsmzJRAFE+zOwRbtmGF5nGqv9fxLB2HJV6nhzZyvYP2fnfTlSnQrEERtSUlC
         QX4xW5sFuYKLGY9TsMrxYFGx7vJIgg6tjRgw8FZ3TQ+ooa5hEd9V9Mjr5zii7yVOZAqK
         W5SS2hZt3/yPYScO3XxddB4xfVl7W7WQyIfdhq4lYCtGAptGHoiBlk1tV8DJPOC6aQlI
         7LVc+jxPUcTDt+RbNU+r2dpb55PmWFdCPSsUMxX2hfA9UFVlsxmhoexvnFF4yLUnunWv
         npMA==
X-Gm-Message-State: AJIora+g7E/oHYb07a0N9uWfPRillO82A9+6Ismvgl7K5Ji3MpBlCSOE
        ujUCzG8UZqa6N1bXC/JAzgs=
X-Google-Smtp-Source: AGRyM1sM8kddgZ5/eeHLd9YPd0vlZfNr18WKSi0CW2svJW92/WrLnqZLNuH36I3tsUFoumDX58peAw==
X-Received: by 2002:a17:906:2c12:b0:726:94a0:2708 with SMTP id e18-20020a1709062c1200b0072694a02708mr41313645ejh.179.1657141973676;
        Wed, 06 Jul 2022 14:12:53 -0700 (PDT)
Received: from localhost (92.40.202.8.threembb.co.uk. [92.40.202.8])
        by smtp.gmail.com with ESMTPSA id l23-20020aa7cad7000000b004356afc7009sm26534782edt.59.2022.07.06.14.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 14:12:53 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     linux-mips@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] ASoC: jz4740-i2s: Support S20_LE and S24_LE sample formats
Date:   Wed,  6 Jul 2022 22:13:29 +0100
Message-Id: <20220706211330.120198-11-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220706211330.120198-1-aidanmacdonald.0x0@gmail.com>
References: <20220706211330.120198-1-aidanmacdonald.0x0@gmail.com>
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

The audio controller on JZ47xx SoCs supports 20- and 24-bit
samples coming from memory. Allow those formats to be used
with the I2S driver.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 sound/soc/jz4740/jz4740-i2s.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index 80b355d715ce..ee99c5e781ec 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -222,9 +222,15 @@ static int jz4740_i2s_hw_params(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_FORMAT_S8:
 		sample_size = 0;
 		break;
-	case SNDRV_PCM_FORMAT_S16:
+	case SNDRV_PCM_FORMAT_S16_LE:
 		sample_size = 1;
 		break;
+	case SNDRV_PCM_FORMAT_S20_LE:
+		sample_size = 3;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		sample_size = 4;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -362,7 +368,9 @@ static const struct snd_soc_dai_ops jz4740_i2s_dai_ops = {
 };
 
 #define JZ4740_I2S_FMTS (SNDRV_PCM_FMTBIT_S8 | \
-		SNDRV_PCM_FMTBIT_S16_LE)
+			 SNDRV_PCM_FMTBIT_S16_LE | \
+			 SNDRV_PCM_FMTBIT_S20_LE | \
+			 SNDRV_PCM_FMTBIT_S24_LE)
 
 static struct snd_soc_dai_driver jz4740_i2s_dai = {
 	.probe = jz4740_i2s_dai_probe,
-- 
2.35.1

