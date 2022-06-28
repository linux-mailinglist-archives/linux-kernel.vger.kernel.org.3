Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6615E55E196
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344339AbiF1KMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 06:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233434AbiF1KMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 06:12:42 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D5B2FE49
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 03:12:41 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v9so1333358wrp.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 03:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rTu9XAWen9WoHj1yR5c7Lkpd0pwfwXCy8JkwcyJEXh0=;
        b=e0z+uzEQ0z82O34jFflF1Z/uP+hlboiW2wesXrgX9LNyU6j72yAqAdIdmruyVWKMJj
         45Ez3pLouqJILdv43Jn3QKmhjJ6MlT50n5JqEogop+2q+WveBB2lhwBpuF9E2Rgh+Izs
         oHZBiitOm6aK9vUzh2rVwmpocxE0NyUoKfDrfJFmBNd02pHD00VQNFvREjitCg1Z07F5
         iIGUSDdnihSCUANGK5UDEDsKx44E97geIPm6C0gYrr8gAYQ7zILoigM6oT34GKlQcEjP
         /Ap0cDYMm1/+1l3eNZqlS82PcLRzXm1M7Kl5C6KLADYVJuTKtO0WjCoOm/blbXmIt9pk
         fpOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rTu9XAWen9WoHj1yR5c7Lkpd0pwfwXCy8JkwcyJEXh0=;
        b=5nHk/DYkegXNmq8xSyFHVWLkMEMJBfSdUwxFUNYyKfbBduNLzLIrvq/TpQ2CDRdwkB
         Ypu00co74wqR9RunFdy74739TMVVz/QTV7l+x7ZaEcL83qoG1NnaoK0WBzL8Df2hyHEz
         Zd+WPGtmMaFfPD6MN7qU7bGAWYSNUU+i3ey6IPuksKlyiDVhVkwJi49ialIXyb49SzG9
         VyD0cG5a5YyYxipq7eqpNJNWhPEq72T6QOF6a11YNBIqG79T91IlfvITqG6e+hd4Gqw9
         561o7ocgL5m7NaoIdR316+orUXAXIHKqrfqgfa3E5DCWIpBo1YoeOx0XN3qEBFaMdE7J
         lsGw==
X-Gm-Message-State: AJIora+esD0RSuSSDWUOcFgXmAYYi3gpLfglPYvIYH+n1MK4YjnOvEyk
        QnzF+qWPXCNL/eFxb7ILz3A1Bw==
X-Google-Smtp-Source: AGRyM1uRGv3iuoKnkhxHQdrR1+LULm1cUgtzHMR1gwCAnsz0PMgjk8VPkm4JlKAXFvl+kgHQ/kzUzA==
X-Received: by 2002:a05:6000:1786:b0:21d:2180:1839 with SMTP id e6-20020a056000178600b0021d21801839mr1043810wrg.596.1656411160443;
        Tue, 28 Jun 2022 03:12:40 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id n12-20020a5d6b8c000000b0020c5253d8fcsm15750078wrx.72.2022.06.28.03.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 03:12:39 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: samsung: h1940_uda1380: Include proper GPIO consumer header
Date:   Tue, 28 Jun 2022 12:12:34 +0200
Message-Id: <20220628101234.34765-1-krzysztof.kozlowski@linaro.org>
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

Changes since v1:
1. Fix typo in commit subject.
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

