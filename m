Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9394F52A3E1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347803AbiEQNxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347571AbiEQNxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:53:48 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6163326AF8
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 06:53:47 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id fd25so9920440edb.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 06:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3A4OivyTFNaDUV/j76uS7UAfnr06mF8BaqQDTpHH1NI=;
        b=fso1T4lD4yWO8PPaFfhx9YZ/S5An9S2h6icVIVaWNn0/6FN2XmB0+6yoqEWPxxY+Rv
         Q5SfZgRqP8YlX/QV2y/KE/iVEePjJ3lCd9SIDdWQzbxhKlyocKUNCqXa4suFVLgqqLgc
         OBLdawBRX6/T4OFX/EAVi2n/kCZhclplFkTNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3A4OivyTFNaDUV/j76uS7UAfnr06mF8BaqQDTpHH1NI=;
        b=EGpzMllS4a/nYBYSUypD7Mqh2QYkBLL7/sPFlDvwijBGJDBMXHUhYVRGhsCTewpnep
         iFAZDB/pxrKNS3G7hckBev8OM12wEUDd0ijjc+Hc4ul8S0U6ZND6+PxCCgN3r4hc4gXc
         MyBMiAzWmF5v1bTx0WzROA75Ih1Kq6v2/KaaKI+t87fgCJ4gLuXpFWnMXXuUDUpWvyBL
         u1Ie4EEKW4Jg4lqZ1d5Mb3OhaWeEZ5yOzbZwekZpuWlU3G4GLpiasg7ScNGZPqXSrTu6
         qIwhF/R+wsI/nba1FBnB4iFa+/mhRmYbdf0qsjE2pfTE4/nD2kXmv+LWP2Hx6mx3E9HF
         KKeg==
X-Gm-Message-State: AOAM533MxZZubA8kwxQUIdVFhRXbPx5BDmkozG4AdFggKWWCo6NPxePF
        wh245GY9xF2rsyjz9lFFcB/upw==
X-Google-Smtp-Source: ABdhPJywNs/FNa8nCJvFyZ6zYFCJ0exS7vS472Ed5ayC3rSFnDN431mnp8g4VhrHiXVWjrdlrEeJ1A==
X-Received: by 2002:a05:6402:1941:b0:413:2822:9c8 with SMTP id f1-20020a056402194100b00413282209c8mr19378672edz.13.1652795625905;
        Tue, 17 May 2022 06:53:45 -0700 (PDT)
Received: from panicking.amarulasolutions.com (mob-176-245-91-171.net.vodafone.it. [176.245.91.171])
        by smtp.gmail.com with ESMTPSA id u20-20020a170906109400b006f3ef214e56sm1055806eju.188.2022.05.17.06.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 06:53:45 -0700 (PDT)
From:   Michael Trimarchi <michael@amarulasolutions.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Rob Herring <robh+dt@kernel.org>,
        Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Simon Holesch <simon.holesch@bshg.com>
Subject: [PATCH V2] arm: dts: imx6ulz-bsh-smm-m2: Support proper board power off
Date:   Tue, 17 May 2022 15:53:42 +0200
Message-Id: <20220517135342.2458267-1-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Holesch <simon.holesch@bshg.com>

Supports initiating poweroff on SNVS_PMIC_ON_REQ signal.

Signed-off-by: Simon Holesch <simon.holesch@bshg.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
V1->V2:
	- adjust the sign-off for mailing list policy (Thank you Fabio
	  Estavam
---
 arch/arm/boot/dts/imx6ulz-bsh-smm-m2.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ulz-bsh-smm-m2.dts b/arch/arm/boot/dts/imx6ulz-bsh-smm-m2.dts
index 59bcfc9a6b10..c92e4e2f6ab9 100644
--- a/arch/arm/boot/dts/imx6ulz-bsh-smm-m2.dts
+++ b/arch/arm/boot/dts/imx6ulz-bsh-smm-m2.dts
@@ -29,6 +29,10 @@ &gpmi {
 	status = "okay";
 };
 
+&snvs_poweroff {
+	status = "okay";
+};
+
 &uart3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart3>;
-- 
2.25.1

