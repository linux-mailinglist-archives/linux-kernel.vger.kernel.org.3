Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89944B5C99
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiBNVW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 16:22:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbiBNVWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:22:17 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C138119F49
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:22:09 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 29F9B40337
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 21:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644873728;
        bh=1xNmK//HjGNaIQp8eaYbachy53dRAmEobraHrPxOQCQ=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=cyfDDj0QyhfE9wY/rL/p54nhFVQtItBOU4Bh1dntQKkiHLilCCB4aA+rcNqYk/hya
         ovIGaYGYQZnJG4B7YRrnWFwQZYUcejFRkg1FNkPvD2O5GMVjiINjDgHPpstpoyf+sy
         OxRlQO51UNtnzklZb/WBLYm2kp/5OcPXpHrg0WUDDU2JJm0+wbv8oV+dJBzImYrfZF
         0p0l1A3v7ijEp8D1v6dCBMjIiuChC/wXDIpDwq8gFzjU5kiUFC8sDGmXsJAMyM4f1u
         3fRJhUk76Vy8HjfHO5LTCOfW9pNsh7lGpq4LyyDFGb2f/5GWFWlq4chdX2tCQcBjzZ
         B3u3SNosJh6lQ==
Received: by mail-ed1-f70.google.com with SMTP id z21-20020a05640235d500b0041092b29ad6so4815239edc.19
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:22:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1xNmK//HjGNaIQp8eaYbachy53dRAmEobraHrPxOQCQ=;
        b=DMsynb6Apc8vTKrG74THlD26ZxnAlgr/Ct/tpj5U6s3xbkF7SHn4zwb2PWaz3mM3j3
         Qs0u+387m5t/pxb0WlzkWP0km1Lj8/YnFoa08ssm5VK6U79K2gSxONPqs1ruILZQld8g
         sXLUTgW/hUgOXSkn/dWAyuHxgi/VI/iNz6z6POkeDTkI48jMn8ceKUBewPskkwcdV43i
         H4Wb2IQ9ptFepl5IWExF48E4HA4RB553gR+k0y4TUWH9T6nUYijHJZ5H2Ml9sO7VFSf7
         kM6p9OYCBFgjyBky7+glwUyj95hziu0p02uB93jRcsWMeAYj+jif0qlIMrid8OGhoP6Q
         Sgow==
X-Gm-Message-State: AOAM532iwDaFYzC/N/2gBRSa3Jm+w3ev9xINiNQr4OYOBYCI4MvCDTa4
        n8sX5Px9AQQ4YS88oP4LmALNYcLoG0gAqSjWDxayIjGoZHmN1jHuvUXqfnJ6Ue6KpMYnkXz3Dcy
        izEdcn1PSvkCJNVBa8YLvGzFYMvJGAxlpynHLnsYe1A==
X-Received: by 2002:a05:6402:2203:: with SMTP id cq3mr756163edb.185.1644873727721;
        Mon, 14 Feb 2022 13:22:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy49BfL0PgnMrV38zW/ZrNuMHV/5GZGb+TKlaJ5NvG8aoL2ex2m6POK5VS+J5aobKGKcLFIQQ==
X-Received: by 2002:a05:6402:2203:: with SMTP id cq3mr756128edb.185.1644873727584;
        Mon, 14 Feb 2022 13:22:07 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id v24sm2327203ejf.7.2022.02.14.13.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 13:22:07 -0800 (PST)
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
Subject: [PATCH v2 05/15] dt-bindings: pwm: mxs: Include generic pwm schema
Date:   Mon, 14 Feb 2022 22:21:44 +0100
Message-Id: <20220214212154.8853-6-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220214212154.8853-1-krzysztof.kozlowski@canonical.com>
References: <20220214212154.8853-1-krzysztof.kozlowski@canonical.com>
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

Include generic pwm.yaml schema, which enforces PWM node naming and
brings pwm-cells requirement.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 Documentation/devicetree/bindings/pwm/mxs-pwm.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/mxs-pwm.yaml b/Documentation/devicetree/bindings/pwm/mxs-pwm.yaml
index 8740e076061e..a34cbc13f691 100644
--- a/Documentation/devicetree/bindings/pwm/mxs-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/mxs-pwm.yaml
@@ -10,6 +10,9 @@ maintainers:
   - Shawn Guo <shawnguo@kernel.org>
   - Anson Huang <anson.huang@nxp.com>
 
+allOf:
+  - $ref: pwm.yaml#
+
 properties:
   compatible:
     enum:
@@ -28,7 +31,6 @@ properties:
 required:
   - compatible
   - reg
-  - "#pwm-cells"
   - fsl,pwm-number
 
 additionalProperties: false
-- 
2.32.0

