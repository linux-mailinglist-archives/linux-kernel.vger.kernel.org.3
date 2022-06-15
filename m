Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A0454C7D5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346439AbiFOLuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344937AbiFOLus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 07:50:48 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28FE4BFDE;
        Wed, 15 Jun 2022 04:50:47 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id v19so15755427edd.4;
        Wed, 15 Jun 2022 04:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0gSK28S9ceVWUz1iTMdpdovJKFOpKauEhwDZwMPNaq0=;
        b=mc6yf626eu1cSbVnBZIijiEYVcysbhuTVxaZwQAhn9/PlGqp8O+wC0yd90icvQgSr7
         yLoVasclAJN7p9a709yXq/PrAXEmyhpisJAJgL1DZv2laPVR3rAVfjCL0YNd2oej6e98
         tiA0wfzJY2pn1wiVHX6L/I2Wq7eKh7QWeLP1vktKxCikhW/YDQvl8/X7l6isqPN6baSr
         6oryz9DQMBkYG9FzUQxVsOs3l9V5dMLK9frm4I0fhuoxfO+K0z6WSwBT/0YXzoyDBnfW
         7+Ivi6HZaIZpwSClcDKxXkkQkXU7BeDF36nGaCdJIWUpgcDoiRljcIZiGgMYgrfut+xA
         gDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0gSK28S9ceVWUz1iTMdpdovJKFOpKauEhwDZwMPNaq0=;
        b=INx7Sf7QWSx03ge+UbpyK8HLghtSt9YgpZclm1aTIG+rvWJyhdCZWO/tsVeycySnqQ
         2aiqH3NiCr1ga7sOQ+pPyhe7z18uwzY7p3+ERKoP/0RbS4k6jJvL49NPDbAGxxNFIuAo
         YyGBH0ZZwIrmDVgMLp/cWK2qkGvz4aXsHqmvMHOXJUp7p5dZcLL7/VUqv0xcUNYbQo71
         wiJPMvS3tuJqGSxctubXLqIfiFgaw8CB14xrstyzXA2Mykru8nwoOznqMFtyesgkGhI2
         l6oauHxFN21kzfPhkxKVmhoYhn+sFIG0TqAvLnS1W7p62+8Op1IYB6yqPwGpx+VDV3+s
         whaA==
X-Gm-Message-State: AOAM531j6t33L+VK+6J7bzr4AiprXPTghtSTiPGTEvmKTBD3JLYvHivm
        6EMaj11S8ok6NxyePDfOpMc=
X-Google-Smtp-Source: AGRyM1tfWnczt3nKFVgd48r566OO1mcDxasbAggeDrC0QV6PFRwbkYAuEAppqgEf5CQB7ETe8KWJKg==
X-Received: by 2002:a05:6402:428a:b0:42e:8f7e:1638 with SMTP id g10-20020a056402428a00b0042e8f7e1638mr11948815edc.228.1655293846435;
        Wed, 15 Jun 2022 04:50:46 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id t6-20020a17090616c600b00715a02874acsm4561158ejd.35.2022.06.15.04.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 04:50:45 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/18] Revert "ARM: dts: imx6qdl-apalis: Avoid underscore in node name"
Date:   Wed, 15 Jun 2022 13:49:50 +0200
Message-Id: <20220615115006.45672-3-max.oss.09@gmail.com>
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

The STMPE MFD device binding requires the child node to have a fixed
name, i.e. with '_', not '-'. Otherwise the stmpe_adc, stmpe_touchscreen
drivers will not be probed.

Fixes: 56086b5e804f ("ARM: dts: imx6qdl-apalis: Avoid underscore in node name")
Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

---

Changes in v2:
- add Ahmad's reviewed-by tag

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

