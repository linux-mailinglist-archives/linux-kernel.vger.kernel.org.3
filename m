Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D944B5CBE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiBNVXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 16:23:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiBNVWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:22:44 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115A513D559
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:22:25 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 393AA407D6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 21:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644873743;
        bh=2GfdITO+DKwVQsf6qkFkxVmUjntYlwpPLBCNaZvP8rs=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=N1wUlV2NP+3I6QsOFoI106EbigIrDCYLhJOE7G1dH7UWuImHqgHz0FQOAHFqsPHPX
         lAPXdiWD/kNPHwOSOHP0Ct8XHbKIQ+LSkvewAe1jdY8BcqTqCG+MJ3sBEiOMnQvTnt
         unO2YsoIYd6rLAUmMRCh32x8rWJbYl4/1lRSykU1hG+Tb7cQ6tjjRFt4t/0u77hb/6
         nx8JdqG2fzwKgFkdnhcTDu9/DCC0/6jH35IdBwvsM6TovQvwRUBGa8UCGXZF3lpudd
         tc8la2C5DppYUF4FXgSPyGdnqaLBBL18q7IKpORD2tfoBgjy+uIkPPsDAYkWNpJMcL
         K+JPQ1Wel0UJA==
Received: by mail-ed1-f71.google.com with SMTP id g3-20020a056402424300b004107aa941ffso6525402edb.14
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:22:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2GfdITO+DKwVQsf6qkFkxVmUjntYlwpPLBCNaZvP8rs=;
        b=JNb06hjInPMeNwOeOZzkSocDMMXaeZdukTD6cJDF7jdu8OxzU0PwT8NExLV2Pk5Ile
         KC3oCzIGzqoqg73rJyFEwpUIBq7WZJBX4v6Gtb+7K21QlvYm+95Qt3W9GpHLu5yoYqpY
         oZIV8oqcGp1iUqLULTSbXIf/dAzhIPYPd+4Am9o6pcyUno5wTLa5uZ9oqBP2V+kgj1d0
         dE7hJ9S2CU+vWsrHlPd4CC18xJDZGA/hgR2MDgP84HzZwFaoOzwVVORVsiGcuyeEAvtg
         DPFltfWUFaHsh77kXIwLdaC8L2xwWLkZLO34if6c7bFDGNWqFRf5aC3Q9UbNzVKXmGle
         tr1g==
X-Gm-Message-State: AOAM532o29vN1bGmWDNbP/yaQ9hAfjYRLguW36I4fSoEG1Rr+SE90HBs
        2ZFYFZcnDGbwXewqZF0G2v8b7FGgrHyk/D/1CHA4/GY2/8UlHg9nwotxAjG6JsBr/fHR/8cN7HG
        K2YReVd1YqqzYpVKFFhTCf+vrOJC/aI5MfN2qjtEMcg==
X-Received: by 2002:a05:6402:518e:: with SMTP id q14mr795804edd.155.1644873742493;
        Mon, 14 Feb 2022 13:22:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxF3h26z/5uxDbEq+54Opag5L4k/zFtMBfvScttTAdV5Yv9njK8Ir/cF1x90gGCn8KuufGFTA==
X-Received: by 2002:a05:6402:518e:: with SMTP id q14mr795759edd.155.1644873742300;
        Mon, 14 Feb 2022 13:22:22 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id v24sm2327203ejf.7.2022.02.14.13.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 13:22:21 -0800 (PST)
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
Subject: [PATCH v2 13/15] dt-bindings: pwm: tiecap: Do not require pwm-cells twice
Date:   Mon, 14 Feb 2022 22:21:52 +0100
Message-Id: <20220214212154.8853-14-krzysztof.kozlowski@canonical.com>
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

pwm-cells property is already required by pwm.yaml schema.

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

