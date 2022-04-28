Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DF6513E10
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 23:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352462AbiD1VwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 17:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352436AbiD1Vv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 17:51:59 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8F2C0D3A;
        Thu, 28 Apr 2022 14:48:43 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id e15so4501067qtp.3;
        Thu, 28 Apr 2022 14:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KRtH+Wxe02eFiur7ExzdY0+QMUjX+71o2GqJF6SZUAc=;
        b=Els3D1/dqjRgnV6P1/IRv8MixfnbGNrSg11sIlqfezb3oSNVj3hzaUxvTtbEnjM9pz
         zKmE5/sC0pzjao1L/7Gh3w3dG0SdW7Su0/SFaTMk73kZC9nQdnHz2b/pMmcHkh0fOYdK
         9gF5MGztxhK/G1G0jYO44PQuyinv4XhLntGhktl8T4LNfq89W183L5JIyU3iPKDWjksT
         1IN3lrhc410oLiryADmOh1fB3U/Z8o8XTN3CugOqNm50BzHCbBA4lMC01DjV2kb9fBID
         Ms+GJYnuX3pT104r13iPSjOI0cCJ8925M9XO9dhQd0OtCfOg7B9nM4Wh70UPfKzizWBt
         Mt1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KRtH+Wxe02eFiur7ExzdY0+QMUjX+71o2GqJF6SZUAc=;
        b=tIdemmJmhGe09yazk1FB+IPPnO5/vJ10jM+RlZVFBk5GkqOibYE92XLVpHYbBRhsEO
         Dtjmf/FB73g1yU+owdpXNo2X2CcyOA0NJvDG+aQfCN9JJcTS0C42/+evxANZW/+Jo4oF
         mSIGaJVqFYZfOPjg/x45qLpUhqRvOziStF11sXndkf+ybh/lOJ8tKAEZYt9/0QdkCYeZ
         xyXkAgnpz9aJb7nFMh3wrLblMuW9j++UthgQJQxHB/cn+MnQTKoDcyX/YYaa6FFIeAyg
         ++j+G0B9DAuC2XgwG9tT1sceBO7yv0go39CrbRS8d6pvxOkaqE9uEibl90WT1nHouVhu
         MByQ==
X-Gm-Message-State: AOAM532pRlQsz1sIsSYCYibeO89AcOGPKaPu+u8bZr8dtbCD0TzmCnSl
        aLjLig0z8I2K+lhbaAgsC4A=
X-Google-Smtp-Source: ABdhPJwJMaTemA09s72gPi0VsUmQm4Ktuf7tJ2veFfZKW2vPO9YjbEgUH5Nh4wJ+fHmVMtXWZN5M1g==
X-Received: by 2002:ac8:5e4e:0:b0:2f3:5df5:5b3f with SMTP id i14-20020ac85e4e000000b002f35df55b3fmr21753402qtx.295.1651182522779;
        Thu, 28 Apr 2022 14:48:42 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id bl5-20020a05620a1a8500b0069f51e47c5esm546442qkb.110.2022.04.28.14.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 14:48:42 -0700 (PDT)
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
Subject: [PATCH v2 01/15] dt-bindings: arm: imx: Add i.MXRT compatible Documentation
Date:   Thu, 28 Apr 2022 17:48:24 -0400
Message-Id: <20220428214838.1040278-2-Mr.Bossman075@gmail.com>
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

Recently the imxrt1050 was added but the cpu compatible node wasn't
added. Add both i.MXRT1170 and 1050 compatibles to fsl.yaml.

Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
---
V1 -> V2:
 - Swap order of soc's
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 0b595b26061f..e71b981b0245 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -834,6 +834,18 @@ properties:
           - const: toradex,colibri-imx8x
           - const: fsl,imx8qxp
 
+      - description: i.MXRT1050 based Boards
+        items:
+          - enum:
+              - fsl,imxrt1050-evk         # i.MXRT1050 EVK Board
+          - const: fsl,imxrt1050
+
+      - description: i.MXRT1170 based Boards
+        items:
+          - enum:
+              - fsl,imxrt1170-evk         # i.MXRT1170 EVK Board
+          - const: fsl,imxrt1170
+
       - description:
           Freescale Vybrid Platform Device Tree Bindings
 
-- 
2.35.1

