Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B0E5283AE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbiEPL7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 07:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243300AbiEPL7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 07:59:31 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF7A15FC2;
        Mon, 16 May 2022 04:59:25 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id z2so28179109ejj.3;
        Mon, 16 May 2022 04:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gThDHWbqFCP9qbssdWR/8tkQmg9lvSi8P3DDStpWpd0=;
        b=TEt+cednHQf4XGucaHpUbUP6tpT44YDZvznSBa2Or8dRdQ+cKl4YLuIlXmnmCSJiNK
         ypcnB40JSfXoioah4RU3H2Mzdi0z2Fr50pshMwmSdFL/OgXiyM4BN1GXfQb82eJg5VRN
         6Tpe/AmWatHltSCB4iaQjLSqGvuwTnfYnPysTYQS0oTIEx6fv/xhU9siTFInUXSBMbSn
         aNXROk9MAESZvRzgaMcwZfuLFBUEym/gU5DZX/EVRhLgKDbX4V+Piisrx14VaRzhZYFM
         5saA2ujhsb8GHsfl8HarkZHO8aLR0Q02FHE9r/opPzJ9J4ShlFN7eiNmS+pqR2aIsNAO
         oZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gThDHWbqFCP9qbssdWR/8tkQmg9lvSi8P3DDStpWpd0=;
        b=4Ho7N4+jvCM/II7wvJOHtJzoj9wkAOugJ1XU+urrUse9/SfapO08EsRh3Ke5NKXhBD
         gcy2yfRE6QtIY5EWhDA69iWL3BlFuin5VkoLj0Mjq3pkaGjblum8BGl8Psz7kznAEzMP
         cKjOB3p9bkKl+IGBcaWdgatA9ZbjM+3CY6HgTTDQdBhBpc/DXBe+5tV5BTHycuif2ABA
         41jtFdjtC0U+CY3UexnPLZadoXIJd2QOwaiM4H3mrefoGJ9IwpD5pj+VMMxXaacQMHWK
         YfHsU6EwehcFeQYtXfp5B8t9SfvlPYwleTNAVAJzHab5s91jdCPqKHj3i2zFJkRnmB28
         /IQw==
X-Gm-Message-State: AOAM530iwnJqnLWx4uPkk9VGaUgNQezmQs6JlffrlvZsav4QPAqYvDOz
        8r3gbQa0T3YeSa7Pd2XV7CM=
X-Google-Smtp-Source: ABdhPJzBfuv2XyXGJugCPvYCLipwLx8XOgyffkIKDcO9mO6hrNSqRypVFjxhgkTh1s6TdZgYxEJlxg==
X-Received: by 2002:a17:907:a429:b0:6fd:da12:eec4 with SMTP id sg41-20020a170907a42900b006fdda12eec4mr14255039ejc.707.1652702364111;
        Mon, 16 May 2022 04:59:24 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id s18-20020a170906779200b006f3ef214dacsm3711008ejm.18.2022.05.16.04.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 04:59:23 -0700 (PDT)
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
Subject: [PATCH v1 04/17] ARM: dts: imx6q-apalis: Command pmic to standby for poweroff
Date:   Mon, 16 May 2022 13:58:32 +0200
Message-Id: <20220516115846.58328-5-max.oss.09@gmail.com>
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

The Apalis iMX6 HW doesn't allow to use the PWR_ON_REQ signal for
poweroff. Use the fsl,pmic-stby-poweroff property to command the PMIC
into a low power mode in poweroff.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

 arch/arm/boot/dts/imx6qdl-apalis.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index e56451651a6d..668793356b46 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -125,6 +125,10 @@
 	status = "disabled";
 };
 
+&clks {
+	fsl,pmic-stby-poweroff;
+};
+
 /* Apalis SPI1 */
 &ecspi1 {
 	cs-gpios = <&gpio5 25 GPIO_ACTIVE_LOW>;
@@ -387,6 +391,7 @@
 
 	pmic: pfuze100@8 {
 		compatible = "fsl,pfuze100";
+		fsl,pmic-stby-poweroff;
 		reg = <0x08>;
 
 		regulators {
-- 
2.20.1

