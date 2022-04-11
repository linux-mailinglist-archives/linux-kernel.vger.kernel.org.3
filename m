Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4052B4FB6A8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344023AbiDKJCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344017AbiDKJCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:02:06 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00B93ED1D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 01:59:51 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id r13so29454361ejd.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 01:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rc69LIllmgRf7vbSQlFUqLbxtA3mmK6fFRVeHFBvEso=;
        b=ZtBIAWZfMwJRLnMjFDnnzsD+a32eYDsJraswdAMsypg/nhGtIBd2E1Vv1EV8aM5/SO
         efltsNS95hR1vy6CKaHvxa+Usw/FYccqNxeQPZQDgMJPNjjTkA1jXKnMt597RrqhTLf7
         sPiD1hqoRxuNUVZ55axnjSI/TCv+5rDByBj+bGSszNln2bNAKNWcte8BHBJJTqqIMqxI
         evweJzDei1CD6n2WI9jDPNnauVwtIJ+P5vYkoAWmdnkY8Q1cc7MFTxcTeeIVHAxOTxHT
         5fl+1FvVEDOJH0mtHqwjsQzhFBDIyXLqDpG/KNOL2tSKOPbTeLyJ+hmdygvPUB0G5HNb
         71Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rc69LIllmgRf7vbSQlFUqLbxtA3mmK6fFRVeHFBvEso=;
        b=p9p1V+N0C+o39ANiKRqiDBIAkTJ6LvaKz5/tuK51Q8coFUhJSJKXX6BGCcb4Yl1ujx
         4uGryX9RO9l0HW2lop3+Z3z2oCCFFJxRnFig5OmBviqGsqgjrSu54wGr7cZt9TDWA5qw
         xI+NuiColKtsFp2eSJS13Pyr4dFXt2VgEu/fBytzRTjF0o5CSe7oEvIdSGHjNYUbxviA
         4iJ+Ay/EUp94KPx7ZcTseZVHeQIBX5PqwEgKQ7eb+Sc9bNyJ5vlqOLZWOJ/wqoIvaVVW
         faHY439MbzDfG3ifi4+WI49X/VbFImtfT1DRirJoyTofo0q1wm6kIXWkrd2it1RhTinm
         yIkA==
X-Gm-Message-State: AOAM5325/o6baPvnCkmxYn2FDgFzCMqQbRtOp/vPp3THJDelS+prwBP9
        98hVzbUeGfSrA9CQgKKyqh91sA==
X-Google-Smtp-Source: ABdhPJzxp5gK+6mo01IKUXO19ZqPNKPmjGNciUm2HErbM1DHA2IhXyk9haPio0X8Kghqchtl/vNL7A==
X-Received: by 2002:a17:906:2b93:b0:6cf:bb48:5a80 with SMTP id m19-20020a1709062b9300b006cfbb485a80mr28490139ejg.681.1649667589943;
        Mon, 11 Apr 2022 01:59:49 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id x17-20020a170906297100b006e49a9535f3sm11705416ejd.114.2022.04.11.01.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 01:59:49 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vamsi krishna Lanka <quic_vamslank@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/4] arm64: dts: qcom: do not use underscore in BCM node name
Date:   Mon, 11 Apr 2022 10:59:34 +0200
Message-Id: <20220411085935.130072-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220411085935.130072-1-krzysztof.kozlowski@linaro.org>
References: <20220411085935.130072-1-krzysztof.kozlowski@linaro.org>
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

Align BCM voter node with DT schema by using hyphen instead of
underscore.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index e1c46b80f14a..86175d257b1e 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -3522,7 +3522,7 @@ rpmhpd_opp_turbo_l1: opp11 {
 				};
 			};
 
-			apps_bcm_voter: bcm_voter {
+			apps_bcm_voter: bcm-voter {
 				compatible = "qcom,bcm-voter";
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index d7c9edff19f7..443cd9c7f49f 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -1217,7 +1217,7 @@ rpmhpd_opp_turbo_l1: opp10 {
 				};
 			};
 
-			apps_bcm_voter: bcm_voter {
+			apps_bcm_voter: bcm-voter {
 				compatible = "qcom,bcm-voter";
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 15f3bf2e7ea0..b5c418d326b2 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -3744,7 +3744,7 @@ rpmhpd_opp_turbo_l1: opp11 {
 				};
 			};
 
-			apps_bcm_voter: bcm_voter {
+			apps_bcm_voter: bcm-voter {
 				compatible = "qcom,bcm-voter";
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index af8f22636436..56bf95b7f6ff 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -4654,7 +4654,7 @@ rpmhpd_opp_turbo_l1: opp10 {
 				};
 			};
 
-			apps_bcm_voter: bcm_voter {
+			apps_bcm_voter: bcm-voter {
 				compatible = "qcom,bcm-voter";
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 20f850b94158..008f6188c8b4 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1881,7 +1881,7 @@ rpmhpd_opp_turbo_l1: opp10 {
 				};
 			};
 
-			apps_bcm_voter: bcm_voter {
+			apps_bcm_voter: bcm-voter {
 				compatible = "qcom,bcm-voter";
 			};
 		};
-- 
2.32.0

