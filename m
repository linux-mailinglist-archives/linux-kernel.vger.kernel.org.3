Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB484E2D3D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350763AbiCUQKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350670AbiCUQJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:09:46 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39ADD26545;
        Mon, 21 Mar 2022 09:08:21 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id j13-20020a05600c1c0d00b0038c8f94aac2so4410128wms.3;
        Mon, 21 Mar 2022 09:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8h0dp/sRCWnE/SzxqBhwWtp3OCJwunZ7486W2HMfBko=;
        b=eMAAW4T4i4c8oUssXYgx110V91CsAvVQIGvLX9z3GI4RjCZxiOD8oqh7MCh/KNudSP
         piLBrwD9JIdDhfg2mXpo1bxKazBL6l+RlaK/YMcMyiEgKMtLzJ4nWi0F1v9+UiB9t5Ux
         kgjz6xybMBM3Sfi91CzFYpD0aewMPoKPFfhq0PgyU+/GpNJNyiqhleXpCBgxRa5Z7B+D
         3jDfre4Feyr0Fx7KzUW3Rcwc4WctWEVCb9iPZmJRfCQG/j0Cb8sMEc2T2otMC0a0Iuor
         A7Yc5al4ZvQeBQhe+RbqY5BuiZdHCQ20dTiHEgfEQ6gW1NMhFsB3xK9UcQ8v1G6bJgXd
         aZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8h0dp/sRCWnE/SzxqBhwWtp3OCJwunZ7486W2HMfBko=;
        b=Tanwq7c6wwXTA0aXLqm8K7vyvGbvnVBntd0Jb1D/ISzw/BGLMF6jvQzSZSsm6LDzs7
         +O8g8M1/tzoYfdiwgxc1dGEOJubBgXiYN+nYsRC38KBY8YrjfDWKz4wwTN5UkglLZVT6
         QU0H9bz9dfgHYgY9GYbeSbVypJOrrnZl70n2lW6+H/vvGQ9GW+eSpEA3u4i5iETs+pmM
         dehRRhUbRhX53pobVk+mlzSJcS058Y1S3WRGkD5h1+xuBNa9XxnHQ2pZYwsEHsHWq/Tw
         7Y5c2RxzWBBR/TKLt2foASPUHf1sd3f9IXuDrb28F/AYRPLntoTW2ap+2IYh3lHwPWZO
         5RmQ==
X-Gm-Message-State: AOAM531ylOu7GCVQxQW//W8tHKNrGE28ZluyTb2TzQ3upyJ1HMgQBBZC
        m+zv8IcRvwigDOZP8J0xCtt5CDJclAo=
X-Google-Smtp-Source: ABdhPJxs9iuvoQvrH/GpiNtxgRTLeoY4ZANQsUUXCIClS/8QRGTs+yHtpGU28ZIKTAHfyBFfnDbcbA==
X-Received: by 2002:a05:600c:3d0e:b0:38c:9b5e:52c0 with SMTP id bh14-20020a05600c3d0e00b0038c9b5e52c0mr8366210wmb.3.1647878899660;
        Mon, 21 Mar 2022 09:08:19 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id az19-20020a05600c601300b0038cadf3aa69sm2603864wmb.36.2022.03.21.09.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 09:08:19 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v5 04/18] clk: qcom: clk-hfpll: use poll_timeout macro
Date:   Mon, 21 Mar 2022 16:38:41 +0100
Message-Id: <20220321153855.12082-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220321153855.12082-1-ansuelsmth@gmail.com>
References: <20220321153855.12082-1-ansuelsmth@gmail.com>
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

