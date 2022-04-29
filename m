Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359555148CC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358814AbiD2MH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 08:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358850AbiD2MHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 08:07:49 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A50C864B;
        Fri, 29 Apr 2022 05:04:30 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id i19so14976198eja.11;
        Fri, 29 Apr 2022 05:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jWJFJ4Mb0qP+VRMm4evCxcC91IxX72L57yrRrtHm9eg=;
        b=q3uXrUtoHQrV/np2U4K2tFvnoo8uawobQvYjxzU96LZkEh+PAnHUWzNHAUQfqNang9
         fUg7loVFAhlhowz+3FMrAvsBu/BFA9Tb7I7Ri1k7BljN5PPmMKNohIuUo/AAuy1dYhXe
         EWd2jWtSD5acJn+nuNJoCFSDs/zrB9iS7/B7uNp0Dv9YNyHJmOazRTk3ChOPfsEHPJoO
         zHaKC+5jn0NEoCAanfGzCS7HoWz9uN6Ek5/tFl9xfkGjmodCPD6cDCb0AHfi7iF87ERo
         rX7Su4xo2Ztzs1YHJyyy6Y+vu7mg05MuYA238qE8F1+CfvJRoIRwF1qL3DDVxURXIxvm
         Hi1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jWJFJ4Mb0qP+VRMm4evCxcC91IxX72L57yrRrtHm9eg=;
        b=L8mHtUze5YVkJSdVByTu22OyfLun2GKFqz2TOdo8G2qz5SxbNFpMTXbr9iZYV/2Pq9
         hxEuouLKN2SBhVjyIh+CxUNU9loqDShFeF9fTegxThTWw3YdtqIXugVgHLoV2oNZFzyV
         lDL+4xurH16ohslcWlD4oU/WoBo4RWSXMcopneXtHaIS437YSHCRZIv3ZWt2qI0ymOw8
         pGx08P9vIOo8plfTYNWZKTKMa7SRCL+955pbC/iQ1hzlzymHcde3/dLYv3mi+9Nb7FEo
         vbV+wsZssmsC8T0Ots7LrFcZ1VSCX/M5O9twtKKS8nIBZsS6gAWGzMbzBf9YbcO/fe8G
         hZmQ==
X-Gm-Message-State: AOAM531x56r3Fu9148Kl4rjj82LKt5wYT0aA0e33/pF3bi59LHHJ5qa0
        /2SIWnYyVeDDKUtT1DKuEUU=
X-Google-Smtp-Source: ABdhPJzsyMM0eTdOapwiissGROn9ZAJUlwqtSDXlcUfsVAmDv3KOyUId3Ml0Qd8+sMDkS0bjUsuJAg==
X-Received: by 2002:a17:906:4985:b0:6ef:b344:2a56 with SMTP id p5-20020a170906498500b006efb3442a56mr36753125eju.625.1651233869134;
        Fri, 29 Apr 2022 05:04:29 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id eo9-20020a1709069b0900b006f3ef214e02sm581338ejc.104.2022.04.29.05.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 05:04:28 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sricharan R <sricharan@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH 2/4] clk: qcom: clk-krait: unlock spin after mux completion
Date:   Fri, 29 Apr 2022 14:01:06 +0200
Message-Id: <20220429120108.9396-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220429120108.9396-1-ansuelsmth@gmail.com>
References: <20220429120108.9396-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlock spinlock after the mux switch is completed to prevent any corner
case of mux request while the switch still needs to be done.

Fixes: 4d7dc77babfe ("clk: qcom: Add support for Krait clocks")
Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/clk-krait.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clk-krait.c b/drivers/clk/qcom/clk-krait.c
index 59f1af415b58..90046428693c 100644
--- a/drivers/clk/qcom/clk-krait.c
+++ b/drivers/clk/qcom/clk-krait.c
@@ -32,11 +32,16 @@ static void __krait_mux_set_sel(struct krait_mux_clk *mux, int sel)
 		regval |= (sel & mux->mask) << (mux->shift + LPL_SHIFT);
 	}
 	krait_set_l2_indirect_reg(mux->offset, regval);
-	spin_unlock_irqrestore(&krait_clock_reg_lock, flags);
 
 	/* Wait for switch to complete. */
 	mb();
 	udelay(1);
+
+	/*
+	 * Unlock now to make sure the mux register is not
+	 * modified while switching to the new parent.
+	 */
+	spin_unlock_irqrestore(&krait_clock_reg_lock, flags);
 }
 
 static int krait_mux_set_parent(struct clk_hw *hw, u8 index)
-- 
2.34.1

