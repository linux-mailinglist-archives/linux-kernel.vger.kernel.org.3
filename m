Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3751C534E5F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 13:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347407AbiEZLo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 07:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347181AbiEZLoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 07:44:05 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DF8496B6
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:43:59 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id gz24so1532053pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6s0x8dJmuy2Ybw2lPLVZk+KMGhxE6UiFXXt2n7Y53xs=;
        b=U7t6fFDjDa0Ctor2pMs5mB+RkfuEaQPk9jAll6z0ozbTwHH7hCCOV39QhC1AudH7B7
         mQNpvXHdoHtmlP/l8G9ftM8cnpNgbGwwGz9I+OmYGanwKqbuDAFiLpXAxWh8NKaVHaAA
         aBOK8br6uQdtX1bFAvIQ7JvqoxwHiCHDyyeEoXHWCbLWoVvk7zriP5dvMGGKYIuZyP3N
         Ec0tGGa/3p+cdA3hyyIF0IaJc8Wg1rXpfwN5vn1/9ccbu8Tx6TT0v0YsqfAustZYcUM+
         AEv36mJY1RccxXovNcGZX5iR8HI63Dc4GaojNxWzAlkrNrcHbTysqe9W1RvbTeEt6NOm
         3OfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6s0x8dJmuy2Ybw2lPLVZk+KMGhxE6UiFXXt2n7Y53xs=;
        b=ik4TJdSIKBwJl5HBixwgKkr2Kj+qMEa3LARkbmpEa9u03ZFpLXLQAn3sUA5yVPPN5V
         zAQmxGxFa+44ynKvE00UodwwgXQ4ay82JRmjPqfcCyMI9027kEdiaR1qOexo7pWImIYE
         OfibDTDnaTcAC8xhPekC6k2Equ2vbxkusLys8oA98wMYM279xpyW71nqY06w7472yGqx
         8qKCdtJ4F8OXR4eGPi7rCfGvGaYX02V3I8myJo77d3SMX+3vXn8u1gldcA3cbAVb4mMA
         meXBshAaom9m7NveX+D37i+XuJyO8HcDlrXLa8MFRjomgyT5zkydTU+65f1YgLKrJvLi
         mxCQ==
X-Gm-Message-State: AOAM5316P7G0jcDJWEXN4deZLaRTlTlQx1HnMz5+BzthAIblFIWTDtIF
        M9ZmWP+pcSRz1fb9Z1tpD5QEBpjE8QvqeQ==
X-Google-Smtp-Source: ABdhPJxbhS8femEgYxRhuPmf1pbTSv1ParpKVoHJCFN/pCA01ph85V+OU8iJG6Dir5uT/slHjL/sTg==
X-Received: by 2002:a17:90a:4cc2:b0:1dd:1010:d10d with SMTP id k60-20020a17090a4cc200b001dd1010d10dmr2174506pjh.205.1653565439389;
        Thu, 26 May 2022 04:43:59 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id v5-20020a62a505000000b005183434ec86sm1261317pfm.135.2022.05.26.04.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 04:43:59 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/31] devfreq: sun8i: Migrate to dev_pm_opp_set_config()
Date:   Thu, 26 May 2022 17:12:10 +0530
Message-Id: <276f3e9b7d9b696cbfa1e5546f79db7029510fb4.1653564321.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1653564321.git.viresh.kumar@linaro.org>
References: <cover.1653564321.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OPP core now provides a unified API for setting all configuration
types, i.e. dev_pm_opp_set_config().

Lets start using it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/devfreq/sun8i-a33-mbus.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/sun8i-a33-mbus.c b/drivers/devfreq/sun8i-a33-mbus.c
index 13d32213139f..125b479c9d6d 100644
--- a/drivers/devfreq/sun8i-a33-mbus.c
+++ b/drivers/devfreq/sun8i-a33-mbus.c
@@ -337,6 +337,9 @@ static int sun8i_a33_mbus_probe(struct platform_device *pdev)
 	unsigned int max_state;
 	const char *err;
 	int i, ret;
+	struct dev_pm_opp_config config = {
+		.clk_name = "dram",
+	};
 
 	variant = device_get_match_data(dev);
 	if (!variant)
@@ -404,9 +407,9 @@ static int sun8i_a33_mbus_probe(struct platform_device *pdev)
 	priv->profile.freq_table	= priv->freq_table;
 	priv->profile.max_state		= max_state;
 
-	ret = devm_pm_opp_set_clkname(dev, "dram");
+	ret = devm_pm_opp_set_config(dev, &config);
 	if (ret) {
-		err = "failed to add OPP table\n";
+		err = "failed to set OPP config\n";
 		goto err_unlock_mbus;
 	}
 
-- 
2.31.1.272.g89b43f80a514

