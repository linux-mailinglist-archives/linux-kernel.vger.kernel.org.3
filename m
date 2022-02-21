Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0354F4BE542
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358778AbiBUNLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 08:11:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358657AbiBUNLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 08:11:30 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D870A1EEF4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:10:52 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id az26-20020a05600c601a00b0037c078db59cso11160137wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 05:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=at3S5biHzZRQ5m3HY8Vsi7c1hMS+BWBfzlmLlepvupM=;
        b=faIwDDvCMFUEF365S3xjC5ACrPp7alH7moZZBT7u8h2JopCKjQv6oR0hnojsJxt4nX
         gW8YPghV7MzBMDBMSxDzkxge6UPqxV8PHiEwbndMtwbClQHyCV07RL1yRAs8m6hepQ/I
         l9x4Jryu6tq34aXWJs3Px21zIpSusUdKkGUrkhljHfU1omzZJ7myLsumwSDmpEibKffn
         ETCAun07s1vRNZ0kgrU+MTbScQ/wzYQlrvVeub74t2cIsLNnuVpUrLxXbaIQ3GMyLtZN
         twP4OWM99hLins9KsaQqWdc5M7sHE6LxCTu9lkMTQCztm1xtIsiR+Rp/iGvHdQkMuI0+
         ypyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=at3S5biHzZRQ5m3HY8Vsi7c1hMS+BWBfzlmLlepvupM=;
        b=rMEUc+vlRsEYL7WV+wgLlLGheqswN9NogIJkzfRmpHVlwETEEpyr7zICizZo+wdgJa
         oQUdO/hfbLpLRXJhOmMO05TVkbIMo0yjqHW9oq2xwKJAM1ff92X56BXH5uqJSk61zLfo
         V+Mu7Kps2A28zANVv76s3t7gjewbyATrnlZnGLViePEjeKi3kLXnTP7Z3fzYU+KwHQtU
         nzE09uxInqtSz3VoVnL6pccNb3dKAqn8kKhoJwNtvECiypPB2a7VMvh89HY07gBMa5mj
         VqglMAkR1D62je1qSHicWaKsXTTGWXbnyBY7qKaqlD9lAXblP7Mx4mNaV9jqyXn6cOMS
         1qgA==
X-Gm-Message-State: AOAM530YTvOgBfHM80K+UC0iUY1LEH2u6ZZqboQFUDTm97dj+thvvA+L
        7eyVRZhjQjn58KUfFUmc5t936olKR1chcw==
X-Google-Smtp-Source: ABdhPJwdS0x6aEHX2AWFNqZ0uWaJOk2qtndMD9nkFanM/s2IpgpnWoYitl9TdBmG9QSBo7veMQobBQ==
X-Received: by 2002:a1c:4443:0:b0:34d:a9d6:884 with SMTP id r64-20020a1c4443000000b0034da9d60884mr21774467wma.50.1645449051415;
        Mon, 21 Feb 2022 05:10:51 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id 3sm49412801wrz.86.2022.02.21.05.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 05:10:50 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 09/10] ASoC: codecs: tx-macro: setup soundwire clks correctly
Date:   Mon, 21 Feb 2022 13:10:36 +0000
Message-Id: <20220221131037.8809-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220221131037.8809-1-srinivas.kandagatla@linaro.org>
References: <20220221131037.8809-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For SoundWire Frame sync to be generated correctly we need both MCLK
and MCLKx2 (npl). Without pm runtime enabled these two clocks will remain on,
however after adding pm runtime support its possible that NPl clock could be
turned off even when SoundWire controller is active.

Fix this by enabling mclk and npl clk when SoundWire clks are enabled.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/lpass-tx-macro.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index 1c0f0d27ed42..f90786100d1a 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -1687,6 +1687,7 @@ static int swclk_gate_enable(struct clk_hw *hw)
 	struct tx_macro *tx = to_tx_macro(hw);
 	struct regmap *regmap = tx->regmap;
 
+	clk_prepare_enable(tx->clks[2].clk);
 	tx_macro_mclk_enable(tx, true);
 	if (tx->reset_swr)
 		regmap_update_bits(regmap, CDC_TX_CLK_RST_CTRL_SWR_CONTROL,
@@ -1713,6 +1714,7 @@ static void swclk_gate_disable(struct clk_hw *hw)
 			   CDC_TX_SWR_CLK_EN_MASK, 0x0);
 
 	tx_macro_mclk_enable(tx, false);
+	clk_disable_unprepare(tx->clks[2].clk);
 }
 
 static int swclk_gate_is_enabled(struct clk_hw *hw)
@@ -1750,7 +1752,7 @@ static struct clk *tx_macro_register_mclk_output(struct tx_macro *tx)
 	struct clk_init_data init;
 	int ret;
 
-	parent_clk_name = __clk_get_name(tx->clks[2].clk);
+	parent_clk_name = __clk_get_name(tx->clks[3].clk);
 
 	init.name = clk_name;
 	init.ops = &swclk_gate_ops;
-- 
2.21.0

