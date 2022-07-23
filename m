Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79B057F040
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 18:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237508AbiGWQFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 12:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237479AbiGWQFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 12:05:24 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D93511457;
        Sat, 23 Jul 2022 09:05:21 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id g1so5663748qki.7;
        Sat, 23 Jul 2022 09:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oM+J6LQU47Ll5cBvglPrj/8sNA6JWNYmjwfp5l6F0ec=;
        b=cB+D6tFZxjNwwMQAdR7bB/aqZsiIAZVbh/5GRQIwpERHhBFDShRd5e5X3bU3XjVZaI
         lyZlVUy8ViCqLrwANiJ76x1UGZsWGwM9kZ+wzMyFUHLkAmdjFSI9Jd1CU9UgFcsTIpgh
         2EbjFi+yqjwU/00jei4KX2StYRpNkNUQyngSFf/jx/v8BiTbNNE4Emv5yHeTK3JwzheR
         7bFwNANlOjTl250em41TcMDLI5j9xylhcf49WGaDWHEOSfM4+QMBx7ILcExeeqfEMuIC
         fl2VaRkFq1yX167nuCNIAEfOrJ0PefsoQ7KRhFElOrnlyaSYav3+xlXAFZGybiFRiIKk
         snDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oM+J6LQU47Ll5cBvglPrj/8sNA6JWNYmjwfp5l6F0ec=;
        b=7BqenY3ckoxZ/KFWvdDxb9zW5qnc3KMRGFrDgg2Oa0oHusiGBq6Hgy+2PHTH4qURK7
         TopAhHTQHBZ7GSfanXuNdRMVsyWExIympOdcz2y296NejFQykprG0UQ+G/7RuIO4oYdI
         SWQxYe3eDAd6hhDQJJplBJ7WAU3Tr7hcRi28Rz6IM2hSnX/2F8e1hIr6NEXbuI2yVdAX
         Dqni2j2tFdmeImdLuuVL3wkKkvlrfS8vfau9OQDz8JJ6g2Y5mpXxa3gxyLfcud+Z9Gh5
         8i4A4tA5Z8rSqsYK4H5h2ig+FPZbqB6k+8g68cxu3HZTc2jUtF8SvjjgMx6V4A86gvmT
         5Vmw==
X-Gm-Message-State: AJIora8uAaTYtUme63mhq7pqIPKwkfP94Fju01X/N7WNMiFSYOqdv5VR
        MERSTwTKiSW4T65IgBbIcT8=
X-Google-Smtp-Source: AGRyM1sh3TrQGE4W8az/u94k8nMU0iL06oazAZ1/ltgN7HHBlzFufvmZxLkCZp6G8L8Z6PQ/bZleIg==
X-Received: by 2002:a05:620a:270e:b0:6b4:8425:d03c with SMTP id b14-20020a05620a270e00b006b48425d03cmr3820941qkp.732.1658592320736;
        Sat, 23 Jul 2022 09:05:20 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id g4-20020ac87f44000000b0031eb3af3ffesm4935046qtk.52.2022.07.23.09.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 09:05:20 -0700 (PDT)
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
        linux-gpio@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v5 02/12] dt-bindings: timer: gpt: Add i.MXRT compatible Documentation
Date:   Sat, 23 Jul 2022 12:05:03 -0400
Message-Id: <20220723160513.271692-3-Mr.Bossman075@gmail.com>
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

Both the i.MXRT1170 and 1050 have the same GPT timer as "fsl,imx6dl-gpt"
Add i.MXRT to the compatible list.

Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
V1 -> V2:
 - Nothing done
V2 -> V3:
 - Nothing done
V3 -> V4:
 - Nothing done
V4 -> V5:
 - Nothing done
---
 Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml b/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
index a4f51f46b7a1..716c6afcca1f 100644
--- a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
+++ b/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
@@ -31,6 +31,8 @@ properties:
           - enum:
               - fsl,imx6sl-gpt
               - fsl,imx6sx-gpt
+              - fsl,imxrt1050-gpt
+              - fsl,imxrt1170-gpt
           - const: fsl,imx6dl-gpt
 
   reg:
-- 
2.36.1

