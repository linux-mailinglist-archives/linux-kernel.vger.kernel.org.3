Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F53A5AC059
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 19:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbiICRnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 13:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbiICRmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 13:42:49 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801CD5852A;
        Sat,  3 Sep 2022 10:42:35 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id fc24so518195ejc.3;
        Sat, 03 Sep 2022 10:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=d90cBTaHglfa/L3UmwiIFS49uaF4cnaVMbMrPZWt4mU=;
        b=US5Ymhd9bM+pHZEy+RWB9EG+qVJy8Ozaj7Xadj5wyPsMwt6AM7ChtfgFmbb4BWASG/
         TMgJtFSGdEZaSG0aJh55FagneR0uvkXpw8hL/+upfXpxYXMsIpDMbAnZvdSalUy1SE9Y
         2B8LTt+sjNcGVTrHWWt94ks8xoqOOD7DX2o+Q3K69pGI3kkvTMVG6GPCXHqQhkX4iAvT
         qs1zo00tBZAsccRQ3RnZte0tUpHNLEAX3M5Clm4zJxadfJ5/g2fbv0d+OCP6BWPBQYro
         qU7nD9TMW4xB3gkBAJF7St5jGhdVdaCMhpoDaCegwEvqlPYZm5A76fZkl4s4NN0M6riJ
         QULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=d90cBTaHglfa/L3UmwiIFS49uaF4cnaVMbMrPZWt4mU=;
        b=F08ghTxFH6TZycJTnFfH0ldTq9PI5WAO88LNC2lOc1/MlFjtYDFApljVODiTXOF0CR
         1MPLNBnV7FKq5b3e0zfbQGlVdq5eWBOmsa/X8c2vFk8MP8CNigBN7n7jMlrzv8yTEONh
         j4669SB57CF8zbluRYyH7wng0ZkMV7lBJr98RWYp5mZys0S5RigF3gL4cftAXfMOrpV5
         gh+OyIth3YQRHb/9fqYRK2lm/gstIsM6ip/6YBR7e7RCZ/i8/6BpnvdiSah5zIcJt6Cb
         aAN4gDUQHVkuAo9HwoNraCOkE/uCOXtkKYjAQJoQdtAQdnRsAJbo/rMQJm8rD9nWm4P3
         Pw8A==
X-Gm-Message-State: ACgBeo3MXwLQOaErI/Ju96HLoZUazsFu31cd7KDNhupT77g4UiPEYGIy
        oB+Q+RYJUe6BJQN4sPRtAoQj9qTSgklTow==
X-Google-Smtp-Source: AA6agR67nlD/IWBkek7VE3gtKSTY7s+2KevCI5sqqIokH7Q2aDWKF9uhimnyr4Hl8CUxPYnRpFfn8g==
X-Received: by 2002:a17:906:9b8b:b0:741:56d3:b8fc with SMTP id dd11-20020a1709069b8b00b0074156d3b8fcmr23859088ejc.337.1662226955358;
        Sat, 03 Sep 2022 10:42:35 -0700 (PDT)
Received: from localhost ([77.78.20.135])
        by smtp.gmail.com with ESMTPSA id r13-20020a056402034d00b00447c89a63f4sm3526853edw.35.2022.09.03.10.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Sep 2022 10:42:34 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Bartosz Dudziak <bartosz.dudziak@snejp.pl>,
        Maxime Ripard <maxime@cerno.tech>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/9] dt-bindings: arm: cpus: Add kryo240 compatible
Date:   Sat,  3 Sep 2022 20:41:46 +0300
Message-Id: <20220903174150.3566935-6-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220903174150.3566935-1-iskren.chernev@gmail.com>
References: <20220903174150.3566935-1-iskren.chernev@gmail.com>
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

Kryo240 is found in SM4250, the slower sibling of the SM6115.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index a07c5bac7c46..5c13b73e4d57 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -174,6 +174,7 @@ properties:
       - nvidia,tegra194-carmel
       - qcom,krait
       - qcom,kryo
+      - qcom,kryo240
       - qcom,kryo250
       - qcom,kryo260
       - qcom,kryo280
-- 
2.37.2

