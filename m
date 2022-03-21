Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9984E349E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 00:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbiCUXre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbiCUXqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 19:46:54 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C292B53F1;
        Mon, 21 Mar 2022 16:45:27 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id o30-20020a05600c511e00b0038c9cfb79cbso501308wms.1;
        Mon, 21 Mar 2022 16:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QkfgyebL6ZDeFyix3jLmVd6pOSFa+uhSyC95dgb9bxk=;
        b=bge0TBx2KjLdT9bxG+d3B5PQrNAM+swGbZbw7/73YAo/TJh+4n+fSfEjHb8k44lo6m
         mZK8pJlbbwcz0YhVHXI+i7ER3FbBbwAXEJ95bYaT4+32AKUVJX/IDxD0EDtls5HUxkPL
         K2a0/wmLDaDY1j/c8EJ20IeMpL6CWq21X6c4N79csGgJ9NgJ9BCLQVA8RXNQHeDZUB9e
         +Fdo11CYYc2CwKRUqSluf2rynkK428wRIe158HA+WQSXO4ltMQiApDGsrTXQCHCuM7wx
         ZwSahXQp+zGBAzYacz3Bj5pgiDb2g58igMlKEO3FDmOidvY0ZsuoGaAgHimA0bKaf+e4
         79vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QkfgyebL6ZDeFyix3jLmVd6pOSFa+uhSyC95dgb9bxk=;
        b=wuVhWPHQqep3k7cimQ5CCF6g7RxN9/GpbaxhqThr58gZEaqjS+5ds1R0Dpr+RNM0vX
         lAKWd8FH24FRXejS5DGUortJ6JbRo9lhHh8c75tMMIpFw1kEcKUWT/ssaAfgNj5UZHLr
         9buntucdkRoZIogsdP5uGOGop8ziu+PNQf7Ci/3/vH1+ZNdvw09b25lZ4kl5OQ0bgVDz
         e9fspUf/PSYOTOAexEE5Q3x5VzqfxJKVwIx61BmjY95/Oa7cnhpy/7dtFQSEiR4yOn8c
         hYYzN/vEJxuovK0ZzWZeKTXgrKz86+NkPV+c53IPFB+05ZNEh6NxaT2Jc1glNyZcT/9e
         tQMw==
X-Gm-Message-State: AOAM530P9Rlz+6DCCglXgIGjriIeDgPmcSCyV6XC68y+ie8L7qN+Zcbb
        6Nn6PfaxSn/f19Wb4jAuOTc=
X-Google-Smtp-Source: ABdhPJwkW2p7PHJBwZCI9ei0rE/h0snTHL1QPZPHV8gfqAHhnM2mPHcGMoJOR9bqyon0jUX13coDUg==
X-Received: by 2002:a05:600c:a0b:b0:389:dd65:66f1 with SMTP id z11-20020a05600c0a0b00b00389dd6566f1mr1190829wmp.95.1647906325852;
        Mon, 21 Mar 2022 16:45:25 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id n10-20020a5d588a000000b002052e4aaf89sm105497wrf.80.2022.03.21.16.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 16:45:25 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v6 13/18] clk: qcom: clk-krait: add enable disable ops
Date:   Tue, 22 Mar 2022 00:15:43 +0100
Message-Id: <20220321231548.14276-14-ansuelsmth@gmail.com>
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

