Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0974D892B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243047AbiCNQbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243055AbiCNQbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:31:40 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1D712ACE;
        Mon, 14 Mar 2022 09:30:23 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j26so24922916wrb.1;
        Mon, 14 Mar 2022 09:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q6mwrSZ3sKKJkfTkUxwWv397hDHEAar1in3QIeHPxyE=;
        b=qkkXmTRgi7hsytH3PlMi1UnafR81qBMQQA+IGS+NFKOZV3lNrJ3G1XB+2nUbDCujQk
         Oy3jc3h6i9qud5dzPi3hCfqPkrITgND6+dN3WMevl4/apO1mYfyQC3nlfzfgzWIh2LSk
         uD0O7OeBZ2l4UZctH0xV3vSvq+btH4y+gXwBlYtwfNLNkPwy9fZEjJ2/95pNynKJLwcj
         UsDbX8mK9hXEVk2jNlbWnmld7JT2wBjpFxer0uFHRA6jj3M6tZhP23kX/kqthESk6Un8
         jv1Z63rIL2W9tMHOy2GdtbCFKYat9MV/AisA27SbK1SwcDikNr2JXZ2MxXABYHqQz6HF
         UzkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q6mwrSZ3sKKJkfTkUxwWv397hDHEAar1in3QIeHPxyE=;
        b=cwoHK38oHzKX9j8oMST8mlx9VYeqyF4/ztPq+IFLa/FpXMp2jXrZdnqNuxnTtjO1lE
         gY3J1cCf9D1dgdKl4ElOFljEsBZIqqsU9LIr6yiYWlVxPLvrm8eyaTiXwW9OzhvPB9Mn
         by9zKzq+oYrGIzf2rsIIkz0pqR7EaKSMs2ANfe2d4pwTC0kfq64V67Zaiz8GCSLhcom2
         nW3KLwo51Jm/5PWXIjox6OiNI2PzudfN+vQD4aoYrx12KGyM5LtwgT+N39CHx2c0VCoo
         SiFjwhy18NIcAx7p1gtLJrygexuVmcIFiawUNSiSLtyUCywL84tSFwBAlaRoFPVsf3dQ
         7AuA==
X-Gm-Message-State: AOAM532UehFhLvCXRVKMMa3bYHa3VplVsBROTXVNxmVtHImYjl3SBMgQ
        Bj+WxDxt608F3JRWeojF4U0=
X-Google-Smtp-Source: ABdhPJx3E3lbDaxL2T5+GPEswJGtMU7Vp9nlST6a84vlY158GegDVSFH/0lVvTpc7025Z24uTTSigA==
X-Received: by 2002:a05:6000:2c6:b0:203:871d:aaa4 with SMTP id o6-20020a05600002c600b00203871daaa4mr16231458wry.47.1647275421636;
        Mon, 14 Mar 2022 09:30:21 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-124.static.upc.ch. [31.10.206.124])
        by smtp.gmail.com with ESMTPSA id w10-20020a5d680a000000b001f1dabec837sm13476817wru.113.2022.03.14.09.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 09:30:21 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
X-Google-Original-From: Max Krummenacher <max.krummenacher@toradex.com>
To:     max.krummenacher@toradex.com
Cc:     Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 07/14] ARM: dts: imx6dl-colibri: Command pmic to standby for poweroff
Date:   Mon, 14 Mar 2022 17:29:51 +0100
Message-Id: <20220314162958.40361-8-max.krummenacher@toradex.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220314162958.40361-1-max.krummenacher@toradex.com>
References: <20220314162958.40361-1-max.krummenacher@toradex.com>
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

The Colibri iMX6 HW doesn't allow to use the PWR_ON_REQ signal for
poweroff. Use the fsl,pmic-stby-poweroff property to command the PMIC
into a low power mode in poweroff.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

 arch/arm/boot/dts/imx6qdl-colibri.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index f6243762e918..da52a71bb6e7 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -138,6 +138,10 @@
 	status = "disabled";
 };
 
+&clks {
+	fsl,pmic-stby-poweroff;
+};
+
 /* Colibri SSP */
 &ecspi4 {
 	cs-gpios = <&gpio5 2 GPIO_ACTIVE_LOW>;
@@ -403,6 +407,7 @@
 
 	pmic: pfuze100@8 {
 		compatible = "fsl,pfuze100";
+		fsl,pmic-stby-poweroff;
 		reg = <0x08>;
 
 		regulators {
-- 
2.20.1

