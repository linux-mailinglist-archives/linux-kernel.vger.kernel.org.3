Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35D453F181
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 23:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234284AbiFFVS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 17:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiFFVSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 17:18:50 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EE5BA99D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 14:18:47 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id m82so21346608oif.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 14:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YCcSuhuQ1vWwVJ0SW2RVYIVh/aSNB0orFLVM+U8ftCM=;
        b=aX4csWQi3E97IZVp7kfPFWT4t/uQQ91msNCIDdET7namQno4hrb4pgmbFaFuMwHnuv
         cXGC0QOHEtB0M57d4JOcViNU0H7E26JpSpsGUfaWgPOOG4ZdEzVhVrkzb7keqvhywz07
         sNcXZ7jGIGSgw0YBGR5yF33qWulsfzMkje4N/Dzc3GthV6QgHzW6dTLj1UvCKURBEuN1
         Ftl8yWjme7AaNT+w8CvIIna4/la7QBc1oZbqdgXn8RsUzfBTOtUSvlvBEAyQXL5kWxFL
         e6VCROspeDsXUiIYU56QKDUcYYE6x9kLNhFe/qybielxQS/UxXZIA+twBUSCirrNoiYh
         mMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YCcSuhuQ1vWwVJ0SW2RVYIVh/aSNB0orFLVM+U8ftCM=;
        b=uBErJwgHDe8zAokFGzbuBurvrMEgWHp/mhCENt6cCDKts+XILWijX1kRyZBsEddkoR
         pGM44n4qHCU3d/Vp+vdt9nrl1WQWeC+L4RJhjbXZ9vXOu0b7ayArAMT6a24Q8un70Gky
         gEexqIvyOtFHjrdKQbYqIn8QwQ4TVgUdxLiX3uTTAYjhsJ4vXf0OrbWNDME89Kz9XaFO
         XzGr7U/bCtBpPdezrCEFhlG6+2+UsxhvHdw6Gk3Z7VHvETlISm0lQ3eDCT+ZYgM+T4C8
         UGUSgCPfjJpOIcE6vsltkwoLBWkfN76WMZ4GDEj0M1dEw54zgHplf67hC1w1jaZ9jJJf
         ZiYQ==
X-Gm-Message-State: AOAM530XDzbbwVDvF8PfBkKNdIlgNb0mIwjqHkqymAVnUIrVdt/qu6OA
        DQ7XoCbKMa7tB2U6j3fDUkCrOA==
X-Google-Smtp-Source: ABdhPJzO7TM8BK3G8gYvkXfPhVHXVafWnK1DvN0BUm2+eoHuppcoSnE9n+Wv7V4l1pdwHAEcaSAg9w==
X-Received: by 2002:aca:304f:0:b0:32e:8381:fa69 with SMTP id w76-20020aca304f000000b0032e8381fa69mr5698715oiw.289.1654550326658;
        Mon, 06 Jun 2022 14:18:46 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id e28-20020a544f1c000000b0032c18f04800sm9126744oiy.1.2022.06.06.14.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 14:18:46 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: qcom: gdsc: Bump parent usage count when GDSC is found enabled
Date:   Mon,  6 Jun 2022 14:21:12 -0700
Message-Id: <20220606212112.3617731-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
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

When a GDSC is found to be enabled at boot the pm_runtime state will
be unbalanced as the GDSC is later turned off. Fix this by increasing
the usage counter on the power-domain, in line with how we handled the
regulator state.

Fixes: 1b771839de05 ("clk: qcom: gdsc: enable optional power domain support")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/clk/qcom/gdsc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index 44520efc6c72..a1fa7c4cff60 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -420,6 +420,9 @@ static int gdsc_init(struct gdsc *sc)
 				return ret;
 		}
 
+		/* ...and the power-domain */
+		gdsc_pm_runtime_get(sc);
+
 		/*
 		 * Votable GDSCs can be ON due to Vote from other masters.
 		 * If a Votable GDSC is ON, make sure we have a Vote.
-- 
2.35.1

