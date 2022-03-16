Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C82A4DB06A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 14:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356024AbiCPNK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 09:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356017AbiCPNK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 09:10:56 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931174F9E7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 06:09:42 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1B1B83F325
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 13:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647436178;
        bh=hMpVGD6o3TsybJH5wrGEkbZ3q6M86lmXlzkdgti+gZM=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=ajmhVyosPjPHewC9eWeEy8Gk5x03HOhY37sldJdEb7V8LzWc1AkFlEv3Fdz4MHxIS
         9xIvzmA8QuKUDHjGdO0R2yBl6DLFjbC0I1UBWVgVkQ5byHYT6cOYiRYBHk1FYVDgu5
         86JBj7OphBtExVKE0G5zNFSvj1vBF+21WIw4zbXN70B0kBtvymXH7MtOb/1ZSHLBkI
         5jINgdOUHZwZjGpxJnkm0Hfr39IyA83XqnWSJ1vE4fbDFd3TDN6aN5RXFqnMcoOhUI
         VpQPig8CWRv54gq1292rNP4cQRfGwJ5CsGPe7o1zABJFEg3lQ8CqhGwJSVnoS6sswE
         FmJTkBp3GraRg==
Received: by mail-ed1-f70.google.com with SMTP id v9-20020a509549000000b00418d7c2f62aso1278195eda.15
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 06:09:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hMpVGD6o3TsybJH5wrGEkbZ3q6M86lmXlzkdgti+gZM=;
        b=KTefUEapngWVsNmD5pOZt1hMvSJLW+GlgNa3hoW3hl3jhCew2RkTpfQrZDLXfpe0Z6
         QNm3lMEFadrco2wZ/1FJJujetZUWup3pE6afj1I/2HRxn6/ovLKyJvNZHcUCO+UhvTdT
         hc1ggncSCAYFchAYSaHAUVtrLBfrXntYrLKMXSK8F6Hn50V7lqsKX+yjp1QN8IhYoUyM
         0esvavfAFmBUr3NkG1KoFkcry4stSb9lkbgN4JQxZ9e4Hvq8hQryIQZ03kWzE8p4TLXK
         RsB834PoFlOQ+brAkyGbzoI2XRWQJw/EPvglj9BGc8EJIxqxLeL033Csi6dDwOSaX8+k
         Fdsw==
X-Gm-Message-State: AOAM531+vKT0B6gLCUbgZi2ALMhpQPzxWrW3qr5cjzyGtwQOWso7/uFJ
        X7R5vYf1u44pD5NBB/t3V6q1WOHJFG0BwP/2bbhsu0OSOiFOQglQpqXICh/OaqJ6XNvRn2/QTV2
        KIP2ZTzcsZE8EsxxzsMfi+N0xirqvHV/nRHKbg4oMmQ==
X-Received: by 2002:a17:906:dc8c:b0:6df:831e:76d4 with SMTP id cs12-20020a170906dc8c00b006df831e76d4mr1659343ejc.139.1647436177716;
        Wed, 16 Mar 2022 06:09:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFY00Fte9yceTYtdcLIDEMUngEA7Vv2XIZrc94QHM+xHDidA3EN1sRimJG9UK5kh8CSQEOXQ==
X-Received: by 2002:a17:906:dc8c:b0:6df:831e:76d4 with SMTP id cs12-20020a170906dc8c00b006df831e76d4mr1659302ejc.139.1647436177483;
        Wed, 16 Mar 2022 06:09:37 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id mp33-20020a1709071b2100b006db6dea7f9dsm861597ejc.168.2022.03.16.06.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 06:09:36 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Alexander Shiyan <shc_work@mail.ru>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Jesse Taube <Mr.Bossman075@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Ioana Ciornei <ioana.ciornei@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 1/2] dt-bindings: gpio: pca95xx: drop useless consumer example
Date:   Wed, 16 Mar 2022 14:08:57 +0100
Message-Id: <20220316130858.93455-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consumer examples in the bindings of resource providers are trivial,
useless and duplication of code.  Remove the example code for consumer

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml b/Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml
index b6a6e742b66d..dc0fc8fc4839 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml
+++ b/Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml
@@ -190,14 +190,6 @@ examples:
                               "chg-status+red", "green", "blue", "en-esata",
                               "fault1", "p26", "p27";
         };
-
-        ts3a227@3b {
-            compatible = "ti,ts3a227e";
-            reg = <0x3b>;
-            interrupt-parent = <&gpio99>;
-            interrupts = <14 IRQ_TYPE_EDGE_RISING>;
-            ti,micbias = <0>; /* 2.1V */
-        };
     };
 
   - |
-- 
2.32.0

