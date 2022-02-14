Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611ED4B5CCA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbiBNVXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 16:23:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbiBNVWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:22:44 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E5413D905
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:22:26 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A3FB04049B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 21:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644873745;
        bh=fQGwcHi8/nTW0SMwp6SpOvSaCBhZUIuzRLgVqfnHG+w=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=IyAge/kNvQDRLP9/loC2G1xfV5l7KXYX5EsT4XeoilVmE/xXI3JrCXecGTskZipbQ
         gmV80hnnxuBCE6Uy8z2KETIa2XrjYH3SXD+llYHn5CLHT1RifFaA45gPo6w+7pcR8d
         Bt2r0iPCLIkJNBt97jBFxnrHvVVmEK1yGHFUem8H3K30d/eXPjxUf8N+o5BpNmqIiZ
         WlOntD+vkF0WSL9m8hQmFTQv1m7AmrCeibIoMhuILMw8UED5teBcBs1ct3qXTWQPsA
         T3X7NHks5b+e0+v6dpqcnHlvohHWprHXfYQjSvkRHROJyij0lx76TbIQYawFX5vw0R
         r/Ibwx9o8S1DA==
Received: by mail-ed1-f70.google.com with SMTP id o8-20020a056402438800b00410b9609a62so2775713edc.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:22:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fQGwcHi8/nTW0SMwp6SpOvSaCBhZUIuzRLgVqfnHG+w=;
        b=aCWECBs7wBtlFJg16Vq+UlStRtbI2bFfTg/Na2y4zPfxZt7FEJ/JQbKv4YOL7iNoTH
         b6DY3eK8z641KrL/7ZMzM/N1MKNw/pz258svsSYua7u0To3jcXv7qYwi8yCN88bHWby6
         6I4W3/qaAERfL96jG7tvLCSj4YOj2NVvqyUiKPK2zVUGOldfC6gYT5wazQIsleYGBpR+
         CskxnazGhQnZ3sBz4nL6autm7zDWLKOHga14OfXKVk8FWvWZSX2iNggLjrCvvQRQc1mV
         5onh+z5sD+tQJJoK2anlN/0PMfIjDrVTvPEtaFoU9jS4WA8S5ag1R9lvU9WSoc8mA5b3
         C90g==
X-Gm-Message-State: AOAM531lVIBdg7jIAYSg4gGudvHwY/NcdP6N2h3XqpGXT4v46Nv99lEl
        sQCJ7bSlr8pQRPwqAINYYaSmEmuGvVUioV7LOpY4FQdamAgZa/p2OT4tSiVQDtLqWUbUjJCmhVC
        8GylGxPztwfi69TzA9I4UmoWYj66iSiLGKVaH7AviTw==
X-Received: by 2002:a05:6402:3687:: with SMTP id ej7mr784096edb.335.1644873734549;
        Mon, 14 Feb 2022 13:22:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxIpInfMiZOfc9K2mvopmHJpGq7HGo1U79elFbaK9u9/4kmAeiVck7Mp6uIQadoSXhIA1gAlg==
X-Received: by 2002:a05:6402:3687:: with SMTP id ej7mr784084edb.335.1644873734367;
        Mon, 14 Feb 2022 13:22:14 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id v24sm2327203ejf.7.2022.02.14.13.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 13:22:13 -0800 (PST)
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
Subject: [PATCH v2 09/15] dt-bindings: pwm: toshiba,visconti: Include generic pwm schema
Date:   Mon, 14 Feb 2022 22:21:48 +0100
Message-Id: <20220214212154.8853-10-krzysztof.kozlowski@canonical.com>
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
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 .../devicetree/bindings/pwm/toshiba,pwm-visconti.yaml         | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/toshiba,pwm-visconti.yaml b/Documentation/devicetree/bindings/pwm/toshiba,pwm-visconti.yaml
index d350f5edfb67..46622661e5fb 100644
--- a/Documentation/devicetree/bindings/pwm/toshiba,pwm-visconti.yaml
+++ b/Documentation/devicetree/bindings/pwm/toshiba,pwm-visconti.yaml
@@ -9,6 +9,9 @@ title: Toshiba Visconti PWM Controller
 maintainers:
   - Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
 
+allOf:
+  - $ref: pwm.yaml#
+
 properties:
   compatible:
     items:
@@ -23,7 +26,6 @@ properties:
 required:
   - compatible
   - reg
-  - '#pwm-cells'
 
 additionalProperties: false
 
-- 
2.32.0

