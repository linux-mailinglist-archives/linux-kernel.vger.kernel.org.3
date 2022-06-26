Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2708855AF8F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 08:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbiFZGpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 02:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbiFZGpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 02:45:30 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8B812D27;
        Sat, 25 Jun 2022 23:45:30 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id z7so4934987qko.8;
        Sat, 25 Jun 2022 23:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XPwvFn4gTkB+GSZLzmKBMIR4IEDTnzdWDg+gFOWjMIU=;
        b=qL0/NO5eCmPRXxlD80EOXkVV3++bq/jTIHxvhVJQ9uHdNE11VcCRx8pYtAQimiqIBP
         8VDhe5yG+QtZrpCMZWObZ+AvBg4HZWmqtDbjeIQkAt07mY25b6fec+B6EWJjgdBXN0HK
         C2x1iWChvG2F1B9iRsbun2VBOYVAAIQ1767FH1tcTmHPFUWdSpfZgJciMAlkaxYeAo30
         wrn7bUL6wbiFkiCGMsxd9OygJTZTAu7LHafbAdDJIDMvKTDEs2Lr79wJdxFhY6U2Hu1z
         vtzoOBs7mZUgZITX0FRjtPggsXl4Kj7HLBcOXkuNVDW6HofWQt6xXhcsSmI9Fw99JJG/
         oz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XPwvFn4gTkB+GSZLzmKBMIR4IEDTnzdWDg+gFOWjMIU=;
        b=x0pIC4LZGMssfybixPguYalbeSCK9NU21Tq6cS5fjzJHesMS3iTPVjAUYdj3y+GrbU
         Ds0ZiAUhZdr0ddId9FvyeX5sCnS2Ldn14Ro4wOxumA0DVuaEydLVFdADS7GlkD0KMStH
         YUQjCcgzp/1WAV0b9mWgYFfLz/sQo68dvsJf6SMpON5YA4+RSKlQphXWu725n+BX19u+
         /8O9+0ogrFC6Jsa8G8xf1wE76HEWc/D0yNJpb0uBC3hNtLS3m8wpihOQn1Lhxz+GTauz
         4mKLXnUkYsBW8GukgYF3shKEVYBWY9RcY9CXsglqdfZ3BBhNm41juEw208l/XIk0zo7y
         SgwQ==
X-Gm-Message-State: AJIora90wLTZBQYq+djldSsWSfF9EEtw+Xf4sqPVec6G07nys+gtxl7L
        YJ6Ml7oK0Xk9BOsW0yperLc=
X-Google-Smtp-Source: AGRyM1vXgqpWs9NIxH037urX2oQSo/odVk35HI+MeAB180KTrJABQMCzZJGYfa5xT/vkb3pRve92Aw==
X-Received: by 2002:a37:b487:0:b0:6a3:2a76:2836 with SMTP id d129-20020a37b487000000b006a32a762836mr4691934qkf.352.1656225929180;
        Sat, 25 Jun 2022 23:45:29 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id w15-20020a05620a424f00b006a76a939dbasm5914620qko.112.2022.06.25.23.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 23:45:27 -0700 (PDT)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To:     linux-imx@nxp.com
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, aisheng.dong@nxp.com, stefan@agner.ch,
        linus.walleij@linaro.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, olof@lixom.net, linux@armlinux.org.uk,
        abel.vesa@nxp.com, dev@lynxeye.de, marcel.ziswiler@toradex.com,
        tharvey@gateworks.com, leoyang.li@nxp.com,
        sebastian.reichel@collabora.com, cniedermaier@dh-electronics.com,
        Mr.Bossman075@gmail.com, clin@suse.com,
        giulio.benetti@benettiengineering.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 01/13] dt-bindings: arm: imx: Add i.MXRT compatible Documentation
Date:   Sun, 26 Jun 2022 02:45:11 -0400
Message-Id: <20220626064523.3683775-2-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220626064523.3683775-1-Mr.Bossman075@gmail.com>
References: <20220626064523.3683775-1-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently the imxrt1050 was added but the cpu compatible node wasn't
added. Add both i.MXRT1170 and 1050 compatibles to fsl.yaml.

Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
V1 -> V2:
 - Swap order of soc's
V2 -> V3:
 - Nothing done
V3 -> V4:
 - Nothing done
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index ef524378d449..875f136010ae 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1020,6 +1020,18 @@ properties:
               - fsl,imx8ulp-evk           # i.MX8ULP EVK Board
           - const: fsl,imx8ulp
 
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
2.36.1

