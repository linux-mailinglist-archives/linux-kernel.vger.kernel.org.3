Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8ED357F625
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 19:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbiGXRZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 13:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiGXRY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 13:24:59 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B6610FDF;
        Sun, 24 Jul 2022 10:24:57 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id b21so3681021ljk.8;
        Sun, 24 Jul 2022 10:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kEqMaeNBAGPeiVakMqD7j5ZbFrxHuSRmgJ0iAS3vjNY=;
        b=NNkXMHViFoZ9XvY+WmaxJHFCHP9huFcvHDFPeQucD7Pq/bjQ2hMam2o3ew8PyHFSPB
         u0ELI5Y1OgVVNqvnLu8iThCYZ8ff2t1Y0M9M+XlLrvkpGRVJTknwEoffssQAmp5rorut
         Ja4PPJ+V5cyGTeD8s8zcEkdDuu3LZhvzin0IHvJ8/dtYgvTHLl0QdA6fr9XaKtEbpejl
         d4LRtePzAbzdARDf4mfjHMe6if6cVynb8tOMc910TjLxcsW60jAG0UtfxJscBiwKv8+F
         pTKCspHe6Q7Ud1mnS3kQ2Mgktxt3l1OSE8LxVKy8/71QBj26uhIuiNJArz5nJLT1kLEk
         eRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kEqMaeNBAGPeiVakMqD7j5ZbFrxHuSRmgJ0iAS3vjNY=;
        b=e2Ud5SOtXS+7HvAtw+8g1X/PQrtLLld3L5IlCDfPddm70u99Qm1Y2aKu5e+qaTYXzi
         ApaQ7OVhFk3DZwjaBb/H1/1QZ9nM9r1UbVJm8YvorLmf13k7iWPeOftEbOHSMNjQU61r
         byFoTFKhyCN9rwOjj4UijEIyD9oA7/KJ9Y921xnnxZ0zCN8S4pZSapU1PcFpycxT1/dS
         o7YOP9cqnBoxKHfQTfwOtvZQbseJrMvVKMm1jLLzHPKTAIiWNQ6OBuxERzS2y4XAH+Wv
         XOQozmNdRDtOPDCFYLyNSlrZYD3zZj3FWOTSCtA/kWTKqPxyyOam7reTx/I8mhVscZK8
         W7Nw==
X-Gm-Message-State: AJIora/GjNDYoakBlUPo45raCgDuvBUNBBNh2LXpImN3a07b15Qxz6ww
        z+w/QPp+IZxlbin4n3dvFfMoOyDPDICYapsNS0I=
X-Google-Smtp-Source: AGRyM1s6qutVwGep7Lod+dAs/FagMiAfGMUmr7f4JLMbL3iontxFpS2aG4C+FPLeB417Db94zBsPSw==
X-Received: by 2002:a05:651c:151:b0:25d:e967:23e1 with SMTP id c17-20020a05651c015100b0025de96723e1mr2831769ljd.346.1658683496133;
        Sun, 24 Jul 2022 10:24:56 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-5673c7-93.dhcp.inet.fi. [86.115.199.93])
        by smtp.gmail.com with ESMTPSA id d7-20020a19f247000000b0048a73d83b7csm1928322lfk.133.2022.07.24.10.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 10:24:55 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] ARM: dts: qcom: pm8226: Add node for the GPIOs
Date:   Sun, 24 Jul 2022 20:24:39 +0300
Message-Id: <20220724172442.87830-2-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220724172442.87830-1-matti.lehtimaki@gmail.com>
References: <20220724172442.87830-1-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PM8226 provides 8 GPIOs. Add a node to support them.

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
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

