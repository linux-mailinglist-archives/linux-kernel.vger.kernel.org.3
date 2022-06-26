Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4390555AF95
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 08:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbiFZGpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 02:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234002AbiFZGpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 02:45:35 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0290312D27;
        Sat, 25 Jun 2022 23:45:34 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id b125so4894845qkg.11;
        Sat, 25 Jun 2022 23:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9/ATJOPTaD1P8EZLK/VbrYDbl12rVBmHa/56rNLSGWo=;
        b=SSFo4cuNWz/Va+aJcnPiWub4YlWNZBa/pJ9zmcibII/ECQ9z+OpvKaVpySsZeygNJh
         kdCgLOQQs7mlY+9Jtjh//7wfFff1RFIaOAx4lK9JxnG+oFsuslsMN3uQYaILEHVQAz9W
         HaPMH/jOTuxt858Q2gWo4EqaatwX5HeWclglTPYQPHSMTJbo+w8Kz1ZajHHxYWF70/CK
         vhhtFBsb4xKhxbPvTjt1AslQzbA6mhWALHbm7uJbesTWE7lzVHmY6KdDUQMnvgbSCC3T
         yAoNNdRy58+UWaX6cSPa0hd8nPS36mCT6NqzL8SL2kDaQhxVKy4ougv9zas9opqjYGZA
         bjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9/ATJOPTaD1P8EZLK/VbrYDbl12rVBmHa/56rNLSGWo=;
        b=GiHXHarBTb054QX/iUYObRQpCl1AbdhksTjpxUt7qjIUgco1pLCOt/2BLlTf5f/Kq1
         +aRViIaSx9czG7rAI7+YXaSyT5Tpj6ObLaGGTGPpKpcln866rf2hamHVrcuBXHNbGek6
         IjoyJdUCTAPzRERtYI+ZSF4IYminUt5fgHfGNL4oJCFN8CY4kL76oUFufV3l6pFj+PjK
         IY/i8PFasnp2AsRsIbPQCEzM1Is2KUXt6XF7rxynTxiVs94w4ACR0FHIiMFriYyUSJGK
         BHTQB3nF18+bKuSyXuDAr9EWczJSVs7yhSLhtN4AbneFgIBuAC2xCjaB6PmiaZoD+c3O
         9Lbw==
X-Gm-Message-State: AJIora8MRN7h6s4J5GInwb8Em8/POMGAIWGc/X6sMQ0osiTAhWHcpNPu
        SOBOE1Ry7f+XDwVPDuO1cg0=
X-Google-Smtp-Source: AGRyM1s9lDMe9Y8IBSF61tsA949KDo0prZSLidlM3YPHKX4LwU9buy93PiUcbQG0aI29zMtwNo9flQ==
X-Received: by 2002:a05:620a:248b:b0:6a6:b07d:4353 with SMTP id i11-20020a05620a248b00b006a6b07d4353mr4776257qkn.754.1656225933150;
        Sat, 25 Jun 2022 23:45:33 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id w15-20020a05620a424f00b006a76a939dbasm5914620qko.112.2022.06.25.23.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 23:45:32 -0700 (PDT)
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
Subject: [PATCH v4 03/13] dt-bindings: gpio: fsl-imx-gpio: Add i.MXRT compatibles
Date:   Sun, 26 Jun 2022 02:45:13 -0400
Message-Id: <20220626064523.3683775-4-Mr.Bossman075@gmail.com>
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

Both the i.MXRT1170 and 1050 have the same gpio controller as
"fsl,imx35-gpio". Add i.MXRT to the compatible list.

Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
V1 -> V2:
 - New commit to fix dtbs_check
V2 -> V3:
 - Nothing done
V3 -> V4:
 - Nothing done
---
 Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml b/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
index f57d22d1ebd6..ae18603697d7 100644
--- a/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
@@ -37,6 +37,8 @@ properties:
               - fsl,imx8mp-gpio
               - fsl,imx8mq-gpio
               - fsl,imx8qxp-gpio
+              - fsl,imxrt1050-gpio
+              - fsl,imxrt1170-gpio
           - const: fsl,imx35-gpio
 
   reg:
-- 
2.36.1

