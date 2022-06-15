Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5464554C7E2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347863AbiFOLvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347204AbiFOLvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:51:06 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9663F4EDF8;
        Wed, 15 Jun 2022 04:50:58 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id x5so15761191edi.2;
        Wed, 15 Jun 2022 04:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cl1dcczO96rBtCg5ygEOypyWeJ90Qx/W0l9Ehf8BH4M=;
        b=QCoS3wSh7xzDJh42Kjkbhg2/y1eEQ+j+Zb72WzIpKlKJZbMiMdQXiVm52iPgs4hBg1
         uhzvAhjaseNimjJUAdncHPTEsYFVb/D2bn5Va4fbtN3LSn7J07MuYD/UwHC6yvJmEvpe
         Bf3pbUA2CIPb988FRhaVXILig2m8/ZbhKp85bEmtNA6tRRoOpqjnOGN1desIoGiTO5OG
         ERrR50qwYHQhTD85fEjWG5H0R2NtAVexwy9azQQSnAnDRpL/2Od54PxH4GzZl3zG+mM4
         mNP2EtvTD7915qmEYOLaVJBX5FgqITRf7crxWaPGkcolEBB/anzB8SlFt1Wm0y9KCpx0
         ZsYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cl1dcczO96rBtCg5ygEOypyWeJ90Qx/W0l9Ehf8BH4M=;
        b=D+4uEyXwEQIymVwkXnqlVcs5wr6IvxLpyTn7PjWySpZHkiHw+CE/KhWdhgHYNRh59k
         6vemQf7277yXgyON1QLrq/MSXf3WUblc0qPDSAFL0yxyQRE3xh+nBoG/Cgl7VqhPBode
         xLox/LNzo8OsTKD7kpXD+E4x/WteixMDHeOV1vNtJfjozyf2IeAyl4sag51III1Br4Ir
         wX/X8XFuRjNP5z3Ul7jOTCpq0hUVmP1nHHfPtmsW0pQQFi9i/L8qWY6RD8050IO/sNyz
         J3su46PFJNGsge324io1WgUPLHO2GqREZaCpYRvHmI72xzMTV3UyELLN98XftvRBFPWs
         TqwA==
X-Gm-Message-State: AOAM533x0m5jHo41QKOQGKmd3Bc7JUDppAQtfmWhjOUv1C91I+l3utan
        J2eW+XaQyQdUKFaFRUuDHlY=
X-Google-Smtp-Source: ABdhPJwtUg/5+Cq6iOM/mEbJDKECBlI5ltgZntMeaKelklR1yr8vyLEtxsPhjovrN8Dbxg+8xZkN5w==
X-Received: by 2002:a05:6402:249c:b0:431:3883:967a with SMTP id q28-20020a056402249c00b004313883967amr12490255eda.264.1655293857158;
        Wed, 15 Jun 2022 04:50:57 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id t6-20020a17090616c600b00715a02874acsm4561158ejd.35.2022.06.15.04.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 04:50:56 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/18] ARM: dts: imx6q-apalis: Disable stmpe touchscreen
Date:   Wed, 15 Jun 2022 13:49:59 +0200
Message-Id: <20220615115006.45672-12-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220615115006.45672-1-max.oss.09@gmail.com>
References: <20220615115006.45672-1-max.oss.09@gmail.com>
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

(no changes since v1)

 arch/arm/boot/dts/imx6qdl-apalis.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index 636b04139a5b..b4742ad85f56 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -592,7 +592,7 @@
 		/* ADC conversion time: 80 clocks */
 		st,sample-time = <4>;
 
-		stmpe_touchscreen: stmpe_touchscreen {
+		stmpe_ts: stmpe_touchscreen {
 			compatible = "st,stmpe-ts";
 			/* 8 sample average control */
 			st,ave-ctrl = <3>;
@@ -607,6 +607,7 @@
 			st,settling = <3>;
 			/* 5 ms touch detect interrupt delay */
 			st,touch-det-delay = <5>;
+			status = "disabled";
 		};
 
 		stmpe_adc: stmpe_adc {
-- 
2.20.1

