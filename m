Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F755163C1
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 12:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345613AbiEAKj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 06:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345328AbiEAKi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 06:38:57 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5071C0B
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 03:35:30 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id g23so13677733edy.13
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 03:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dFahH59BOMsWXM1m1iMuw1dze5pfTvPM54N+hMTC96w=;
        b=ZsYViszJSPQ0CaaVe7LHbtreWvu+hh6wFyzUgYcImbRO85R79VjddFcvg0DqPTOWkf
         tvlxfeFeWOkVhyQ5hU0tBNHCTosWfD3K3cFecanf6FULBEbmYpTyTwNDnsRrfogyOTGs
         mslpIInD4bNHjYhMp/qTuqbsFTklUIk7S00yovxXgH27DrxXKvPpxGktacTFk6o2BveL
         KJkqJceYOD8EdwZEmVOioAEie2OTWtpuPYu1ChP6jJuKrPS/lmmKwtmZq+/dDXY0O7xG
         Nx4iDLqpROG9YOlBRrBD9JNbq2g/WzGFmNKwpJO9qIbyf7pK3Zur9res4k2PKyHXCbBI
         rNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dFahH59BOMsWXM1m1iMuw1dze5pfTvPM54N+hMTC96w=;
        b=UroSEVziahkkAhUyyxk6ofFnx/18CYOlUeDGPemdOVDVx4vFHMEDLBXDviUB0A1dmw
         3gKJ7vIlksHFjjOeUnUS3gETosGf4UfDcVUk8063oujCIJdWXTxE31tdl5y9HkjwN408
         6+nPdr1AeXOEey5eFeMOA9jC2VVhXnboD+ZGw1eeDftxNG/oR37TMXGPgAlEt+1hwpGG
         kf9wYk9hwbju+DvqZHhiUzdKwKhUhaB0FNvpnanWRJqrzv3dzgUZyX0QMYP9ouKRwYTr
         PETQzTKD3t6Y63W8cAn8c5jDHP9GQgb12Ki3UF8plK3o1Cf/9c72Zgp5G8Wh9989Daj4
         v1yQ==
X-Gm-Message-State: AOAM531TxFss2del8tVHcyzVfno0HHqBHB35y6PIz0H+Gz5IzNy0dq8j
        PIBOhv3iLF0WRJ5z96LgqhBOjA==
X-Google-Smtp-Source: ABdhPJwLmaRoTqZst6tN49r43f4yAahFJ0alIb3Z4IVETYNUR5niWASmJ/VJyCHQ859CysoQbtz/JQ==
X-Received: by 2002:aa7:da4a:0:b0:425:d676:9684 with SMTP id w10-20020aa7da4a000000b00425d6769684mr8236501eds.248.1651401329043;
        Sun, 01 May 2022 03:35:29 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id zp1-20020a17090684e100b006f3ef214df1sm2464438ejb.87.2022.05.01.03.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 03:35:28 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/8] clk: qcom: alpha-pll: correct kerneldoc
Date:   Sun,  1 May 2022 12:35:13 +0200
Message-Id: <20220501103520.111561-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct kerneldoc warning:

  drivers/clk/qcom/clk-alpha-pll.c:1450:
    warning: expecting prototype for clk_lucid_pll_configure(). Prototype was for clk_trion_pll_configure() instead

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/clk/qcom/clk-alpha-pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 4406cf609aae..969d98fca5df 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -1439,7 +1439,7 @@ const struct clk_ops clk_alpha_pll_postdiv_fabia_ops = {
 EXPORT_SYMBOL_GPL(clk_alpha_pll_postdiv_fabia_ops);
 
 /**
- * clk_lucid_pll_configure - configure the lucid pll
+ * clk_trion_pll_configure - configure the lucid pll
  *
  * @pll: clk alpha pll
  * @regmap: register map
-- 
2.32.0

