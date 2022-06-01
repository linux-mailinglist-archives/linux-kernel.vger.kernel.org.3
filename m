Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994AC53B02E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 00:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbiFAVjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 17:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbiFAVja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 17:39:30 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE2713AF1A;
        Wed,  1 Jun 2022 14:39:29 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id m20so6310687ejj.10;
        Wed, 01 Jun 2022 14:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YrD+JEX1Oyzn9nFf3iDdJCONtWaGtv1YVuVMGJJHK5Q=;
        b=nOv8RtH0HFqY9i7kNtIoUlTj2rA2stFdVxrRngb+qGhR/TWT/rigMl54nX/AdF2EmJ
         ZUbTEToOQZbKDzyqCylt7vvkZKKGNadgfTNQ+nswaoJhyKHyP8yPaSuDdqw7UJf5oDD4
         Xp0PIDgaCddRZIB6ORNldu/wDv4AD3x7ixCO/35lJG94B3jQCOxS//xiu7Nl8csRmGDf
         R2czBGSlouCmrJLCnfHQjbKNl1iVOlAfMtD9rNm0+AiuVLm6GzxJQvpf7xRDClQrMEeQ
         IavsMhJlmiIj0XxDmC1w6b9yWUZCEeJvFkM2me8J6zBIE1cc0WDPo+Tal+Gfdf/ZECni
         +3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YrD+JEX1Oyzn9nFf3iDdJCONtWaGtv1YVuVMGJJHK5Q=;
        b=7TtcwvBRIpq7HiJU03e0moYooSGYy/KRKzbaWPu1tdpntUvlUCgoyuONnUjRLCgUU0
         Ik48zI8kIq4oW0a7DNxoWuoWTnrDQHWjzAXA1vw1BvOEji0AqDH1s328oudErvNDr8aM
         Kj8H8xVROe23Yq4w9sW+pNJ+ajbBwNccZCrJMrpWUiLbHKn6QS6opX9HTcniR6UnJ0/4
         I+lBgjfgvUF5/Dt1qJwX8Z7+upPiCV87K9nAlPHfyFdTLtIB7qeHArebhPb8iXu7lhWg
         E3kTEYl53rh5VQd9XoPAA1shIErH7GnpyWWIC5qHx4+Pl7aFPpiraNiWax0Kd93R2EQf
         gpoQ==
X-Gm-Message-State: AOAM530Bv+c60aSzEaGh//M88GHE8ext5lY8XK9bQwNuv5/2YwJ3AyoL
        xG668z3X8kJiFNA+3uc+44z7EjYI+QjcJI9O
X-Google-Smtp-Source: ABdhPJyM3NgfnvqESXniyXc5csiFFzHjwGb/h5F6Rwnq8DGxDzv81rOML4H3v38fSxlsgdiQIEAr0w==
X-Received: by 2002:a17:906:4b55:b0:6fe:c52c:68c9 with SMTP id j21-20020a1709064b5500b006fec52c68c9mr1439158ejv.491.1654119567976;
        Wed, 01 Jun 2022 14:39:27 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:368f:2080:5d6e:322:57b6:5f03])
        by smtp.googlemail.com with ESMTPSA id a14-20020a170906368e00b006fec5cef701sm1099080ejc.197.2022.06.01.14.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 14:39:27 -0700 (PDT)
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
Subject: [PATCH 2/5] dt-bindings: clock: Add indices for Exynos7885 TREX clocks
Date:   Thu,  2 Jun 2022 01:37:40 +0200
Message-Id: <20220601233743.56317-3-virag.david003@gmail.com>
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

TREX D Core and P core clocks seem to be related to the BTS (Bus Traffic
Shaper) inside the Exynos7885 SoC, and are needed for the SoC to
function correctly.

Add indices for these clocks.

Signed-off-by: David Virag <virag.david003@gmail.com>
---
 include/dt-bindings/clock/exynos7885.h | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/include/dt-bindings/clock/exynos7885.h b/include/dt-bindings/clock/exynos7885.h
index d2e1483f93e4..8256e7430b63 100644
--- a/include/dt-bindings/clock/exynos7885.h
+++ b/include/dt-bindings/clock/exynos7885.h
@@ -72,14 +72,21 @@
 #define TOP_NR_CLK			61
 
 /* CMU_CORE */
-#define CLK_MOUT_CORE_BUS_USER		1
-#define CLK_MOUT_CORE_CCI_USER		2
-#define CLK_MOUT_CORE_G3D_USER		3
-#define CLK_MOUT_CORE_GIC		4
-#define CLK_DOUT_CORE_BUSP		5
-#define CLK_GOUT_CCI_ACLK		6
-#define CLK_GOUT_GIC400_CLK		7
-#define CORE_NR_CLK			8
+#define CLK_MOUT_CORE_BUS_USER			1
+#define CLK_MOUT_CORE_CCI_USER			2
+#define CLK_MOUT_CORE_G3D_USER			3
+#define CLK_MOUT_CORE_GIC			4
+#define CLK_DOUT_CORE_BUSP			5
+#define CLK_GOUT_CCI_ACLK			6
+#define CLK_GOUT_GIC400_CLK			7
+#define CLK_GOUT_TREX_D_CORE_ACLK		8
+#define CLK_GOUT_TREX_D_CORE_GCLK		9
+#define CLK_GOUT_TREX_D_CORE_PCLK		10
+#define CLK_GOUT_TREX_P_CORE_ACLK_P_CORE	11
+#define CLK_GOUT_TREX_P_CORE_CCLK_P_CORE	12
+#define CLK_GOUT_TREX_P_CORE_PCLK		13
+#define CLK_GOUT_TREX_P_CORE_PCLK_P_CORE	14
+#define CORE_NR_CLK				15
 
 /* CMU_PERI */
 #define CLK_MOUT_PERI_BUS_USER		1
-- 
2.36.1

