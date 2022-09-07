Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331615B01D7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 12:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiIGKX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 06:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbiIGKXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 06:23:40 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D44A19C14
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 03:23:18 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id m15so2028810lfl.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 03:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=DUZnAOXvnpwBSyYKpy7XC2+oubbqgditxTlrj9yISaE=;
        b=YKseDWEuQrei+DMXjAdhXWNkjPj/XhJlvCb3QGZ5L61lPym0S4hmAc/ek+LGwrpF6J
         TnQbf3UkUJUROG2eAEV0vphFJ3aIrx/O9wflRYVSJznxfGR4aznKVL6SoTRo7/IhPsUD
         s2+KzzSc5z/ivHykL5YgjKqTiVIQCteNe0H0j3odZoYhn0eft/dqcuGyQFikq1+h9Lq8
         X1iuaHT48VeuDWI2i0OvG2AypADRYKtAw3eWxTD5lBxUU8wp0fWvWEnMql8mAuC6YeHd
         41/6ZmqShTypXD+MP7XsD8swHbFbLal1AotIaRThcfR3zoCJzJTw5G13iBJK5gHMc9j8
         UCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=DUZnAOXvnpwBSyYKpy7XC2+oubbqgditxTlrj9yISaE=;
        b=M5WmudqdKY/QcVdb2kGLeWmQer3nCDLLUhTvnktf3dQg0PsdHzqC/AEo0ZBogY+mwm
         U5X45PBSxwRYnD9nOwOuOxlSdJOspw6nzs9+D3/gfbwc0QPLTkWYEISPbQKIw+9g3TbT
         cKmEjUxdiRyHhvJPEf66QAiWTrtlBmL+AfgyNpyMc7e8kCaPTkrW4vYL8GNIfzdMUuf9
         4UmG+rYo62Og3y1cZgoC+4eqxq6omPclo6nSlseB7MG/okdO2aMZhVPBVeziLuyyti6f
         AunKwyl9HehjdThNxp/lEjhEDbjJbTO4uCJoh/4JJr6WRDY1tAYQCvE5xnnZc/QJeC+e
         jOvA==
X-Gm-Message-State: ACgBeo1qjZHomuw7+zXm1MzvAKgxJeKYAiWXsxAtaPBkVZnOHeGGTK8V
        ZOzIMk2jjqx1l/PvqeBOg47Nlw==
X-Google-Smtp-Source: AA6agR6tbubvvq8/DfaCTr0+Pf575TvwyTL1PYEUWtKKonjTxXHultN785WWU5YW7mRViESeUxF52A==
X-Received: by 2002:a05:6512:3f0a:b0:492:da2e:ce69 with SMTP id y10-20020a0565123f0a00b00492da2ece69mr817185lfa.269.1662546196496;
        Wed, 07 Sep 2022 03:23:16 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id w22-20020a0565120b1600b004946d1f3cc4sm2378309lfu.164.2022.09.07.03.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 03:23:15 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ASoC: MAINTAINERS: add bindings and APR to Qualcomm Audio entry
Date:   Wed,  7 Sep 2022 12:23:11 +0200
Message-Id: <20220907102311.38428-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the Qualcomm Audio maintainer entry to include sound related
bindings and the Qualcomm APR/GPR (Asynchronous/Generic Packet Router)
IPC driver, which is tightly related to the Audio DSP.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0350effebe8f..453dc6fd0b80 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16710,6 +16710,9 @@ M:	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 M:	Banajit Goswami <bgoswami@quicinc.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Supported
+F:	Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
+F:	Documentation/devicetree/bindings/sound/qcom,*
+F:	drivers/soc/qcom/apr.c
 F:	include/dt-bindings/sound/qcom,wcd9335.h
 F:	sound/soc/codecs/lpass-rx-macro.*
 F:	sound/soc/codecs/lpass-tx-macro.*
-- 
2.34.1

