Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1C34E2BDB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350049AbiCUPTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349948AbiCUPTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:19:18 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504BFEDF0B;
        Mon, 21 Mar 2022 08:17:53 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u16so20158813wru.4;
        Mon, 21 Mar 2022 08:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fDLuIDyRCuRCH3Dc/gWWNAl91bj4g20Fwm4jwXMbE5A=;
        b=Za7W/slBsPjKinOPkZ2nZCjIHv+6kAIcjDdr+EVrNJfsgodzkSfMaEvSGVW7qEtmKw
         G7dq/MKUs8mm5URj3DwRdQdjL9nF4CoDGoSKE6PN9WbbTeo+4YBOGfaQTx0j66LIp1X4
         x/Vw7pGpSj3VN2uGVPFgbZHZlC+8KlNOyjJqRlHDW49ryoPbSkh8XoDznVeiOPkITpxe
         MU1DGQis317QaiMz2OfGHSUevrLJWj1tRSKfcbZUmKooAJlTtaoWeM9rRsfWYzoeiPi0
         V8UOs4IxIMQisL3FoQ49JoYxAWeAPcR1ZMW/PFDrWN9iQ1s3P977T6hN9L/xzujwX6iu
         QMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fDLuIDyRCuRCH3Dc/gWWNAl91bj4g20Fwm4jwXMbE5A=;
        b=DBsAmRAyH5OiYUJqXDtZpRRRxkv+0sUozBElQXvZbu3iimORXL9l8kwWjCfM8PUXpE
         bZb6QQiwN3D3K/XD+8eBUPJdVPJZbKaEDIHpAZNilwmM0zlOlaM3zfYJraZibMIIGTkC
         QwYDGKUTv8nNaXfWZx/VXAc584ONQpPTNZi59Wt36TV0htWl3u1q6LTjENLzqxJKF5pn
         MY6AjWLR8Hd4/w4T48WnblsIUiEK4tEmwz52PfnBaG3gkozGkbJ1M+EGQeoUnzx84bzQ
         wuwlq7023reHsVkaz3jW47bwNoPLtzvn0hHkGW7FGwhuEwrETTei5bMlsKLGVL7Lo7Mo
         87MQ==
X-Gm-Message-State: AOAM530RGTQygofvjSzQ0Y0lACuR693LTlOgYflg69HRyRByel2MoFMF
        sNxVby8UGz5eP0up2AgN7AbU1/0TNhM=
X-Google-Smtp-Source: ABdhPJyuqUrPKCTH9LaDiGhkitGK66ua3smDzdvkvO1yoJPyeVsDcg6vRDdohrCsGHDOsaZXXlNT9A==
X-Received: by 2002:a5d:404c:0:b0:203:ea4e:3c07 with SMTP id w12-20020a5d404c000000b00203ea4e3c07mr17149999wrp.597.1647875871738;
        Mon, 21 Mar 2022 08:17:51 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id 10-20020a5d47aa000000b00204012e4373sm7239729wrb.101.2022.03.21.08.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 08:17:51 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v4 06/18] clk: qcom: clk-krait: unlock spin after mux completion
Date:   Mon, 21 Mar 2022 15:48:13 +0100
Message-Id: <20220321144825.11736-7-ansuelsmth@gmail.com>
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

