Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA915370A3
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 12:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiE2Kvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 06:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiE2KvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 06:51:24 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F674DF63
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 03:51:23 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id c2so715693edf.5
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 03:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tjHmH/k5OnwGTIX8JGp/u7wV+TKFsiA0hlmVPnIEjOI=;
        b=nwkcY8aS85BC02SBgalxJjxF5X2sRSHiazRKBPvxeWltyh9GpA2Y/3GJSo5hGdRmle
         B42JQYxzwweiSJ8LUiu/0L7nRLZ6OuJJM4d1ryf5X9RrEknmc6LB49n1uNuct3+wHA5l
         ZZiG8LJYgR+o6V83OmVlIQD2lGL1/5W8Fnyf8x26d6EDCa1gnEsyVdHkdWfllYr35Zh5
         nELvWJBSoAq9etnJ+aw4Jxf7FeK9Wr+4MMsMhRXm5xwggEt8NvoAm7rqHfnYDb4EV9ZI
         HFvGZy0WrhlqoaLBJdbstaO/JeRuZwLzTfg9+ZCQgs1g4xMy15DZ6lRyq/WnTvn3Nu8e
         lIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tjHmH/k5OnwGTIX8JGp/u7wV+TKFsiA0hlmVPnIEjOI=;
        b=iRYbK+hJu6kT6XycsG2vYZBzitPRjZ3JOmsA1gq4Hb9ZVVKWXx7uL+FlB/HdJWITag
         uprLkWdX41sv3bYGYO8dMbYB7mhXx3ztgOpYsfQdOGn+3RqvecN+Y19/pS56iDf2g92z
         /6wsKBNRWVm6cvksZphuLijIzP/KSJLHi3qhk1mrVfw037/1Yg4Bt5wV2HgO9iGpVouy
         GKM0e28RDLfZdpOb8p69kysl+2quewqLjCGhXdPRT3cIBFAJWxoZOGe5mpX7NgtPuOod
         gTlVnOZyVn7aJ0+FZNjhVhfc36N3yGO9AJRlKPaBNVIffE0/xDTg2SR9l+VnNKI7dD+T
         bTxw==
X-Gm-Message-State: AOAM533gBnnPSl4b1Kj38xIQ7E6jPsJ2mTrBpOdRA0mwhxoDATYZL0ZU
        Zq5yQP4eBTOoz3LhlMjG//vvbg==
X-Google-Smtp-Source: ABdhPJzPfF++CclA17wW8Tsy2/nq+Rvo6+fQTJ+x5gV7m58QRmV067rGaFZx7OsF+daXLjfPYqqw1Q==
X-Received: by 2002:a05:6402:1b1e:b0:42b:cf35:2621 with SMTP id by30-20020a0564021b1e00b0042bcf352621mr20338321edb.352.1653821481695;
        Sun, 29 May 2022 03:51:21 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id w25-20020a50f119000000b0042b0fcfe966sm4746991edl.37.2022.05.29.03.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 03:51:21 -0700 (PDT)
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
Subject: [PATCH 7/7] ARM: dts: aspeed: centriq2400: use qcom compatible
Date:   Sun, 29 May 2022 12:49:28 +0200
Message-Id: <20220529104928.79636-7-krzysztof.kozlowski@linaro.org>
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

"qualcomm" is not a documented compatible and instead "qcom" should be
used.

Fixes: 3719a1b13056 ("ARM: dts: aspeed: Add Qualcomm Centriq 2400 REP BMC")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts b/arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts
index 3395de96ee11..2e8b87783717 100644
--- a/arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts
@@ -6,7 +6,7 @@
 
 / {
 	model = "Qualcomm Centriq 2400  REP AST2520";
-	compatible = "qualcomm,centriq2400-rep-bmc", "aspeed,ast2500";
+	compatible = "qcom,centriq2400-rep-bmc", "aspeed,ast2500";
 
 	chosen {
 		stdout-path = &uart5;
-- 
2.34.1

