Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7018E531DF1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 23:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbiEWVi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 17:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiEWViv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 17:38:51 -0400
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [5.144.164.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAAC5C372
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 14:38:50 -0700 (PDT)
Received: from Marijn-Arch-PC.localdomain (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 2810B2051D;
        Mon, 23 May 2022 23:38:48 +0200 (CEST)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Marek <jonathan@marek.ca>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH 1/9] clk: divider: Introduce devm_clk_hw_register_divider_parent_hw()
Date:   Mon, 23 May 2022 23:38:29 +0200
Message-Id: <20220523213837.1016542-2-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220523213837.1016542-1-marijn.suijten@somainline.org>
References: <20220523213837.1016542-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the devres variant of clk_hw_register_divider_parent_hw() for
registering a divider clock with clk_hw parent pointer instead of parent
name.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 include/linux/clk-provider.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index c10dc4c659e2..4e07621849e6 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -831,6 +831,25 @@ struct clk *clk_register_divider_table(struct device *dev, const char *name,
 	__devm_clk_hw_register_divider((dev), NULL, (name), (parent_name), NULL,   \
 				  NULL, (flags), (reg), (shift), (width),     \
 				  (clk_divider_flags), NULL, (lock))
+/**
+ * devm_clk_hw_register_divider_parent_hw - register a divider clock with the clock framework
+ * @dev: device registering this clock
+ * @name: name of this clock
+ * @parent_hw: pointer to parent clk
+ * @flags: framework-specific flags
+ * @reg: register address to adjust divider
+ * @shift: number of bits to shift the bitfield
+ * @width: width of the bitfield
+ * @clk_divider_flags: divider-specific flags for this clock
+ * @lock: shared register lock for this clock
+ */
+#define devm_clk_hw_register_divider_parent_hw(dev, name, parent_hw, flags,   \
+					       reg, shift, width,	      \
+					       clk_divider_flags, lock)       \
+	__devm_clk_hw_register_divider((dev), NULL, (name), NULL,	      \
+				       (parent_hw), NULL, (flags), (reg),     \
+				       (shift), (width), (clk_divider_flags), \
+				       NULL, (lock))
 /**
  * devm_clk_hw_register_divider_table - register a table based divider clock
  * with the clock framework (devres variant)
-- 
2.36.1

