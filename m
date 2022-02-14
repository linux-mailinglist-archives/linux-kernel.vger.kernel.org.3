Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27FF4B5CC2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbiBNVXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 16:23:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiBNVWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:22:40 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCF713C9F5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:22:16 -0800 (PST)
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8F9DD4004A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 21:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644873735;
        bh=Vx5pgZq+wTDk2cXNM++1rpL4of1cb6TeLTw59n/JqH4=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=D1hApH4IvTlRuugl7ctkR6S5zna8UpA5a7kz0MoOoQxuvxirxMJZnCMEJKj/7Kmmr
         +B0Kw8QABtGEpsAyoJFOPw/z9dEeyk8KII13LbP4vX2Y1gOGrgU5zdg9aZfRgSK+ag
         VnCUaZq/CE4URJ6NtaWT8oNuh/fGq3W7Q3Y7StOHgBa8Mx2j4+0q5tyPkAZxrL6vVK
         Dznj121uEVcmUMKzEMSj7u4bCWRLThY3Sj/r8MWGZXSDxAKlVHcKiOE/pAE4YHTIaD
         bu8e9G2SmiM8ienG8EJwr7HO9XA11shSj62G2Za1QiHyLCpIQ82k/q6J8dK1SUTcqf
         znXt8zrBsuSUA==
Received: by mail-lj1-f197.google.com with SMTP id c21-20020a2ebf15000000b00244de1e4d37so320798ljr.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:22:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vx5pgZq+wTDk2cXNM++1rpL4of1cb6TeLTw59n/JqH4=;
        b=XAofacZMjfJpXFgYX9hJvVykf5L8fsJG9hVVFoWCQDSMs3nAj7iGYKe+XDbUfbukX+
         c7l78ON7S/Xi+/WKa2dmnHY5yi2lTGYJacbeIu4rJT2/MgQJOZ4cGmox9Arfo16z+QD8
         lVVnHAnyzMOqAhkvAyaZsUqDWMlWACh9l3IjsxxIZ0tfu9eOV+FH/Htd7ee96Aj5Xw22
         KQ++DjopjLoHp67f+Tq+tCdeuKPhX4ShHmog7/825DQKsNORv7F5ojrhJkjZ1vIjvXqj
         Smd6v6ELEWp93TqCMQvQcJD1y5et/lCLV0M4twp6X4n1octssIRArjkTR/1fvkDTH/n9
         PSaQ==
X-Gm-Message-State: AOAM530c1M/t27mjnws8cZ5j4R2UyTAZtZNUCgn4W1tQ3ZfWZ8O+Wb2R
        99h5xuR2HOeiC5JoXGFZVYu9i5akfg0E/iXpnIpVagBDtj0VO4pRp9yLdqUD/SvDHN7VV9g+T+L
        Og5aqU9FJWvX54qjTXAQxxo+rI6YvjYksaRRSy1o95w==
X-Received: by 2002:a17:907:d17:: with SMTP id gn23mr511680ejc.719.1644873723781;
        Mon, 14 Feb 2022 13:22:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzn9EFz2R0CbHcclhbUA8j9QL+yRr4fQpPA+X8j3jV9fWd1mKh939ozog2RabglBFb1m4mDQw==
X-Received: by 2002:a17:907:d17:: with SMTP id gn23mr511652ejc.719.1644873723619;
        Mon, 14 Feb 2022 13:22:03 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id v24sm2327203ejf.7.2022.02.14.13.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 13:22:02 -0800 (PST)
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
Subject: [PATCH v2 03/15] dt-bindings: pwm: intel,lgm: Include generic pwm schema
Date:   Mon, 14 Feb 2022 22:21:42 +0100
Message-Id: <20220214212154.8853-4-krzysztof.kozlowski@canonical.com>
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
 Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml b/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml
index 11a606536169..59d7c4d864c1 100644
--- a/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml
@@ -9,6 +9,9 @@ title: LGM SoC PWM fan controller
 maintainers:
   - Rahul Tanwar <rtanwar@maxlinear.com>
 
+allOf:
+  - $ref: pwm.yaml#
+
 properties:
   compatible:
     const: intel,lgm-pwm
-- 
2.32.0

