Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942FA51BE3F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 13:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358455AbiEELmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 07:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358308AbiEELmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 07:42:00 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3649A54180
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 04:38:14 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id n10so8170699ejk.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 04:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0B77eQYKO8uoHd8GX7CLVmghS1xkaBRJ4WQ/0qKLNzg=;
        b=BPCYwh2H94L/C1Fle5H+kc06hUfHDJfB5SwTcw3auNm+LQO/k4CLdgmoIl4dp9AXlc
         v8PLbZCrUF7h+BAhGEAF3F1BCI9mBXAqXNAzw1YyAbHo5Q9F99k8+9jRghb4SCK2jO3V
         o3RBTG3fj3wq8cDCgBc6QnGu/J7vK+HIzYwLbfTjgOAEp3YFVQfLn2Wk5Jahn34Irne1
         /tkCAM5YjoOBQd0AjDl8msHIEHm5+N7I0GghvFf9tX5xtBGCOzHooUU83wqRQiszfcHv
         TUwtJ8zQnd2zyS1kSp8WMCCDerYPwWdYJn/EvGGHHpfk6lDAt0HlzAY98AaWo02tXvv8
         t8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0B77eQYKO8uoHd8GX7CLVmghS1xkaBRJ4WQ/0qKLNzg=;
        b=PuxXYR9lIOKtHqg2rjtsWq7FRGfdd3RjKXTzcXS66/ykgEWRF3PPE3CZlV2wFyjdNt
         w4Af+ch6H0nCptZ7DOj1pXN0ah0dcmFFnscf1wo3Wi1ZeqVoR9irEsCw+ASfZQMFcT5c
         uNs/D34HLmVe1hXStujU4aLS5pOpgMpkbazQ5H2vaiqN4+DoDiesiyFMArZeGNP6sZT3
         WDhu2Wc6YmRFzyukAjDmoOBRVQFVJ/cqYY4ewbcpn+l8M+CcaOTmCEF0Gp3Mxc76PfGi
         z8Stt1bsG79HKT/WDDnBaTQVSOLT2OMn7UxuLNV3WCVh35ieaBGpl7a0+Kf4sXDIsqJ0
         b2tg==
X-Gm-Message-State: AOAM531yWM++yvr+Jnv1u1RSbXBDtuYhlUz9NNkUAj5MzdI6HpVmw7n9
        J83XRkXiw1em9bL2KRSpcHp8NQ==
X-Google-Smtp-Source: ABdhPJz2hiw2ca+vQ4cCnCAtms89wFZqljglbhxrF+3KD6v4Ous4H21EyTHhv5R35xFgbWC0Sddxzg==
X-Received: by 2002:a17:907:8688:b0:6f4:3d77:f9c7 with SMTP id qa8-20020a170907868800b006f43d77f9c7mr19969992ejc.716.1651750693517;
        Thu, 05 May 2022 04:38:13 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g9-20020a1709063b0900b006f3ef214db6sm661006ejf.28.2022.05.05.04.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 04:38:13 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/6] ARM: dts: qcom: apq8064: add unit addresses to QFPROM regions
Date:   Thu,  5 May 2022 13:38:00 +0200
Message-Id: <20220505113802.243301-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220505113802.243301-1-krzysztof.kozlowski@linaro.org>
References: <20220505113802.243301-1-krzysztof.kozlowski@linaro.org>
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

QFPROM children have 'reg' so they must have unit address.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index d3cb099cb691..028d52b5d075 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -801,10 +801,10 @@ qfprom: qfprom@700000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
-			tsens_calib: calib {
+			tsens_calib: calib@404 {
 				reg = <0x404 0x10>;
 			};
-			tsens_backup: backup_calib {
+			tsens_backup: backup_calib@414 {
 				reg = <0x414 0x10>;
 			};
 		};
-- 
2.32.0

