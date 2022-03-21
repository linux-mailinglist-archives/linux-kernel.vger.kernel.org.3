Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21AE44E34CD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 00:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbiCUXrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbiCUXqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 19:46:50 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED829155C;
        Mon, 21 Mar 2022 16:45:21 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v22so8847821wra.2;
        Mon, 21 Mar 2022 16:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uKLqUE0HqMblkYxTDEoLkraH8fYkNKsZ80vlgdu8msQ=;
        b=PSd5RElnYKdfT7JJ4xRmSZsf3s4ZZ2M6RghbeBlNBFjRzifBRgCWiDV7DrMIm4b7eX
         +s+QJOlASeV7W5CEHDrrK18BOw/rSPYOQpWO2ewmXSnwQzVb0XlkJttSS62WbzINMXjH
         fM2MYijB/38Dk4gB5R1MXNPmTK1c0Bg1V4ge4p1dZQtgEqQPV1BI4CicnnJfC3yJkPtZ
         IXQL1Mz/4H+QwCEhMSAOb2RQ3OOokFFBNsGeiOOt7Uh1lOPR5hu/V5R4pdhJHi1szrd3
         hkIxMzx7ihaKt3cI6rHaVeorrGgc9w4z3sHmRS2vykSBNMoSvlq2kIut1PDcHDSjkZeX
         X90w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uKLqUE0HqMblkYxTDEoLkraH8fYkNKsZ80vlgdu8msQ=;
        b=gw1Xt8clpNeyB2ei15HtJDmI/8E8OvUjuUIVPnwc9FEL/GW0Q6smSqjzuTdtmH0bMY
         gJKc3YHOTKSVSGjPWXvTD45CfcE3lg1hvjGzSM/XpsUfwkPFqmzGgXBB7+uGafbFLm4S
         +TnhF75TRmBhVSU/u73wVeujez7CV9J4SqgpRp90gdAlV7kVJA6JJIF7hF8JXFIQ3x30
         bkGKqjPsRr65NO14/NdrtcHEYs+9xuOoNURQsS1B6f69mPc2J2ja7uEfUvPJm9jSh8V9
         jiPMw1gUHGrMhUX6ysYI41n3+c/M+h22LS7+8LJeRCAhE8NjuWxnWb6CaoCxmSyJ1zjl
         JcSQ==
X-Gm-Message-State: AOAM531nGAMN+0N/D0oaBLQhuK0b71cDMoApsT9uIQNUB7Ry6PUTgF6b
        W0uA0pJpCgFi0BTXa1DJq7L6QrUQPz4=
X-Google-Smtp-Source: ABdhPJygX3L7achtlpOONDVhOVZGbv6VOE93/ieKdwpP8aYhxet/ApXPkN9SKzQ40eRhSJNKomj63Q==
X-Received: by 2002:adf:9581:0:b0:1ed:c341:4ed1 with SMTP id p1-20020adf9581000000b001edc3414ed1mr19797135wrp.299.1647906319637;
        Mon, 21 Mar 2022 16:45:19 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id n10-20020a5d588a000000b002052e4aaf89sm105497wrf.80.2022.03.21.16.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 16:45:19 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v6 07/18] clk: qcom: clk-krait: add hw_parent check for div2_round_rate
Date:   Tue, 22 Mar 2022 00:15:37 +0100
Message-Id: <20220321231548.14276-8-ansuelsmth@gmail.com>
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

