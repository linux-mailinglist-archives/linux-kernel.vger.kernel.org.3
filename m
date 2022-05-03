Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370F35188A3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 17:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238584AbiECPg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238563AbiECPgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:36:24 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6996C2CE1A
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 08:32:51 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id q8so18111255oif.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 08:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XnQmOhsCZK19KFsjaZWzKreHbtLS7E4MAuj6me5xfA4=;
        b=e93gker8XSUGtP9FNQzNbA3o8jNHWWcEose726ZqruHmgrvDB6XNDCXe7pZbHRDROa
         qYb/NaGqpYxL4Z8sTqsoPbLPcLSrje8PJNt043evZevPWI3kIrBFYKul4LicV+pvUZrA
         jjRtIlggoU+i0AyhjtBiCCEXSo1/wpZADFzanrftOTBWJG6Q+DUQyuNmTve/RNnbBAIH
         1HvGNirA6jfGl0osjYrSghaU6VKQtnqGP4RIVWaM3typQ2AbuUkNl5i4UzbJrkBz5uZ7
         BwOKF7idQCqwcT6+PnX/vwDFwMW2xnU3c5VClxep6rw5EeZKnA1M7pWl5yI6ZsMRBwQs
         nDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XnQmOhsCZK19KFsjaZWzKreHbtLS7E4MAuj6me5xfA4=;
        b=aVFBbBu/+kFfwLBuQwrGM85xZv90+hZUqrqFDtm9yQl9Vy1/iye7Dfq9YkxbR7pFMC
         qea3UkRJVkk48n2KWvePhnfxwRiisxiKszPhCUBQJeC+iIEzUtgcyXJQd8djqf4uB+7e
         4Q8fZG57e3WWZSMRU5aSPDLPSVIbxSwenVoeIHc9c4uqlvwOQOHrfqDw1PUrsxmc5gul
         MnAyVywGSbCfGztafGnPYaqjPxIriQ+xIcHNko7YFYEHKVi/xwZ+EhddDJ59uoNy3LFZ
         GYw5UgUFRVM4U1tec0EpAB8ekgLOHRzZvcY2Q/6r1bRoYkjppgrmHj8CkFfvf8J4eK4Z
         3t0g==
X-Gm-Message-State: AOAM532PxPikcOPkBexqd/gAgq95a3vOTLdyf3KvA5tn0hI2/FtqC2CO
        7F6wdD/L1iZxso9hQqfAv5bIgw==
X-Google-Smtp-Source: ABdhPJxHKuxC9rmkYi2NQblFYNBfCKjkd4iYQI+D1hZPwuCjICezisBZiLi1dY6rZjY6TScVwvLZ5Q==
X-Received: by 2002:a05:6808:f8d:b0:325:1e81:ffe5 with SMTP id o13-20020a0568080f8d00b003251e81ffe5mr2084792oiw.253.1651591970783;
        Tue, 03 May 2022 08:32:50 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id s4-20020a4adb84000000b00333220959b9sm4955736oou.1.2022.05.03.08.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 08:32:50 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] dt-bindings: thermal: tsens: Add sc8280xp compatible
Date:   Tue,  3 May 2022 08:34:36 -0700
Message-Id: <20220503153436.960184-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220408225037.627432-1-bjorn.andersson@linaro.org>
References: 
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

The Qualcomm SC8280XP platform has three instances of the tsens block,
add a compatible for these instances.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

I apprently missed the '2' in the compatible. Retaining Krzysztof's ack under
the assumption that he's even more okay with the patch now that it's content is
correct.

Changes since v1:
- Fix compatible to say 8280, instead of 8180

 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index d72122bbaf3d..038d81338fcf 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -50,6 +50,7 @@ properties:
               - qcom,sc7180-tsens
               - qcom,sc7280-tsens
               - qcom,sc8180x-tsens
+              - qcom,sc8280xp-tsens
               - qcom,sdm630-tsens
               - qcom,sdm845-tsens
               - qcom,sm6350-tsens
-- 
2.35.1

