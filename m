Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7E14E8183
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 15:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbiCZOpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 10:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbiCZOpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 10:45:00 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B2F208320;
        Sat, 26 Mar 2022 07:43:23 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id v15so8100441qkg.8;
        Sat, 26 Mar 2022 07:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J0KAey3gf6lpGrAz4+ac6WU8V1jpceu2CiVcs68nOBw=;
        b=HcdtvBZNmP6nfzLVfAV1D53h21YifChAoEDz6WaEVX4c0+PHgHjFRVt0vVq0x2PV2l
         d7WXjqSNApMUfKDvn53m0rj9Wp/fpQeqCHJ/+7gdbo5u3JXkAcTHw6QFf1DKmcmh6onz
         cmJLNyACvLZe+oc0sEPbNeodAqOo2eDSGb95gmnW7PZCHxPYRZuV5nfj2VJJy0C6Omgs
         a3r6P9yGGdAbebvv97yO4x41ouLPVa/rXRTbe9t2UH9dc8m/toY+svKofp8bJpuROBNn
         JQ3ek3dcBmv1+cScpeWNov9AId/nVBBjBxuP4DanYSb80ngHbtcN+u70zDQm01+WC/wz
         sdMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J0KAey3gf6lpGrAz4+ac6WU8V1jpceu2CiVcs68nOBw=;
        b=SLX6RBCkP5l1n0LNEvrrj2mvOMGcQb4aIkHbltnmij7fw3G45nzRGDnJLrlDxs6is8
         31hh8/W3K4c0F14r9oowhkYWkaWMIUdeSGmVR++/UgVXSV2vE1aiZ8wAbJmektB4R3QL
         fyvckzdH87XHD0NuhubZ+lJlnIuDfzZs7r+rM64wE7kt+SRHEo5oz0jqNYnM0ajXCLI9
         br7CGsMSYBDvGb5nhoQcM5mWJKb+Kl2dw1NoIn3+kCCejlqZRfrUjvyXFbxJD6FmbKhh
         spaJZCIJGiA+rWtGDjQa9WxZsJwpW7iUiVUort09xgC5J+UYIygQiJUoU8F4eqczZcDZ
         lVeg==
X-Gm-Message-State: AOAM531jBn1+tGnaXQbRdU42eLMj83RNjlg0CbkC66XRLu94nuqbKeMP
        YQbpRxEodvo+nKTmoRR+BsoWI+iXZlfWXw==
X-Google-Smtp-Source: ABdhPJzNAY3XSSTbA4ySLo/1l34XLNiCrW+cDOn+J/1CnKliqJB1YwYCuBOOxF9wnfdEhZgns0U+Og==
X-Received: by 2002:a05:620a:1aa2:b0:67d:1637:7a9e with SMTP id bl34-20020a05620a1aa200b0067d16377a9emr10383879qkb.680.1648305802594;
        Sat, 26 Mar 2022 07:43:22 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id 70-20020a370649000000b0067b4cd8ffbasm4908918qkg.60.2022.03.26.07.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 07:43:21 -0700 (PDT)
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
Subject: [PATCH v1 01/12] dt-bindings: arm: imx: Add i.MXRT compatible Documentation
Date:   Sat, 26 Mar 2022 10:43:02 -0400
Message-Id: <20220326144313.673549-2-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220326144313.673549-1-Mr.Bossman075@gmail.com>
References: <20220326144313.673549-1-Mr.Bossman075@gmail.com>
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
added. Add both i.MXRT1170 and 1050 compatible to fsl.yaml

Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 0b595b26061f..59575053ff03 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -834,6 +834,18 @@ properties:
           - const: toradex,colibri-imx8x
           - const: fsl,imx8qxp
 
+      - description: i.MXRT1170 based Boards
+        items:
+          - enum:
+              - fsl,imxrt1170-evk         # i.MXRT1170 EVK Board
+          - const: fsl,imxrt1170
+
+      - description: i.MXRT1050 based Boards
+        items:
+          - enum:
+              - fsl,imxrt1050-evk         # i.MXRT1050 EVK Board
+          - const: fsl,imxrt1050
+
       - description:
           Freescale Vybrid Platform Device Tree Bindings
 
-- 
2.34.1

