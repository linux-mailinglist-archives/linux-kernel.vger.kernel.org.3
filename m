Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2390D4B43D6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 09:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241967AbiBNIRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 03:17:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241826AbiBNIRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 03:17:11 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44A15FF0C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 00:17:02 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8E5E14033A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644826621;
        bh=bOhlBRyYjdc4olCsTRd9yvmwLAfAPm/hGaoOpjTnzVA=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=bVnnPe6z79LbSXoIzfyudEIXqpop6oVMEsPjJDh0vHony2gshRvemnZEeAJ9BRR0n
         oUK+0dUC5WkhvsyWvH7mv6AU+GrlElxVbIxEkGruewf+62Ug0XwuRHGYN3etHwFMH0
         +S4H+kWqc3RAI5waTxdjSXgR6S1ZRqiS+B8jpBJgK12SbEb9nbpPVW3xyv5mhgiIiZ
         mmq9aqqqoEZE4vTAj08SYvoG2yndMDdg1/958XmG9INnqn9erqDbhaUyVkrz1ULdA1
         OyZTVWyxmKZ9uF7iBBvX0im6EsLyuhaMnv/CckDzYIcjuzKF6//FoDEe9tGxhIQmUT
         kHKTdyRzExw0g==
Received: by mail-ed1-f71.google.com with SMTP id s7-20020a508dc7000000b0040f29ccd65aso9799910edh.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 00:17:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bOhlBRyYjdc4olCsTRd9yvmwLAfAPm/hGaoOpjTnzVA=;
        b=f/GaACRD7i1NmZ3hgTuGfgekcJOJUuS9/X/E3zCZK7dGUv3Z1Bif0TPtfmDgmYWYHi
         AakhvbygD8IwIhKkVnrRePrJhkJdbj8F36JNXss9pskrF51etNVeuBDIkZG/JNSmNVnc
         2zenGrkqtbzSoPNOJ5vG+F4kLR3y7P+jJ4VbLSylLB75YTSviEHV5MIKDi/tW5ja+us3
         rhe7eh2oYAhs+tXFSKjThC7cijgGqMUuIePkPtPGpoaGFSAf0Zs3C2Su+K8G2MjKnivL
         4xeYfggysIpS6tOY1YKb2/IcimzmPAjqVK52LyAVAvTKNfyD0i5MfebZwFzmumovgSQj
         If3Q==
X-Gm-Message-State: AOAM531iV+7YuTa2c3h3yn/jkig7IkjK3ePoAV+arcNf7dqGJOdmRiMs
        GFBHnmffincbpOY3hCHMSlPem5DDPKBjhEbufqNbXqF05N5uCHpAXZy7Sr5sOdADw+nn3kPO9Ts
        uSZ/RmrEMQBCZQIkn1c/HRb8nzgPFdhWEE64FBDoNWw==
X-Received: by 2002:a17:907:f9c:: with SMTP id kb28mr10076887ejc.213.1644826621258;
        Mon, 14 Feb 2022 00:17:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxxVq42SC5ZUR0wG1GQiAhOdCRluJBdfCYPvNoUVrfESuZAlthB1iFEyURnQo2Crc/39Bc5gA==
X-Received: by 2002:a17:907:f9c:: with SMTP id kb28mr10076870ejc.213.1644826621102;
        Mon, 14 Feb 2022 00:17:01 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id t21sm3363642edd.74.2022.02.14.00.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 00:17:00 -0800 (PST)
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
Subject: [PATCH 13/15] dt-bindings: pwm: tiecap: do not require pwm-cells
Date:   Mon, 14 Feb 2022 09:16:03 +0100
Message-Id: <20220214081605.161394-13-krzysztof.kozlowski@canonical.com>
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

pwm-cells are already required by pwm.yaml schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 Documentation/devicetree/bindings/pwm/pwm-tiecap.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiecap.yaml b/Documentation/devicetree/bindings/pwm/pwm-tiecap.yaml
index ed35b6cc48d5..3840ae709bc6 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-tiecap.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-tiecap.yaml
@@ -47,7 +47,6 @@ properties:
 required:
   - compatible
   - reg
-  - "#pwm-cells"
   - clocks
   - clock-names
 
-- 
2.32.0

