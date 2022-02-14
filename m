Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10AB4B5CB9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbiBNVXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 16:23:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbiBNVWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:22:45 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF93B13DE15
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:22:29 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 736A6407DA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 21:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644873747;
        bh=nq4ij651Faznv2JZt1q1SNPJWaeI5lkTeLdPO5VR/U4=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Pp1ZbmNugIyIdEKY9w7eL7ZciDhFkj6T/6mXCMtMqbdd/rF5rrp1P1e4uQ85addhm
         EgHhuLqQ8CAyqf+U1ms1AicMOLk+e6ZdewH4q7Grj8UpJkTp8/54m1KJ6NVIF3CIol
         ZdbRNnCr8Rp9qm+Cgb3yNzHAaEuQMWQ2PGTYbOZ5/EmGuNLaycmWfpvWwCBnyCel4N
         RUPxTAKXbHpSYaIL5oohdbA6kHJue+w+/m6sXDRCc/F4uZ7IBX5Y/FeDzc5dvIHg/2
         x5LYI0puJAxc4m0ST/N3sYxk80fWeCwN3RQZfkC2X2JbmdyVmv085VqKqDkuyyZQ/9
         Cr0b86xBZ70aw==
Received: by mail-ej1-f72.google.com with SMTP id go11-20020a1709070d8b00b006cf0d933739so1312899ejc.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:22:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nq4ij651Faznv2JZt1q1SNPJWaeI5lkTeLdPO5VR/U4=;
        b=t/EUo8v4JPhSeWJCrkAvmQJwpXtFCVrqpzjpdzb+ZlnRKWVy6SOxIkub7/K3RfkGgO
         xijElkIrfN0BFCPv71z2V11ZHtvTSUtZIibJoBT3JYvd5k2fIRhkhy44YzcYqdQlNUZb
         yEQpWKJlCqDojw1VZ93GepceruvQoQjdUyP1tKM+fh6uSiowDXd7+R2ummjoeRfFS4gi
         Jxa98opy2SKdnkTlfWfkQHdIqwRD0kDi3xiuupkqcYq6dTWeZ9n0j/cRriiXTBJp7y/n
         BxY/r4nUWqSJDNpS15K7o+W8MNtXuPXV5bGKEFjGdGon7jTSX4WuBujPfsrydM+bIRfI
         +l9w==
X-Gm-Message-State: AOAM533cGg8XwmKIAOwviAt0EqXW0oZd35wpcZ6S5ZdGTOx4yT0Gb+wt
        0nsTDud3fAtYrfDLZQx1+LTR9nzIxhrpcyvPxNsCnonHakAHteimgHd2PtyGUGmvXgtv8JzvbrH
        +5HOM5KiF/dIXsaTgQ0HD2OATpCEP3YTUgnqqEEDp+Q==
X-Received: by 2002:a05:6402:298a:: with SMTP id eq10mr800857edb.71.1644873746916;
        Mon, 14 Feb 2022 13:22:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz80Pl7KOImaUzcJEjp8kENwO8sBpFHNKeJMvOW/i73kktJXPrP1OEMsEJv+HrKWeHE8aPXYg==
X-Received: by 2002:a05:6402:298a:: with SMTP id eq10mr800841edb.71.1644873746761;
        Mon, 14 Feb 2022 13:22:26 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id v24sm2327203ejf.7.2022.02.14.13.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 13:22:26 -0800 (PST)
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
Subject: [PATCH v2 15/15] dt-bindings: pwm: renesas,tpu: Do not require pwm-cells twice
Date:   Mon, 14 Feb 2022 22:21:54 +0100
Message-Id: <20220214212154.8853-16-krzysztof.kozlowski@canonical.com>
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

pwm-cells property is already required by pwm.yaml schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
index 1f5c6384182e..c6b2ab56b7fe 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.yaml
@@ -68,7 +68,6 @@ properties:
 required:
   - compatible
   - reg
-  - '#pwm-cells'
   - clocks
   - power-domains
 
-- 
2.32.0

