Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A0052293F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 03:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240825AbiEKBzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 21:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240843AbiEKBzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 21:55:36 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914EE18C063
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 18:55:35 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id gj17-20020a17090b109100b001d8b390f77bso3546994pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 18:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2ba9RlsMQZXWIx36Z7u38zcXmSCVXQjEy1o7bWz6s8w=;
        b=Yf0OpUrx+nfUoeezT84Ho8jYoJAtvR8bMUSrPF3q+WTRu6Ojay2B4dj6RtDYjvaror
         vetcXq+m1RFeUa2gXq0i8ncujVkNNI5wScGQZ+j5D8fsb5aeLgzfnl4eRVK5S8cPRRtv
         m2cck0UeO9+0JSlBuQxaTFfxD20DXCW/FzuKwWD4cNp8w8HtZIMS4jX/sWjjTE6yb2Qr
         e9VRzGOsNBuBOJ5I4gCg8KX0Ff5oXJ65u5xRBJpYerfPiyXjaNfNH3KQD+ZEC48GjlgI
         0ek7wC2HHcwTIgOMmqGkhoq6/i1lme5dq07X39Xm9TyjLxaxIP7a/rQN4UlBb9F4EwEw
         8YHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2ba9RlsMQZXWIx36Z7u38zcXmSCVXQjEy1o7bWz6s8w=;
        b=bkfMFkT8HhYB0dU3EeYeyZZYNd1DO6xPGKpAB32Ef61KyJ4zEhg3DkrDX63LxfhgSv
         tQriEZ7pQBf/WoHiH2VeYcyNEexOY80i7sL+dk2CGkdZx2NJ66Yqnix+Jn6qUhi7p/SH
         zXxvHV48Ihdqwd8aAP8pJAZdRq92G3jc/l6mROYF3vZwAUPdgb7YhC9g9Vzw/06u4DjY
         0shnJGGftuJdKZ9pZA/cG8T3hZ8dQ3ffwmn6ZHI6LykAcaqnchmFlRmV7HbJIemCcxFC
         Lxcp/XTHn/MvBqoB9SAEJ4VQFWrRckEP1PRyevodcfHte6F0EXpqv33Z2j0aUufJgDrh
         lNiw==
X-Gm-Message-State: AOAM532HpyM9ZSG5lnmwp7kJ6PXnBDD9PGaXBiOANW4Ke9BRFw3/um64
        XJJQEUAe221CN1IOLkf4k7h1SiifezMnK1o=
X-Google-Smtp-Source: ABdhPJxoDtoqqDlHuOkZKONoO7zzvmWFvWXx00E4kWjd9G64OYb3ea98eE0UH2enSRVwLWVdAFpW5Q==
X-Received: by 2002:a17:902:fe01:b0:15e:e178:e2e3 with SMTP id g1-20020a170902fe0100b0015ee178e2e3mr22853345plj.40.1652234134968;
        Tue, 10 May 2022 18:55:34 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id f12-20020aa79d8c000000b0050dc76281f2sm207807pfq.204.2022.05.10.18.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 18:55:34 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     james.schulman@cirrus.com, david.rhodes@cirrus.com,
        tanureal@opensource.cirrus.com, rf@opensource.cirrus.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, ckeepax@opensource.cirrus.com,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Cc:     Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH v2] ASoC: cs42l56: Fix the error handling of cs42l56_i2c_probe()
Date:   Wed, 11 May 2022 09:55:14 +0800
Message-Id: <20220511015514.1777923-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510155410.GC38351@ediswmail.ad.cirrus.com>
References: <20220510155410.GC38351@ediswmail.ad.cirrus.com>
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

The driver should goto label 'err_enable' when failing at regmap_read().

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
Changes in v2:
    - Fix the typo in the subject
---
 sound/soc/codecs/cs42l56.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l56.c b/sound/soc/codecs/cs42l56.c
index 2c4e09b43199..dc23007336c5 100644
--- a/sound/soc/codecs/cs42l56.c
+++ b/sound/soc/codecs/cs42l56.c
@@ -1245,7 +1245,7 @@ static int cs42l56_i2c_probe(struct i2c_client *i2c_client)
 	ret = regmap_read(cs42l56->regmap, CS42L56_CHIP_ID_1, &reg);
 	if (ret) {
 		dev_err(&i2c_client->dev, "Failed to read chip ID: %d\n", ret);
-		return ret;
+		goto err_enable;
 	}
 
 	devid = reg & CS42L56_CHIP_ID_MASK;
-- 
2.25.1

