Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDE653AFC9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 00:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbiFAVjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 17:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbiFAVj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 17:39:29 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01F7139CA5;
        Wed,  1 Jun 2022 14:39:27 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id x62so3905606ede.10;
        Wed, 01 Jun 2022 14:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yyRNP3vGAFkKTHx9P93DagXSBKy3wcwKPWE0rVPLMZQ=;
        b=Cp1BG+UT0jiWdXWNMLh7asA4vboh1p6H6p9xUrWnaJG5qf+CkZ7QZ67+kGw43H0WVv
         2waiJUG+dd/KyBZZ6cZr7awwWKv73jPdTl5F4lMCUGL+pYeCfy0eib+zdJ58D/UJ37xQ
         d3D86A1WEVYz0CdFspxQu0cQujAveHxspRgSuW8Ep8bZ+XqJSxt/b9MZZM19J8nuJ9mr
         jeUKWRhp0rtoLNR45VH4/TR7aua9r4Tq98NdRxAMjKZaHtd+iWBXVJmWWPPBTd10nnzV
         je+Dj/KHITynYZmGgZsCFK93k3RIlEtKbjy5YGqOVMxs4MJfyOJVbXZXLm17eMCw+uTq
         UkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yyRNP3vGAFkKTHx9P93DagXSBKy3wcwKPWE0rVPLMZQ=;
        b=8EYeY9XsSWtEXeSE6mzJM6QtSOSF9HxdlfRYAylLV6AIuhg5/GOUVtdAFE/AM2sWyR
         ZyhRu6kggEEbk5R4JvCxBm//C5sFw9Lf2QRzK8Nhk5zLOKq3yFjAsJ2jJ++yFIS/R5Ve
         W8tBzSpUhfvdtnc8IcpZKwwxfW8gsHYH5mczAF0XjvTn0n3PNbdtsJEEysVuR1XzLaLw
         wlRlr9C1r1PHTZngqO41hd7kh1vwqYEMQYey1rvDF+4TIpmdvuQgRYVXC3BqLIBxCw7Z
         TFUH/PjKpVrpyH56SPQtXNxk0jbsEbsh/mR1DysNN5dgRXTRNmRLljG9cvrVYw7zRl+h
         3N8w==
X-Gm-Message-State: AOAM533OCjRGtWaCF/jQd5Lewn1mtad6J2+IBLVpJj19QovcPlwPqMlB
        l2OFvaTDgaO/QQQZtIji77wmXeI9HqBpdTp1
X-Google-Smtp-Source: ABdhPJx3NKb4pQOtEt7auKhzjmSKlpcYRqJ8hAKswST+/NuQLaaDuoUyjRnlvZC+Y+XS0u70QJ8Hdg==
X-Received: by 2002:a05:6402:440d:b0:412:9e8a:5e51 with SMTP id y13-20020a056402440d00b004129e8a5e51mr1936036eda.362.1654119566358;
        Wed, 01 Jun 2022 14:39:26 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:368f:2080:5d6e:322:57b6:5f03])
        by smtp.googlemail.com with ESMTPSA id a14-20020a170906368e00b006fec5cef701sm1099080ejc.197.2022.06.01.14.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 14:39:25 -0700 (PDT)
From:   David Virag <virag.david003@gmail.com>
Cc:     phone-devel@vger.kernel.org,
        David Virag <virag.david003@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] dt-bindings: clock: Add bindings for Exynos7885 CMU_FSYS
Date:   Thu,  2 Jun 2022 01:37:39 +0200
Message-Id: <20220601233743.56317-2-virag.david003@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220601233743.56317-1-virag.david003@gmail.com>
References: <20220601233743.56317-1-virag.david003@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CMU_FSYS clock domain provides clocks for MMC (MMC_CARD, MMC_EMBD,
MMC_SDIO), and USB30DRD.

Add clock indices and bindings documentation for CMU_FSYS domain.

Signed-off-by: David Virag <virag.david003@gmail.com>
---
 .../clock/samsung,exynos7885-clock.yaml       | 27 ++++++++++++++++
 include/dt-bindings/clock/exynos7885.h        | 31 ++++++++++++++++++-
 2 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/samsung,exynos7885-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynos7885-clock.yaml
index 5073e569a47f..006d33a9e0f1 100644
--- a/Documentation/devicetree/bindings/clock/samsung,exynos7885-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/samsung,exynos7885-clock.yaml
@@ -33,6 +33,7 @@ properties:
     enum:
       - samsung,exynos7885-cmu-top
       - samsung,exynos7885-cmu-core
+      - samsung,exynos7885-cmu-fsys
       - samsung,exynos7885-cmu-peri
 
   clocks:
@@ -88,6 +89,32 @@ allOf:
             - const: dout_core_cci
             - const: dout_core_g3d
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynos7885-cmu-fsys
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: External reference clock (26 MHz)
+            - description: CMU_FSYS bus clock (from CMU_TOP)
+            - description: MMC_CARD clock (from CMU_TOP)
+            - description: MMC_EMBD clock (from CMU_TOP)
+            - description: MMC_SDIO clock (from CMU_TOP)
+            - description: USB30DRD clock (from CMU_TOP)
+
+        clock-names:
+          items:
+            - const: oscclk
+            - const: dout_fsys_bus
+            - const: dout_fsys_mmc_card
+            - const: dout_fsys_mmc_embd
+            - const: dout_fsys_mmc_sdio
+            - const: dout_fsys_usb30drd
+
   - if:
       properties:
         compatible:
diff --git a/include/dt-bindings/clock/exynos7885.h b/include/dt-bindings/clock/exynos7885.h
index 1f8701691d62..d2e1483f93e4 100644
--- a/include/dt-bindings/clock/exynos7885.h
+++ b/include/dt-bindings/clock/exynos7885.h
@@ -54,7 +54,22 @@
 #define CLK_GOUT_PERI_USI0		43
 #define CLK_GOUT_PERI_USI1		44
 #define CLK_GOUT_PERI_USI2		45
-#define TOP_NR_CLK			46
+#define CLK_MOUT_FSYS_BUS		46
+#define CLK_MOUT_FSYS_MMC_CARD		47
+#define CLK_MOUT_FSYS_MMC_EMBD		48
+#define CLK_MOUT_FSYS_MMC_SDIO		49
+#define CLK_MOUT_FSYS_USB30DRD		50
+#define CLK_DOUT_FSYS_BUS		51
+#define CLK_DOUT_FSYS_MMC_CARD		52
+#define CLK_DOUT_FSYS_MMC_EMBD		53
+#define CLK_DOUT_FSYS_MMC_SDIO		54
+#define CLK_DOUT_FSYS_USB30DRD		55
+#define CLK_GOUT_FSYS_BUS		56
+#define CLK_GOUT_FSYS_MMC_CARD		57
+#define CLK_GOUT_FSYS_MMC_EMBD		58
+#define CLK_GOUT_FSYS_MMC_SDIO		59
+#define CLK_GOUT_FSYS_USB30DRD		60
+#define TOP_NR_CLK			61
 
 /* CMU_CORE */
 #define CLK_MOUT_CORE_BUS_USER		1
@@ -112,4 +127,18 @@
 #define CLK_GOUT_WDT1_PCLK		43
 #define PERI_NR_CLK			44
 
+/* CMU_FSYS */
+#define CLK_MOUT_FSYS_BUS_USER		1
+#define CLK_MOUT_FSYS_MMC_CARD_USER	2
+#define CLK_MOUT_FSYS_MMC_EMBD_USER	3
+#define CLK_MOUT_FSYS_MMC_SDIO_USER	4
+#define CLK_MOUT_FSYS_USB30DRD_USER	4
+#define CLK_GOUT_MMC_CARD_ACLK		5
+#define CLK_GOUT_MMC_CARD_SDCLKIN	6
+#define CLK_GOUT_MMC_EMBD_ACLK		7
+#define CLK_GOUT_MMC_EMBD_SDCLKIN	8
+#define CLK_GOUT_MMC_SDIO_ACLK		9
+#define CLK_GOUT_MMC_SDIO_SDCLKIN	10
+#define FSYS_NR_CLK			11
+
 #endif /* _DT_BINDINGS_CLOCK_EXYNOS_7885_H */
-- 
2.36.1

