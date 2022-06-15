Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFA454C7CC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343500AbiFOLvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345234AbiFOLut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:50:49 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D704B87F;
        Wed, 15 Jun 2022 04:50:49 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id v19so15755427edd.4;
        Wed, 15 Jun 2022 04:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6suKy/7DRYloQtzVBGS1osgjJ67TW7jgZjipxxbY9yQ=;
        b=gke4V+Z/RKABnEbZgf/+QUsdUxDyB1a+O2y3AAyzhwRpc3IwxvK/LqOFuaTXfbuhLk
         I93XSx4kMV3F2d4GwupCUgbs9E2TYwdfIjwJUTCJkmA5idIaNomntclg+Q7AZyZ9K+Tk
         wtC7+kZRWkx2LeJ2lVoWjy4dEQ1ujlu/IPZYgdjf9H1IlwvCCboioTwOf2a1fiorEiNq
         QytHSMWCn4H87N213GbGchUfGYbKrFucjgLg3zLY9IZXIV11pHIOWMjugYPDW9xsbkKL
         xaRk1eNC64yU+SHmbcsoxM4Gza2P3BOWFGzfilXhXZ3Mcq/rSNycBrzzHzVDlvPY/2hL
         VcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6suKy/7DRYloQtzVBGS1osgjJ67TW7jgZjipxxbY9yQ=;
        b=e6OC9lQ423pmv05bYYOKwaN7HnbEXYgbP12hy/aGknGfEA3+1dO++/g1BXiEaxxdIr
         4zQ8QQM2SPwdzxYSc0YHcX4KbPHm3Q0OgAJyQNVnV/VllDkdWPOpPx90mfKwP83LM5+U
         ZxUkm/+8p37SJ4OpatIBm9pyQyp5mGSQYMStxD6u2s3YDZNldtvCRpth+sYBkN3wk38Y
         RtLDxmB5KsdYijJSIj00UVFcqLnXOUTZTAh0OUhqlIFfEdElaN2/47KBEFtjxxd9aMEn
         swyDT+lF0Ox03PcJ2TDq4ktGe3GztdsVoVOhnl1Kq19X9N1iJMtUrJz9jhNvQ6sYaik+
         t1sQ==
X-Gm-Message-State: AJIora9JpEboxaM5FmiKiPecAIrTgoiIAxOw+yOJ39KW3ICol2B9Qzur
        gnYmj6PWHE7S/yjHcyvrdVk=
X-Google-Smtp-Source: AGRyM1tWZHi3+4csr+oJAFLiB79X8fyIX4WI46M+4gppDpcrY2ffamQSIlWSeLxNkanslCpNyHqwjA==
X-Received: by 2002:a05:6402:380a:b0:435:2019:52ab with SMTP id es10-20020a056402380a00b00435201952abmr3191545edb.44.1655293848675;
        Wed, 15 Jun 2022 04:50:48 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id t6-20020a17090616c600b00715a02874acsm4561158ejd.35.2022.06.15.04.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 04:50:48 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/18] ARM: dts: imx6q-apalis: Command pmic to standby for poweroff
Date:   Wed, 15 Jun 2022 13:49:52 +0200
Message-Id: <20220615115006.45672-5-max.oss.09@gmail.com>
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

From: Max Krummenacher <max.krummenacher@toradex.com>

The Apalis iMX6 HW doesn't allow to use the PWR_ON_REQ signal for
poweroff. Use the fsl,pmic-stby-poweroff property to command the PMIC
into a low power mode in poweroff.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

(no changes since v1)

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

