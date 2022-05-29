Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24745370A2
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 12:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiE2Kvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 06:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiE2KvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 06:51:20 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A757C4CD5D
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 03:51:19 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ck4so15968308ejb.8
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 03:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qgQq5YY5g1jPHR+HWdKtiA4Zjs/eV4wGZhb7rjwkR2c=;
        b=CZp/I0K3BY1MJhVXmiwcSl4w55kavz2JEgA9VVfOUNFe9TYHUEI9o+r6NXa4RRh06P
         M5Xmqkws+7WycCGLkbBVkeaW86bvoAR5S/kIn38WFdB8haiYQLILehufzOYpLXeu/TOA
         uIvEJ+X8NKoFKkcN9Bwskyh6rraK0WMKWAkuUbc6/A0OKtkjij745oq5KYqRuohdXiAn
         1V2eG0z9mltbHoD5rn24y7OJrjFfF4NV5HlMORcW4z7T4tZMhJpe8YoxVp7JXhmnC03M
         fv2zvYOFGoo82UpCc779fZve3dkYARyOtE70iY92QUTgXpoq0PAlkMDHM9vAWU25/oYB
         RbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qgQq5YY5g1jPHR+HWdKtiA4Zjs/eV4wGZhb7rjwkR2c=;
        b=naB3X8eEmWuvbxCg9bseA5lDhd+Q8W4KwS/WNrRQLTIBaB1sTeMiB8gfP+5kYoKvnC
         n3uDBwjpNA3MZj2xLbLjrw6bXz8Q7Fppv9XUbHOVkuNUgeARv7nPGroWSh7p0CvOKtVe
         ULDTVHyynCkw9l6jK/KKxCcjZ7WLP/cguuZbuy2jdx9dUjfioJ72vFWlM6EXhM43xaTd
         HRSQbK2bTbjjQJsQogryTSmxw5xbjZeH8e/4nr2RCTWt2T/9KyWS/VOG6WSUH8WLPWfP
         ps3jxCmmQpfiInyRgy2SiBEz/4siMIYUSOv+FiWU/dQMBPBIehI+HFqucrXD2tCyLPGf
         EoKA==
X-Gm-Message-State: AOAM532VoDfkmbA2WlN0/hrQBIPtfcAbjgK306AED3KS8ArWiMkM36tv
        soeZWNl5LlmAi6079jeX4/TsjT5F/vrxPL2f
X-Google-Smtp-Source: ABdhPJwLrlyqp191ide0tQO3BUOEryml6g7D35IAw9JkMrAdj0vMgCpLMo/FFIQ2sXKYs9UF7t4QbA==
X-Received: by 2002:a17:907:7207:b0:6ff:d25:ee3f with SMTP id dr7-20020a170907720700b006ff0d25ee3fmr20068800ejc.389.1653821478248;
        Sun, 29 May 2022 03:51:18 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id w25-20020a50f119000000b0042b0fcfe966sm4746991edl.37.2022.05.29.03.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 03:51:17 -0700 (PDT)
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
Subject: [PATCH 4/7] ARM: dts: ast2500-evb: fix board compatible
Date:   Sun, 29 May 2022 12:49:25 +0200
Message-Id: <20220529104928.79636-4-krzysztof.kozlowski@linaro.org>
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

The AST2500 EVB board should have dedicated compatible.

Fixes: 02440622656d ("arm/dst: Add Aspeed ast2500 device tree")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/aspeed-ast2500-evb.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-ast2500-evb.dts b/arch/arm/boot/dts/aspeed-ast2500-evb.dts
index 1d24b394ea4c..a497dd135491 100644
--- a/arch/arm/boot/dts/aspeed-ast2500-evb.dts
+++ b/arch/arm/boot/dts/aspeed-ast2500-evb.dts
@@ -5,7 +5,7 @@
 
 / {
 	model = "AST2500 EVB";
-	compatible = "aspeed,ast2500";
+	compatible = "aspeed,ast2500-evb", "aspeed,ast2500";
 
 	aliases {
 		serial4 = &uart5;
-- 
2.34.1

