Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C4553AF80
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 00:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbiFAWIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 18:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbiFAWIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 18:08:00 -0400
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [IPv6:2001:4b7a:2000:18::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C5F227CD6
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 15:07:55 -0700 (PDT)
Received: from Marijn-Arch-PC.localdomain (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 619BE206BF;
        Thu,  2 Jun 2022 00:07:51 +0200 (CEST)
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
Subject: [PATCH v2 02/11] clk: mux: Introduce devm_clk_hw_register_mux_parent_hws()
Date:   Thu,  2 Jun 2022 00:07:38 +0200
Message-Id: <20220601220747.1145095-3-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220601220747.1145095-1-marijn.suijten@somainline.org>
References: <20220601220747.1145095-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the devres variant of clk_hw_register_mux_hws() for registering a
mux clock with clk_hw parent pointers instead of parent names.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 include/linux/clk-provider.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 4e07621849e6..316c7e082934 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -980,6 +980,13 @@ struct clk *clk_register_mux_table(struct device *dev, const char *name,
 			      (parent_names), NULL, NULL, (flags), (reg),     \
 			      (shift), BIT((width)) - 1, (clk_mux_flags),     \
 			      NULL, (lock))
+#define devm_clk_hw_register_mux_parent_hws(dev, name, parent_hws,	      \
+					    num_parents, flags, reg, shift,   \
+					    width, clk_mux_flags, lock)       \
+	__devm_clk_hw_register_mux((dev), NULL, (name), (num_parents), NULL,  \
+				   (parent_hws), NULL, (flags), (reg),        \
+				   (shift), BIT((width)) - 1,		      \
+				   (clk_mux_flags), NULL, (lock))
 
 int clk_mux_val_to_index(struct clk_hw *hw, const u32 *table, unsigned int flags,
 			 unsigned int val);
-- 
2.36.1

