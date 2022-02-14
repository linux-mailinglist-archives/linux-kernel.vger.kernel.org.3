Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CF84B5CB1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbiBNVX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 16:23:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiBNVWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:22:51 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873DD13CA00
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:22:36 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 659E64033E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 21:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644873755;
        bh=3PF5Xzl5CoJdPD2v8HAB1YXbDg9KPu30U+G9i+xttCw=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Ewu5ZSIXGZvMSdWMOEOPwosJd6i4JeSVswTIbM7CrJRdYcg3mv1mhnNujSvKdL4HC
         fsP9B2LzWe4pM7QGbbP9vyh6ygu+BaE23jmSoCg2QoVSeXkiIWrKpuYwWw5dJbxWTq
         kELjm6y9PnjISSZnVBC0Z5+e7rEvyprNjuw3Y2hjAN4tqcZhtgqu1XXZqfvTnn89ma
         kvgJU3hCR0DAuZZLdA1rCW5VxzYwvBIPhRIJGYL/iE3FtQr0EBgfG7zm3llseHIWlc
         9CHpakQwPEDStHNtnEEkiAVM9d9Mwwk4QyLD+DvmQb45OetnGbKsAEuf/9eTPfqK4e
         iGSUy+AhJDkvg==
Received: by mail-ej1-f72.google.com with SMTP id d7-20020a1709061f4700b006bbf73a7becso6379124ejk.17
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:22:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3PF5Xzl5CoJdPD2v8HAB1YXbDg9KPu30U+G9i+xttCw=;
        b=UNsuufWMVgyPY7yLKMWhJDI11Lt15SCrzAeacTrVoaVKfLWoUeJtqDyRUeEkBsZLH2
         Fb1MpquwkfZae3ENRh36+K2B9tLhT4xU2lvqO4I7fEci6ujBb/bgZyKsg9ERRxYgA7KH
         1rMph0ZjfA8tr6SagpVSqfN2ClU/+HhRXE2O5ZlkEOc24h1aq4c120TVVDWWTuS+kXFo
         dzg7Toa8CqkS14ly+dGEJHkT7x/Z7xa+0nHLz0kyU0BrbjwljLpsXIwC3cBoXeDXzDrj
         QHwmA+vt2I08Mia9EDbzzwSZoOh3AAlCI8J2t62zhlmk0QTbmkIgoJpmNyAlTgYAiWTp
         PnpA==
X-Gm-Message-State: AOAM5336OcOPhu0MLSwOx5BQLo+DzjzlZ81s0B/sderLSRapUBmPOv53
        f9xxOyDBhO94Sb9Ey26kmyNgZ85+seWr1bbFbiE0/f489djcbq8gS+gVtpPRT2fvNk9wa0XZ89D
        CGJ5hOFK7OwBf8n6oiIZDmdUT4Wm8dsaiqP2U/i4Jcw==
X-Received: by 2002:a17:907:72c6:: with SMTP id du6mr574121ejc.204.1644873744391;
        Mon, 14 Feb 2022 13:22:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyrvlFt0k7lzl0jdOoom20eqtUPJDSasKZZ5zI9SYLsZwz94svn3KccXpJhcfimHcBqD9IEPQ==
X-Received: by 2002:a17:907:72c6:: with SMTP id du6mr574097ejc.204.1644873744234;
        Mon, 14 Feb 2022 13:22:24 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id v24sm2327203ejf.7.2022.02.14.13.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 13:22:23 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        Jeff LaBundy <jeff@labundy.com>,
        Yash Shah <yash.shah@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Vignesh R <vigneshr@ti.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v2 14/15] dt-bindings: pwm: tiehrpwm: Do not require pwm-cells twice
Date:   Mon, 14 Feb 2022 22:21:53 +0100
Message-Id: <20220214212154.8853-15-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220214212154.8853-1-krzysztof.kozlowski@canonical.com>
References: <20220214212154.8853-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pwm-cells property is already required by pwm.yaml schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.yaml b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.yaml
index ee312cb210e6..70a8f766212e 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.yaml
@@ -48,7 +48,6 @@ properties:
 required:
   - compatible
   - reg
-  - "#pwm-cells"
   - clocks
   - clock-names
 
-- 
2.32.0

