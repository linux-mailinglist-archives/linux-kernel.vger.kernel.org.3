Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E9C5A9F0D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 20:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbiIASd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 14:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234017AbiIASdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 14:33:51 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1544A7E03E;
        Thu,  1 Sep 2022 11:33:50 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id g14so14138160qto.11;
        Thu, 01 Sep 2022 11:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=xKw4P8rUJGfJ1IRQYdJ5k8rUl4OjlTJzuus/Ip46sKI=;
        b=YtM0VaDKMElA1TOmURomZsGvaDv/RfT4YnUMKoGo4l5v4r10ZQkpelL6ih1RYWUFgb
         hiZq8JR0Jjx5RbiLnXfnuOPgCUglfgmsGtjb5ynMvke04mZjpCFFyYeGX/yyLGyOaLVl
         y1VgZLo0ECMrIIbnF4N5pZ0mSl9RZJeBSzlSRuG0OUkWf1flDBg8vJL3P9/mHPLhVi9c
         pYO7yAxEo0HljoXiYfGWkSVOdtritmVzW0VYh5m9LmJfA+g9zdLLn0G9Y/N15pq69Orz
         yPFcZ08XteQrxN2ZnnGb8RUngQLrB/WKirqU1QgfFJVVCpny3a2F+y8O/K8AkN6aJZ0B
         21mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=xKw4P8rUJGfJ1IRQYdJ5k8rUl4OjlTJzuus/Ip46sKI=;
        b=3tXc+TeYtC4jyFQ8THmq1yqRMNUkZ7V8tVr73qToEvbetyD4cDdT2Wy1gIRABf+tht
         TPsZUWjGlBzb553qqmrSly86Msh5r/io8VrDfwIsbLwQrk65Uta+rmeMEUxdR8vzsHcj
         ZesDDUhZlFAa1HoyzLNR3waf2s+JO6MUs3RIDUkPAcsjs6yCMZ4Qzf/N+wwlX+Ggp1do
         jbXe8uWybhncb2zpfOG2MiMSCtiadPeqRp8cxKLSKLv+gS8zC13Di1s2oUiCYoF2GxM+
         RN2mZ1O/FI7MruCLQjebmSOtmr2TUoXBJ4/3Qulf7iYhmnwVznuYImPTbxSyEff0W+mn
         FJQQ==
X-Gm-Message-State: ACgBeo1yoJGHuUMkd8Ff9OCy2fsr/DjzlXUopii9flBbGInNleRp4uY+
        5keWQDhOc7fB05dP9DpVqeI=
X-Google-Smtp-Source: AA6agR6X08zzVh0bpzfhpbQ/suX+Lp6b/y7S04GPoRVpBzhuL2qzGVVVqa2/9E64KnFvJhjXn8zWXg==
X-Received: by 2002:ac8:5a14:0:b0:344:5660:6530 with SMTP id n20-20020ac85a14000000b0034456606530mr25011005qta.12.1662057229247;
        Thu, 01 Sep 2022 11:33:49 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id u20-20020ac87514000000b00342e86b3bdasm10563343qtq.12.2022.09.01.11.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 11:33:48 -0700 (PDT)
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
Subject: [PATCH v6 01/10] dt-bindings: arm: imx: Add i.MXRT compatible Documentation
Date:   Thu,  1 Sep 2022 14:33:34 -0400
Message-Id: <20220901183343.3188903-2-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220901183343.3188903-1-Mr.Bossman075@gmail.com>
References: <20220901183343.3188903-1-Mr.Bossman075@gmail.com>
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
V4 -> V5:
 - Nothing done
V5 -> V6:
 - Nothing done
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 7431579ab0e8..03350dd1fc58 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1053,6 +1053,18 @@ properties:
               - fsl,imx93-11x11-evk       # i.MX93 11x11 EVK Board
           - const: fsl,imx93
 
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

