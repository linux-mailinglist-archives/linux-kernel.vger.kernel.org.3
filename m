Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E87554365
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 09:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351290AbiFVGsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350539AbiFVGsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:48:39 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC91B35262;
        Tue, 21 Jun 2022 23:48:36 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id v1so32028471ejg.13;
        Tue, 21 Jun 2022 23:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u1eiPXpTeoJ4YK94xfC/4guXF7vZMwFhVUYu4kxiL+k=;
        b=VkjSZU+ZIalRBcg/aY9otvwjSGkG2louwosC9Z+WhTggAKAhLVvFnMb0KoB2qHcTjY
         B8flVc+KaVrqbbt153meF3pQFHuk6BnzUnvMPdFDzVnO97+3OcLPM5ird6+oXmE2SF4B
         MfIDi1MJj6n5DUGRPMiQGJGyU7QW15JmEI5jhld3HM/sRkORe/9MHUok7oxoePxGP5Y2
         KkihqCGzT/yc2rhIQaaCT5IxizmniMdASV7EZSOXM6VeY+nhkrK5X+A7L13kmX+O/jVx
         caAxD8GeETvoeM26zApSyBXcrMAAyWDzn8vvnJYJwyM999MPX5m4/CP5p0BNsi6lP5Fl
         okDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u1eiPXpTeoJ4YK94xfC/4guXF7vZMwFhVUYu4kxiL+k=;
        b=av9Z7zWwXbCK/kGwNWpaELJjWH5xUTE0cw7p8Yj0A+z/V/wpTw8C1iyEpSQsgdrZAh
         aTjYpUjmxLE3D09RlJdpiriYhbIKUbw3IxDRJ5XtUoZXqVNt5L/jTPHrg/Lyfs8K1bgD
         H9epuF5iN6yjC1sg/WwKH0/5/uJgZky/x5wsUex4L2/J/ZqobvcIrDwDcGelaPMF8rTC
         aCV4fTD4SMs5RLwgxA5XmaNJVO1BLdYSU/MSYdteisccisaE5YMBD8aOz+q3rLZp0E7B
         PFFHPsf1V1RETBRtKdAOfLSI8yAsIE8fE0mgF+fMs0s/GaVmz8JGdDTcjsf3p5lMnQGJ
         Vpjw==
X-Gm-Message-State: AJIora+Vmi9gFb8X6WQhjojzwzp2DVsUuO2H6GbSB+H87EL9UdYFk3Kw
        xpF2h+9PsfGbVGaio1Pp92c=
X-Google-Smtp-Source: AGRyM1vA2jfPhbVXwp0p2yLq5X8upNLnqULE7yWgNJaNCX+6/OXo9Ji5EpptSNXb6UAFCZV2uzeHzg==
X-Received: by 2002:a17:907:1c1a:b0:705:3158:ab07 with SMTP id nc26-20020a1709071c1a00b007053158ab07mr1660279ejc.767.1655880515522;
        Tue, 21 Jun 2022 23:48:35 -0700 (PDT)
Received: from localhost.localdomain ([185.107.95.225])
        by smtp.gmail.com with ESMTPSA id sd12-20020a1709076e0c00b00722e8c47cc9sm1197148ejc.181.2022.06.21.23.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 23:48:33 -0700 (PDT)
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
Subject: [PATCH 1/3] ASoC: dt-bindings: Add bindings for WCD9335 DAIs
Date:   Wed, 22 Jun 2022 10:47:56 +0400
Message-Id: <20220622064758.40543-2-y.oudjana@protonmail.com>
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

Add bindings for the DAIs available in WCD9335 to avoid
having to use unclear number indices in device trees.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
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
index 000000000000..709d33ca748d
--- /dev/null
+++ b/include/dt-bindings/sound/qcom,wcd9335.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef __DT_QCOM_WCD9335_H
+#define __DT_QCOM_WCD9335_H
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

