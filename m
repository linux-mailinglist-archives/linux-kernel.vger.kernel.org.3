Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DF44B43EE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 09:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241925AbiBNIUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 03:20:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241810AbiBNIUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 03:20:01 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FC625C47
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 00:19:54 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A6A1C402DF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644826793;
        bh=r/A1exu5teyjmoBiQRL2ADp+LBFLDHTow6yiZCZgmss=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=KjUiTDX19e3BrgHmreSs4Cs1goo9SD4zIEBHKunqpZKGShuvgi/Mjii8NKB00kKIq
         3GVqkmKXsesYZc6vx0pghCpzX/jeCRM+EjWug4HBb5vI7JoggOoInUwOi97LggtY6i
         4NYMP59Z73a0wzr3MsE7l9geBZi2yrRA0Wozg4lzJiTkX011+EhC9GQ+aEt9JlVMpE
         nHy7eHo43b7pJPorNoHSRCTAf/0yhX641n47JVbbMHKAqwL9CGQyQnN/wfrWi2e424
         k7AFgT7nzpZYB0ekjNlgwQkxvr5ZDn3hf3lDG3trdk3LL5LAS7Lrq9iJpqMuGHCGqU
         IR/P1vhgYQl7w==
Received: by mail-ed1-f69.google.com with SMTP id cr7-20020a056402222700b0040f59dae606so9759703edb.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 00:19:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r/A1exu5teyjmoBiQRL2ADp+LBFLDHTow6yiZCZgmss=;
        b=Uy20yTM7dD6NWFOSaDQn06Y1WGOXgXKfcm/x102ltnOuF4BSW8z4qpu9zW0/KjIIQ9
         ZK36JF1a5gh+PA+i2L1ZRpX6ZWvwxblABZ1NA9F4zb1jjpjfZNHgAuKqi5xvobZ9xsNW
         OfbEergRK7K+SV7fBZwPpSUtnSLqYbuygDNslkKmlhdf7Hj6FnrXDN4XoiPGMO2wWZG4
         ktLL48zFAvodmZvCh5S43Bnnmu4WGkhLPLKRnwt5CeqO+4YDJREGznKTqWy6qca//5Mx
         yLPS4Wep6JmDzQaF2mqspRfNSL1tgfJmqlIFo8aJLg64clTD+NmLzKMTB4Z2RNPmWde/
         zsYA==
X-Gm-Message-State: AOAM53367wEJl/ybzsIO9iYnNCgCuMGfMpObZPGQg9LDfyaQkxeO3rU9
        gq8dj9IAJnNp89h0vTwTzQH3EuExOhYD6s9RZS79AwUKob/dvZ0ZR4s5DGaLJ+DAU0VSWRyxh9C
        9uZL1cv7fnfeE+TGI3HyyKMSMraR2z2V5FNUUV/1riQ==
X-Received: by 2002:a05:6402:278c:: with SMTP id b12mr14039646ede.103.1644826793452;
        Mon, 14 Feb 2022 00:19:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzdbYmf42KnCNX/mcVtFFEqTiPZLsd8EmrJGHsXn4X5T6VWqFxb6wiz0GiywYV8Bjax6MTWGA==
X-Received: by 2002:a05:6402:278c:: with SMTP id b12mr14039619ede.103.1644826793319;
        Mon, 14 Feb 2022 00:19:53 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id b20sm2022941ede.23.2022.02.14.00.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 00:19:52 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 1/4] dt-bindings: pwm: google,cros-ec: include generic pwm schema
Date:   Mon, 14 Feb 2022 09:19:13 +0100
Message-Id: <20220214081916.162014-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220214081916.162014-1-krzysztof.kozlowski@canonical.com>
References: <20220214081916.162014-1-krzysztof.kozlowski@canonical.com>
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

Include generic pwm.yaml schema, which enforces PWM node naming.  Keep
the old name in bindings as deprecated.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 Documentation/devicetree/bindings/mfd/google,cros-ec.yaml    | 4 ++++
 .../devicetree/bindings/pwm/google,cros-ec-pwm.yaml          | 5 ++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
index d1f53bd449f7..0255b7028496 100644
--- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
+++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
@@ -89,6 +89,10 @@ properties:
 
   ec-pwm:
     $ref: "/schemas/pwm/google,cros-ec-pwm.yaml#"
+    deprecated: true
+
+  pwm:
+    $ref: "/schemas/pwm/google,cros-ec-pwm.yaml#"
 
   keyboard-controller:
     $ref: "/schemas/input/google,cros-ec-keyb.yaml#"
diff --git a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
index 4cfbffd8414a..7ab6912a845f 100644
--- a/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.yaml
@@ -16,6 +16,9 @@ description: |
   An EC PWM node should be only found as a sub-node of the EC node (see
   Documentation/devicetree/bindings/mfd/google,cros-ec.yaml).
 
+allOf:
+  - $ref: pwm.yaml#
+
 properties:
   compatible:
     const: google,cros-ec-pwm
@@ -39,7 +42,7 @@ examples:
             compatible = "google,cros-ec-spi";
             reg = <0>;
 
-            cros_ec_pwm: ec-pwm {
+            cros_ec_pwm: pwm {
                 compatible = "google,cros-ec-pwm";
                 #pwm-cells = <1>;
             };
-- 
2.32.0

