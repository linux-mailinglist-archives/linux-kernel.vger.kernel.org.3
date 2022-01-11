Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D0048AF67
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 15:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241656AbiAKOVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 09:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241371AbiAKOVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 09:21:49 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE450C061748
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 06:21:48 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id r28so4888405wrc.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 06:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hifiphile-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qfsEiqeTzL+rxl2EJnRIMYOkFM+p+zinSPSBDNmPksQ=;
        b=sBorI1N01iKAcaLF9K6kB5yXg0/hD6Q3DQNaJqXVyXSSMVxsrWpJqjfctKDslV0OQZ
         nbNB9hUxiiRwQhmCdkuKA6uz0i5jFB9ZsoCtrRn3zBJyaZsMw35x1pnKcJWHte5tX6sp
         wnYjf9BZhpFbuGtD+46w85vR/qiBMAOADhVZtLavRLeAKLh1A7Jijr7dvcm9FQjM/Fzp
         JMQCeXJ/Z+ttdsiszC1+S6ymyu1ExTZXDBwLu4361YKl5mEOY+7055lGocxXAZdLdTvE
         lIG0tpWo7RXxa9Lu9ljnu/6/PkUuvfprSWc6odp2V5jzcpjIA7DTIzoRwh+Od85l3BN6
         7hBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qfsEiqeTzL+rxl2EJnRIMYOkFM+p+zinSPSBDNmPksQ=;
        b=jXeIMrGmV4tqxg0ICowt0epK/j7uJtX8RGz0ST25Qd69M2OhySzDmAQkL6eX8qQxrD
         VzvUvKcWZAO00PabC+QGuD5Z7FUtMQZMt6l6xQmPIq2k62JYEIklb5EZpAnjP4Z9p20n
         cRVFFMdaVTuzmGH1p5DqtkPF+IPPYvjZhHB/VslstAPTyKvkwoLFSst3e119ZS8RySzN
         DvFH2NCBLOHkSK3PlNZp67eeZHkKkF448l8AdPBX1DelfFCtvGPjy8XxfOsXBVuZ3zHO
         R11tSiwQR66ta5etj6IyPtoD8JP88kVaw0U+UPW31e1r0Nagrl22xERjDymFUmwUv8bw
         XqdQ==
X-Gm-Message-State: AOAM530XSSsEuRfXnivU1qo5iQ3YGo/IZWr6PtIZs92cWmpRJ2mH6wdl
        3rbbaUahwbqYYopbQkySwrNWLQ==
X-Google-Smtp-Source: ABdhPJyZqcc0cseZTyeYELMHJhhL0T8eB4Z8OK3FvdmmqljGxALydejQGmQu/SYbSMZv6Nl6UFrzug==
X-Received: by 2002:a5d:678e:: with SMTP id v14mr2424291wru.254.1641910907489;
        Tue, 11 Jan 2022 06:21:47 -0800 (PST)
Received: from vbuilder.hifiphile.com ([2a01:e34:ec1a:b010:28b2:58ff:fe32:748e])
        by smtp.googlemail.com with ESMTPSA id u16sm9280157wrn.24.2022.01.11.06.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 06:21:46 -0800 (PST)
From:   Zixun LI <admin@hifiphile.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Zixun LI <admin@hifiphile.com>,
        Claudiu Beznea <Claudiu.Beznea@microchip.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] clk: at91: allow setting PMC_AUDIOPINCK clock parents via DT
Date:   Tue, 11 Jan 2022 14:20:50 +0000
Message-Id: <20220111142051.37957-1-admin@hifiphile.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make AUDIOPINCK accessible via phandle to select it
as peripheral clock parent using assigned-clock-parents in DT
where available.

Signed-off-by: Zixun LI <admin@hifiphile.com>
Reviewed-by: Claudiu Beznea <Claudiu.Beznea@microchip.com>
---
 drivers/clk/at91/sama5d2.c       | 4 +++-
 include/dt-bindings/clock/at91.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index d027294a0089..f479e39e3bb2 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -168,7 +168,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 	if (IS_ERR(regmap))
 		return;
 
-	sama5d2_pmc = pmc_data_allocate(PMC_AUDIOPLLCK + 1,
+	sama5d2_pmc = pmc_data_allocate(PMC_AUDIOPINCK + 1,
 					nck(sama5d2_systemck),
 					nck(sama5d2_periph32ck),
 					nck(sama5d2_gck), 3);
@@ -216,6 +216,8 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
 	if (IS_ERR(hw))
 		goto err_free;
 
+	sama5d2_pmc->chws[PMC_AUDIOPINCK] = hw;
+
 	hw = at91_clk_register_audio_pll_pmc(regmap, "audiopll_pmcck",
 					     "audiopll_fracck");
 	if (IS_ERR(hw))
diff --git a/include/dt-bindings/clock/at91.h b/include/dt-bindings/clock/at91.h
index 98e1b2ab6403..573cf8c25eb4 100644
--- a/include/dt-bindings/clock/at91.h
+++ b/include/dt-bindings/clock/at91.h
@@ -24,6 +24,7 @@
 #define PMC_PLLACK		7
 #define PMC_PLLBCK		8
 #define PMC_AUDIOPLLCK		9
+#define PMC_AUDIOPINCK		10
 
 /* SAMA7G5 */
 #define PMC_CPUPLL		(PMC_MAIN + 1)
-- 
2.30.2

