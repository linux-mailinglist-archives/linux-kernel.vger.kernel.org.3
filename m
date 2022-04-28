Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E654513E24
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 23:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352495AbiD1VwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 17:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352464AbiD1VwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 17:52:04 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E51C0D3A;
        Thu, 28 Apr 2022 14:48:48 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id t16so4487129qtr.9;
        Thu, 28 Apr 2022 14:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gNj5xhufjdWWURKKhVA8TS0GEfIhNVCDlFkshMGCDZs=;
        b=PmdBXHhh9D9paZpt7KH+MTZBO7FfplCu5gvDGPNBV6u7HWX8CzIvrCjJ93VdtX5n9J
         WsUM/O5ef5DTP+l5BhHXBy1D3wgqFm58aJ06ccv4Ha25JaSx4AuD/grlZDcqPIu1uK9z
         Q2rqz7CEBclY6jM62C2anI7sE4wxBbOz/8bSdeLin+NoBjNOzQgeyulCDhV2Gi3tMWBV
         ejEhuK1tCPUIuwuD8GSlQfoDcJ+390I6h2UgU6PXK/unK2TdoMmBn5TODzvwQXLcafHG
         nMlJmItkTa5eqFmDAWBnLX/ZCvO86dFKNDibMF/FAxeX1PJXjsAS4nm41WUgii7j8GKy
         AkPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gNj5xhufjdWWURKKhVA8TS0GEfIhNVCDlFkshMGCDZs=;
        b=i5r6+VxW58UkSMWb68BP6Y2nSSzDFw3H5jwUmYwcNNBVGHLseGx9bfuY2hrZ2/fI+J
         qGA2MfWGPpZyTD79LSDYRBHKzEXX6yRR+ZacKiDm+EhKQ0r5ag0JNVJ26Gm1OnMzx7OE
         gMlrViKKHnLY4focC0JNw44eyxTTRnjofMZoldyW4wYQ5RVe951Si9jUUzu2IzyOmXo+
         RNcYrcyhDzdGfKKIvHEO2q4BkOCwdTa75SaEqnhT+uQlOMDhg0afKyhKTAXqQl1PSqyO
         sAHk5JqA/um6pxOi+/mNG/q0e6aevP+8sOm7Z4bIxCUJ14+RYTEmix0aC6Iut/NgQ9yC
         lZfQ==
X-Gm-Message-State: AOAM532OZqLtDDxBfg1YmU1J5Jl9f6+jrN/eS+LkdoWsbft/pi8lRlra
        EsearB4iwAD0A5pCJjH6t1k=
X-Google-Smtp-Source: ABdhPJx4ld17vXNAFmJUl03CBWUmXcU44oS6P0g+XzkKY75LbMpT0tHeCvt2sLgzHzttchLuvhNc2g==
X-Received: by 2002:a05:622a:cc:b0:2f1:fc74:c7a6 with SMTP id p12-20020a05622a00cc00b002f1fc74c7a6mr24783118qtw.387.1651182527660;
        Thu, 28 Apr 2022 14:48:47 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id bl5-20020a05620a1a8500b0069f51e47c5esm546442qkb.110.2022.04.28.14.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 14:48:47 -0700 (PDT)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To:     linux-imx@nxp.com
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, aisheng.dong@nxp.com, stefan@agner.ch,
        linus.walleij@linaro.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        linux@armlinux.org.uk, abel.vesa@nxp.com, dev@lynxeye.de,
        marcel.ziswiler@toradex.com, tharvey@gateworks.com,
        leoyang.li@nxp.com, sebastian.reichel@collabora.com,
        cniedermaier@dh-electronics.com, Mr.Bossman075@gmail.com,
        clin@suse.com, giulio.benetti@benettiengineering.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH v2 04/15] dt-bindings: mmc: fsl-imx-esdhc: add i.MXRT1170 compatible
Date:   Thu, 28 Apr 2022 17:48:27 -0400
Message-Id: <20220428214838.1040278-5-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428214838.1040278-1-Mr.Bossman075@gmail.com>
References: <20220428214838.1040278-1-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MXRT1170 compatible string to Documentation.

Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
---
V1 -> V2:
 - New commit to fix dtbs_check
---
 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
index 19621a2f8beb..b4d98a9c0952 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
@@ -34,6 +34,7 @@ properties:
           - fsl,imx6ull-usdhc
           - fsl,imx7d-usdhc
           - fsl,imx7ulp-usdhc
+          - fsl,imx1050-usdhc
           - nxp,s32g2-usdhc
       - items:
           - enum:
@@ -44,6 +45,11 @@ properties:
               - fsl,imx8qm-usdhc
               - fsl,imx8qxp-usdhc
           - const: fsl,imx7d-usdhc
+      - const: fsl,imxrt1050-usdhc
+      - items:
+          - enum:
+              - fsl,imxrt1170-usdhc
+          - const: fsl,imxrt1050-usdhc
 
   reg:
     maxItems: 1
-- 
2.35.1

