Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5844E2BFD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350079AbiCUPU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349998AbiCUPTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:19:45 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15894DF35;
        Mon, 21 Mar 2022 08:18:00 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v22so7253555wra.2;
        Mon, 21 Mar 2022 08:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QkfgyebL6ZDeFyix3jLmVd6pOSFa+uhSyC95dgb9bxk=;
        b=cZz0U/iOVfloYC4f/0atTNYv/Stene+gmHS7w3Adc4pxem/fX5HAIxC/NtEd9nhtUa
         VVghCrlDb4OzRIUWSEGNha9hQZT/VZwfpKh4BO3fud8x5E8amyIdKcNWHGCDK4KGIk7v
         Xw+RbNvXMZkggipNI41PC4ZZFYwGLXMlSXoiJJXb/JBzlf16wtm1MXn7I60cn2hhz83t
         5LSDo63LqpTaIedlAirVU5DtEx+OY594kuIM0HTJbknFJzgdSO5H36Fy8mHwy/GShQYQ
         zYLkCZ3UbBzMD04kfLRgrCjsp1AD7ylSOwEaR636nd30lCTeC5LYEMV1ffbFIk4pj8bz
         ePrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QkfgyebL6ZDeFyix3jLmVd6pOSFa+uhSyC95dgb9bxk=;
        b=6gIW3hzwHPX7h9sRM+z2OFporGlJU+luHZLW4mAPf1Z+EShbd+nZZrCGeFkbOcyGbb
         r8MzoyDcVUaGEVBotTVm7NgQ20ciFDv7XHInV5c01doO3N8/VKdkXFfjBjl14uomsJKt
         5MiEtIeNypbn8QYpOo1yLW3CPMfa72RtUv+3TxSY60fF3e8HS3Y6kvnwvjNSrwLiaiNf
         vtCYjZqNcb0SALBX2YoexSJbg3M4ErVaa9WaPnhgBKUnuuOrZamLQRxwR2LCpSmYR/BW
         IxNWo7cMTNyFkJYICnV4mm/bW26TN6VMw/KUPCRmAnwWdF83bUhlPfL/r0L/w5L5Q9tr
         8/JA==
X-Gm-Message-State: AOAM532w3cVjWfRWAEArAu6sLr9n3Cc57pDKKBW/HYpQ7Cezpg6+tKBy
        0htIqbQt9YNW16MX03jJVVI=
X-Google-Smtp-Source: ABdhPJxMbMXydtFMNDRzOikc97iALRWa2BHY78yEDBsHK90MSNPoteJbnFWvEKyH3mW9aeeUucyS4w==
X-Received: by 2002:a5d:4890:0:b0:1ed:9d4e:f8ef with SMTP id g16-20020a5d4890000000b001ed9d4ef8efmr18962564wrq.595.1647875879268;
        Mon, 21 Mar 2022 08:17:59 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id 10-20020a5d47aa000000b00204012e4373sm7239729wrb.101.2022.03.21.08.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 08:17:58 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v4 13/18] clk: qcom: clk-krait: add enable disable ops
Date:   Mon, 21 Mar 2022 15:48:20 +0100
Message-Id: <20220321144825.11736-14-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220321144825.11736-1-ansuelsmth@gmail.com>
References: <20220321144825.11736-1-ansuelsmth@gmail.com>
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

Add enable/disable ops for krait mux. On disable the mux is set to the
safe selection.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/clk-krait.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/clk/qcom/clk-krait.c b/drivers/clk/qcom/clk-krait.c
index 7ba5dbc72bce..061af57b0ec2 100644
--- a/drivers/clk/qcom/clk-krait.c
+++ b/drivers/clk/qcom/clk-krait.c
@@ -85,7 +85,25 @@ static u8 krait_mux_get_parent(struct clk_hw *hw)
 	return clk_mux_val_to_index(hw, mux->parent_map, 0, sel);
 }
 
+static int krait_mux_enable(struct clk_hw *hw)
+{
+	struct krait_mux_clk *mux = to_krait_mux_clk(hw);
+
+	__krait_mux_set_sel(mux, mux->en_mask);
+
+	return 0;
+}
+
+static void krait_mux_disable(struct clk_hw *hw)
+{
+	struct krait_mux_clk *mux = to_krait_mux_clk(hw);
+
+	__krait_mux_set_sel(mux, mux->safe_sel);
+}
+
 const struct clk_ops krait_mux_clk_ops = {
+	.enable = krait_mux_enable,
+	.disable = krait_mux_disable,
 	.set_parent = krait_mux_set_parent,
 	.get_parent = krait_mux_get_parent,
 	.determine_rate = __clk_mux_determine_rate_closest,
-- 
2.34.1

