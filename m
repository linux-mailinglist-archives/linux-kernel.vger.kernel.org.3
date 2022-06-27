Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8967755CCFD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237495AbiF0Oek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235461AbiF0Oef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:34:35 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0312AB7EF
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 07:34:35 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id b26so969452wrc.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 07:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=RulnywGDRCN4Up1alBesmQISI/vXS+eDPdIZtvq/DHE=;
        b=T/5ehi/+YQa6nBm0drA1PW1R6m5Oo11fA/Ze5NurtYii6uKm8f9uLM5U0/INzxSlDZ
         Ts40K4Ha+eRjzpRJNfX9zIPHYv856PbSw4/aqvJpf8fY3Ror7+XnVhOO7pWQhd9du6BO
         kR7qwiNons3UzV6/NS+XvePSlOCBkyr5TYc5e48e1JLOFmeejyczJHqQlTw0RKlf87Ou
         NqgRziypXltJJqZ8yFg76wt/faQHLusNBPt1U9GrUrlrWXqEGYBktEzirD5lnl8p5sSb
         bw93L98AaoVoYIVxo0YDsOWC+79yhl8pEmIDY5WvMjnwdueBK/Yg2l3cjXQvhua/AfUC
         Fj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RulnywGDRCN4Up1alBesmQISI/vXS+eDPdIZtvq/DHE=;
        b=VCSlZcStBTtUoOcNwAL4nt1jjYSJCIjIkUPeh/9WP/oIaLy5WshdN2AEqv7lfLOe1c
         E8GOHTSgT4dlHaYjI4haoPKy4OZf1M51S8NpMIdWmQvdbN0TwkEYE1iYQSbX5jnRSZf1
         /IHGapviN8mw5WMk4z6tje+Jwi4rd6ss631HONutpdZktofv+A5UCxyEQjEXcnC4r/rL
         rsyfRQAajkTFc+18jFABQ4t3K/w1zMkmKwu65dpaVoQDYuxUvjC8gCBcq2MALnUet0re
         9CCHI2C9pzihuJDx9YDHUWamU59u6cl865DwEUPXaTnDIUU6i640iqPyEdOUM0HZXl4k
         0S4A==
X-Gm-Message-State: AJIora94N+or93+8OHNuMQIDsxYd9c2308NY3/zWgO6sQZ5jW0puPXSL
        6459/bLtjj+pWV+Jf1Mj/ka+wQ==
X-Google-Smtp-Source: AGRyM1vPwQLpT1whbo/vMPp0t4ykErcdUKzGyeUSBtjebvJh9JnkbgixAK4/Q/LwHWbjIB/vcN8KwA==
X-Received: by 2002:adf:dc51:0:b0:21b:a045:9730 with SMTP id m17-20020adfdc51000000b0021ba0459730mr13008944wrj.134.1656340473269;
        Mon, 27 Jun 2022 07:34:33 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g4-20020a5d5544000000b0021a39f5ba3bsm10662853wrw.7.2022.06.27.07.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 07:34:32 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ASoC: samsung: s3c24xx-i2s: Drop unneeded gpio.h include
Date:   Mon, 27 Jun 2022 16:34:11 +0200
Message-Id: <20220627143412.477226-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220627143412.477226-1-krzysztof.kozlowski@linaro.org>
References: <20220627143412.477226-1-krzysztof.kozlowski@linaro.org>
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

The module does not use anything from gpio.h header.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/samsung/s3c24xx-i2s.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/samsung/s3c24xx-i2s.c b/sound/soc/samsung/s3c24xx-i2s.c
index c1a314b86b15..44e93dc16fc3 100644
--- a/sound/soc/samsung/s3c24xx-i2s.c
+++ b/sound/soc/samsung/s3c24xx-i2s.c
@@ -12,7 +12,6 @@
 #include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/io.h>
-#include <linux/gpio.h>
 #include <linux/module.h>
 
 #include <sound/soc.h>
-- 
2.34.1

