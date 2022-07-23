Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35CB457F047
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 18:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237837AbiGWQFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 12:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237240AbiGWQF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 12:05:26 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B1F10FC8;
        Sat, 23 Jul 2022 09:05:23 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id q3so4624820qvp.5;
        Sat, 23 Jul 2022 09:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=InRXohvCnMAhmT8u+oEgogA0v2wkFEAz3q2k5R/fqSM=;
        b=GgUat65VKsK0ZfRj3q0oBW1CkoIxu7E+MrqgpBUEm2grTGs4eOFzTDGV6ULXDRIgwG
         HAbl1U/fHF+h+Wq96YysjLLqZFfen2ImAAjHbqzYNc+T2Fl6Fe6YPsnilshk+f8rEXMH
         te/1Ef5Rlfw9d7z6TKt2anIYBnvjN/NpXu24WhOPXE3sKw0275znEekL9CpGbF78EtkK
         fMbQFA2e2kF9Pa3CNgy5eGWhOZQ804VywFTjvwudP8eIImO/mQ471l5IXGVWYntbJhNV
         OVavlOfcCyd2LfoGE9LEi+/HUOhVeBE4tFYknVTriYkZvf4C4X/EjCLtmCcafZZtP3Vo
         tVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=InRXohvCnMAhmT8u+oEgogA0v2wkFEAz3q2k5R/fqSM=;
        b=JFsWMJhpwgEjrmzk++mS7FZDa9/kFXMSC4cIruFeBz7rJw3mTd/J7HQaI7Qk7a32kN
         k78+NNRGdErPyiHLLoGtH9WSmr7TBG017lZOtGfqTMXHySiH/+C8LqGn52Fbm4KHQtsf
         Qg3KmL3l0ELTSohOlqZ2JXmr+b7h4GIWnbn0bcetZVYMs0zCPC0onlyyjhJXZd2id3Lp
         0O940XfHyD5RImoeSihspFtyDESWSQAl5REZnaiaqehIaEc8i6uekuJEBvQjC0egLG7t
         hvGv2Sswf5f7gXYRkmHZzMPOVyqApHL5pu9j6q2OCR5Dr5cKWBZoEE1p0kd0pnsyF5Ke
         OPvQ==
X-Gm-Message-State: AJIora/cDRh8PAtVaCDj9AdrrDJenjeqdeKgK6RxmXPPaBRLdiohzXae
        Yja5sU+F0N0wHTaeTaYl1M4=
X-Google-Smtp-Source: AGRyM1vw/+m2KQwJeidQXdDWly0QGmIWFNzrcAVU3JJcEdM246sNweIz4yvWIYO6yOqG2saax+vE0g==
X-Received: by 2002:ad4:5c62:0:b0:474:1267:14fd with SMTP id i2-20020ad45c62000000b00474126714fdmr4439378qvh.68.1658592322732;
        Sat, 23 Jul 2022 09:05:22 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id g4-20020ac87f44000000b0031eb3af3ffesm4935046qtk.52.2022.07.23.09.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 09:05:22 -0700 (PDT)
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
Subject: [PATCH v5 03/12] dt-bindings: gpio: fsl-imx-gpio: Add i.MXRT compatibles
Date:   Sat, 23 Jul 2022 12:05:04 -0400
Message-Id: <20220723160513.271692-4-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220723160513.271692-1-Mr.Bossman075@gmail.com>
References: <20220723160513.271692-1-Mr.Bossman075@gmail.com>
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
V4 -> V5:
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

