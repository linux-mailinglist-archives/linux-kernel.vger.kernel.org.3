Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB9E4E1CB7
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 17:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245516AbiCTQ3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 12:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245475AbiCTQ3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 12:29:40 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05081344FD;
        Sun, 20 Mar 2022 09:28:17 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d7so17849512wrb.7;
        Sun, 20 Mar 2022 09:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8h0dp/sRCWnE/SzxqBhwWtp3OCJwunZ7486W2HMfBko=;
        b=B0atMPIder4N8TYzrHjKga4/7nhsneKYsEcoH6kos02/gg5Yn2wwVo/AA73vcSdScA
         5+6kZJGk0GqaIWEuFkJeI2/yCIAH5X+FxabhJzXcedFjtZCcgSnU7nq6Qeeiod1cj85+
         26dN+n5uOgJOJNPJGDoOzxudbCnM7cpJlOt+nCMgRzsXBr689x7Llduc/k2f6i7Mqjzs
         U5Cs0O6e8/ewWfPwxqBFjsSxHhHoeqDm+Ug9duoj525HZZJZrI38MtdgcLip8mA5Jfgn
         HJcz1dNOM7zU3V/7xbvUBJ1TPTR31rDa580elBXgdYOUpe1hynwQM2v9NmPQLrCSRdUV
         2ZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8h0dp/sRCWnE/SzxqBhwWtp3OCJwunZ7486W2HMfBko=;
        b=H//iICjD7Lf55ewOUOF/c7KKA0/fHP8F1xy3wwVVw1Xx8KAYenPWKqWDFsEVdnLMC6
         VhsM5ldaJrg7fX4HJWQ5hp/sFKK7IcWixDeI9nDcPaf6XqcEl+9AROM7oKQEbajJGsnu
         uHurP/79NMmSqDD04XjzpQb4bc5vfmzn4QZ11rNNrcWDg2JJ8Lom0R0d3fW2HgTRX2O7
         Ll88PQMNuoAtANgc2Dp9doBg6xyDbcjXk1SEAq/q7le/S7bnb+lYhUnObUkRWfeHgrDo
         uxbSBeTs/rcVgnr6HVsgfOIxncOy67eed29ugDNh+n/jCcYv9CY8h1l/1n77e8eS8f9L
         V1UQ==
X-Gm-Message-State: AOAM533RYuJAatKTk2rpvKo5R6fQCO/DEqQMPZ/jgfaNdHFHHmA86Z90
        V2Yg5PjOfAunzQB3/nQ6WOE3dmFBeMo=
X-Google-Smtp-Source: ABdhPJzVnwSL99bC9SXDX+khcfZLP0yrgqadr9Ahdtx3UDvRCpWSKetOLw+Ppv/JNS9xkqj+x1qA1g==
X-Received: by 2002:adf:a4ce:0:b0:203:fce0:755e with SMTP id h14-20020adfa4ce000000b00203fce0755emr7469376wrb.510.1647793695282;
        Sun, 20 Mar 2022 09:28:15 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id y6-20020a05600015c600b00203fa70b4ebsm6760085wry.53.2022.03.20.09.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 09:28:14 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v3 04/18] clk: qcom: clk-hfpll: use poll_timeout macro
Date:   Sun, 20 Mar 2022 12:34:16 +0100
Message-Id: <20220320113430.26076-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220320113430.26076-1-ansuelsmth@gmail.com>
References: <20220320113430.26076-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use regmap_read_poll_timeout macro instead of do-while structure.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/clk-hfpll.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/qcom/clk-hfpll.c b/drivers/clk/qcom/clk-hfpll.c
index e847d586a73a..a4e347eb4d4d 100644
--- a/drivers/clk/qcom/clk-hfpll.c
+++ b/drivers/clk/qcom/clk-hfpll.c
@@ -12,6 +12,8 @@
 #include "clk-regmap.h"
 #include "clk-hfpll.h"
 
+#define HFPLL_BUSY_WAIT_TIMEOUT	100
+
 #define PLL_OUTCTRL	BIT(0)
 #define PLL_BYPASSNL	BIT(1)
 #define PLL_RESET_N	BIT(2)
@@ -72,13 +74,12 @@ static void __clk_hfpll_enable(struct clk_hw *hw)
 	regmap_update_bits(regmap, hd->mode_reg, PLL_RESET_N, PLL_RESET_N);
 
 	/* Wait for PLL to lock. */
-	if (hd->status_reg) {
-		do {
-			regmap_read(regmap, hd->status_reg, &val);
-		} while (!(val & BIT(hd->lock_bit)));
-	} else {
+	if (hd->status_reg)
+		regmap_read_poll_timeout(regmap, hd->status_reg, val,
+					 !(val & BIT(hd->lock_bit)), USEC_PER_MSEC * 2,
+					 HFPLL_BUSY_WAIT_TIMEOUT * USEC_PER_MSEC);
+	else
 		udelay(60);
-	}
 
 	/* Enable PLL output. */
 	regmap_update_bits(regmap, hd->mode_reg, PLL_OUTCTRL, PLL_OUTCTRL);
-- 
2.34.1

