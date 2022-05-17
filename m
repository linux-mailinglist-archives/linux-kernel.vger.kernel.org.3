Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5FC529815
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 05:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbiEQD2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 23:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238833AbiEQD2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 23:28:08 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D30B3FBE4;
        Mon, 16 May 2022 20:28:07 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id u3so3277578qta.8;
        Mon, 16 May 2022 20:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=84f7g+sKZD602ioxCC7MVO7dlWOosyB1/zCeUUmzgMA=;
        b=lFLHS18+GVAOIAqYThoD6Zu7gdvkvkMUumPdXCYvPBKgNi8tyJf3Ki7gVHjdw0+fzz
         j9fM7F8rUI6tjL9aP2mBveTye0TA82rHeRb9NQcESGFT3gQSC3Xc891R+oGxsONNEJ+h
         C3GBa7w2I4gpOqkETq3/rpRQpbUL7YGg5zfQuRNBgJGsgjeEkI7H2T3l/wBrNC+4j4Nc
         a0gWPCksFwVa3/l5DcKv7/fxQu7ZcRDJDUzJIaW5P/pG4Qn7zyaX1D0/779WW8s2mH60
         KfG47N3BCxMDx7OC/oxpgEI4IiV6h/uVBZKiioYK3pEKejO74egBCLGtts/pIwvrReRk
         wIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=84f7g+sKZD602ioxCC7MVO7dlWOosyB1/zCeUUmzgMA=;
        b=rInYP0IlViflhzYmop2d1Fht9WMm4kob7l62xPb+y694H17Vq1/OdRNWxjhIXpmHB6
         Lg+7LMXIjzOsEcuRzT3CZ8vshazdzux2cl4K9q7XdhDABHb8ZnpWAflMlgb8Mqn5a1Qx
         SW0YLmxGagCCf611qqlx5dq6j5fBEMGJ7GQxHoxKD2/pRTF3hWWK6mFKGe1oRhpE21cq
         y2s5pXSS/SXmIZXGmUk2DUZy7z3bVR3QorTi8XobeDvvYUGLSOYc5AfJ67DFSTW32SIu
         JJT49MwgDjqSBzGAeP6cD1h22a3rSwf4ugmpUq6/i1ap0lySaaBDcFjtVK3YtISowy0X
         +qVg==
X-Gm-Message-State: AOAM530xM0A/Qwm8LrJmQYpBK+GxlFa03QgoOOygd0Os5DnPsqpWYDAi
        cNxek6S1wRxK9U1SR+HSokE=
X-Google-Smtp-Source: ABdhPJw8lWYwiVEnRBZ3Ohx3GjhUJ8BlrFPzW08cqADkSUD6tRFqVPvFGAe1xP9GtKJbhFUrYSgyLg==
X-Received: by 2002:a05:622a:293:b0:2f3:b483:baae with SMTP id z19-20020a05622a029300b002f3b483baaemr18130441qtw.111.1652758086483;
        Mon, 16 May 2022 20:28:06 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id a19-20020a376613000000b006a098381abcsm7079535qkc.114.2022.05.16.20.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 20:28:06 -0700 (PDT)
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
        linux-gpio@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 03/15] dt-bindings: gpio: fsl-imx-gpio: Add i.MXRT compatibles
Date:   Mon, 16 May 2022 23:27:50 -0400
Message-Id: <20220517032802.451743-2-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220517032802.451743-1-Mr.Bossman075@gmail.com>
References: <20220517032802.451743-1-Mr.Bossman075@gmail.com>
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

