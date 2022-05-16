Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4231D5283B4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243521AbiEPMAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 08:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243355AbiEPL7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 07:59:51 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C391165AA;
        Mon, 16 May 2022 04:59:34 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id m20so28116633ejj.10;
        Mon, 16 May 2022 04:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QCU7wfDMqrm19GcnwILuywiRx6koKWukaCjyLUMr2jY=;
        b=lCL7qISvtKKvBfN7Fj5ilr1dpWU0aSKxE1M1Ycx2YiF1m2N2r20lHQkoMeOOoqphhM
         zTFOOQUMcsoXp1Z4adiWU8brX19S+6CQq9pTptK5cmoiV8+lEF+gXgUiOsMwrWeCxDrW
         j2zN0Ejt+en9ZZo6tsfnyWPX+Z1lC0eBCDaA59e6O81rGbZvhbE54AhMx9l0xq1+SwZW
         +69tW4ajTk7H1BZJVhhBg3kEjl40Q/w5zI4Gz2zKxvnh0/UFkwTH7yrIwd97zvAXrQT0
         ArtYz80hSDUH0XYrtLZ6tk7rJRk2XQ5h6FeBqTDaq89OdRBL0tvc5YZxcGs/1ebAHqvI
         YZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QCU7wfDMqrm19GcnwILuywiRx6koKWukaCjyLUMr2jY=;
        b=QuNakz6uezVHqnY3wrpnwy+E7VxwbpvHIhgR2/2FH1162taM/BjgTYTZo4vQMk9c7m
         Pf+vcrCf0/wuDy+UPplzSzVzkHPQOOPBCPlRVNlZGzVaT51KIFk4549fV0Q+KqtBiAfh
         Yejz/sCjRKNSI86OZNJ2HvtJWFfeSNuoFPq+REkuGy00J3E9FXs0urMSbD31qzH69Msu
         zuG5HB8nTpJwRZm7/8X/CBBIUAMp5b56zR1J1CnVFh51POLVA4Z+K8mVbsvB7DIghefz
         LwD994uSSyUwaqp2aAlPC5CpeLg1xZTcE9RhaZpbvzwPbcHgRe86js5JfLWylRSsDiLb
         h5nw==
X-Gm-Message-State: AOAM530Pn8UiGgV0k7jrRcXAahMUqd8pItFqRvnY/l0mzzfYu3bKwPxT
        cEtdmBbwLen92GCyo9sK5UYz3Jkgl0E=
X-Google-Smtp-Source: ABdhPJwy58Fv2Rln/V04XhYV65F1aWgT954hvfk2TNnITvkLvMQSdg+QATjeaXnqvWLQp8TCmUpQdw==
X-Received: by 2002:a17:907:161f:b0:6f6:b288:b397 with SMTP id hb31-20020a170907161f00b006f6b288b397mr14865028ejc.303.1652702373233;
        Mon, 16 May 2022 04:59:33 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id s18-20020a170906779200b006f3ef214dacsm3711008ejm.18.2022.05.16.04.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 04:59:32 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 10/17] ARM: dts: imx6q-apalis: Disable stmpe touchscreen
Date:   Mon, 16 May 2022 13:58:38 +0200
Message-Id: <20220516115846.58328-11-max.oss.09@gmail.com>
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

From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

Unify its label with other toradex SoM dtbs.
This allows to enable it in an overlay per the current
system configuration.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

 arch/arm/boot/dts/imx6qdl-apalis.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index 428841cdaac2..506d040ea37a 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -578,7 +578,7 @@
 		/* ADC conversion time: 80 clocks */
 		st,sample-time = <4>;
 
-		stmpe_touchscreen: stmpe_touchscreen {
+		stmpe_ts: stmpe_touchscreen {
 			compatible = "st,stmpe-ts";
 			/* 8 sample average control */
 			st,ave-ctrl = <3>;
@@ -593,6 +593,7 @@
 			st,settling = <3>;
 			/* 5 ms touch detect interrupt delay */
 			st,touch-det-delay = <5>;
+			status = "disabled";
 		};
 
 		stmpe_adc: stmpe_adc {
-- 
2.20.1

