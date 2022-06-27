Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1DD355D7FD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236490AbiF0OTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235267AbiF0OTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:19:05 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992AE101C2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 07:19:04 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id i25so7776519wrc.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 07:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=etbyC6+DcjuUYPYEggX53K5pNY+3Oq3KA+YfrpJk3l0=;
        b=xFR4kWDPyiw6BBcuKsZN9XPw30MhlmzCP7Dx7I9hj6EPes9x0Frv1pyCzN/vNpIZB3
         AJTwYUKUKTvULghGgqyFKKeDbSj21OaSafAP1VJ4+dh4KopA5XaBSY9Z8KYs5lur+8MQ
         AGQmp/19c58xwDaH6j+abpT8/q9EWgTefiWPQCRY9VljoqQpdH9dTmEXMlSoZvgQPIEq
         2D/BK4SCSox+Ci0E4uoqdN5Z36BUPsfqN1dlyIvwLg4vY5Ak1/ROun3eQIsOy6gIvzFV
         +WHhcJvAgPND7/iVJdguMtWtu6qaMHgdG1kK0TSpMjvBVEIumHW/b9fl1vSFcQt51BoR
         o4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=etbyC6+DcjuUYPYEggX53K5pNY+3Oq3KA+YfrpJk3l0=;
        b=JHVsW5aE+DPMa0C9T8e3kPo42+/ShVs2oGVH3DU+wrPTRt4cZbqH9TkUOKlNkR3Hyz
         smJXiyISs7F/jnXxGq2+Di8wDMo/DOPc0YHtr/YIodsbUyG538/cCwyUJVfH2FDRjK0a
         M6xyfaFEl4TWqKlHhxFU39KoOdWWMt/o//SSct/AfNBZ2TWHGVtGZgsIQoZLCE78p34L
         gpfDqUBz1IiNag4/LBb8StmQah0YRZYig3U8P+nFRHEfs/mX1TP/8aPtP+rF7meBlM/V
         1rGcRVTLbkOi08igtwKb8+WDNzlSBZgC9xRJuj+pDRmocmwe2RLoFEc23wyv4oAU3ISo
         EP3A==
X-Gm-Message-State: AJIora8yNGE0gUtsfPxpJStiT9OlmV5iiUJj6OQJacr/ggFttu3ym70b
        deG1ycdSc84mXlvK6321puMbKXkc1SzLcw==
X-Google-Smtp-Source: AGRyM1vaYtefBK9d+YZR3or0A5F0tEaouPxAFBusj6zsA6PDz2Hem6+/ZHpDHTfTMQMRdd1A+A0lYQ==
X-Received: by 2002:a5d:568b:0:b0:21b:995c:eb4e with SMTP id f11-20020a5d568b000000b0021b995ceb4emr12762633wrv.325.1656339543211;
        Mon, 27 Jun 2022 07:19:03 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id i6-20020a05600c354600b003974a00697esm18944196wmq.38.2022.06.27.07.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 07:19:02 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: samsung: h1940_uda1380: include proepr GPIO consumer header
Date:   Mon, 27 Jun 2022 16:19:00 +0200
Message-Id: <20220627141900.470469-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

h1940_uda1380 uses gpiod*/GPIOD* so it should include GPIO consumer
header.

Fixes: 9666e27f90b9 ("ASoC: samsung: h1940: turn into platform driver")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/samsung/h1940_uda1380.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/samsung/h1940_uda1380.c b/sound/soc/samsung/h1940_uda1380.c
index 907266aee839..fa45a54ab18f 100644
--- a/sound/soc/samsung/h1940_uda1380.c
+++ b/sound/soc/samsung/h1940_uda1380.c
@@ -8,7 +8,7 @@
 // Based on version from Arnaud Patard <arnaud.patard@rtp-net.org>
 
 #include <linux/types.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 
 #include <sound/soc.h>
-- 
2.34.1

