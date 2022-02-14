Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CCB4B43DB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 09:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbiBNIRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 03:17:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241874AbiBNIRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 03:17:20 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6F26005F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 00:17:11 -0800 (PST)
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AD8094055B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644826630;
        bh=icQcZ+WFXKpPn99IyrrodPILDL6gHPyC2MLITlx0dJQ=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=I82Yq2+hg0DtcNZi46wLNtmQO7vsr1YNxMRZLPXqt7AU+015LtuC3dXMsy9HEt5Cu
         dkHC3XqyofEyV3xncAdyiBpy6NzUbGm4fV90IE3kO5e3wXzhmPHncVRKNAzt56gS7D
         3FToPArx2YHcILXgu9Nk9JIZQe1EDSrwzh0gX5Nc39X2O+tj9Z1Oqi/6jGbytXihvC
         CfqtLjSKeJ9zqofKycHpIcOiQGXk4SzmyEl1z5NuRZ0th9DSLZuaKuTrJ0hrE8pdgb
         Tp2b3gR7Fy/TznSboNhAdyp+CCyQ8HyE43PR+mU+mMZKf8hesfg92OOrSGfEHWieJP
         UFbvfkpDp1tKQ==
Received: by mail-lj1-f198.google.com with SMTP id p10-20020a2ea4ca000000b0023c8545494fso5406485ljm.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 00:17:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=icQcZ+WFXKpPn99IyrrodPILDL6gHPyC2MLITlx0dJQ=;
        b=YYr2AmJdiZmN8yuOUvD+63AUi1PP/DG8ugrxIOnE0Sr0f+KyF7Y2qgDJAR95OoTmxp
         C969JcboY4jPBmWPwSikEf9EPb3DnKHy/EvdTZfT/qWDggfilnxiqgE90Tacy21xu7Ak
         RKVqknpZV+L93jpOLmUKqXEYRpkXJTomEROhfPgng177NrKT7df1+zViwAzceOo6X5jJ
         K4+BQuz2af1oFV1oNtOC0RVuRnO2iiWblwWS9SOvY/mM9eG2QF2Zc+DKF/XkO4OQggak
         b460x9AzcNnEUGJ6PY+KvAEKtx9GoAHTRGG7rBNbsMe8VANeyzP6EVL2uRCvv4HkeysQ
         gQpg==
X-Gm-Message-State: AOAM532vc99BgF7W6h+xYyKALmzYHlMl62Wci1MWEbFwjsGZO8H+SKzQ
        cOTEEZ7ZMov6CR5ke3V9YTlycdeJmLad6eFTw+b7gX8m5JP8eAEJNTYyI+3zylEZDvsZl+DGkln
        7+GbgepOHLAejudbHzTJjptAm0nXr8violTzsjWutug==
X-Received: by 2002:a17:907:7e9a:: with SMTP id qb26mr1455501ejc.294.1644826619430;
        Mon, 14 Feb 2022 00:16:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyo1kloneuL4CK5f402ZmLsMaBH9PsTCXLm/PAvrgWgzMOv7fXj/4RlM6Dc+vRLwWlSy4wiTw==
X-Received: by 2002:a17:907:7e9a:: with SMTP id qb26mr1455469ejc.294.1644826619203;
        Mon, 14 Feb 2022 00:16:59 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id t21sm3363642edd.74.2022.02.14.00.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 00:16:58 -0800 (PST)
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
Subject: [PATCH 12/15] dt-bindings: pwm: samsung: do not require pwm-cells
Date:   Mon, 14 Feb 2022 09:16:02 +0100
Message-Id: <20220214081605.161394-12-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220214081605.161394-1-krzysztof.kozlowski@canonical.com>
References: <20220214081605.161394-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pwm-cells are already required by pwm.yaml schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 Documentation/devicetree/bindings/pwm/pwm-samsung.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml b/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
index 188679cb8b8c..fe603fb1b2cc 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
@@ -86,7 +86,6 @@ required:
   - clocks
   - clock-names
   - compatible
-  - "#pwm-cells"
   - reg
 
 additionalProperties: false
-- 
2.32.0

