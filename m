Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1092D555105
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357891AbiFVQOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbiFVQN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:13:56 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C029BC2B;
        Wed, 22 Jun 2022 09:13:55 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id c13so20139110eds.10;
        Wed, 22 Jun 2022 09:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zAlPejfAQCxvtnqb2e7esLuuwfx9+dbQueVecsqGTnM=;
        b=AdqVL1fn2Nch6BaslzUJtV1cx1jD3oDKzhYBdgH8XXPW7Xs/yUzclctxexMRz0ye4m
         T4+zMvA3dqhGFEjOGUt9HGdpRfluYH924o4KUB1E2cWq+dT54Ne3JHFOTX6SO6w+CZON
         AFuUf90TWAAUW8S5ikQSQGJOLKHpqK33JV3nGHGYQ6L99vxL1sm1tvNwI5C4SZH8hDoK
         Db+DsfftmTHV892LT4/7ELlpP81nPbF8nswVSGRlA+CYsHX2gLoNierd43ChQUymGQjU
         8TTSXbYUMUmsfdb9oPormsYfVOavoi+HSqm6J2YvwZhjY/dCf44ObHmrTFNQXSpNTp4u
         /Gjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zAlPejfAQCxvtnqb2e7esLuuwfx9+dbQueVecsqGTnM=;
        b=h5FeQ9dyR8lopkLbEDyoXUVw96u6d3hTTbZW5O5SjX9XrxgNoGuLG/jK599pypY1gM
         d3IUXimy5XgFtIonXoF9ZwrqruGwWbYBEiqfMr2ACnHwGqZE9cz2MuWd8uGVtEaHHfQ4
         sk8+rv2AGd7ZvJ1+6pFRqIOTlWDunCwpi6cbgcium2A4GETs9YP49UWGDuZdi4y36PHp
         ky6IRzIhUZ4Pt3rYTCvyfle8zXl0KaUCLu2aQk+UCXYrlJli64Kqk3jL7XBtj50Z2grM
         4AgHMmQJqqzHbQY9B9BjZbSkqj8Ykx/xw8zhrzWZl9aGqKs2w6GaFw6xTzDjl4sTHjZr
         SCTA==
X-Gm-Message-State: AJIora+siqiFyVrIxBN4Lztx8kc0mZy2OEFAUFVb3WbC3Wgq24zjdEBp
        MxOaUbrYkYXylcpRt7OXRlw=
X-Google-Smtp-Source: AGRyM1tUeZKhkR6l8vLpmW0F9+thSOWMhMCzrTst6cJhHntejTBuoEAhk0TNhif3zETWLXT4QGdt1A==
X-Received: by 2002:a05:6402:2750:b0:435:ab9f:1235 with SMTP id z16-20020a056402275000b00435ab9f1235mr4972683edd.188.1655914435429;
        Wed, 22 Jun 2022 09:13:55 -0700 (PDT)
Received: from localhost.localdomain ([185.107.95.225])
        by smtp.gmail.com with ESMTPSA id sd14-20020a1709076e0e00b007072dc80e06sm9576036ejc.190.2022.06.22.09.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 09:13:55 -0700 (PDT)
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
Subject: [PATCH v2 1/3] ASoC: dt-bindings: Add bindings for WCD9335 DAIs
Date:   Wed, 22 Jun 2022 20:13:20 +0400
Message-Id: <20220622161322.168017-2-y.oudjana@protonmail.com>
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

Add bindings for the DAIs available in WCD9335 to avoid
having to use unclear number indices in device trees.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes since v1:
 - Make header guard match path

 MAINTAINERS                              |  1 +
 include/dt-bindings/sound/qcom,wcd9335.h | 15 +++++++++++++++
 2 files changed, 16 insertions(+)
 create mode 100644 include/dt-bindings/sound/qcom,wcd9335.h

diff --git a/MAINTAINERS b/MAINTAINERS
index b774f21828f7..2bcc3cc129c5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16366,6 +16366,7 @@ M:	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 M:	Banajit Goswami <bgoswami@quicinc.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Supported
+F:	include/dt-bindings/sound/qcom,wcd9335.h
 F:	sound/soc/codecs/lpass-va-macro.c
 F:	sound/soc/codecs/lpass-wsa-macro.*
 F:	sound/soc/codecs/msm8916-wcd-analog.c
diff --git a/include/dt-bindings/sound/qcom,wcd9335.h b/include/dt-bindings/sound/qcom,wcd9335.h
new file mode 100644
index 000000000000..f5e9f1db091e
--- /dev/null
+++ b/include/dt-bindings/sound/qcom,wcd9335.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef __DT_SOUND_QCOM_WCD9335_H
+#define __DT_SOUND_QCOM_WCD9335_H
+
+#define AIF1_PB                 0
+#define AIF1_CAP                1
+#define AIF2_PB                 2
+#define AIF2_CAP                3
+#define AIF3_PB                 4
+#define AIF3_CAP                5
+#define AIF4_PB                 6
+#define NUM_CODEC_DAIS          7
+
+#endif
-- 
2.36.1

