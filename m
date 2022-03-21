Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147154E2D68
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350783AbiCUQK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350737AbiCUQJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:09:57 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2C728E1B;
        Mon, 21 Mar 2022 09:08:30 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j18so11741005wrd.6;
        Mon, 21 Mar 2022 09:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QkfgyebL6ZDeFyix3jLmVd6pOSFa+uhSyC95dgb9bxk=;
        b=Xy7btiTOmGxwpKCPRMyNOEmU43iq6KqMdSjxxbMx2tfdQZUfVCDyvrSnyfWJcIxdbl
         EH6tRWlZL6QTCAUhCO9A7BNlKp2oipTIziduV/XaeCdqdma4bK/hzcbg4Cu85GpNaxD5
         wFDN6K8HFq+yVp8jVJcKIqXviwoTyLkSKtWC/36sGpVivyUWeVFgUzddqkau1EsHOFE0
         KT0vvzo3BxWSTtbKSR2ma4qMmFZC5NIwpBTHWjNmCFlVjDBvYlmCasmb74m83cwaR0XZ
         5zxtKkq99AI1/sFWRhug35FEB0DsvhnUVnw4XW0qZKsF7kxh+GMBFS3/AEGKAxeKoDKX
         eKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QkfgyebL6ZDeFyix3jLmVd6pOSFa+uhSyC95dgb9bxk=;
        b=sRcjdoB/tWINpZv90qgmgudJVh3Da+vOL8bBOofKYYVPgCS6JZDZDlC0p5TVJ3hivG
         VZbnvk8Hx30Ft0HLbhVAOtCjPxc42ShQD7NtTsTRNDyeJr8UlanCQ654XQJYFcB2q90y
         2jTWYdGrmmwTYxZrK6Ct4Pp2S0Zdpb1bp+yPiVOpTxcfEd6zbRBiPeZ127YSKBZAzqxc
         JtnC7Rfo4Y8dTmEivAivW0bVnQIT5JzpjZs0kAxBGv1n+cwfD8ooKQb4cZ5CUbLZkm6k
         56rCqXpBGZsJpO83+EKoQvP6HOzex0yc87PMkPQRNqbid3988WyVnXVUZm5ZD+wILDX0
         0M0Q==
X-Gm-Message-State: AOAM531zaTh6uz/mDrhF6nrU8n532Tx4BjYw234ecbOnjxJ8UughXeye
        UDTU4ADwJU/zh9xzBZPBdC4=
X-Google-Smtp-Source: ABdhPJwnoYA15mOBjwq6yKBPgoqniTSCmwQ9Mkz8feT//Dxhgvf2CEQBKFYz0HNRAupHjSaRyzLxTQ==
X-Received: by 2002:a5d:4609:0:b0:203:e792:3add with SMTP id t9-20020a5d4609000000b00203e7923addmr18527741wrq.657.1647878909233;
        Mon, 21 Mar 2022 09:08:29 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id az19-20020a05600c601300b0038cadf3aa69sm2603864wmb.36.2022.03.21.09.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 09:08:28 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v5 13/18] clk: qcom: clk-krait: add enable disable ops
Date:   Mon, 21 Mar 2022 16:38:50 +0100
Message-Id: <20220321153855.12082-14-ansuelsmth@gmail.com>
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

