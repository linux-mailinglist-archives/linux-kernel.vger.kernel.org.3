Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB6B4E2D5E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348906AbiCUQKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350690AbiCUQJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:09:50 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6E2286F7;
        Mon, 21 Mar 2022 09:08:23 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t11so21391391wrm.5;
        Mon, 21 Mar 2022 09:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fDLuIDyRCuRCH3Dc/gWWNAl91bj4g20Fwm4jwXMbE5A=;
        b=VTFoGgHy46VG05v3mlZ7Rbg1Ij/iZQAYDOclaiGTVO2GXpFbGJ0w5UMnLQ54FQfBny
         7HLTl8eUQ1oObSKvzrkutp15cFbKTLWcUm6L8V3lPHpfp3UpHIlpXQfBePq4bJZt8TLb
         l2z9UMU4J3DG0X8xiM4gtbVvrIybZOS/jI25v3YW1EmjO0f9+fFiqFD0omrf8ZXVpj4W
         Blo7usEyvfuFXtp+nAsAyM5jPL0AR4ylK7J/olkQJSyV4DFcnZBXj45JVeANKFKfvMyy
         96HtDzA7RnTiDC24+INRc7Uy+UEVMy57GPnxWpUMC4ZEwyy3XcHNITGZCqlVk/pPJb/1
         B5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fDLuIDyRCuRCH3Dc/gWWNAl91bj4g20Fwm4jwXMbE5A=;
        b=wrL3rw871CQGu9HlIYDb+9CucuY+XGGOJ6pDr0XNNejJJV4orTHuQljXVyph3jWuyl
         9YaRl2M6Z0nwT4s13NH8MPln4Q11gOwflWAjw4OqgQUlaCDGcCZfZSubnUeTkV7iBEM7
         ZCkIWbxxy/i/xsQrm3FAs/tg7IlEbFE4gdA3EC7rlSQlalKMgtlaDJKDnPU/9orCXlyY
         WzjQ01wk16oBJtCayXC4g5by6EpSEjq1vcz8px2QE1je5OFD0hEWP8C1Cwa0iva0ooV3
         ceyA8en2QZ2rjiEewfnvRb/FAYgJAzxm3Pjw/U8R5pGRgw31AOa4V4qxgg+K6YTcJBXn
         B0UQ==
X-Gm-Message-State: AOAM532gNALKQPS2Oi4CRAxiAeNoFv0X4bogWWHEKnWXL8jvxaXc0GIm
        qslGcnfTNK+br0VkvI9KOvs=
X-Google-Smtp-Source: ABdhPJxQl95223QIhrmEBBoQM5AbNKYcBBiv7qPwdMS5iIhOtA/y5V32KHAWTkxw8GRm9Agd55dtUw==
X-Received: by 2002:a5d:59a5:0:b0:203:d46b:f27a with SMTP id p5-20020a5d59a5000000b00203d46bf27amr19357992wrr.126.1647878901726;
        Mon, 21 Mar 2022 09:08:21 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id az19-20020a05600c601300b0038cadf3aa69sm2603864wmb.36.2022.03.21.09.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 09:08:21 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v5 06/18] clk: qcom: clk-krait: unlock spin after mux completion
Date:   Mon, 21 Mar 2022 16:38:43 +0100
Message-Id: <20220321153855.12082-7-ansuelsmth@gmail.com>
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

