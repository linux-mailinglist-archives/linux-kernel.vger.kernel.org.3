Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C9B527A0D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 22:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238751AbiEOUqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 16:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbiEOUpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 16:45:47 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCE3237CE;
        Sun, 15 May 2022 13:45:45 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ch13so25153067ejb.12;
        Sun, 15 May 2022 13:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CVJmMjKSGPsdpVl5B7dwM8pbpVk/e6e/YzA6OtxjZig=;
        b=P7dGGjdNUaA0IqLlqPADFrdhjN+QY+65AfnxxdOJ92BG17pe0Db6F1DK+0XbfT9x56
         sTXlhvcXcZE7U66UusoiJZrmSpN86bzHgnSj4BaHbSBPXRWOdzRj2wCChSapmcsbvNEC
         T3GHb9ULoHbo9tZfLuA+TcDCAgbxvDsXeVRAUEVRSDhNTjScb+D52apg3gOEEIblnV20
         t66dmMgXZExdyTzO14up9vEVKwjRfS4H6z53voEUCxRw6WxPIzaugRijlrIUtvmQkxEZ
         IBKXqZrhlYijJ/EteeglkPZl4V7bdaX7HTzfBC7AYJfL/wUeA7lA9X4EInAzNYY/XODh
         x1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CVJmMjKSGPsdpVl5B7dwM8pbpVk/e6e/YzA6OtxjZig=;
        b=UGOcJnIbbMi2EGetrm5XzcaBCW/gPU8ai6QV55VwrkyCTv189DHp9GN/4APzEO7W4B
         LsXwqUV/4SCUBa7gNivLNDZLafCHrp16End5+LRUQeiSemR3GqQvmfNChAwRF1ugEKkC
         2t0py2UFbIJJ1h4sLF7VTcXqHFt8FTkoAPdVg4lJIAJFMHZvIGdKZxAfJc1Xzg81EsaC
         nJBwtxyiaBbsKcjMmpnjhrYyH06uET9+7dcRp8wI4HgSI7xj5K1nicEFRlvs7+heZzhv
         kWfIlySNLFKFRSjQ0+zXHcrhL2qwpemdqzYsSpGekeaF2IZUotsgdPQ6JBaHFBV8Ap0v
         7aiQ==
X-Gm-Message-State: AOAM531z91+SNxWFm8jpcr6wEltrh03xX+2UAEArbWddcARFny5/vKPX
        Y3F2VJEaRxULIhflB6gR2rI=
X-Google-Smtp-Source: ABdhPJwzqJKxcby/qor1KpG+PZmQynhtAuF4IqryADP1xTGOxUowbSTR18nsvDEKYxIzbfRIAlgKRg==
X-Received: by 2002:a17:907:6d22:b0:6f4:85c1:5a07 with SMTP id sa34-20020a1709076d2200b006f485c15a07mr12613313ejc.733.1652647543951;
        Sun, 15 May 2022 13:45:43 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-105.xnet.hr. [88.207.98.105])
        by smtp.googlemail.com with ESMTPSA id i10-20020a50870a000000b0042617ba63cdsm4174156edb.87.2022.05.15.13.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 13:45:43 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        jassisinghbrar@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 2/6] dt-bindings: clock: Add support for IPQ8074 APSS clock controller
Date:   Sun, 15 May 2022 22:45:36 +0200
Message-Id: <20220515204540.477711-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220515204540.477711-1-robimarko@gmail.com>
References: <20220515204540.477711-1-robimarko@gmail.com>
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

Add dt-binding for the IPQ8074 APSS clock controller which provides
clocks to the CPU cores.

Signed-off-by: Robert Marko <robimarko@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v4:
* Dual license the bindings
* Update the copyright year

Changes in v2:
* Correct subject
---
 include/dt-bindings/clock/qcom,apss-ipq8074.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 include/dt-bindings/clock/qcom,apss-ipq8074.h

diff --git a/include/dt-bindings/clock/qcom,apss-ipq8074.h b/include/dt-bindings/clock/qcom,apss-ipq8074.h
new file mode 100644
index 000000000000..32538c9311ff
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,apss-ipq8074.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2022, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLOCK_QCA_APSS_IPQ8074_H
+#define _DT_BINDINGS_CLOCK_QCA_APSS_IPQ8074_H
+
+#define APSS_PLL_EARLY				0
+#define APSS_PLL				1
+#define APCS_ALIAS0_CLK_SRC			2
+#define APCS_ALIAS0_CORE_CLK			3
+
+#endif
-- 
2.36.1

