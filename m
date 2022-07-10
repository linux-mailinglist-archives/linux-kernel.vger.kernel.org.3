Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD2B56CDBC
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 10:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiGJIUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 04:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiGJITr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 04:19:47 -0400
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5F3CE34;
        Sun, 10 Jul 2022 01:19:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1657441158; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=PkzC3ejKaCxJqH/GwdRZh/U2JzhwTODT/YasOITe2H6ilXB9YTV6nITcgXQv7haL2wYg8IPuTHZb61aEcH4NyeHxKmyHUl/u+jVGyUDXNQ+a6t+vasSHC/17zVKnIZCqeUjxNqRGKLwsEF3Z2K62YnVokkIRSdcyB4dV3s7JRyk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1657441158; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=vkBk3XuBdXHwhI4SZSoY4y1nxjiX6Q+W8YSL2cmzykg=; 
        b=anniRx2ifFXfBuhIoWK3MTyAPAbl2kcG/OEhUiOt/iXt59la2t6b5y9iJNPQThtna2C08LMkJPiZUFoOypaQgiRNbhmxXFwYw6pXVnHXwEEf+nRris+xDXXo1Rp1QXidlzi8LLG8g+aDALNPuC6B7LSXZU6LFSbWro22OXLbJLE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1657441158;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=vkBk3XuBdXHwhI4SZSoY4y1nxjiX6Q+W8YSL2cmzykg=;
        b=LCjX9Xfd4H17sgf0pqn1XS49bzwvR8UlXUP4JWoCAP8BQIrgYuZJS7xZmr3JJYPf
        8CsZODPnUfsHezfq3S90pqk1NrTzvJxCEgf7pLrdzzeZP6XiZPIZh4LCDgT0ZooUusZ
        DjnI483bd0kxpVfrXzGCpn4rZDtR3NNScBvTCewc=
Received: from edelgard.icenowy.me (59.41.163.237 [59.41.163.237]) by mx.zohomail.com
        with SMTPS id 1657441157248771.0074016983624; Sun, 10 Jul 2022 01:19:17 -0700 (PDT)
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/3] dt-bindings: pinctrl: document Allwinner R329 PIO and R-PIO
Date:   Sun, 10 Jul 2022 16:18:51 +0800
Message-Id: <20220710081853.1699028-2-uwu@icenowy.me>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220710081853.1699028-1-uwu@icenowy.me>
References: <20220710081853.1699028-1-uwu@icenowy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner R329 have two pin controllers similar to previous Allwinner
SoCs, PIO and R-PIO.

Add compatible strings for them.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
Acked-by: Maxime Ripard <maxime@cerno.tech>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Samuel Holland <samuel@sholland.org>
Acked-by: Samuel Holland <samuel@sholland.org>
---
Changes in v2:
- Collect tags.

 .../bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml         | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml
index fa0c2df04675..d6f4bdf0c0ff 100644
--- a/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml
@@ -55,6 +55,8 @@ properties:
       - allwinner,sun50i-h6-r-pinctrl
       - allwinner,sun50i-h616-pinctrl
       - allwinner,sun50i-h616-r-pinctrl
+      - allwinner,sun50i-r329-pinctrl
+      - allwinner,sun50i-r329-r-pinctrl
       - allwinner,suniv-f1c100s-pinctrl
       - nextthing,gr8-pinctrl
 
@@ -187,6 +189,7 @@ allOf:
             - allwinner,sun6i-a31-pinctrl
             - allwinner,sun6i-a31s-pinctrl
             - allwinner,sun50i-h6-pinctrl
+            - allwinner,sun50i-r329-pinctrl
 
     then:
       properties:
@@ -202,6 +205,7 @@ allOf:
             - allwinner,sun8i-a83t-pinctrl
             - allwinner,sun50i-a64-pinctrl
             - allwinner,sun50i-h5-pinctrl
+            - allwinner,sun50i-r329-r-pinctrl
             - allwinner,suniv-f1c100s-pinctrl
 
     then:
-- 
2.36.0

