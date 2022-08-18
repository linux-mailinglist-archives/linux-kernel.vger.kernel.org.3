Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2CAA59849B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 15:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245040AbiHRNqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242050AbiHRNqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:46:46 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDC5B56D0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:46:44 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id z14-20020a7bc7ce000000b003a5db0388a8so2810520wmk.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=9Ds9SCyWv8tIHrUgmAXNfm5+EVXzQeANVhipst31cuo=;
        b=tvrEW8/AFy1sphi52sXodEZD6wK9GmoWGc+ximO7cDQvzygeAaMtzKMn2ziNYCiTAW
         UK9NR0jh+gK8Odieb+jUppFmQgp4fq40x4jb4KQG9ziYLy6dcS6pQwW3CLOAdHRD6pj4
         4J+ExVTNOdwIH1Pe/lYa7q5N90EuGJdhZVXEdCplaB7umGhSeEqOAekqEpbiTqky5xEj
         opvnIwdmJZkpnIYgshi7L8c0o+KGDDOZ11x4Tx6ko3eX2GzKWrhlL+R5LHAbbXa6RJyg
         X3AKIiF9eyBTuUavO1EHAF/365xQPu9Sr5T1vBSY2oQPyGuxyLOIXb+m16isyzVnQ6KD
         +LGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=9Ds9SCyWv8tIHrUgmAXNfm5+EVXzQeANVhipst31cuo=;
        b=o8eVdjTFgD0jTpmCq1ix3DCs7MSvQendO98EhagYH4yiHTIOgfcHJggEVP9ilqRsMA
         uv5/254iVS1+apvDXz8Yv6M2+OSZGOmwr1ys7G4Mx1YWthpmhSwh1fSGGClCI2ui7A+f
         WSI6/FhHgRCzp3imYjKjyxQkg6tvHt8z0IG9ia8zGAM5unHFm6vvz7L+pIK9ClwDOXCD
         98hFnBOtPNvfwfY2p0iUEedK1n1qR/ta8q6a/fcbAgq5PiHzOuiqfWC7yaxM8wCQ7sQy
         2Kl3EP19UzHH5S6e5LAyIk/21VpKKmIlyslHOSEqVCDHrzgkAzU89LMGlA1ahcTPlfkl
         RyTw==
X-Gm-Message-State: ACgBeo2uZYSkOprScgDOsUNIkViiHvejwSndP/sx9iPvK32n1+U2rCQb
        EsyEyeSfg9PeNr9QhjChkS4uRg==
X-Google-Smtp-Source: AA6agR6Khq9CsT5T42xFf9oRrqQfOqFWWEfHyu70AyJ9wlCf9tg/6xeEEvxs4pqI2+lWO8ozK6D0Ig==
X-Received: by 2002:a1c:7708:0:b0:3a5:5543:cec4 with SMTP id t8-20020a1c7708000000b003a55543cec4mr5270398wmi.47.1660830403389;
        Thu, 18 Aug 2022 06:46:43 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id v5-20020a5d6785000000b0021e47fb24a2sm1454549wru.19.2022.08.18.06.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 06:46:42 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/6] ASoC: codecs: lpass: add support fro sm8450 and sc8280xp
Date:   Thu, 18 Aug 2022 14:46:13 +0100
Message-Id: <20220818134619.3432-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

THis patchset adds support for SM8450 and SC8280XP SoC.

Tested SmartSpeakers and Headset on SM8450 MTP and
Lenovo Thinkpad X13s.

THanks,
Srini

Srinivas Kandagatla (6):
  ASoC: qcom: dt-bindings: add sm8450 and sc8280xp compatibles
  ASoC: codecs: wsa-macro: add support for sm8450 and sc8280xp
  ASoC: codecs: tx-macro: add support for sm8450 and sc8280xp
  ASoC: codecs: rx-macro: add support for sm8450 and sc8280xp
  ASoC: codecs: va-macro: clear the frame sync counter before enabling
  ASoC: codecs: tx-macro: add support for sm8450 and sc8280xp

 .../bindings/sound/qcom,lpass-rx-macro.yaml   |  2 +
 .../bindings/sound/qcom,lpass-tx-macro.yaml   |  2 +
 .../bindings/sound/qcom,lpass-va-macro.yaml   |  2 +
 .../bindings/sound/qcom,lpass-wsa-macro.yaml  |  2 +
 sound/soc/codecs/lpass-rx-macro.c             |  2 +
 sound/soc/codecs/lpass-tx-macro.c             |  2 +
 sound/soc/codecs/lpass-va-macro.c             | 72 +++++++++++++++++--
 sound/soc/codecs/lpass-wsa-macro.c            |  2 +
 8 files changed, 82 insertions(+), 4 deletions(-)

-- 
2.21.0

