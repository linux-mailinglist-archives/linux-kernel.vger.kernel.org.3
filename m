Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36E751B5C7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 04:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238514AbiEECYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 22:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236575AbiEECYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 22:24:44 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923EE4AE0F
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 19:21:07 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id p6so2902122pjm.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 19:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L29beijmOBItkkHFe0zAs3en1lXL5wQ+ii6bOfyDx3w=;
        b=nsnFguKB2NLOrLnOrTZKwKhFp50jdrWPHzz6A8Y+5pjtxjvPbb9s1WBIppo7QlrXwD
         avUxyjTz7indRQhqjLDUmu5sbkeimM/DVnwNPjRFQOXQzD8aaKPOkVkeCvP8B8mZEkaj
         F1ND3RyphXaRjQ5/g1sRfVdm5zcnNIcYt3ZIjaojw42cxY6/Q3RWG9gTLu3oxxU6slK8
         T8xm3Tg8V2VUvIZRh42HUHHIif1w/NVb5o8IdFMkup7DhZYTmK8qYxOc1xBTQXnRqU35
         5G8Pu/PGDRyWDOiio8KEnZ4go+wl4QSM0pcwsxXDE80Et4U0lz2ccrxcP5oPvy5i2jHs
         dxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L29beijmOBItkkHFe0zAs3en1lXL5wQ+ii6bOfyDx3w=;
        b=ipDR1IEF7d6aXtZ9QXGRqGj6uT9D4o/K2cg82DrEsF3md2OLrMNB/HdS8VNdzUrqwg
         ucO/+ExRbyjJkfrHJ0jYqKfHcf4n4vJ29/iU9ywwsSKH1lCanBdZp+yxBDJ2IowVAv2x
         BtpgMAkXoqOpIDzM4kqPmMjjp56y/D4z+kY/izJXxgY/TfXoOTyBJ+Mtj8h+CAtcob/7
         gKPrM7iGNzIeRzg6UyE0eyuEGB+YIriGJQG/4syEwc6jdPgsOjCVW2iO9iBy4aG2BtQG
         B9UBWxwTBC4v4G/YoliC/VaNBIO97jFCy9oCtyxtc36CThK4LUBg+idV9WoIWAYGnrvm
         /uzg==
X-Gm-Message-State: AOAM533gdJU5y6p0GIGnP+idKHuOOc3UEgb1kxgPqbg4bFO/lg+fQsQk
        vAyt1RShofDiFcG4VwvbFZpTGmoAwuQ=
X-Google-Smtp-Source: ABdhPJwnuY6Oc5ajFtJMUAPrBiE+7/kofVgYm1v0VyH9aYzBuzJEFEQA5gUvaeQyUiPKz/3ZOWN8Dw==
X-Received: by 2002:a17:902:c2d5:b0:15e:d84a:b24a with SMTP id c21-20020a170902c2d500b0015ed84ab24amr916063pla.69.1651717267153;
        Wed, 04 May 2022 19:21:07 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 28-20020a17090a1a5c00b001cd4989ff41sm235507pjl.8.2022.05.04.19.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 19:21:06 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] ASoC: pcm186x: simplify the return expression of pcm186x_power_off()
Date:   Thu,  5 May 2022 02:21:02 +0000
Message-Id: <20220505022102.54650-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Simplify the return expression.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 sound/soc/codecs/pcm186x.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/sound/soc/codecs/pcm186x.c b/sound/soc/codecs/pcm186x.c
index 2c78dccb3f62..fda9d7ee3fe6 100644
--- a/sound/soc/codecs/pcm186x.c
+++ b/sound/soc/codecs/pcm186x.c
@@ -534,19 +534,14 @@ static int pcm186x_power_on(struct snd_soc_component *component)
 static int pcm186x_power_off(struct snd_soc_component *component)
 {
 	struct pcm186x_priv *priv = snd_soc_component_get_drvdata(component);
-	int ret;
 
 	snd_soc_component_update_bits(component, PCM186X_POWER_CTRL,
 			    PCM186X_PWR_CTRL_PWRDN, PCM186X_PWR_CTRL_PWRDN);
 
 	regcache_cache_only(priv->regmap, true);
 
-	ret = regulator_bulk_disable(ARRAY_SIZE(priv->supplies),
+	return regulator_bulk_disable(ARRAY_SIZE(priv->supplies),
 				     priv->supplies);
-	if (ret)
-		return ret;
-
-	return 0;
 }
 
 static int pcm186x_set_bias_level(struct snd_soc_component *component,
-- 
2.25.1


