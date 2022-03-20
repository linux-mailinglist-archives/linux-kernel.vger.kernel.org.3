Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43974E1CC1
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 17:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245574AbiCTQaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 12:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245480AbiCTQ3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 12:29:42 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376BA344FD;
        Sun, 20 Mar 2022 09:28:19 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id u16so16850530wru.4;
        Sun, 20 Mar 2022 09:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fDLuIDyRCuRCH3Dc/gWWNAl91bj4g20Fwm4jwXMbE5A=;
        b=SjSggtGy7HEDnlnd7IWkNUi0E5N14R9aw4lHDSeYP6vaLkfUXqnYDswHK3Gj+ek+A7
         mu3576fyQmbfhD7ks7apDJ/G77BxXAoHyMiS2/iI2Wmw+YeYH1H6k8vj/ML+cMwhn22r
         iU6Lhq4tS5YVynV+sh1CdWtiXWGSz/ynklBNOL7PliJ0EvnXuZokTjdEDfcBGjlI1XzH
         ha4APHmGXFrJodZ4lD/9z64I8AhDNXwN5mx29ZT9PS6Qp61DGljmsEhlUhjrs4jYlEYE
         FNPuclw6eADpcGO4d1klnVFLDE1c/rQ7m+7bcvKAdCWsn30oSIh8ic55iG6Po09ZOoN8
         N+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fDLuIDyRCuRCH3Dc/gWWNAl91bj4g20Fwm4jwXMbE5A=;
        b=DpyZILraqlleTzOBSmvWs8291yCFFQmjLB4nhCxg6PIsLfJXb/TZIRP3hoSpCSNE3P
         vQKNyrGNn1L7IPHeiRfLo0jd5zcXhhRqtx2+an7jDaR42yC8SW59SWUWp5cgKShaC0Jm
         6PqsfSikKLwI+z6ALhtYF9Nj4qmZj3RzciTMmdFSlL4eKBYMAm9TfoZ+ZxP6om6Irf2Q
         5+0VwGWayb+0ax3U6AVJsCf4+rnvgc17sY6ImQsZQq/eE8RoK1EkdtLDel48kVE8DYnm
         KTxev1P81mE1sJtpSP3F7rEXzbe19p5nyzCpVIOD+YA4Asmc8IjTJZMiO3KkoS3exSzi
         SDjw==
X-Gm-Message-State: AOAM530E0Veo5GBBwbe5fWw4vELoe1TzpbAlpq1TbIoe2VqY9oLiJn/r
        KiouqmtRHiiFMFhXx+X08iM=
X-Google-Smtp-Source: ABdhPJy7vFcZe2XKWBUt0rtJ1+TXrD5KrcZwd0ZFlwZuzU9ATFYWmW1iscTu2Qyt9o7fEsXSJDwkrQ==
X-Received: by 2002:adf:e2cb:0:b0:203:7564:1076 with SMTP id d11-20020adfe2cb000000b0020375641076mr15418628wrj.199.1647793697658;
        Sun, 20 Mar 2022 09:28:17 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id y6-20020a05600015c600b00203fa70b4ebsm6760085wry.53.2022.03.20.09.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 09:28:17 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v3 06/18] clk: qcom: clk-krait: unlock spin after mux completion
Date:   Sun, 20 Mar 2022 12:34:18 +0100
Message-Id: <20220320113430.26076-7-ansuelsmth@gmail.com>
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

Unlock spinlock after the mux switch is completed to prevent any corner
case of mux request while the switch still needs to be done.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/clk-krait.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clk-krait.c b/drivers/clk/qcom/clk-krait.c
index 59f1af415b58..e447fcc3806d 100644
--- a/drivers/clk/qcom/clk-krait.c
+++ b/drivers/clk/qcom/clk-krait.c
@@ -32,11 +32,12 @@ static void __krait_mux_set_sel(struct krait_mux_clk *mux, int sel)
 		regval |= (sel & mux->mask) << (mux->shift + LPL_SHIFT);
 	}
 	krait_set_l2_indirect_reg(mux->offset, regval);
-	spin_unlock_irqrestore(&krait_clock_reg_lock, flags);
 
 	/* Wait for switch to complete. */
 	mb();
 	udelay(1);
+
+	spin_unlock_irqrestore(&krait_clock_reg_lock, flags);
 }
 
 static int krait_mux_set_parent(struct clk_hw *hw, u8 index)
-- 
2.34.1

