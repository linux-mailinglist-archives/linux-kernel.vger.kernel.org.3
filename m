Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9FE4E1CC8
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 17:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbiCTQaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 12:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245485AbiCTQ3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 12:29:43 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEC534641;
        Sun, 20 Mar 2022 09:28:20 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id d7so17849601wrb.7;
        Sun, 20 Mar 2022 09:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uKLqUE0HqMblkYxTDEoLkraH8fYkNKsZ80vlgdu8msQ=;
        b=iYJ6YcWR1OzNhEc8eDm1BETiXmNRH+94pt0UUNT/Ry8CxhnaVu8rLhxSVaanLbWAhm
         c/COTr9lXxlL1pPmfOYijokmyi1/fa3A+3kaqN7G6yT2jzZhZrjjxkjMZeT0y0VWcP9F
         /i4LzKY1TszdFnnaCFBvUmxk07Zm0j/R3Emfv0KBIO2wF/8JsARYoYj26Ffm2WLbpCT1
         GZG48KRjifDaA+Ry5Zui+fOhJKAsIe0QSxwOWCmoB6Woaycbf5H7zbjnkRSI74VBFhcR
         cXryRr6JgCM6TKrDb5dyq8UPi4TKkIZdnF+j7S1rN1aT+7lP0IaJqg6IhMLXqS4xRxSH
         fzqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uKLqUE0HqMblkYxTDEoLkraH8fYkNKsZ80vlgdu8msQ=;
        b=A5LUVz7t1Vm7leGhvflfryKETIf0E6kMn+EZD+vD3vSteOZWItYI2oRKpAjjou6D7V
         Tnnxw7u2/9rGnpGWnWFz1ghDJiEuz8iroD4kXLQ9gvK8AbP8+CXS06WdTDWA0FpmP8zN
         FPxeYrH0/6PSbPQAr3zzm41oefoWgvjwJoSbsLsOn93+cuiOvKEfe/4ghASVWipyc43N
         cl558zJI+kQQeeruAJOf7Jie+1Hr+uUUFqSwywgAyOvnahj2gL0pp4sBD1vfwucA408f
         2R0E9U4Tod/9vGMYC4+QDfWjcnDENz5svLLHAo5HX3RIOWNq2M/jw0hJQjZ7jDEjXwgA
         kqxA==
X-Gm-Message-State: AOAM533sCwGuYJWPXnzxfQlyrPLNzNERHAa+lDFuUCtMzThXXDkYA0wx
        O1xHfm791oE8iJtJOVxHNKk=
X-Google-Smtp-Source: ABdhPJwEo0Ml4P5+engaF0NwKuix26puiUgZIE36D/s43jZyXKBC7gWtwdwHd0bHXX1D9M8rbE86gw==
X-Received: by 2002:a5d:624c:0:b0:1f7:4b77:becb with SMTP id m12-20020a5d624c000000b001f74b77becbmr15134428wrv.594.1647793698760;
        Sun, 20 Mar 2022 09:28:18 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id y6-20020a05600015c600b00203fa70b4ebsm6760085wry.53.2022.03.20.09.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 09:28:18 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v3 07/18] clk: qcom: clk-krait: add hw_parent check for div2_round_rate
Date:   Sun, 20 Mar 2022 12:34:19 +0100
Message-Id: <20220320113430.26076-8-ansuelsmth@gmail.com>
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

Check if hw_parent is present before calculating the round_rate to
prevent kernel panic. On error -EINVAL is reported.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/clk-krait.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clk-krait.c b/drivers/clk/qcom/clk-krait.c
index e447fcc3806d..b6b7650dbf15 100644
--- a/drivers/clk/qcom/clk-krait.c
+++ b/drivers/clk/qcom/clk-krait.c
@@ -80,7 +80,12 @@ EXPORT_SYMBOL_GPL(krait_mux_clk_ops);
 static long krait_div2_round_rate(struct clk_hw *hw, unsigned long rate,
 				  unsigned long *parent_rate)
 {
-	*parent_rate = clk_hw_round_rate(clk_hw_get_parent(hw), rate * 2);
+	struct clk_hw *hw_parent = clk_hw_get_parent(hw);
+
+	if (!hw_parent)
+		return -EINVAL;
+
+	*parent_rate = clk_hw_round_rate(hw_parent, rate * 2);
 	return DIV_ROUND_UP(*parent_rate, 2);
 }
 
-- 
2.34.1

