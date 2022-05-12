Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278F2524461
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 06:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240594AbiELEin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 00:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347465AbiELEij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 00:38:39 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D854A4EA3E
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 21:38:38 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id i17so3772259pla.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 21:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qeatecpI5VBsmshnC6au00bIeak7l+cm/LdiNwjT/c0=;
        b=ndNUfPvViUWmtHv/CwYTGkFHMtGEOJ8yY5z5NK+5vl7ANwwIpU/KiLEnlBjaT/AFVX
         thndiuRJZy5kMs6BnRW7N1Xc7Einl3HPYGHoYa2mWJqsi+B5RkyMKwGFprJ+NYeiuLth
         Rpz8h11jpfxHuiyQw05812e2fT2Rl6i02d7lwQaC07tva+Trzy4lioTO6YKC+yQd7Iq4
         sViqW+VLFl9eM+4GPuVH9wL4S64LbBsHSLOHkQa62KQ5r0Gsf69xoe/yfRSNQf6JJlIp
         qO8xSBC0K/gJUoPSL4TejJPtehuSQ7lpZIMxTkTkwPQLMWXNd2/4dI8hpHw+y+8bbJ2V
         VvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qeatecpI5VBsmshnC6au00bIeak7l+cm/LdiNwjT/c0=;
        b=SZ/dU9JZM2z6nOUcIY9CyNh98QycYVyHnPlC/Tb9mnuao6PQ9KNzofxreB9aczo3+M
         BUnjhgHcS5+O5pR40h0/QhT2qWhB9ii4hytBI74uVaaJKNCFTtKSGoiASIFAL5EJIhIO
         sEHnnaC4dWmbLP7dTuh2rMCFknG5ZM5KJK1TUwwuuLHva7K+r1F9RRGbX2qDM69IoZFK
         XyccKGbGKibDMw+uc3myH4a5PEjGm/j6nLN1mMZZ/2j1GDj5JzoT2bKjRYwdLBsqZqlf
         zOWx4s9JMZnXAVSUOEsUDI6f+6fN7hVKv1sCdgfIkmk0f3L+VDwvoxxmkHn1iAgQXJA4
         +wVA==
X-Gm-Message-State: AOAM533aieyoCw7fBzXJvqtkFRDH/v++iLWOGCZqa4BLy7Oqr2NUCI1N
        xSmBauSrl5JtguvFKnJkGXM=
X-Google-Smtp-Source: ABdhPJxAVJ1FIYvRsnYjOBa/CyoO2jvWFCUmu+eGDJ0Ftz3NpcBnK2gsn0/MPoUBnks7zZsYB7vK3g==
X-Received: by 2002:a17:90b:1d03:b0:1dc:f0d0:f165 with SMTP id on3-20020a17090b1d0300b001dcf0d0f165mr8963314pjb.25.1652330318461;
        Wed, 11 May 2022 21:38:38 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id j35-20020a634a63000000b003c18ab7389asm759665pgl.36.2022.05.11.21.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 21:38:38 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] ASoC: samsung: Fix refcount leak in aries_audio_probe
Date:   Thu, 12 May 2022 08:38:28 +0400
Message-Id: <20220512043828.496-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
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

of_parse_phandle() returns a node pointer with refcount
incremented, we should use of_node_put() on it when done.
If extcon_find_edev_by_node() fails, it doesn't call of_node_put()
Calling of_node_put() after extcon_find_edev_by_node() to fix this.

Fixes: 7a3a7671fa6c ("ASoC: samsung: Add driver for Aries boards")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 sound/soc/samsung/aries_wm8994.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/samsung/aries_wm8994.c b/sound/soc/samsung/aries_wm8994.c
index 5265e546b124..83acbe57b248 100644
--- a/sound/soc/samsung/aries_wm8994.c
+++ b/sound/soc/samsung/aries_wm8994.c
@@ -585,10 +585,10 @@ static int aries_audio_probe(struct platform_device *pdev)
 
 	extcon_np = of_parse_phandle(np, "extcon", 0);
 	priv->usb_extcon = extcon_find_edev_by_node(extcon_np);
+	of_node_put(extcon_np);
 	if (IS_ERR(priv->usb_extcon))
 		return dev_err_probe(dev, PTR_ERR(priv->usb_extcon),
 				     "Failed to get extcon device");
-	of_node_put(extcon_np);
 
 	priv->adc = devm_iio_channel_get(dev, "headset-detect");
 	if (IS_ERR(priv->adc))
-- 
2.25.1

