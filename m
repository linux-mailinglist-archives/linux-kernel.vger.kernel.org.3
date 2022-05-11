Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8572B523674
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235580AbiEKO6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245304AbiEKO6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:58:03 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09A320CDB6
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:57:44 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id p10so3998974lfa.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wv5aQMBAxBfpngf2CFgjlzhePq/PDlQSq4BZ2y0GyjQ=;
        b=vwy2lOw+NliBdDqJ2qvuijVd49v40ghLG0Mvlzr8AaDDNcn+acXzxrly2p2jGKidRb
         oJcm24/fTEANOqm7ymPn+cKYJooUA+WDJPEZf7n8GnADoEzNClh+pTsXt9PHXDfIVYZ+
         QiW+6KZBz4SDv2SHgW3aL8+wxCbcnNbqHJHiTZ18skfIbro7M5ac7TIFTxazdsTaxe4b
         4hMr3VeW77m6LDyNoJyk+fhrRtx7cdRnGefI03hFpaiHCW+oJVIpMQwwaS/hbokGnmYN
         asu77j2ZURl1LVJltcjfCOgTwEBmuz12h6haXFBCI32qIV2xg0mNN7llwWH6mgo8Hm8X
         9xIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wv5aQMBAxBfpngf2CFgjlzhePq/PDlQSq4BZ2y0GyjQ=;
        b=MdsQe7xhNat8BIeIeimz+OuikX7UPvg7OK50rAz9u5FvWIcGonNavX+duByHKsQKam
         5NwUS4M8/pVLgbEjWPWylGWDbEIbg/XPeiY1Iyd0ubPGe/LNP1U+sz9z6csiVX1MfMRS
         KgntwcEFOAN3rXv3NSxbmq418uIPxpGG3E8x5sI8thwLFGWdXsUztXICPIG7KsBwOJsW
         R+KlDXGHYemkSVTbnb7vapNsfEAm7NDwLl+CQrnrjkAGDJjyvpUlKRFetLxlxtj7uOxC
         B2qxJhQN/iaAEevOEnB61qE+AYFpL1SV2UjN4LNXmQfHiSGYC5UAazUr5xHkPC+876Lu
         TncA==
X-Gm-Message-State: AOAM5337MvPhlduymxQ4nb5h9L5/paC1U1lDCAyUzGZ/lP1A54qztX4m
        NOyL5vQG0/lobsTrhvg9Q+PqKg==
X-Google-Smtp-Source: ABdhPJy/oJFXB8+xSdJ7QKJVgYpBHlpWxmBXHjr1zKTaRNPN1cMQ1B78Euzg49d3k6IqUBXHffHbGw==
X-Received: by 2002:a05:6512:1086:b0:473:e8ad:c923 with SMTP id j6-20020a056512108600b00473e8adc923mr20855798lfg.463.1652281063022;
        Wed, 11 May 2022 07:57:43 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-154.NA.cust.bahnhof.se. [98.128.181.154])
        by smtp.gmail.com with ESMTPSA id z26-20020a19f71a000000b0047255d210f3sm320793lfe.34.2022.05.11.07.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 07:57:42 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/14] PM: domains: Trust domain-idle-states from DT to be correct by genpd
Date:   Wed, 11 May 2022 16:57:04 +0200
Message-Id: <20220511145704.698189-15-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220511145704.698189-1-ulf.hansson@linaro.org>
References: <20220511145704.698189-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If genpd has parsed the domain-idle-states from DT, it's reasonable to
believe that the parsed data should be correct for the HW in question.
Based upon this, it seem superfluous to let genpd measure the corresponding
power-on/off latencies for these states.

Therefore, let's improve the behaviour in genpd by avoiding the
measurements for the domain-idle-states that have been parsed from DT.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 83b073cdd0ed..739e52cd4aba 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -509,7 +509,7 @@ static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
 	if (!genpd->power_on)
 		goto out;
 
-	timed = timed && genpd->gd;
+	timed = timed && genpd->gd && !genpd->states[state_idx].fwnode;
 	if (!timed) {
 		ret = genpd->power_on(genpd);
 		if (ret)
@@ -559,7 +559,7 @@ static int _genpd_power_off(struct generic_pm_domain *genpd, bool timed)
 	if (!genpd->power_off)
 		goto out;
 
-	timed = timed && genpd->gd;
+	timed = timed && genpd->gd && !genpd->states[state_idx].fwnode;
 	if (!timed) {
 		ret = genpd->power_off(genpd);
 		if (ret)
-- 
2.25.1

