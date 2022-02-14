Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651A64B43DE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 09:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241971AbiBNISC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 03:18:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241940AbiBNIRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 03:17:34 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB9960A87
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 00:17:18 -0800 (PST)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E4DF3407BD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644826636;
        bh=iIyJdPXcEBkqUXDuGqxhbnQvntH0bGkCRSvxS5pcFZw=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=ObP+wGnSqWy+WY4XVmoIK5yH0/HGRiEkHV1HY488VCKMHdNl5FXqBX2N5YsPXJWkl
         /eA2r3BTZY8pGbRfg007TBIiR4HnMP5dxNpU1JfHixHV02ZJ+0ullZBish4cvmotek
         6P090wr7H3uJ4FjMJUo9W2wlYnuOAuoTjXPuW0QGVChFZJvX19VyZohjVAEqilSYgu
         +mO0x036Keca3GkeRe1aZGgWPOqc54xvtH3zJgr7bGuR7f/0MwuyIE/J+hZpnoFJ8q
         BbTlLPzru4HG0GAnb3eZkksUPgAInFohbsGyqXNIpCRKFObn+bQsZVA2OZMBNWoBKh
         q8R7NcReFQqbw==
Received: by mail-wm1-f69.google.com with SMTP id n26-20020a05600c3b9a00b0037c524e6d97so1664782wms.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 00:17:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iIyJdPXcEBkqUXDuGqxhbnQvntH0bGkCRSvxS5pcFZw=;
        b=qx3yBAW3o+addXJpYbhVNmJ2LQbPK5iFvp4lrfeCL82c9MA/q1aNc9GL//QB9qRkvw
         wRWySJJZC97KMPw9pvpdG5y4gDEeVsAA4HGQE2XjfxxStcZZO/UIMXDQbj7940EjDW+g
         6Igm/ujQs8RyhtrpAuYOfWJVSQHk4/C6qTlOzjy9ovtqtf8SGMVgwwdB+vslvvvvJFg1
         X1Wn3DzH3OzVhvgD5goYwtI8zv8cT+5jFHV3kHPTsEJWbT/b8NLa1vLyV5knsrwVOF/o
         7kRaLDV/50EZoEE2jf8StpNgexx55S5SKjt4UDk02i2vLKIy1qMKBg2ssamxw4eHSp9A
         o94g==
X-Gm-Message-State: AOAM532p932Je54VuM5csgsOXJmeKBI4MKyRs0kEaXOWIMtHU8hLcP9O
        YAIZwiroi6leIMGCnAHSnZEqgOtN6tH3F76o5ga7Z70FMDyDabfEZPKu8mcfrL8E3o0qKvl1n1a
        HOSGaEixy3sk2I+dU4+75kwL5i5kUnc1zSA2q0un+Ng==
X-Received: by 2002:a17:906:7482:: with SMTP id e2mr10548212ejl.84.1644826626194;
        Mon, 14 Feb 2022 00:17:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxq33v0frVviF6aoq/yzn0yigEhIAPUAXD+ZluCWsCIVgJnTB15DwsxtEtp09CYMHvANYnT6g==
X-Received: by 2002:a17:906:7482:: with SMTP id e2mr10548195ejl.84.1644826625992;
        Mon, 14 Feb 2022 00:17:05 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id t21sm3363642edd.74.2022.02.14.00.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 00:17:05 -0800 (PST)
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
Subject: [PATCH 15/15] dt-bindings: pwm: renesas,tpu: do not require pwm-cells
Date:   Mon, 14 Feb 2022 09:16:05 +0100
Message-Id: <20220214081605.161394-15-krzysztof.kozlowski@canonical.com>
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

