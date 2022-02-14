Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72D34B43C8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 09:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241807AbiBNIRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 03:17:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241783AbiBNIRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 03:17:07 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED415F8F5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 00:16:59 -0800 (PST)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9ABA6407EF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644826618;
        bh=1xNmK//HjGNaIQp8eaYbachy53dRAmEobraHrPxOQCQ=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=VgUpz3G6IocMENdvwALNwgkotcbxG2+sHO0hCMzYRO1xEY+hFVoVv4fvA1c8a96Wq
         HmkLTg5R14pdvDzCgNQaeFZaoHsx0cpkorsaiDGSSCm6k+kLsrNERCZ/G6gUhcI9Mi
         QZ4EpJLosRW5g3YHr1TueLn0Giu/Av58ozGyemb0j2yhvh6kQ/s9SsyyiGFma5O88b
         S9XVtlR+6NmCIZUWF+pdswOlmurWPVf9tODmKxai/ZqPpxqwiW0XE4sfP9ROxoD3In
         3iqsSntpyfCCVugOx2yu3WqLXKByuUMtRdVSTUHM6B3owNufy5BBOxwbqpxkTcy00G
         7FAL+1DEVQtyg==
Received: by mail-wm1-f70.google.com with SMTP id p2-20020a05600c430200b0037bb72b5865so1435751wme.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 00:16:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1xNmK//HjGNaIQp8eaYbachy53dRAmEobraHrPxOQCQ=;
        b=6GmcjViC77qV+R6pwo/8DlJ/dqXDwkrue5OApKf+aOt3PxVPF8hXj+TraLx3OXZCZ9
         f2WQJzYgpLY2o5XCoIfxZbwsABgGrdddz186MD8CZrTyD+2FfpFKOWkH206zkHvo2SVN
         ffXaLY36ZHiZ7MxWoAwzqOFrQvhq4T1xST1B6FduYXE7CtaZ151nzXoR8EcAaC2PnIwZ
         x2oAou1Q/ypS9HOoOVxTplUt97l0DP3M1c7yFX8Sm/UZmW+6Gqkwwt0fClFoLLHprFYV
         HEud7l0o45T4FiGtEWoTpUBSUDWbwsvZyxh59eiWlZZqKbvxu/ZUz0xwDVwBCqqOcE3t
         rlzA==
X-Gm-Message-State: AOAM531zqXt68+1iQeGY91lFgHm7ZAzBnG1PtsjDcW8tJPm7uNxuyzJx
        QxWuH9ZOZuKRArjSYaABmn0Kx90sgyU+cajfhhDgYGgb2YEoPe9OFW6IE5k4zZgvVg0ZTkSQZ30
        mIDTO83CisO7oSWI57ZfXMmDl2zb4w+bwxiQ6XBQjqQ==
X-Received: by 2002:a17:906:29d:: with SMTP id 29mr3045158ejf.183.1644826607514;
        Mon, 14 Feb 2022 00:16:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyFwQjCgryJA08f/ZPqu91gByLS1lXUPn3UYgvNgieSyLAvCFuIrk9GLlp5SVzdDUHhPKf2qw==
X-Received: by 2002:a17:906:29d:: with SMTP id 29mr3045116ejf.183.1644826607316;
        Mon, 14 Feb 2022 00:16:47 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id t21sm3363642edd.74.2022.02.14.00.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 00:16:46 -0800 (PST)
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
Subject: [PATCH 05/15] dt-bindings: pwm: mxs: include generic pwm schema
Date:   Mon, 14 Feb 2022 09:15:55 +0100
Message-Id: <20220214081605.161394-5-krzysztof.kozlowski@canonical.com>
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

