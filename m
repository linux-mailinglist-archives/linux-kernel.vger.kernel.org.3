Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF314E34D5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 00:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbiCUXrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbiCUXqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 19:46:46 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AE991AF3;
        Mon, 21 Mar 2022 16:45:20 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id h4so4793993wrc.13;
        Mon, 21 Mar 2022 16:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fDLuIDyRCuRCH3Dc/gWWNAl91bj4g20Fwm4jwXMbE5A=;
        b=AeVv7fxFBnMYc6TyGPQJgqr6Os1ISVirKCBnb0cEjT23JRQiN3kzSkbJC0WGd3S7U3
         vuFTIdYM6A1YIEX5acudsY8cHSuJRoMOa9mi+QoIsisQ6LwKy03eGnozYKYM6/GHetaQ
         N1pdi/Lojc3qRPlYDHAPF82xNp76yMtyK+ujOYFzMR6Rhq7+gVN8rtlHEcDZtsuw5TNk
         mteDjvKEamD61BrgfDvh7G1hSK3Ah7yaYskBUKoewGEuf2CEane2pVgy+1/orAIx7vcm
         HWJiToqyVRIWr6Tjm8c0Lr0tMk1YIz2D1ysWr6JYXdnJPWS/h4EjCIK8QpBtkm40tK0s
         rcMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fDLuIDyRCuRCH3Dc/gWWNAl91bj4g20Fwm4jwXMbE5A=;
        b=7BOmn4wgmsrVr2HVChFUjDloGy1xrHjyp5UuA4zpUxv+USlKNpoRba6V2kP6Jeq1BY
         ne8fzVT8fMqJIKBEdS6RCrczqXzAVcfdR8kNIIPREK6oMKNkrHQ6VbLsAGCkvfxkUvVE
         HjDp1wj3ZVet927E3ayaRGxFICTNT9br+6QsRa/2276xEvU1Rlar7IeuI/bQVRZQSxP1
         MhEZ0JgjyW1zLf41rJcfe//GdX9onLXXXvlP1CJ3d6B+J59Hb/Vr60XME3iFlin3gwjS
         3EkAjLLCDTLMIhKWbN3jmiAFGMbCHpgIHtRC+kosQIcNUj2P5hRr+nZQXpbEKQP9b6m7
         gtog==
X-Gm-Message-State: AOAM533rQzXQSxBf9Ew+6vTldQ/pWyqNOEc4qDBcLDPAYVRQSUAu/ZPv
        C2bc84o22naC1NICELRvUpU=
X-Google-Smtp-Source: ABdhPJxNPd77bvjDTqhT6guQSbqvAquPuH8wDOmtU4K7LLM2fm96J7tPK8SxTOhH8GsSmBY3HCimNw==
X-Received: by 2002:a5d:6c66:0:b0:204:93b:5dee with SMTP id r6-20020a5d6c66000000b00204093b5deemr7880786wrz.332.1647906318565;
        Mon, 21 Mar 2022 16:45:18 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id n10-20020a5d588a000000b002052e4aaf89sm105497wrf.80.2022.03.21.16.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 16:45:18 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v6 06/18] clk: qcom: clk-krait: unlock spin after mux completion
Date:   Tue, 22 Mar 2022 00:15:36 +0100
Message-Id: <20220321231548.14276-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220321231548.14276-1-ansuelsmth@gmail.com>
References: <20220321231548.14276-1-ansuelsmth@gmail.com>
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

