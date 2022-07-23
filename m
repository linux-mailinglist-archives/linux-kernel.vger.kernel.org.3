Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F2557F03C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 18:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237496AbiGWQFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 12:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237328AbiGWQFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 12:05:21 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD21FE097;
        Sat, 23 Jul 2022 09:05:19 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id l3so5677918qkl.3;
        Sat, 23 Jul 2022 09:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/eLH0yog0Bw3hBDbRM0s90v+9InNOx9Xe/vOmOIYLbo=;
        b=QsvevnAfSaOAESS2pqob5ExJCfuhq8ERdGh1JIbzftti/uF5xgwFd66/BtJ5xKA8iG
         wM1lzri4ASIdyvHxC0+N0QRJJoGzq+OcGZbgOCimn0ynAzTeDHEQ0uYbdnAfbGZBFFHh
         chy8nISvhn+kINVzn4Yb62GTQnu+JqjCIKpGg0sObm2DCOdMAjg6PFJbpK/FVDTpPl5E
         7veMxkmRV6P4p/GLwhyzC0lF84u2EcRWs57zCKFtpCFsX6TxtyteI64WwcFlQmM3av2J
         iut/TJjomjkiwVdqDi10AkpNBgAgsO5iQjfD5eQO34/qx9OZFZrkOE/HplVVkRivfVOv
         nAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/eLH0yog0Bw3hBDbRM0s90v+9InNOx9Xe/vOmOIYLbo=;
        b=2xPggzAUjER+Q6XaJFXn7Vyw6UPVd+jYp7Qy+Ncnd2SS2IbLHv5np6kgpEABq2cP9h
         weNy1MYGqCXfxGlkLsSyo1kY9Zn9+pUtNRx2O74NObjFRpZ5TFcIsiQ8+J+7k97vhSTl
         96ppSsLbX9AVv0/D/6VobL29U2ty0ONB55/YZJsRRVsDpd4aZQEb5U/TjkueO4YLgblY
         WubX+kjLbqtUhvnz9gpfdyRjxf+FM0me7lH9PFyuyha6aK+oJVprvrhBge5wEX8+ygAJ
         FBr6OzXflfvy50pG7NjpsjEV0lNvyl0t+5rkMyVC8IjkJhe0G2GHyb4DlZ08CYIXB9wl
         oOVA==
X-Gm-Message-State: AJIora/t5hA8TvDxE5pu4mF8obOK+1blcu0SJsmzfzuYrB9JOp6ltS/8
        3HzcqqGcGmfV5Ah6cctX6t4=
X-Google-Smtp-Source: AGRyM1ugzQFqbvUOtNQn2VtC93LwY/YIDuaLe/OWEY2+qiBkxiz65vTaYQXWhERPI4O+ETyOey2WJw==
X-Received: by 2002:a37:8a44:0:b0:6b5:f371:a183 with SMTP id m65-20020a378a44000000b006b5f371a183mr3853203qkd.492.1658592318886;
        Sat, 23 Jul 2022 09:05:18 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id g4-20020ac87f44000000b0031eb3af3ffesm4935046qtk.52.2022.07.23.09.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 09:05:18 -0700 (PDT)
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
Subject: [PATCH v5 01/12] dt-bindings: arm: imx: Add i.MXRT compatible Documentation
Date:   Sat, 23 Jul 2022 12:05:02 -0400
Message-Id: <20220723160513.271692-2-Mr.Bossman075@gmail.com>
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
V4 -> V5:
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

