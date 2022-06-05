Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D455753DCCB
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 18:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351154AbiFEQGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 12:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351089AbiFEQFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 12:05:39 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB134DF66
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 09:05:36 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id s12so17502409ejx.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 09:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UnEy8V6gE2d73YKWzCoW+lrNzkfCzBornaZdJIUsn5E=;
        b=h54vGCuf3s+A0WXKEjiezuYcYr+FXOViaAKSe3vpyle6501XMhcOzwFUgBrgrBGBqb
         ToLxit6RzDkwbX0zo5cnu74DseWJjpLY2YcpOkdTYyq+lOAmsFfZ1D0oxCts9As3DeRT
         wREjZpDjVbtTlXs/9BD/HJBJGAOxiUJ1M/I8BlMlpF/1siVYKvxGVdQP3FB2O6VpVa8A
         5g3WnU+7cD4KaKjK0NyoSjOAzJvIzkLqvmedNJJl6kZFzrrOh3SozFseFMaRKce12qrX
         fbBzVd89F5xMVloY0VohIk0zpRp0lWyKzsv7p2L48cFm8PRcmWz4mwB+syzPx3/IlhKr
         9Ohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UnEy8V6gE2d73YKWzCoW+lrNzkfCzBornaZdJIUsn5E=;
        b=DbPzunS6Z7L9qJ7advfPVAy7B+k3FeVwKm2YHhM4ig7wk5hl6TJMmCh7nWm3BeMUo+
         smvtvTAOCe316H/QrzL47nzV9qk9WiT77bzLkPybM4VuM6eMruzyY2+/+3rermX9MdC8
         mu4bYaDcjBYkxf1SS3TAvDN28HxKB8v217/9kZLeyXcfYecUO8gyvp9POvD1M3k/+x8z
         P1poU+EFS7+hVdR6iOAK/HXSaJvDtgzXht+iTJa2xupPkPHpHD4Aso7HSOGgVGitU8KM
         BkiyacLEjbdctuA1Gjos0Pkh8gxTudHiN8lu4VMPUJ48MwUc76SL7g0s85CNc0Rqd71a
         eokg==
X-Gm-Message-State: AOAM531D0CSseBBnXha5TnaQYeaLIoKJNk1T46HbnQ+TPU2ZhNaCIR37
        9efheElR0a4m50DU4HrzVeBqTQ==
X-Google-Smtp-Source: ABdhPJySBYFwVYmEJKD+EOusGlyb+c6/Fify1F32ILKzFx8KeU09tbhoLpC+yspCW/dCCme1S5Pa+w==
X-Received: by 2002:a17:907:6e88:b0:707:ea6b:5e15 with SMTP id sh8-20020a1709076e8800b00707ea6b5e15mr17481798ejc.57.1654445134865;
        Sun, 05 Jun 2022 09:05:34 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id x18-20020a170906805200b0070b7875aa6asm3969963ejw.166.2022.06.05.09.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 09:05:34 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chanho Park <chanho61.park@samsung.com>,
        Linus Walleij <linus.wallej@linaro.org>
Subject: [PATCH v3 8/8] dt-bindings: pinctrl: samsung: deprecate header with register constants
Date:   Sun,  5 Jun 2022 18:05:08 +0200
Message-Id: <20220605160508.134075-9-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220605160508.134075-1-krzysztof.kozlowski@linaro.org>
References: <20220605160508.134075-1-krzysztof.kozlowski@linaro.org>
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
Reviewed-by: Linus Walleij <linus.wallej@linaro.org>
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

