Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507AD5283A6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 13:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbiEPL7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 07:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243279AbiEPL7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 07:59:23 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E7E15A1F;
        Mon, 16 May 2022 04:59:22 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id y21so17992295edo.2;
        Mon, 16 May 2022 04:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e5MlAE8SnkTiFChlBdPJSfW3vFLUzMTgpeUilH24TZ4=;
        b=ifEttzhn6xBuE6SqZ1BK3qusjmqI+ZoFGO6PbHg6FKGnoOUbGbJ6Nbq4gZmliMjlKM
         HpRfJkGa1R5K6S3Sz+GmcgV0W/omf4So0r+ewX5tPSbrhMFl7cb+/RWY2T1+TpxhtnQD
         5wGGauwd6L4pGGlFISSTV2nDDhVWmk62x3YczXn8NX/v+JSF6g4OoaneuS5WIrzd/T1r
         O8XFt+1fjeXDW6XC9wj2wa4LazRUEtSzoatn7k9cZ/bQUzvOyyI2v8QKz+zSpLpPrFJy
         /O8q1F3z+qEwiPHsGQHx4C/KLSlhMmNz02xq7hCXVD2TJCBWgyX4gP2SV4Yr188leNbW
         M3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e5MlAE8SnkTiFChlBdPJSfW3vFLUzMTgpeUilH24TZ4=;
        b=b96EmVSFxYqkF8I21FwYnexnA+ZLwEsL8uD1ry1QRVBm7uNpmK/n3VE7u0mgUnPQXM
         1aB4AaBX6ThvOKL+tAPmkv+IowGBSFWNLd6uVH90bX4Z2zm738C1cD+xqEl2NRCU4AcW
         DDmFcjSt2dLN8tlAchlPQfdtLC724A3golf8wvh7kWKho9ahdMbgqguflg3BfrWNHQe1
         cYgq+cdfp1GkOLAiRakUYqmgl4WSxtPkjZfQ92WH5QhrgXugYjIQG88XX6Ees8Nwd2H8
         cdicj4tpUXW88f9gVbFzwiTfpDTWsjKMZeaXgq1AxxiMvRaPVsKdD5okRzjT3Np9n+0h
         m9lg==
X-Gm-Message-State: AOAM530b4ZBgVcPakI8bCX6ALZ9FU4KyPdmh+24YVgbd21+YK/iZR7aG
        1UYgkUPfGEa/hAIcI8DgRSA=
X-Google-Smtp-Source: ABdhPJz4tLeGiOn5boAVfBdvy20eNUDuSLC2kPEis33ndo0w+9uFWq0olKNZfF/PXNdVvwI1jFVtVg==
X-Received: by 2002:a05:6402:17c1:b0:428:8016:d98d with SMTP id s1-20020a05640217c100b004288016d98dmr12791876edy.5.1652702361288;
        Mon, 16 May 2022 04:59:21 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id s18-20020a170906779200b006f3ef214dacsm3711008ejm.18.2022.05.16.04.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 04:59:20 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 02/17] Revert "ARM: dts: imx6qdl-apalis: Avoid underscore in node name"
Date:   Mon, 16 May 2022 13:58:30 +0200
Message-Id: <20220516115846.58328-3-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220516115846.58328-1-max.oss.09@gmail.com>
References: <20220516115846.58328-1-max.oss.09@gmail.com>
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

From: Max Krummenacher <max.krummenacher@toradex.com>

The STMPE MFD device binding requires the child node to have a fixed
name, i.e. with '_', not '-'. Otherwise the stmpe_adc, stmpe_touchscreen
drivers will not be probed.

Fixes: 56086b5e804f ("ARM: dts: imx6qdl-apalis: Avoid underscore in node name")
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

 arch/arm/boot/dts/imx6qdl-apalis.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index bd763bae596b..da919d0544a8 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -315,7 +315,7 @@
 		/* ADC conversion time: 80 clocks */
 		st,sample-time = <4>;
 
-		stmpe_touchscreen: stmpe-touchscreen {
+		stmpe_touchscreen: stmpe_touchscreen {
 			compatible = "st,stmpe-ts";
 			/* 8 sample average control */
 			st,ave-ctrl = <3>;
@@ -332,7 +332,7 @@
 			st,touch-det-delay = <5>;
 		};
 
-		stmpe_adc: stmpe-adc {
+		stmpe_adc: stmpe_adc {
 			compatible = "st,stmpe-adc";
 			/* forbid to use ADC channels 3-0 (touch) */
 			st,norequest-mask = <0x0F>;
-- 
2.20.1

