Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51877547387
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 11:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiFKJ7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 05:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbiFKJ6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 05:58:53 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3126B84F;
        Sat, 11 Jun 2022 02:58:52 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id e4so1501142ljl.1;
        Sat, 11 Jun 2022 02:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qqG1jqR6TJ+ossn/Taa42wkdLkXZRIkBpKhqix1o0Nk=;
        b=I3jVrJeQfeeEUpRXX4j3bFLN0JDYjpr2/5CF5Ik1W8de2CQMNAm+DQ8l6O1LxRezCl
         GO7TAEVgwFdIyUxbkSZLBQQHjW5fbDzNuW6cGfVBRkFFOGXg1qUGscG1EiBXj/Wl3huE
         YuvsuRlKxsEPGE3Vt5q8+Sw42lqCnFmfeYGCZJFaa2PyufPGXbvbYxTPYy2C4WxHkRs7
         Jw/k4KuQogmXlcH2SnSQC1wHD7JdEYymLagxxUuXNYWqzIR5LOOptL92cp1tO6Cg/I+1
         R1+B+04LJC13sj0LyVR5KGxpSaD1k7M2iPIhk0tT2uLZgrQjWgzod6uPTCXPWAh3c1/P
         CZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qqG1jqR6TJ+ossn/Taa42wkdLkXZRIkBpKhqix1o0Nk=;
        b=tx1GlbNZNudCwPIs9Wn/uWpGwxEYo4OpsYsRyxfoNCb1MklJV7ptZINpZ0aaA24x0t
         EG/U8Ogdp4zjop/wD7FPZK4qztHgBSV0tENl6wIdeTTdefREtsi4+VwbCw70T7s0KjDu
         INont7f8ZRSCWVTl+wXrEQvFO48BPfr9BWSOnCfrXGtvyd4hmMiE+4/c+cbOaRxoQ5wG
         S2UlbfgWmAQxygwMhrBoUXP3z0DVSrzL8yVg2++iIv1O24N5dlbmc0PYHkrzpC853j+2
         282XS5jLebI6WDv1ZCUdWQyTmtV2kf3K5DBeWhD0zb68FJ1AH3FDpPW5BHJX6CMvSeo/
         wMTw==
X-Gm-Message-State: AOAM53218XsYZakMc17jcEq7MzzOtMTOwWmrtbC+fvyyd313XtBtFHNy
        kBAdPVwGIcJQ3LSEgJYVf7A=
X-Google-Smtp-Source: ABdhPJxbCZOKur9tOGLWFf7ulXImGftDF4a+Z/DYBqIigxmKroh1yds8o/DKWkS8ynJgTeWngkHLfg==
X-Received: by 2002:a2e:3112:0:b0:24f:132a:fd71 with SMTP id x18-20020a2e3112000000b0024f132afd71mr64922689ljx.522.1654941531058;
        Sat, 11 Jun 2022 02:58:51 -0700 (PDT)
Received: from DESKTOP-GSFPEC9.localdomain (broadband-90-154-71-254.ip.moscow.rt.ru. [90.154.71.254])
        by smtp.gmail.com with ESMTPSA id h18-20020a056512055200b004785060bad6sm200634lfl.201.2022.06.11.02.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jun 2022 02:58:50 -0700 (PDT)
From:   Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     supreeth.venkatesh@amd.com, aladyshev22@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] ARM: dts: aspeed: ethanolx: Use correct driver for the FRU EEPROM
Date:   Sat, 11 Jun 2022 12:58:27 +0300
Message-Id: <20220611095828.1090-4-aladyshev22@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220611095828.1090-1-aladyshev22@gmail.com>
References: <20220611095828.1090-1-aladyshev22@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AMD EthanolX CRB uses 24LC128 chip as FRU EEPROM. To bind correct
driver for this device "24c128" compatible string should be used in DTS.

Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
index 0354a7d8f9f5..428fa9f673f9 100644
--- a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
@@ -163,7 +163,7 @@ &i2c2 {
 &i2c3 {
 	status = "okay";
 	eeprom@50 {
-		compatible = "atmel,24c256";
+		compatible = "atmel,24c128";
 		reg = <0x50>;
 		pagesize = <64>;
 	};
-- 
2.25.1

