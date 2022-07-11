Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE09570044
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbiGKLW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbiGKLWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:22:13 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5600B1F;
        Mon, 11 Jul 2022 03:47:30 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id v10-20020a05600c15ca00b003a2db8aa2c4so2776878wmf.2;
        Mon, 11 Jul 2022 03:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yIboIxQuAfrUWzSoLEOVgFtmcLKnX85uUb2His2TGbY=;
        b=dOJyfD9l6amfDM3zplFOXRyFmKj5AwfAxqo+vWqeLJtBapQVPT1lWvTCnpEAmlhwwm
         nUx4/i/bkomrny7/7NIM8PcnU3WLhI7/y4MFmIP8ZOIW4fwRHrRzbijn78phwZuVX1BC
         7qmkreHu+04MuaLE804IhOJ1cr/C8dWdFZQdDk/Rz5m+p6IOXwbjc+37EVn1EXlPMlxm
         bmRQ/r7I35EQC2X9k0bNpZSEOZWlZRk328dsRXyWKkExDl2c+yPOQiEnJpIFu7KYS3vJ
         VObY1gj8ta1miFAG+/u4ev8pip0mRWHJ30EtkQg2QwNFL45IXl/3486ECA5SaUnqw1pq
         ZNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yIboIxQuAfrUWzSoLEOVgFtmcLKnX85uUb2His2TGbY=;
        b=bBqn6Qh0fOJ8xt9mW3BHsnTh6pgcYumCinOjmWvsWk07d5ExZ8sGOaz1xIlf3C7BO7
         ICd1lhASpv+9Sr2Ke9qp6zNijqqok1bgRmXOkOLEh7sCZHyO4S6RsozS8JS39FtkStKN
         VbskwlTsWSFBXVqU4mqyjr3fzFqK/oXRD4OSiwjFhMgZUKlPbcNpxwyFY1XQdIUqSTEU
         5p3q7lHq/3l7f7XdLkwotge5ATQbwHWfWexh9ySafxeSjByeafYJeJOiq8epF/FmQdwt
         6jcNOxDM82xeel4hLRPTMaCN4WaoA6MqohKL1lgigvkwQ7/xnTNfwXphueeBUVqj0B9Q
         u67g==
X-Gm-Message-State: AJIora8bQhR+kl24BjFmmbG71CnPU8cnk8Y5ZrrbGMHUVBTqsZacohy6
        3++3sJj9LgjZB+8QSWoY3vU=
X-Google-Smtp-Source: AGRyM1vU/SdEQIabKWNF5X4Uup1rp0Z87VjUhlm5s8YuiLECN1N+WHPmrhd6HkVn4oJ/V4uUBh3IiA==
X-Received: by 2002:a05:600c:5007:b0:3a1:7c44:44f5 with SMTP id n7-20020a05600c500700b003a17c4444f5mr14911653wmr.106.1657536449360;
        Mon, 11 Jul 2022 03:47:29 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-242-cbl.xnet.hr. [94.253.144.242])
        by smtp.googlemail.com with ESMTPSA id n3-20020a7bcbc3000000b003a05621dc53sm6338716wmi.29.2022.07.11.03.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 03:47:29 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sivaprak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 5/6] dt-bindings: clock: qcom,a53pll: add IPQ8074 compatible
Date:   Mon, 11 Jul 2022 12:47:18 +0200
Message-Id: <20220711104719.40939-5-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220711104719.40939-1-robimarko@gmail.com>
References: <20220711104719.40939-1-robimarko@gmail.com>
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

Add IPQ8074 compatible to A53 PLL bindings.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 Documentation/devicetree/bindings/clock/qcom,a53pll.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,a53pll.yaml b/Documentation/devicetree/bindings/clock/qcom,a53pll.yaml
index fbd758470b88..76830816982e 100644
--- a/Documentation/devicetree/bindings/clock/qcom,a53pll.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,a53pll.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     enum:
       - qcom,ipq6018-a53pll
+      - qcom,ipq8074-a53pll
       - qcom,msm8916-a53pll
       - qcom,msm8939-a53pll
 
-- 
2.36.1

