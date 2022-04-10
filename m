Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0DD4FB040
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 22:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242337AbiDJU6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 16:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234484AbiDJU6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 16:58:51 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040E3BB9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 13:56:39 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id p8so11818394qvv.5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 13:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prism19-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v4Dm0zZiVNz+3KjhnBsylTDpY1b0Arid63IH2fuAnik=;
        b=XrE9JJrRaF5iLY2JPFzzhhBr+NmyNaXlURO7Am8sXuwB5LTKcNq7cbc57ZCESWKJVA
         ViMCAynxoDmUwjI3l1MH/DclLSskI/r/ezCnkW2hNwIg9LL6WvqwNgFjxvNYO2gs7TZO
         v9I9kihxoJBmmWlji9Jg6CjthaNKMaL3SaeKWU4Cc4/bk6sdhCfBHfx8kQxq/CyEcKOM
         SQYmaRjaJw25yY2fjA4rh+L8UAr/TBEJ5onCKlHA7+Is6ftwEPo7OapWRPU5ElVav7jQ
         JGUDps5Y6qtMvtJaDEJUAEBadoEeIy4Xiok33I4BWXH+WkEkTffro2AgOmLm1NcX1elX
         fr8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v4Dm0zZiVNz+3KjhnBsylTDpY1b0Arid63IH2fuAnik=;
        b=Mbj7aw8UKOA2zGiZVk9o7IIyxN2lmugAZpqrCxZZbyCrXLAsXhsS28Prc9oPYQ3M0x
         4+QgZ9nYD3Y2OVWfuXTxtDuV2d3I5BkKrp6/JDRQ4d2F+tM+DNoOshzTwvMFwwQCvF+c
         v2wD/8YPWRFCrFwqYJJf+MPzSDEtOGReVaXhh16O/DrGvfsM8tTvjijpv4w6EL8mRmhY
         jKLAJYBpDA9u9VXM3CN/BvfXeSBiQKSSXxfAWu2QS8qhU7CsI+7m9rp2k7RVnRqHNapn
         SYric04Lsh+sjzZwS1JHn/No3FUOBLHiz+F/qx3RvYHbUovuiWeoiM90KMSVmrmmESA9
         0LNg==
X-Gm-Message-State: AOAM530XBJyof4cFT8KPWuNb6A3PhlBa7ZXS9iD04eon6uqDVf8aEyni
        I6MXXM0yJz9AbkOB9XO1jkZN3cbvPPzridg6KAdw7Q==
X-Google-Smtp-Source: ABdhPJzKr+05g1w/9S4kzn27/Px/j9DsPrGWiXdcX3y2gI1UMnWoBRqzRfgcxanrSdHR+07WQSThEA==
X-Received: by 2002:a05:6214:1d2b:b0:441:6a41:f726 with SMTP id f11-20020a0562141d2b00b004416a41f726mr24547900qvd.102.1649624198180;
        Sun, 10 Apr 2022 13:56:38 -0700 (PDT)
Received: from RADIUM.localdomain (bras-base-mtrlpq2718w-grc-02-76-67-205-66.dsl.bell.ca. [76.67.205.66])
        by smtp.googlemail.com with ESMTPSA id bl22-20020a05620a1a9600b00680da570a5dsm19073102qkb.61.2022.04.10.13.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 13:56:37 -0700 (PDT)
From:   Guillaume Giraudon <ggiraudon@prism19.com>
To:     kernel-dev@prism19.com
Cc:     ggiraudon@prism19.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: meson-sm1-bananapi-m5: fix wrong GPIO pin labeling for CON1
Date:   Sun, 10 Apr 2022 16:56:24 -0400
Message-Id: <20220410205624.14295-1-ggiraudon@prism19.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The labels for lines 61 through 84 on the periphs-banks were offset by 2.
Realigned them to match the Banana Pi M5 schematics.

Signed-off-by: Guillaume Giraudon <ggiraudon@prism19.com>
---
 arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
index 5751c48620ed..754c3d43ef0b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
@@ -448,7 +448,7 @@
 		"",
 		/* GPIOA */
 		"", "", "", "", "", "", "", "",
-		"", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
 		"CON1-P27", /* GPIOA_14 */
 		"CON1-P28", /* GPIOA_15 */
 		/* GPIOX */
-- 
2.20.1

