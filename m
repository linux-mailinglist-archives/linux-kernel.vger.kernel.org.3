Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A30B5665C6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiGEJDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiGEJD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:03:28 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05092EE12
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 02:03:26 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id u12so20438691eja.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 02:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition;
        bh=VhMVYceaMPOW57U8F7IYVNMLSx0pUikqSY1p27w3qOM=;
        b=d97wazQqx3cx2Ox9PftXcyeAWivYS8wfb3lcmRlz1Vjdh/T8kUD5YI/5ESyC5dM+je
         QNiAwQzu02o0AY/09yrCN5KyDGDhA6YfFQRRtaVX+vBV7JMi4jB8sTnV0kS8Xpqk33A8
         6YQAmWK3zRjHa+B4i2h5YpHUO3VBsvne7z/6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition;
        bh=VhMVYceaMPOW57U8F7IYVNMLSx0pUikqSY1p27w3qOM=;
        b=VYSh33X/NL4RTGdD6jHOcbkMYk8nBD7QYlcltyyl31gihA4Q99Eh6YEdqBYynur0qo
         KGujBA8gy2k/b+RZLPHC3Gb1ewa2HrVjOH4AnVSrGPWAcpUsosnwRHORTbetyvpDGSe0
         F6cihKCzGmdmXvYt+jIopeWmvNoPtKC6bJsK19iqfxa03pGqXbTrbuioQ3VQKfm7XuIx
         e6dqbcZQxYrKR0i1rVl7DmHFauecFPcw8HAYJMTStwoUSrHCeg+E3iwBzNSXTNmjkaxo
         U4ljVOT+DYg9guTzkDn8AX1z4TfWSRJpZtPvAAILid41Rot9VCa8hJX9X+LMvL0o/epT
         DICA==
X-Gm-Message-State: AJIora+otTiohG30sm5UOhA/GqeHo4ss94t2vQoDXKCJXtTbNQP1WQOn
        fnCNj1Cs/mRL3+a0q0fY3kwDdhOwk0xhPw==
X-Google-Smtp-Source: AGRyM1sVZiecfw9Ff+mKo3y9uv99XzCrsKyxN4Rm3Nj53BK/O8N8a64Q3r1M0bZCKgmkxN3RWqFP5Q==
X-Received: by 2002:a17:906:b01a:b0:718:cc50:4c6 with SMTP id v26-20020a170906b01a00b00718cc5004c6mr31971409ejy.630.1657011805095;
        Tue, 05 Jul 2022 02:03:25 -0700 (PDT)
Received: from p310.k.g (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id q10-20020a170906940a00b006fe8bf56f53sm15631412ejx.43.2022.07.05.02.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 02:03:24 -0700 (PDT)
Date:   Tue, 5 Jul 2022 12:06:29 +0300
From:   Petko Manolov <petko.manolov@konsulko.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-imx@nxp.com, robh+dt@kernel.org
Subject: [patch] fix IMX FEC device tree for Variscite SOMs
Message-ID: <YsP/Fc6KHWb6ciR8@p310.k.g>
Mail-Followup-To: linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        robh+dt@kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="6R2DcGwZpkmiWR9J"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6R2DcGwZpkmiWR9J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	Hello,

The attached patch fixes FEC's detection on Variscite Symphony board on 
'master'.  Please review and advice on how to proceed with the final patch.


thanks,
Petko

--6R2DcGwZpkmiWR9J
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="imx8mm-var-som.patch"

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi
index a0bd540f27d3..a853e3c2d0a7 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi
@@ -110,6 +110,9 @@ &fec1 {
 	phy-handle = <&ethphy>;
 	phy-supply = <&reg_eth_phy>;
 	fsl,magic-packet;
+	phy-reset-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
+	phy-reset-duration = <10>;
+	phy-reset-post-delay = <20>;
 	status = "okay";
 
 	mdio {
@@ -119,9 +122,9 @@ mdio {
 		ethphy: ethernet-phy@4 {
 			compatible = "ethernet-phy-ieee802.3-c22";
 			reg = <4>;
-			reset-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
-			reset-assert-us = <10000>;
-			reset-deassert-us = <10000>;
 		};
 	};
 };

--6R2DcGwZpkmiWR9J--
