Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5335B59850F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245549AbiHRN7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245533AbiHRN6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:58:39 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CEC30F6D
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:58:31 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id m10-20020a05600c3b0a00b003a603fc3f81so994894wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=DkLvDp1vbSt269b1f6wV/xHq6I5W5tUasXS/Aq5agqs=;
        b=LvxJhbZ6hr5Q2ii+L3kadNeOWeoG5D/FRC8u3hJyqQwn8KY9wk4Q6mmmw9SmEoFgiI
         1A9nak6aNsTfKPoxTmiP8bAj7jgjWGbezpDDgErzWsQBAHTp1SwYHUf3dQbU6vFn8fwT
         TJiZeqUcHvJFhLICeQQVxSqdehQWisuCSqeVXbBRcv6IKGZBF+kDS6EJfh8XY+u8EQj+
         34XcG4p6ydPX4/RSuom28ALvfAIu5F+0sqjXR66gFUs0ImW738oWVFrdZ6Smo/IMxKkD
         jYqWyCOGd5HPDQKxft8vg6GKkkRiuzyPp6IBIzc6IUL0+nQI61v5/jcaw659cMjScm67
         G/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=DkLvDp1vbSt269b1f6wV/xHq6I5W5tUasXS/Aq5agqs=;
        b=W0Qsu8eMsxFLS9E8bXRK0FaAuISiLB+o2mt6YTzyWNzDG30f9FPCuRoyKF62HZH2wP
         LlIWlWyM95rb80wydw5Nq20wdYZ2bIml/GOeCYUPp0aK4+U2bI9oawOJqAZH1wW91kxK
         S1y5eW88smf3UK59I/exY1yioE68TPQp5gi8nIvB8jzXC4E/qjnOlRE+GEunCxbKF4sU
         /LPkrFCuyxOY+pR0FOuaSQvN83l5b4AivXkLzsu0ISbSZCwFPzTaQjS1dmvVRRAgADaN
         aAjUhoYVwsP4MZBz+CZQ2Y0COnTdGiDCCsMjpVwuAeOLNthEQW7TRDF8TIzUt6ME/D7Y
         jiEQ==
X-Gm-Message-State: ACgBeo1jCCWNxSxxRqSOo6/syQjzkc6UGx4Z9j9NAY0vdtrZlfUCvCoe
        okxt4bWV6dSeD6Zaqxz0nPLx8A==
X-Google-Smtp-Source: AA6agR5ASJ0+kWLVeryJGGbjeE1j1nLglNJ2ljbdzAxpXDLaWFyyHIY1mUHqsVKUig1QIWMunzFVeg==
X-Received: by 2002:a05:600c:a4c:b0:39c:6517:1136 with SMTP id c12-20020a05600c0a4c00b0039c65171136mr1991210wmq.12.1660831110329;
        Thu, 18 Aug 2022 06:58:30 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id l24-20020a1c7918000000b003a5ca627333sm5335937wme.8.2022.08.18.06.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 06:58:29 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/3] ASoC: dt-bindings: qcom,sm8250: add compatibles for sm8450 and sm8250
Date:   Thu, 18 Aug 2022 14:58:15 +0100
Message-Id: <20220818135817.10142-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220818135817.10142-1-srinivas.kandagatla@linaro.org>
References: <20220818135817.10142-1-srinivas.kandagatla@linaro.org>
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

Add compatibles for sm8450 and sm8250xp based soundcards.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/sound/qcom,sm8250.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
index e6e27d09783e..317340215c24 100644
--- a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
@@ -23,6 +23,8 @@ properties:
       - qcom,sdm845-sndcard
       - qcom,sm8250-sndcard
       - qcom,qrb5165-rb5-sndcard
+      - qcom,sm8450-sndcard
+      - qcom,sc8280xp-sndcard
 
   audio-routing:
     $ref: /schemas/types.yaml#/definitions/non-unique-string-array
-- 
2.21.0

