Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055FF55CEC0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237314AbiF0Oeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236204AbiF0Oee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:34:34 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DE6B7F5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 07:34:33 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id n1so13330834wrg.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 07:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xHFZz8RZkVB6QrSDdCB+Dgt2NiSqLKXwv65gqyA505k=;
        b=vRhaRSdGeHb3qNVgG98bODYQGIV5R8Xntd1otqLzy9xvwjDNXNc4ycsq4AiYSvNrUx
         RPNT/s++mVAUF/bVaavfPrs8sy123BK+8RvtnkVaEXv1AAumF9j6TTyYP1k26A0EuRs+
         eOY+IdGjdkyvYBXdhuSh/7ZOmCMzUszaIV/W66PpYFVVKvdTnJX9/5MrsGXSslaXlhBH
         ABNGZdDMQa8bGqgi1tu+DCCrDN+EsJpo+JBwkCEaX4NhPWC6HnH1Ysu58rN22VTNYHXE
         w73JVJh1NUVGL9AA0DGuaQ9jVi7ukJ+hMJQcG+kn1ttzgAUYj9+IOU9vNh7zpQDf0bpt
         1AUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xHFZz8RZkVB6QrSDdCB+Dgt2NiSqLKXwv65gqyA505k=;
        b=LhNOAc3TChkUl5ZAkpSzQ0BJOxRvAhL/vxLaISyuyoXmn85JET2mtRzBGrClsYW/gj
         kgBOQbzoT/xSSNtHzYuLVGa7VWz1TpPnEh/SJlNeF5//7Q0dojPntBIblhBO7L+jrTyL
         hK6fMuEC5VAbxRx2fv9ovgpIqZVRVo+5eSGCvyAxqrYUCvVApqbgOVDtAksE2v7yceqv
         0l0duJUlajAhMpAtNiYZS6q0vSRAOMFMImCx5M63q70k2lnBw1Ps8kmSgOiyP6hq4INi
         X0l+4je4azsBMbMT82s98TUgigpQdiY7z0CHo3AnHWjFOOuMpumpaLdZxX7DFNkAN+gZ
         ynPQ==
X-Gm-Message-State: AJIora+/wsIRKj0Wj15wqRcOklUZqvVmWMZZXu1TpOIIPj8FGoSQxbPW
        DMZctV4cubKpJqpGW5EZLdwtWQ==
X-Google-Smtp-Source: AGRyM1vePo96avYvzN+/VbfXPpJbfFzcJOWYoI90juxd+OLG/WT4wbBA6NER5THHL9r98g5G23tATQ==
X-Received: by 2002:adf:e182:0:b0:21b:92c8:b045 with SMTP id az2-20020adfe182000000b0021b92c8b045mr12577551wrb.219.1656340472265;
        Mon, 27 Jun 2022 07:34:32 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g4-20020a5d5544000000b0021a39f5ba3bsm10662853wrw.7.2022.06.27.07.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 07:34:31 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ASoC: samsung: s3c-i2s-v2: Allow build for unsupported hardware
Date:   Mon, 27 Jun 2022 16:34:10 +0200
Message-Id: <20220627143412.477226-1-krzysztof.kozlowski@linaro.org>
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

There is no particular need to restrict building of S3C I2S driver to
supported platforms within the C unit, because Kconfig does it.
Removing such restricting #ifdef from s3c-i2s-v2 allows compile testing
it on other platforms.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/samsung/s3c-i2s-v2.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/sound/soc/samsung/s3c-i2s-v2.c b/sound/soc/samsung/s3c-i2s-v2.c
index 1bec72246ed0..2b221cb0ed03 100644
--- a/sound/soc/samsung/s3c-i2s-v2.c
+++ b/sound/soc/samsung/s3c-i2s-v2.c
@@ -21,17 +21,6 @@
 #include "regs-i2s-v2.h"
 #include "s3c-i2s-v2.h"
 
-#undef S3C_IIS_V2_SUPPORTED
-
-#if defined(CONFIG_CPU_S3C2412) \
-	|| defined(CONFIG_ARCH_S3C64XX) || defined(CONFIG_CPU_S5PV210)
-#define S3C_IIS_V2_SUPPORTED
-#endif
-
-#ifndef S3C_IIS_V2_SUPPORTED
-#error Unsupported CPU model
-#endif
-
 #define S3C2412_I2S_DEBUG_CON 0
 
 static inline struct s3c_i2sv2_info *to_info(struct snd_soc_dai *cpu_dai)
-- 
2.34.1

