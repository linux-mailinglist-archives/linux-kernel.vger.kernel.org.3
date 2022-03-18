Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F6A4DDDFB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 17:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbiCRQKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 12:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238501AbiCRQJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:09:56 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFC78CCEF;
        Fri, 18 Mar 2022 09:08:36 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z92so9854222ede.13;
        Fri, 18 Mar 2022 09:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fDLuIDyRCuRCH3Dc/gWWNAl91bj4g20Fwm4jwXMbE5A=;
        b=MduW0K6yHWbOsRruvibz3UTGJImXF0ExFolwO2lNWVKyIBt7jgF+l2QJsT41ebVEPI
         IVoAf1g1PCOJqiW4eRtatPzMW4SwAa38vWHIl9z5MkVQiCtbNIO/VETa6se47BBmic7y
         ZLcmZvHg4zM/C2ZL9lM3+sRrTbmLHklIxD3jUXU0qt3vbftwyB/1W+O3FwQZHiEL5ua6
         dFLWsLEeKV5omikVBUoR4rP6PD2JsJ8La3eAGxCzawQ4yv9I8cnA4RwFEVaWpoRKobOg
         /L2h+S+jG/F5b4LQ+dNbjo9I0VUAFFVWD+w1n45znA5RZ0Z4CihD+4F4g2bTDFztRTMQ
         KTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fDLuIDyRCuRCH3Dc/gWWNAl91bj4g20Fwm4jwXMbE5A=;
        b=AqdWTyERPcR8AE7RvMupXOatIyLKLguSsPXZaG2Tyg2dJw7iz5NXvSu6qm2ewGyBnV
         W+/DwTmqMkG5Guw4sgZg0ofrYT5htUU0v0mNrlg7HLmCrvNSUh8M0wz+/jVLpMFCLwhK
         Nb6UD+X6sk83/qOU8okoH9qlvwmUuip+PjaG/lgrnZ+GOFoUuyXTGDf1qcz/50Bi4lPW
         ngUw1pF/PCB8TL0nYEyFNODHZJ5IkO0f/djgS1/UfEMGv+6wSQ4LnCfOkO0m54zX54JS
         zH+K8+eo0CrbFoJjgmqHf4X3A7DTXf9CprRsO9M4KpMI6GQ8doIpidV+d4OhKcPqg1XZ
         cOFg==
X-Gm-Message-State: AOAM533yHT/erAjHzGiIBmYP3z8tG1rtLUHNw8D58TuOTs+xxAEhmZlL
        BpGFkJpUktIK8xZvmq8II6g=
X-Google-Smtp-Source: ABdhPJwIDAuBvS9AYUlCGpqVsISVE7aKrNYqxs51mhuj+MA5Dhb/Xs39RkotESnqjHahIUYIT1Aerw==
X-Received: by 2002:a05:6402:1906:b0:418:ff14:62b8 with SMTP id e6-20020a056402190600b00418ff1462b8mr7591325edz.40.1647619715322;
        Fri, 18 Mar 2022 09:08:35 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id e9-20020a170906c00900b006d4a45869basm3754118ejz.199.2022.03.18.09.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 09:08:34 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v2 06/16] clk: qcom: clk-krait: unlock spin after mux completion
Date:   Fri, 18 Mar 2022 17:08:17 +0100
Message-Id: <20220318160827.8860-7-ansuelsmth@gmail.com>
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

