Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B203F51EA06
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 22:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447002AbiEGUeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 16:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387356AbiEGUdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 16:33:47 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598FABC9E;
        Sat,  7 May 2022 13:29:59 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id gh6so20181465ejb.0;
        Sat, 07 May 2022 13:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gt1TfdpUx36mpk0knRdW8cvBlw/+WYrsEA+apVijl4c=;
        b=hs5SdNelpY5YDkiPDiq6fnNM63MQZoQgkjYz3yRTrxktYJk8RSa86tmA5dF6dOE4Rb
         Bwv/3FMjDPGb7cb5rv5hy/dVhEHpWYBINu422u4yYwgsqaAsHAxJmSXr7GjVW1rVZmGg
         2boB7Cg6vcI8oyiai1gwOyUlsqm60Bce4SwDWOu5p3pezc8JIqbuer+BDWhS6APPKAz1
         tX8QckdbO/Xqiwn+so20w3+sw7grn45Xs5scEUxt4Let6EEtuHPU5vKd6M3C1ocHVLAg
         6Lg0j4KaJB6lbPZfEw4EuvvofoJz2PY9/SfbZhmHo9mJ2kaUsBFtS3oYkU9YwhKp5jG+
         I9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gt1TfdpUx36mpk0knRdW8cvBlw/+WYrsEA+apVijl4c=;
        b=D6MuniL6d/N5CJeuQKHhJP56RzmgUQ4CmfuDWVhocC9Xtg5QqHptMvfqmK9At9Gcw2
         xqHG4IWTfLxdViv3v6ZN9/qyYbU0wXdbP3g5g3PAbgEl6YIFaL36E9wYjQl+8apWdjKw
         CnzJcuXOI9JDvWRf7ulyvC8Dx+hS23DO0biXYfsBUB31s3QUgijfc1hLPWp03FU/bmf9
         MYdiVCdDARK1t30O8gXQ1MXkTGbHvr+vS8/haTYhEXUJFrC5RVsm8gzLW7+csKMax8La
         dG6+70V4JQJKpo9IzYc70CNG8bkZPkS/QAyhIONlhZl25fTC1MFqvgphVE4rIYCBCFwu
         4rLQ==
X-Gm-Message-State: AOAM532S3KZSUxPx8a0EZJf1WAIIvzbdOWNd0FQ+19qxLZV46le+vT1B
        uM9ndZRtbWNtYuJSyhjR2qA45uqYGLefKA==
X-Google-Smtp-Source: ABdhPJyyg9+hKxzYmfIDwPamcivFWWy4BzIFJcilsEa2TplJyOinM/dU37wYfeYiJsKSKmwPYPDgZw==
X-Received: by 2002:a17:906:9748:b0:6f4:d336:6b94 with SMTP id o8-20020a170906974800b006f4d3366b94mr8471075ejy.471.1651955397924;
        Sat, 07 May 2022 13:29:57 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-244-cbl.xnet.hr. [94.253.144.244])
        by smtp.googlemail.com with ESMTPSA id k11-20020a056402048b00b0042617ba6383sm3900777edv.13.2022.05.07.13.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 13:29:57 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tdas@codeaurora.org,
        absahu@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 05/11] dt-bindings: clock: qcom: ipq8074: add PPE crypto clock
Date:   Sat,  7 May 2022 22:29:42 +0200
Message-Id: <20220507202948.397271-5-robimarko@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220507202948.397271-1-robimarko@gmail.com>
References: <20220507202948.397271-1-robimarko@gmail.com>
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

Add binding for the PPE crypto clock in IPQ8074.

Signed-off-by: Robert Marko <robimarko@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 include/dt-bindings/clock/qcom,gcc-ipq8074.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/qcom,gcc-ipq8074.h b/include/dt-bindings/clock/qcom,gcc-ipq8074.h
index 8e2bec1c91bf..5f0928785d7a 100644
--- a/include/dt-bindings/clock/qcom,gcc-ipq8074.h
+++ b/include/dt-bindings/clock/qcom,gcc-ipq8074.h
@@ -233,6 +233,7 @@
 #define GCC_PCIE0_AXI_S_BRIDGE_CLK		224
 #define GCC_PCIE0_RCHNG_CLK_SRC			225
 #define GCC_PCIE0_RCHNG_CLK			226
+#define GCC_CRYPTO_PPE_CLK			227
 
 #define GCC_BLSP1_BCR				0
 #define GCC_BLSP1_QUP1_BCR			1
-- 
2.35.1

