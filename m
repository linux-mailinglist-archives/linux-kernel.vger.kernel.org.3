Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8D455434A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 09:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351328AbiFVGsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350665AbiFVGso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:48:44 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38E035A9A;
        Tue, 21 Jun 2022 23:48:43 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id cw10so8361911ejb.3;
        Tue, 21 Jun 2022 23:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9DOoIhOIXLMpNcIvOgH0b4QaNFlGhZBdv3PWCfH2y3Q=;
        b=qV7gMAdSgelSWa7TFM6/x0Pn3f3imGFjcBspWKsqSR6NIIr/pf+lVvZE3iKZXMnuRG
         kdhAzuCYC+fLu06G9lXm8FEe0fHDsxw20bB9qXYITLi9BRiJ0bIg9OJ7bEr/gmd0Vf0m
         bb9tfvRSQGgoP/wCjsh052utMVrm4pjAsK3XhwXQeiZiaOMtV/uvPxkJqk4XQoI4Klx9
         yML4UcfP1wFfk8fU/AowEXYBlf4881Ce+nMIpTiqEGXcUOWno37ebdFO0USTjNIrSUAx
         aTt4BXPsqzHETONwmXc1fleZuOx9ne5K97uNIokcdRLMr/dIkkBUrpeWQLxK70kj1Iog
         w5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9DOoIhOIXLMpNcIvOgH0b4QaNFlGhZBdv3PWCfH2y3Q=;
        b=ZlZZ9IEUZtrlOILzaxYaAEYb+qHUZA7cPASkmJTq0NdjlTmxZpW1w7mNJQJ+N/Zj+S
         KRpz3M/o3qGGHO+zpNGwu/NRQTxaPDHcUNEcdu4mB/H2EOvOS8WgFakYf04AaioMNAdC
         HOM9lIbICg1LksinhKgeII+pCAKn1xJNGIyEtfyj6LgUURAVBgORMvD/sdMXq6iGRL/u
         pdGGOq+PXnpbiNyV3keCxgq4d92SycbaOL3VK3L/9IKqnbVB9cmMsCZHiX9XEmdtJgyc
         bnGZfo55AEUxKpXHArNIi8ND6ZDU4vFarCmZ+qy06UfofNJVZcpxT4OjM3m2kLLzD3Yb
         bRNw==
X-Gm-Message-State: AJIora9vuZYXsVVocSLe+W1i2qZQl7NfX4arXeEzu/t4KqK0RjyykMYo
        dPYP/3TGFVIGMVbONSNXKzs=
X-Google-Smtp-Source: AGRyM1scE35n8xZ+4qERsfvT4HLJEkrOBgu2EDwyloit1cuSCOWgK9XfPhZyBILW4l1ICBo28yajZA==
X-Received: by 2002:a17:907:c202:b0:710:8d0c:6e89 with SMTP id ti2-20020a170907c20200b007108d0c6e89mr1665564ejc.141.1655880522353;
        Tue, 21 Jun 2022 23:48:42 -0700 (PDT)
Received: from localhost.localdomain ([185.107.95.225])
        by smtp.gmail.com with ESMTPSA id sd12-20020a1709076e0c00b00722e8c47cc9sm1197148ejc.181.2022.06.21.23.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 23:48:40 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ASoC: wcd9335: Use DT bindings instead of local DAI definitions
Date:   Wed, 22 Jun 2022 10:47:57 +0400
Message-Id: <20220622064758.40543-3-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622064758.40543-1-y.oudjana@protonmail.com>
References: <20220622064758.40543-1-y.oudjana@protonmail.com>
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

From: Yassine Oudjana <y.oudjana@protonmail.com>

Get DAI indices from DT bindings and remove the currently used
local definitions.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 sound/soc/codecs/wcd9335.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index 7d40a61b03b0..3554b95462e8 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -24,6 +24,8 @@
 #include "wcd9335.h"
 #include "wcd-clsh-v2.h"
 
+#include <dt-bindings/sound/qcom,wcd9335.h>
+
 #define WCD9335_RATES_MASK (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |\
 			    SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_48000 |\
 			    SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_192000)
@@ -203,17 +205,6 @@ enum wcd9335_sido_voltage {
 	SIDO_VOLTAGE_NOMINAL_MV = 1100,
 };
 
-enum {
-	AIF1_PB = 0,
-	AIF1_CAP,
-	AIF2_PB,
-	AIF2_CAP,
-	AIF3_PB,
-	AIF3_CAP,
-	AIF4_PB,
-	NUM_CODEC_DAIS,
-};
-
 enum {
 	COMPANDER_1, /* HPH_L */
 	COMPANDER_2, /* HPH_R */
-- 
2.36.1

