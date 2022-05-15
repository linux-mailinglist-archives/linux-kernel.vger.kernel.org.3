Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A16527A44
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 23:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238776AbiEOVBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 17:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238192AbiEOVBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 17:01:02 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21613DEB6;
        Sun, 15 May 2022 14:01:01 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id dk23so25243628ejb.8;
        Sun, 15 May 2022 14:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=73tZzJtf8TyPjOxedRCWWK0Av6m0gxqtoRC788x1uDI=;
        b=FCXY4xKxeUYqPkuiPHMazxQhiKMGp5AxJuyWcEW8hmw655SGuNg5ELNn2KQpph50TH
         ggxTZ5CqcXNHy0gYN9jStJeCtTbUjNXkJ1ZrmsRJSArDc7+MW3dGwmNjEUl8bhfPm8IQ
         icCfZvyEIoGF+XUsHB7S451JQBLKiCR/LC855kNASykCmvqWquYtAn94AiWFRNgqPhfx
         wW4wM6c5jMtr+OqLtIlG0qdsmsAldO1c8oa8aBSdCWdZEpQS9up62niaVToX9cyItDMS
         HIeRiJ+bDpgwZYUXfJcHkPforc0tz+4uXFIaHL6HVBV5h6vJoLKAhHGciFQTn3oPEZ/F
         Coyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=73tZzJtf8TyPjOxedRCWWK0Av6m0gxqtoRC788x1uDI=;
        b=5lwB4bqwN0Blj0QEjrLf49L+uwCl3KjWB3EA5t4AeF+X7J49TEm2nwHaSUIeU4V/tT
         UKmDbr65oC9farIGDvqdSGsn1q5X2VZ7bzGjYqvz08VzCkNTLlPoBHihwUyKK8xeKcQX
         8IqY+wBrLaOqyQMGqwOjb8/VQ+cLK9vvPoa9aZHzMFciDQ6P1uKouftoc6tgREVQNuYc
         uBM6+nn7H13aaHOChEQ/F7nTxcZ+3+10HN0oJgWkiLdmRT0wxtFKRMPkWGuhjkLqsRWC
         NGKxigP0XrYE3cfEHM8XV8/9mb72kYMfh2iWGVMv3UKAGO5Ba/rz5pAK/dyY/YOZSHlm
         Ug4A==
X-Gm-Message-State: AOAM533so8piHyBMmUN8R6cdAoviROg26R5vPGwB7Vib41RGH5Qo9b94
        ngmoUCqMemx82t+ifXs4rr2oTb70JA1ARw==
X-Google-Smtp-Source: ABdhPJygz8V2+hHxe2YbEjCZQ2hlZG/P4MnPbh7/QxmvuDlLuk75brf4CH8NDW2yyQrpH6ynEPeV0w==
X-Received: by 2002:a17:907:c0d:b0:6f3:ed89:d9c with SMTP id ga13-20020a1709070c0d00b006f3ed890d9cmr12678944ejc.502.1652648459667;
        Sun, 15 May 2022 14:00:59 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-105.xnet.hr. [88.207.98.105])
        by smtp.googlemail.com with ESMTPSA id w12-20020aa7da4c000000b0042ab649183asm28917eds.35.2022.05.15.14.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 14:00:59 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tdas@codeaurora.org,
        absahu@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v4 08/11] dt-bindings: clock: qcom: ipq8074: add USB GDSCs
Date:   Sun, 15 May 2022 23:00:45 +0200
Message-Id: <20220515210048.483898-8-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220515210048.483898-1-robimarko@gmail.com>
References: <20220515210048.483898-1-robimarko@gmail.com>
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

Add bindings for the USB GDSCs found in IPQ8074 GCC.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 include/dt-bindings/clock/qcom,gcc-ipq8074.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/dt-bindings/clock/qcom,gcc-ipq8074.h b/include/dt-bindings/clock/qcom,gcc-ipq8074.h
index 5f0928785d7a..e4991d303708 100644
--- a/include/dt-bindings/clock/qcom,gcc-ipq8074.h
+++ b/include/dt-bindings/clock/qcom,gcc-ipq8074.h
@@ -368,4 +368,7 @@
 #define GCC_PCIE1_AXI_MASTER_STICKY_ARES	130
 #define GCC_PCIE0_AXI_SLAVE_STICKY_ARES		131
 
+#define USB0_GDSC				0
+#define USB1_GDSC				1
+
 #endif
-- 
2.36.1

