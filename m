Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9933355510C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376596AbiFVQOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358374AbiFVQOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:14:02 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FE425E9F;
        Wed, 22 Jun 2022 09:14:01 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z11so18444322edp.9;
        Wed, 22 Jun 2022 09:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BPDXlvqV0AxMWt136en9f/MZtZ2FaK26EatF9Qx87KM=;
        b=hf8j8FP8sSZV8bbnqKdDoJXLx/IEZmAA8Jaa7wqvMhUaHYLq7K36mR7xDrLaIUE+BJ
         adS6FpovfS8Ut0BA2qx0T0HI3g1rm6mib96GmJhyBkC2DgWLEOzzM3GDt2xI7Xo68lcp
         hMDIQ2wFarYLSsxe6KPVqoYxSUfP3HiTrfUAissQ1JRwIgKnWtIJfGklxJcmY9mYujWI
         ruGjt7mQKz7apoj5WXYGzb37tWtqr6bwdQW0GYFk3OL2RAoIYXxbJvXZZwxTL1Q3G/Qu
         bvfVvlQrmh2Aj0mwLQTyP07oDZtWDyZuZpyxVM77ODlI6xx8IIeCDbgMGh/7FsxeZOKn
         wB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BPDXlvqV0AxMWt136en9f/MZtZ2FaK26EatF9Qx87KM=;
        b=tWQtanii852WWSfKDaobKhsuVLXk9xn8nrUEhrAspxPbeOVjU0IRJWQ2qt/kao+MXS
         Y6ER1zIuQ2jxT2eaw5JgfT4DalYSVoY43PQsveGR7Dk5+w1q7LR1A+eH04AEoCLVRcoA
         /kpr0lT4f1FjGN9n+D95JKHEuLL/Qf8EVLrCp1weBHZLkGOtrTZHM4mns94XT5fS0DIg
         K6UZ60Vw6+h4G/0Xd2QDw/iBZojc0rciwdoYugVN3/mATpN30Uae1wKk+0WMsdrjL1x1
         aZt4NS+oqrUHOusluAQ8xSF79tMQkUCCh1bdUIGKjTYlg7bRn6gNADFbHefdleDEyBF2
         u3aA==
X-Gm-Message-State: AJIora+hQRfvMJu1KCKycxvECeYBFO18cQDJ9nL+q5OBmci7D0J3XbPu
        yAqWInDSUCjpOl/6/K2xVCWEZFC5tIDC7g==
X-Google-Smtp-Source: AGRyM1s0xvuP9BhHEnaO03VpmTSeJV1TWPz57NVjo6q1R+NUICF3HXpZKVue8kGa+VHd1zFMVrmrhw==
X-Received: by 2002:a05:6402:28a2:b0:435:798e:2988 with SMTP id eg34-20020a05640228a200b00435798e2988mr4965039edb.217.1655914439781;
        Wed, 22 Jun 2022 09:13:59 -0700 (PDT)
Received: from localhost.localdomain ([185.107.95.225])
        by smtp.gmail.com with ESMTPSA id sd14-20020a1709076e0e00b007072dc80e06sm9576036ejc.190.2022.06.22.09.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 09:13:59 -0700 (PDT)
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
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/3] ASoC: wcd9335: Use DT bindings instead of local DAI definitions
Date:   Wed, 22 Jun 2022 20:13:21 +0400
Message-Id: <20220622161322.168017-3-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622161322.168017-1-y.oudjana@protonmail.com>
References: <20220622161322.168017-1-y.oudjana@protonmail.com>
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
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

