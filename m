Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194124B43AF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 09:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241707AbiBNIQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 03:16:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241667AbiBNIQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 03:16:51 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90715F8F1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 00:16:44 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AA7E5407DC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644826603;
        bh=11HYmRlx8dE2WpuAnKJ9eGJzYR6C7S08K2HSgZ9haWY=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=FkPTLt7jp9UNXDH2+IU3m6hYstXVUeibd2NA5vIK8KS/LN4NburyECaqC8wmiROXi
         JNkZQm7XSqmW8wH2sKMy9ef7AapVBaW9hCKwsRxQP5fuNcBRCrtt5r7X3V5LJmXinO
         iSZao07MlbDN/gkd3YzAXFsKX2gavCQq/DygK9nxFgaiGjCFuloC7K4JtmXrBHjSnR
         R1TGHFM4YcRLn1kcB0L2kHSPiYYM6fB7o5sg+9X6/0CfWvBuB9VEIwL5lmqKYKTcJH
         ENjdNtl4AXf5d+JqloYMikk4/hDYQ9YcThIFEz4ybzZqoHyp0WRAg0MAgZYMNy2pws
         0jAcJaWrBYSgA==
Received: by mail-ed1-f71.google.com with SMTP id l14-20020aa7cace000000b003f7f8e1cbbdso9762175edt.20
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 00:16:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=11HYmRlx8dE2WpuAnKJ9eGJzYR6C7S08K2HSgZ9haWY=;
        b=5taqHSAHPvyRezcWFoD2wMKC29GononGgO3OuS4glwucq/aogSPjgK1NVeA3Hb54b5
         JYewt6aJbg0IB++yG9NKNhfNm2Pmv7svKKfqp3ZVFk2r/4Vq5uy98EF36GwQqZBv64Yk
         ugl4jwNBeJeLuQ7dzr5iXLDIT80NKNFZgJ+XcdotB9lvsdlpSLDywDxA0ksq38+2zCyi
         UY9+pU6eUaFuaQA5pUnkUdFDMo6JDuq0v1ZCMTaqfSIYpiaahAIZNJXylbUYK1TkfPLS
         C7yFkkKdz2NBLAdVg88SMEPyzoxia7kDdlqbgs8HsqP7Cf2mhMTXpSTV/j54Nv0OeQki
         ehlw==
X-Gm-Message-State: AOAM533kL8F1TQiAOBhuAnse5hS0f4htSWP26kcca/HEfPYm30CvheNz
        bLIiPAUWQpuICJcmfVPBv9icMZGPy6PdCFEtgIYmKzFNk0CeNWCU6qO5P47WxRvTsa4kH9JD2Oj
        xIDGcUxjK8vs0SPZhsnv6wxcSfcLck+uyz8nfo2sFyQ==
X-Received: by 2002:a17:907:2849:: with SMTP id el9mr10391901ejc.201.1644826603258;
        Mon, 14 Feb 2022 00:16:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxLuiFn010/+iYNxCh4N8RZLwAdqCGm9AdinTqIbutozbZK/206AXtZbT7nvgxN/IZXfSJlXQ==
X-Received: by 2002:a17:907:2849:: with SMTP id el9mr10391886ejc.201.1644826603108;
        Mon, 14 Feb 2022 00:16:43 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id t21sm3363642edd.74.2022.02.14.00.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 00:16:42 -0800 (PST)
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
Subject: [PATCH 02/15] dt-bindings: pwm: imx: include generic pwm schema
Date:   Mon, 14 Feb 2022 09:15:52 +0100
Message-Id: <20220214081605.161394-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220214081605.161394-1-krzysztof.kozlowski@canonical.com>
References: <20220214081605.161394-1-krzysztof.kozlowski@canonical.com>
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

