Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BD453709C
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 12:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiE2Kvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 06:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiE2KvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 06:51:21 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFEA4B429
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 03:51:20 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id jx22so15957700ejb.12
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 03:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NgMauWvxEUuOeuS3Y92cUsJTownNgikY7PKvyEqLIJ0=;
        b=SNlPaMUB+7zeMZ40NRYDTHGbFJ7bDg8bNcjtSrbo2g/09zCuKS0mzczq2VajsJFjtM
         5B6l/FIwo+u9FUTS2Dw2RgVb9ud/cTfiUKG7WPQQtbsSxi/74pfHC+BCkiRtAMhokGU3
         wAA0uVLbDozClvVb8yw/H2MSJFnjZIOwIBJeGLlcoo5mFUlkx0VPSLF/pdRZjCtNLcdG
         +V2MmFhUirx6phG6SaHWfuLUMwnxDF/dWDpnVizRe14bsbVwLjTTqcYIiWFXhkW2RKts
         /lnHt8qnGIP1kxLSokpN8qLmJbMw4ri+p8DaJWTZ8SyDtGSbEaN+9a51q+SehkuyqmYD
         O5zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NgMauWvxEUuOeuS3Y92cUsJTownNgikY7PKvyEqLIJ0=;
        b=O2yNP7WKWOlf9E8g1CsJiVsRMJU2Sz4rKl0FG39AWaDQpLHgIA0Je9BupljvsLNcx4
         jqrR7L6LL6EMcBba4rxVXb5b/lhqSX4VMcgf1eci7TksXncHiG3La47S6NdA8bqIdSLY
         pUpHtisxI0oOPhiSQHnKRCfZp3Xnd9tsjULd6ADF4BLTOeu7gilLqvklpxQn0xEXXFcf
         1BfEeWLcblOgoPE57b4GhSS79nnvYE1GoxKKLzaffq/oLMq6MYQcLNFfI5ksRpZ9gQ/n
         OnnfiUMJ309zeoF4VHp0PqPPIOgwMYlSxX+QFHBfwf+1E3BgvWpY0rVipFz0kxb7M1gj
         nRdQ==
X-Gm-Message-State: AOAM530H6sJaLsscXUFEpEbJbxkuhF2eJKgF/b4Y9+B2jQBr3MwHFqkf
        cke6180siKh+a70oz0umo9wGCw==
X-Google-Smtp-Source: ABdhPJxhghDhXPcQraQ2UX4g1HUR3BAj9m0/Qjzp5NPytdTY43MUPg3GjwR3iLHl3b1OD9CFysiuSg==
X-Received: by 2002:a17:906:9743:b0:6d8:632a:a42d with SMTP id o3-20020a170906974300b006d8632aa42dmr3476540ejy.157.1653821480511;
        Sun, 29 May 2022 03:51:20 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id w25-20020a50f119000000b0042b0fcfe966sm4746991edl.37.2022.05.29.03.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 03:51:20 -0700 (PDT)
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
Subject: [PATCH 6/7] ARM: dts: ast2600-evb-a1: fix board compatible
Date:   Sun, 29 May 2022 12:49:27 +0200
Message-Id: <20220529104928.79636-6-krzysztof.kozlowski@linaro.org>
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

The AST2600 EVB A1 board should have dedicated compatible.

Fixes: a72955180372 ("ARM: dts: aspeed: ast2600evb: Add dts file for A1 and A0")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/aspeed-ast2600-evb-a1.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb-a1.dts b/arch/arm/boot/dts/aspeed-ast2600-evb-a1.dts
index dd7148060c4a..d0a5c2ff0fec 100644
--- a/arch/arm/boot/dts/aspeed-ast2600-evb-a1.dts
+++ b/arch/arm/boot/dts/aspeed-ast2600-evb-a1.dts
@@ -5,6 +5,7 @@
 
 / {
 	model = "AST2600 A1 EVB";
+	compatible = "aspeed,ast2600-evb-a1", "aspeed,ast2600";
 
 	/delete-node/regulator-vcc-sdhci0;
 	/delete-node/regulator-vcc-sdhci1;
-- 
2.34.1

