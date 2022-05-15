Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5696F527A41
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 23:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238713AbiEOVBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 17:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbiEOVA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 17:00:58 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771A0B48B;
        Sun, 15 May 2022 14:00:56 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id j28so1970081eda.13;
        Sun, 15 May 2022 14:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I3v3xUbGkou9V1pzQELGCGcR+zcC6SorV8LTEkdqEGA=;
        b=lOAbB2alfyM+wvCTjQG52WxzfXC/jnLz0/0o1zdUu64Ra43vvSqapN71xYslIkTag7
         Zr29MshPA0guPExDTOlyJbm0210YjsGmVYzqArlMTST3PTUnjQlYFHkh+LwiJYLanb2d
         HoFLjuLhBkdDXF912+bIISYcrlljZI9CpINDps1dkqv85GZVW0ryVjtAChYqCCVFp7m/
         LUYMfgfebQMJzoDnT2S5neu7GduQBJRC6fkw+ne/R0IAcM+oTvOnlS3mFuqMRXe4StHp
         pwf5Q7qkFyvqtKt/m2SAWk66/nW2WMBUQhpCL5v1lMKq8+BQk3UxpKM39AtLJu1ZPTlJ
         OiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I3v3xUbGkou9V1pzQELGCGcR+zcC6SorV8LTEkdqEGA=;
        b=tWbAaVzkAf6PXfm9H8V6Xv/SiZyCRdp1xFPjHmZJfWutxc3/cCuX+ARycCd8pqhzL6
         vbFLyHD2VprIrmAPtcYpqJgDV26xP+U4+2TAGQzF2sOHgHi1lUwjBZwasc4uYykZZrte
         VETihPwtQorZW055/5MnGdhcX+WZT2Ia4S2j7xOy4MOr9KlpCJvF7Ag0+l+D+KvzfjMn
         qcbsp5eOMJPr1W8yyFodvprysWKkiFXWGe44Ctlg9Hlr1W7cDBeJGWw613J5+BxAhTvm
         90ZUPjNMtK9EdAUxnAw+rku2ln73KEsMcAvvjp73pDzG8PaPCRhBVjul92X5966iPuLJ
         6s6g==
X-Gm-Message-State: AOAM532gsOAsoR0f5k6lp+MGw70J44xDNEZleOJsgsXqX71SZain19rh
        N5DgrQq/pB/EWHMb0CZ86bM=
X-Google-Smtp-Source: ABdhPJwdJKyrBI26zmBAdTtnYN6xQtiSInCiBOQ5k/Jx1Z+xpH8b7YvL0zXjmnq9atkgBpw2HKmHwA==
X-Received: by 2002:a05:6402:2789:b0:427:bc78:85c9 with SMTP id b9-20020a056402278900b00427bc7885c9mr10110228ede.50.1652648455107;
        Sun, 15 May 2022 14:00:55 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-105.xnet.hr. [88.207.98.105])
        by smtp.googlemail.com with ESMTPSA id w12-20020aa7da4c000000b0042ab649183asm28917eds.35.2022.05.15.14.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 14:00:54 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tdas@codeaurora.org,
        absahu@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org
Cc:     Robert Marko <robimarko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 04/11] dt-bindings: clock: qcom: ipq8074: add PPE crypto clock
Date:   Sun, 15 May 2022 23:00:41 +0200
Message-Id: <20220515210048.483898-4-robimarko@gmail.com>
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
2.36.1

