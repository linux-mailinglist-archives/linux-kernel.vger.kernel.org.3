Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7355B5297FB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 05:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbiEQD1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 23:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238148AbiEQD1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 23:27:17 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3C33FBDB;
        Mon, 16 May 2022 20:27:14 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id kk28so13589158qvb.3;
        Mon, 16 May 2022 20:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ei/dh+6UXeL3JNBdiwijmzKnsVw6+/DL3qzf7Tgv6So=;
        b=UWtxOhIlXvvtTRU+ihQ20LF6d7gEDsAqJxmp8xA/xVjp4RgXUfsgxVOCi7JLw3tdcj
         rr5iDetVwan9UwX2GoXo8jPgkmGRwDcGrNaiDjln3yKGT9hdhRBPTmV+RT9KAuKtJYMM
         ZzM+rVR3lYPAubaGYWoi0hGWBDiCGpFSqEXPROuYe+f64MD3Sr3A18S0bTWrnHJy+lzp
         Kz8Wc/VQ2MDeOJCLioFKn4gQOHqXXsZsVo6md2rptm5hbhofUSd6HujJvyTVASiC6qR6
         iig9u+0DUVFJkIhkkwCd8wIp3E/Qc13dziHh8gPOAbjMvTinYi+c/DGOWaK0dO8GgWDf
         O+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ei/dh+6UXeL3JNBdiwijmzKnsVw6+/DL3qzf7Tgv6So=;
        b=SITauwCqVe6FpSnY8Zm/i9d4KvZOoSk0SyMnDmrtCjK30Pyd6/ZnMMEs0VnlvYPbtS
         jRF9n4OmGU6yt2rCWnhyGcJkeUIaICJsGHWQhJqbJ91fa6BS+cAzRiTlz6+al93bd5AU
         +FJKvIkB5rcnocKXG4rLKU1TzWMtHQ4HpT1tTYwYj863yDIudJDw1ZXQLFKMs+Fm/qRt
         hAKWsyvxR5Z6LTbe8mEWMBnwLrCCWmCpZRWmuMCBo/WCCBZUcf5DRwOiLFSFLRmCHmv4
         gD6KoOqJ+G+1pcAsJlQy4JfNehZ6raRmWaobggd03WAUXrwh//inSfyY0SSu6dSlHx11
         9Vaw==
X-Gm-Message-State: AOAM530ofT1wyW+wUAGgxqcfxpA7dm5xTeTwrsY+Uvbrk9hO/MRns09m
        CjrLjc9RYikYOznoqSjv44c=
X-Google-Smtp-Source: ABdhPJzVqs/D9zM84cuKx7JvNpHVTjiGE7nlr0s/oDsnXmDJ2NnuIGzTA6BDGTaSBm3F9wMbqut21Q==
X-Received: by 2002:ad4:5aed:0:b0:461:caa6:81f8 with SMTP id c13-20020ad45aed000000b00461caa681f8mr8097770qvh.49.1652758034053;
        Mon, 16 May 2022 20:27:14 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id u129-20020a372e87000000b0069fc13ce1f6sm6893635qkh.39.2022.05.16.20.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 20:27:13 -0700 (PDT)
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
Subject: [PATCH v3 01/15] dt-bindings: arm: imx: Add i.MXRT compatible Documentation
Date:   Mon, 16 May 2022 23:26:56 -0400
Message-Id: <20220517032710.451537-2-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220517032710.451537-1-Mr.Bossman075@gmail.com>
References: <20220517032710.451537-1-Mr.Bossman075@gmail.com>
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

