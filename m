Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B373657F048
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 18:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237599AbiGWQFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 12:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237463AbiGWQF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 12:05:26 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB89C1277F;
        Sat, 23 Jul 2022 09:05:25 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id e5so5469695qts.1;
        Sat, 23 Jul 2022 09:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jK1g6CKi8TGVEXtmQQp5ePb9oV0aBgQX1WSc/ZWjGNc=;
        b=GQ0LXoz16pb+BYb0RYEMcaylvWKYAa8sbH7tNP4qaYXmHQ4vfvIDFFzFaZeDwJNhkA
         JRkAu18I87FSi1PmxFfMgZi9WYd9B707Id2gwgJNH3InLY7ABu8ENNS3HxCBnhJUFeP4
         PjsBt78fC3NmHrt1q8n5bIEvO3yh+qDhyM+vxpgRnTcsMlOGG64gCPlzLiyp3TEGSVoM
         qeedapYa9+3VBlLprjdRvECKgGidNwpPJ0kg90g0uxHzNLFNMIxOIIwCUquaYDCs9z+E
         UBCxJnFfkmDdRtVVK03+pv9o/hdADx0Q6xLaJyA4i7IB6N8QRiUZPHh1SyRhXCO7Lvpc
         wA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jK1g6CKi8TGVEXtmQQp5ePb9oV0aBgQX1WSc/ZWjGNc=;
        b=ki6XkkFpQNI/dS/xvjGtMT4bP7L/sllZYu7lLo/MJu/gSKtmbdsRjB7bSYtao7/ZVe
         GKM/L/LJrV626mN1DRC70LgjWkoYq/W9fYl+qPurVQlEicdGU70ApIi44e1LfbFovAIg
         57jsy674hPTW/3OI3Iyq0FGTmA1gbP14ESQnMi5PDDtJQ9W1lcUb73hAdqRBxD/jZbFx
         deuqh9ef8UjJBSDuMU/mj48t27yDT461ZBMC209ruMXZd7C6euC0J8XzdxwTgj/p2eRq
         JgEt+4wxtSLS5XLg4fVnJ38uAy93RTjI/ZR59ZuSSnEEyJrxXZ//pUrf2hYEuqwbdDSD
         Pz8A==
X-Gm-Message-State: AJIora96+6cJTmAoFwXevtES0uMGdQyHTDLFvFjPFassfBIJC37IhMTy
        ZLgsd/CaPjEz4nVvY5b2Acg=
X-Google-Smtp-Source: AGRyM1uYTCjmmVj7ECql86XkacltEYujgSy09r9BhU6t7MjcYTmX4zbhUggyKQnVGkKuHfyGoMZGSg==
X-Received: by 2002:a05:622a:24e:b0:31e:fec2:d0d7 with SMTP id c14-20020a05622a024e00b0031efec2d0d7mr4400777qtx.222.1658592324787;
        Sat, 23 Jul 2022 09:05:24 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id g4-20020ac87f44000000b0031eb3af3ffesm4935046qtk.52.2022.07.23.09.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 09:05:24 -0700 (PDT)
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
Subject: [PATCH v5 04/12] dt-bindings: mmc: fsl-imx-esdhc: add i.MXRT1170 compatible
Date:   Sat, 23 Jul 2022 12:05:05 -0400
Message-Id: <20220723160513.271692-5-Mr.Bossman075@gmail.com>
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

Add i.MXRT1170 compatible string to Documentation.

Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
---
V1 -> V2:
 - New commit to fix dtbs_check
V2 -> V3:
 - Fix typo
 - Remove unused const
V3 -> V4:
 - Nothing done
V4 -> V5:
 - Nothing done
---
 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
index 29339d0196ec..0e7833478869 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
@@ -75,6 +75,10 @@ properties:
           - const: fsl,imx8qxp-usdhc
           - const: fsl,imx7d-usdhc
         deprecated: true
+      - items:
+          - enum:
+              - fsl,imxrt1170-usdhc
+          - const: fsl,imxrt1050-usdhc
 
   reg:
     maxItems: 1
-- 
2.36.1

