Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4342756D0A3
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 19:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiGJRwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 13:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiGJRwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 13:52:41 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EE01055E;
        Sun, 10 Jul 2022 10:52:40 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id bu1so3209347wrb.9;
        Sun, 10 Jul 2022 10:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AeSUffjgrxLIDrHX0WRm/GzkZY58B1bVWJKIzfHMVqY=;
        b=Fx0xAcxQswDl6PZOZPn4Ig2Gi+z8tQ3eW9sjga5TlDz1ubNvvqGiBOz+y61CqBBRrG
         7rtnn+Sw8cpEQvDGJeAhqBOD2vpmj0W+qQamEdEDi+vSGoGM2WYrTOozWjIRgwlYwtTH
         6MfIw+1j+v1FJsv8wmAWP03om3TOARE3okCdLHnzZoVhfe95oH++xbARRkV/iuvd7bO1
         vuYRUpxD0kMucxII8XXDqzNB1lTZ5so7rodpfMJXSLM3aCUofra54ax6iITHa5BTOes7
         8iviher/DChZKOOk2kr2wpZ0HjbcsbHAVb/L7+/mFqPcnWEzJLftQhpIAp9eJCEoPRKC
         vlBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AeSUffjgrxLIDrHX0WRm/GzkZY58B1bVWJKIzfHMVqY=;
        b=ivLaNDuCL+Wd1u0ZtVImSihYim6I0PAMlR1EAdFlNeV3Tf1qqoS218KV36dfQXWVvS
         japkHG/3SF3ZYqhfuGnmorVK2SjPfgrHT21uFVsXgbvr4I5RXeY59MuGU4Oj3uzz3E7B
         3U60Hf427bZdyHZVeCqN+frTspKnBy8kN/QPzWfSLiKjCSgNdQ+uK9lzsq/SAnKSAdWq
         /LAtW8IQN9HnHJiuKjJ5rZtn2Aw76RKaZAymgQyNkhi/ZBi281dZL7+PX6bS24xyqGac
         hQvpHmXsTDUpmNi0uyGstg4C4pM/xEQjaSk9Or4skVPHZI0pY+o3+/QfgxEdRXIvF+4w
         elLw==
X-Gm-Message-State: AJIora9RVBBLUyUZ37yYtK0OklL/mAS5uWjQ4GnjD9j0ZRbfC2eXvWn/
        TrizREudIZmNSZ0CtW9/14gVl+aZ3Tw=
X-Google-Smtp-Source: AGRyM1tO70VRNWP+zx9h+dZMqVSgs/r1nVqGy2ngqLU80XsFfk9kYgm6wOt2MUcya3rcsubm/NQJDA==
X-Received: by 2002:a5d:6dab:0:b0:21d:9fc8:3029 with SMTP id u11-20020a5d6dab000000b0021d9fc83029mr4189820wrs.172.1657475558497;
        Sun, 10 Jul 2022 10:52:38 -0700 (PDT)
Received: from roman-Latitude-3400.globallogic.com ([195.234.74.2])
        by smtp.gmail.com with ESMTPSA id c8-20020a7bc848000000b003a2e7c13a3asm840346wml.42.2022.07.10.10.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 10:52:38 -0700 (PDT)
From:   Roman Stratiienko <r.stratiienko@gmail.com>
To:     samuel@sholland.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org, mripard@kernel.org,
        wens@csie.org, jernej.skrabec@gmail.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Roman Stratiienko <r.stratiienko@gmail.com>
Subject: [RFC] ccu-sun50i-h6: Bump-up DDR0 PLL to 1800MHz
Date:   Sun, 10 Jul 2022 20:52:14 +0300
Message-Id: <20220710175214.544748-1-r.stratiienko@gmail.com>
X-Mailer: git-send-email 2.34.1
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

While debugging complex animated composition cases  I noticed a glitch
which as it turned-out eventually was caused by lack of memory bandwidth.

I can't find a DRAMC manual to check what input frequency must be
supplied to avoid exceeding the 800MHz LPDDR3 which is installed on
my orangepi3 board. But the system is running stable so far.

Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
---
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
index 750368a86b8b6..abdde80307993 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
@@ -1203,6 +1203,17 @@ static int sun50i_h6_ccu_probe(struct platform_device *pdev)
 	val &= ~GENMASK(3, 0);
 	writel(val, reg + gpu_clk.common.reg);
 
+	/*
+	 * Increase DDR0 PLL from 1488(default) to 1800MHz.
+	 * (DE3.0 require higher memory bandwidth while displaying
+	 * complex composition at 1920x1080@60FPS)
+	 */
+
+	val = readl(reg + SUN50I_H6_PLL_DDR0_REG);
+	val &= ~GENMASK(15, 0);
+	val |= 74 << 8;
+	writel(val, reg + SUN50I_H6_PLL_DDR0_REG);
+
 	/* Enable the lock bits on all PLLs */
 	for (i = 0; i < ARRAY_SIZE(pll_regs); i++) {
 		val = readl(reg + pll_regs[i]);
-- 
2.34.1

