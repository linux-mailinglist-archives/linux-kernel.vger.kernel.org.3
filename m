Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF9A53709F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 12:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiE2Kvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 06:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiE2KvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 06:51:21 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A8C4FC6D
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 03:51:19 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id er5so10231647edb.12
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 03:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=32oRUurEdVyP4eLrtlvGULHRT9DbX5ENH78v/cdn0oQ=;
        b=SAEms0Q0LQZLuwDZwbGR3iLBzbV0o7Vp81Z/09GtFOGJgCesGjHseBi5RXC7IOjlJW
         8p8X2mz/+SR7ye1/YPk0rKioOlSjNQ/mzLuZJwoSgdXDa6YJenoY96r+4S20qtT58cnl
         vFpDkgzHomMrDPKgtn+xov2mei0v3oTWwEYs3gfcwfcx5HgENS8bouVTA7dnzDkp695t
         zdSCX4aU+LAyJyou81uLEmuGhZFPoitiheaBtRV6YXqBtsy0KSAIrnEvfocFflrXxQ2B
         LakVs5iA3bFVj4KtDYFyDQtwX5VCdmaqjLEK0sHo731eqQPN7GLgmdKO12mu+R5BhpEU
         pAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=32oRUurEdVyP4eLrtlvGULHRT9DbX5ENH78v/cdn0oQ=;
        b=2Pcj8ShVduA8t28WKNcreb31aFyqc4niY0jcpvCHyMkF4hry15rFNop2OTVyAlKcYe
         L6eUX77dYXpkOBScJe+o7Wk4AJoG5p1MgXI3x2VcqmY/C73EHdt9YcpVrxyulRa2pTIR
         StTSwbwexjySFLQmF6y8negZk7UJ84tZXIHE7jdHNtO0FG8bQsFlrhW95HnoJ02fqNpP
         gMZsKyepS6659u2YfRxw4vk2NFGLXPeTR9ach36k6OR4n3+u2duxa2rG0dyi/6MtjnNd
         lbzOIlNPa3jDVT4lvput5YxIsVyE9EBDPE/ZpnCgxrXWLEfbnSifuHf1aU5cR6l18Apm
         DmvQ==
X-Gm-Message-State: AOAM530N8xH34pt9T6qw2cNkFzVzCB6lnaWDioZsZY9FQqM+hLru6xvR
        2OxoJcAigVOOuRzNwwb1HZ5vmA==
X-Google-Smtp-Source: ABdhPJw8d7g2sDkHVBAzTeeMMRQh/0/LdRPavHItYLCzqxQjYX5Jrw7uPOyTtPJx7coy/d5zXNCQPg==
X-Received: by 2002:a05:6402:34c1:b0:42b:4047:20b8 with SMTP id w1-20020a05640234c100b0042b404720b8mr41562410edc.88.1653821479409;
        Sun, 29 May 2022 03:51:19 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id w25-20020a50f119000000b0042b0fcfe966sm4746991edl.37.2022.05.29.03.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 03:51:18 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Lee <steven_lee@aspeedtech.com>,
        Ken Chen <chen.kenyy@inventec.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     David Wang <David_Wang6097@jabil.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 5/7] ARM: dts: ast2600-evb: fix board compatible
Date:   Sun, 29 May 2022 12:49:26 +0200
Message-Id: <20220529104928.79636-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220529104928.79636-1-krzysztof.kozlowski@linaro.org>
References: <20220529104928.79636-1-krzysztof.kozlowski@linaro.org>
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

The AST2600 EVB board should have dedicated compatible.

Fixes: 2ca5646b5c2f ("ARM: dts: aspeed: Add AST2600 and EVB")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/aspeed-ast2600-evb.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
index 5a6063bd4508..c698e6538269 100644
--- a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
+++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
@@ -8,7 +8,7 @@
 
 / {
 	model = "AST2600 EVB";
-	compatible = "aspeed,ast2600";
+	compatible = "aspeed,ast2600-evb-a1", "aspeed,ast2600";
 
 	aliases {
 		serial4 = &uart5;
-- 
2.34.1

