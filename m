Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23D54CD89F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 17:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240448AbiCDQKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 11:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240150AbiCDQKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 11:10:32 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C9F150404
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 08:09:44 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id x15so13362486wru.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 08:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mpcaFFM4Vlil9J8sKnIMDV3zVV5Y4u+XZLqTyb1B72k=;
        b=rkdCrZjmyS/RXcib6D6bM3pF7QZLt8bqrNCOt3MH3NGpjgzQNxvLEBsFXyfon8z7zT
         OGEJTdpnHH5Q0RVO4gKNmrXIvcA5xCNdRPNZHpJfeABZn/9VeC0UqkVFumhHce1fGjBD
         tlqjw3aasK96+a73ofc0GYsB44dTRHopnqC1HcwMBLUbmnVpwAtqDHkcYmS3GnOKT7Mv
         dPnOzmJECWkyDDds8fiUokCXgI0jA/KEGTAB8F1kyhjEd19fJZ3J/yrtPBZJ84fQWn+D
         B/6PPv+alt+3hW3wyAI0hpFI+oJYmFFRRC/ggKLBn/TWTRfqlaE7wU5Dc5r4E686eAMH
         MItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mpcaFFM4Vlil9J8sKnIMDV3zVV5Y4u+XZLqTyb1B72k=;
        b=de3fCmDM/4OedSu5hM40JLXb5LSMoTsM9mD/7AHBP6SO2TKNd0CJlU87ABHHTGk17C
         0EVeE+Osm5XQoCXsnOJHV3FB6Tovx4xVLHow5eQDAOgV4+pesB8IwUsoafbu4dAH6fdk
         vi9ttm4lSGztQbtDSQS9mJxuhanub4FgQLL3onqgMrWPk84ZurHtmgxFhpocrIGllQ4/
         U5MBQOLgRuV5j0BmSS9raGToq95vkBuqw0N+4Kn4elsmZiZbqQ4goEEDWTUYFaLGP8Hz
         mtFOl7yvnTEDBkyj4K1lnK5FV7EOVjqxBD+gAGubbfogvGhlP8BJscuFAcDG6I/p0OZO
         qWmw==
X-Gm-Message-State: AOAM533oz5x8+QDJujCmmgYG8CXECXv9gjqv5O5uQ2e46cQKkp9PtsUo
        vrOgYEtWUBmHmRTrTTVnmYwupg==
X-Google-Smtp-Source: ABdhPJyGwmzyIoQ9ro/TZ+vxg/5BiF5i9Kky2BCfEyUx0I0fCDIdJ2pVlz+q5Scz0R5Q4+qf1ka2nQ==
X-Received: by 2002:a05:6000:1b07:b0:1f0:248d:bc1d with SMTP id f7-20020a0560001b0700b001f0248dbc1dmr10801281wrz.534.1646410182680;
        Fri, 04 Mar 2022 08:09:42 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c22cb00b00382a960b17csm10275145wmg.7.2022.03.04.08.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 08:09:41 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] ASoC: qcom: select correct WCD938X config for SC7280
Date:   Fri,  4 Mar 2022 16:09:34 +0000
Message-Id: <20220304160934.32010-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
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

SC7280 config selected WCD938X instead of WCD938X_SDW Soundwire codecs.
WCD938X_SDW actually selects WCD938X, so directly selecting WCD938X results
in unmet dependencies and below warning

WARNING: unmet direct dependencies detected for SND_SOC_WCD938X
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=m]
 && SND_SOC_WCD938X_SDW [=n] && (SOUNDWIRE [=n] || !SOUNDWIRE [=n])
  Selected by [m]:
  - SND_SOC_SC7280 [=m] && SOUND [=y] && !UML && SND [=y]
 && SND_SOC [=m] && SND_SOC_QCOM [=m] && (I2C [=y] && SOUNDWIRE [=n] ||
 COMPILE_TEST [=y])

Fix this issue by selecting WCD SoundWire codecs instead of component driver.

Fixes: 57350bd41c3a ("ASoC: qcom: SC7280: Add machine driver")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 0cd0dae5c545..82f5eafb2f6c 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -193,7 +193,7 @@ config SND_SOC_SC7280
 	select SND_SOC_QCOM_COMMON
 	select SND_SOC_LPASS_SC7280
 	select SND_SOC_MAX98357A
-	select SND_SOC_WCD938X
+	select SND_SOC_WCD938X_SDW
 	select SND_SOC_LPASS_MACRO_COMMON
 	select SND_SOC_LPASS_RX_MACRO
 	select SND_SOC_LPASS_TX_MACRO
-- 
2.21.0

