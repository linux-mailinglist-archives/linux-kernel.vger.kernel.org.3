Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CB14B5CB0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbiBNVWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 16:22:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbiBNVWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:22:41 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DF713CA23
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:22:18 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 381023F071
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 21:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644873737;
        bh=0Dk3kP2LcmOur99Xj+FmPMKKDcu6NdY88HV+BhS2v74=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=eFwOoAXLEYiG7vTg27HLDo75s3mWU3cJxFjn2l6kVIPZQ5nJSB+OEEBhtvKHB7Jhu
         AiHEyIVSK0g4Me+sFluP+uoVEVGexnXngmORRPF63mGnEw5rYM3w5CNfvONtK5NhzW
         Lic800ncXk9mKRNWqGn539fohtxEZ2pojPwUh74oisVFZpUrfsphPSLneh+OwoOi6u
         lk1wB9oU/t0APi2YRbZ5Touef4DO+K+odBBc7Y9yYCGjQCfkwzsnLROsOK/OXXqxH3
         PGBO/Apk9QXFeleYgupd3nIiqGJ5B8ks/LiStsB9vTGjbzWFmwqhZlXfKZMdb4HUXs
         YqlyG756NRohA==
Received: by mail-ej1-f72.google.com with SMTP id l18-20020a1709063d3200b006a93f7d4941so6426640ejf.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:22:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Dk3kP2LcmOur99Xj+FmPMKKDcu6NdY88HV+BhS2v74=;
        b=LLzFkUjoQNaU1YqDUQ7A0heIWztJsVvPzxAvKVGi4Dq41Ks95jjK1JQ11rIxRv8RD/
         sb3Ji9RSdCkaFA9mZKgQN+WqpGlJrQXatWSFosn94oqZNEkFIbZv3ygX3CeRztkeh7vo
         s2ATvwSVRaY8xlP8YBXMezOJalhQH4DhYm74vmTOOwDgItWOHkXVmyawHfSSGJQIaBry
         fqJek1AxyAszwb8WtAfehBcClc01OZn9E4lSwWDO7Niqmjn6ybbYjBNirokn+74H00Ib
         cff0ZO1A6oXDVb+UXsRNDa11loVTcVR/FTHlvkr9SZWsPBzuZge9C7x4QlT3GM5TpnEB
         hf2A==
X-Gm-Message-State: AOAM531599q3HlB55IV/zRSSeB9C1OX+lYGBsZF7QrqGIB2F+5gknqNc
        fTl5F1lnl7V1VCisW9832ERbiUfPhgXIE60e7oPG9eiGQKV/Q0ll0r8fzWl6MAYdWKzuLWB2E7Q
        IiduqP3AHHAWxT+jCtc1NhHboTLi/qqm5dsvNqMWMGg==
X-Received: by 2002:a50:eb46:: with SMTP id z6mr774697edp.229.1644873736958;
        Mon, 14 Feb 2022 13:22:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwqQkxT5GkrKkpkI1jpRkimV8tYbLj7FNI3K2NGaV+hzyOeRr8raElR8r83H6B6TAN4ZZ/sJA==
X-Received: by 2002:a50:eb46:: with SMTP id z6mr774682edp.229.1644873736779;
        Mon, 14 Feb 2022 13:22:16 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id v24sm2327203ejf.7.2022.02.14.13.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 13:22:16 -0800 (PST)
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
Subject: [PATCH v2 10/15] dt-bindings: pwm: brcm,bcm7038: Do not require pwm-cells twice
Date:   Mon, 14 Feb 2022 22:21:49 +0100
Message-Id: <20220214212154.8853-11-krzysztof.kozlowski@canonical.com>
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
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml b/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml
index 4080e098f746..119de3d7f9dd 100644
--- a/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml
@@ -28,7 +28,6 @@ properties:
 required:
   - compatible
   - reg
-  - "#pwm-cells"
   - clocks
 
 additionalProperties: false
-- 
2.32.0

