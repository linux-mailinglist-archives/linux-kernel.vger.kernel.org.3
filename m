Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894F54B5C98
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiBNVWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 16:22:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbiBNVWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:22:15 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B662513C3B1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:22:02 -0800 (PST)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 86A46402E0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 21:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644873721;
        bh=11HYmRlx8dE2WpuAnKJ9eGJzYR6C7S08K2HSgZ9haWY=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=D4Isp002T/68PG64fsV9tYAp3xpaOjws7fI7XFSQ893gibUR1y738SCL0X/ApK89C
         ZjZVzAuvOl6tvexOPC4HiZm+7laa8ko4DenvpCGYV97CEEqqwRKrE2j/eCP1z43P6P
         Hb/l99QuHjpq15Z0zyxQw/ussYDurUmlR4kosJtEvXKuawCrFBHZTA6g1gSTnL/kXs
         lQlapgWf4B7o3rRn99QQTkoZtCAgW+pDTutN6Oev0ciNdxgG82bBsCvHN8tteLz3Ao
         5XR304tAyYR5H7mJuJS7qnKo2jLRJSr8ZY0QYpJYfNJ2FNSRw3/2Di2knIFEemElVh
         mp6tSO+ZfknVw==
Received: by mail-ej1-f69.google.com with SMTP id go11-20020a1709070d8b00b006cf0d933739so1312525ejc.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:22:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=11HYmRlx8dE2WpuAnKJ9eGJzYR6C7S08K2HSgZ9haWY=;
        b=KTF40skibz1EXl0x/Rh0EQk4VmVupjXALntLiOHjQWW4qL3L1LPO84r5mibJwGxXwb
         PK56vLtuLPiHhSNezdO9WQLglBwd94EzSxdGY7hvAQdBg8lGdb5Kj72m5xXz6avWlLz2
         vXYaTGF1xjMzYbbZb/6CYqIati2oicHfr0LnGxnRwyou5EkU1DTZc2S/X8w66YvWIqMX
         FjcOjMD3itrNG+vPUsZ8P9E9owGq/Z4o4CJBsjY79yS0Yeg1TThe27i8J7IPASLGNagE
         qtGNnbcClM3WmU+TQbxUvvpDUQHKkaDwu3/z3YbrgO9oiJTbcjIkzsGRA/c3H1Pl+gi3
         LFKA==
X-Gm-Message-State: AOAM533kb4uGAseau2abTsx2A0H+iPdVwoXsbwGecUCsTjrdb5lEfMTC
        EVJ5fpuj1obs/0QkJ6xQm+TfQZAplY9XM+j1oKfAkNpBE0SYFz8uexpW+u5QipNjopjLes4uaCC
        qJ3QHDLxF7poVwN6mjBTlNiXiMMqisl8hmU4+UJcz9g==
X-Received: by 2002:a17:906:8a83:: with SMTP id mu3mr507546ejc.699.1644873721206;
        Mon, 14 Feb 2022 13:22:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzBRv82g+ePgMF2+U8SP74RMmwo7vMWesKHUBo0ELgxKNYYBtnBlWhrBbL5O1DcvkqWwBUiLQ==
X-Received: by 2002:a17:906:8a83:: with SMTP id mu3mr507532ejc.699.1644873721039;
        Mon, 14 Feb 2022 13:22:01 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id v24sm2327203ejf.7.2022.02.14.13.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 13:22:00 -0800 (PST)
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
Subject: [PATCH v2 02/15] dt-bindings: pwm: imx: Include generic pwm schema
Date:   Mon, 14 Feb 2022 22:21:41 +0100
Message-Id: <20220214212154.8853-3-krzysztof.kozlowski@canonical.com>
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

Include generic pwm.yaml schema, which enforces PWM node naming and
brings pwm-cells requirement.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 Documentation/devicetree/bindings/pwm/imx-pwm.yaml     | 4 +++-
 Documentation/devicetree/bindings/pwm/imx-tpm-pwm.yaml | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.yaml b/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
index 379d693889f6..b3da4e629341 100644
--- a/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
@@ -9,6 +9,9 @@ title: Freescale i.MX PWM controller
 maintainers:
   - Philipp Zabel <p.zabel@pengutronix.de>
 
+allOf:
+  - $ref: pwm.yaml#
+
 properties:
   "#pwm-cells":
     description: |
@@ -59,7 +62,6 @@ properties:
     maxItems: 1
 
 required:
-  - "#pwm-cells"
   - compatible
   - reg
   - clocks
diff --git a/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.yaml b/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.yaml
index fe9ef42544f1..8bef9dfeba9a 100644
--- a/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/imx-tpm-pwm.yaml
@@ -13,6 +13,9 @@ description: |
   The TPM counter and period counter are shared between multiple
   channels, so all channels should use same period setting.
 
+allOf:
+  - $ref: pwm.yaml#
+
 properties:
   "#pwm-cells":
     const: 3
@@ -34,7 +37,6 @@ properties:
     maxItems: 1
 
 required:
-  - "#pwm-cells"
   - compatible
   - reg
   - clocks
-- 
2.32.0

