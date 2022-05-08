Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC60251ED11
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 12:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbiEHKxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 06:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiEHKw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 06:52:56 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519C8B86F;
        Sun,  8 May 2022 03:49:06 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id gh6so21929369ejb.0;
        Sun, 08 May 2022 03:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gEM8092vCUXJvD5hNfzZpNzpdrsS4y8FwWR/EIuYhPw=;
        b=V2SXUx8E0fVhlE+MkGRRMS2T64rJ8iGCDaOKR5zhbyHAkxJnoQ6ODw7Yv3JR/5KMzE
         HWoLvyZQI+8UGD7Ft7FYFjHX1v0y8eQO/z4XVPC/0MyV1puO2qvbu7YSJyp5exd9KgFP
         CSozuieZpuvxfnK9WwXKDHUc0ViaQzASxGBfJY464mCsKazK6XaE3OB3UIWH7MPwVeRr
         nrf0YLeQ61IGKrAozbQOrXvx1pKilIyGBaR+cudvkeUhXejkGAopHXX+v1KrqJ6ktQ2l
         P24ufNUpEujz5L0wtbnYW0l9X8ZsDteTE3lNetxn1Gr5p/w+1+PUgrK2uGvlTFEQ0vE1
         4Cpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gEM8092vCUXJvD5hNfzZpNzpdrsS4y8FwWR/EIuYhPw=;
        b=C0eEPStUsVYUj6YqicJKDZZ/dGKb9VP9kZq/f69wFn9PvSZp+H1C4fYlUAxH3lTrFA
         DcxCpiaOkB46dcyZZPMHEzmVEMSff3t5vq/1u7ZZ4Wce78frs4ppSzjAWYqROUN/FDlb
         cW3TzxK6lJVtBZW7GTBqD/cNctFDF8XqvJavlMBv/al0RObpSDj+24nxMSNnks4bVYwt
         jyTIknZF13kBLYG2PmWmsni6urDkpA1+MD8tmeb108cXgXKbBhVL47bjK2Hx3tzGPOJy
         3Lf24igJc8NHmRY8VHcsidS0/ZsumAHGdOD3njmF7ZmuAw4fD+wNbrASRbqZDsuT4FKO
         mupA==
X-Gm-Message-State: AOAM530WINy5goZvFLOBTdJBASXNIwsQQs+2bhb1sJ+Dcw33m3q5IsmE
        mqmcj7qvAKznV5yWMWppRBSJ12ymlCeTpQ==
X-Google-Smtp-Source: ABdhPJwdJwBI2WCXoRCJczJpkYlJUksipQCWe9odDU+X4rK9UjX7bmcIiag763NvEKJJc8J0Hs2DZg==
X-Received: by 2002:a17:906:d54b:b0:6f4:d14b:bb91 with SMTP id cr11-20020a170906d54b00b006f4d14bbb91mr10081969ejc.314.1652006943513;
        Sun, 08 May 2022 03:49:03 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-244-cbl.xnet.hr. [94.253.144.244])
        by smtp.googlemail.com with ESMTPSA id hg12-20020a1709072ccc00b006f3ef214e0csm3917471ejc.114.2022.05.08.03.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 03:49:03 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org
Cc:     Robert Marko <robimarko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 04/11] dt-bindings: clock: qcom: ipq8074: add PPE crypto clock
Date:   Sun,  8 May 2022 12:48:48 +0200
Message-Id: <20220508104855.78804-4-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220508104855.78804-1-robimarko@gmail.com>
References: <20220508104855.78804-1-robimarko@gmail.com>
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
2.36.0

