Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3EB547A9B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 17:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237453AbiFLPBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 11:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237519AbiFLPAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 11:00:53 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A2A49FB9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 08:00:33 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 0B3404B00E;
        Sun, 12 Jun 2022 20:00:17 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1655046017; bh=YkgwOu6ZXEnQVwZ7+RjB1T33+mj+xdkO/PzEYrrkkhs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lZGBZ1zr8BtDwIPN4VBtMaKu6BZa42YkiUepAHQTlLIODBEt/wBgd5ZNXfa4Co65O
         t6k4rL0b+gzMAKuS+MjdVZWqLUjxTKH7Q94HydHeoDrNBaU1DhxLdbLTJPwf80Qy5K
         jyADX/M23R+QaKbqEToZ6oQFhJSkz7rtqSyihL4AFAuY9v2D8U/YkiZVjefSRK1bhz
         ThgKEAEgmY7FhKhSEfLekPGor+4mzdr35qApJa44thwbmvXequlzpHgS6ogtIpeHtU
         iGsWu0YgndvYV7s6jMD4KVIevxEh/QmCWnEbzcKj/MdTFFGRBeUfDqWeQNWh6d1wr9
         d1dLGDTSPVdaw==
From:   Nikita Travkin <nikita@trvn.ru>
To:     mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, tdas@codeaurora.org,
        joonwoop@codeaurora.org, svarbanov@mm-sol.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v2 2/4] clk: qcom: clk-rcg2: Make sure to not write d=0 to the NMD register
Date:   Sun, 12 Jun 2022 19:59:53 +0500
Message-Id: <20220612145955.385787-3-nikita@trvn.ru>
In-Reply-To: <20220612145955.385787-1-nikita@trvn.ru>
References: <20220612145955.385787-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes calculation of d value may result in 0 because of the
rounding after integer division. This causes the following error:

[  113.969689] camss_gp1_clk_src: rcg didn't update its configuration.
[  113.969754] WARNING: CPU: 3 PID: 35 at drivers/clk/qcom/clk-rcg2.c:122 update_config+0xc8/0xdc

Make sure that D value is never zero.

Fixes: 7f891faf596e ("clk: qcom: clk-rcg2: Add support for duty-cycle for RCG")
Signed-off-by: Nikita Travkin <nikita@trvn.ru>

---
v2:
 - Use clamp()
---
 drivers/clk/qcom/clk-rcg2.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index 2375e8122012..28019edd2a50 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -13,6 +13,7 @@
 #include <linux/rational.h>
 #include <linux/regmap.h>
 #include <linux/math64.h>
+#include <linux/minmax.h>
 #include <linux/slab.h>
 
 #include <asm/div64.h>
@@ -461,9 +462,11 @@ static int clk_rcg2_set_duty_cycle(struct clk_hw *hw, struct clk_duty *duty)
 	/* Calculate 2d value */
 	d = DIV_ROUND_CLOSEST(n * duty_per * 2, 100);
 
-	 /* Check bit widths of 2d. If D is too big reduce duty cycle. */
-	if (d > mask)
-		d = mask;
+	/*
+	 * Check bit widths of 2d. If D is too big reduce duty cycle.
+	 * Also make sure it is never zero.
+	 */
+	d = clamp_val(d, 1, mask);
 
 	if ((d / 2) > (n - m))
 		d = (n - m) * 2;
-- 
2.35.3

