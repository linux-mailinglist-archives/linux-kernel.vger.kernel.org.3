Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DACCD4DDE02
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 17:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238542AbiCRQKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 12:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238533AbiCRQJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:09:57 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40FC4FC46;
        Fri, 18 Mar 2022 09:08:37 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id x34so9642446ede.8;
        Fri, 18 Mar 2022 09:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uKLqUE0HqMblkYxTDEoLkraH8fYkNKsZ80vlgdu8msQ=;
        b=RufIWNE/YK0iS48SJ2ZYrw2MT1i03P+usPEkru8m+4u/RVv1Diwub+Wo+ikhTcWr5D
         Cl6yBI/JYT8m2JncckCo20qU+HN41iLIjytTKiPmvIxIoPpnHuhsPXpMxOuLptn8L2G0
         YsSFEjq9x1zN1uv+TlOHU2JL7hCs7Ee0vdOV7BBgFNPn3VbgH3jHIq7YRkSGHxdF/c3l
         LljjlKjrqU7ukX5hyD33oYGWlCNQy4EY2dQixqq4Zlk2OPQqy5AZmepJ/NDb9Oe5m0SH
         IWhY95pqKiOkg2VDjUNiM0LibhRpLmSriFGxBTvad7WFPsUpBU+TaZtU1sLATXP6umfo
         EUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uKLqUE0HqMblkYxTDEoLkraH8fYkNKsZ80vlgdu8msQ=;
        b=rK4UuqLtcT9OAhPIZ8Tqy7gH+AJIsQdx4Nz0+a0p6Wzyp1npymymoRLjhwWRFG2bZ+
         qdyP+8yDl6YCzaRHvbN1hu76jGrJWJpfHXN/Tm9dUix3yjQKoiWivIW/YfroxH8d8h6D
         pE/rD/uhardANgrG7OIGqx9hQFRiK5qkXy7pcfeFaij6fbt9JrU3/ZRs5iQQLHk6oU1e
         MjFZGBJxu9YMW6Jjg+vQhCANHx5eEzq6X43247y8AKsxwmA7sbRXpk19AL9I8tV7+zDw
         SBKjZukR6S/fE31tsqoH8lA6jcCPVfGpNZlX1S63kZm9xdZurPbQyvV1Z3di2xcnCEqE
         zo2w==
X-Gm-Message-State: AOAM533NqRqenpCK1z+CxdzvMSrzeXT15bU6+oSo5LHm8usWL+Cy922Q
        69qeHt6gEubFDpbK1RouwlE=
X-Google-Smtp-Source: ABdhPJxsL05n0fvaqhEOnEtKNa3kuV1zQUKIgI36M9DAjeWdtThBRpLXiaKwp19iUHf4uWjrz2MrjQ==
X-Received: by 2002:a05:6402:350b:b0:419:1c11:23ed with SMTP id b11-20020a056402350b00b004191c1123edmr358545edd.8.1647619716333;
        Fri, 18 Mar 2022 09:08:36 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id e9-20020a170906c00900b006d4a45869basm3754118ejz.199.2022.03.18.09.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 09:08:36 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v2 07/16] clk: qcom: clk-krait: add hw_parent check for div2_round_rate
Date:   Fri, 18 Mar 2022 17:08:18 +0100
Message-Id: <20220318160827.8860-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220318160827.8860-1-ansuelsmth@gmail.com>
References: <20220318160827.8860-1-ansuelsmth@gmail.com>
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

