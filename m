Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C17595D6C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 15:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235767AbiHPNas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 09:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235763AbiHPNa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:30:26 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E23B8F28
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:30:24 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id v2so14934261lfi.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=rpFTAZjl2pleYfeFAlCfw7Z2JDn36v61i5OIVLO2w5I=;
        b=uvTyRrDNC6QxEbZyA44Zxl3dL5k8aNXBoKjruHNBXGtk2zV6fnuu5vtZ4/2VwKy1/w
         1JPKp2UYomYYlmfRq6xgSv65G3QbqSt8okEA9Zal7bs2g+N4DMft9up8OGlH4E6QA0Lt
         gy6tWDnwimp4O8ZuTVeavEa2wTzOcaqmwRTDXQ+178hWWkkIYdpgmXZzNih2pdvWejUb
         Y80rYquHbGE7znX/n+mmZRKoTN7NsS4gLtmmP2jqzK9V3KV4Jcm3WPaKdIWpppfwue8f
         oRQfxNDbbIaNn2yyXcxDSeONpbGTpxdrECS+nJ5Z20pVahG3+E+mbhZS3/1UuAFSWG0r
         Yr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=rpFTAZjl2pleYfeFAlCfw7Z2JDn36v61i5OIVLO2w5I=;
        b=kwkNb9awQKbcYuooNUhDEwQNeaxBNwCkXr8B3sfUA0Z37dyy1jbcTNCCIXyrtrJtJL
         PAq1GLdjYUiGiil4AxN6fxRAIKkiv8fvkJMIm+6jJUjx1ZzVG8xCU23p0F7Xvtvg8PS4
         VO89vsXq6OPS5LiWC17GO6zFKac90SvvlZ2ZVp7GD10gpL7T17nQbPHlNmOR2dNp33Sj
         rE+RB1c1rlnYCZKQSiz+VuZLjkLxV/skZKRXDe+ZdJZbLdv8Kw4E3o16Hcn5PsvpddUY
         nMPeYx4ovvI696iOOze6UiuUBJhWi9qxxaZOhqcwme6DlP4Z5sVpgUHLSDJoQzGZGMXV
         jbqA==
X-Gm-Message-State: ACgBeo2FX7hxw7lLIaUiEkGTnJn0Wr14L+LFQVgiH+6cY/ecfxQi1PFD
        jAwLg2wSSwndbr9KGj6Y2yx4jA==
X-Google-Smtp-Source: AA6agR4Goe1n8aiYtC29+SCFdUP5bbCFlxfNYNF/MgBrjfL/Ht7JGKQpdw+rOfy5V5n3hRIXo+LcWA==
X-Received: by 2002:a05:6512:39c3:b0:48b:90c2:da4c with SMTP id k3-20020a05651239c300b0048b90c2da4cmr6806066lfu.282.1660656622369;
        Tue, 16 Aug 2022 06:30:22 -0700 (PDT)
Received: from krzk-bin.. (d15l54g8c71znbtrbzt-4.rev.dnainternet.fi. [2001:14bb:ae:539c:1782:dd68:b0c1:c1a4])
        by smtp.gmail.com with ESMTPSA id k19-20020a2eb753000000b0025e42f8e771sm1816301ljo.34.2022.08.16.06.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 06:30:21 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Tomasz Figa <tomasz.figa@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Chanho Park <chanho61.park@samsung.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 2/2] dt-bindings: pinctrl: samsung: deprecate header with register constants
Date:   Tue, 16 Aug 2022 16:30:16 +0300
Message-Id: <20220816133016.77553-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220816133016.77553-1-krzysztof.kozlowski@linaro.org>
References: <20220816133016.77553-1-krzysztof.kozlowski@linaro.org>
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

For convenience (less code duplication, some meaning added to raw
number), the pin controller pin configuration register values
were defined in the bindings header.  These are not some IDs or other
abstraction layer but raw numbers used in the registers

These constants do not fit the purpose of bindings.  They do not provide
any abstraction, any hardware and driver independent ID.  With minor
exceptions, the Linux drivers actually do not use the bindings header at
all.

All of the constants were moved already to headers local to DTS
(residing in DTS directory) and to Samsung pinctrl driver (where
applicable), so remove any references to the bindings header and add a
warning tha tit is deprecated.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Chanho Park <chanho61.park@samsung.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 include/dt-bindings/pinctrl/samsung.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/dt-bindings/pinctrl/samsung.h b/include/dt-bindings/pinctrl/samsung.h
index 950970634dfe..d1da5ff68d0c 100644
--- a/include/dt-bindings/pinctrl/samsung.h
+++ b/include/dt-bindings/pinctrl/samsung.h
@@ -10,6 +10,13 @@
 #ifndef __DT_BINDINGS_PINCTRL_SAMSUNG_H__
 #define __DT_BINDINGS_PINCTRL_SAMSUNG_H__
 
+/*
+ * These bindings are deprecated, because they do not match the actual
+ * concept of bindings but rather contain pure register values.
+ * Instead include the header in the DTS source directory.
+ */
+#warning "These bindings are deprecated. Instead use the header in the DTS source directory."
+
 #define EXYNOS_PIN_PULL_NONE		0
 #define EXYNOS_PIN_PULL_DOWN		1
 #define EXYNOS_PIN_PULL_UP		3
-- 
2.34.1

