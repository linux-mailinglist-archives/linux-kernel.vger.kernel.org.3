Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF515A846F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 19:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbiHaRdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 13:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbiHaRdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 13:33:02 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70866B7297;
        Wed, 31 Aug 2022 10:32:56 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id g7so3984322lfe.11;
        Wed, 31 Aug 2022 10:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=8JnTaUxBxl2Y6bYQxSkch1AceV7B8+lC6pectLFxi9s=;
        b=pGo9jSKfySmkurutsDswpm8bmxZC6+gjvX/xqEJG0wXWE+WJNDW+kz80T0FAjyBa6a
         847/Eb9mb5Dy+jlvCnJ0IoMgSyb0kr2AK8BNmTx/nEBJSzZbBhcfzORcunr0H03VDzBt
         VKOz3QkjkWjMVvrgahtPDS60USiN6aXzWz7P1mByznifvLI0idAesI7S1D36y6KwXNN7
         smuQbLVZIZRSHD+HHrovTsGxokLDFa1yFBRHNO1MVomzuFoKXzLESbmCROkDSoo0vdHL
         PNneaV20nfFp0AmeNMaw4PsjCrSf39JmCN33/cf1GFeZSeLLkKpPBQxu6fwtJP6Bw6iD
         eH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=8JnTaUxBxl2Y6bYQxSkch1AceV7B8+lC6pectLFxi9s=;
        b=h443c+5FNJs8WHGge8RZ1peynkmagHdr68pfVoQae5059b6oj4uBU0YqJEoLLVxcRw
         HtWcNPcNWYEdUfZ1cl1S427coflafnmygU4PNnS0cTvb7352Ar47mHpQ9ws0L3Y1Dczc
         QjFoPdsOO0a4/HX1d3VYHNYsKm+mIs1FNh7YM9q+qeQaRp6Xg82Ln7Qlu3cYt3CSWHuN
         8hmDcQ66PZTn2mHYGUWVYP6toc2tA6dICoij8iTX0/6GPGSuGNvC8gYqvD3ht0/SzFMs
         EZH8xzFC1CbWybhI/Q1WwGslwxpJxRsBABIGd0P34vvPv75L6O6EdyBEQtBOXVIHiHds
         E2/g==
X-Gm-Message-State: ACgBeo3BCt9DMRtYUlQkjb9Jqgh2wRcsGqe7Zn7RhHWZ7BUw4dgyacoY
        MooGD1Ua3rL5E4QqvOXgUhH93CLmsjioPQ==
X-Google-Smtp-Source: AA6agR5ZtQxxhL8wnWwvd4ZwMYpAqeZEDW9K2mDCO8IVsGrHEsLZoCSUsDmB3ptbSEYtCFAIwVAWGg==
X-Received: by 2002:a05:6512:3d06:b0:494:6871:639e with SMTP id d6-20020a0565123d0600b004946871639emr5389849lfv.227.1661967174053;
        Wed, 31 Aug 2022 10:32:54 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-5673c7-93.dhcp.inet.fi. [86.115.199.93])
        by smtp.gmail.com with ESMTPSA id m18-20020a056512359200b0049464d05bfcsm1501336lfr.105.2022.08.31.10.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 10:32:53 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] ARM: dts: qcom: pm8226: Add node for the GPIOs
Date:   Wed, 31 Aug 2022 20:32:04 +0300
Message-Id: <20220831173207.238080-2-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220831173207.238080-1-matti.lehtimaki@gmail.com>
References: <20220831173207.238080-1-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The PM8226 provides 8 GPIOs. Add a node to support them.

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
(no changes since v2)

Changes in v2:
  - Rename pm8226 gpio node
---
 arch/arm/boot/dts/qcom-pm8226.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-pm8226.dtsi b/arch/arm/boot/dts/qcom-pm8226.dtsi
index 9b7d9d04ded6..0c10fa16a0f3 100644
--- a/arch/arm/boot/dts/qcom-pm8226.dtsi
+++ b/arch/arm/boot/dts/qcom-pm8226.dtsi
@@ -90,6 +90,16 @@ pm8226_mpps: mpps@a000 {
 			interrupt-controller;
 			#interrupt-cells = <2>;
 		};
+
+		pm8226_gpios: gpio@c000 {
+			compatible = "qcom,pm8226-gpio", "qcom,spmi-gpio";
+			reg = <0xc000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pm8226_gpios 0 0 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
 	};
 
 	pm8226_1: pm8226@1 {
-- 
2.34.1

