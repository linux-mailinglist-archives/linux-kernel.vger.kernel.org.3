Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1060513E06
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 23:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346746AbiD1VwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 17:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352478AbiD1VwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 17:52:05 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233FFC3E0C;
        Thu, 28 Apr 2022 14:48:50 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id j9so4656171qkg.1;
        Thu, 28 Apr 2022 14:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cyKjVqkv7xpCIRzFdkGLOU+0WChIqQ56OJI9afxDIPM=;
        b=AUh3UA5ZXoQFgxx3Eae9B3/xLpd2GS7ntg8qTW+WbwgaRnKFfh3A9fhZV10Xei2pSX
         gSpanaoY+okzVJJUZNEHQTUl09xX38VmbvQOhm4emdJ5LvYIkI1vH/tADb/3wSGYy7DA
         V4+rjHd6Bm+SjjqZf55lyTG9Ts38TbXSXlDLrMITpqTKqDRdIjgnabHk4yH96Xxl2G0h
         tEpGeFtDzfrL7dvnBarkn1AAVobcsCxHsVSDZ5AP6eRAc9Q97c/anbtrEdiN3FBYf16R
         6K4Nb/SJ3fD4Pn+1MT9pf2d0NeKrowC7cQwG7HKjK8Y4bI1M5UDo9t/EJCLyGWakKUFz
         DuWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cyKjVqkv7xpCIRzFdkGLOU+0WChIqQ56OJI9afxDIPM=;
        b=Xs47nuYVtix9iALAwGLjZ3S1pNtMs3ofHxR8IMaHsvNfMxieZt8XCJMMcn6DoFfXRo
         WB7Fnv8yqfrifgkOx09DcGW8P5XQ5W8OSDzxREhqSjPtKZg2tmWR0moeA9qx7JTwEjAW
         YRBcP49jviJ9IrS3EOPuQNa9KxVWBqkwSMlIb4EcfR4SC98NLqdfiXh4bkHdm5BTGLip
         ngTGCDjEz7aOJaj826YPRbTqT1Bvbk3SsxF1PTnPOq3tajYLpXlLpfbrBu1ibMFTdKzA
         I1JXi2MMdSvJqNCye5AXzb41Iz74ogi7TbLJLvjK76vqfYW0U37n7pgZUxhzx0EJSTTi
         eC5Q==
X-Gm-Message-State: AOAM533O9Fg4nuGjJX5Nt7mBIx5kQ7t7bDUnyRwqjmPwX8/yQBJj88wG
        ApYg6T+oXhGEp/2QOOtqNGw=
X-Google-Smtp-Source: ABdhPJy53waABWpYCBALdgcYUjkemu6k1JLDrkCmqWvg/OP+7NQVRYqnHFASLm9UJHG1mC1xp+nRkQ==
X-Received: by 2002:a37:678d:0:b0:69f:8aa7:f3e1 with SMTP id b135-20020a37678d000000b0069f8aa7f3e1mr6727498qkc.74.1651182529258;
        Thu, 28 Apr 2022 14:48:49 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id bl5-20020a05620a1a8500b0069f51e47c5esm546442qkb.110.2022.04.28.14.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 14:48:48 -0700 (PDT)
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
Subject: [PATCH v2 05/15] dt-bindings: serial: fsl-lpuart: add i.MXRT1170 compatible
Date:   Thu, 28 Apr 2022 17:48:28 -0400
Message-Id: <20220428214838.1040278-6-Mr.Bossman075@gmail.com>
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
 Documentation/devicetree/bindings/serial/fsl-lpuart.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
index a90c971b4f1f..5e306078629d 100644
--- a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
@@ -21,9 +21,13 @@ properties:
           - fsl,ls1028a-lpuart
           - fsl,imx7ulp-lpuart
           - fsl,imx8qm-lpuart
+          - fsl,imxrt1050-lpuart
       - items:
           - const: fsl,imx8qxp-lpuart
           - const: fsl,imx7ulp-lpuart
+      - items:
+          - const: fsl,imxrt1170-lpuart
+          - const: fsl,imxrt1050-lpuart
 
   reg:
     maxItems: 1
-- 
2.35.1

